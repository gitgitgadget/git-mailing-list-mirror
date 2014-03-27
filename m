From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Thu, 27 Mar 2014 18:22:50 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140327142250.GC17333@mini.zxlink>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
 <CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
 <CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com>
 <20140228170012.GA5247@tugrik.mns.mnsspb.ru>
 <CABPQNSYnDjhxjpyZQkNP_qwect_tnPvJ_nEfGSq9qnYFMpehWg@mail.gmail.com>
 <20140305093151.GA3994@tugrik.mns.mnsspb.ru>
 <xmqq1txrp8ur.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>, kirr@mns.spb.ru
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 15:19:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTB9d-0004dH-Bn
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 15:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743AbaC0OTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 10:19:33 -0400
Received: from forward7l.mail.yandex.net ([84.201.143.140]:51863 "EHLO
	forward7l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbaC0OTc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 10:19:32 -0400
Received: from smtp8.mail.yandex.net (smtp8.mail.yandex.net [77.88.61.54])
	by forward7l.mail.yandex.net (Yandex) with ESMTP id 8E6CCBC0F4D;
	Thu, 27 Mar 2014 18:19:28 +0400 (MSK)
Received: from smtp8.mail.yandex.net (localhost [127.0.0.1])
	by smtp8.mail.yandex.net (Yandex) with ESMTP id 547ED1B60085;
	Thu, 27 Mar 2014 18:19:27 +0400 (MSK)
Received: from unknown (unknown [93.185.17.156])
	by smtp8.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Z2Sbcfb6lO-JL8iPqTb;
	Thu, 27 Mar 2014 18:19:23 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 2a437f15-105d-4652-b34c-84b17b05db05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1395929966; bh=Jard3xNU/RyReQIIqu7xvGiwFyxeW1KFaqaAJPHyXHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:Organization:
	 User-Agent;
	b=dww2cdCIGen8Ai99D8P2y8f3g+sJYiP1MYEDPifqhcDn9RSdQb6sKvKGBMBxSj4Ni
	 kHJcykOSSEFyqHUcnpuxYcZ0qQVoNBhGUumC3LAOH1UcvEUn38ltYPO+3vVzYqlqsc
	 m+xpI/gbecRmtd7DIHhu1AigR6o0z7/FGr8pLv38=
Authentication-Results: smtp8.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WTBCk-0005V0-TM; Thu, 27 Mar 2014 18:22:50 +0400
Content-Disposition: inline
In-Reply-To: <xmqq1txrp8ur.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245280>

On Mon, Mar 24, 2014 at 02:47:24PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > On Fri, Feb 28, 2014 at 06:19:58PM +0100, Erik Faye-Lund wrote:
> >> On Fri, Feb 28, 2014 at 6:00 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> >> ...
> >> > In fact that would be maybe preferred, for maintainers to enable alloca
> >> > with knowledge and testing, as one person can't have them all at hand.
> >> 
> >> Yeah, you're probably right.
> >
> > Erik, the patch has been merged into pu today. Would you please
> > follow-up with tested MINGW change?
> 
> Sooo.... I lost track but this discussion seems to have petered out
> around here.  I think the copy we have had for a while on 'pu' is
> basically sound, and can easily built on by platform folks by adding
> or removing the -DHAVE_ALLOCA_H from the Makefile.

Yes, that is all correct - that version works and we can improve it in
the future with platform-specific follow-up patches, if needed.

Please pick up the patch with ack from Thomas Schwinge.

Thanks,
Kirill

(please keep author email)
---- 8< ----
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Mon, 24 Feb 2014 20:21:49 +0400
Subject: [PATCH v1a] Portable alloca for Git

In the next patch we'll have to use alloca() for performance reasons,
but since alloca is non-standardized and is not portable, let's have a
trick with compatibility wrappers:

1. at configure time, determine, do we have working alloca() through
   alloca.h, and define

    #define HAVE_ALLOCA_H

   if yes.

2. in code

    #ifdef HAVE_ALLOCA_H
    # include <alloca.h>
    # define xalloca(size)      (alloca(size))
    # define xalloca_free(p)    do {} while(0)
    #else
    # define xalloca(size)      (xmalloc(size))
    # define xalloca_free(p)    (free(p))
    #endif

   and use it like

   func() {
       p = xalloca(size);
       ...

       xalloca_free(p);
   }

This way, for systems, where alloca is available, we'll have optimal
on-stack allocations with fast executions. On the other hand, on
systems, where alloca is not available, this gracefully fallbacks to
xmalloc/free.

Both autoconf and config.mak.uname configurations were updated. For
autoconf, we are not bothering considering cases, when no alloca.h is
available, but alloca() works some other way - its simply alloca.h is
available and works or not, everything else is deep legacy.

For config.mak.uname, I've tried to make my almost-sure guess for where
alloca() is available, but since I only have access to Linux it is the
only change I can be sure about myself, with relevant to other changed
systems people Cc'ed.

NOTE

SunOS and Windows had explicit -DHAVE_ALLOCA_H in their configurations.
I've changed that to now-common HAVE_ALLOCA_H=YesPlease which should be
correct.

Cc: Brandon Casey <drafnel@gmail.com>
Cc: Marius Storm-Olsen <mstormo@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Gerrit Pape <pape@smarden.org>
Cc: Petr Salinger <Petr.Salinger@seznam.cz>
Cc: Jonathan Nieder <jrnieder@gmail.com>
Cc: Thomas Schwinge <tschwinge@gnu.org>
Acked-by: Thomas Schwinge <thomas@codesourcery.com> (GNU Hurd changes)
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Changes since v1:

 - added ack for GNU/Hurd.

 Makefile          |  6 ++++++
 config.mak.uname  | 10 ++++++++--
 configure.ac      |  8 ++++++++
 git-compat-util.h |  8 ++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index dddaf4f..0334806 100644
--- a/Makefile
+++ b/Makefile
@@ -30,6 +30,8 @@ all::
 # Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+# Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
+#
 # Define NO_CURL if you do not have libcurl installed.  git-http-fetch and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports (neither smart nor dumb).
@@ -1099,6 +1101,10 @@ ifdef USE_LIBPCRE
 	EXTLIBS += -lpcre
 endif
 
+ifdef HAVE_ALLOCA_H
+	BASIC_CFLAGS += -DHAVE_ALLOCA_H
+endif
+
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 	REMOTE_CURL_PRIMARY =
diff --git a/config.mak.uname b/config.mak.uname
index 7d31fad..71602ee 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -28,6 +28,7 @@ ifeq ($(uname_S),OSF1)
 	NO_NSEC = YesPlease
 endif
 ifeq ($(uname_S),Linux)
+	HAVE_ALLOCA_H = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
@@ -35,6 +36,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_DEV_TTY = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
+	HAVE_ALLOCA_H = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
@@ -103,6 +105,7 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
 	SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
+	HAVE_ALLOCA_H = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
@@ -146,7 +149,7 @@ ifeq ($(uname_S),SunOS)
 	endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
-	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H
+	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
 endif
 ifeq ($(uname_O),Cygwin)
 	ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
@@ -166,6 +169,7 @@ ifeq ($(uname_O),Cygwin)
 	else
 		NO_REGEX = UnfortunatelyYes
 	endif
+	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
@@ -239,6 +243,7 @@ ifeq ($(uname_S),AIX)
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
+	HAVE_ALLOCA_H = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
@@ -316,6 +321,7 @@ endif
 ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
+	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
@@ -363,7 +369,7 @@ ifeq ($(uname_S),Windows)
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
 	PTHREAD_LIBS =
diff --git a/configure.ac b/configure.ac
index 2f43393..0eae704 100644
--- a/configure.ac
+++ b/configure.ac
@@ -272,6 +272,14 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
 #
+# Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
+AC_FUNC_ALLOCA
+case $ac_cv_working_alloca_h in
+    yes)    HAVE_ALLOCA_H=YesPlease;;
+    *)      HAVE_ALLOCA_H='';;
+esac
+GIT_CONF_SUBST([HAVE_ALLOCA_H])
+#
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..63b2b3b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -526,6 +526,14 @@ extern void release_pack_memory(size_t);
 typedef void (*try_to_free_t)(size_t);
 extern try_to_free_t set_try_to_free_routine(try_to_free_t);
 
+#ifdef HAVE_ALLOCA_H
+# include <alloca.h>
+# define xalloca(size)      (alloca(size))
+# define xalloca_free(p)    do {} while (0)
+#else
+# define xalloca(size)      (xmalloc(size))
+# define xalloca_free(p)    (free(p))
+#endif
 extern char *xstrdup(const char *str);
 extern void *xmalloc(size_t size);
 extern void *xmallocz(size_t size);
-- 
1.9.rc0.143.g6fd479e
