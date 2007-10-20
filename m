From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: How can I access remote branches in a cloned repository on my
 local machine?
Date: Sat, 20 Oct 2007 14:53:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710201449340.8248@beast.quantumfyre.co.uk>
References: <05B1B470-1C86-40E6-9E33-968809414537@atlasocean.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Erich Ocean <erich@atlasocean.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 15:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjEm7-00084z-UE
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 15:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbXJTNxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 09:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754360AbXJTNxs
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 09:53:48 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:37722 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754701AbXJTNxr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 09:53:47 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6D9686C5AD
	for <git@vger.kernel.org>; Sat, 20 Oct 2007 14:53:46 +0100 (BST)
Received: (qmail 25160 invoked by uid 103); 20 Oct 2007 14:53:46 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91.2/4545. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.03067 secs); 20 Oct 2007 13:53:46 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Oct 2007 14:53:45 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <05B1B470-1C86-40E6-9E33-968809414537@atlasocean.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61835>

On Sat, 20 Oct 2007, Erich Ocean wrote:

> Our developer group has a shared git repository at git@git.1kstudios.lan:dev.
>
> Each developer has established their own local repository by running:
>
> 	 git clone git@git.1kstudios.lan:dev
> 	 git config remote.origin.push master:refs/remotes/<username>/master
>
> Each developer then does a `git pull` to update their master branch, merges 
> their changes from their local topic branches, and then does `git push` to 
> make the results available at git@git.1kstudios.lan:dev.
>
> As the integrator, I have then been ssh'ing into the git@git.1kstudios.lan 
> machine, cd'ing to "dev" and doing:
>
> 	git merge <username>/master
>
> to incorporate their changes after running `git diff` to see what the changes 
> are.
>
> My own development repository is set up identically to the other developers.
>
> What I would like to do now is clone the git@git.1kstudios.lan:dev repository 
> on my local machine a second time, checkout a <username>/master branch in 
> that repository, and then use BBEdit's graphical diff to visually see the 
> changes between my own repository and what another developer has pushed to 
> the shared repository. I'll then merge them into my own developer repository 
> and push that to the shared repository for the rest of the developers to pull 
> from, so no longer will I merge by ssh'ing into the machine with the shared 
> repository.
>
> The problem is, when I clone git@git.1kstudios.lan:dev, the various 
> <username>/master's aren't there. I have tried a bunch of different ways, but 
> they all give me errors. For example:

The default fetch refspec doesn't include the remotes - after all, you 
normally don't want the origin for your origin ...

> How can I access remote branches in a cloned repository on my local machine?

Try something like:

git config remote.origin.fetch +refs/remotes/*:+refs/remotes/*
git fetch

-- 
Julian

  ---
No matter how cynical you get, it's impossible to keep up.
