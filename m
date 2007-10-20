From: Erich Ocean <erich@atlasocean.com>
Subject: How can I access remote branches in a cloned repository on my local machine?
Date: Sat, 20 Oct 2007 06:15:21 -0700
Message-ID: <05B1B470-1C86-40E6-9E33-968809414537@atlasocean.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 15:39:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjEYA-0002OL-5Y
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 15:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbXJTNjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 09:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbXJTNjW
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 09:39:22 -0400
Received: from georgia.textdrive.com ([207.7.107.246]:53768 "EHLO
	georgia.textdrive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbXJTNjV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 09:39:21 -0400
X-Greylist: delayed 1437 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2007 09:39:21 EDT
Received: from [192.168.2.4] (cpe-76-168-244-235.socal.res.rr.com [76.168.244.235])
	by georgia.textdrive.com (Postfix) with ESMTP id 1AAEE350F3
	for <git@vger.kernel.org>; Sat, 20 Oct 2007 13:15:23 +0000 (GMT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61833>

Our developer group has a shared git repository at git@git. 
1kstudios.lan:dev.

Each developer has established their own local repository by running:

	git clone git@git.1kstudios.lan:dev
	git config remote.origin.push master:refs/remotes/<username>/master

Each developer then does a `git pull` to update their master branch,  
merges their changes from their local topic branches, and then does  
`git push` to make the results available at git@git.1kstudios.lan:dev.

As the integrator, I have then been ssh'ing into the git@git. 
1kstudios.lan machine, cd'ing to "dev" and doing:

	git merge <username>/master

to incorporate their changes after running `git diff` to see what the  
changes are.

My own development repository is set up identically to the other  
developers.

What I would like to do now is clone the git@git.1kstudios.lan:dev  
repository on my local machine a second time, checkout a <username>/ 
master branch in that repository, and then use BBEdit's graphical  
diff to visually see the changes between my own repository and what  
another developer has pushed to the shared repository. I'll then  
merge them into my own developer repository and push that to the  
shared repository for the rest of the developers to pull from, so no  
longer will I merge by ssh'ing into the machine with the shared  
repository.

The problem is, when I clone git@git.1kstudios.lan:dev, the various  
<username>/master's aren't there. I have tried a bunch of different  
ways, but they all give me errors. For example:

 > logan-2:~ ocean$ git clone git@git.1kstudios.lan:dev commiters
 > Initialized empty Git repository in /Users/ocean/commiters/.git/
 > git@git.1kstudios.lan's password:
 > remote: Generating pack...
 > remote: Done counting 7029 objects.
 > remote: Deltifying 7029 objects...
 > remote:  100% (7029/7029) done
 > Indexing 7029 objects...
 > remote: Total 7029 (delta 3334), reused 2456 (delta 1154)
 >  100% (7029/7029) done
 > Resolving 3334 deltas...
 >  100% (3334/3334) done
 > Checking 3864 files out...
 >  100% (3864/3864) done
 > logan-2:~ ocean$ cd commiters
 > logan-2:~/commiters ocean$ git branch
 > * masterlogan-2:~/commiters ocean$ git checkout -b jchumley/master  
jchumley
 > git checkout: updating paths is incompatible with switching  
branches/forcing

How can I access remote branches in a cloned repository on my local  
machine?

Thanks!

Erich
