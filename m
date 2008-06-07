From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/2] git-commit.txt: Add missing long/short options
Date: Sat,  7 Jun 2008 02:24:21 +0200
Message-ID: <1212798261-26785-2-git-send-email-s-beyer@gmx.net>
References: <1212798261-26785-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 02:25:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4mFS-0006cI-Bg
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303AbYFGAYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756089AbYFGAYj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:24:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:40859 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755600AbYFGAYh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:24:37 -0400
Received: (qmail invoked by alias); 07 Jun 2008 00:24:36 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp055) with SMTP; 07 Jun 2008 02:24:36 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18J3iVQ8+AJHu6vg75aagC37sdbeQbs0CyaRSkQGR
	O5On+AghMJQ/Pj
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K4mEH-0006yP-35; Sat, 07 Jun 2008 02:24:21 +0200
X-Mailer: git-send-email 1.5.5.1.490.g1fabe.dirty
In-Reply-To: <1212798261-26785-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84154>

Furthmore, use
	short option::
	long option::
instead of
	short option|long option::
and split the "-c or -C <commit>" item into two separate items.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi again,

I added short or long options where they were missing because I think 
the manual page should talk about all options.
I also thought that it's useful to split the -c and -C case
and to use asciidoc's
 -f::
 --foo::
which will result in an "-f, -foo" for manual pages and imho
also is easier to read in the HTML output ;-)

Hmmm, somehow I don't expect that you will accept this patch ;-)

Regards,
  Stephan

 Documentation/git-commit.txt |   45 ++++++++++++++++++++++++++++--------------
 1 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c734326..43bc3e7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -52,19 +52,25 @@ that, you can recover from it with linkgit:git-reset[1].
 
 OPTIONS
 -------
--a|--all::
+-a::
+--all::
 	Tell the command to automatically stage files that have
 	been modified and deleted, but new files you have not
 	told git about are not affected.
 
--c or -C <commit>::
+-C <commit>::
+--reuse-message=<commit>::
 	Take existing commit object, and reuse the log message
 	and the authorship information (including the timestamp)
-	when creating the commit.  With '-C', the editor is not
-	invoked; with '-c' the user can further edit the commit
-	message.
+	when creating the commit.
+
+-c <commit>
+--reedit-message=<commit>::
+	Like '-C' but with '-c' the editor is invoked, so that
+	the user can further edit the commit message.
 
 -F <file>::
+--file=<file>::
 	Take the commit message from the given file.  Use '-' to
 	read the message from the standard input.
 
@@ -72,19 +78,23 @@ OPTIONS
 	Override the author name used in the commit.  Use
 	`A U Thor <author@example.com>` format.
 
--m <msg>|--message=<msg>::
+-m <msg>::
+--message=<msg>::
 	Use the given <msg> as the commit message.
 
--t <file>|--template=<file>::
+-t <file>::
+--template=<file>::
 	Use the contents of the given file as the initial version
 	of the commit message. The editor is invoked and you can
 	make subsequent changes. If a message is specified using
 	the `-m` or `-F` options, this option has no effect. This
 	overrides the `commit.template` configuration variable.
 
--s|--signoff::
+-s::
+--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
+-n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
 	See also linkgit:githooks[5][hooks].
@@ -105,14 +115,14 @@ OPTIONS
 	'whitespace' removes just leading/trailing whitespace lines
 	and 'strip' removes both whitespace and commentary.
 
--e|--edit::
+-e::
+--edit::
 	The message taken from file with `-F`, command line with
 	`-m`, and from file with `-C` are usually used as the
 	commit log message unmodified.  This option lets you
 	further edit the message taken from these sources.
 
 --amend::
-
 	Used to amend the tip of the current branch. Prepare the tree
 	object you would want to replace the latest commit as usual
 	(this includes the usual -i/-o and explicit paths), and the
@@ -133,13 +143,15 @@ It is a rough equivalent for:
 but can be used to amend a merge commit.
 --
 
--i|--include::
+-i::
+--include::
 	Before making a commit out of staged contents so far,
 	stage the contents of paths given on the command line
 	as well.  This is usually not what you want unless you
 	are concluding a conflicted merge.
 
--o|--only::
+-o::
+--only::
 	Make a commit only from the paths specified on the
 	command line, disregarding any contents that have been
 	staged so far. This is the default mode of operation of
@@ -150,20 +162,23 @@ but can be used to amend a merge commit.
 	the last commit without committing changes that have
 	already been staged.
 
--u|--untracked-files::
+-u::
+--untracked-files::
 	Show all untracked files, also those in uninteresting
 	directories, in the "Untracked files:" section of commit
 	message template.  Without this option only its name and
 	a trailing slash are displayed for each untracked
 	directory.
 
--v|--verbose::
+-v::
+--verbose::
 	Show unified diff between the HEAD commit and what
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
 	lines prefixed with '#'.
 
--q|--quiet::
+-q::
+--quiet::
 	Suppress commit summary message.
 
 \--::
-- 
1.5.5.1
