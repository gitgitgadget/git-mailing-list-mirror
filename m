From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/2] Brief documentation for the mysterious git-am script
Date: Fri, 21 Oct 2005 02:28:42 +0200
Message-ID: <20051021002842.26819.56707.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 02:29:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESkm8-0003b1-OK
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVJUA2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVJUA2q
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:28:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58505 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964816AbVJUA2p (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:28:45 -0400
Received: (qmail 26839 invoked from network); 21 Oct 2005 02:28:43 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 21 Oct 2005 02:28:43 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10394>

The git-am script is nowhere called and nowhere (including itself)
explained, and the name isn't helpful either. For those like me who will
wonder what is it about, add some documentation stub for it to the
documentation.

I probably got something wrong and I don't feel like investigating all the
options - this is just kind of "emergency" docs.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-am.txt        |   51 +++++++++++++++++++++++++++++++++++++++
 Documentation/git-applymbox.txt |    2 +-
 git-applymbox.sh                |    2 ++
 3 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
new file mode 100644
index 0000000..c73a8c5
--- /dev/null
+++ b/Documentation/git-am.txt
@@ -0,0 +1,51 @@
+git-am(1)
+================
+
+NAME
+----
+git-am - Apply a series of patches in a mailbox
+
+
+SYNOPSIS
+--------
+'git-am' [--signoff] [--dotest=<dir>] [--utf8] [--3way] <mbox>
+'git-am' [--skip]
+
+DESCRIPTION
+-----------
+Splits mail messages in a mailbox into commit log message,
+authorship information and patches, and applies them to the
+current branch.
+
+This is the replacement for the 'git-applymbox' script.
+Unlike git-applymbox, it can take more than one mailbox file from
+the command line, as well as reading from the standard input when
+'-' is specified. Other differences include changed parameter names
+and less descriptive command name.
+
+
+When initially invoking it, you give it name of the mailbox to crunch.
+The usage hints that it might get interrupted and you will want to
+resume the last round of applying - to do that, pass it no mailbox
+name, and optionally the mysterious '--skip' parameter.
+
+
+SEE ALSO
+--------
+gitlink:git-applymbox[1], gitlink:git-applypatch[1].
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by Petr Baudis, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+This manual page is a stub. You can help the git documentation by expanding it.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Documentation/git-applymbox.txt b/Documentation/git-applymbox.txt
index 8f01ca6..f74c6a4 100644
--- a/Documentation/git-applymbox.txt
+++ b/Documentation/git-applymbox.txt
@@ -75,7 +75,7 @@ OPTIONS
 
 SEE ALSO
 --------
-gitlink:git-applypatch[1].
+gitlink:git-am[1], gitlink:git-applypatch[1].
 
 
 Author
diff --git a/git-applymbox.sh b/git-applymbox.sh
index 4e77132..6de6932 100755
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -15,6 +15,8 @@
 ## Pay a special attention to the commit log message if you do this and
 ## use a Signoff_file, because applypatch wants to append the sign-off
 ## message to msg-clean every time it is run.
+##
+## git-am is supposed to be the newer and better tool for this job.
 
 . git-sh-setup || die "Not a git archive"
 
