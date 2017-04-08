Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1B620970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbdDHN01 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:26:27 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34988 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbdDHN0X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:26:23 -0400
Received: by mail-wm0-f47.google.com with SMTP id w64so9796047wma.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANwlAzril7/OYq0x0qxgikTFM4Mv2lUWoyRODZKxQyo=;
        b=bKODTN+f7JkAhj64SjcEvtMYpTiKdSHEn+n+Le1HmZVNRc91D3TBnY31JuUeSo/rK9
         j7dNz5/Ab2oVmCkyy2JuFxDtjAlBPpzsPz7Lv4IMWEE3G2XhIqYzMNaJ4MCyYi7G1+0T
         A+SF5CUKopruvQxx9csZL8FRPJo/ztffGMrnw4G1iOE+SlFIElqbxt+uccbedwJY4spb
         L+HHvfGZ3aM6UUK0FJ35ykzRHDyaYR08BB7ymMargxJNp9FLozO+JYNnBWh66DO2bEFf
         zpfW1aXHtkW2LmZuXho2O9E+qf4CvoGd0RzkiVti5A/JYSkzrXGDQuLCXJncuYHvOhwg
         SFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANwlAzril7/OYq0x0qxgikTFM4Mv2lUWoyRODZKxQyo=;
        b=teCX3wO/Uyo+gxOYxiqEEpo5t4ITOnF4/B2pttlnBvsXapEb5K2M4oaycTRCDvxxJh
         o+YmrbG8HKXZ+UwJnokM95dBF8F/o6IbQVRGZbyoE50KbPazs9zj2o+5MN/vm64HKmWW
         qxOJm/qLnpQGnkV8rrrAEwjRsBebuODIwL6xvareEW4igYjhqGXQIKjd4vPqMUKBHgvr
         f9LRnH/bH5rCXNqvqVe/ZjSMrK5enU91DhjjrWaewb7yG4+i4sxhJhauJHsses1kqAW6
         Q4U/crDGghdfF3ed+oNoRRu3SlCBw//aIKyAQ6T3wM1aMuMGK9iYWTqiIYo3zwOSDQ24
         c4gw==
X-Gm-Message-State: AN3rC/7SxmMleixxsHCVlKZY+rSM0TstVpz5k4VzA8GNHPEUyatWVHurBzBBRwJ3OAVqcg==
X-Received: by 10.28.214.133 with SMTP id n127mr3102463wmg.70.1491657980462;
        Sat, 08 Apr 2017 06:26:20 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:26:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/12] grep: add support for PCRE v2
Date:   Sat,  8 Apr 2017 13:25:06 +0000
Message-Id: <20170408132506.5415-13-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for v2 of the PCRE API. This is a new major version of
PCRE that came out in early 2015[1]. The regular expression syntax is
the same, but while similar-ish requires a different codepath to
support it.

Git can now be compiled with any combination of
USE_LIBPCRE=[YesPlease|] & USE_LIBPCRE2=[YesPlease|]. If both are
provided the version of the PCRE library can be selected at runtime
with grep.PatternType, but the default (for now) is v1. This table
shows what the various combinations do depending on what libraries Git
is compiled against:

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

Originally I started work on this series because my ad-hoc patch to
support v2 ("Very promising results with libpcre2",
<CACBZZX6FcHcY7cYs6s_pv=E43cHNmzyUY5wrcuhPWWmUixCL+g@mail.gmail.com>)
showed very promising performance results. E.g. grepping a rare string
on the linux.git tree for 50 iterations gives[2]:

             s/iter    basic extended    pcre1    fixed    pcre2
    basic      2.31       --      -5%      -6%     -36%     -46%
    extended   2.20       5%       --      -1%     -32%     -44%
    pcre1      2.17       6%       1%       --     -32%     -43%
    fixed      1.49      56%      48%      46%       --     -17%
    pcre2      1.24      87%      77%      75%      20%       --

I.e. PCRE v2 is around 20% faster than the previously fastest codepath
to grep for a fixed string, while grepping for a similar regex. A
similar test for 'log --grep' is less promising[3]:

             s/iter extended    basic    pcre2    pcre1    fixed
    extended   8.36       --      -0%      -1%      -6%     -11%
    basic      8.35       0%       --      -1%      -5%     -11%
    pcre2      8.26       1%       1%       --      -4%     -10%
    pcre1      7.90       6%       6%       5%       --      -6%
    fixed      7.44      12%      12%      11%       6%       --

Here PCRE v2 is around 5% slower than v1. I don't know why that
is. Perhaps PCRE v2 is worse at matching shorter strings, commit
messages tend to be shorter than files.

I eventually found out though that the main difference in v1 and v2
performance is because v2 is using the JIT feature, but we never got
around to doing that for v1. The two benchmarks above run without v2
JIT are for "grep" & "log", respectively:

             s/iter    basic extended    pcre1    pcre2    fixed
    basic      2.23       --      -0%      -1%     -15%     -31%
    extended   2.22       0%       --      -1%     -15%     -31%
    pcre1      2.21       1%       1%       --     -15%     -31%
    pcre2      1.89      18%      18%      17%       --     -19%
    fixed      1.53      46%      45%      44%      23%       --

             s/iter    basic    pcre2 extended    pcre1    fixed
    basic      10.9       --     -21%     -24%     -28%     -33%
    pcre2      8.63      26%       --      -4%      -9%     -16%
    extended   8.30      31%       4%       --      -5%     -12%
    pcre1      7.88      38%      10%       5%       --      -8%
    fixed      7.28      50%      19%      14%       8%       --

Here v2 still outperforms v1 on the "grep" test, but by 15% instead of
43%, v1 is still faster on "log", but by 9% instead of 4%.

When both v1 and v2 use JIT v1 will ever so slightly beat v2 by 1% on
the "grep" test:

             s/iter    basic extended    fixed    pcre2    pcre1
    basic      2.22       --      -0%     -33%     -44%     -45%
    extended   2.21       0%       --     -33%     -44%     -45%
    fixed      1.49      49%      49%       --     -17%     -18%
    pcre2      1.24      80%      79%      20%       --      -1%
    pcre1      1.22      82%      81%      22%       1%       --

But v1 is 10% faster than v2 for "log" when both have JIT, as opposed
to 4% faster when v2 has JIT and v1 doesn't:

         s/iter    basic extended    pcre2    pcre1    fixed
basic      9.43       --     -11%     -12%     -21%     -22%
extended   8.39      12%       --      -2%     -11%     -12%
pcre2      8.26      14%       2%       --     -10%     -11%
pcre1      7.45      27%      13%      11%       --      -1%
fixed      7.37      28%      14%      12%       1%       --

The v1 JIT support uses a patch that isn't part of this series
yet. Supporting it is slightly tricker than for v2 because we need to
support PCRE v1 versions that don't have JIT support, the "SIMPLE USE
OF JIT" section in pcrejit(3) documents how to do that.

The PCRE performance improvements suggest that there are numerous
other follow-up projects on grep.c which could yield better
performance:

 - Disable the "fast" path for fixed patterns in compile_regexp() when
   PCRE is being used, at least in some cases. It was added in commit
   9eceddeec6 ("Use kwset in grep", 2011-08-21) as an optimization,
   but clearly results in taking a slower path with PCRE in some
   cases.

 - Similarly -F on a pattern that !is_fixed() (e.g. -F '[f]oo') might
   be better of escaping the regex characters & feeding them to PCRE
   than using kwset.

 - Other things could be farmed out to the regex engine rather than
   being handled by our own custom code. E.g. the support for -w in
   match_one_pattern() added in commit 7839a25eab ("builtin-grep:
   support -w (--word-regexp).", 2006-05-02) can instead by done by
   munging the PATTERN to \bPATTERN\b.

   This would make it easy to support e.g. -x by similarly prefixing
   the line with "^(?:" & suffixing it with ")$". See how pcre2grep.c
   handles -w, -x & -F by simply munging the pattern.

 - The look-ahead support added in commit a26345b608 ("grep: optimize
   built-in grep by skipping lines that do not hit", 2010-01-10) might
   need tweaking to either match in smaller or bigger
   batches. Possibly with some heuristic that tries to detect if the
   pattern has been matching a lot ("." v.s. "rare.*string") so far.

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

2. PF=~/g/git/ perl -MBenchmark=cmpthese -wE 'cmpthese(50, { fixed => sub { system "$ENV{PF}git grep -F avarasu >/dev/null" }, basic => sub { system "$ENV{PF}git grep -G avara?su >/dev/null" }, extended => sub { system "$ENV{PF}git grep -E avara?su >/dev/null" }, pcre1 => sub { system "$ENV{PF}git -c grep.patternType=pcre1 grep avara?su >/dev/null" }, pcre2 => sub { system "$ENV{PF}git -c grep.patternType=pcre2 grep avara?su >/dev/null" } })'

3. PF=~/g/git/ perl -MBenchmark=cmpthese -wE 'cmpthese(10, { fixed => sub { system "$ENV{PF}git log -F --grep=avarasu >/dev/null" }, basic => sub { system "$ENV{PF}git log --basic-regexp --grep=avara?su >/dev/null" }, extended => sub { system "$ENV{PF}git log --extended-regexp --grep=avara?su >/dev/null" }, pcre1 => sub { system "$ENV{PF}git -c grep.patternType=pcre1 log --grep=avara?su >/dev/null" }, pcre2 => sub { system "$ENV{PF}git -c grep.patternType=pcre2 log --grep=avara?su >/dev/null" } })'

Signed-off-by: Ã†var ArnfjÃ¶rÃ° Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt  |  14 +++---
 Makefile                  |  18 +++++++
 builtin/grep.c            |   4 +-
 configure.ac              |  49 +++++++++++++++++-
 grep.c                    | 125 +++++++++++++++++++++++++++++++++++++++++++++-
 grep.h                    |  16 +++++-
 revision.c                |   2 +-
 t/README                  |  12 +++++
 t/t7810-grep.sh           |  30 +++++++++--
 t/t7813-grep-icase-iso.sh |  11 ++--
 t/test-lib.sh             |   4 +-
 11 files changed, 261 insertions(+), 24 deletions(-)

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
index c8a26087e3..bf8db4bae9 100644
--- a/Makefile
+++ b/Makefile
@@ -32,6 +32,14 @@ all::
 # Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+# Define USE_LIBPCRE if you have and want to use libpcre2. Various
+# commands such as like log, grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
+#
+# Define LIBPCRE2DIR=/foo/bar if your libpcre2 header and library
+# files are in /foo/bar/include and /foo/bar/lib directories.
+#
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
 #
 # Define NO_CURL if you do not have libcurl installed.  git-http-fetch and
@@ -1092,6 +1100,15 @@ ifdef USE_LIBPCRE
 	EXTLIBS += -lpcre
 endif
 
+ifdef USE_LIBPCRE2
+	BASIC_CFLAGS += -DUSE_LIBPCRE2
+	ifdef LIBPCRE2DIR
+		BASIC_CFLAGS += -I$(LIBPCREDIR)/include
+		EXTLIBS += -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib)
+	endif
+	EXTLIBS += -lpcre2-8
+endif
+
 ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
@@ -2236,6 +2253,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
 	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
+	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
diff --git a/builtin/grep.c b/builtin/grep.c
index dffb9743b8..9478ab5dff 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -490,7 +490,7 @@ static void compile_submodule_options(const struct grep_opt *opt,
 	case GREP_PATTERN_TYPE_FIXED:
 		argv_array_push(&submodule_options, "-F");
 		break;
-	case GREP_PATTERN_TYPE_PCRE1:
+	case GREP_PATTERN_TYPE_PCRE:
 		argv_array_push(&submodule_options, "-P");
 		break;
 	case GREP_PATTERN_TYPE_UNSPECIFIED:
@@ -1036,7 +1036,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_FIXED),
 		OPT_SET_INT('P', "perl-regexp", &pattern_type_arg,
 			    N_("use Perl-compatible regular expressions"),
-			    GREP_PATTERN_TYPE_PCRE1),
+			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
diff --git a/configure.ac b/configure.ac
index d09a204a7e..6c99c4c285 100644
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
+# commands such as like log, grep offer runtime options to use
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
+	AC_MSG_NOTICE([Setting LIBPCRE2DIR to $LIBPCREDIR])
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
+# Define USE_LIBPCRE2 if you have and want to use libpcre. Various
+# commands such as like log, grep offer runtime options to use
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
index ac7d6f9bbf..1797807f9c 100644
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
 
@@ -181,24 +184,48 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 	case GREP_PATTERN_TYPE_BRE:
 		opt->fixed = 0;
 		opt->pcre1 = 0;
+		opt->pcre2 = 0;
 		opt->regflags &= ~REG_EXTENDED;
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
 		opt->regflags &= ~REG_EXTENDED;
 		break;
 
+	case GREP_PATTERN_TYPE_PCRE:
+		opt->fixed = 0;
+		/* We default to pcre1 in the prescience of both
+		 * versions. This may change in future versions.
+		 */
+#ifdef USE_LIBPCRE1
+		opt->pcre1 = 1;
+		opt->pcre2 = 0;
+#elif USE_LIBPCRE2
+		opt->pcre1 = 0;
+		opt->pcre2 = 1;
+#endif
+		break;
+
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
@@ -394,6 +421,93 @@ static void free_pcre1_regexp(struct grep_pat *p)
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
+	if (!p->pcre2_pattern) {
+		pcre2_get_error_message(error, errbuf, sizeof(errbuf));
+		compile_regexp_failed(p, (const char *)&errbuf);
+	}
+
+	pcre2_config(PCRE2_CONFIG_JIT, &canjit);
+	if (canjit == 1) {
+		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
+		if (jitret)
+			die("BUG: Couldn't JIT the PCRE pattern '%s', got '%d'\n", p->pattern, jitret);
+	}
+}
+
+static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
+		regmatch_t *match, int eflags)
+{
+	int ret, flags = 0;
+	PCRE2_SIZE *ovector;
+
+	if (eflags & REG_NOTBOL)
+		flags |= PCRE2_NOTBOL;
+
+	p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, NULL);
+	ret = pcre2_match(p->pcre2_pattern, (unsigned char *)line, eol - line,
+			  0, flags, p->pcre2_match_data, NULL);
+	if (ret < 0 && ret != PCRE2_ERROR_NOMATCH)
+		die("pcre_exec failed with error code %d", ret);
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
+	pcre2_code_free(p->pcre2_pattern);
+	pcre2_match_data_free(p->pcre2_match_data);
+	pcre2_compile_context_free(p->pcre2_ccontext);
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
@@ -481,6 +595,11 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
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
@@ -915,6 +1034,8 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 		hit = !fixmatch(p, line, eol, match);
 	else if (p->pcre1_regexp)
 		hit = !pcre1match(p, line, eol, match, eflags);
+	else if (p->pcre2_pattern)
+		hit = !pcre2match(p, line, eol, match, eflags);
 	else
 		hit = !regexec_buf(&p->regexp, line, eol - line, 1, match,
 				   eflags);
diff --git a/grep.h b/grep.h
index fa2ab9485f..5c7f4dc799 100644
--- a/grep.h
+++ b/grep.h
@@ -7,6 +7,14 @@
 typedef int pcre;
 typedef int pcre_extra;
 #endif
+#ifdef USE_LIBPCRE2
+#define PCRE2_CODE_UNIT_WIDTH 8
+#include <pcre2.h>
+#else
+typedef int pcre2_code;
+typedef int pcre2_match_data;
+typedef int pcre2_compile_context;
+#endif
 #include "kwset.h"
 #include "thread-utils.h"
 #include "userdiff.h"
@@ -49,6 +57,9 @@ struct grep_pat {
 	pcre *pcre1_regexp;
 	pcre_extra *pcre1_extra_info;
 	const unsigned char *pcre1_tables;
+	pcre2_code *pcre2_pattern;
+	pcre2_match_data *pcre2_match_data;
+	pcre2_compile_context *pcre2_ccontext;
 	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
@@ -68,7 +79,9 @@ enum grep_pattern_type {
 	GREP_PATTERN_TYPE_BRE,
 	GREP_PATTERN_TYPE_ERE,
 	GREP_PATTERN_TYPE_FIXED,
-	GREP_PATTERN_TYPE_PCRE1
+	GREP_PATTERN_TYPE_PCRE,
+	GREP_PATTERN_TYPE_PCRE1,
+	GREP_PATTERN_TYPE_PCRE2
 };
 
 struct grep_expr {
@@ -112,6 +125,7 @@ struct grep_opt {
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
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 46f528183d..6e9e38cec9 100755
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
@@ -1522,14 +1532,28 @@ test_expect_success 'grep with thread options' '
 	test_must_fail git -c grep.threads=1 grep --threads=-1 st.*dio
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
-	git grep --perl-regexp -i "TILRAUN: H.lló Heimur!" &&
-	git grep --perl-regexp -i "TILRAUN: H.LLÓ HEIMUR!"
-'
+for pcrev in 1 2
+do
+	test_expect_success GETTEXT_ISO_LOCALE,LIBPCRE$pcrev "grep -i with i18n string using libpcre$pcrev" "
+		git -c grep.patternType=pcre$pcrev grep -i \"TILRAUN: H.lló Heimur!\" &&
+		git -c grep.patternType=pcre$pcrev grep -i \"TILRAUN: H.LLÓ HEIMUR!\"
+	"
+done
 
 test_done
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

