From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 3] Copy description of build configuration variables to configure.ac
Date: Sat,  8 Jul 2006 23:07:08 +0200
Message-ID: <11523928361444-git-send-email-jnareb@gmail.com>
References: <200607030156.50455.jnareb@gmail.com> <1152392835436-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 08 23:07:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzK1T-0003iK-8u
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 23:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWGHVH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 17:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWGHVH2
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 17:07:28 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:60097 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030384AbWGHVH0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 17:07:26 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k68L6nVT021745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jul 2006 23:06:49 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k68L7Gkb015573;
	Sat, 8 Jul 2006 23:07:16 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k68L7GbS015572;
	Sat, 8 Jul 2006 23:07:16 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1152392835436-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23503>

Copy description of build configuration variables from the commentary
in the top Makefile (from 'next' branch) to configure.ac, splitting
them into "autoconf" sections.

This is to be able to easily check which build/install configuration
variables are covered by current configure.ac

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Please correct this if you feel that some variable was put in wrong
section in configure.ac

 configure.ac |  114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 113 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index cecdbe5..6fe5013 100644
--- a/configure.ac
+++ b/configure.ac
@@ -9,6 +9,118 @@ AC_CONFIG_SRCDIR([git.c])
 config_file=config.mak.autogen
 config_in=config.mak.in
 
-# Output files
+
+## Checks for programs.
+# Define NO_PYTHON if you want to loose all benefits of the recursive merge.
+
+
+## Checks for libraries.
+# Define NO_OPENSSL environment variable if you do not have OpenSSL.
+# This also implies MOZILLA_SHA1.
+#
+# Define NO_CURL if you do not have curl installed.  git-http-pull and
+# git-http-push are not built, and you cannot use http:// and https://
+# transports.
+#
+# Define NO_EXPAT if you do not have expat installed.  git-http-push is
+# not built, and you cannot push using http:// and https:// transports.
+#
+# Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
+#
+# Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
+#
+# Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
+# Patrick Mauritz).
+
+
+## Checks for header files.
+
+
+## Checks for typedefs, structures, and compiler characteristics.
+# Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
+#
+# Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
+# d_type in struct dirent (latest Cygwin -- will be fixed soonish).
+#
+# Define NO_SOCKADDR_STORAGE if your platform does not have struct
+# sockaddr_storage.
+
+
+## Checks for library functions.
+# Define NO_STRCASESTR if you don't have strcasestr.
+#
+# Define NO_STRLCPY if you don't have strlcpy.
+#
+# Define NO_SETENV if you don't have setenv in the C library.
+#
+# Define NO_MMAP if you want to avoid mmap.
+#
+# Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
+#
+# Define NO_ICONV if your libc does not properly support iconv.
+
+
+## Other checks.
+# Define USE_PIC if you need the main git objects to be built with -fPIC
+# in order to build and link perl/Git.so.  x86-64 seems to need this.
+#
+# Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
+# Enable it on Windows.  By default, symrefs are still used.
+#
+# Define WITH_OWN_SUBPROCESS_PY if you want to use with python 2.3.
+#
+# Define NO_ACCURATE_DIFF if your diff program at least sometimes misses
+# a missing newline at the end of the file.
+
+
+## Site configuration 
+## --with-PACKAGE[=ARG] and --without-PACKAGE
+# Define NO_SVN_TESTS if you want to skip time-consuming SVN interopability
+# tests.  These tests take up a significant amount of the total test time
+# but are not needed unless you plan to talk to SVN repos.
+#
+# Define MOZILLA_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
+# on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
+# choice) has very fast version optimized for i586.
+#
+# Define PPC_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine optimized for PowerPC.
+#
+# Define ARM_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine optimized for ARM.
+#
+# Define NO_OPENSSL environment variable if you do not have OpenSSL.
+# This also implies MOZILLA_SHA1.
+#
+# Define NO_CURL if you do not have curl installed.  git-http-pull and
+# git-http-push are not built, and you cannot use http:// and https://
+# transports.
+#
+# Define CURLDIR=/foo/bar if your curl header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
+#
+# Define NO_EXPAT if you do not have expat installed.  git-http-push is
+# not built, and you cannot push using http:// and https:// transports.
+#
+# Define NO_MMAP if you want to avoid mmap.
+#
+# Define NO_PYTHON if you want to loose all benefits of the recursive merge.
+#
+## --enable-FEATURE[=ARG] and --disable-FEATURE
+# Define COLLISION_CHECK below if you believe that SHA1's
+# 1461501637330902918203684832716283019655932542976 hashes do not give you
+# sufficient guarantee that no collisions between objects will ever happen.
+#
+# Define USE_NSEC below if you want git to care about sub-second file mtimes
+# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
+# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
+# randomly break unless your underlying filesystem supports those sub-second
+# times (my ext3 doesn't).
+#
+# Define USE_STDEV below if you want git to care about the underlying device
+# change being considered an inode change from the update-cache perspective.
+
+## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}"]) 
 AC_OUTPUT
-- 
1.4.0
