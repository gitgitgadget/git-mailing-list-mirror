From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Add a sample user for the svndump library
Date: Thu, 15 Jul 2010 18:25:39 +0200
Message-ID: <1279211139-8629-2-git-send-email-artagnon@gmail.com>
References: <1279211139-8629-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 15 18:24:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZREL-0007bQ-8p
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 18:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933708Ab0GOQX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 12:23:58 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51317 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933694Ab0GOQXz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 12:23:55 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so288033ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=24pmlNu16rU/s5kL8kQ6Md3VRCD4cd5xVRuxpLcEHYQ=;
        b=DjKCN/Wxc9TTGsT3V8vaTx2XcU5SpYAmmkIgu9S03Nld6FtPEQ7TMAmjJs2HXa/5Ln
         +OBvNp/qPiJWCaO27USsU4WujUvhIBOG7/Ae+tCaG9XBY4DzXowENyN/z07dgtssVSLy
         JXY/e/LQlrMpQZpPspR6qOODhQuwvs/WwKX7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bbST7IQu5o7+u7pRdWdho2XfyYJQkGbdIc0U0NIxE/vAzG+Yt+rwvSPz3ps9+6P4ST
         SS9PdZ/6REXpgB+W6D8jJxsxEQvsxf8D9d7t0TqMdpCFNynoozylTVyludUKxoIu1R8j
         2wQl9M2uQE3gLh9yFHIZj5lvzgxD0n4LhvzGI=
Received: by 10.213.19.7 with SMTP id y7mr3046816eba.25.1279211034494;
        Thu, 15 Jul 2010 09:23:54 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id v8sm9428163eeh.2.2010.07.15.09.23.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 09:23:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279211139-8629-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151096>

From: Jonathan Nieder <jrnieder@gmail.com>

The svn-fe tool takes a Subversion dump file as input and produces
a fast-import stream as output.  This can be useful as a low-level
tool in building other importers, or for debugging the vcs-svn
library.

 make svn-fe
 make svn-fe.1

to test.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/svn-fe/.gitignore |    3 ++
 contrib/svn-fe/Makefile   |   63 ++++++++++++++++++++++++++++++++++++++++++
 contrib/svn-fe/svn-fe.c   |   15 ++++++++++
 contrib/svn-fe/svn-fe.txt |   66 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 contrib/svn-fe/.gitignore
 create mode 100644 contrib/svn-fe/Makefile
 create mode 100644 contrib/svn-fe/svn-fe.c
 create mode 100644 contrib/svn-fe/svn-fe.txt

diff --git a/contrib/svn-fe/.gitignore b/contrib/svn-fe/.gitignore
new file mode 100644
index 0000000..27a33b6
--- /dev/null
+++ b/contrib/svn-fe/.gitignore
@@ -0,0 +1,3 @@
+/*.xml
+/*.1
+/*.html
diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
new file mode 100644
index 0000000..4cc8d15
--- /dev/null
+++ b/contrib/svn-fe/Makefile
@@ -0,0 +1,63 @@
+all:: svn-fe$X
+
+CC = gcc
+RM = rm -f
+MV = mv
+
+CFLAGS = -g -O2 -Wall
+LDFLAGS =
+ALL_CFLAGS = $(CFLAGS)
+ALL_LDFLAGS = $(LDFLAGS)
+EXTLIBS =
+
+GIT_LIB = ../../libgit.a
+VCSSVN_LIB = ../../vcs-svn/lib.a
+LIBS = $(VCSSVN_LIB) $(GIT_LIB) $(EXTLIBS)
+
+QUIET_SUBDIR0 = +$(MAKE) -C # space to separate -C and subdir
+QUIET_SUBDIR1 =
+
+ifneq ($(findstring $(MAKEFLAGS),w),w)
+PRINT_DIR = --no-print-directory
+else # "make -w"
+NO_SUBDIR = :
+endif
+
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifndef V
+	QUIET_CC      = @echo '   ' CC $@;
+	QUIET_LINK    = @echo '   ' LINK $@;
+	QUIET_SUBDIR0 = +@subdir=
+	QUIET_SUBDIR1 = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+	                $(MAKE) $(PRINT_DIR) -C $$subdir
+endif
+endif
+
+svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
+		$(ALL_LDFLAGS) $(LIBS)
+
+svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+
+svn-fe.html: svn-fe.txt
+	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/svn-fe/svn-fe.txt \
+		../contrib/svn-fe/$@
+
+svn-fe.1: svn-fe.txt
+	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/svn-fe/svn-fe.txt \
+		../contrib/svn-fe/$@
+	$(MV) ../../Documentation/svn-fe.1 .
+
+../../vcs-svn/lib.a: FORCE
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) vcs-svn/lib.a
+
+../../libgit.a: FORCE
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) libgit.a
+
+clean:
+	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
+
+.PHONY: all clean FORCE
diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
new file mode 100644
index 0000000..43c4320
--- /dev/null
+++ b/contrib/svn-fe/svn-fe.c
@@ -0,0 +1,15 @@
+/*
+ * This file is in the public domain.
+ * You may freely use, modify, distribute, and relicense it.
+ */
+
+#include <stdlib.h>
+#include "vcs-svn/svndump.h"
+
+int main(int argc, char **argv)
+{
+	svndump_init(NULL);
+	svndump_read((argc > 1) ? argv[1] : NULL);
+	svndump_reset();
+	return 0;
+}
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
new file mode 100644
index 0000000..de30f83
--- /dev/null
+++ b/contrib/svn-fe/svn-fe.txt
@@ -0,0 +1,66 @@
+svn-fe(1)
+=========
+
+NAME
+----
+svn-fe - convert an SVN "dumpfile" to a fast-import stream
+
+SYNOPSIS
+--------
+svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
+
+DESCRIPTION
+-----------
+
+Converts a Subversion dumpfile (version: 2) into input suitable for
+git-fast-import(1) and similar importers. REPO is a path to a
+Subversion repository mirrored on the local disk. Remote Subversion
+repositories can be mirrored on local disk using the `svnsync`
+command.
+
+INPUT FORMAT
+------------
+Subversion's repository dump format is documented in full in
+`notes/dump-load-format.txt` from the Subversion source tree.
+Files in this format can be generated using the 'svnadmin dump' or
+'svk admin dump' command.
+
+OUTPUT FORMAT
+-------------
+The fast-import format is documented by the git-fast-import(1)
+manual page.
+
+NOTES
+-----
+Subversion dumps do not record a separate author and committer for
+each revision, nor a separate display name and email address for
+each author.  Like git-svn(1), 'svn-fe' will use the name
+
+---------
+user <user@UUID>
+---------
+
+as committer, where 'user' is the value of the `svn:author` property
+and 'UUID' the repository's identifier.
+
+To support incremental imports, 'svn-fe' will put a `git-svn-id`
+line at the end of each commit log message if passed an url on the
+command line.  This line has the form `git-svn-id: URL@REVNO UUID`.
+
+Empty directories and unknown properties are silently discarded.
+
+The resulting repository will generally require further processing
+to put each project in its own repository and to separate the history
+of each branch.  The 'git filter-branch --subdirectory-filter' command
+may be useful for this purpose.
+
+BUGS
+----
+Litters the current working directory with .bin files for
+persistence. Will be fixed when the svn-fe infrastructure is aware of
+a Git working directory.
+
+SEE ALSO
+--------
+git-svn(1), svn2git(1), svk(1), git-filter-branch(1), git-fast-import(1),
+https://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
-- 
1.7.1
