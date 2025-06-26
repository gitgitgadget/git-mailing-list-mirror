Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FFC2957C2
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927995; cv=none; b=G/CumkUmDNu53E7c80pmOLigw0OZeVymlu8VmsKEQLiw1rN6te82G22pwGxss3uBlK+uhR21v2LcK4qbGRZmADFC/U+wSdeW4uEX8PRZ+38IRBvOgoweogK2sanw1tdeRFa4P/rUJsjNbUFwDaMfeTCOk0EZnYPrLlqTXJRK3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927995; c=relaxed/simple;
	bh=myI9M3A+5bYuEnI0vfQBf9LJl63oAFaCPceqodtJWRs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=GtGL81Ph85cpPOoeCh8PZ9LRci6tuOO0QAAm4nLcfPxBA11ShDQa3KVKpvbAmjS04UoQiVjIlaB747aADye76eDIZU7ibqdxOXXoQuiwXe3Hyiph55BEybpbP7o7MRantZM/DUZ0y+kUtJbLTU6zwP/6cHAurqNmFQLLgNJ55ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2PlB2FG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2PlB2FG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so677391f8f.3
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750927992; x=1751532792; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0TgGWPbk1LLusyDL6ocRrE+MgNe9k7qeCIAkVDT/78=;
        b=l2PlB2FGbs6NjpgKDqeJ9ACiY0xgchqzM16PpHcG6og16827Ks/RgE0EnbQCbOmwmH
         Y+7ykRStnZBEz1htQ5AdSy8w7gGIxsvliTisoebUF3sMDGnwfZGVEo9OyhgQM9QoHQQE
         ujIfOOXTzK4OOvOMIb9ZfcCPnccjjqtJ7U2QBxQYZfazeM03ZEf4WIsmGMH82WCye55x
         p+8l3PF1c/d/y3ujFNGoMsulyH64Ef21zsi6Zfm6XDdSSbdan4WNR/tKDQ0AfLdLPy8T
         HHRSoT9sMl8/UMZhaZwiZ7xzy5u5Zz5X+5yuM4zoPUW8GxhDQwGtMdmKjiWjWYxaBs5K
         dHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927992; x=1751532792;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0TgGWPbk1LLusyDL6ocRrE+MgNe9k7qeCIAkVDT/78=;
        b=QyqsVGHYTLFUEbFY4Dkf9xpTwvuRFe4oURJsVtk4ISEMI5gutQgY8BnjoYzWQcOdjD
         HWyWisl9pRMHVtyQg7az4InrKAAZnMls3kWGlxZUI3kImlCNd+M7f+G0yd362EQ2Bhy9
         7FXDhRKmjO8BmfAvh2E75jXmjA9oys9a7MxENWljv5irdbKeCiUWdREou9gqchqf03Hu
         UyFgTZ5vSpmrFPTytyC9JVf03XH+AYS39yZGvUxq5e12BieilC7bO4aiMRRJUYHFIisW
         H2TyYkmURV1fm9JGGjFcS3od3QW3Ql+F7Bo6awIGnSvOgw4iPRlWWsFxB4lWp4nZS/qo
         fR/A==
X-Gm-Message-State: AOJu0YyE3Orud0Xzbk8JbesIu33Px90+w3xYjGOE9FtBUiahIYvq5ewU
	Qaeu2yypdCNQghGHuT6U7UDnxzhkLMBpsIiEJAv/2VhZXgddWjlwn5LE0nDXHQ==
X-Gm-Gg: ASbGncurCWnbyawBjDIM0m935XPokdePH+hvOwzyEt+iX0wIbBRvAFtcW+T8jhrmMyJ
	Y2kROSEu7dgAsY/NQjoE8wCohJlSmdG+w0a130GWZsgiijcPfZtm9dQ7lXmxD27N6geeP6MvbjF
	3Cw12r4djZTr/V8BhraIu0GTd6uzs1kliHuq8TK6JCDOo7/befK6bBV+mGaKJhfXywXymBqVGoP
	Yr42wAcGBZKiRSWdaNSlzx4/Nx+8LzF8pZa4MpQsZeld+9a7EaCT7qw4myzYfSg47b5ZL258g8n
	RHVwsjXvchyI+o/FWQ3nj0hrt4sSW0cNWjE4hDfSbQFiKw2689YMBaXyGl+tXrM=
X-Google-Smtp-Source: AGHT+IHPoDwfz9E2ZnvY8Vvk4G1iokwxxNa7TZq1GhkEBesOC6iKKLhp8UGgsUcdHG7HlIgi01VDiw==
X-Received: by 2002:a05:6000:18ad:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3a6ed64b5e9mr5417442f8f.46.1750927991387;
        Thu, 26 Jun 2025 01:53:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f26ebsm6804452f8f.51.2025.06.26.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:53:10 -0700 (PDT)
Message-Id: <ae1ca6bb2b258fc3c18c627aed2159dbb8f8c268.1750927989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Jun 2025 08:53:05 +0000
Subject: [PATCH v3 1/4] compat/posix.h: track SA_RESTART fallback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Systems without SA_RESTART are using custom CFLAGS or headers
instead of the standard header file.

Correct that, and invent a Makefile variable to track the
exceptions which will become handy in the next commits.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile             |  5 +++++
 compat/mingw-posix.h |  1 -
 compat/posix.h       |  8 ++++++++
 config.mak.uname     |  7 ++++---
 configure.ac         | 16 ++++++++++++++++
 meson.build          |  4 ++++
 6 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 70d1543b6b86..f0839356199c 100644
--- a/Makefile
+++ b/Makefile
@@ -37,6 +37,8 @@ include shared.mak
 # when attempting to read from an fopen'ed directory (or even to fopen
 # it at all).
 #
+# Define NO_RESTARTABLE_SIGNALS if don't have support for SA_RESTART
+#
 # Define OPEN_RETURNS_EINTR if your open() system call may return EINTR
 # when a signal is received (as opposed to restarting).
 #
@@ -1811,6 +1813,9 @@ ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
 	COMPAT_OBJS += compat/fopen.o
 endif
+ifdef NO_RESTARTABLE_SIGNALS
+	COMPAT_CFLAGS += -DNO_RESTARTABLE_SIGNALS
+endif
 ifdef OPEN_RETURNS_EINTR
 	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
 endif
diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 88e0cf92924b..a0dca756d104 100644
--- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -95,7 +95,6 @@ struct sigaction {
 	sig_handler_t sa_handler;
 	unsigned sa_flags;
 };
-#define SA_RESTART 0
 
 struct itimerval {
 	struct timeval it_value, it_interval;
diff --git a/compat/posix.h b/compat/posix.h
index 067a00f33b83..b514e67902d2 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -250,6 +250,14 @@ char *gitdirname(char *);
 #define NAME_MAX 255
 #endif
 
+/*
+ * On most systems <signal.h> would have given us this, but
+ * not on some systems (e.g. NonStop, QNX).
+ */
+#ifndef SA_RESTART
+# define SA_RESTART 0 /* disabled for sigaction() */
+#endif
+
 typedef uintmax_t timestamp_t;
 #define PRItime PRIuMAX
 #define parse_timestamp strtoumax
diff --git a/config.mak.uname b/config.mak.uname
index b1c5c4d5e8ed..435078dc620b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -486,6 +486,7 @@ ifeq ($(uname_S),Windows)
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_INTTYPES_H = YesPlease
+	NO_RESTARTABLE_SIGNALS = YesPlease
 	CSPRNG_METHOD = rtlgenrandom
 	# VS2015 with UCRT claims that snprintf and friends are C99 compliant,
 	# so we don't need this:
@@ -654,8 +655,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 
 	# Not detected (nor checked for) by './configure'.
-	# We don't have SA_RESTART on NonStop, unfortunalety.
-	COMPAT_CFLAGS += -DSA_RESTART=0
 	# Apparently needed in compat/fnmatch/fnmatch.c.
 	COMPAT_CFLAGS += -DHAVE_STRING_H=1
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
@@ -664,6 +663,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_MMAP = YesPlease
 	NO_POLL = YesPlease
 	NO_INTPTR_T = UnfortunatelyYes
+	NO_RESTARTABLE_SIGNALS = UnfortunatelyYes
 	CSPRNG_METHOD = openssl
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
@@ -699,6 +699,7 @@ ifeq ($(uname_S),MINGW)
 	NEEDS_LIBICONV = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
+	NO_RESTARTABLE_SIGNALS = YesPlease
 	NO_SVN_TESTS = YesPlease
 
 	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
@@ -782,7 +783,6 @@ ifeq ($(uname_S),MINGW)
         endif
 endif
 ifeq ($(uname_S),QNX)
-	COMPAT_CFLAGS += -DSA_RESTART=0
 	EXPAT_NEEDS_XMLPARSE_H = YesPlease
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_SOCKET = YesPlease
@@ -794,4 +794,5 @@ ifeq ($(uname_S),QNX)
 	NO_PTHREADS = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
+	NO_RESTARTABLE_SIGNALS = UnfortunatelyYes
 endif
diff --git a/configure.ac b/configure.ac
index f6caab919a3e..631ca67dd1aa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -862,6 +862,22 @@ fi
 GIT_CONF_SUBST([ICONV_OMITS_BOM])
 fi
 
+# Define NO_RESTARTABLE_SIGNALS if don't have support for SA_RESTART
+
+AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
+	AC_COMPILE_IFELSE(
+		[AC_LANG_PROGRAM([#include <signal.h>], [[
+			#ifdef SA_RESTART
+			restartable signals supported
+			#endif
+		]])],[
+			ac_cv_siginterrupt=no
+			NO_RESTARTABLE_SIGNALS=UnfortunatelyYes
+		], [ac_cv_siginterrupt=yes]
+	)
+])
+GIT_CONF_SUBST([NO_RESTARTABLE_SIGNALS])
+
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
 #
diff --git a/meson.build b/meson.build
index 7fea4a34d684..b6711393a5fa 100644
--- a/meson.build
+++ b/meson.build
@@ -1094,6 +1094,10 @@ else
   build_options_config.set('NO_EXPAT', '1')
 endif
 
+if compiler.get_define('SA_RESTART', prefix: '#include <signal.h>') == ''
+  libgit_c_args += '-DNO_RESTARTABLE_SIGNALS'
+endif
+
 if not compiler.has_header('sys/select.h')
   libgit_c_args += '-DNO_SYS_SELECT_H'
 endif
-- 
gitgitgadget

