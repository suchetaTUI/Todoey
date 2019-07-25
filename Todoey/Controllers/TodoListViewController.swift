//
//  ViewController.swift
//  Todoey
//
//  Created by Sucheta Maindarkar on 24/07/2019.
//  Copyright © 2019 Sucheta Maindarkar. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
   // var itemArray = ["Find Milk", "Buy Eggs", "Destroy Demorgon"]
    var defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var item1 = Item()
        item1.title = "Find Mike"
        itemArray.append(item1)
        
        var item2 = Item()
        item2.title = "Buy Eggs"
        itemArray.append(item2)
        
        var item3 = Item()
        item3.title = "Destroy Demorgon"
        itemArray.append(item3)
        
        // Do any additional setup after loading the view, typically from a nib.
        if let arrayItems = defaults.array(forKey: "TodoListArray") as?  [Item] {
            itemArray =  arrayItems
        }
    }
    
    
    //MARK: Table View DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //MARK: Table View Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Items
    
    @IBAction func addButtonChanged(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message:"", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let  newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        alert.addAction( action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print( alertTextField.text! )
        }
        
        present(alert, animated: true, completion:  nil )
        
    }
}

