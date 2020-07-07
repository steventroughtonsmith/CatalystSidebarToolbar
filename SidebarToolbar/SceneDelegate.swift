//
//  SceneDelegate.swift
//  SidebarToolbar
//
//  Created by Steven Troughton-Smith on 07/07/2020.
//

import UIKit

#if !targetEnvironment(macCatalyst)
@objc protocol NSToolbarDelegate {
}
#endif

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UITableViewDataSource, NSToolbarDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        
        let svc = UISplitViewController()
        svc.primaryBackgroundStyle = .sidebar
        
        let whiteVC = UIViewController()
        whiteVC.view.backgroundColor = .white
        
        let tableVC = UITableViewController(style: .grouped)
        tableVC.tableView.dataSource = self
        tableVC.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        svc.viewControllers = [tableVC, whiteVC]
        
        window?.rootViewController = svc
        window?.makeKeyAndVisible()
        
        #if targetEnvironment(macCatalyst)
        setupNSToolbar()
        #endif
    }
    
    #if targetEnvironment(macCatalyst)
    func setupNSToolbar()
    {
        let toolbar = NSToolbar()
        toolbar.delegate = self
        window?.windowScene?.titlebar?.toolbar = toolbar
        window?.windowScene?.titlebar?.titleVisibility = .hidden
    }
    #endif
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = "Item"
        cell.imageView?.image = UIImage(systemName: "folder")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section"
    }
    
    #if targetEnvironment(macCatalyst)
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [NSToolbarItem.Identifier("navigationButton"), .flexibleSpace, NSToolbarItem.Identifier("otherButton")]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [NSToolbarItem.Identifier("navigationButton"), .flexibleSpace, NSToolbarItem.Identifier("otherButton")]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        switch itemIdentifier {
        case NSToolbarItem.Identifier("navigationButton"):
            let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(nop(_:)))
            return NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: barButtonItem)
        case NSToolbarItem.Identifier("otherButton"):
            let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(nop(_:)))
            return NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: barButtonItem)
        default:
            break
        }
        
        return NSToolbarItem(itemIdentifier: itemIdentifier)
    }
    
    @objc func nop(_ sender : NSObject)
    {
        
    }
    
    #endif
}

