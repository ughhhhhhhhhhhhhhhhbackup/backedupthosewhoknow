local Stored = {}
local function goThrough(v)
    Stored[v.Name] = {}
    for index,value in pairs(v.Backpack:GetChildren()) do
        if string.match(value.Name:lower(),'mantra') and not string.match(value.Name:lower(),'recalled') then
            if game.Players.LocalPlayer.Backpack:FindFirstChild(value.Name) then continue; end;
            value.Parent=game.Players.LocalPlayer.Backpack
            table.insert(Stored[v.Name],value);
        end
    end
end
for i,v in pairs(game.Players:GetPlayers()) do
    if v == game.Players.LocalPlayer then continue end
    goThrough(v)
end
game.Players.PlayerAdded:Connect(function(p)
    Stored[p.Name]={}
    repeat task.wait() until (p:FindFirstChild('Backpack') and (#p.Backpack:GetChildren()>5))
    for index,value in pairs(p.Backpack:GetChildren()) do
        if string.match(value.Name:lower(),'mantra') and not string.match(value.Name:lower(),'recalled') then
            value.Parent=game.Players.LocalPlayer.Backpack
            table.insert(Stored[v.Name],value);
        end
    end
    p.Backpack.ChildAdded:Connect(function(c)
        if string.match(c.Name:lower(), 'mantra') and not string.match(c.Name:lower(),'recalled') then
            task.wait();
            c.Parent = game.Players.LocalPlayer.Backpack;
            table.insert(Stored[p.Name],c)
        end
    end)
end)

game.Players.PlayerRemoving:Connect(function(p)
    if Stored[p.Name] then 
        for i,v in pairs(Stored[p.Name]) do
            v:Destroy()
        end
        Stored[p.Name]={}
    end
end)
