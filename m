Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DCE5207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993563AbdDYVHD (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:07:03 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37425 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954728AbdDYVGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:55 -0400
Received: by mail-wm0-f46.google.com with SMTP id m123so107744026wma.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEk42QDdQ8IQJwhlXRScYWjCK88pXmpkam3oyhojZzM=;
        b=SiLDEIhGylqgoRX6lp0sh9gPuoaaFEJMhXISp5kWQx3tCxuwZvWR+wKpXtFMmdiNEL
         Hxlo/KPtxgfDppIssXxQgJZNfDivNGGP1HziB7TwIsrRKiiGDYxu83nm18GFRsEJQ23L
         uJgxriPlHYiCdh3l8lBhxMKtCJFupxJuI/O9/Os87HHcoGdkpYM6zCMOFKP8/HT09zf+
         CsU1mwqWJ8GkKH784RPJdJYxN+Z30SULTvbY44STPppLmM9/TpOqvLDpSg0CH/8GjmcB
         toI/10o0KeZDBDn7wY78XO/69ed/6vo3EOncqs12tsouXYYgjqBh1nLgc+vOxeq2VXN+
         Fo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEk42QDdQ8IQJwhlXRScYWjCK88pXmpkam3oyhojZzM=;
        b=XhqMLsxFbs9QOh3Uyp/bOEcm9ESajQAod8hVGmLE0JEwSncp6+4Cu5QA9OnLM90MlJ
         1gUYT8lq/nnLQxc9hlgYDT1vTaa/pYmN28WfV3c6Ofw7JT0tJeD0PJkAcKzhzYDyu3OP
         tH5g2dGuBg1iaMgVNeYy1zFSu0uTaLBV35To+PjrdOCUHhJvK01QqFLUQ/vJaOItALWj
         STI9yaoWvLJvnkLKhLNLbTIC5PIrIv89AlzUVl7RmJKlrrK0K7wDwLSvtPMi0MFqqWvW
         tpzWf8Oxs0Se4KDkipqg1ngLXU0OgXy/q6R2ZBB8HELu9hSm4/L8BWWg7K1yUxdQIDRR
         Scfw==
X-Gm-Message-State: AN3rC/7b1ngRYsN2NABBT2KDQ0xXEplpw7QPHkBEASPm/TjwK2R3vDC+
        a+A4ZjCZ3fxzNw==
X-Received: by 10.28.113.73 with SMTP id m70mr14879548wmc.12.1493154412969;
        Tue, 25 Apr 2017 14:06:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:51 -0700 (PDT)
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
Subject: [PATCH v4 17/19] grep: add support for PCRE v2
Date:   Tue, 25 Apr 2017 21:05:46 +0000
Message-Id: <20170425210548.24612-18-avarab@gmail.com>
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

Add support for v2 of the PCRE API. This is a new major version of
PCRE that came out in early 2015[1].

The regular expression syntax is the same, but while the API is
similar-ish, pretty much every function is either renamed or takes
different arguments. Thus using it via entirely new functions makes
sense, as opposed to trying to e.g. have one compile_pcre_pattern()
that would call either PCRE v1 or v2 functions.

Git can now be compiled with any combination of
USE_LIBPCRE=[YesPlease|] & USE_LIBPCRE2=[YesPlease|]. If both are
provided the version of the PCRE library can be selected at runtime
with grep.PatternType, but the default (for now) is v1.

This table shows what the various combinations do, depending on what
libraries Git is compiled against:

    |------------------+-----+-----+----------|
    | grep.PatternType | v1  | v2  | v1 && v2 |
    |------------------+-----+-----+----------|
    | perl             | v1  | v2  | v1       |
    | pcre             | v1  | v2  | v1       |
    | pcre1            | v1  | ERR | v1       |
    | pcre2            | ERR | v2  | v2       |
    |------------------+-----+-----+----------|

When Git is only compiled with v2 grep.PatternType=perl, --perl-regexp
& -P will use v2. All tests pass with this new PCRE version. When Git
is compiled with both v1 & v2 most of the tests will only test v1, but
there are some v2-specific tests that will be run.

With earlier patches to enable JIT for PCRE v1 the performance of the
release versions of both libraries have almost exactly the same
performance, with PCRE v2 being around 1% slower.

However after I reported this to the pcre-dev mailing list[2] I got a
lot of help with the API use from Zolt√°n Herczeg, he
subsequently optimized some of the JIT functionality in v2 of the
library.

Running the p7820-grep-engines.sh performance test against the latest
Subversion trunk of both, with both them and git compiled as -O3, and
the test run against linux.git, gives the following results:

    7820.1: extended with how.to                               0.27(1.22+0.34)
    7820.2: extended with ^how to                              0.27(1.18+0.36)
    7820.3: extended with \w+our\w*                            6.09(38.64+0.32)
    7820.4: extended with -?-?-?-?-?-?-?-?-?-?-?-----------$   0.38(1.69+0.28)
    7820.5: pcre1 with how.to                                  0.19(0.42+0.53)
    7820.6: pcre1 with ^how to                                 0.23(0.58+0.50)
    7820.7: pcre1 with \w+our\w*                               0.50(2.93+0.34)
    7820.8: pcre1 with -?-?-?-?-?-?-?-?-?-?-?-----------$      5.12(19.32+0.38)
    7820.9: pcre2 with how.to                                  0.19(0.34+0.57)
    7820.10: pcre2 with ^how to                                0.19(0.29+0.60)
    7820.11: pcre2 with \w+our\w*                              0.51(2.85+0.41)
    7820.12: pcre2 with -?-?-?-?-?-?-?-?-?-?-?-----------$     5.04(19.27+0.31)

I.e. the two are neck-to-neck, but PCRE v2 usually pulls ahead, when
it does it's up to 20% faster.

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

Signed-off-by: √Üvar Arnfj√∂r√∞ Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt           |  14 ++--
 Makefile                           |  18 +++++
 builtin/grep.c                     |   7 +-
 configure.ac                       |  49 +++++++++++-
 grep.c                             | 154 ++++++++++++++++++++++++++++++++++++-
 grep.h                             |  21 ++++-
 revision.c                         |   2 +-
 t/README                           |  12 +++
 t/perf/p7820-grep-engines.sh       |   2 +-
 t/t7810-grep.sh                    |  30 +++++++-
 t/t7813-grep-icase-iso.sh          |  11 ++-
 t/t7814-grep-recurse-submodules.sh |  12 ++-
 t/test-lib.sh                      |   4 +-
 13 files changed, 309 insertions(+), 27 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5ef12d0694..a5fc482495 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1625,14 +1625,12 @@ grep.patternType::
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
 	value 'default' will return to the default matching behavior.
 +
-The 'pcre' and 'pcre1' values are synonyms for 'perl'. The other
-values starting with 'pcre' are reserved for future use, e.g. if we'd
-like to use 'pcre2' for the PCRE v2 library.
-+
-In the future 'perl' and 'pcre' might become synonyms for some other
-implementation or PCRE version, such as 'pcre2', while the more
-specific 'pcre1' & 'pcre2' might throw errors depending on whether git
-is compiled to include those libraries.
+The 'perl' and 'pcre' values are synonyms. Depending on which PCRE
+library Git was compiled with either or both of 'pcre1' and 'pcre2'
+might also be available.
++
+If both are available Git currently defaults to 'pcre1', but this
+might change in future versions.
 
 grep.extendedRegexp::
 	If set to true, enable `--extended-regexp` option by default. This
diff --git a/Makefile b/Makefile
index aecdfdcfe6..afdde49cda 100644
--- a/Makefile
+++ b/Makefile
@@ -32,6 +32,14 @@ all::
 # Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+# Define USE_LIBPCRE2 if you have and want to use libpcre2. Various
+# commands such as log and grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
+#
+# Define LIBPCRE2DIR=/foo/bar if your libpcre2 header and library
+# files are in /foo/bar/include and /foo/bar/lib directories.
+#
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
 #
 # Define NO_CURL if you do not have libcurl installed.  git-http-fetch and
@@ -1094,6 +1102,15 @@ ifdef USE_LIBPCRE
 	EXTLIBS += -lpcre
 endif
 
+ifdef USE_LIBPCRE2
+	BASIC_CFLAGS += -DUSE_LIBPCRE2
+	ifdef LIBPCRE2DIR
+		BASIC_CFLAGS += -I$(LIBPCRE2DIR)/include
+		EXTLIBS += -L$(LIBPCRE2DIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCR2EDIR)/$(lib)
+	endif
+	EXTLIBS += -lpcre2-8
+endif
+
 ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
@@ -2239,6 +2256,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
 	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
+	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
diff --git a/builtin/grep.c b/builtin/grep.c
index 28e0dd3236..178b10aa6f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -490,11 +490,14 @@ static void compile_submodule_options(const struct grep_opt *opt,
 	case GREP_PATTERN_TYPE_FIXED:
 		argv_array_push(&submodule_options, "-F");
 		break;
-	case GREP_PATTERN_TYPE_PCRE1:
+	case GREP_PATTERN_TYPE_PCRE:
 		argv_array_push(&submodule_options, "-P");
 		break;
 	case GREP_PATTERN_TYPE_UNSPECIFIED:
 		break;
+	case GREP_PATTERN_TYPE_PCRE1:
+	case GREP_PATTERN_TYPE_PCRE2:
+		die("BUG: Command-line option for pcre1 or pcre2 added without updating switch statement");
 	default:
 		die("BUG: Added a new grep pattern type without updating switch statement");
 	}
@@ -1022,7 +1025,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_FIXED),
 		OPT_SET_INT('P', "perl-regexp", &pattern_type_arg,
 			    N_("use Perl-compatible regular expressions"),
-			    GREP_PATTERN_TYPE_PCRE1),
+			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
diff --git a/configure.ac b/configure.ac
index deeb968daa..7ceb22ed03 100644
--- a/configure.ac
+++ b/configure.ac
@@ -259,8 +259,8 @@ GIT_PARSE_WITH([openssl]))
 # /foo/bar/include and /foo/bar/lib directories.
 #
 AC_ARG_WITH(libpcre,
-AS_HELP_STRING([--with-libpcre],[support Perl-compatible regexes (default is NO)])
-AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
+AS_HELP_STRING([--with-libpcre],[support Perl-compatible regexes via libpcre1 (default is NO)])
+AS_HELP_STRING([],           [ARG can be also prefix for libpcre1 library and headers]),
     if test "$withval" = "no"; then
 	USE_LIBPCRE=
     elif test "$withval" = "yes"; then
@@ -273,6 +273,30 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
         dnl it yet.
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
+
+# Define USE_LIBPCRE2 if you have and want to use libpcre2. Various
+# commands such as log and grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
+#
+# Define LIBPCR2EDIR=/foo/bar if your libpcre2 header and library
+# files are in /foo/bar/include and /foo/bar/lib directories.
+#
+AC_ARG_WITH(libpcre2,
+AS_HELP_STRING([--with-libpcre2],[support Perl-compatible regexes via libpcre2 (default is NO)])
+AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
+    if test "$withval" = "no"; then
+	USE_LIBPCRE2=
+    elif test "$withval" = "yes"; then
+	USE_LIBPCRE2=YesPlease
+    else
+	USE_LIBPCRE2=YesPlease
+	LIBPCRE2DIR=$withval
+	AC_MSG_NOTICE([Setting LIBPCRE2DIR to $LIBPCRE2DIR])
+        dnl USE_LIBPCRE2 can still be modified below, so don't substitute
+        dnl it yet.
+	GIT_CONF_SUBST([LIBPCRE2DIR])
+    fi)
 #
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
 AC_FUNC_ALLOCA
@@ -522,6 +546,27 @@ GIT_CONF_SUBST([USE_LIBPCRE])
 fi
 
 #
+# Define USE_LIBPCRE2 if you have and want to use libpcre2. Various
+# commands such as log and grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
+#
+
+if test -n "$USE_LIBPCRE2"; then
+
+GIT_STASH_FLAGS($LIBPCRE2DIR)
+
+AC_CHECK_LIB([pcre2-8], [pcre2_config_8],
+[USE_LIBPCRE2=YesPlease],
+[USE_LIBPCRE2=])
+
+GIT_UNSTASH_FLAGS($LIBPCRE2DIR)
+
+GIT_CONF_SUBST([USE_LIBPCRE2])
+
+fi
+
+#
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
diff --git a/grep.c b/grep.c
index 8e3ba164b5..dd5dff08f8 100644
--- a/grep.c
+++ b/grep.c
@@ -61,9 +61,12 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 	else if (!strcmp(arg, "fixed"))
 		return GREP_PATTERN_TYPE_FIXED;
 	else if (!strcmp(arg, "perl") ||
-		 !strcmp(arg, "pcre") ||
-		 !strcmp(arg, "pcre1"))
+		 !strcmp(arg, "pcre"))
+		return GREP_PATTERN_TYPE_PCRE;
+	else if (!strcmp(arg, "pcre1"))
 		return GREP_PATTERN_TYPE_PCRE1;
+	else if (!strcmp(arg, "pcre2"))
+		return GREP_PATTERN_TYPE_PCRE2;
 	die("bad %s argument: %s", opt, arg);
 }
 
@@ -181,22 +184,46 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
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
+		break;
+
+	case GREP_PATTERN_TYPE_PCRE:
+		opt->fixed = 0;
+		/* We default to pcre1 if we have both versions. This
+		 * may change in future versions.
+		 */
+#ifdef USE_LIBPCRE1
+		opt->pcre1 = 1;
+		opt->pcre2 = 0;
+#elif USE_LIBPCRE2
+		opt->pcre1 = 0;
+		opt->pcre2 = 1;
+#endif
 		break;
 
 	case GREP_PATTERN_TYPE_PCRE1:
 		opt->fixed = 0;
 		opt->pcre1 = 1;
+		opt->pcre2 = 0;
+		break;
+
+	case GREP_PATTERN_TYPE_PCRE2:
+		opt->fixed = 0;
+		opt->pcre1 = 0;
+		opt->pcre2 = 1;
 		break;
 	}
 }
@@ -417,6 +444,120 @@ static void free_pcre1_regexp(struct grep_pat *p)
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
+	uint32_t canjit;
+	int jitret;
+
+	p->pcre2_ccontext = NULL;
+
+	if (opt->ignore_case) {
+		if (has_non_ascii(p->pattern)) {
+			character_tables = pcre2_maketables(NULL);
+			p->pcre2_ccontext = pcre2_compile_context_create(NULL);
+			pcre2_set_character_tables(p->pcre2_ccontext, character_tables);
+		}
+		options |= PCRE2_CASELESS;
+	}
+	if (is_utf8_locale() && has_non_ascii(p->pattern))
+		options |= PCRE2_UTF;
+
+	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
+					 p->patternlen, options, &error, &erroffset,
+					 p->pcre2_ccontext);
+
+	if (p->pcre2_pattern) {
+		p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, NULL);
+		if (!p->pcre2_match_data)
+			die("BUG: Couldn't allocate PCRE2 match data");
+	} else {
+		pcre2_get_error_message(error, errbuf, sizeof(errbuf));
+		compile_regexp_failed(p, (const char *)&errbuf);
+	}
+
+	pcre2_config(PCRE2_CONFIG_JIT, &canjit);
+	if (canjit == 1) {
+		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
+		if (!jitret)
+			p->pcre2_jit_on = 1;
+		else
+			die("BUG: Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+		p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 * 1024, NULL);
+		if (!p->pcre2_jit_stack)
+			die("BUG: Couldn't allocate PCRE2 JIT stack");
+		p->pcre2_match_context = pcre2_match_context_create(NULL);
+		if (!p->pcre2_jit_stack)
+			die("BUG: Couldn't allocate PCRE2 match context");
+		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
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
+	pcre2_compile_context_free(p->pcre2_ccontext);
+	pcre2_code_free(p->pcre2_pattern);
+	pcre2_match_data_free(p->pcre2_match_data);
+	pcre2_jit_stack_free(p->pcre2_jit_stack);
+	pcre2_match_context_free(p->pcre2_match_context);
+}
+#else /* !USE_LIBPCRE2 */
+static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
+{
+	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE2");
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
 static int is_fixed(const char *s, size_t len)
 {
 	size_t i;
@@ -503,6 +644,11 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
+	if (opt->pcre2) {
+		compile_pcre2_pattern(p, opt);
+		return;
+	}
+
 	err = regcomp(&p->regexp, p->pattern, opt->regflags);
 	if (err) {
 		char errbuf[1024];
@@ -857,6 +1003,8 @@ void free_grep_patterns(struct grep_opt *opt)
 				kwsfree(p->kws);
 			else if (p->pcre1_regexp)
 				free_pcre1_regexp(p);
+			else if (p->pcre2_pattern)
+				free_pcre2_pattern(p);
 			else
 				regfree(&p->regexp);
 			free(p->pattern);
@@ -937,6 +1085,8 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 		hit = !fixmatch(p, line, eol, match);
 	else if (p->pcre1_regexp)
 		hit = !pcre1match(p, line, eol, match, eflags);
+	else if (p->pcre2_pattern)
+		hit = !pcre2match(p, line, eol, match, eflags);
 	else
 		hit = !regexec_buf(&p->regexp, line, eol - line, 1, match,
 				   eflags);
diff --git a/grep.h b/grep.h
index 29e20bf837..dd16b5fd53 100644
--- a/grep.h
+++ b/grep.h
@@ -11,6 +11,16 @@ typedef int pcre;
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
@@ -54,6 +64,12 @@ struct grep_pat {
 	pcre_extra *pcre1_extra_info;
 	pcre_jit_stack *pcre1_jit_stack;
 	const unsigned char *pcre1_tables;
+	pcre2_code *pcre2_pattern;
+	pcre2_match_data *pcre2_match_data;
+	pcre2_compile_context *pcre2_ccontext;
+	pcre2_match_context *pcre2_match_context;
+	pcre2_jit_stack *pcre2_jit_stack;
+	int pcre2_jit_on;
 	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
@@ -73,7 +89,9 @@ enum grep_pattern_type {
 	GREP_PATTERN_TYPE_BRE,
 	GREP_PATTERN_TYPE_ERE,
 	GREP_PATTERN_TYPE_FIXED,
-	GREP_PATTERN_TYPE_PCRE1
+	GREP_PATTERN_TYPE_PCRE,
+	GREP_PATTERN_TYPE_PCRE1,
+	GREP_PATTERN_TYPE_PCRE2
 };
 
 struct grep_expr {
@@ -117,6 +135,7 @@ struct grep_opt {
 	int extended;
 	int use_reflog_filter;
 	int pcre1;
+	int pcre2;
 	int relative;
 	int pathname;
 	int null_following_name;
diff --git a/revision.c b/revision.c
index 7a10a8570a..03a3a012de 100644
--- a/revision.c
+++ b/revision.c
@@ -1996,7 +1996,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
 	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
-		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE1;
+		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
 	} else if (!strcmp(arg, "--invert-grep")) {
diff --git a/t/README b/t/README
index a90cb62583..547b06e700 100644
--- a/t/README
+++ b/t/README
@@ -808,6 +808,18 @@ use these, and "test_set_prereq" for how to define your own.
    Git was compiled with support for PCRE. Wrap any tests
    that use git-grep --perl-regexp or git-grep -P in these.
 
+ - LIBPCRE1
+
+   Git was compiled with PCRE v1 support via
+   USE_LIBPCRE=YesPlease. Wrap any PCRE using tests that for some
+   reason need v1 of the PCRE library instead of v2 in these.
+
+ - LIBPCRE2
+
+   Git was compiled with PCRE v2 support via
+   USE_LIBPCRE2=YesPlease. Wrap any PCRE using tests that for some
+   reason need v2 of the PCRE library instead of v1 in these.
+
  - CASE_INSENSITIVE_FS
 
    Test is run on a case insensitive file system.
diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
index 5ae42ceccc..70c5a5ca32 100755
--- a/t/perf/p7820-grep-engines.sh
+++ b/t/perf/p7820-grep-engines.sh
@@ -7,7 +7,7 @@ test_description="Comparison of git-grep's regex engines"
 test_perf_large_repo
 test_checkout_worktree
 
-for engine in extended pcre1
+for engine in extended pcre1 pcre2
 do
 	# Patterns stolen from http://sljit.sourceforge.net/pcre.html
 	for pattern in \
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f929b447e9..bae7e524b9 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1063,6 +1063,16 @@ test_expect_success PCRE 'grep -P pattern' '
 	test_cmp expected actual
 '
 
+test_expect_success LIBPCRE1 'grep libpcre1 pattern' '
+	git -c grep.patternType=pcre1 grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE2 'grep libpcre2 pattern' '
+	git -c grep.patternType=pcre2 grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'grep pattern with grep.extendedRegexp=true' '
 	>empty &&
 	test_must_fail git -c grep.extendedregexp=true \
@@ -1512,14 +1522,28 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
-test_expect_success PCRE "grep with grep.patternType synonyms perl/pcre/pcre1" '
+test_expect_success PCRE "grep with grep.patternType synonyms perl/pcre" '
 	echo "#include <stdio.h>" >expected &&
 	git -c grep.patternType=perl  grep -h --no-line-number "st(?=dio)" >actual &&
 	test_cmp expected actual &&
 	git -c grep.patternType=pcre  grep -h --no-line-number "st(?=dio)" >actual &&
-	test_cmp expected actual &&
-	git -c grep.patternType=pcre1 grep -h --no-line-number "st(?=dio)" >actual &&
 	test_cmp expected actual
 '
 
+test_expect_success LIBPCRE1 "grep with grep.patternType=pcre1" '
+	echo "#include <stdio.h>" >expected &&
+	git -c grep.patternType=pcre1 grep -h --no-line-number "st(?=dio)" >actual &&
+	test_cmp expected actual &&
+	test_must_fail git -c grep.patternType=pcre1 grep "foo(?+bar)" 2>error &&
+	test_i18ngrep -q "digit expected after" error
+'
+
+test_expect_success LIBPCRE2 "grep with grep.patternType=pcre2" '
+	echo "#include <stdio.h>" >expected &&
+	git -c grep.patternType=pcre2 grep -h --no-line-number "st(?=dio)" >actual &&
+	test_cmp expected actual &&
+	test_must_fail git -c grep.patternType=pcre2 grep "foo(?+bar)" 2>error &&
+	test_i18ngrep -q "digit expected after" error
+'
+
 test_done
diff --git a/t/t7813-grep-icase-iso.sh b/t/t7813-grep-icase-iso.sh
index 701e08a8e5..e16570690c 100755
--- a/t/t7813-grep-icase-iso.sh
+++ b/t/t7813-grep-icase-iso.sh
@@ -11,9 +11,12 @@ test_expect_success GETTEXT_ISO_LOCALE 'setup' '
 	export LC_ALL
 '
 
-test_expect_success GETTEXT_ISO_LOCALE,PCRE 'grep pcre string' '
-	git grep --perl-regexp -i "TILRAUN: H.llÛ Heimur!" &&
-	git grep --perl-regexp -i "TILRAUN: H.LL” HEIMUR!"
-'
+for pcrev in 1 2
+do
+	test_expect_success GETTEXT_ISO_LOCALE,LIBPCRE$pcrev "grep -i with i18n string using libpcre$pcrev" "
+		git -c grep.patternType=pcre$pcrev grep -i \"TILRAUN: H.llÛ Heimur!\" &&
+		git -c grep.patternType=pcre$pcrev grep -i \"TILRAUN: H.LL” HEIMUR!\"
+	"
+done
 
 test_done
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index dc6cf771ec..7a8a48493b 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -361,8 +361,16 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
 		test_cmp expect actual &&
 		git -c grep.patternType=pcre grep --recurse-submodules -e "(.|.)[\d]" >actual &&
 		test_cmp expect actual &&
-		git -c grep.patternType=pcre1 grep --recurse-submodules -e "(.|.)[\d]" >actual &&
-		test_cmp expect actual
+		if test_have_prereq LIBPCRE1
+		then
+			git -c grep.patternType=pcre1 grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+			test_cmp expect actual
+		fi &&
+		if test_have_prereq LIBPCRE2
+		then
+			git -c grep.patternType=pcre2 grep --recurse-submodules -e "(.|.)[\d]" >actual &&
+			test_cmp expect actual
+		fi
 	fi
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e5cfbcc36b..6f873de3e7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1010,7 +1010,9 @@ esac
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
-test -n "$USE_LIBPCRE1" && test_set_prereq PCRE
+test -n "$USE_LIBPCRE1$USE_LIBPCRE2" && test_set_prereq PCRE
+test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
+test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-- 
2.11.0

