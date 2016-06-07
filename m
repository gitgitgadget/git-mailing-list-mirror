From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v4 3/3] doc: more consistency in environment variables format
Date: Wed,  8 Jun 2016 00:35:07 +0200
Message-ID: <20160607223507.18061-4-tom.russello@grenoble-inp.org>
References: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
 <20160607223507.18061-1-tom.russello@grenoble-inp.org>
Cc: erwan.mathoniere@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	jordan.de-gea@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	gitster@pobox.com, Tom Russello <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 00:39:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPbL-0003jB-DE
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423405AbcFGWfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:35:55 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:50904 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423396AbcFGWfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:35:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C1A7F256B;
	Wed,  8 Jun 2016 00:35:50 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ukzOKnxp_zQ; Wed,  8 Jun 2016 00:35:50 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B1F8024F3;
	Wed,  8 Jun 2016 00:35:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id AF46F2066;
	Wed,  8 Jun 2016 00:35:50 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNdfwo0EKCNT; Wed,  8 Jun 2016 00:35:50 +0200 (CEST)
Received: from ux-305.numericable.fr (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 6F8F52064;
	Wed,  8 Jun 2016 00:35:50 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160607223507.18061-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296744>

Wrap with backticks (monospaced font) unwrapped or single-quotes wrapped
(italic type) environment variables which are followed by the word
"environment". It was obtained with:

perl -pi -e "s/\'?(\\\$?[0-9A-Z\_]+)\'?(?= environment ?)/\`\1\`/g" *.txt

One of the main purposes is to stick to the CodingGuidelines as possible so
that people writting new documentation by mimicking the existing are more likely
to have it right (even if they didn't read the CodingGuidelines).

Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
One reason behind the creation of this patch is that patch [2/3] led to minor
inconsistencies in some sentences as it only deals with GIT_* environment
variables and let others unchanged (for example `GIT_ASKPASS` and 'SSH_ASKPASS'
in Documentation/config.txt).

For this one, I had to manually change GIT_AUTHOR_DATE
(Documentation/date-formats.txt - l.4) and GIT_EXTERNAL_DIFF
(Documentation/diff-generate-patch.txt - l.9) as the perl command didn't manage
these cases and so created minor inconsistencies.

 Documentation/config.txt              | 12 ++++++------
 Documentation/date-formats.txt        |  2 +-
 Documentation/diff-generate-patch.txt |  2 +-
 Documentation/git-bisect-lk2009.txt   |  2 +-
 Documentation/git-bisect.txt          |  2 +-
 Documentation/git-commit.txt          |  4 ++--
 Documentation/git-config.txt          |  2 +-
 Documentation/git-daemon.txt          |  2 +-
 Documentation/git-filter-branch.txt   |  2 +-
 Documentation/git-help.txt            |  2 +-
 Documentation/git-http-backend.txt    |  8 ++++----
 Documentation/git-init.txt            |  2 +-
 Documentation/git-p4.txt              |  2 +-
 Documentation/git-quiltimport.txt     |  4 ++--
 Documentation/git-sh-setup.txt        |  2 +-
 Documentation/git.txt                 |  2 +-
 Documentation/gitweb.conf.txt         |  2 +-
 17 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3897906..a555c30 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -478,9 +478,9 @@ false), while all other repositories are assumed to be bare (bare
 
 core.worktree::
 	Set the path to the root of the working tree.
-	If GIT_COMMON_DIR environment variable is set, core.worktree
+	If `GIT_COMMON_DIR` environment variable is set, core.worktree
 	is ignored and not used for determining the root of working tree.
-	This can be overridden by the GIT_WORK_TREE environment
+	This can be overridden by the `GIT_WORK_TREE` environment
 	variable and the '--work-tree' command-line option.
 	The value can be an absolute path or relative to the path to
 	the .git directory, which is either specified by --git-dir
@@ -621,7 +621,7 @@ core.askPass::
 	ask for a password can be told to use an external program given
 	via the value of this variable. Can be overridden by the `GIT_ASKPASS`
 	environment variable. If not set, fall back to the value of the
-	'SSH_ASKPASS' environment variable or, failing that, a simple password
+	`SSH_ASKPASS` environment variable or, failing that, a simple password
 	prompt. The external program shall be given a suitable prompt as
 	command-line argument and write the password on its STDOUT.
 
@@ -1608,7 +1608,7 @@ guitool.<name>.confirm::
 
 guitool.<name>.argPrompt::
 	Request a string argument from the user, and pass it to the tool
-	through the 'ARGS' environment variable. Since requesting an
+	through the `ARGS` environment variable. Since requesting an
 	argument implies confirmation, the 'confirm' option has no effect
 	if this is enabled. If the option is set to 'true', 'yes', or '1',
 	the dialog uses a built-in generic prompt; otherwise the exact
@@ -1616,7 +1616,7 @@ guitool.<name>.argPrompt::
 
 guitool.<name>.revPrompt::
 	Request a single valid revision from the user, and set the
-	'REVISION' environment variable. In other aspects this option
+	`REVISION` environment variable. In other aspects this option
 	is similar to 'argPrompt', and can be used together with it.
 
 guitool.<name>.revUnmerged::
@@ -2910,7 +2910,7 @@ url.<base>.pushInsteadOf::
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
-	'EMAIL' environment variables.  See linkgit:git-commit-tree[1].
+	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
 
 user.name::
 	Your full name to be recorded in any newly created commits.
diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index ccd1fc8..35e8da2 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -1,7 +1,7 @@
 DATE FORMATS
 ------------
 
-The GIT_AUTHOR_DATE, GIT_COMMITTER_DATE environment variables
+The `GIT_AUTHOR_DATE`, `GIT_COMMITTER_DATE` environment variables
 ifdef::git-commit[]
 and the `--date` option
 endif::git-commit[]
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index bcf54da..c91afee 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -6,7 +6,7 @@ with a '-p' option, "git diff" without the '--raw' option, or
 "git log" with the "-p" option, they
 do not produce the output described above; instead they produce a
 patch file.  You can customize the creation of such patches via the
-GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS environment variables.
+`GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables.
 
 What the -p option produces is slightly different from the traditional
 diff format:
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index c06efbd..e015f5b 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -366,7 +366,7 @@ skip" to do the same thing. (In fact the special exit code 125 makes
 
 Or if you want more control, you can inspect the current state using
 for example "git bisect visualize". It will launch gitk (or "git log"
-if the DISPLAY environment variable is not set) to help you find a
+if the `DISPLAY` environment variable is not set) to help you find a
 better bisection point.
 
 Either way, if you have a string of untestable commits, it might
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 7e79aae..d9f960b 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -205,7 +205,7 @@ $ git bisect visualize
 
 `view` may also be used as a synonym for `visualize`.
 
-If the 'DISPLAY' environment variable is not set, 'git log' is used
+If the `DISPLAY` environment variable is not set, 'git log' is used
 instead.  You can also give command-line options such as `-p` and
 `--stat`.
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d474226..8a38179 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -450,8 +450,8 @@ include::i18n.txt[]
 ENVIRONMENT AND CONFIGURATION VARIABLES
 ---------------------------------------
 The editor used to edit the commit log message will be chosen from the
-GIT_EDITOR environment variable, the core.editor configuration variable, the
-VISUAL environment variable, or the EDITOR environment variable (in that
+`GIT_EDITOR` environment variable, the core.editor configuration variable, the
+`VISUAL` environment variable, or the `EDITOR` environment variable (in that
 order).  See linkgit:git-var[1] for details.
 
 HOOKS
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 6843114..a89c304 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -269,7 +269,7 @@ and '--unset'. *'git config' will only ever change one file at a time*.
 
 You can override these rules either by command-line options or by environment
 variables. The '--global' and the '--system' options will limit the file used
-to the global or system-wide file respectively. The GIT_CONFIG environment
+to the global or system-wide file respectively. The `GIT_CONFIG` environment
 variable has a similar effect, but you can specify any filename you want.
 
 
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a69b361..dc20275 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -188,7 +188,7 @@ Git configuration files in that directory are readable by `<user>`.
 	arguments. The external command can decide to decline the
 	service by exiting with a non-zero status (or to allow it by
 	exiting with a zero status).  It can also look at the $REMOTE_ADDR
-	and $REMOTE_PORT environment variables to learn about the
+	and `$REMOTE_PORT` environment variables to learn about the
 	requestor when making this decision.
 +
 The external command can optionally write a single line to its
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 003731f..bd560d3 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -61,7 +61,7 @@ Filters
 The filters are applied in the order as listed below.  The <command>
 argument is always evaluated in the shell context using the 'eval' command
 (with the notable exception of the commit filter, for technical reasons).
-Prior to that, the $GIT_COMMIT environment variable will be set to contain
+Prior to that, the `$GIT_COMMIT` environment variable will be set to contain
 the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
 GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
 and GIT_COMMITTER_DATE are taken from the current commit and exported to
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 3956525..679d539 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -128,7 +128,7 @@ will try to use konqueror first. But this may fail (for example, if
 DISPLAY is not set) and in that case emacs' woman mode will be tried.
 
 If everything fails, or if no viewer is configured, the viewer specified
-in the GIT_MAN_VIEWER environment variable will be tried.  If that
+in the `GIT_MAN_VIEWER` environment variable will be tried.  If that
 fails too, the 'man' program will be tried anyway.
 
 man.<tool>.path
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 9268fb6..bb0db19 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -21,7 +21,7 @@ pushing using the smart HTTP protocol.
 It verifies that the directory has the magic file
 "git-daemon-export-ok", and it will refuse to export any Git directory
 that hasn't explicitly been marked for export this way (unless the
-GIT_HTTP_EXPORT_ALL environmental variable is set).
+`GIT_HTTP_EXPORT_ALL` environmental variable is set).
 
 By default, only the `upload-pack` service is enabled, which serves
 'git fetch-pack' and 'git ls-remote' clients, which are invoked from
@@ -241,7 +241,7 @@ $HTTP["url"] =~ "^/git/private" {
 
 ENVIRONMENT
 -----------
-'git http-backend' relies upon the CGI environment variables set
+'git http-backend' relies upon the `CGI` environment variables set
 by the invoking web server, including:
 
 * PATH_INFO (if GIT_PROJECT_ROOT is set, otherwise PATH_TRANSLATED)
@@ -251,7 +251,7 @@ by the invoking web server, including:
 * QUERY_STRING
 * REQUEST_METHOD
 
-The GIT_HTTP_EXPORT_ALL environmental variable may be passed to
+The `GIT_HTTP_EXPORT_ALL` environmental variable may be passed to
 'git-http-backend' to bypass the check for the "git-daemon-export-ok"
 file in each repository before allowing export of that repository.
 
@@ -269,7 +269,7 @@ GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
 ensuring that any reflogs created by 'git-receive-pack' contain some
 identifying information of the remote user who performed the push.
 
-All CGI environment variables are available to each of the hooks
+All `CGI` environment variables are available to each of the hooks
 invoked by the 'git-receive-pack'.
 
 GIT
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 6364e5d..9d27197 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -47,7 +47,7 @@ Only print error and warning messages; all other output will be suppressed.
 
 --bare::
 
-Create a bare repository. If GIT_DIR environment is not set, it is set to the
+Create a bare repository. If `GIT_DIR` environment is not set, it is set to the
 current working directory.
 
 --template=<template_directory>::
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3385409..9d4f151 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -134,7 +134,7 @@ Submit
 ~~~~~~
 Submitting changes from a Git repository back to the p4 repository
 requires a separate p4 client workspace.  This should be specified
-using the 'P4CLIENT' environment variable or the Git configuration
+using the `P4CLIENT` environment variable or the Git configuration
 variable 'git-p4.client'.  The p4 client must exist, but the client root
 will be created and populated if it does not already exist.
 
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index ff633b0..8cf952b 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -46,14 +46,14 @@ OPTIONS
 	The directory to find the quilt patches.
 +
 The default for the patch directory is patches
-or the value of the $QUILT_PATCHES environment
+or the value of the `$QUILT_PATCHES` environment
 variable.
 
 --series <file>::
 	The quilt series file.
 +
 The default for the series file is <patches>/series
-or the value of the $QUILT_SERIES environment
+or the value of the `$QUILT_SERIES` environment
 variable.
 
 GIT
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 4f67c4c..8632612 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -41,7 +41,7 @@ usage::
 	die with the usage message.
 
 set_reflog_action::
-	Set GIT_REFLOG_ACTION environment to a given string (typically
+	Set `GIT_REFLOG_ACTION` environment to a given string (typically
 	the name of the program) unless it is already set.  Whenever
 	the script runs a `git` command that updates refs, a reflog
 	entry is created using the value of this string to leave the
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 48f5bf7..a9b55cd 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -571,7 +571,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string.
 
 --git-dir=<path>::
 	Set the path to the repository. This can also be controlled by
-	setting the GIT_DIR environment variable. It can be an absolute
+	setting the `GIT_DIR` environment variable. It can be an absolute
 	path or relative path to current working directory.
 
 --work-tree=<path>::
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 8a42270..a79e350 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -376,7 +376,7 @@ $site_name::
 	Name of your site or organization, to appear in page titles.  Set it
 	to something descriptive for clearer bookmarks etc.  If this variable
 	is not set or is, then gitweb uses the value of the `SERVER_NAME`
-	CGI environment variable, setting site name to "$SERVER_NAME Git",
+	`CGI` environment variable, setting site name to "$SERVER_NAME Git",
 	or "Untitled Git" if this variable is not set (e.g. if running gitweb
 	as standalone script).
 +
-- 
2.8.3
