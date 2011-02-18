From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/3] compat: do not use relative paths to refer to
 git-compat-util.h et al
Date: Thu, 17 Feb 2011 22:32:31 -0600
Message-ID: <20110218043231.GD15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <20110218023750.GD23435@elie>
 <AANLkTi=VhJi4eDrtRPHukckQKo9TYCcnh1_u0_tnv24z@mail.gmail.com>
 <20110218042916.GC15643@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:32:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqI1K-0000la-Tk
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab1BREci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:32:38 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37237 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1BREcg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:32:36 -0500
Received: by iwn9 with SMTP id 9so3248778iwn.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 20:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=izgmZfiQXSGuFEzXvqd2uYXHj38YRBjm1pWJdVhn3D4=;
        b=ClscU986SD3v4RPGh7sIbXfY4CuNxYSU6fSE+27hpSiUoBK5Mt16SH5BwuOf6E8klS
         b9tDhxxzRrtGdh7i0b9ojC2LA3eXZ1Qq4PDB4ALVUnaS/GvHBafCvim+X2BooQxa6GuL
         Jo8Gq8HQLgB/ywOhqeRPHHd9dovec1u/5w194=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q+jh1Hw0/WkjjSAajUTw+fwGFW7LLXosrG2OPp7kFaufTIxOQAqo4J4H8f2dDICqgw
         uzD7sO3J4dzmnL36Ld3/2SIxRleNcmKS57J/MJGQYv6WQ6v1EUv/CBd+TO+20KWd4+YF
         lcFnC92RTnocHahZJD1aPkEHaz396eOEFYPC0=
Received: by 10.231.17.205 with SMTP id t13mr196583iba.80.1298003556130;
        Thu, 17 Feb 2011 20:32:36 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.sbcglobal.net [69.209.72.148])
        by mx.google.com with ESMTPS id z4sm1333989ibg.19.2011.02.17.20.32.34
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 20:32:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218042916.GC15643@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167167>

Constructs like '#include "../cache.h"' referring to the toplevel of
the git sources from a subdirectory make it hard to move files around.
Luckily "cache.h" works from any directory because the Makefile
supplies -I. in BASIC_CFLAGS explicitly.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 compat/basename.c      |    2 +-
 compat/cygwin.c        |    4 ++--
 compat/fopen.c         |    2 +-
 compat/inet_ntop.c     |    2 +-
 compat/inet_pton.c     |    2 +-
 compat/memmem.c        |    2 +-
 compat/mingw.c         |    4 ++--
 compat/mkdtemp.c       |    2 +-
 compat/mmap.c          |    2 +-
 compat/msvc.c          |    4 ++--
 compat/pread.c         |    2 +-
 compat/qsort.c         |    2 +-
 compat/setenv.c        |    2 +-
 compat/snprintf.c      |    2 +-
 compat/strcasestr.c    |    2 +-
 compat/strlcpy.c       |    2 +-
 compat/strtok_r.c      |    2 +-
 compat/strtoumax.c     |    2 +-
 compat/unsetenv.c      |    2 +-
 compat/win32/dirent.c  |    2 +-
 compat/win32/pthread.c |    2 +-
 compat/win32/syslog.c  |    4 ++--
 compat/win32mmap.c     |    2 +-
 compat/winansi.c       |    2 +-
 24 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/compat/basename.c b/compat/basename.c
index d8f8a3c..4382378 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 /* Adapted from libiberty's basename.c.  */
 char *gitbasename (char *path)
diff --git a/compat/cygwin.c b/compat/cygwin.c
index b4a51b9..23c5138 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,7 +1,7 @@
 #define WIN32_LEAN_AND_MEAN
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
+#include "cache.h" /* to read configuration */
 #include "win32.h"
-#include "../cache.h" /* to read configuration */
 
 static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
 {
diff --git a/compat/fopen.c b/compat/fopen.c
index b5ca142..e777c44 100644
--- a/compat/fopen.c
+++ b/compat/fopen.c
@@ -9,7 +9,7 @@
  *  fopen after including git-compat-util.h is inadequate in this case.
  */
 #undef FREAD_READS_DIRECTORIES
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 FILE *git_fopen(const char *path, const char *mode)
 {
diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index ea249c6..d2c2b48 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 #include <stdio.h>
 #include <string.h>
diff --git a/compat/inet_pton.c b/compat/inet_pton.c
index 2ec995e..8ff1d9d 100644
--- a/compat/inet_pton.c
+++ b/compat/inet_pton.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <sys/types.h>
 
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 #include <stdio.h>
 #include <string.h>
diff --git a/compat/memmem.c b/compat/memmem.c
index 56bcb42..2df3e7b 100644
--- a/compat/memmem.c
+++ b/compat/memmem.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 void *gitmemmem(const void *haystack, size_t haystack_len,
                 const void *needle, size_t needle_len)
diff --git a/compat/mingw.c b/compat/mingw.c
index bee6054..e43bba3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,7 +1,7 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
 #include "win32.h"
 #include <conio.h>
-#include "../strbuf.h"
 
 int err_win_to_posix(DWORD winerr)
 {
diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
index 1136119..4349e15 100644
--- a/compat/mkdtemp.c
+++ b/compat/mkdtemp.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 char *gitmkdtemp(char *template)
 {
diff --git a/compat/mmap.c b/compat/mmap.c
index c9d46d1..a62533e 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
diff --git a/compat/msvc.c b/compat/msvc.c
index 71843d7..e55b546 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -1,6 +1,6 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
 #include "win32.h"
 #include <conio.h>
-#include "../strbuf.h"
 
 #include "mingw.c"
diff --git a/compat/pread.c b/compat/pread.c
index 978cac4..429f7dd 100644
--- a/compat/pread.c
+++ b/compat/pread.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
 {
diff --git a/compat/qsort.c b/compat/qsort.c
index d93dce2..a490959 100644
--- a/compat/qsort.c
+++ b/compat/qsort.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 /*
  * A merge sort implementation, simplified from the qsort implementation
diff --git a/compat/setenv.c b/compat/setenv.c
index 3a22ea7..bf1016f 100644
--- a/compat/setenv.c
+++ b/compat/setenv.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 int gitsetenv(const char *name, const char *value, int replace)
 {
diff --git a/compat/snprintf.c b/compat/snprintf.c
index e1e0e75..376eeff 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 /*
  * The size parameter specifies the available space, i.e. includes
diff --git a/compat/strcasestr.c b/compat/strcasestr.c
index 26896de..d666093 100644
--- a/compat/strcasestr.c
+++ b/compat/strcasestr.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 char *gitstrcasestr(const char *haystack, const char *needle)
 {
diff --git a/compat/strlcpy.c b/compat/strlcpy.c
index 4024c36..780b39f 100644
--- a/compat/strlcpy.c
+++ b/compat/strlcpy.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 size_t gitstrlcpy(char *dest, const char *src, size_t size)
 {
diff --git a/compat/strtok_r.c b/compat/strtok_r.c
index 7b5d568..6eec7f8 100644
--- a/compat/strtok_r.c
+++ b/compat/strtok_r.c
@@ -17,7 +17,7 @@
    Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA.  */
 
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 /* Parse S into tokens separated by characters in DELIM.
    If S is NULL, the saved pointer in SAVE_PTR is used as
diff --git a/compat/strtoumax.c b/compat/strtoumax.c
index 5541353..50fe26d 100644
--- a/compat/strtoumax.c
+++ b/compat/strtoumax.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 uintmax_t gitstrtoumax (const char *nptr, char **endptr, int base)
 {
diff --git a/compat/unsetenv.c b/compat/unsetenv.c
index eb29f5e..8f38d37 100644
--- a/compat/unsetenv.c
+++ b/compat/unsetenv.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 void gitunsetenv (const char *name)
 {
diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index 7a0debe..038188e 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 #include "dirent.h"
 
 struct DIR {
diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 010e875..3b1f381 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -7,7 +7,7 @@
  * no need for double-checking.
  */
 
-#include "../../git-compat-util.h"
+#include "git-compat-util.h"
 #include "pthread.h"
 
 #include <errno.h>
diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 42b95a9..9c4c8e2 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -1,5 +1,5 @@
-#include "../../git-compat-util.h"
-#include "../../strbuf.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
 
 static HANDLE ms_eventlog;
 
diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index b58aa69..756fe8a 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
diff --git a/compat/winansi.c b/compat/winansi.c
index dedce21..82a5d9c 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -2,7 +2,7 @@
  * Copyright 2008 Peter Harris <git@peter.is-a-geek.org>
  */
 
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 /*
  Functions to be wrapped:
-- 
1.7.4.1
