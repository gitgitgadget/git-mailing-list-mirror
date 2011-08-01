From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] Documentation/submodule: add command references and update
 options
Date: Mon, 01 Aug 2011 22:49:21 +0200
Message-ID: <4E371151.4040407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nikolai Weibull <now@bitwi.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 22:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnzQW-0007K1-Ea
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 22:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab1HAUtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 16:49:25 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:52843 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab1HAUtX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 16:49:23 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id A8A911947CF20;
	Mon,  1 Aug 2011 22:49:21 +0200 (CEST)
Received: from [91.48.110.244] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QnzQP-0002hN-00; Mon, 01 Aug 2011 22:49:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/zqUrxg1Y4FS1kNTaT4jFyJ3ZlC/uUjn/UhmvS
	+qaoF6UrwvBwMkpcBQhz4WyeVhDrptd81qWkz8tF1DE7xPeSQ2
	4w/eUbz47TeMWcxkCfzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178411>

Reference the "git diff" and "git status" commands where they learned
functionality that in earlier git versions was only available through the
'summary' and 'status' subcommands of "git submodule".

The short option '-n' for '--summary-limit' was missing from the synopsis
and the --init option was missing from the "options" section, add those
there. And while at it, quote all options in backticks so they are
decorated properly in the output formats which support that.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

In this version the options are quoted in backticks and the phrase "will
provide the same information" has been changed to "provide that information
too" to inform the user that it will provide "the same and a lot of other"
information.


 Documentation/git-submodule.txt |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0ec8574..67cf5f0 100644
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

@@ -108,8 +109,13 @@ status::
 	repository and `U` if the submodule has merge conflicts.
 	This command is the default command for 'git submodule'.
 +
-If '--recursive' is specified, this command will recurse into nested
+If `--recursive` is specified, this command will recurse into nested
 submodules, and show their status as well.
++
+If you are only interested in changes of the currently initialized
+submodules with respect to the commit recorded in the index or the HEAD,
+linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
+too (and can also report changes to a submodule's work tree).

 init::
 	Initialize the submodules, i.e. register each submodule name
@@ -125,26 +131,29 @@ init::
 update::
 	Update the registered submodules, i.e. clone missing submodules and
 	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached unless '--rebase' or
-	'--merge' is specified or the key `submodule.$name.update` is set to
+	This will make the submodules HEAD be detached unless `--rebase` or
+	`--merge` is specified or the key `submodule.$name.update` is set to
 	`rebase` or `merge`.
 +
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
-submodule with the --init option.
+submodule with the `--init` option.
 +
-If '--recursive' is specified, this command will recurse into the
+If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.

 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
 	in the submodule between the given super project commit and the
-	index or working tree (switched by --cached) are shown. If the option
-	--files is given, show the series of commits in the submodule between
+	index or working tree (switched by `--cached`) are shown. If the option
+	`--files` is given, show the series of commits in the submodule between
 	the index of the super project and the working tree of the submodule
-	(this option doesn't allow to use the --cached option or to provide an
+	(this option doesn't allow to use the `--cached` option or to provide an
 	explicit commit).
++
+Using the `--submodule=log` option with linkgit:git-diff[1] will provide that
+information too.

 foreach::
 	Evaluates an arbitrary shell command in each checked out submodule.
@@ -155,9 +164,9 @@ foreach::
 	superproject, $sha1 is the commit as recorded in the superproject,
 	and $toplevel is the absolute path to the top-level of the superproject.
 	Any submodules defined in the superproject but not checked out are
-	ignored by this command. Unless given --quiet, foreach prints the name
+	ignored by this command. Unless given `--quiet`, foreach prints the name
 	of each submodule before evaluating the command.
-	If --recursive is given, submodules are traversed recursively (i.e.
+	If `--recursive` is given, submodules are traversed recursively (i.e.
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
+for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.

 --recursive::
 	This option is only valid for foreach, update and status commands.
-- 
1.7.6.351.gb35ac
