From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] Documentation/git-branch: new -r to delete remote-tracking
 branches.
Date: Thu, 21 Dec 2006 15:18:07 +1100
Message-ID: <458A0AFF.5030208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 05:18:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxFNz-0002Dd-O8
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 05:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWLUESY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 23:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWLUESY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 23:18:24 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:51262 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422687AbWLUESX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 23:18:23 -0500
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1GxFNg-000529-Oq
	for git@vger.kernel.org; Thu, 21 Dec 2006 15:18:20 +1100
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35013>



Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---

	For the version of git-branch currently in "next".

 Documentation/git-branch.txt |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 71417fe..c464bd2 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git-branch' [-r | -a] [-v [--abbrev=<length>]]
 'git-branch' [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
-'git-branch' (-d | -D) <branchname>...
+'git-branch' (-d | -D) [-r] <branchname>...
 
 DESCRIPTION
 -----------
@@ -33,7 +33,8 @@ to happen.
 
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
-has a ref log then the ref log will also be deleted.
+has a ref log then the ref log will also be deleted. Use -r together with -d
+to delete remote-tracking branches.
 
 
 OPTIONS
@@ -60,7 +61,7 @@ OPTIONS
 	Move/rename a branch even if the new branchname already exists.
 
 -r::
-	List the remote-tracking branches.
+	List or delete (if used with -d) the remote-tracking branches.
 
 -a::
 	List both remote-tracking branches and local branches.
@@ -111,10 +112,12 @@ Delete unneeded branch::
 ------------
 $ git clone git://git.kernel.org/.../git.git my.git
 $ cd my.git
-$ git branch -D todo    <1>
+$ git branch -d -r todo html man   <1>
+$ git branch -D test               <2>
 ------------
 +
-<1> delete todo branch even if the "master" branch does not have all
+<1> delete remote-tracking branches "todo", "html", "man"
+<2> delete "test" branch even if the "master" branch does not have all
 commits from todo branch.
 
 
-- 
1.4.4.1.GIT
