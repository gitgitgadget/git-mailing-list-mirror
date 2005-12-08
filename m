From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 4/17] Documentation/git-commit.txt: Add long options and -- to documentation.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844853670-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844852030-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVBO-0004R3-5g
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbVLHX2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVLHX2H
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:07 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:9636 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932725AbVLHX2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:06 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051208232804.VENM676.mxfep01.bredband.com@puritan.petwork>;
          Fri, 9 Dec 2005 00:28:04 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 4E53AADFEC;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844852030-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13402>

Added the following long options to documentation:

* --all
* --signoff
* --verify
* --no-verify
* --edit

Also added documentation for the -- option for terminating option parsing.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-commit.txt |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

f0cc0137f124e36fd31acb8d0d543bdc84923586
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1edc278..b92cf48 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -7,7 +7,7 @@ git-commit - Record your changes
 
 SYNOPSIS
 --------
-'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>] [-e] <file>...
+'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>] [-e] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -22,7 +22,7 @@ information.
 
 OPTIONS
 -------
--a::
+-a|--all::
 	Update all paths in the index file.
 
 -c or -C <commit>::
@@ -39,23 +39,29 @@ OPTIONS
 -m <msg>::
 	Use the given <msg> as the commit message.
 
--s::
+-s|--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
--v::
+-v|--verify::
 	Look for suspicious lines the commit introduces, and
 	abort committing if there is one.  The definition of
 	'suspicious lines' is currently the lines that has
 	trailing whitespaces, and the lines whose indentation
 	has a SP character immediately followed by a TAB
-	character.
+	character.  This is the default.
 
--e::
+-n|--no-verify::
+	The opposite of `--verify`.
+
+-e|--edit::
 	The message taken from file with `-F`, command line with
 	`-m`, and from file with `-C` are usually used as the
 	commit log message unmodified.  This option lets you
 	further edit the message taken from these sources.
 
+--::
+	Do not interpret any more arguments as options.
+
 <file>...::
 	Update specified paths in the index file before committing.
 
-- 
0.99.9l
