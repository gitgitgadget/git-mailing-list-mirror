From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: push-pull commands into a separate category.
Date: Thu, 14 Jul 2005 00:10:48 -0700
Message-ID: <7vu0ixj213.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 09:11:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsxs5-0004LC-Eu
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 09:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVGNHKw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 03:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVGNHKw
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 03:10:52 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:13288 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262937AbVGNHKt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 03:10:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714071048.KEKE12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Jul 2005 03:10:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This splits push-pull related commands into a separate
category.  I think a bigger overhaul of the main index is
needed, but have not got around to it.  Help is welcome.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git.txt |   65 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 42 insertions(+), 23 deletions(-)

9ea24aa8739dc23074872679d493dfd6fb0e5321
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -30,8 +30,9 @@ reflect recent changes.
 Commands Overview
 -----------------
 The git commands can helpfully be split into those that manipulate
-the repository, the cache and the working fileset and those that
-interrogate and compare them.
+the repository, the cache and the working fileset, those that
+interrogate and compare them, and those that moves objects and
+references between repositories.
 
 There are also some ancilliary programs that can be viewed as useful
 aids for using the core commands but which are unlikely to be used by
@@ -117,16 +118,6 @@ The interrogate commands may create file
 touch the working file set - but in general they don't
 
 
-Ancilliary Commands
--------------------
-Manipulators:
-
-link:git-apply-patch-script.html[git-apply-patch-script]::
-	Sample script to apply the diffs from git-diff-*
-
-link:git-convert-cache.html[git-convert-cache]::
-	Converts old-style GIT repository
-
 link:git-clone-script.html[git-clone-script]::
 	Clones a repository into the current repository (user interface)
 
@@ -134,18 +125,49 @@ link:git-clone-pack.html[git-clone-pack]
 	Clones a repository into the current repository (engine
 	for ssh and local transport)
 
+link:git-pull-script.html[git-pull-script]::
+	Pull from a repote repository via various protocols
+	(user interface).
+
 link:git-http-pull.html[git-http-pull]::
 	Downloads a remote GIT repository via HTTP
 
 link:git-local-pull.html[git-local-pull]::
 	Duplicates another GIT repository on a local system
 
+link:git-ssh-pull.html[git-ssh-pull]::
+	Pulls from a remote repository over ssh connection
+
+link:git-send-pack.html[git-send-pack]::
+	Pushes to a remote repository, intelligently.
+
+link:git-receive-pack.html[git-receive-pack]::
+	Invoked by 'git-send-pack' to receive what is pushed to it.
+
+link:git-clone-pack.html[git-clone-pack]::
+	Clones from a remote repository.
+
+link:git-fetch-pack.html[git-fetch-pack]::
+	Updates from a remote repository.
+
+link:git-upload-pack.html[git-upload-pack]::
+	Invoked by 'git-clone-pack' and 'git-fetch-pack' to push
+	what are asked for.
+
+
+Ancilliary Commands
+-------------------
+Manipulators:
+
+link:git-apply-patch-script.html[git-apply-patch-script]::
+	Sample script to apply the diffs from git-diff-*
+
+link:git-convert-cache.html[git-convert-cache]::
+	Converts old-style GIT repository
+
 link:git-merge-one-file-script.html[git-merge-one-file-script]::
 	The standard helper program to use with "git-merge-cache"
 
-link:git-pull-script.html[git-pull-script]::
-	Script used by Linus to pull and merge a remote repository
-
 link:git-prune-script.html[git-prune-script]::
 	Prunes all unreachable objects from the object database
 
@@ -155,8 +177,6 @@ link:git-resolve-script.html[git-resolve
 link:git-tag-script.html[git-tag-script]::
 	An example script to create a tag object signed with GPG
 
-link:git-ssh-pull.html[git-ssh-pull]::
-	Pulls from a remote repository over ssh connection
 
 Interogators:
 
@@ -221,17 +241,16 @@ The git-core manipulates the following a
 
  .git/	       The base (overridden with $GIT_DIR)
    objects/    The object base (overridden with $GIT_OBJECT_DIRECTORY)
-     ??/       'First 2 chars of object' directories
-
-It can interrogate (but never updates) the following areas:
+     ??/       'First 2 chars of object' directories.
+     pack/     Packed archives.
 
    refs/       Directories containing symbolic names for objects
 	       (each file contains the hex SHA1 + newline)
      heads/    Commits which are heads of various sorts
      tags/     Tags, by the tag name (or some local renaming of it)
-     snap/     ????
-   ...         Everything else isn't shared
-   HEAD        Symlink to refs/heads/<something>
+     */        Any other subdirectory of refs/ can be used to store
+	       files similar to what are under refs/heads/.
+   HEAD        Symlink to refs/heads/<current-branch-name>
 
 Higher level SCMs may provide and manage additional information in the
 GIT_DIR.
