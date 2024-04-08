Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A022091
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591510; cv=none; b=gdZ3b6xrRN5g1DQ1E1+zvUlZd92mXCRF2S1fImUqX2NYIA5vMU/gN4urx0vFXhVdsHRcSXsFqBpkG1rjn2Rj79L50p19GpyZMrd2DFN7aV1c7E9RqTrs6D95p5MAvQZjw0YEKT9b8UWmLzAix6moogVEDxwMVFPOBrfAMgcHN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591510; c=relaxed/simple;
	bh=UEQhJNiBez31hFSyqqrTd16AR5H1tJz+N4vmbOpSvZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GETRsEM9sijxZtZ5e03rAxI0+lxZ2jdzt7rJMiC37ibT6D6gbuD+M6tpFZwJxReat9Ho8lLA9vygaMXl2t6gHWeduNSJd/Pzrmw5q2jtkKAoYmcapW0nQtsbQwkAq5yvaMxCzEnSCt4L9eQdr7HvDkgomXOZRjDQx0nMq6rLIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=owxetOWw; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="owxetOWw"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4752124276.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712591507; x=1713196307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k52BqYLCSppGX3XixPWj8vGSOwNqhLv0F9Tq8OMDzfI=;
        b=owxetOWwVtc/6xtdzPIWk/O58MRH6cwH4ixxROdd4jRYplszWmJt+T+0/6jUXs2lOE
         hrEUplSpynn1iw/Qb/sboma8BZL6oLgpY1Xzr8BpaE9LWZLe6jCttE9Z1oyT9rud5dMc
         UeGdQQtCpiPKZORiYA8OdJQZlE/oqfYyTm6Uc6/wKO0hpspyICwY3xXTMoVlvw9MTNaV
         jAjOGjeQ0DNBiVNXBdNzeQHFWvu9E9FosBsdIg2BESojJopF9pkWoCDJFkgSy+405xAM
         NB9JgJrnzB5tUHUd5jjXTZWeNbyyglrv7U3OKgpblklzj+LfA+Xz8WKZh2YF6ELFim6y
         OOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591507; x=1713196307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k52BqYLCSppGX3XixPWj8vGSOwNqhLv0F9Tq8OMDzfI=;
        b=QR7DPO2UCKV2tY4kiDKzmBs6oQMKbyOusKcV+hqi/fWeYifLrmiX7aJ9msVAdNYDUR
         QPLwIJkHq/GBKEweHS2+KTdtPwiFFXWNOlWl/fTmif/0T1HPsgb46Q5DXq+f1d4MaEo3
         Hhg75pj/jBhTInGdzJ4uPCyAoQiGfrJsuH6Z6jIuc2vSMStXmp+q6HTHAuImplLued+Q
         xODy2kgE3NwhfXqpabdg4kDgmaWetUIhVzbOyfk5GgGe3PeHdCFCDOlopUYoM2yJrzFL
         xgGoq+JGfTByr2drIIWlUH2BMRsg83XUOcQsx7f8TQfRIkFWH0c8byjEIAHUDhvueCJK
         HJhA==
X-Gm-Message-State: AOJu0YxQlGlOTyrOKmg6ba8bpZ797wgEIaV3ecbKu4ak5vahMa+F4MWZ
	QBgK5ZTY64YHyIt1JNAbL1tZaTEHeGRwn5SsfJgVa2VCT4XWIZGnjzrsaHGHmPmRVg1b437Vgf/
	QagI=
X-Google-Smtp-Source: AGHT+IEysyRiUe3uu6N4VUr7+qzc4BKLran1UeK1tbdVlu7hofwmcy6zbN8cqy3nGOFLOAuiTKka1Q==
X-Received: by 2002:a25:e094:0:b0:dcc:9e88:b15 with SMTP id x142-20020a25e094000000b00dcc9e880b15mr7214483ybg.41.1712591506887;
        Mon, 08 Apr 2024 08:51:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bb6-20020a05622a1b0600b0042f43a486c9sm3776085qtb.77.2024.04.08.08.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:51:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:51:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Dario Gjorgjevski <dario.gjorgjevski@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile(s): avoid recipe prefix in conditional statements
Message-ID: <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
References: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>

In GNU Make commit 07fcee35 ([SV 64815] Recipe lines cannot contain
conditional statements, 2023-05-22) and following, conditional
statements may no longer be preceded by a tab character (which Make
refers to as the recipe prefix).

There are a handful of spots in our various Makefile(s) which will break
in a future release of Make containing 07fcee35. For instance, trying to
compile the pre-image of this patch with the tip of make.git results in
the following:

    $ make -v | head -1 && make
    GNU Make 4.4.90
    config.mak.uname:842: *** missing 'endif'.  Stop.

The kernel addressed this issue in 82175d1f9430 (kbuild: Replace tabs
with spaces when followed by conditionals, 2024-01-28). Address the
issues in Git's tree by applying the same strategy.

When a conditional word (ifeq, ifneq, ifdef, etc.) is preceded by one or
more tab characters, replace each tab character with 8 space characters
with the following:

    find . -type f -not -path './.git/*' -name Makefile -or -name '*.mak' |
      xargs perl -i -pe '
        s/(\t+)(ifn?eq|ifn?def|else|endif)/" " x (length($1) * 8) . $2/ge unless /\\$/
      '

The "unless /\\$/" removes any false-positives (like "\telse \"
appearing within a shell script as part of a recipe).

After doing so, Git compiles on newer versions of Make:

    $ make -v | head -1 && make
    GNU Make 4.4.90
    GIT_VERSION = 2.44.0.414.gfac1dc44ca9
    [...]

    $ echo $?
    0

Reported-by: Dario Gjorgjevski <dario.gjorgjevski@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile          |  96 ++++++++++++++---------------
 config.mak.uname  | 154 +++++++++++++++++++++++-----------------------
 git-gui/Makefile  |  16 ++---
 gitk-git/Makefile |   4 +-
 4 files changed, 135 insertions(+), 135 deletions(-)

diff --git a/Makefile b/Makefile
index c43c1bd1a05..ac603fb7678 100644
--- a/Makefile
+++ b/Makefile
@@ -1557,23 +1557,23 @@ ifneq (,$(SOCKLEN_T))
 endif
 
 ifeq ($(uname_S),Darwin)
-	ifndef NO_FINK
-		ifeq ($(shell test -d /sw/lib && echo y),y)
+        ifndef NO_FINK
+                ifeq ($(shell test -d /sw/lib && echo y),y)
 			BASIC_CFLAGS += -I/sw/include
 			BASIC_LDFLAGS += -L/sw/lib
-		endif
-	endif
-	ifndef NO_DARWIN_PORTS
-		ifeq ($(shell test -d /opt/local/lib && echo y),y)
+                endif
+        endif
+        ifndef NO_DARWIN_PORTS
+                ifeq ($(shell test -d /opt/local/lib && echo y),y)
 			BASIC_CFLAGS += -I/opt/local/include
 			BASIC_LDFLAGS += -L/opt/local/lib
-		endif
-	endif
-	ifndef NO_APPLE_COMMON_CRYPTO
+                endif
+        endif
+        ifndef NO_APPLE_COMMON_CRYPTO
 		NO_OPENSSL = YesPlease
 		APPLE_COMMON_CRYPTO = YesPlease
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
-	endif
+        endif
 	PTHREAD_LIBS =
 endif
 
@@ -1612,23 +1612,23 @@ ifdef NO_CURL
 	REMOTE_CURL_NAMES =
 	EXCLUDED_PROGRAMS += git-http-fetch git-http-push
 else
-	ifdef CURLDIR
+        ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
 		CURL_CFLAGS = -I$(CURLDIR)/include
 		CURL_LIBCURL = $(call libpath_template,$(CURLDIR)/$(lib))
-	else
+        else
 		CURL_CFLAGS =
 		CURL_LIBCURL =
-	endif
+        endif
 
-	ifndef CURL_LDFLAGS
+        ifndef CURL_LDFLAGS
 		CURL_LDFLAGS = $(eval CURL_LDFLAGS := $$(shell $$(CURL_CONFIG) --libs))$(CURL_LDFLAGS)
-	endif
+        endif
 	CURL_LIBCURL += $(CURL_LDFLAGS)
 
-	ifndef CURL_CFLAGS
+        ifndef CURL_CFLAGS
 		CURL_CFLAGS = $(eval CURL_CFLAGS := $$(shell $$(CURL_CONFIG) --cflags))$(CURL_CFLAGS)
-	endif
+        endif
 	BASIC_CFLAGS += $(CURL_CFLAGS)
 
 	REMOTE_CURL_PRIMARY = git-remote-http$X
@@ -1636,29 +1636,29 @@ else
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
-	ifndef NO_EXPAT
+        ifndef NO_EXPAT
 		PROGRAM_OBJS += http-push.o
-	endif
+        endif
 	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
-	ifeq "$(curl_check)" "072200"
+        ifeq "$(curl_check)" "072200"
 		USE_CURL_FOR_IMAP_SEND = YesPlease
-	endif
-	ifdef USE_CURL_FOR_IMAP_SEND
+        endif
+        ifdef USE_CURL_FOR_IMAP_SEND
 		BASIC_CFLAGS += -DUSE_CURL_FOR_IMAP_SEND
 		IMAP_SEND_BUILDDEPS = http.o
 		IMAP_SEND_LDFLAGS += $(CURL_LIBCURL)
-	endif
-	ifndef NO_EXPAT
-		ifdef EXPATDIR
+        endif
+        ifndef NO_EXPAT
+                ifdef EXPATDIR
 			BASIC_CFLAGS += -I$(EXPATDIR)/include
 			EXPAT_LIBEXPAT = $(call libpath_template,$(EXPATDIR)/$(lib)) -lexpat
-		else
+                else
 			EXPAT_LIBEXPAT = -lexpat
-		endif
-		ifdef EXPAT_NEEDS_XMLPARSE_H
+                endif
+                ifdef EXPAT_NEEDS_XMLPARSE_H
 			BASIC_CFLAGS += -DEXPAT_NEEDS_XMLPARSE_H
-		endif
-	endif
+                endif
+        endif
 endif
 IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
@@ -1670,15 +1670,15 @@ EXTLIBS += -lz
 
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
-	ifdef OPENSSLDIR
+        ifdef OPENSSLDIR
 		BASIC_CFLAGS += -I$(OPENSSLDIR)/include
 		OPENSSL_LINK = $(call libpath_template,$(OPENSSLDIR)/$(lib))
-	else
+        else
 		OPENSSL_LINK =
-	endif
-	ifdef NEEDS_CRYPTO_WITH_SSL
+        endif
+        ifdef NEEDS_CRYPTO_WITH_SSL
 		OPENSSL_LIBSSL += -lcrypto
-	endif
+        endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
 	OPENSSL_LIBSSL =
@@ -1696,18 +1696,18 @@ ifdef APPLE_COMMON_CRYPTO
 endif
 endif
 ifndef NO_ICONV
-	ifdef NEEDS_LIBICONV
-		ifdef ICONVDIR
+        ifdef NEEDS_LIBICONV
+                ifdef ICONVDIR
 			BASIC_CFLAGS += -I$(ICONVDIR)/include
 			ICONV_LINK = $(call libpath_template,$(ICONVDIR)/$(lib))
-		else
+                else
 			ICONV_LINK =
-		endif
-		ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
+                endif
+                ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
 			ICONV_LINK += -lintl
-		endif
+                endif
 		EXTLIBS += $(ICONV_LINK) -liconv
-	endif
+        endif
 endif
 ifdef ICONV_OMITS_BOM
 	BASIC_CFLAGS += -DICONV_OMITS_BOM
@@ -1828,10 +1828,10 @@ ifdef NO_MMAP
 	COMPAT_CFLAGS += -DNO_MMAP
 	COMPAT_OBJS += compat/mmap.o
 else
-	ifdef USE_WIN32_MMAP
+        ifdef USE_WIN32_MMAP
 		COMPAT_CFLAGS += -DUSE_WIN32_MMAP
 		COMPAT_OBJS += compat/win32mmap.o
-	endif
+        endif
 endif
 ifdef MMAP_PREVENTS_DELETE
 	BASIC_CFLAGS += -DMMAP_PREVENTS_DELETE
@@ -1956,11 +1956,11 @@ else
 	BASIC_CFLAGS += -DSHA1_DC
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
-	ifdef DC_SHA1_SUBMODULE
-		ifneq ($(DC_SHA1_SUBMODULE),auto)
+        ifdef DC_SHA1_SUBMODULE
+                ifneq ($(DC_SHA1_SUBMODULE),auto)
 $(error Only set DC_SHA1_EXTERNAL or DC_SHA1_SUBMODULE, not both)
-		endif
-	endif
+                endif
+        endif
 	BASIC_CFLAGS += -DDC_SHA1_EXTERNAL
 	EXTLIBS += -lsha1detectcoll
 else
diff --git a/config.mak.uname b/config.mak.uname
index d0dcca2ec55..b11408e67b4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -65,9 +65,9 @@ ifeq ($(uname_S),Linux)
 	HAVE_PLATFORM_PROCINFO = YesPlease
 	COMPAT_OBJS += compat/linux/procinfo.o
 	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
-	ifneq ($(findstring .el7.,$(uname_R)),)
+        ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
-	endif
+        endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
@@ -95,13 +95,13 @@ ifeq ($(uname_S),UnixWare)
 	NO_MEMMEM = YesPlease
 endif
 ifeq ($(uname_S),SCO_SV)
-	ifeq ($(uname_R),3.2)
+        ifeq ($(uname_R),3.2)
 		CFLAGS = -O2
-	endif
-	ifeq ($(uname_R),5)
+        endif
+        ifeq ($(uname_R),5)
 		CC = cc
 		BASIC_CFLAGS += -Kthread
-	endif
+        endif
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
@@ -124,19 +124,19 @@ ifeq ($(uname_S),Darwin)
 	# - MacOS 10.0.* and MacOS 10.1.0 = Darwin 1.*
 	# - MacOS 10.x.* = Darwin (x+4).* for (1 <= x)
 	# i.e. "begins with [15678] and a dot" means "10.4.* or older".
-	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
+        ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
 		OLD_ICONV = UnfortunatelyYes
 		NO_APPLE_COMMON_CRYPTO = YesPlease
-	endif
-	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
+        endif
+        ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
 		NO_STRLCPY = YesPlease
-	endif
-	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
+        endif
+        ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
 		HAVE_GETDELIM = YesPlease
-	endif
-	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 20 && echo 1),1)
+        endif
+        ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 20 && echo 1),1)
 		OPEN_RETURNS_EINTR = UnfortunatelyYes
-	endif
+        endif
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
@@ -152,12 +152,12 @@ ifeq ($(uname_S),Darwin)
 	# Workaround for `gettext` being keg-only and not even being linked via
 	# `brew link --force gettext`, should be obsolete as of
 	# https://github.com/Homebrew/homebrew-core/pull/53489
-	ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
+        ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
 		BASIC_CFLAGS += -I/usr/local/include -I/usr/local/opt/gettext/include
 		BASIC_LDFLAGS += -L/usr/local/lib -L/usr/local/opt/gettext/lib
-		ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
+                ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
 			MSGFMT = /usr/local/opt/gettext/bin/msgfmt
-		endif
+                endif
 	# On newer ARM-based machines the default installation path has changed to
 	# /opt/homebrew. Include it in our search paths so that the user does not
 	# have to configure this manually.
@@ -165,22 +165,22 @@ ifeq ($(uname_S),Darwin)
 	# Note that we do not employ the same workaround as above where we manually
 	# add gettext. The issue was fixed more than three years ago by now, and at
 	# that point there haven't been any ARM-based Macs yet.
-	else ifeq ($(shell test -d /opt/homebrew/ && echo y),y)
+        else ifeq ($(shell test -d /opt/homebrew/ && echo y),y)
 		BASIC_CFLAGS += -I/opt/homebrew/include
 		BASIC_LDFLAGS += -L/opt/homebrew/lib
-		ifeq ($(shell test -x /opt/homebrew/bin/msgfmt && echo y),y)
+                ifeq ($(shell test -x /opt/homebrew/bin/msgfmt && echo y),y)
 			MSGFMT = /opt/homebrew/bin/msgfmt
-		endif
-	endif
+                endif
+        endif
 
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
 	# Unix domain sockets and PThreads.
-	ifndef NO_PTHREADS
-	ifndef NO_UNIX_SOCKETS
+        ifndef NO_PTHREADS
+        ifndef NO_UNIX_SOCKETS
 	FSMONITOR_DAEMON_BACKEND = darwin
 	FSMONITOR_OS_SETTINGS = darwin
-	endif
-	endif
+        endif
+        endif
 
 	BASIC_LDFLAGS += -framework CoreServices
 endif
@@ -196,7 +196,7 @@ ifeq ($(uname_S),SunOS)
 	NO_REGEX = YesPlease
 	NO_MSGFMT_EXTENDED_OPTIONS = YesPlease
 	HAVE_DEV_TTY = YesPlease
-	ifeq ($(uname_R),5.6)
+        ifeq ($(uname_R),5.6)
 		SOCKLEN_T = int
 		NO_HSTRERROR = YesPlease
 		NO_IPV6 = YesPlease
@@ -206,8 +206,8 @@ ifeq ($(uname_S),SunOS)
 		NO_STRLCPY = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
-	endif
-	ifeq ($(uname_R),5.7)
+        endif
+        ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
@@ -216,25 +216,25 @@ ifeq ($(uname_S),SunOS)
 		NO_STRLCPY = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
-	endif
-	ifeq ($(uname_R),5.8)
+        endif
+        ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
-	endif
-	ifeq ($(uname_R),5.9)
+        endif
+        ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
-	endif
+        endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
 	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
 endif
 ifeq ($(uname_O),Cygwin)
-	ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
+        ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
 		NO_D_TYPE_IN_DIRENT = YesPlease
 		NO_STRCASESTR = YesPlease
 		NO_MEMMEM = YesPlease
@@ -245,9 +245,9 @@ ifeq ($(uname_O),Cygwin)
 		# On some boxes NO_MMAP is needed, and not so elsewhere.
 		# Try commenting this out if you suspect MMAP is more efficient
 		NO_MMAP = YesPlease
-	else
+        else
 		NO_REGEX = UnfortunatelyYes
-	endif
+        endif
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
@@ -263,25 +263,25 @@ ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
 	# Versions up to 10.1 require OLD_ICONV; 10.2 and beyond don't.
 	# A typical version string looks like "10.2-RELEASE".
-	ifeq ($(shell expr "$(uname_R)" : '[1-9]\.'),2)
+        ifeq ($(shell expr "$(uname_R)" : '[1-9]\.'),2)
 		OLD_ICONV = YesPlease
-	endif
-	ifeq ($(firstword $(subst -, ,$(uname_R))),10.0)
+        endif
+        ifeq ($(firstword $(subst -, ,$(uname_R))),10.0)
 		OLD_ICONV = YesPlease
-	endif
-	ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
+        endif
+        ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
 		OLD_ICONV = YesPlease
-	endif
+        endif
 	NO_MEMMEM = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	USE_ST_TIMESPEC = YesPlease
-	ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
+        ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
 		PTHREAD_LIBS = -pthread
 		NO_UINTMAX_T = YesPlease
 		NO_STRTOUMAX = YesPlease
-	endif
+        endif
 	PYTHON_PATH = /usr/local/bin/python
 	PERL_PATH = /usr/local/bin/perl
 	HAVE_PATHS_H = YesPlease
@@ -317,9 +317,9 @@ ifeq ($(uname_S),MirBSD)
 	CSPRNG_METHOD = arc4random
 endif
 ifeq ($(uname_S),NetBSD)
-	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
+        ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
 		NEEDS_LIBICONV = YesPlease
-	endif
+        endif
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 	USE_ST_TIMESPEC = YesPlease
@@ -343,14 +343,14 @@ ifeq ($(uname_S),AIX)
 	BASIC_CFLAGS += -D_LARGE_FILES
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 	NEED_ACCESS_ROOT_HANDLER = UnfortunatelyYes
-	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
+        ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
 		NO_PTHREADS = YesPlease
-	else
+        else
 		PTHREAD_LIBS = -lpthread
-	endif
-	ifeq ($(shell expr "$(uname_V).$(uname_R)" : '5\.1'),3)
+        endif
+        ifeq ($(shell expr "$(uname_V).$(uname_R)" : '5\.1'),3)
 		INLINE = ''
-	endif
+        endif
 	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),GNU)
@@ -410,29 +410,29 @@ ifeq ($(uname_S),HP-UX)
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_NSEC = YesPlease
-	ifeq ($(uname_R),B.11.00)
+        ifeq ($(uname_R),B.11.00)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
-	endif
-	ifeq ($(uname_R),B.10.20)
+        endif
+        ifeq ($(uname_R),B.10.20)
 		# Override HP-UX 11.x setting:
 		INLINE =
 		SOCKLEN_T = size_t
 		NO_PREAD = YesPlease
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
-	endif
+        endif
 	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	# Assume that this is built in Git for Windows' SDK
-	ifeq (MINGW32,$(MSYSTEM))
+        ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
-	else
+        else
 		prefix = /mingw64
-	endif
+        endif
 	# Prepend MSVC 64-bit tool-chain to PATH.
 	#
 	# A regular Git Bash *does not* have cl.exe in its $PATH. As there is a
@@ -550,16 +550,16 @@ ifeq ($(uname_S),Interix)
 	NO_MKDTEMP = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_NSEC = YesPlease
-	ifeq ($(uname_R),3.5)
+        ifeq ($(uname_R),3.5)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
-	endif
-	ifeq ($(uname_R),5.2)
+        endif
+        ifeq ($(uname_R),5.2)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
-	endif
+        endif
 endif
 ifeq ($(uname_S),Minix)
 	NO_IPV6 = YesPlease
@@ -579,12 +579,12 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# still not compile in c89 mode, due to non-const array initializations.
 	CC = cc -c99
 	# Build down-rev compatible objects that don't use our new getopt_long.
-	ifeq ($(uname_R).$(uname_V),J06.21)
+        ifeq ($(uname_R).$(uname_V),J06.21)
 		CC += -WRVU=J06.20
-	endif
-	ifeq ($(uname_R).$(uname_V),L17.02)
+        endif
+        ifeq ($(uname_R).$(uname_V),L17.02)
 		CC += -WRVU=L16.05
-	endif
+        endif
 	# Disable all optimization, seems to result in bad code, with -O or -O2
 	# or even -O1 (default), /usr/local/libexec/git-core/git-pack-objects
 	# abends on "git push". Needs more investigation.
@@ -651,9 +651,9 @@ ifeq ($(uname_S),OS/390)
 	NEEDS_MODE_TRANSLATION = YesPlease
 endif
 ifeq ($(uname_S),MINGW)
-	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
+        ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
 		$(error "Building with MSys is no longer supported")
-	endif
+        endif
 	pathsep = ;
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
@@ -712,22 +712,22 @@ ifeq ($(uname_S),MINGW)
 	# Enable DEP
 	BASIC_LDFLAGS += -Wl,--nxcompat
 	# Enable ASLR (unless debugging)
-	ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
+        ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
 		BASIC_LDFLAGS += -Wl,--dynamicbase
-	endif
-	ifeq (MINGW32,$(MSYSTEM))
+        endif
+        ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
 		HOST_CPU = i686
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
-	endif
-	ifeq (MINGW64,$(MSYSTEM))
+        endif
+        ifeq (MINGW64,$(MSYSTEM))
 		prefix = /mingw64
 		HOST_CPU = x86_64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
-	else
+        else
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
-	endif
+        endif
 	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
@@ -739,11 +739,11 @@ ifeq ($(uname_S),MINGW)
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
 	USE_NED_ALLOCATOR = YesPlease
-	ifeq (/mingw64,$(subst 32,64,$(prefix)))
+        ifeq (/mingw64,$(subst 32,64,$(prefix)))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig
 		ETC_GITATTRIBUTES = ../etc/gitattributes
-	endif
+        endif
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
diff --git a/git-gui/Makefile b/git-gui/Makefile
index 3f80435436c..667c39ed564 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -107,12 +107,12 @@ endif
 
 ifeq ($(uname_S),Darwin)
 	TKFRAMEWORK = /Library/Frameworks/Tk.framework/Resources/Wish.app
-	ifeq ($(shell echo "$(uname_R)" | awk -F. '{if ($$1 >= 9) print "y"}')_$(shell test -d $(TKFRAMEWORK) || echo n),y_n)
+        ifeq ($(shell echo "$(uname_R)" | awk -F. '{if ($$1 >= 9) print "y"}')_$(shell test -d $(TKFRAMEWORK) || echo n),y_n)
 		TKFRAMEWORK = /System/Library/Frameworks/Tk.framework/Resources/Wish.app
-		ifeq ($(shell test -d $(TKFRAMEWORK) || echo n),n)
+                ifeq ($(shell test -d $(TKFRAMEWORK) || echo n),n)
 			TKFRAMEWORK = /System/Library/Frameworks/Tk.framework/Resources/Wish\ Shell.app
-		endif
-	endif
+                endif
+        endif
 	TKEXECUTABLE = $(shell basename "$(TKFRAMEWORK)" .app)
 endif
 
@@ -143,9 +143,9 @@ ifeq ($(exedir),$(gg_libdir))
 endif
 gg_libdir_sed_in := $(gg_libdir)
 ifeq ($(uname_S),Darwin)
-	ifeq ($(shell test -d $(TKFRAMEWORK) && echo y),y)
+        ifeq ($(shell test -d $(TKFRAMEWORK) && echo y),y)
 		GITGUI_MACOSXAPP := YesPlease
-	endif
+        endif
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
@@ -220,9 +220,9 @@ ifdef NO_MSGFMT
 	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
 else
 	MSGFMT ?= msgfmt
-	ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $$?),0)
+        ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $$?),0)
 		MSGFMT := $(TCL_PATH) po/po2msg.sh
-	endif
+        endif
 endif
 
 msgsdir     = $(gg_libdir)/msgs
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index 5bdd52a6ebf..e1f0aff4a19 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -33,9 +33,9 @@ ifdef NO_MSGFMT
 	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
 else
 	MSGFMT ?= msgfmt
-	ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $$?),0)
+        ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $$?),0)
 		MSGFMT := $(TCL_PATH) po/po2msg.sh
-	endif
+        endif
 endif
 
 PO_TEMPLATE = po/gitk.pot
-- 
2.44.0.414.g38c9f58cd0c
