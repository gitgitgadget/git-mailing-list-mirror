From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/9] Add a sample user for the svndump library
Date: Thu, 24 Jun 2010 06:07:52 -0500
Message-ID: <20100624110752.GI12376@burratino>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 13:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORkI1-0000FO-QX
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 13:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab0FXLIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 07:08:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56798 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab0FXLIF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 07:08:05 -0400
Received: by vws9 with SMTP id 9so2322762vws.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 04:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6aw/LzE1X7Ip5q/vB+RvfL/KIZduhznkasSZ1p3C2Aw=;
        b=SzP3VQrdx2cb8U6ScT/ErlAQk581ZKaOlktakpRPe5uVzeFb45Hm5WVOzVkCXEFnvu
         je9r+Dg4Wi5+MnPtt2BuVU1xng8HKTJwMrAzPZdqFj5B65gTjUiARR/bMdCED9N8tGME
         E1Hh91IBgDvZLhK+3iAHm+h8zGhZoyUpEP42c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hwv+wpe/7VOgVn4mIRNDXzXrHBkqG8JEEjMFG13KaPZ6px+oCMwPgEUAcZ6wYaAReW
         yZZH3SRaexZBskYd1R2PpkaiAAAn08r34KPUVaf8SI0ifeUKN+vw4x2x7+1mVTzZ9BlG
         TTWma6j/sGb1B+hMEUPGzyxrk2VqHoaQrPRd0=
Received: by 10.229.213.136 with SMTP id gw8mr5170515qcb.193.1277377682292;
        Thu, 24 Jun 2010 04:08:02 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u6sm40944653ibu.12.2010.06.24.04.08.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 04:08:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624105004.GA12336@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149580>

The svn-fe tool takes a Subversion dump file as input and produces
a fast-import stream as output.  This can be useful as a low-level
tool in building other importers, or for debugging the vcs-svn
library.

 make svn-fe
 make svn-fe.1

to test.

NEEDSWORK: litters cwd with useless .bin files.
But I hope it is enough to show the idea.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.  Thoughts welcome.

 contrib/svn-fe/.gitignore |    3 ++
 contrib/svn-fe/Makefile   |   63 +++++++++++++++++++++++++++++++++++++++++++++
 contrib/svn-fe/svn-fe.c   |   43 ++++++++++++++++++++++++++++++
 contrib/svn-fe/svn-fe.txt |   56 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+), 0 deletions(-)
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
index 0000000..d84dd4f
--- /dev/null
+++ b/contrib/svn-fe/svn-fe.c
@@ -0,0 +1,43 @@
+/*
+ * Parse and rearrange a svnadmin dump.
+ * Create the dump with:
+ * svnadmin dump --incremental -r<startrev>:<endrev> <repository> >outfile
+ *
+ * Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice(s), this list of conditions and the following disclaimer
+ *    unmodified other than the allowable addition of one or more
+ *    copyright notices.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice(s), this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+ * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <stdlib.h>
+#include "../../vcs-svn/svndump.h"
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
index 0000000..bfd3a68
--- /dev/null
+++ b/contrib/svn-fe/svn-fe.txt
@@ -0,0 +1,56 @@
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
+Converts a textual representation of a Subversion repository into
+input suitable for git-fast-import(1) and similar importers.
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
+SEE ALSO
+--------
+git-svn(1), svn2git(1), svk(1), git-filter-branch(1), git-fast-import(1),
+https://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
-- 
1.7.1
