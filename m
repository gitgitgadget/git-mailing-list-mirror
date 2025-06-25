Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B91E5B6F
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836935; cv=none; b=seStjPsv97lBx716YAGK9ph7DXgMKflw2vnu70Y8RkHWRqUReSa2KHl2+Ko6/5cMP5PQQVecHmcqpJmcCrSXHlC2LyFmGHFia2kHO1qUKEsopTTbPDryonhrGWGTYXQ+YV6qhpKiWRsmKCG7w1vRjmg5dsXW9EPzOc5/SvG4d3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836935; c=relaxed/simple;
	bh=UHew+fm+YEl3ZNMwirpIRhgvLxdC/FveE7eAj4i7sWI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=J+yA4HpRqVWH51N8tfvP6GtroT9WUhe2dsncrKy9t6zKZiawVD2bbrZMmcom92Y6FNw42Y7lkU4WS8cdm9iSUTdhuEvXPLSFF0e73Yy+lckBDqjnPleCwHnJO3Q7YTnobnITg+180jkc1q1vNKrcuz6bj1ZU/hRrxEFdAL9Pk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB1DkRBJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB1DkRBJ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a510432236so4591374f8f.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750836932; x=1751441732; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IhcdbGVtLKLyqFlYjeb1fl8Wzg0fvrRqm1eVi4UKJM=;
        b=GB1DkRBJgIt3JHAILTKo3NVIdPjveIIcyKhCn5XG/90l9h9lloIanxS4wFpp7HdoG+
         hJhA8EEJGYt5jR8p/keF4h66SLq9W5Dy9lzKP4yCK/gusSGgQBulIk0rv4nzpTyRUxXJ
         llb2v19eOoKERejRKnZkTf0Bt/c6KT9Ap0HhV95KUs82BaS+JbtWOaJbvn1Waf7g+7rn
         9PK0a+28sGOvbdYlNFThuQyV7Yrd6rYQFc8AS683PZhIvhpfXGNRtOejmdsgF9GtJDbh
         bvn5XppSLIND4lxhiDxpx2XvlLYeDRDCunaJilatxPyfuxS2D1HKe/HokI+epCVtW99p
         xv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750836932; x=1751441732;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IhcdbGVtLKLyqFlYjeb1fl8Wzg0fvrRqm1eVi4UKJM=;
        b=Bl/2jxv7Chv53xpSFPA7auCjS59oLvchpz/A2yFlld0EEYCBbYejNCnqHDendGQWdN
         ciIIrcOEKRqXw6CcH2T8qFoPRUMXbnzmB5QYc7LRYdgiprnETHBZfANAYTeIQp3vE14/
         n8kW66rMsba6qUeNDA8/PiB88eT8ku9t63p+xLsFZmGv62nUw0YPc7MbTxxxV7rQaBPi
         CcPeXJFzHFZMFhPkHUbiNo69orrF3QiUcnIHH9fj4IqtlHk07itLut9CFLM9WkigsjdW
         JC2XEdeDA1HHsqGKhETuzvqJ9bQqV1dvWL9wg69GvQQUZ8MlUFQCVqxPdTq31YumjstA
         Da1Q==
X-Gm-Message-State: AOJu0YxajMwnl3MGXTSD4TBRtPK1LECgXDzyas74+9PxRjw99rdY80da
	SqbBzOpw4oMb7iv/dIMc2eHJ9ai8gpncqhXEp/mjruXo9nQ4qV4lzfkzjtjiTQ==
X-Gm-Gg: ASbGncuqMHWA5CN9pjRohNk/8TN2r6jPWjgbHfedeNh7G7yNdil0FPtv2btcWo/utaM
	sbMRpdbXh8AcoaRpzH77jNq9kXMZeuZxayNc/Mg1SRIjXiE7JltcYYRYdUQMuWsiNblfLzWFnNx
	WjtcUZs2s6xOgtk4lRWHbrucy0X9CTjukQ1UKhvWKE5Zx1PQI8+H+xfiUOA7Sip1BvlI8ONMJst
	lYA3yWQoHwBU8Y/tGliIaxf48kQlsRzTfFKRBS8RIwaWC5tTHklDQWZXFIoLn3sLPAQ61uiyql9
	Y8lVNssDy9MvsrhWx1blx3W7jueoTm/ATY5YFfFY4NTIvXrFeinq4OBbp3+ZtIE=
X-Google-Smtp-Source: AGHT+IFM80MfpELAMzMC8dHh+kSEiqr3e2rqNjhJsIx8kJp67yDlUrToV774JadCHeKDGZNggtC+Ag==
X-Received: by 2002:a5d:58cf:0:b0:3a4:f655:8c4d with SMTP id ffacd0b85a97d-3a6ed642557mr954696f8f.27.1750836931377;
        Wed, 25 Jun 2025 00:35:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f2670sm3785908f8f.49.2025.06.25.00.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 00:35:30 -0700 (PDT)
Message-Id: <e82b7425bbc2540fa5ef3fd4584e6f902485d064.1750836928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Jun 2025 07:35:26 +0000
Subject: [PATCH v2 1/3] compat/posix.h: track SA_RESTART fallback
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
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Systems without SA_RESTART are using custom CFLAGS or headers
instead of the standard header file.

Correct that, and invent a Makefile variable to track the
exceptions which will become handy in the next commits.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile             |  6 ++++++
 compat/mingw-posix.h |  1 -
 compat/posix.h       |  8 ++++++++
 config.mak.uname     |  7 ++++---
 configure.ac         | 17 +++++++++++++++++
 meson.build          |  4 ++++
 6 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 70d1543b6b86..c4e6fc7bfd13 100644
--- a/Makefile
+++ b/Makefile
@@ -37,6 +37,9 @@ include shared.mak
 # when attempting to read from an fopen'ed directory (or even to fopen
 # it at all).
 #
+# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
+# prefer to use ANSI C signal() over POSIX sigaction()
+#
 # Define OPEN_RETURNS_EINTR if your open() system call may return EINTR
 # when a signal is received (as opposed to restarting).
 #
@@ -1811,6 +1814,9 @@ ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
 	COMPAT_OBJS += compat/fopen.o
 endif
+ifdef USE_NON_POSIX_SIGNAL
+	COMPAT_CFLAGS += -DUSE_NON_POSIX_SIGNAL
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
index 067a00f33b83..84ad2c9647aa 100644
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
+# define SA_RESTART 0	/* disabled for sigaction() */
+#endif
+
 typedef uintmax_t timestamp_t;
 #define PRItime PRIuMAX
 #define parse_timestamp strtoumax
diff --git a/config.mak.uname b/config.mak.uname
index b1c5c4d5e8ed..1914982eb13e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -486,6 +486,7 @@ ifeq ($(uname_S),Windows)
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_INTTYPES_H = YesPlease
+	USE_NON_POSIX_SIGNAL = YesPlease
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
+	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
 	CSPRNG_METHOD = openssl
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
@@ -699,6 +699,7 @@ ifeq ($(uname_S),MINGW)
 	NEEDS_LIBICONV = YesPlease
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
+	USE_NON_POSIX_SIGNAL = YesPlease
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
+	USE_NON_POSIX_SIGNAL = UnfortunatelyYes
 endif
diff --git a/configure.ac b/configure.ac
index f6caab919a3e..8c52fd129f31 100644
--- a/configure.ac
+++ b/configure.ac
@@ -862,6 +862,23 @@ fi
 GIT_CONF_SUBST([ICONV_OMITS_BOM])
 fi
 
+# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
+# prefer using ANSI C signal() over POSIX sigaction()
+
+AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
+	AC_COMPILE_IFELSE(
+		[AC_LANG_PROGRAM([#include <signal.h>], [[
+		#ifdef SA_RESTART
+		#endif
+		siginterrupt(SIGCHLD, 1)
+		]])],[ac_cv_siginterrupt=yes],[
+			ac_cv_siginterrupt=no
+			USE_NON_POSIX_SIGNAL=UnfortunatelyYes
+		]
+	)
+])
+GIT_CONF_SUBST([USE_NON_POSIX_SIGNAL])
+
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
 #
diff --git a/meson.build b/meson.build
index 7fea4a34d684..f27c37e430ae 100644
--- a/meson.build
+++ b/meson.build
@@ -1094,6 +1094,10 @@ else
   build_options_config.set('NO_EXPAT', '1')
 endif
 
+if compiler.get_define('SA_RESTART', prefix: '#include <signal.h>') == ''
+  libgit_c_args += '-DUSE_NON_POSIX_SIGNAL'
+endif
+
 if not compiler.has_header('sys/select.h')
   libgit_c_args += '-DNO_SYS_SELECT_H'
 endif
-- 
gitgitgadget

