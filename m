From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 11/12] Basic build infrastructure for Python scripts
Date: Wed, 18 Nov 2009 02:42:31 +0100
Message-ID: <1258508552-20752-12-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-6-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-7-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-8-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-9-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-10-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-11-git-send-email-srabbelier@gmail.com>
Cc: Johan Herland <johan@herland.net>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZar-0000vW-Od
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbZKRBnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756845AbZKRBnk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:40 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60684 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721AbZKRBni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:38 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so622806bwz.21
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jmFUIR8pIpGj9C3E7bzb6sta17IDihzA5mqJHfYeDf4=;
        b=fI8Jg451qw1WCCH3ypZOw1E/CiLWhFaVUP9CYfDQgx0jmmGgMc5/z3L4a7mcpC2lAS
         ZWo2fzEVichGprhpyN7tJliUOE+y9qpQccYryH9TqUx0uISr8PRs9EqK9ZZqxqTp26ls
         +G1R+P4GCrHA02BxgxuUH6PsofL7Y03BXZTC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jJ4iFW8WawrcwwG15ztOKw7NcbnJ8oiw4PyFLc3G9EsxSk2CN+zyxeYm1StL+OU/kC
         oBExnIfQqfMFSJLnuC8eniOR3ZOjijDJ4hJlLLFt1qEo5dHiOOmTHphO4uUDkp3mgemG
         VglDz7/9rciWPXR9WYvltMxW4dCbG4p9cXowY=
Received: by 10.216.88.8 with SMTP id z8mr2457wee.109.1258508623892;
        Tue, 17 Nov 2009 17:43:43 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:43 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-11-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133129>

From: Johan Herland <johan@herland.net>

This patch adds basic boilerplate support (based on corresponding Perl
sections) for enabling the building and installation Python scripts.

There are currently no Python scripts being built, and when Python
scripts are added in future patches, their building and installation
can be disabled by defining NO_PYTHON.

Signed-off-by: Johan Herland <johan@herland.net>
---

	Unchanged.

 Makefile      |   13 +++++++++++++
 configure.ac  |    3 +++
 t/test-lib.sh |    1 +
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 35f5294..ed027df 100644
--- a/Makefile
+++ b/Makefile
@@ -168,6 +168,8 @@ all::
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
+# Define NO_PYTHON if you do not want Python scripts or libraries at all.
+#
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
 # The TCL_PATH variable governs the location of the Tcl interpreter
@@ -312,6 +314,7 @@ LIB_H =
 LIB_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
+SCRIPT_PYTHON =
 SCRIPT_SH =
 TEST_PROGRAMS =
 
@@ -349,6 +352,7 @@ SCRIPT_PERL += git-svn.perl
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
+	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-instaweb
 
 # Empty...
@@ -402,8 +406,12 @@ endif
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
+ifndef PYTHON_PATH
+	PYTHON_PATH = /usr/bin/python
+endif
 
 export PERL_PATH
+export PYTHON_PATH
 
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
@@ -1315,6 +1323,10 @@ ifeq ($(PERL_PATH),)
 NO_PERL=NoThanks
 endif
 
+ifeq ($(PYTHON_PATH),)
+NO_PYTHON=NoThanks
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -1362,6 +1374,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
diff --git a/configure.ac b/configure.ac
index b09b8e4..84b6cf4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -233,6 +233,9 @@ GIT_ARG_SET_PATH(shell)
 # Define PERL_PATH to provide path to Perl.
 GIT_ARG_SET_PATH(perl)
 #
+# Define PYTHON_PATH to provide path to Python.
+GIT_ARG_SET_PATH(python)
+#
 # Define ZLIB_PATH to provide path to zlib.
 GIT_ARG_SET_PATH(zlib)
 #
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2ca536..0b991db 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -729,6 +729,7 @@ case $(uname -s) in
 esac
 
 test -z "$NO_PERL" && test_set_prereq PERL
+test -z "$NO_PYTHON" && test_set_prereq PYTHON
 
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
-- 
1.6.5.3.164.g07b0c
