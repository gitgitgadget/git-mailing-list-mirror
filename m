From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH v2 1/7] autoconf: GIT_CONF_APPEND_LINE: change signature
Date: Thu, 19 Jul 2012 09:49:56 +0200
Message-ID: <bed901f25e6e9b6c6c3e5b9e13fc1e3605ce08ef.1342683786.git.stefano.lattarini@gmail.com>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
 <cover.1342683786.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:50:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlVE-0006oN-Qf
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab2GSHuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:50:18 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44410 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab2GSHuP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:50:15 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2137707bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=yzmc43qdbN2T0+ky2XiqMzsB97o5IkgIXVhRyfvttdk=;
        b=tSrTOJgCMEGTq0FNw0P+FhwL4EgNHDHR8zZCUTk671ZV0RwGmqcYtRQB08UnlLToAd
         eYhWCBEb+N7/HCglHYyzVBtW2adRQ/YkHn20YhJWMGxp0W10ns6c8YPUvQlJP5BTXkf0
         cwRZv9biawbfIbxCczOj7HrZ1x2xWbY7SOHRZNTzm5NUTs6HIjsyRssF68DkO6kAXB8s
         TpnTYr+D0TZVNTFFnDaq3LJJBmn+D05xQSY04OzQ4ZLX4gTToJMuq63RP5KsUtl5Dyy8
         hKiLyCUl0/sFrkXvz2YZMAB7IojoXWV2yMTf9aftUdvdNnoxwczReguyKmfUIsgZtTkp
         Ki7w==
Received: by 10.204.148.86 with SMTP id o22mr290509bkv.59.1342684215088;
        Thu, 19 Jul 2012 00:50:15 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id c18sm430224bkv.8.2012.07.19.00.50.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:50:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
References: <cover.1342683786.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201720>

From:

   GIT_CONF_APPEND_LINE([VAR=VAL])

to:

   GIT_CONF_APPEND_LINE([VAR], [VAL])

This is only a preparatory change in view of future refactorings.
No semantic change is intended.  In fact, the generated configure
file doesn't change at all.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4e9012f..5f63269 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,11 +3,11 @@
 
 ## Definitions of private macros.
 
-# GIT_CONF_APPEND_LINE(LINE)
-# --------------------------
-# Append LINE to file ${config_append}
+# GIT_CONF_APPEND_LINE(VAL, VAR)
+# ------------------------------
+# Append the line "VAR=VAL" to file ${config_append}
 AC_DEFUN([GIT_CONF_APPEND_LINE],
-         [echo "$1" >> "${config_append}"])
+         [echo "$1=$2" >> "${config_append}"])
 
 # GIT_ARG_SET_PATH(PROGRAM)
 # -------------------------
@@ -34,8 +34,8 @@ AC_DEFUN([GIT_CONF_APPEND_PATH],
 	if test -n "$2"; then
 		GIT_UC_PROGRAM[]_PATH=$withval
 		AC_MSG_NOTICE([Disabling use of ${PROGRAM}])
-		GIT_CONF_APPEND_LINE(NO_${PROGRAM}=YesPlease)
-		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=)
+		GIT_CONF_APPEND_LINE([NO_${PROGRAM}], [YesPlease])
+		GIT_CONF_APPEND_LINE([${PROGRAM}_PATH], [])
 	else
 		AC_MSG_ERROR([You cannot use git without $1])
 	fi
@@ -45,7 +45,7 @@ AC_DEFUN([GIT_CONF_APPEND_PATH],
 	else
 		GIT_UC_PROGRAM[]_PATH=$withval
 		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval])
-		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=$withval)
+		GIT_CONF_APPEND_LINE([${PROGRAM}_PATH], [$withval])
 	fi
     fi
     m4_popdef([GIT_UC_PROGRAM])])
@@ -67,7 +67,7 @@ AC_DEFUN([GIT_PARSE_WITH],
 	NO_[]GIT_UC_PACKAGE=
 	GIT_UC_PACKAGE[]DIR=$withval
 	AC_MSG_NOTICE([Setting GIT_UC_PACKAGE[]DIR to $withval])
-	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=$withval)
+	GIT_CONF_APPEND_LINE([${PACKAGE}DIR], [$withval])
     fi
     m4_popdef([GIT_UC_PACKAGE])])
 
@@ -87,7 +87,7 @@ AC_DEFUN([GIT_PARSE_WITH_SET_MAKE_VAR],
 		     [a value for $1 ($2).  Maybe you do...?])
   fi
   AC_MSG_NOTICE([Setting $2 to $withval])
-  GIT_CONF_APPEND_LINE($2=$withval)
+  GIT_CONF_APPEND_LINE([$2], [$withval])
  fi)])# GIT_PARSE_WITH_SET_MAKE_VAR
 
 #
@@ -150,7 +150,7 @@ AC_ARG_WITH([sane-tool-path],
   else
     AC_MSG_NOTICE([Setting SANE_TOOL_PATH to '$withval'])
   fi
-  GIT_CONF_APPEND_LINE([SANE_TOOL_PATH=$withval])],
+  GIT_CONF_APPEND_LINE([SANE_TOOL_PATH], [$withval])],
   [# If the "--with-sane-tool-path" option was not given, don't touch
    # SANE_TOOL_PATH here, but let defaults in Makefile take care of it.
    # This should minimize spurious differences in the behaviour of the
@@ -169,7 +169,7 @@ AC_ARG_WITH([lib],
   else
 	lib=$withval
 	AC_MSG_NOTICE([Setting lib to '$lib'])
-	GIT_CONF_APPEND_LINE(lib=$withval)
+	GIT_CONF_APPEND_LINE([lib], [$withval])
   fi])
 
 if test -z "$lib"; then
@@ -205,7 +205,7 @@ AC_ARG_ENABLE([jsmin],
 [
   JSMIN=$enableval;
   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
-  GIT_CONF_APPEND_LINE(JSMIN=$enableval);
+  GIT_CONF_APPEND_LINE([JSMIN], [$enableval]);
 ])
 
 # Define option to enable CSS minification
@@ -215,7 +215,7 @@ AC_ARG_ENABLE([cssmin],
 [
   CSSMIN=$enableval;
   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifying])
-  GIT_CONF_APPEND_LINE(CSSMIN=$enableval);
+  GIT_CONF_APPEND_LINE([CSSMIN], [$enableval]);
 ])
 
 ## Site configuration (override autodetection)
@@ -256,7 +256,7 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
 	USE_LIBPCRE=YesPlease
 	LIBPCREDIR=$withval
 	AC_MSG_NOTICE([Setting LIBPCREDIR to $withval])
-	GIT_CONF_APPEND_LINE(LIBPCREDIR=$withval)
+	GIT_CONF_APPEND_LINE([LIBPCREDIR], [$withval])
     fi)
 #
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
-- 
1.7.10.2.1067.g553d16e
