From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Cogito documentation updates
Date: Sun, 20 Nov 2005 11:11:12 +0100
Message-ID: <20051120101112.GA2302@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 11:12:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdmAK-0000R6-A4
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 11:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVKTKLP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 05:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKTKLO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 05:11:14 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:11218 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751126AbVKTKLO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 05:11:14 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id BCA5D6DFFB2; Sun, 20 Nov 2005 11:10:41 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 792596DFFA0; Sun, 20 Nov 2005 11:10:41 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 035C6613AF; Sun, 20 Nov 2005 11:11:12 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12377>

 - local cg-fetch now works without the cp option -u
 - note the difference between short and long help in cg-help(1)
 - mention the alien repo importers provided by the git core
 - fix typo in cg-update(1)

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
diff --git a/README.osx b/README.osx
index e82ef79..d8df872 100644
--- a/README.osx
+++ b/README.osx
@@ -9,18 +9,6 @@ You may have to deal with md5 mismatches
 your new Portfile or place the new tarball in
 /opt/local/var/db/dports/distfiles/cogito.
 
-Caveats:
-
-cg-fetch on a local repository requires cp -u, a non-portable gnu
-extension.  This means that cg-fetch, cg-clone and cg-update from a
-local repository are broken.
-
-Workaround #1: Use rsync for local clones.  I.e.  "cg-clone
-rsync://localhost/dir" instead of "cg-clone dir".  This loses the disk
-space savings of normally gained by cg-clone.
-
-Workaround #2: Use gnu cp.  "cd /opt/local/bin; sudo ln -s gcp cp".
-
 Recommendations:
 
 The gnu versions of "stat" and "date" are preferred over their BSD
diff --git a/cg-help b/cg-help
index 6ba7657..5fa65ef 100755
--- a/cg-help
+++ b/cg-help
@@ -8,8 +8,9 @@
 # If the argument is left out an overview of all the Cogito commands will
 # be shown.
 #
-# Note help for a command is also available by passing `--help` or `-h`
-# to the command.
+# Note, short help for a command is also available by passing `--help` or
+# `-h` to the command. The complete command manual is shown when passing
+# `--long-help` (and is the same as doing "`cg-help command`").
 #
 # OPTIONS
 # -------
diff --git a/cg-init b/cg-init
index a0a7372..31c2e10 100755
--- a/cg-init
+++ b/cg-init
@@ -9,7 +9,9 @@
 # This command is intended for creating repositories for work on new projects.
 # If you want to clone an existing project, see `cg-clone`. If you want to
 # set up a public repository not for direct work but only for pushing/pulling,
-# see `cg-admin-setuprepo`.
+# see `cg-admin-setuprepo`. It is also possible to import repositories from
+# other SCMs to GIT, see `git-cvsimport(1)`, `git-svnimport(1)` and
+# `git-archimport(1)`.
 #
 # OPTIONS
 # -------
diff --git a/cg-update b/cg-update
index ed93c01..9d82fcb 100755
--- a/cg-update
+++ b/cg-update
@@ -8,7 +8,7 @@
 # This is similar to running cg-fetch and cg-merge commands successively.
 # Please refer to the documentation of those commands for more details
 # about the operation. Note that if you are not doing own development
-# but only following some project, you it is recommended to use this command
+# but only following some project, it is recommended to use this command
 # instead of `cg-fetch` + `cg-merge` since `cg-update` can handle some
 # additional corner cases (in particular, if the remote branch rebases,
 # `cg-update` will fast-forward instead of doing a tree merge and diverging).

-- 
Jonas Fonseca
