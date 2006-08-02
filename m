From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] autoconf: Move site configuration section earlier in configure.ac
Date: Thu, 3 Aug 2006 00:38:56 +0200
Message-ID: <200608030038.56322.jnareb@gmail.com>
References: <200608030036.56298.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 03 00:40:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8POB-000679-5v
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 00:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWHBWk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWHBWk2
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 18:40:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:44600 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932293AbWHBWk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 18:40:27 -0400
Received: by nf-out-0910.google.com with SMTP id o25so783661nfa
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 15:40:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WWBGMFgl371BFurPxIfXtGXXOEAp1iclhwCtITcb5+Oz5kQPveDcDsvu+M55cGXxKNjjIPH+99vimW65nHlyZ43nH69XeM4vlAXSF5dSvqM8ovf6qfd7wpd+NzuIBSnTXUC8XOX28+adlsAJO+aHZA+gjQhLxakcSoYQ4Q6OZJY=
Received: by 10.49.75.2 with SMTP id c2mr2970623nfl;
        Wed, 02 Aug 2006 15:40:26 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id m15sm151205nfc.2006.08.02.15.40.25;
        Wed, 02 Aug 2006 15:40:25 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608030036.56298.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24695>

Move site configuration section, i.e. --with-PACKAGE[=ARG] and
--without-PACKAGE, --enable-FEATURE[=ARG] and --disable-FEATURE
options to the beginning of configure.ac file, just after definitions
of macros.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |  100 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4688e97..73e12d3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -48,6 +48,56 @@ fi; \
 ]) # GIT_CONF_APPEND_PATH
 
 
+## Site configuration
+## --with-PACKAGE[=ARG] and --without-PACKAGE
+#
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
+
 ## Checks for programs.
 AC_MSG_NOTICE([CHECKS for programs])
 #
@@ -155,56 +205,6 @@ # Define NO_ACCURATE_DIFF if your diff p
 # a missing newline at the end of the file.
 
 
-## Site configuration
-## --with-PACKAGE[=ARG] and --without-PACKAGE
-#
-# Define NO_SVN_TESTS if you want to skip time-consuming SVN interopability
-# tests.  These tests take up a significant amount of the total test time
-# but are not needed unless you plan to talk to SVN repos.
-#
-# Define MOZILLA_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
-# on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
-# choice) has very fast version optimized for i586.
-#
-# Define PPC_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for PowerPC.
-#
-# Define ARM_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for ARM.
-#
-# Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies MOZILLA_SHA1.
-#
-# Define NO_CURL if you do not have curl installed.  git-http-pull and
-# git-http-push are not built, and you cannot use http:// and https://
-# transports.
-#
-# Define CURLDIR=/foo/bar if your curl header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
-#
-# Define NO_EXPAT if you do not have expat installed.  git-http-push is
-# not built, and you cannot push using http:// and https:// transports.
-#
-# Define NO_MMAP if you want to avoid mmap.
-#
-# Define NO_PYTHON if you want to loose all benefits of the recursive merge.
-#
-## --enable-FEATURE[=ARG] and --disable-FEATURE
-# Define COLLISION_CHECK below if you believe that SHA1's
-# 1461501637330902918203684832716283019655932542976 hashes do not give you
-# sufficient guarantee that no collisions between objects will ever happen.
-#
-# Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
-# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
-# randomly break unless your underlying filesystem supports those sub-second
-# times (my ext3 doesn't).
-#
-# Define USE_STDEV below if you want git to care about the underlying device
-# change being considered an inode change from the update-cache perspective.
-
-
 ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
 AC_OUTPUT
-- 
1.4.1.1
