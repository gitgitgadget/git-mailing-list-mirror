From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/4] autoconf: Typo cleanup, reordering etc.
Date: Fri,  4 Aug 2006 17:55:58 +0200
Message-ID: <11547069591326-git-send-email-jnareb@gmail.com>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 04 17:56:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G922L-0007FZ-4Q
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 17:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161271AbWHDP4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 11:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWHDP4N
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 11:56:13 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:64932 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1161268AbWHDP4J (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 11:56:09 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k74Ft7LO029220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Aug 2006 17:55:07 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k74FtxIN018891;
	Fri, 4 Aug 2006 17:55:59 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k74Ftxpa018890;
	Fri, 4 Aug 2006 17:55:59 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24798>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Makefile     |    2 +-
 configure.ac |   43 +++++++++++++++++++++++--------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index d662bd6..c6b62d9 100644
--- a/Makefile
+++ b/Makefile
@@ -22,7 +22,7 @@ #
 # Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
 # do not support the 'size specifiers' introduced by C99, namely ll, hh,
 # j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).
-# some c compilers supported these specifiers prior to C99 as an extension.
+# some C compilers supported these specifiers prior to C99 as an extension.
 #
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
diff --git a/configure.ac b/configure.ac
index 1796cf4..a88219a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -51,7 +51,7 @@ fi; \
 ## Site configuration
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 #
-# Define NO_SVN_TESTS if you want to skip time-consuming SVN interopability
+# Define NO_SVN_TESTS if you want to skip time-consuming SVN interoperability
 # tests.  These tests take up a significant amount of the total test time
 # but are not needed unless you plan to talk to SVN repos.
 #
@@ -81,7 +81,24 @@ # not built, and you cannot push using h
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
-# Define NO_PYTHON if you want to loose all benefits of the recursive merge.
+# Define SHELL_PATH to provide path to shell.
+GIT_ARG_SET_PATH(shell)
+#
+# Define PERL_PATH to provide path to Perl.
+GIT_ARG_SET_PATH(perl)
+#
+# Define NO_PYTHON if you want to lose all benefits of the recursive merge.
+# Define PYTHON_PATH to provide path to Python.
+AC_ARG_WITH(python,[AS_HELP_STRING([--with-python=PATH], [provide PATH to python])
+AS_HELP_STRING([--no-python], [don't use python scripts])],
+ [if test "$withval" = "no"; then \
+    NO_PYTHON=YesPlease; \
+  elif test "$withval" != "yes"; then \
+    PYTHON_PATH=$withval; \
+  fi; \
+ ])
+AC_SUBST(NO_PYTHON)
+AC_SUBST(PYTHON_PATH)
 #
 ## --enable-FEATURE[=ARG] and --disable-FEATURE
 # Define COLLISION_CHECK below if you believe that SHA1's
@@ -101,27 +118,13 @@ # change being considered an inode chang
 ## Checks for programs.
 AC_MSG_NOTICE([CHECKS for programs])
 #
-GIT_ARG_SET_PATH(shell)
-GIT_ARG_SET_PATH(perl)
-AC_ARG_WITH(python,[AS_HELP_STRING([--with-python=PATH], [provide PATH to python])
-AS_HELP_STRING([--no-python], [don't use python scripts])],
- [if test "$withval" = "no"; then \
-    NO_PYTHON=YesPlease; \
-  elif test "$withval" != "yes"; then \
-    PYTHON_PATH=$withval; \
-  fi; \
- ])
-AC_SUBST(NO_PYTHON)
-AC_SUBST(PYTHON_PATH)
-
-
-#
-# Define NO_PYTHON if you want to lose all benefits of the recursive merge.
-# Define PYTHON_PATH to provide path to Python.
 AC_PROG_CC
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOL(AR, ar, :)
 AC_CHECK_PROGS(TAR, [gtar tar])
+#
+# Define NO_PYTHON if you want to lose all benefits of the recursive merge.
+# Define PYTHON_PATH to provide path to Python.
 if test -z "$NO_PYTHON"; then
 	AC_PATH_PROGS(PYTHON_PATH, [python2.4 python2.3 python2 python])
 	if test -n "$PYTHON_PATH"; then
@@ -194,7 +197,7 @@ # Define NO_C99_FORMAT if your formatted
 # do not support the 'size specifiers' introduced by C99, namely ll, hh,
 # j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).
 # some C compilers supported these specifiers prior to C99 as an extension.
-AC_CACHE_CHECK(whether IO functions support %ll %hh %j %z %t size specifiers,
+AC_CACHE_CHECK(whether formatted IO functions support C99 size specifiers,
  ac_cv_c_c99_format,
 [# Actually git uses only %z (%zu) in alloc.c, and %t (%td) in mktag.c
 AC_RUN_IFELSE(
-- 
1.4.1.1
