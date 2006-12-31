From: bfields@fieldses.org
Subject: [PATCH] Documentation: update tutorial's discussion of origin
Date: Sun, 31 Dec 2006 18:47:38 -0500
Message-ID: <11676088581777-git-send-email-bfields@fieldses.org>
References: <11676088584199-git-send-email-bfields@fieldses.org> <1167608858759-git-send-email-bfields@fieldses.org> <11676088582634-git-send-email-bfields@fieldses.org> <11676088581948-git-send-email-bfields@fieldses.org> <1167608858532-git-send-email-bfields@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 00:47:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1APB-0007zX-Vo
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 00:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbWLaXrp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 18:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbWLaXro
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 18:47:44 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38260 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbWLaXrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 18:47:39 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1AOw-0002F4-MZ; Sun, 31 Dec 2006 18:47:38 -0500
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.gac28
In-Reply-To: <1167608858532-git-send-email-bfields@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35715>

From: J. Bruce Fields <bfields@citi.umich.edu>

Update tutorial's discussion of origin branch to reflect new defaults,
and include a brief mention of git-repo-config.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/tutorial.txt |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index cb808d9..d043e84 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -323,20 +323,25 @@ $ git pull
 
 Note that he doesn't need to give the path to Alice's repository;
 when Bob cloned Alice's repository, git stored the location of her
-repository in the file .git/remotes/origin, and that location is used
-as the default for pulls.
-
-Bob may also notice a branch in his repository that he didn't create:
+repository in the repository configuration, and that location is
+used for pulls:
 
 -------------------------------------
-$ git branch
-* master
-  origin
+$ git repo-config --get remote.origin.url
+/home/bob/myrepo
 -------------------------------------
 
-The "origin" branch, which was created automatically by "git clone",
-is a pristine copy of Alice's master branch; Bob should never commit
-to it.
+(The complete configuration created by git-clone is visible using
+"git repo-config -l", and the gitlink:git-repo-config[1] man page
+explains the meaning of each option.)
+
+Git also keeps a pristine copy of Alice's master branch under the
+name "origin/master":
+
+-------------------------------------
+$ git branch -r
+  origin/master
+-------------------------------------
 
 If Bob later decides to work from a different host, he can still
 perform clones and pulls using the ssh protocol:
-- 
1.5.0.rc0.gac28
