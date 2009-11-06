From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 11/12] Basic build infrastructure for Python scripts
Date: Fri,  6 Nov 2009 23:52:45 +0100
Message-ID: <1257547966-14603-12-git-send-email-srabbelier@gmail.com>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-2-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-5-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-10-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-11-git-send-email-srabbelier@gmail.com>
Cc: Johan Herland <johan@herland.net>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 23:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Xi8-00008E-F6
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 23:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbZKFWxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 17:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbZKFWxr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 17:53:47 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:18980 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453AbZKFWxn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 17:53:43 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1151eyd.5
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 14:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=J85SrjR5GPqoezme3fLxNvAiMtcKiIsfei/0d3/1pXo=;
        b=eQBtlnvn0e2UaMc7ebBB++DIbt/KRR3XoxrJn7xULHWW57K7JbHgif0fExqZZW8LIF
         mgJaV2ugYMXTzWQlrLBK5b108LYOY2ekAdJJqaGIHaJgDIQDG8p2L+ZxYvCLXnGEuECx
         5HDaEFPBKZnDWmnnOfiEZhWlFNRYWFFAu4gDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IlqfYyHV+55vtwE/c2oxPv5VWsCCZQO8CJiOTLGSbuyGvYLamdP13WghybVWJOsEnX
         epCY4FkjHPNzyuGG6MydC249pPJ+EW0N4TMreSsIJJcxXcRvtacxJzbjOE9RyrBBz8xI
         /OSMYIlw/M9Whwniruv48JLsNIE2170Z0T1PQ=
Received: by 10.213.23.137 with SMTP id r9mr24487ebb.34.1257548027629;
        Fri, 06 Nov 2009 14:53:47 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 7sm1501175eyb.40.2009.11.06.14.53.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 14:53:46 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.158.g6dacb
In-Reply-To: <1257547966-14603-11-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132335>

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
index 5d5976f..6d1593f 100644
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
1.6.5.2.158.g6dacb
