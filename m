From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make NO_PTHREADS the sole thread configuration variable
Date: Sun, 31 Jan 2010 11:52:21 -0800
Message-ID: <7vsk9mcaru.fsf@alter.siamese.dyndns.org>
References: <1264814539-27209-1-git-send-email-dpmcgee@gmail.com>
 <7vwryzqyjb.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001302015120.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 20:52:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbfqX-0006hR-AO
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 20:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab0AaTwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 14:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640Ab0AaTwb
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 14:52:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab0AaTwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 14:52:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFDB895736;
	Sun, 31 Jan 2010 14:52:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4OU5p7F9c38s31PqLKumqb7BA48=; b=RdM/Q/
	nnqWJF9mWMnUqcBd+n8NYYJUjyljgwDiZlgdZoAdgRreloe+3uh9uLJS8/P1MXTh
	+ahLvUSdTSNbs54Hg716UNFUA0kzpkrM8NVHfUvtexBjGP2pepwztzsYCbi3Kn82
	NjDoloKVqIEFCnlbOXrNzO/Almmx9F0+aMaGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cFJj53kmK8dX7kRV9sPhnD0D/KLVJ6Pb
	Nl4ImoFxQgEVAixNtt42xSLVnA/ageloC0ryyjz3Ry11hd3eRrcaZ5hmSL2Tyo27
	1tBOl6bvxUD6fJrDgaDFYb3rC95Kwfzr3urexjZhCyTIk5ll/ZdJ8j0tJodMzO1y
	x5/uW4Ap2hE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF37B95735;
	Sun, 31 Jan 2010 14:52:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88E2E95734; Sun, 31 Jan
 2010 14:52:22 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001302015120.1681@xanadu.home> (Nicolas
 Pitre's message of "Sat\, 30 Jan 2010 20\:29\:28 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 283BB9A6-0EA2-11DF-987E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138556>

Nicolas Pitre <nico@fluxnic.net> writes:

> Simply mentioning in the 1.7.0 
> release notes that THREADED_DELTA_SEARCH is no more should be fine.  

Ok; here is what I'll queue.

Thanks, both.

-- >8 --
From: Dan McGee <dpmcgee@gmail.com>
Date: Fri, 29 Jan 2010 19:22:19 -0600
Subject: [PATCH] Make NO_PTHREADS the sole thread configuration variable

When the first piece of threaded code was introduced in commit 8ecce684, it
came with its own THREADED_DELTA_SEARCH Makefile option. Since this time,
more threaded code has come into the codebase and a NO_PTHREADS option has
also been added. Get rid of the original option as the newer, more generic
option covers everything we need.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes-1.7.0.txt |    3 +++
 Makefile                         |   24 ++----------------------
 builtin-pack-objects.c           |   12 ++++++------
 config.mak.in                    |    1 -
 configure.ac                     |    9 ++-------
 5 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-1.7.0.txt
index 997b026..45ac906 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -175,6 +175,9 @@ Updates since v1.6.6
 
  * Many more commands are now built-in.
 
+ * THREADED_DELTA_SEARCH is no more.  If you build with threads, delta
+   compression will always take advantage of it.
+
 Fixes since v1.6.6
 ------------------
 
diff --git a/Makefile b/Makefile
index af08c8f..83383c3 100644
--- a/Makefile
+++ b/Makefile
@@ -180,9 +180,6 @@ all::
 # If not set it defaults to the bare 'wish'. If it is set to the empty
 # string then NO_TCLTK will be forced (this is used by configure script).
 #
-# Define THREADED_DELTA_SEARCH if you have pthreads and wish to exploit
-# parallel delta searching when packing objects.
-#
 # Define INTERNAL_QSORT to use Git's implementation of qsort(), which
 # is a simplified version of the merge sort used in glibc. This is
 # recommended if Git triggers O(n^2) behavior in your platform's qsort().
@@ -722,12 +719,10 @@ EXTLIBS =
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
@@ -781,7 +776,6 @@ ifeq ($(uname_S),Darwin)
 		NO_STRLCPY = YesPlease
 	endif
 	NO_MEMMEM = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
@@ -794,7 +788,6 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease
@@ -850,7 +843,6 @@ ifeq ($(uname_S),FreeBSD)
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	USE_ST_TIMESPEC = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
 		PTHREAD_LIBS = -pthread
 		NO_UINTMAX_T = YesPlease
@@ -864,7 +856,6 @@ ifeq ($(uname_S),OpenBSD)
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),NetBSD)
 	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
@@ -872,7 +863,6 @@ ifeq ($(uname_S),NetBSD)
 	endif
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
-	THREADED_DELTA_SEARCH = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	NO_MKSTEMPS = YesPlease
 endif
@@ -887,9 +877,7 @@ ifeq ($(uname_S),AIX)
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease
 	BASIC_CFLAGS += -D_LARGE_FILES
-	ifneq ($(shell expr "$(uname_V)" : '[1234]'),1)
-		THREADED_DELTA_SEARCH = YesPlease
-	else
+	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
 		NO_PTHREADS = YesPlease
 	endif
 endif
@@ -915,7 +903,6 @@ ifeq ($(uname_S),IRIX)
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH = /usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),IRIX64)
 	NO_SETENV=YesPlease
@@ -934,7 +921,6 @@ ifeq ($(uname_S),IRIX64)
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),HP-UX)
 	NO_IPV6=YesPlease
@@ -984,7 +970,6 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -1036,7 +1021,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
-	THREADED_DELTA_SEARCH = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
@@ -1334,16 +1318,12 @@ ifdef RUNTIME_PREFIX
 endif
 
 ifdef NO_PTHREADS
-	THREADED_DELTA_SEARCH =
 	BASIC_CFLAGS += -DNO_PTHREADS
 else
 	EXTLIBS += $(PTHREAD_LIBS)
-endif
-
-ifdef THREADED_DELTA_SEARCH
-	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
 	LIB_OBJS += thread-utils.o
 endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b0887d7..4a41547 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -17,7 +17,7 @@
 #include "progress.h"
 #include "refs.h"
 
-#ifdef THREADED_DELTA_SEARCH
+#ifndef NO_PTHREADS
 #include "thread-utils.h"
 #include <pthread.h>
 #endif
@@ -1255,7 +1255,7 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 	return 0;
 }
 
-#ifdef THREADED_DELTA_SEARCH
+#ifndef NO_PTHREADS
 
 static pthread_mutex_t read_mutex;
 #define read_lock()		pthread_mutex_lock(&read_mutex)
@@ -1380,7 +1380,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	/*
 	 * Handle memory allocation outside of the cache
 	 * accounting lock.  Compiler will optimize the strangeness
-	 * away when THREADED_DELTA_SEARCH is not defined.
+	 * away when NO_PTHREADS is defined.
 	 */
 	free(trg_entry->delta_data);
 	cache_lock();
@@ -1567,7 +1567,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 	free(array);
 }
 
-#ifdef THREADED_DELTA_SEARCH
+#ifndef NO_PTHREADS
 
 /*
  * The main thread waits on the condition that (at least) one of the workers
@@ -1899,7 +1899,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		if (delta_search_threads < 0)
 			die("invalid number of threads specified (%d)",
 			    delta_search_threads);
-#ifndef THREADED_DELTA_SEARCH
+#ifdef NO_PTHREADS
 		if (delta_search_threads != 1)
 			warning("no threads support, ignoring %s", k);
 #endif
@@ -2227,7 +2227,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			delta_search_threads = strtoul(arg+10, &end, 0);
 			if (!arg[10] || *end || delta_search_threads < 0)
 				usage(pack_usage);
-#ifndef THREADED_DELTA_SEARCH
+#ifdef NO_PTHREADS
 			if (delta_search_threads != 1)
 				warning("no threads support, "
 					"ignoring %s", arg);
diff --git a/config.mak.in b/config.mak.in
index 67b12f7..6008ac9 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -56,5 +56,4 @@ NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
 FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
 NO_PTHREADS=@NO_PTHREADS@
-THREADED_DELTA_SEARCH=@THREADED_DELTA_SEARCH@
 PTHREAD_LIBS=@PTHREAD_LIBS@
diff --git a/configure.ac b/configure.ac
index 78345eb..229140e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -762,10 +762,9 @@ AC_SUBST(NO_MKSTEMPS)
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
-# Define NO_PTHREADS if we do not have pthreads
+# Define NO_PTHREADS if we do not have pthreads.
 #
-# Define PTHREAD_LIBS to the linker flag used for Pthread support and define
-# THREADED_DELTA_SEARCH if Pthreads are available.
+# Define PTHREAD_LIBS to the linker flag used for Pthread support.
 AC_DEFUN([PTHREADTEST_SRC], [
 #include <pthread.h>
 
@@ -782,7 +781,6 @@ dnl   [[pthread_mutex_t test_mutex;]]
 dnl )])
 
 NO_PTHREADS=UnfortunatelyYes
-THREADED_DELTA_SEARCH=
 PTHREAD_LIBS=
 
 if test -n "$USER_NOPTHREAD"; then
@@ -798,7 +796,6 @@ elif test -z "$PTHREAD_CFLAGS"; then
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
 		PTHREAD_LIBS="$opt"
-		THREADED_DELTA_SEARCH=YesPlease
 		break
 	],
 	[AC_MSG_RESULT([no])])
@@ -812,7 +809,6 @@ else
 	[AC_MSG_RESULT([yes])
 		NO_PTHREADS=
 		PTHREAD_LIBS="$PTHREAD_CFLAGS"
-		THREADED_DELTA_SEARCH=YesPlease
 	],
 	[AC_MSG_RESULT([no])])
 
@@ -823,7 +819,6 @@ CFLAGS="$old_CFLAGS"
 
 AC_SUBST(PTHREAD_LIBS)
 AC_SUBST(NO_PTHREADS)
-AC_SUBST(THREADED_DELTA_SEARCH)
 
 ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
-- 
1.7.0.rc1.141.gd3fd2
