From: Marco Costalba <mcostalba@yahoo.it>
Subject: Fix: remove generated template files
Date: Fri, 26 Aug 2005 11:26:24 -0700 (PDT)
Message-ID: <20050826182624.86421.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 20:27:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8iuO-00078z-8C
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 20:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVHZS01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 14:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbVHZS00
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 14:26:26 -0400
Received: from web26306.mail.ukl.yahoo.com ([217.146.176.17]:45970 "HELO
	web26306.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965150AbVHZS00 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 14:26:26 -0400
Received: (qmail 86423 invoked by uid 60001); 26 Aug 2005 18:26:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HpHopKVDBmEtoYweh0nUZpv4AGqargYsl5Nah40h3/Z4bQzFDLmyZ/Z5CwhdlXZcocuz0KQmRQM1Ix1n0LWWIhPE97MNMto6a3EqUIWJKvPKKyAH3V4yIvblQTwrPDqqQJ3pTaFGa62RzdQdD15b1/6lTFX/CInRoQOeox1+3iM=  ;
Received: from [151.38.111.157] by web26306.mail.ukl.yahoo.com via HTTP; Fri, 26 Aug 2005 11:26:24 PDT
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7820>

From: Marco Costalba <mcostalba@yahoo.it>
Date: 1125080490 +0200

This files are created by 'make' so remove from
repository

Signed-off-by: Marco Costalba <mcostalba@yahoo.it>

---

This time I send the patch ;-)


 templates/blt/description          |    1 -
 templates/blt/hooks/applypatch-msg |   14 --------
 templates/blt/hooks/commit-msg     |   14 --------
 templates/blt/hooks/post-commit    |    8 -----
 templates/blt/hooks/post-update    |    8 -----
 templates/blt/hooks/pre-applypatch |   14 --------
 templates/blt/hooks/pre-commit     |   61 ------------------------------------
 templates/blt/hooks/update         |   27 ----------------
 templates/blt/info/exclude         |    6 ----
 9 files changed, 0 insertions(+), 153 deletions(-)
 delete mode 100644 templates/blt/description
 delete mode 100644 templates/blt/hooks/applypatch-msg
 delete mode 100644 templates/blt/hooks/commit-msg
 delete mode 100644 templates/blt/hooks/post-commit
 delete mode 100644 templates/blt/hooks/post-update
 delete mode 100644 templates/blt/hooks/pre-applypatch
 delete mode 100644 templates/blt/hooks/pre-commit
 delete mode 100644 templates/blt/hooks/update
 delete mode 100644 templates/blt/info/exclude

01168c6044e7ebb570e851b4707b4fe0c7f40c15
diff --git a/templates/blt/description b/templates/blt/description
deleted file mode 100644
--- a/templates/blt/description
+++ /dev/null
@@ -1 +0,0 @@
-Unnamed repository; edit this file to name it for gitweb.
diff --git a/templates/blt/hooks/applypatch-msg b/templates/blt/hooks/applypatch-msg
deleted file mode 100644
--- a/templates/blt/hooks/applypatch-msg
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-#
-# An example hook script to check the commit log message taken by
-# applypatch from an e-mail message.
-#
-# The hook should exit with non-zero status after issuing an
-# appropriate message if it wants to stop the commit.  The hook is
-# allowed to edit the commit message file.
-#
-# To enable this hook, make this file executable.
-
-test -x "$GIT_DIR/hooks/commit-msg" &&
-	exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
-:
diff --git a/templates/blt/hooks/commit-msg b/templates/blt/hooks/commit-msg
deleted file mode 100644
--- a/templates/blt/hooks/commit-msg
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-#
-# An example hook script to check the commit log message.
-# Called by git-commit-script with one argument, the name of the file
-# that has the commit message.  The hook should exit with non-zero
-# status after issuing an appropriate message if it wants to stop the
-# commit.  The hook is allowed to edit the commit message file.
-#
-# To enable this hook, make this file executable.
-
-# This example catches duplicate Signed-off-by lines.
-
-test "" = "$(grep '^Signed-off-by: ' "$1" |
-	 sort | uniq -c | sed -e '/^[ 	]*1 /d')"
diff --git a/templates/blt/hooks/post-commit b/templates/blt/hooks/post-commit
deleted file mode 100644
--- a/templates/blt/hooks/post-commit
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-#
-# An example hook script that is called after a successful
-# commit is made.
-#
-# To enable this hook, make this file executable.
-
-: Nothing
diff --git a/templates/blt/hooks/post-update b/templates/blt/hooks/post-update
deleted file mode 100644
--- a/templates/blt/hooks/post-update
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-#
-# An example hook script to prepare a packed repository for use over
-# dumb transports.
-#
-# To enable this hook, make this file executable by "chmod +x post-update".
-
-exec git-update-server-info
diff --git a/templates/blt/hooks/pre-applypatch b/templates/blt/hooks/pre-applypatch
deleted file mode 100644
--- a/templates/blt/hooks/pre-applypatch
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/sh
-#
-# An example hook script to verify what is about to be committed
-# by applypatch from an e-mail message.
-#
-# The hook should exit with non-zero status after issuing an
-# appropriate message if it wants to stop the commit.
-#
-# To enable this hook, make this file executable.
-
-test -x "$GIT_DIR/hooks/pre-commit" &&
-	exec "$GIT_DIR/hooks/pre-commit" ${1+"$@"}
-:
-
diff --git a/templates/blt/hooks/pre-commit b/templates/blt/hooks/pre-commit
deleted file mode 100644
--- a/templates/blt/hooks/pre-commit
+++ /dev/null
@@ -1,61 +0,0 @@
-#!/bin/sh
-#
-# An example hook script to verify what is about to be committed.
-# Called by git-commit-script with no arguments.  The hook should
-# exit with non-zero status after issuing an appropriate message if
-# it wants to stop the commit.
-#
-# To enable this hook, make this file executable.
-
-# This is slightly modified from Andrew Morton's Perfect Patch.
-# Lines you introduce should not have trailing whitespace.
-# Also check for an indentation that has SP before a TAB.
-perl -e '
-    my $fh;
-    my $found_bad = 0;
-    my $filename;
-    my $reported_filename = "";
-    my $lineno;
-    sub bad_line {
-	my ($why, $line) = @_;
-	if (!$found_bad) {
-	    print STDERR "*\n";
-	    print STDERR "* You have some suspicious patch lines:\n";
-	    print STDERR "*\n";
-	    $found_bad = 1;
-	}
-	if ($reported_filename ne $filename) {
-	    print STDERR "* In $filename\n";
-	    $reported_filename = $filename;
-	}
-	print STDERR "* $why (line $lineno)\n";
-	print STDERR "$filename:$lineno:$line\n";
-    }
-    open $fh, "-|", qw(git-diff-cache -p -M --cached HEAD);
-    while (<$fh>) {
-	if (m|^diff --git a/(.*) b/\1$|) {
-	    $filename = $1;
-	    next;
-	}
-	if (/^@@ -\S+ \+(\d+)/) {
-	    $lineno = $1 - 1;
-	    next;
-	}
-	if (/^ /) {
-	    $lineno++;
-	    next;
-	}
-	if (s/^\+//) {
-	    $lineno++;
-	    chomp;
-	    if (/\s$/) {
-		bad_line("trailing whitespace", $_);
-	    }
-	    if (/^\s* 	/) {
-		bad_line("indent SP followed by a TAB", $_);
-	    }
-	}
-    }
-    exit($found_bad);
-'
-
diff --git a/templates/blt/hooks/update b/templates/blt/hooks/update
deleted file mode 100644
--- a/templates/blt/hooks/update
+++ /dev/null
@@ -1,27 +0,0 @@
-#!/bin/sh
-#
-# An example hook script to mail out commit update information.
-# Called by git-receive-pack with arguments: refname sha1-old sha1-new
-#
-# To enable this hook:
-# (1) change the recipient e-mail address
-# (2) make this file executable by "chmod +x update".
-#
-
-recipient="commit-list@mydomain.xz"
-
-if expr "$2" : '0*$' >/dev/null
-then
-	echo "Created a new ref, with the following commits:"
-	git-rev-list --pretty "$3"
-else
-	$base=$(git-merge-base "$2" "$3")
-	if [ $base == "$2" ]; then
-		echo "New commits:"
-	else
-		echo "Rebased ref, commits from common ancestor:"
-fi
-git-rev-list --pretty "$3" "^$base"
-fi |
-mail -s "Changes to ref $1" "$recipient"
-exit 0
diff --git a/templates/blt/info/exclude b/templates/blt/info/exclude
deleted file mode 100644
--- a/templates/blt/info/exclude
+++ /dev/null
@@ -1,6 +0,0 @@
-# git-ls-files --others --exclude-from=.git/info/exclude
-# Lines that start with '#' are comments.
-# For a project mostly in C, the following would be a good set of
-# exclude patterns (uncomment them if you want to use them):
-# *.[oa]
-# *~



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
