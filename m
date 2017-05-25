Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E97C5209FD
	for <e@80x24.org>; Thu, 25 May 2017 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165467AbdEYUGG (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 16:06:06 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37116 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165464AbdEYUGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 16:06:03 -0400
Received: by mail-wm0-f45.google.com with SMTP id d127so111560753wmf.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEIjiYNPqT+zkxbWZCLEYgf5vUlKPoGfFRKDy92lWWc=;
        b=dag5rUzk96JKKNZ4kFFOF/yRL8Ulb7GeQY8UlS1D12nFWXziSPM4IKpgr3g/EJlxZh
         xEUTz7GZyoTfE1/6GUNxxDib3m18vX8I61pHMsgXg01husABgrgoFFmB9A8aKbVjGEhL
         7CbQ6TNyaV0YEsIHQRw0oJPW1XP2v50wWpUx2BBtDugbWPbJh2UP8ejLpQjp086sScGC
         kp9ja/GRzglf2rQ/sAxKAqLJwSlU1yN/PSYQ5ksFBu8qLHj7B0iHifl4u6HyzsXLEO/h
         vQ+6EfgGDDzfeaycW9tq2lCEnhPXxm1XiD9H2LAUlQ1cqF6GaE42OsIse/eXFC5utNrd
         GHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEIjiYNPqT+zkxbWZCLEYgf5vUlKPoGfFRKDy92lWWc=;
        b=DsLWqOYh/I8Y0/N9qfIxUD5s16uOss3geTz42Efmw8o2P4JLt3J7s6DEvLbkkz2zbd
         2aAk6B/JOXmPJwHtF8KccfXaEkvoveCyNnlOCzsTAbdhbVdBOY/cz0zfm0rXLe2ZYHoV
         inG5uhMfKfUj+8Cw95Kv8MmkFwVqrlGWMGGGrwghDRmkGFpVxFO3WeHcfE54GjReTHic
         VOrCXEYhqJkWySzzTdDYVwczZfNlweVDOKXGSC9QQFMJN+Fg9aF3JAc678LRYsU7ceZS
         EH3+1vDWkm76k6tZRMvlvk+ynfDK1SRj/93UebP8MRBiCb94f6T4ZL5YUrbf4xroDf7A
         imDw==
X-Gm-Message-State: AODbwcCYqwwUpKN11iayWtINcy6e7muZJzjOx37NM0dv6slU3LEh9z16
        /oA2MBmfUa7+eA==
X-Received: by 10.223.143.70 with SMTP id p64mr23282469wrb.120.1495742761692;
        Thu, 25 May 2017 13:06:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r60sm10574313wrb.37.2017.05.25.13.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 13:06:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/7] grep: add support for PCRE v2
Date:   Thu, 25 May 2017 20:05:28 +0000
Message-Id: <20170525200528.22037-8-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525200528.22037-1-avarab@gmail.com>
References: <20170525200528.22037-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for v2 of the PCRE API. This is a new major version of
PCRE that came out in early 2015[1].

The regular expression syntax is the same, but while the API is
similar, pretty much every function is either renamed or takes
different arguments. Thus using it via entirely new functions makes
sense, as opposed to trying to e.g. have one compile_pcre_pattern()
that would call either PCRE v1 or v2 functions.

Git can now be compiled with either USE_LIBPCRE1=YesPlease or
USE_LIBPCRE2=YesPlease, with USE_LIBPCRE=YesPlease currently being a
synonym for the former. Providing both is a compile-time error.

With earlier patches to enable JIT for PCRE v1 the performance of the
release versions of both libraries is almost exactly the same, with
PCRE v2 being around 1% slower.

However after I reported this to the pcre-dev mailing list[2] I got a
lot of help with the API use from Zoltán Herczeg, he subsequently
optimized some of the JIT functionality in v2 of the library.

Running the p7820-grep-engines.sh performance test against the latest
Subversion trunk of both, with both them and git compiled as -O3, and
the test run against linux.git, gives the following results. Just the
/perl/ tests shown:

    $ GIT_PERF_REPEAT_COUNT=30 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_COMMAND='grep -q LIBPCRE2 Makefile && make -j8 USE_LIBPCRE2=YesPlease CC=~/perl5/installed/bin/gcc NO_R_TO_GCC_LINKER=YesPlease CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre2/inst LDFLAGS=-Wl,-rpath,/home/avar/g/pcre2/inst/lib || make -j8 USE_LIBPCRE=YesPlease CC=~/perl5/installed/bin/gcc NO_R_TO_GCC_LINKER=YesPlease CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre/inst LDFLAGS=-Wl,-rpath,/home/avar/g/pcre/inst/lib' ./run HEAD~2 HEAD~ HEAD p7820-grep-engines.sh
    [...]
    Test                                           HEAD~2            HEAD~                    HEAD
    ----------------------------------------------------------------------------------------------------------------
    7820.3: perl grep 'how.to'                      0.22(0.40+0.48)   0.22(0.31+0.58) +0.0%   0.22(0.26+0.59) +0.0%
    7820.7: perl grep '^how to'                     0.27(0.62+0.50)   0.28(0.60+0.50) +3.7%   0.22(0.25+0.60) -18.5%
    7820.11: perl grep '[how] to'                   0.33(0.92+0.47)   0.33(0.94+0.45) +0.0%   0.25(0.42+0.51) -24.2%
    7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       0.35(1.08+0.46)   0.35(1.12+0.41) +0.0%   0.25(0.52+0.50) -28.6%
    7820.19: perl grep 'm(ú|u)lt.b(æ|y)te'          0.30(0.78+0.51)   0.30(0.86+0.42) +0.0%   0.25(0.29+0.54) -16.7%

See commit ("perf: add a comparison test of grep regex engines",
2017-04-19) for details on the machine the above test run was executed
on.

Here HEAD~2 is git with PCRE v1 without JIT, HEAD~ is PCRE v1 with
JIT, and HEAD is PCRE v2 (also with JIT). See previous commits of mine
mentioning p7820-grep-engines.sh for more details on the test setup.

For ease of readability, a different run just of HEAD~ (PCRE v1 with
JIT v.s. PCRE v2), again with just the /perl/ tests shown:

    Test                                           HEAD~             HEAD
    ---------------------------------------------------------------------------------------
    7820.3: perl grep 'how.to'                      0.23(0.41+0.47)   0.23(0.26+0.59) +0.0%
    7820.7: perl grep '^how to'                     0.27(0.64+0.47)   0.23(0.28+0.56) -14.8%
    7820.11: perl grep '[how] to'                   0.34(0.95+0.44)   0.25(0.38+0.56) -26.5%
    7820.15: perl grep '(e.t[^ ]*|v.ry) rare'       0.34(1.07+0.46)   0.24(0.52+0.49) -29.4%
    7820.19: perl grep 'm(ú|u)lt.b(æ|y)te'          0.30(0.81+0.46)   0.22(0.33+0.54) -26.7%

I.e. the two are either neck-to-neck, but PCRE v2 usually pulls ahead,
when it does it's around 20% faster.

A brief note on thread safety: As noted in pcre2api(3) & pcre2jit(3)
the compiled pattern can be shared between threads, but not some of
the JIT context, however the grep threading support does all pattern &
JIT compilation in separate threads, so this code doesn't need to
concern itself with thread safety.

See commit 63e7e9d8b6 ("git-grep: Learn PCRE", 2011-05-09) for the
initial addition of PCRE v1. This change follows some of the same
patterns it did (and which were discussed on list at the time),
e.g. mocking up types with typedef instead of ifdef-ing them out when
USE_LIBPCRE2 isn't defined. This adds some trivial memory use to the
program, but makes the code look nicer.

1. https://lists.exim.org/lurker/message/20150105.162835.0666407a.en.html
2. https://lists.exim.org/lurker/thread/20170419.172322.833ee099.en.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile      |  36 ++++++++++----
 configure.ac  |  77 +++++++++++++++++++++++++-----
 grep.c        | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 grep.h        |  17 +++++++
 t/test-lib.sh |   2 +-
 5 files changed, 258 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index a79274e5e6..e5a26f77a5 100644
--- a/Makefile
+++ b/Makefile
@@ -29,8 +29,15 @@ all::
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
-# Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
+# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
+# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
+# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
+# default in future releases.
+#
+# Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
+# in /foo/bar/include and /foo/bar/lib directories. Which version of
+# PCRE this points to determined by the USE_LIBPCRE1 and USE_LIBPCRE2
+# variables.
 #
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
 #
@@ -1087,15 +1094,27 @@ ifdef NO_LIBGEN_H
 	COMPAT_OBJS += compat/basename.o
 endif
 
-ifdef USE_LIBPCRE
-	BASIC_CFLAGS += -DUSE_LIBPCRE1
-	ifdef LIBPCREDIR
-		BASIC_CFLAGS += -I$(LIBPCREDIR)/include
-		EXTLIBS += -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib)
+USE_LIBPCRE1 ?= $(USE_LIBPCRE)
+
+ifneq (,$(USE_LIBPCRE1))
+	ifdef USE_LIBPCRE2
+$(error Only set USE_LIBPCRE1 (or its alias USE_LIBPCRE) or USE_LIBPCRE2, not both!)
 	endif
+
+	BASIC_CFLAGS += -DUSE_LIBPCRE1
 	EXTLIBS += -lpcre
 endif
 
+ifdef USE_LIBPCRE2
+	BASIC_CFLAGS += -DUSE_LIBPCRE2
+	EXTLIBS += -lpcre2-8
+endif
+
+ifdef LIBPCREDIR
+	BASIC_CFLAGS += -I$(LIBPCREDIR)/include
+	EXTLIBS += -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib)
+endif
+
 ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
@@ -2240,7 +2259,8 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@+
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
-	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
+	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE1)))'\' >>$@+
+	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
diff --git a/configure.ac b/configure.ac
index deeb968daa..11d083fbe0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -255,21 +255,61 @@ GIT_PARSE_WITH([openssl]))
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
-# Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
+# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
+# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
+# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
+# default in future releases.
+#
+# Define LIBPCREDIR=/foo/bar if your PCRE header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
 AC_ARG_WITH(libpcre,
-AS_HELP_STRING([--with-libpcre],[support Perl-compatible regexes (default is NO)])
+AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre1]),
+    if test "$withval" = "no"; then
+	USE_LIBPCRE1=
+    elif test "$withval" = "yes"; then
+	USE_LIBPCRE1=YesPlease
+    else
+	USE_LIBPCRE1=YesPlease
+	LIBPCREDIR=$withval
+	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
+        dnl USE_LIBPCRE1 can still be modified below, so don't substitute
+        dnl it yet.
+	GIT_CONF_SUBST([LIBPCREDIR])
+    fi)
+
+AC_ARG_WITH(libpcre1,
+AS_HELP_STRING([--with-libpcre1],[support Perl-compatible regexes via libpcre1 (default is NO)])
+AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
+    if test "$withval" = "no"; then
+	USE_LIBPCRE1=
+    elif test "$withval" = "yes"; then
+	USE_LIBPCRE1=YesPlease
+    else
+	USE_LIBPCRE1=YesPlease
+	LIBPCREDIR=$withval
+	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
+        dnl USE_LIBPCRE1 can still be modified below, so don't substitute
+        dnl it yet.
+	GIT_CONF_SUBST([LIBPCREDIR])
+    fi)
+
+AC_ARG_WITH(libpcre2,
+AS_HELP_STRING([--with-libpcre2],[support Perl-compatible regexes via libpcre2 (default is NO)])
 AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
+    if test -n "$USE_LIBPCRE1"; then
+        AC_MSG_ERROR([Only supply one of --with-libpcre1 or --with-libpcre2!])
+    fi
+
     if test "$withval" = "no"; then
-	USE_LIBPCRE=
+	USE_LIBPCRE2=
     elif test "$withval" = "yes"; then
-	USE_LIBPCRE=YesPlease
+	USE_LIBPCRE2=YesPlease
     else
-	USE_LIBPCRE=YesPlease
+	USE_LIBPCRE2=YesPlease
 	LIBPCREDIR=$withval
 	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
-        dnl USE_LIBPCRE can still be modified below, so don't substitute
+        dnl USE_LIBPCRE2 can still be modified below, so don't substitute
         dnl it yet.
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
@@ -501,13 +541,11 @@ GIT_CONF_SUBST([NEEDS_SSL_WITH_CRYPTO])
 GIT_CONF_SUBST([NO_OPENSSL])
 
 #
-# Define USE_LIBPCRE if you have and want to use libpcre. Various
-# commands such as log and grep offer runtime options to use
-# Perl-compatible regular expressions instead of standard or extended
-# POSIX regular expressions.
+# Handle the USE_LIBPCRE1 and USE_LIBPCRE2 options potentially set
+# above.
 #
 
-if test -n "$USE_LIBPCRE"; then
+if test -n "$USE_LIBPCRE1"; then
 
 GIT_STASH_FLAGS($LIBPCREDIR)
 
@@ -517,7 +555,22 @@ AC_CHECK_LIB([pcre], [pcre_version],
 
 GIT_UNSTASH_FLAGS($LIBPCREDIR)
 
-GIT_CONF_SUBST([USE_LIBPCRE])
+GIT_CONF_SUBST([USE_LIBPCRE1])
+
+fi
+
+
+if test -n "$USE_LIBPCRE2"; then
+
+GIT_STASH_FLAGS($LIBPCREDIR)
+
+AC_CHECK_LIB([pcre2-8], [pcre2_config_8],
+[USE_LIBPCRE2=YesPlease],
+[USE_LIBPCRE2=])
+
+GIT_UNSTASH_FLAGS($LIBPCREDIR)
+
+GIT_CONF_SUBST([USE_LIBPCRE2])
 
 fi
 
diff --git a/grep.c b/grep.c
index 19fa67c34c..e4c1ead104 100644
--- a/grep.c
+++ b/grep.c
@@ -179,22 +179,37 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 	case GREP_PATTERN_TYPE_BRE:
 		opt->fixed = 0;
 		opt->pcre1 = 0;
+		opt->pcre2 = 0;
 		break;
 
 	case GREP_PATTERN_TYPE_ERE:
 		opt->fixed = 0;
 		opt->pcre1 = 0;
+		opt->pcre2 = 0;
 		opt->regflags |= REG_EXTENDED;
 		break;
 
 	case GREP_PATTERN_TYPE_FIXED:
 		opt->fixed = 1;
 		opt->pcre1 = 0;
+		opt->pcre2 = 0;
 		break;
 
 	case GREP_PATTERN_TYPE_PCRE:
 		opt->fixed = 0;
+#ifdef USE_LIBPCRE2
+		opt->pcre1 = 0;
+		opt->pcre2 = 1;
+#else
+		/*
+		 * It's important that pcre1 always be assigned to
+		 * even when there's no USE_LIBPCRE* defined. We still
+		 * call the PCRE stub function, it just dies with
+		 * "cannot use Perl-compatible regexes[...]".
+		 */
 		opt->pcre1 = 1;
+		opt->pcre2 = 0;
+#endif
 		break;
 	}
 }
@@ -446,6 +461,129 @@ static void free_pcre1_regexp(struct grep_pat *p)
 }
 #endif /* !USE_LIBPCRE1 */
 
+#ifdef USE_LIBPCRE2
+static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
+{
+	int error;
+	PCRE2_UCHAR errbuf[256];
+	PCRE2_SIZE erroffset;
+	int options = PCRE2_MULTILINE;
+	const uint8_t *character_tables = NULL;
+	int jitret;
+
+	assert(opt->pcre2);
+
+	p->pcre2_compile_context = NULL;
+
+	if (opt->ignore_case) {
+		if (has_non_ascii(p->pattern)) {
+			character_tables = pcre2_maketables(NULL);
+			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
+			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
+		}
+		options |= PCRE2_CASELESS;
+	}
+	if (is_utf8_locale() && has_non_ascii(p->pattern))
+		options |= PCRE2_UTF;
+
+	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
+					 p->patternlen, options, &error, &erroffset,
+					 p->pcre2_compile_context);
+
+	if (p->pcre2_pattern) {
+		p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, NULL);
+		if (!p->pcre2_match_data)
+			die("Couldn't allocate PCRE2 match data");
+	} else {
+		pcre2_get_error_message(error, errbuf, sizeof(errbuf));
+		compile_regexp_failed(p, (const char *)&errbuf);
+	}
+
+	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
+	if (p->pcre2_jit_on == 1) {
+		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
+		if (!jitret)
+			p->pcre2_jit_on = 1;
+		else
+			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+		p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 * 1024, NULL);
+		if (!p->pcre2_jit_stack)
+			die("Couldn't allocate PCRE2 JIT stack");
+		p->pcre2_match_context = pcre2_match_context_create(NULL);
+		if (!p->pcre2_jit_stack)
+			die("Couldn't allocate PCRE2 match context");
+		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
+	} else if (p->pcre2_jit_on != 0) {
+		die("BUG: The pcre2_jit_on variable should be 0 or 1, not %d",
+		    p->pcre1_jit_on);
+	}
+}
+
+static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
+		regmatch_t *match, int eflags)
+{
+	int ret, flags = 0;
+	PCRE2_SIZE *ovector;
+	PCRE2_UCHAR errbuf[256];
+
+	if (eflags & REG_NOTBOL)
+		flags |= PCRE2_NOTBOL;
+
+	if (p->pcre2_jit_on)
+		ret = pcre2_jit_match(p->pcre2_pattern, (unsigned char *)line,
+				      eol - line, 0, flags, p->pcre2_match_data,
+				      NULL);
+	else
+		ret = pcre2_match(p->pcre2_pattern, (unsigned char *)line,
+				  eol - line, 0, flags, p->pcre2_match_data,
+				  NULL);
+
+	if (ret < 0 && ret != PCRE2_ERROR_NOMATCH) {
+		pcre2_get_error_message(ret, errbuf, sizeof(errbuf));
+		die("%s failed with error code %d: %s",
+		    (p->pcre2_jit_on ? "pcre2_jit_match" : "pcre2_match"), ret,
+		    errbuf);
+	}
+	if (ret > 0) {
+		ovector = pcre2_get_ovector_pointer(p->pcre2_match_data);
+		ret = 0;
+		match->rm_so = (int)ovector[0];
+		match->rm_eo = (int)ovector[1];
+	}
+
+	return ret;
+}
+
+static void free_pcre2_pattern(struct grep_pat *p)
+{
+	pcre2_compile_context_free(p->pcre2_compile_context);
+	pcre2_code_free(p->pcre2_pattern);
+	pcre2_match_data_free(p->pcre2_match_data);
+	pcre2_jit_stack_free(p->pcre2_jit_stack);
+	pcre2_match_context_free(p->pcre2_match_context);
+}
+#else /* !USE_LIBPCRE2 */
+static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
+{
+	/*
+	 * Unreachable until USE_LIBPCRE2 becomes synonymous with
+	 * USE_LIBPCRE. See the sibling comment in
+	 * grep_set_pattern_type_option().
+	 */
+	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE");
+}
+
+static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
+		regmatch_t *match, int eflags)
+{
+	return 1;
+}
+
+static void free_pcre2_pattern(struct grep_pat *p)
+{
+}
+#endif /* !USE_LIBPCRE2 */
+
 static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -511,6 +649,11 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
+	if (opt->pcre2) {
+		compile_pcre2_pattern(p, opt);
+		return;
+	}
+
 	if (opt->pcre1) {
 		compile_pcre1_regexp(p, opt);
 		return;
@@ -870,6 +1013,8 @@ void free_grep_patterns(struct grep_opt *opt)
 				kwsfree(p->kws);
 			else if (p->pcre1_regexp)
 				free_pcre1_regexp(p);
+			else if (p->pcre2_pattern)
+				free_pcre2_pattern(p);
 			else
 				regfree(&p->regexp);
 			free(p->pattern);
@@ -950,6 +1095,8 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 		hit = !fixmatch(p, line, eol, match);
 	else if (p->pcre1_regexp)
 		hit = !pcre1match(p, line, eol, match, eflags);
+	else if (p->pcre2_pattern)
+		hit = !pcre2match(p, line, eol, match, eflags);
 	else
 		hit = !regexec_buf(&p->regexp, line, eol - line, 1, match,
 				   eflags);
diff --git a/grep.h b/grep.h
index ce90969736..246f6695c1 100644
--- a/grep.h
+++ b/grep.h
@@ -19,6 +19,16 @@ typedef int pcre;
 typedef int pcre_extra;
 typedef int pcre_jit_stack;
 #endif
+#ifdef USE_LIBPCRE2
+#define PCRE2_CODE_UNIT_WIDTH 8
+#include <pcre2.h>
+#else
+typedef int pcre2_code;
+typedef int pcre2_match_data;
+typedef int pcre2_compile_context;
+typedef int pcre2_match_context;
+typedef int pcre2_jit_stack;
+#endif
 #include "kwset.h"
 #include "thread-utils.h"
 #include "userdiff.h"
@@ -63,6 +73,12 @@ struct grep_pat {
 	pcre_jit_stack *pcre1_jit_stack;
 	const unsigned char *pcre1_tables;
 	int pcre1_jit_on;
+	pcre2_code *pcre2_pattern;
+	pcre2_match_data *pcre2_match_data;
+	pcre2_compile_context *pcre2_compile_context;
+	pcre2_match_context *pcre2_match_context;
+	pcre2_jit_stack *pcre2_jit_stack;
+	uint32_t pcre2_jit_on;
 	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
@@ -126,6 +142,7 @@ struct grep_opt {
 	int extended;
 	int use_reflog_filter;
 	int pcre1;
+	int pcre2;
 	int relative;
 	int pathname;
 	int null_following_name;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 43529451f9..f5da636bea 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1015,7 +1015,7 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
-test -n "$USE_LIBPCRE1" && test_set_prereq PCRE
+test -n "$USE_LIBPCRE1$USE_LIBPCRE2" && test_set_prereq PCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-- 
2.13.0.303.g4ebf302169

