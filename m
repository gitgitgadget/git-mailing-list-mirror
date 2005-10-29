From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: [PATCH] Add to usage and docs for git-add.sh
Date: Sat, 29 Oct 2005 17:46:41 -0400
Message-ID: <11306224011312-git-send-email-c.shoemaker@cox.net>
References: <11306224012707-git-send-email-c.shoemaker@cox.net>
Reply-To: Chris Shoemaker <c.shoemaker@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 29 23:47:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVyXR-0008II-Hy
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 23:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVJ2Vqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 17:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVJ2Vqp
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 17:46:45 -0400
Received: from eastrmmtao01.cox.net ([68.230.240.38]:7833 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932239AbVJ2Vqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 17:46:43 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029214610.CXS13165.eastrmmtao01.cox.net@localhost>;
          Sat, 29 Oct 2005 17:46:10 -0400
Received: from [127.0.0.1] (helo=pe)
	by localhost with smtp (Exim 4.43)
	id 1EVyXB-0006Wc-Ev; Sat, 29 Oct 2005 17:46:41 -0400
In-Reply-To: <11306224012707-git-send-email-c.shoemaker@cox.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10809>

Signed-off-by: Chris Shoemaker <c.shoemaker@cox.net>

---

 Documentation/git-add.txt |    9 ++++++++-
 git-add.sh                |    7 +++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

2bc166e3e8241432b88ff793ec69a979a7056b3e
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -7,7 +7,7 @@ git-add - Add files to the cache.
 
 SYNOPSIS
 --------
-'git-add' <file>...
+'git-add' [-n] [-v] <file>...
 
 DESCRIPTION
 -----------
@@ -19,6 +19,13 @@ OPTIONS
 <file>...::
 	Files to add to the cache.
 
+-n::
+        Don't actually add the file(s), just show if they exist.
+
+-v::
+        Be verbose.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/git-add.sh b/git-add.sh
--- a/git-add.sh
+++ b/git-add.sh
@@ -1,5 +1,9 @@
 #!/bin/sh
 
+usage() {
+    die "usage: git add [-n] [-v] <file>..."
+}
+
 show_only=
 verbose=
 while : ; do
@@ -10,6 +14,9 @@ while : ; do
     -v)
 	verbose=--verbose
 	;;
+    -*)
+	usage
+	;;
     *)
 	break
 	;;
