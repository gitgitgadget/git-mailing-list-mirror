From: dherring@ll.mit.edu
Subject: git-svn: how to connect SVN branches?
Date: Thu, 17 Jan 2008 15:17:32 -0500 (EST)
Message-ID: <alpine.LNX.0.999999.0801171237110.3479@mojave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 21:51:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFbht-0005a2-Sn
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 21:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbYAQUuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 15:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbYAQUuz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 15:50:55 -0500
Received: from LLMAIL1.LL.MIT.EDU ([129.55.12.41]:40337 "EHLO ll.mit.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752781AbYAQUuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 15:50:54 -0500
X-Greylist: delayed 1977 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2008 15:50:54 EST
Received: (from smtp@localhost)
	by ll.mit.edu (8.12.10/8.8.8) id m0HKHtZp018657
	for <git@vger.kernel.org>; Thu, 17 Jan 2008 15:17:55 -0500 (EST)
Received: from mojave.llan.ll.mit.edu(              ), claiming to be "mojave"
 via SMTP by llpost, id smtpdAAA6zaW3J; Thu Jan 17 15:17:32 2008
X-X-Sender: dherring@mojave
User-Agent: Alpine 0.999999 (LNX 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70922>

Hi,

The project I'm tracking changed servers a couple months ago.  To simulate 
the svn-switch, I edited the svn-remote.url to the new location.  `git-svn 
fetch`, `git-svn dcommit`, and the like seemed to work ok.

When a new release branch came out, I tried adding
svn-remote.branches = releases/*:refs/remotes/svn/*

`git-svn fetch` pulled the new branch.  However, it created a whole new 
history for this branch (new git commits from the beginning of the SVN 
repo).

Is there some way to tell git/git-svn to connect these two histories?

Pictorially, I have

SVN1@a---SVN2@a---SVN3@b---SVN4@b---SVNtrunk
SVN1@b---SVN2@b---SVN3@b---SVN4@b---SVNbranch

and want

SVN1@a---SVN2@a---SVN3@b---SVN4@b---SVNtrunk
                                  \--SVNbranch

Similarly, if someone cloned a git repo full of git-svn-id's (which 
indicate that an svn --switch occurred) but without any matching git-svn 
data, is there a way to `git-svn fetch` from the new SVN repo and 
autoconnect the git commits?

Thanks,
Daniel
