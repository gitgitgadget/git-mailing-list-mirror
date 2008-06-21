From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] api-builtin.txt: update and fix typo
Date: Sun, 22 Jun 2008 01:54:36 +0200
Message-ID: <1214092476-8049-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 01:56:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KACwV-0001AG-EM
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 01:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYFUXyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYFUXyw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 19:54:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:41875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751641AbYFUXyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 19:54:51 -0400
Received: (qmail invoked by alias); 21 Jun 2008 23:54:49 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp066) with SMTP; 22 Jun 2008 01:54:49 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+WxDt6/PWWsDo98Uvx6RMqozswPZbE73jhRCdD5o
	MCJtr6oGnszRo/
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KACui-00026C-9j; Sun, 22 Jun 2008 01:54:36 +0200
X-Mailer: git-send-email 1.5.6.310.g344d
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85739>

Mention NEED_WORK_TREE flag and command-list.txt.
Fix "bulit-in" typo and AsciiDoc-formatting of a paragraph.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Documentation/technical/api-builtin.txt |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index 52cdb4c..7ede1e6 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -4,7 +4,7 @@ builtin API
 Adding a new built-in
 ---------------------
 
-There are 4 things to do to add a bulit-in command implementation to
+There are 4 things to do to add a built-in command implementation to
 git:
 
 . Define the implementation of the built-in command `foo` with
@@ -18,8 +18,8 @@ git:
   defined in `git.c`.  The entry should look like:
 
 	{ "foo", cmd_foo, <options> },
-
-  where options is the bitwise-or of:
++
+where options is the bitwise-or of:
 
 `RUN_SETUP`::
 
@@ -33,6 +33,12 @@ git:
 	If the standard output is connected to a tty, spawn a pager and
 	feed our output to it.
 
+`NEED_WORK_TREE`::
+
+	Make sure there is a work tree, i.e. the command cannot act
+	on bare repositories.
+	This makes only sense when `RUN_SETUP` is also set.
+
 . Add `builtin-foo.o` to `BUILTIN_OBJS` in `Makefile`.
 
 Additionally, if `foo` is a new command, there are 3 more things to do:
@@ -41,8 +47,7 @@ Additionally, if `foo` is a new command, there are 3 more things to do:
 
 . Write documentation in `Documentation/git-foo.txt`.
 
-. Add an entry for `git-foo` to the list at the end of
-  `Documentation/cmd-list.perl`.
+. Add an entry for `git-foo` to `command-list.txt`.
 
 
 How a built-in is called
-- 
1.5.6.310.g344d
