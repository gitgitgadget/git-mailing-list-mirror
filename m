From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 4/4] peek-remote: remove deprecated alias of ls-remote
Date: Sun, 10 Nov 2013 15:47:31 +0000
Message-ID: <06b9203a9ac991772d6114b983860dda5ff3d8f7.1384098226.git.john@keeping.me.uk>
References: <cover.1384098226.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 10 16:48:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfXF9-0000E4-6p
	for gcvg-git-2@plane.gmane.org; Sun, 10 Nov 2013 16:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab3KJPsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 10:48:03 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:50442 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab3KJPsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 10:48:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2F67D6064DE;
	Sun, 10 Nov 2013 15:48:01 +0000 (GMT)
X-Quarantine-ID: <84Ee7tpgJSpc>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 84Ee7tpgJSpc; Sun, 10 Nov 2013 15:48:00 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id BAD256064EE;
	Sun, 10 Nov 2013 15:47:56 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.rc0.170.g772b8ec
In-Reply-To: <cover.1384098226.git.john@keeping.me.uk>
In-Reply-To: <cover.1384098226.git.john@keeping.me.uk>
References: <cover.1384098226.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237588>

This has been deprecated since commit 87194d2 (Deprecate peek-remote,
2007-11-24), included in version 1.5.4.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 .gitignore                             |  1 -
 Documentation/git-peek-remote.txt      | 43 ----------------------------------
 Makefile                               |  1 -
 command-list.txt                       |  1 -
 contrib/completion/git-completion.bash |  1 -
 git.c                                  |  1 -
 6 files changed, 48 deletions(-)
 delete mode 100644 Documentation/git-peek-remote.txt

diff --git a/.gitignore b/.gitignore
index c141b2a..c2ad802 100644
--- a/.gitignore
+++ b/.gitignore
@@ -104,7 +104,6 @@
 /git-pack-refs
 /git-parse-remote
 /git-patch-id
-/git-peek-remote
 /git-prune
 /git-prune-packed
 /git-pull
diff --git a/Documentation/git-peek-remote.txt b/Documentation/git-peek-remote.txt
deleted file mode 100644
index 87ea3fb..0000000
--- a/Documentation/git-peek-remote.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-git-peek-remote(1)
-==================
-
-NAME
-----
-git-peek-remote - List the references in a remote repository
-
-
-SYNOPSIS
---------
-[verse]
-'git peek-remote' [--upload-pack=<git-upload-pack>] [<host>:]<directory>
-
-DESCRIPTION
------------
-This command is deprecated; use 'git ls-remote' instead.
-
-OPTIONS
--------
---upload-pack=<git-upload-pack>::
-	Use this to specify the path to 'git-upload-pack' on the
-	remote side, if it is not found on your $PATH. Some
-	installations of sshd ignores the user's environment
-	setup scripts for login shells (e.g. .bash_profile) and
-	your privately installed git may not be found on the system
-	default $PATH.  Another workaround suggested is to set
-	up your $PATH in ".bashrc", but this flag is for people
-	who do not want to pay the overhead for non-interactive
-	shells, but prefer having a lean .bashrc file (they set most of
-	the things up in .bash_profile).
-
-<host>::
-	A remote host that houses the repository.  When this
-	part is specified, 'git-upload-pack' is invoked via
-	ssh.
-
-<directory>::
-	The repository to sync from.
-
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 7ffd705..504931f 100644
--- a/Makefile
+++ b/Makefile
@@ -589,7 +589,6 @@ BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-get-tar-commit-id$X
 BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
-BUILT_INS += git-peek-remote$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
diff --git a/command-list.txt b/command-list.txt
index 7bf2420..cf36c3d 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -87,7 +87,6 @@ git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
 git-parse-remote                        synchelpers
 git-patch-id                            purehelpers
-git-peek-remote                         purehelpers	deprecated
 git-prune                               ancillarymanipulators
 git-prune-packed                        plumbingmanipulators
 git-pull                                mainporcelain common
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c071614..874611d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -686,7 +686,6 @@ __git_list_porcelain_commands ()
 		pack-refs)        : plumbing;;
 		parse-remote)     : plumbing;;
 		patch-id)         : plumbing;;
-		peek-remote)      : plumbing;;
 		prune)            : plumbing;;
 		prune-packed)     : plumbing;;
 		quiltimport)      : import;;
diff --git a/git.c b/git.c
index 5c9858f..727e380 100644
--- a/git.c
+++ b/git.c
@@ -408,7 +408,6 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
 		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 		{ "patch-id", cmd_patch_id },
-		{ "peek-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
-- 
1.8.5.rc0.170.g772b8ec
