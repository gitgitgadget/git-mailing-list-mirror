From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] documentation: convert "diffcore" and
 "repository-layout" to man pages
Date: Fri, 6 Jun 2008 09:07:28 +0200
Message-ID: <20080606090728.907e4611.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 09:04:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4VzX-0006hv-SX
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 09:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbYFFHDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 03:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbYFFHDL
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 03:03:11 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37134 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619AbYFFHDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 03:03:09 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 61FBA1AB30E;
	Fri,  6 Jun 2008 09:03:07 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id DD03D1AB2C4;
	Fri,  6 Jun 2008 09:03:05 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84034>

This patch renames the following documents and at the same time converts
them to the man format:

diffcore.txt          -> gitdiffcore.txt		(man section 7)
repository-layout.txt -> gitrepository-layout.txt	(man section 5)

Other documents that reference the above ones are changed accordingly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/Makefile                             |   10 +++---
 Documentation/diff-options.txt                     |    2 +-
 Documentation/git-add.txt                          |    2 +-
 Documentation/git-update-server-info.txt           |    4 +-
 Documentation/git.txt                              |    3 +-
 Documentation/gitcore-tutorial.txt                 |    2 +-
 Documentation/{diffcore.txt => gitdiffcore.txt}    |   31 +++++++++++++++---
 ...ository-layout.txt => gitrepository-layout.txt} |   34 +++++++++++++++++--
 8 files changed, 68 insertions(+), 20 deletions(-)
 rename Documentation/{diffcore.txt => gitdiffcore.txt} (96%)
 rename Documentation/{repository-layout.txt => gitrepository-layout.txt} (92%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ca4dadf..5bd0e7c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,9 +2,11 @@ MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
 	gitk.txt
-MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt
+MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
+	gitrepository-layout.txt
 MAN7_TXT=git.txt gitcli.txt gittutorial.txt gittutorial-2.txt \
-	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt
+	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
+	gitdiffcore.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
@@ -12,9 +14,7 @@ MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 
 DOC_HTML=$(MAN_HTML)
 
-ARTICLES = diffcore
-ARTICLES += howto-index
-ARTICLES += repository-layout
+ARTICLES = howto-index
 ARTICLES += everyday
 ARTICLES += git-tools
 # with their own formatting rules.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 859d679..5721548 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -241,4 +241,4 @@ endif::git-format-patch[]
 	Do not show any source or destination prefix.
 
 For more detailed explanation on these common options, see also
-link:diffcore.html[diffcore documentation].
+linkgit:gitdiffcore[7][diffcore documentation].
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 1afd0c6..8eb9de1 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -100,7 +100,7 @@ Configuration
 The optional configuration variable 'core.excludesfile' indicates a path to a
 file containing patterns of file names to exclude from git-add, similar to
 $GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
-those in info/exclude.  See link:repository-layout.html[repository layout].
+those in info/exclude.  See linkgit:gitrepository-layout[5][repository layout].
 
 
 EXAMPLES
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 1cf89fd..b49abbf 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -30,8 +30,8 @@ OUTPUT
 ------
 
 Currently the command updates the following files.  Please see
-link:repository-layout.html[repository-layout] for description
-of what they are for:
+linkgit:gitrepository-layout[5][repository-layout] for description of
+what they are for:
 
 * objects/info/packs
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d39ab57..a826bc2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -364,7 +364,8 @@ For a more complete list of ways to spell object names, see
 File/Directory Structure
 ------------------------
 
-Please see the link:repository-layout.html[repository layout] document.
+Please see the linkgit:gitrepository-layout[5][repository layout]
+document.
 
 Read linkgit:githooks[5][hooks] for more details about each hook.
 
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 5995a2e..d61d5c9 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -109,7 +109,7 @@ populating your tree.
 
 [NOTE]
 An advanced user may want to take a look at the
-link:repository-layout.html[repository layout] document
+linkgit:gitrepository-layout[5][repository layout] document
 after finishing this tutorial.
 
 You have now created your first git repository. Of course, since it's
diff --git a/Documentation/diffcore.txt b/Documentation/gitdiffcore.txt
similarity index 96%
rename from Documentation/diffcore.txt
rename to Documentation/gitdiffcore.txt
index c6a983a..f68efed 100644
--- a/Documentation/diffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -1,10 +1,16 @@
-Tweaking diff output
-====================
-June 2005
+gitdiffcore(7)
+==============
 
+NAME
+----
+gitdiffcore - Tweaking diff output (June 2005)
 
-Introduction
-------------
+SYNOPSIS
+--------
+git diff *
+
+DESCRIPTION
+-----------
 
 The diff commands git-diff-index, git-diff-files, and git-diff-tree
 can be told to manipulate differences they find in
@@ -269,3 +275,18 @@ Documentation
 *.c
 t
 ------------------------------------------------
+
+SEE ALSO
+--------
+linkgit:git-diff[1],
+linkgit:git-diff-files[1],
+linkgit:git-diff-index[1],
+linkgit:git-diff-tree[1],
+linkgit:git-format-patch[1],
+linkgit:git-log[1],
+linkgit:gitglossary[7],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
diff --git a/Documentation/repository-layout.txt b/Documentation/gitrepository-layout.txt
similarity index 92%
rename from Documentation/repository-layout.txt
rename to Documentation/gitrepository-layout.txt
index 7fd187b..9949093 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -1,9 +1,20 @@
-git repository layout
-=====================
+gitrepository-layout(5)
+=======================
+
+NAME
+----
+gitrepository-layout - Git Repository Layout
+
+SYNOPSIS
+--------
+$GIT_DIR/*
+
+DESCRIPTION
+-----------
 
 You may find these things in your git repository (`.git`
 directory for a repository associated with your working tree, or
-`'project'.git` directory for a public 'bare' repository. It is
+`<project>.git` directory for a public 'bare' repository. It is
 also possible to have a working tree where `.git` is a plain
 ascii file containing `gitdir: <path>`, i.e. the path to the
 real git repository).
@@ -115,7 +126,7 @@ details.
 branches::
 	A slightly deprecated way to store shorthands to be used
 	to specify URL to `git fetch`, `git pull` and `git push`
-	commands is to store a file in `branches/'name'` and
+	commands is to store a file in `branches/<name>` and
 	give 'name' to these commands in place of 'repository'
 	argument.
 
@@ -180,3 +191,18 @@ shallow::
 	This is similar to `info/grafts` but is internally used
 	and maintained by shallow clone mechanism.  See `--depth`
 	option to linkgit:git-clone[1] and linkgit:git-fetch[1].
+
+SEE ALSO
+--------
+linkgit:git-init[1],
+linkgit:git-clone[1],
+linkgit:git-fetch[1],
+linkgit:git-pack-refs[1],
+linkgit:git-gc[1],
+linkgit:git-checkout[1],
+linkgit:gitglossary[7],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
-- 
1.5.6.rc0.202.g8f5a
