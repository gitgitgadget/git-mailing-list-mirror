From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Documentation/submodule: add command references and update
 options
Date: Sat, 23 Jul 2011 21:00:36 +0200
Message-ID: <4E2B1A54.2000605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nikolai Weibull <now@bitwi.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 21:00:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkhRL-0000Za-Q6
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 21:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab1GWTAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 15:00:39 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:58446 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab1GWTAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 15:00:38 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 94A9B19444524;
	Sat, 23 Jul 2011 21:00:36 +0200 (CEST)
Received: from [93.246.62.195] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QkhRE-0001o3-00; Sat, 23 Jul 2011 21:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19g7oqZWCYexyuOwKQnkX7JlWNq/ZA0jYfOIgec
	tZP+/50lnxzHGu0tzD8Pi83T/Rxl2OhI9CuTxhBPTtotXeywza
	tVwDps5TJT64hQxZBjGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177701>

Reference the "git diff" and "git status" commands where they learned
functionality that in earlier git versions was only available through the
'summary' and 'status' subcommands of "git submodule".

The short option '-n' for '--summary-limit' was missing from the synopsis
and the --init option was missing from the "options" section, add those
there. And while at it, quote all options so they are decorated properly
in the output formats which support that.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

This patch addresses some issues with the current documentation which were
brought up on the list.

 Documentation/git-submodule.txt |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0ec8574..e749aa5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
 	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
-'git submodule' [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
+'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
+	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--] [<path>...]

@@ -110,6 +111,11 @@ status::
 +
 If '--recursive' is specified, this command will recurse into nested
 submodules, and show their status as well.
++
+If you are only interested in changes of the currently initialized
+submodules with respect to the commit recorded in the index or the HEAD,
+linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
+too (and can also report changes to a submodule's work tree).

 init::
 	Initialize the submodules, i.e. register each submodule name
@@ -131,7 +137,7 @@ update::
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
-submodule with the --init option.
+submodule with the '--init' option.
 +
 If '--recursive' is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
@@ -140,11 +146,14 @@ summary::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
 	in the submodule between the given super project commit and the
-	index or working tree (switched by --cached) are shown. If the option
-	--files is given, show the series of commits in the submodule between
+	index or working tree (switched by '--cached') are shown. If the option
+	'--files' is given, show the series of commits in the submodule between
 	the index of the super project and the working tree of the submodule
-	(this option doesn't allow to use the --cached option or to provide an
+	(this option doesn't allow to use the '--cached' option or to provide an
 	explicit commit).
++
+Using the '--submodule=log' option with linkgit:git-diff[1] will provide the
+same information.

 foreach::
 	Evaluates an arbitrary shell command in each checked out submodule.
@@ -155,9 +164,9 @@ foreach::
 	superproject, $sha1 is the commit as recorded in the superproject,
 	and $toplevel is the absolute path to the top-level of the superproject.
 	Any submodules defined in the superproject but not checked out are
-	ignored by this command. Unless given --quiet, foreach prints the name
+	ignored by this command. Unless given '--quiet', foreach prints the name
 	of each submodule before evaluating the command.
-	If --recursive is given, submodules are traversed recursively (i.e.
+	If '--recursive' is given, submodules are traversed recursively (i.e.
 	the given shell command is evaluated in nested submodules as well).
 	A non-zero return from the command in any submodule causes
 	the processing to terminate. This can be overridden by adding '|| :'
@@ -237,13 +246,18 @@ OPTIONS
 	If the key `submodule.$name.update` is set to `rebase`, this option is
 	implicit.

+--init::
+	This option is only valid for the update command.
+	Initialize all submodules for which "git submodule init" has not been
+	called so far before updating.
+
 --reference <repository>::
 	This option is only valid for add and update commands.  These
 	commands sometimes need to clone a remote repository. In this case,
 	this option will be passed to the linkgit:git-clone[1] command.
 +
 *NOTE*: Do *not* use this option unless you have read the note
-for linkgit:git-clone[1]'s --reference and --shared options carefully.
+for linkgit:git-clone[1]'s '--reference' and '--shared' options carefully.

 --recursive::
 	This option is only valid for foreach, update and status commands.
-- 
1.7.6.356.g65c4e
