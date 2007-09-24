From: Jonathan del Strother <maillist@steelskies.com>
Subject: My stash wants to delete all my files
Date: Mon, 24 Sep 2007 14:12:15 +0100
Message-ID: <5A9D6E3B-7B0E-4414-9AFB-C1C8B2EE6A9D@steelskies.com>
Mime-Version: 1.0 (Apple Message framework v901)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 15:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZnkd-0001AW-TW
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 15:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbXIXNNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbXIXNNF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 09:13:05 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:49372 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbXIXNNE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 09:13:04 -0400
Received: from host217-35-101-26.in-addr.btopenworld.com ([217.35.101.26]:49991 helo=[192.168.1.2])
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IZnk5-0001eP-1Q
	for git@vger.kernel.org; Mon, 24 Sep 2007 09:12:53 -0400
X-Mailer: Apple Mail (2.901)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59045>

Heya,
I've run into a problem with git stash.  I suspect that I've already  
lost the work that I tried to stash, but would like to know where I  
went wrong.

I had some work in progress, wanted to check something from my last  
commit, and typed "git stash".  I forgot to "git stash apply"  
immediately afterward, and carried on doing some more work related to  
the stashed code.  I realized that I'd got a stash that I wanted to  
apply, and tried to restore it.
While trying to restore it, I typed "git stash --apply", which  
actually created a new stash named "--apply".  Ooops.  Anyway, the  
real problem is :

$ git stash list
stash@{0}: On master: --apply
stash@{1}: WIP on master: 09e3c30... Better handling of cell sizes in  
the grid

$ git stash show stash@{1}
  .gitignore                            |    3 -
  AppController.h                       |   10 -
  AppController.m                       |   30 -
  English.lproj/InfoPlist.strings       |  Bin 202 -> 0 bytes
  English.lproj/MainMenu.xib            | 2560  
---------------------------------
  GLScene.h                             |   21 -
  GLScene.m                             |  287 ----
  Info.plist                            |   28 -
  LayoutManager.h                       |   19 -
  LayoutManager.m                       |  118 --
  OpenGLTests.xcodeproj/project.pbxproj |  323 -----
  OpenGLTests_Prefix.pch                |   10 -
  TheWall.h                             |   28 -
  TheWall.m                             |   99 --
  UserImage.h                           |   17 -
  UserImage.m                           |  111 --
  Utilities.h                           |   38 -
  Utilities.m                           |   89 --
  main.m                                |   14 -
  19 files changed, 0 insertions(+), 3805 deletions(-)


Hmm.  Looks like it's trying to delete all of my versioned files.   
"git stash apply stash@{1}" confirms this.   Obviously that's not what  
I tried to stash - my WIP when I stashed was a few additions, a couple  
of new unversioned files, and moving a few lines of code from one file  
to another.

Any ideas what happened there?  I can't seem to reproduce the problem  
in a test repository.

Cheers,
Jon
