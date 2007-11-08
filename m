From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Remove deprecated commands from command list and update manpages
Date: Thu, 8 Nov 2007 15:54:35 +0100
Message-ID: <20071108145435.GA18727@diku.dk>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site> <7vlk998u6r.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711080041120.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq8mX-0008V6-07
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 15:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758615AbXKHOyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 09:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757570AbXKHOyl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 09:54:41 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:42138 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbXKHOyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 09:54:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8A4EA52C370;
	Thu,  8 Nov 2007 15:54:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sewyg3Z4+yNi; Thu,  8 Nov 2007 15:54:36 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id EF7B7770002;
	Thu,  8 Nov 2007 15:54:35 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 40A836E016C; Thu,  8 Nov 2007 15:54:15 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id D1F565B8001; Thu,  8 Nov 2007 15:54:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711080041120.4362@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64032>

... and remove manpages of commands that no longer exists.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/cmd-list.perl       |    5 ---
 Documentation/git-local-fetch.txt |   66 -------------------------------------
 Documentation/git-ssh-fetch.txt   |   52 -----------------------------
 Documentation/git-ssh-upload.txt  |   48 ---------------------------
 Documentation/git-tar-tree.txt    |    2 +-
 Documentation/git-var.txt         |    3 +-
 6 files changed, 3 insertions(+), 173 deletions(-)
 delete mode 100644 Documentation/git-local-fetch.txt
 delete mode 100644 Documentation/git-ssh-fetch.txt
 delete mode 100644 Documentation/git-ssh-upload.txt

 Although this new version updates the git-lost-found(1) the command is
 still listed in git(7) which I find misleading. Anyway, it made me
 investigate the commands we list in git(7) and I found a few that could
 possibly be cleaned up.

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 8d21d42..7f1f5d2 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -124,9 +124,7 @@ git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain
 git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
-git-local-fetch                         synchingrepositories
 git-log                                 mainporcelain
-git-lost-found                          ancillarymanipulators
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
@@ -178,8 +176,6 @@ git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-setup                            purehelpers
-git-ssh-fetch                           synchingrepositories
-git-ssh-upload                          synchingrepositories
 git-stash                               mainporcelain
 git-status                              mainporcelain
 git-stripspace                          purehelpers
@@ -187,7 +183,6 @@ git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain
-git-tar-tree                            plumbinginterrogators
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
deleted file mode 100644
index e830dee..0000000
--- a/Documentation/git-local-fetch.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-git-local-fetch(1)
-==================
-
-NAME
-----
-git-local-fetch - Duplicate another git repository on a local system
-
-
-SYNOPSIS
---------
-[verse]
-'git-local-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [-l] [-s] [-n]
-                  commit-id path
-
-DESCRIPTION
------------
-THIS COMMAND IS DEPRECATED.
-
-Duplicates another git repository on a local system.
-
-OPTIONS
--------
--c::
-	Get the commit objects.
--t::
-	Get trees associated with the commit objects.
--a::
-	Get all the objects.
--v::
-	Report what is downloaded.
--s::
-	Instead of regular file-to-file copying use symbolic links to the objects
-	in the remote repository.
--l::
-	Before attempting symlinks (if -s is specified) or file-to-file copying the
-	remote objects, try to hardlink the remote objects into the local
-	repository.
--n::
-	Never attempt to file-to-file copy remote objects.  Only useful with
-	-s or -l command-line options.
-
--w <filename>::
-        Writes the commit-id into the filename under $GIT_DIR/refs/<filename> on
-        the local end after the transfer is complete.
-
---stdin::
-	Instead of a commit id on the command line (which is not expected in this
-	case), 'git-local-fetch' expects lines on stdin in the format
-
-		<commit-id>['\t'<filename-as-in--w>]
-
---recover::
-	Verify that everything reachable from target is fetched.  Used after
-	an earlier fetch is interrupted.
-
-Author
-------
-Written by Junio C Hamano <junkio@cox.net>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
diff --git a/Documentation/git-ssh-fetch.txt b/Documentation/git-ssh-fetch.txt
deleted file mode 100644
index 8d3e2ff..0000000
--- a/Documentation/git-ssh-fetch.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-git-ssh-fetch(1)
-================
-
-NAME
-----
-git-ssh-fetch - Fetch from a remote repository over ssh connection
-
-
-
-SYNOPSIS
---------
-'git-ssh-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
-
-DESCRIPTION
------------
-THIS COMMAND IS DEPRECATED.
-
-Pulls from a remote repository over ssh connection, invoking
-git-ssh-upload on the other end. It functions identically to
-git-ssh-upload, aside from which end you run it on.
-
-
-OPTIONS
--------
-commit-id::
-        Either the hash or the filename under [URL]/refs/ to
-        pull.
-
--c::
-	Get the commit objects.
--t::
-	Get trees associated with the commit objects.
--a::
-	Get all the objects.
--v::
-	Report what is downloaded.
--w::
-        Writes the commit-id into the filename under $GIT_DIR/refs/ on
-        the local end after the transfer is complete.
-
-
-Author
-------
-Written by Daniel Barkalow <barkalow@iabervon.org>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
diff --git a/Documentation/git-ssh-upload.txt b/Documentation/git-ssh-upload.txt
deleted file mode 100644
index 5e2ca8d..0000000
--- a/Documentation/git-ssh-upload.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-git-ssh-upload(1)
-=================
-
-NAME
-----
-git-ssh-upload - Push to a remote repository over ssh connection
-
-
-SYNOPSIS
---------
-'git-ssh-upload' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
-
-DESCRIPTION
------------
-THIS COMMAND IS DEPRECATED.
-
-Pushes from a remote repository over ssh connection, invoking
-git-ssh-fetch on the other end. It functions identically to
-git-ssh-fetch, aside from which end you run it on.
-
-OPTIONS
--------
-commit-id::
-        Id of commit to push.
-
--c::
-        Get the commit objects.
--t::
-        Get tree associated with the requested commit object.
--a::
-        Get all the objects.
--v::
-        Report what is uploaded.
--w::
-        Writes the commit-id into the filename under [URL]/refs/ on
-        the remote end after the transfer is complete.
-
-Author
-------
-Written by Daniel Barkalow <barkalow@iabervon.org>
-
-Documentation
---------------
-Documentation by Daniel Barkalow
-
-GIT
----
-Part of the gitlink:git[7] suite
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 434607b..4aaf813 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-THIS COMMAND IS DEPRECATED.  Use `git-archive` with `--format=tar`
+THIS COMMAND IS DEPRECATED.  Use gitlink:git-archive[1] with `--format=tar`
 option instead (and move the <base> argument to `--prefix=base/`).
 
 Creates a tar archive containing the tree structure for the named tree.
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 8139423..73c37b0 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -20,7 +20,8 @@ OPTIONS
 	Cause the logical variables to be listed. In addition, all the
 	variables of the git configuration file .git/config are listed
 	as well. (However, the configuration variables listing functionality
-	is deprecated in favor of `git-config -l`.)
+	is deprecated. Use gitlink:git-config[1] with the option '-l'
+	instead.)
 
 EXAMPLE
 --------
-- 
1.5.3.5.1623.g4aab495-dirty

-- 
Jonas Fonseca
