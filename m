Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E88B207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993566AbdDYVHH (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:07:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35631 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954745AbdDYVG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so28448586wmi.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SenQGL84pkTHPddQR92D719BGhHAQeU+2y1y2QpYJso=;
        b=ME4oJD+drhgRXvPtwMendc2Z8rjxNoG0gpZ8GDI6DrGni9U+jnywCsAriiHLxsT7vB
         DKl+US8sSMHnzUDwNZ7lqAgKRPmzJATdr/WgWmI6Jg4uWG4UT699+nk6YI6ZFzxV+HsI
         PT0VGzCeUCUvoEmwW/m5o83juinFJWAGcq9JvrYLq5oRXWiPX0kH7GK8hKibf9m5UMGq
         f3WpS/vE6lgOOtxEtRGog4Mn6UjjZia5S5+JHAhWpmiKLT/Pt23eyMFG8IYCg87PBoJM
         HomSYsR0wcDWX5HVZkr5eKk/llRb8rhIqvXEC73tl5qM4MHe4/DAXceyvKIkRTKoV1Z3
         QUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SenQGL84pkTHPddQR92D719BGhHAQeU+2y1y2QpYJso=;
        b=DMvxMMu56MmZ5xxNT6Z9ATXRaBkPOiSDPQAjled9Xm4I4ZXGOHb+egTo4VTbst/Gct
         CH+AmLW4W3Vj8+aqveNczZztcrn4HuvssJWfs5+BEL7334BpsUMoP/i/S2ueqs9Oz3bC
         A7OxOvOPtTfWFY5my4HPKXA+H8xw3vnH4wSpuSG/E/Cpbz5ZUS856jV3O32D1NXMJ6Ql
         Yn7xPrydxoDiKBw2gipZY0dTSS0skDhKvA4CS1vHmhHrDyCxalqvJhx/f+RIFXSmACoz
         +JL5fQiJZdl0WJbaMx3G9hClDCx4oH4XWoBxyQ1sZuu2NAu48okRP9wa+6RRPpTQWa8b
         vHSg==
X-Gm-Message-State: AN3rC/4pTxtFqjwD2Q2VIvpQLaPJUzIt8VYvgjh6JgnGddlzb1gvOUoU
        UZ2PXVmQXOv3v71ca78=
X-Received: by 10.28.23.198 with SMTP id 189mr15273201wmx.38.1493154415105;
        Tue, 25 Apr 2017 14:06:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:54 -0700 (PDT)
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
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 18/19] grep: remove support for concurrent use of both PCRE v1 & v2
Date:   Tue, 25 Apr 2017 21:05:47 +0000
Message-Id: <20170425210548.24612-19-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the support for concurrently using PCRE v1 & v2 by compiling
Git with support for both at the same time.

Having access to both at runtime via grep.patternType=[pcre1|pcre2]
makes it easier for the developer hacking on the PCRE implementations
to test them concurrently, but adds confusion for everyone else,
particularly Git users who have no reason to concurrently use both
libraries.

Now either USE_LIBPCRE1=YesPlease (or its alias USE_LIBPCRE) or
USE_LIBPCRE2=YesPlease can be supplied when building git, but
providing both will yield an error, similarly providing both
--with-libpcre1 & --with-libpcre2 to the configure script will produce
an error.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt           |  7 ----
 Makefile                           | 36 +++++++++----------
 builtin/grep.c                     |  3 --
 configure.ac                       | 72 +++++++++++++++++++++-----------------
 grep.c                             | 19 +---------
 grep.h                             |  4 +--
 t/README                           | 12 -------
 t/perf/p7820-grep-engines.sh       |  2 +-
 t/t7810-grep.sh                    | 30 +---------------
 t/t7814-grep-recurse-submodules.sh | 14 +-------
 t/test-lib.sh                      |  5 ++-
 11 files changed, 65 insertions(+), 139 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a5fc482495..475e874d51 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1624,13 +1624,6 @@ grep.patternType::
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
 	value 'default' will return to the default matching behavior.
-+
-The 'perl' and 'pcre' values are synonyms. Depending on which PCRE
-library Git was compiled with either or both of 'pcre1' and 'pcre2'
-might also be available.
-+
-If both are available Git currently defaults to 'pcre1', but this
-might change in future versions.
 
 grep.extendedRegexp::
 	If set to true, enable `--extended-regexp` option by default. This
diff --git a/Makefile b/Makefile
index afdde49cda..a792f206b9 100644
--- a/Makefile
+++ b/Makefile
@@ -29,16 +29,13 @@ all::
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
-# Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
+# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
+# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
+# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
+# default in future releases.
 #
-# Define USE_LIBPCRE2 if you have and want to use libpcre2. Various
-# commands such as log and grep offer runtime options to use
-# Perl-compatible regular expressions instead of standard or extended
-# POSIX regular expressions.
-#
-# Define LIBPCRE2DIR=/foo/bar if your libpcre2 header and library
-# files are in /foo/bar/include and /foo/bar/lib directories.
+# Define LIBPCREDIR=/foo/bar if your PCRE header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
 #
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
 #
@@ -1093,24 +1090,27 @@ ifdef NO_LIBGEN_H
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
 
 ifdef USE_LIBPCRE2
 	BASIC_CFLAGS += -DUSE_LIBPCRE2
-	ifdef LIBPCRE2DIR
-		BASIC_CFLAGS += -I$(LIBPCRE2DIR)/include
-		EXTLIBS += -L$(LIBPCRE2DIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCR2EDIR)/$(lib)
-	endif
 	EXTLIBS += -lpcre2-8
 endif
 
+ifdef LIBPCREDIR
+	BASIC_CFLAGS += -I$(LIBPCREDIR)/include
+	EXTLIBS += -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib)
+endif
+
 ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
diff --git a/builtin/grep.c b/builtin/grep.c
index 178b10aa6f..be3dbd6957 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -495,9 +495,6 @@ static void compile_submodule_options(const struct grep_opt *opt,
 		break;
 	case GREP_PATTERN_TYPE_UNSPECIFIED:
 		break;
-	case GREP_PATTERN_TYPE_PCRE1:
-	case GREP_PATTERN_TYPE_PCRE2:
-		die("BUG: Command-line option for pcre1 or pcre2 added without updating switch statement");
 	default:
 		die("BUG: Added a new grep pattern type without updating switch statement");
 	}
diff --git a/configure.ac b/configure.ac
index 7ceb22ed03..11d083fbe0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -255,47 +255,63 @@ GIT_PARSE_WITH([openssl]))
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
-AS_HELP_STRING([--with-libpcre],[support Perl-compatible regexes via libpcre1 (default is NO)])
-AS_HELP_STRING([],           [ARG can be also prefix for libpcre1 library and headers]),
+AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre1]),
     if test "$withval" = "no"; then
-	USE_LIBPCRE=
+	USE_LIBPCRE1=
     elif test "$withval" = "yes"; then
-	USE_LIBPCRE=YesPlease
+	USE_LIBPCRE1=YesPlease
     else
-	USE_LIBPCRE=YesPlease
+	USE_LIBPCRE1=YesPlease
 	LIBPCREDIR=$withval
 	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
-        dnl USE_LIBPCRE can still be modified below, so don't substitute
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
         dnl it yet.
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
 
-# Define USE_LIBPCRE2 if you have and want to use libpcre2. Various
-# commands such as log and grep offer runtime options to use
-# Perl-compatible regular expressions instead of standard or extended
-# POSIX regular expressions.
-#
-# Define LIBPCR2EDIR=/foo/bar if your libpcre2 header and library
-# files are in /foo/bar/include and /foo/bar/lib directories.
-#
 AC_ARG_WITH(libpcre2,
 AS_HELP_STRING([--with-libpcre2],[support Perl-compatible regexes via libpcre2 (default is NO)])
 AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
+    if test -n "$USE_LIBPCRE1"; then
+        AC_MSG_ERROR([Only supply one of --with-libpcre1 or --with-libpcre2!])
+    fi
+
     if test "$withval" = "no"; then
 	USE_LIBPCRE2=
     elif test "$withval" = "yes"; then
 	USE_LIBPCRE2=YesPlease
     else
 	USE_LIBPCRE2=YesPlease
-	LIBPCRE2DIR=$withval
-	AC_MSG_NOTICE([Setting LIBPCRE2DIR to $LIBPCRE2DIR])
+	LIBPCREDIR=$withval
+	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
         dnl USE_LIBPCRE2 can still be modified below, so don't substitute
         dnl it yet.
-	GIT_CONF_SUBST([LIBPCRE2DIR])
+	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
 #
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
@@ -525,13 +541,11 @@ GIT_CONF_SUBST([NEEDS_SSL_WITH_CRYPTO])
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
 
@@ -541,26 +555,20 @@ AC_CHECK_LIB([pcre], [pcre_version],
 
 GIT_UNSTASH_FLAGS($LIBPCREDIR)
 
-GIT_CONF_SUBST([USE_LIBPCRE])
+GIT_CONF_SUBST([USE_LIBPCRE1])
 
 fi
 
-#
-# Define USE_LIBPCRE2 if you have and want to use libpcre2. Various
-# commands such as log and grep offer runtime options to use
-# Perl-compatible regular expressions instead of standard or extended
-# POSIX regular expressions.
-#
 
 if test -n "$USE_LIBPCRE2"; then
 
-GIT_STASH_FLAGS($LIBPCRE2DIR)
+GIT_STASH_FLAGS($LIBPCREDIR)
 
 AC_CHECK_LIB([pcre2-8], [pcre2_config_8],
 [USE_LIBPCRE2=YesPlease],
 [USE_LIBPCRE2=])
 
-GIT_UNSTASH_FLAGS($LIBPCRE2DIR)
+GIT_UNSTASH_FLAGS($LIBPCREDIR)
 
 GIT_CONF_SUBST([USE_LIBPCRE2])
 
diff --git a/grep.c b/grep.c
index dd5dff08f8..18a7f155a6 100644
--- a/grep.c
+++ b/grep.c
@@ -60,13 +60,8 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 		return GREP_PATTERN_TYPE_ERE;
 	else if (!strcmp(arg, "fixed"))
 		return GREP_PATTERN_TYPE_FIXED;
-	else if (!strcmp(arg, "perl") ||
-		 !strcmp(arg, "pcre"))
+	else if (!strcmp(arg, "perl"))
 		return GREP_PATTERN_TYPE_PCRE;
-	else if (!strcmp(arg, "pcre1"))
-		return GREP_PATTERN_TYPE_PCRE1;
-	else if (!strcmp(arg, "pcre2"))
-		return GREP_PATTERN_TYPE_PCRE2;
 	die("bad %s argument: %s", opt, arg);
 }
 
@@ -213,18 +208,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 		opt->pcre2 = 1;
 #endif
 		break;
-
-	case GREP_PATTERN_TYPE_PCRE1:
-		opt->fixed = 0;
-		opt->pcre1 = 1;
-		opt->pcre2 = 0;
-		break;
-
-	case GREP_PATTERN_TYPE_PCRE2:
-		opt->fixed = 0;
-		opt->pcre1 = 0;
-		opt->pcre2 = 1;
-		break;
 	}
 }
 
diff --git a/grep.h b/grep.h
index dd16b5fd53..1b56d327e2 100644
--- a/grep.h
+++ b/grep.h
@@ -89,9 +89,7 @@ enum grep_pattern_type {
 	GREP_PATTERN_TYPE_BRE,
 	GREP_PATTERN_TYPE_ERE,
 	GREP_PATTERN_TYPE_FIXED,
-	GREP_PATTERN_TYPE_PCRE,
-	GREP_PATTERN_TYPE_PCRE1,
-	GREP_PATTERN_TYPE_PCRE2
+	GREP_PATTERN_TYPE_PCRE
 };
 
 struct grep_expr {
diff --git a/t/README b/t/README
index 547b06e700..a90cb62583 100644
--- a/t/README
+++ b/t/README
@@ -808,18 +808,6 @@ use these, and "test_set_prereq" for how to define your own.
    Git was compiled with support for PCRE. Wrap any tests
    that use git-grep --perl-regexp or git-grep -P in these.
 
- - LIBPCRE1
-
-   Git was compiled with PCRE v1 support via
-   USE_LIBPCRE=YesPlease. Wrap any PCRE using tests that for some
-   reason need v1 of the PCRE library instead of v2 in these.
-
- - LIBPCRE2
-
-   Git was compiled with PCRE v2 support via
-   USE_LIBPCRE2=YesPlease. Wrap any PCRE using tests that for some
-   reason need v2 of the PCRE library instead of v1 in these.
-
  - CASE_INSENSITIVE_FS
 
    Test is run on a case insensitive file system.
diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
index 70c5a5ca32..96d993ec7d 100755
--- a/t/perf/p7820-grep-engines.sh
+++ b/t/perf/p7820-grep-engines.sh
@@ -7,7 +7,7 @@ test_description="Comparison of git-grep's regex engines"
 test_perf_large_repo
 test_checkout_worktree
 
-for engine in extended pcre1 pcre2
+for engine in extended perl
 do
 	# Patterns stolen from http://sljit.sourceforge.net/pcre.html
 	for pattern in \
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index bae7e524b9..f5f1b61e02 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1063,16 +1063,6 @@ test_expect_success PCRE 'grep -P pattern' '
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE1 'grep libpcre1 pattern' '
-	git -c grep.patternType=pcre1 grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success LIBPCRE2 'grep libpcre2 pattern' '
-	git -c grep.patternType=pcre2 grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
-	test_cmp expected actual
-'
-
 test_expect_success 'grep pattern with grep.extendedRegexp=true' '
 	>empty &&
 	test_must_fail git -c grep.extendedregexp=true \
@@ -1522,28 +1512,10 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
-test_expect_success PCRE "grep with grep.patternType synonyms perl/pcre" '
+test_expect_success PCRE "grep with grep.patternType synonyms perl" '
 	echo "#include <stdio.h>" >expected &&
 	git -c grep.patternType=perl  grep -h --no-line-number "st(?=dio)" >actual &&
-	test_cmp expected actual &&
-	git -c grep.patternType=pcre  grep -h --no-line-number "st(?=dio)" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE1 "grep with grep.patternType=pcre1" '
-	echo "#include <stdio.h>" >expected &&
-	git -c grep.patternType=pcre1 grep -h --no-line-number "st(?=dio)" >actual &&
-	test_cmp expected actual &&
-	test_must_fail git -c grep.patternType=pcre1 grep "foo(?+bar)" 2>error &&
-	test_i18ngrep -q "digit expected after" error
-'
-
-test_expect_success LIBPCRE2 "grep with grep.patternType=pcre2" '
-	echo "#include <stdio.h>" >expected &&
-	git -c grep.patternType=pcre2 grep -h --no-line-number "st(?=dio)" >actual &&
-	test_cmp expected actual &&
-	test_must_fail git -c grep.patternType=pcre2 grep "foo(?+bar)" 2>error &&
-	test_i18ngrep -q "digit expected after" error
-'
-
 test_done
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 7a8a48493b..ef658b7899 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -358,19 +358,7 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
 		EOF
 		test_cmp expect actual &&
 		git -c grep.patternType=perl grep --recurse-submodules -e "(.|.)[\d]" >actual &&
-		test_cmp expect actual &&
-		git -c grep.patternType=pcre grep --recurse-submodules -e "(.|.)[\d]" >actual &&
-		test_cmp expect actual &&
-		if test_have_prereq LIBPCRE1
-		then
-			git -c grep.patternType=pcre1 grep --recurse-submodules -e "(.|.)[\d]" >actual &&
-			test_cmp expect actual
-		fi &&
-		if test_have_prereq LIBPCRE2
-		then
-			git -c grep.patternType=pcre2 grep --recurse-submodules -e "(.|.)[\d]" >actual &&
-			test_cmp expect actual
-		fi
+		test_cmp expect actual
 	fi
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6f873de3e7..969f931ebf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1010,9 +1010,8 @@ esac
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
-test -n "$USE_LIBPCRE1$USE_LIBPCRE2" && test_set_prereq PCRE
-test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
-test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
+test -n "$USE_LIBPCRE1" && test_set_prereq PCRE
+test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-- 
2.11.0

