From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] Documentation: rename "hooks.txt" to "githooks.txt" and
 make it a man page
Date: Fri, 2 May 2008 05:30:47 +0200
Message-ID: <20080502053047.ac68841e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 05:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrlvN-0002fZ-2v
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 05:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbYEBD0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 23:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbYEBD0B
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 23:26:01 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:45840 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477AbYEBDZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 23:25:48 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4B0391AB2B8;
	Fri,  2 May 2008 05:25:47 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id DCE7F1AB2AC;
	Fri,  2 May 2008 05:25:46 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80952>

Also now "gitcli(5)" becomes "gitcli(7)".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/Makefile                    |    5 ++---
 Documentation/cvs-migration.txt           |    2 +-
 Documentation/git-commit.txt              |    4 ++--
 Documentation/git-rev-parse.txt           |    2 +-
 Documentation/git.txt                     |    2 +-
 Documentation/gitcli.txt                  |    2 +-
 Documentation/{hooks.txt => githooks.txt} |   20 ++++++++++++++++++--
 Documentation/repository-layout.txt       |    2 +-
 Documentation/user-manual.txt             |    2 +-
 9 files changed, 28 insertions(+), 13 deletions(-)
 rename Documentation/{hooks.txt => githooks.txt} (98%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 43781fb..4144d1e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,8 +2,8 @@ MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
 	gitk.txt
-MAN5_TXT=gitattributes.txt gitignore.txt gitcli.txt gitmodules.txt
-MAN7_TXT=git.txt
+MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt
+MAN7_TXT=git.txt gitcli.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
@@ -18,7 +18,6 @@ ARTICLES += cvs-migration
 ARTICLES += diffcore
 ARTICLES += howto-index
 ARTICLES += repository-layout
-ARTICLES += hooks
 ARTICLES += everyday
 ARTICLES += git-tools
 ARTICLES += glossary
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 00f2e36..374bc87 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -137,7 +137,7 @@ Advanced Shared Repository Management
 
 Git allows you to specify scripts called "hooks" to be run at certain
 points.  You can use these, for example, to send all commits to the shared
-repository to a mailing list.  See link:hooks.html[Hooks used by git].
+repository to a mailing list.  See linkgit:githooks[5][Hooks used by git].
 
 You can enforce finer grained permissions using update hooks.  See
 link:howto/update-hook-example.txt[Controlling access to branches using
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 4bb51cc..c3c9f5b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -87,7 +87,7 @@ OPTIONS
 
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
-	See also link:hooks.html[hooks].
+	See also linkgit:githooks[5][hooks].
 
 --allow-empty::
 	Usually recording a commit that has the exact same tree as its
@@ -292,7 +292,7 @@ order).
 HOOKS
 -----
 This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
-and `post-commit` hooks.  See link:hooks.html[hooks] for more
+and `post-commit` hooks.  See linkgit:githooks[5][hooks] for more
 information.
 
 
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 110e7ba..b6b2fe9 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -347,7 +347,7 @@ Each line of options has this format:
 
 	* Use `*` to mean that this option should not be listed in the usage
 	  generated for the `-h` argument. It's shown for `--help-all` as
-	  documented in linkgit:gitcli[5].
+	  documented in linkgit:gitcli[7].
 
 	* Use `!` to not make the corresponding negated long option available.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6f445b1..adcd3e0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -364,7 +364,7 @@ File/Directory Structure
 
 Please see the link:repository-layout.html[repository layout] document.
 
-Read link:hooks.html[hooks] for more details about each hook.
+Read linkgit:githooks[5][hooks] for more details about each hook.
 
 Higher level SCMs may provide and manage additional information in the
 `$GIT_DIR`.
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 7ee5ce3..835cb05 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -1,4 +1,4 @@
-gitcli(5)
+gitcli(7)
 =========
 
 NAME
diff --git a/Documentation/hooks.txt b/Documentation/githooks.txt
similarity index 98%
rename from Documentation/hooks.txt
rename to Documentation/githooks.txt
index 1283ab4..67c0809 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/githooks.txt
@@ -1,5 +1,17 @@
-Hooks used by git
-=================
+githooks(5)
+===========
+
+NAME
+----
+githooks - Hooks used by git
+
+SYNOPSIS
+--------
+$GIT_DIR/hooks/*
+
+
+DESCRIPTION
+-----------
 
 Hooks are little scripts you can place in `$GIT_DIR/hooks`
 directory to trigger action at certain points.  When
@@ -284,3 +296,7 @@ pre-auto-gc
 This hook is invoked by `git-gc --auto`. It takes no parameter, and
 exiting with non-zero status from this script causes the `git-gc --auto`
 to abort.
+
+GIT
+---
+Part of the linkgit:git[7] suite
diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index bbaed2e..7fd187b 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -124,7 +124,7 @@ hooks::
 	commands.  A handful of sample hooks are installed when
 	`git init` is run, but all of them are disabled by
 	default.  To enable, they need to be made executable.
-	Read link:hooks.html[hooks] for more details about
+	Read linkgit:githooks[5][hooks] for more details about
 	each hook.
 
 index::
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 86b91a5..e2db850 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1881,7 +1881,7 @@ $ chmod a+x hooks/post-update
 
 (For an explanation of the last two lines, see
 linkgit:git-update-server-info[1], and the documentation
-link:hooks.html[Hooks used by git].)
+linkgit:githooks[5][Hooks used by git].)
 
 Advertise the URL of proj.git.  Anybody else should then be able to
 clone or pull from that URL, for example with a command line like:
-- 
1.5.5.1.124.g7e5fa.dirty
