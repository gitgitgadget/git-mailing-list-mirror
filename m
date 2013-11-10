From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 1/4] repo-config: remove deprecated alias for "git config"
Date: Sun, 10 Nov 2013 15:47:28 +0000
Message-ID: <2a4079dbc0501d2ac33386e7d38123408fe4a54b.1384098226.git.john@keeping.me.uk>
References: <cover.1384098226.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 10 16:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfXEv-0008OV-Jp
	for gcvg-git-2@plane.gmane.org; Sun, 10 Nov 2013 16:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab3KJPrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 10:47:49 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:50340 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab3KJPrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 10:47:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 327E060654B;
	Sun, 10 Nov 2013 15:47:48 +0000 (GMT)
X-Quarantine-ID: <V+v7QN4bcKJr>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V+v7QN4bcKJr; Sun, 10 Nov 2013 15:47:47 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id A1AE560653E;
	Sun, 10 Nov 2013 15:47:43 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.rc0.170.g772b8ec
In-Reply-To: <cover.1384098226.git.john@keeping.me.uk>
In-Reply-To: <cover.1384098226.git.john@keeping.me.uk>
References: <cover.1384098226.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237587>

The release notes for Git 1.5.4 say that "git repo-config" will be
removed in the next feature release.  Since Git 2.0 is nearly here,
remove it.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 .gitignore                             |  1 -
 Documentation/git-repo-config.txt      | 23 -----------------------
 Makefile                               |  1 -
 builtin.h                              |  1 -
 builtin/config.c                       |  6 ------
 command-list.txt                       |  1 -
 contrib/completion/git-completion.bash |  1 -
 contrib/examples/git-whatchanged.sh    |  4 ++--
 git.c                                  |  1 -
 9 files changed, 2 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/git-repo-config.txt

diff --git a/.gitignore b/.gitignore
index 66199ed..3bc1b08 100644
--- a/.gitignore
+++ b/.gitignore
@@ -131,7 +131,6 @@
 /git-remote-testsvn
 /git-repack
 /git-replace
-/git-repo-config
 /git-request-pull
 /git-rerere
 /git-reset
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
deleted file mode 100644
index 9ec115b..0000000
--- a/Documentation/git-repo-config.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-git-repo-config(1)
-==================
-
-NAME
-----
-git-repo-config - Get and set repository or global options
-
-
-SYNOPSIS
---------
-[verse]
-'git repo-config' ...
-
-
-DESCRIPTION
------------
-
-This is a synonym for linkgit:git-config[1].  Please refer to the
-documentation of that command.
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index af847f8..4fc2378 100644
--- a/Makefile
+++ b/Makefile
@@ -591,7 +591,6 @@ BUILT_INS += git-get-tar-commit-id$X
 BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
-BUILT_INS += git-repo-config$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
diff --git a/builtin.h b/builtin.h
index b56cf07..d4afbfe 100644
--- a/builtin.h
+++ b/builtin.h
@@ -103,7 +103,6 @@ extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 extern int cmd_repack(int argc, const char **argv, const char *prefix);
-extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
diff --git a/builtin/config.c b/builtin/config.c
index 20e89fe..92ebf23 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -671,9 +671,3 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	return 0;
 }
-
-int cmd_repo_config(int argc, const char **argv, const char *prefix)
-{
-	fprintf(stderr, "WARNING: git repo-config is deprecated in favor of git config.\n");
-	return cmd_config(argc, argv, prefix);
-}
diff --git a/command-list.txt b/command-list.txt
index 08b04e2..f2bf684 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -102,7 +102,6 @@ git-relink                              ancillarymanipulators
 git-remote                              ancillarymanipulators
 git-repack                              ancillarymanipulators
 git-replace                             ancillarymanipulators
-git-repo-config                         ancillarymanipulators	deprecated
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain common
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dba3c15..c6063c9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -694,7 +694,6 @@ __git_list_porcelain_commands ()
 		read-tree)        : plumbing;;
 		receive-pack)     : plumbing;;
 		remote-*)         : transport;;
-		repo-config)      : deprecated;;
 		rerere)           : plumbing;;
 		rev-list)         : plumbing;;
 		rev-parse)        : plumbing;;
diff --git a/contrib/examples/git-whatchanged.sh b/contrib/examples/git-whatchanged.sh
index 1fb9feb..2edbdc6 100755
--- a/contrib/examples/git-whatchanged.sh
+++ b/contrib/examples/git-whatchanged.sh
@@ -9,12 +9,12 @@ case "$0" in
 *whatchanged)
 	count=
 	test -z "$diff_tree_flags" &&
-		diff_tree_flags=$(git-repo-config --get whatchanged.difftree)
+		diff_tree_flags=$(git config --get whatchanged.difftree)
 	diff_tree_default_flags='-c -M --abbrev' ;;
 *show)
 	count=-n1
 	test -z "$diff_tree_flags" &&
-		diff_tree_flags=$(git-repo-config --get show.difftree)
+		diff_tree_flags=$(git config --get show.difftree)
 	diff_tree_default_flags='--cc --always' ;;
 esac
 test -z "$diff_tree_flags" &&
diff --git a/git.c b/git.c
index cb5208d..0c9dde2 100644
--- a/git.c
+++ b/git.c
@@ -421,7 +421,6 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "remote-fd", cmd_remote_fd },
 		{ "repack", cmd_repack, RUN_SETUP },
 		{ "replace", cmd_replace, RUN_SETUP },
-		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
-- 
1.8.5.rc0.170.g772b8ec
