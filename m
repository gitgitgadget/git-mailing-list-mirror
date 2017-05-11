Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C832018D
	for <e@80x24.org>; Thu, 11 May 2017 17:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933419AbdEKRwR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:52:17 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36644 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933078AbdEKRwF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:52:05 -0400
Received: by mail-qt0-f194.google.com with SMTP id j13so3783505qta.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CuZT8/q/Q+Qm+9XVreWvg7TPiBNL5GOA6Mir9lpiVA=;
        b=aTk5G8CQUW7WgZn3dH/H+tgASa+JjaBNTfpbE1yVU8CllJV93lzBQsgMGwsgoawETh
         CyZxeKv36hIVQcfZekXyeTVCb9ALYMzTPBMXMH84AuHIPo31vHaKahahJ80ASJeChj9E
         O+PjR8kctol5kiCPhnqEUvqQHdNqZkfxo0AAiHld5uoY5ybjDiyZByRwX4HbSvqP/OZd
         dRH7pA/R94PO8nseI4+YRwB/CKoX6cOyE7klN3iD7D50ohQqhA+0wsh78rgqflg8GCYh
         grU47PaCom5XLoO+D612cuDXkcezRfgQtcSNIj+CNpjTfkIkd8vSg6lPngEwTHHlwaTI
         7duA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CuZT8/q/Q+Qm+9XVreWvg7TPiBNL5GOA6Mir9lpiVA=;
        b=ldT8K1HkEBrcgmnmEG//2KiJbh4O/7mgYF+jKHe0x0eW8Zo9KjOyF/xnqSWTU5GZyk
         w29CVw7zgVHgRhZ4rDCTo3BaZKSbOzgRrh650dBeMheObHsCk5mShFlBwPgZc/vVe/Es
         TpOCVUNSYiaJ5ogQEbgFmlyDOaWW6hEYaFOXvs1fNT7RjsUqKWZIhKgYUs1mZNN8IiBj
         vqlzb6ajpzYItWHQ5G2yEAwPvEtPnZh1iAcQPmhOVbynpfYYAlr/l2UszB/jx2iZVE0Q
         B/sKe6V/PKV+sseIfOWjKgT+jVQG15+NZuhm5KJ4nQgj7lY7T1RXQr/HVZxjW4cmV4e1
         6IxQ==
X-Gm-Message-State: AODbwcAa+HP98290YeytLyXZL/kR/eIdZS87t2gZuOWO4coYmAr/UXLL
        WGyP45MO91LDPA==
X-Received: by 10.200.48.149 with SMTP id v21mr65655qta.84.1494525124589;
        Thu, 11 May 2017 10:52:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g3sm561483qte.66.2017.05.11.10.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:52:03 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC 6/6] grep: use PCRE v2 under the hood for -G & -E for amazing speedup
Date:   Thu, 11 May 2017 17:51:15 +0000
Message-Id: <20170511175115.648-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511175115.648-1-avarab@gmail.com>
References: <20170511175115.648-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the underlying engine powering POSIX basic & extended patterns
to be PCRE v2 under the hood.

This relies on an experimental SVN-trunk only PCRE v2 API which Philip
Hazel (the PCRE maintainer) wrote up in response to a feature request
I filed1[1].

This allows us to use pcre2_pattern_convert() to power all grep regex
matches by converting the POSIX patterns into PCRE syntax before
compiling them.

Due to PCRE generally being faster than POSIX, but most importantly
due to its JIT feature (where available) this speeds up grep by
a *lot*.

The improvements to the "perl" tests are already a part of this
series, but all the other benchmarks show improvements made by this
change alone:

    $ GIT_PERF_REPEAT_COUNT=30 GIT_PERF_LARGE_REPO=~/g/linux [see note #2 for the GIT_PERF_MAKE_COMMAND ...]
    [...]
    Test                                           v2.13.0             HEAD
    -----------------------------------------------------------------------------------------
    7810.1: grep worktree, cheap regex             0.19(0.39+0.52)     0.19(0.26+0.56) +0.0%
    7810.2: grep worktree, expensive regex         5.11(29.75+0.33)    1.07(5.36+0.34) -79.1%
    7810.3: grep --cached, cheap regex             2.91(2.77+0.12)     2.85(2.78+0.06) -2.1%
    7810.4: grep --cached, expensive regex         21.00(20.89+0.08)   6.25(6.18+0.06) -70.2%
    7820.1: basic grep how.to                      0.32(1.20+0.43)     0.19(0.26+0.56) -40.6%
    7820.2: extended grep how.to                   0.32(1.12+0.51)     0.19(0.22+0.60) -40.6%
    7820.3: perl grep how.to                       0.31(1.11+0.45)     0.19(0.30+0.54) -38.7%
    7820.5: basic grep ^how to                     0.31(1.09+0.51)     0.19(0.24+0.57) -38.7%
    7820.6: extended grep ^how to                  0.31(1.14+0.46)     0.19(0.29+0.52) -38.7%
    7820.7: perl grep ^how to                      0.57(2.63+0.38)     0.19(0.25+0.56) -66.7%
    7820.9: basic grep [how] to                    0.49(2.19+0.36)     0.22(0.36+0.54) -55.1%
    7820.10: extended grep [how] to                0.49(2.16+0.41)     0.22(0.41+0.50) -55.1%
    7820.11: perl grep [how] to                    0.57(2.55+0.40)     0.22(0.35+0.55) -61.4%
    7820.13: basic grep \(e.t[^ ]*\|v.ry\) rare    0.65(3.18+0.38)     0.22(0.44+0.52) -66.2%
    7820.14: extended grep (e.t[^ ]*|v.ry) rare    0.65(3.17+0.40)     0.21(0.47+0.52) -67.7%
    7820.15: perl grep (e.t[^ ]*|v.ry) rare        1.05(5.64+0.34)     0.22(0.46+0.53) -79.0%
    7820.17: basic grep m\(ú\|u\)ult.b\(æ\|y\)te   0.33(1.33+0.38)     0.19(0.31+0.51) -42.4%
    7820.18: extended grep m(ú|u)ult.b(æ|y)te      0.33(1.27+0.44)     0.19(0.32+0.50) -42.4%
    7820.19: perl grep m(ú|u)ult.b(æ|y)te          0.37(1.58+0.40)     0.19(0.30+0.53) -48.6%
    7821.1: fixed grep int                         0.53(1.70+0.60)     0.43(1.13+0.66) -18.9%
    7821.2: basic grep int                         0.55(1.62+0.59)     0.46(1.08+0.64) -16.4%
    7821.3: extended grep int                      0.54(1.65+0.59)     0.45(1.17+0.56) -16.7%
    7821.4: perl grep int                          0.54(1.63+0.62)     0.46(1.12+0.60) -14.8%
    7821.6: fixed grep -i int                      0.58(1.93+0.54)     0.48(1.40+0.52) -17.2%
    7821.7: basic grep -i int                      0.83(1.91+0.60)     0.57(1.23+0.67) -31.3%
    7821.8: extended grep -i int                   0.59(1.80+0.66)     0.48(1.33+0.59) -18.6%
    7821.9: perl grep -i int                       0.61(1.91+0.56)     0.52(1.28+0.63) -14.8%
    7821.11: fixed grep æ                          0.34(1.25+0.45)     0.19(0.29+0.51) -44.1%
    7821.12: basic grep æ                          0.34(1.26+0.43)     0.19(0.28+0.53) -44.1%
    7821.13: extended grep æ                       0.34(1.22+0.48)     0.19(0.29+0.53) -44.1%
    7821.14: perl grep æ                           0.34(1.30+0.41)     0.19(0.26+0.57) -44.1%
    7821.16: fixed grep -i æ                       0.27(0.88+0.46)     0.19(0.30+0.51) -29.6%
    7821.17: basic grep -i æ                       0.27(0.88+0.44)     0.19(0.27+0.54) -29.6%
    7821.18: extended grep -i æ                    0.27(0.90+0.42)     0.19(0.22+0.59) -29.6%
    7821.19: perl grep -i æ                        0.25(0.74+0.51)     0.18(0.27+0.58) -28.0%
    7821.1: fixed grep int                         0.53(1.70+0.60)     0.43(1.13+0.66) -18.9%
    7821.2: basic grep int                         0.55(1.62+0.59)     0.46(1.08+0.64) -16.4%
    7821.3: extended grep int                      0.54(1.65+0.59)     0.45(1.17+0.56) -16.7%
    7821.4: perl grep int                          0.54(1.63+0.62)     0.46(1.12+0.60) -14.8%
    7821.6: fixed grep -i int                      0.58(1.93+0.54)     0.48(1.40+0.52) -17.2%
    7821.7: basic grep -i int                      0.83(1.91+0.60)     0.57(1.23+0.67) -31.3%
    7821.8: extended grep -i int                   0.59(1.80+0.66)     0.48(1.33+0.59) -18.6%
    7821.9: perl grep -i int                       0.61(1.91+0.56)     0.52(1.28+0.63) -14.8%
    7821.11: fixed grep æ                          0.34(1.25+0.45)     0.19(0.29+0.51) -44.1%
    7821.12: basic grep æ                          0.34(1.26+0.43)     0.19(0.28+0.53) -44.1%
    7821.13: extended grep æ                       0.34(1.22+0.48)     0.19(0.29+0.53) -44.1%
    7821.14: perl grep æ                           0.34(1.30+0.41)     0.19(0.26+0.57) -44.1%
    7821.16: fixed grep -i æ                       0.27(0.88+0.46)     0.19(0.30+0.51) -29.6%
    7821.17: basic grep -i æ                       0.27(0.88+0.44)     0.19(0.27+0.54) -29.6%
    7821.18: extended grep -i æ                    0.27(0.90+0.42)     0.19(0.22+0.59) -29.6%
    7821.19: perl grep -i æ                        0.25(0.74+0.51)     0.18(0.27+0.58) -28.0%

Caveats & other things to mention:

 * This will expose PCRE v2 (as opposed to C library reg(comp|exec))to
   the network via gitweb in its default configuration. See
   <CACBZZX6V8qbnrZAdhRvPthy5Z91iEG8rrJ=Sf9tdkOt52M9j1Q@mail.gmail.com>
   for a discussion of security & other caveats related to that.

 * I'm checking for PCRE2_CONVERT_POSIX_BASIC to enable this, but the
   experimental API of pcre2_pattern_convert() may change before it
   makes it into a release.

   If we think this patch is awesome enough to get into a git release
   regardless, it should be guarded by some other method so we don't
   rudely tie upstream PCRE to this API least they break git versions
   in the wild.

 * One way to do to that would be to guard this via the
   USE_LIBPCRE2_BUNDLED flag, but see the above E-Mail thread for
   concerns about shipping an embedded PCRE, and for ways that could
   be made OK.

 * We could ship some copy of just the logic in
   pcre2_pattern_convert() & use the system PCRE instead. I haven't
   tried splitting it off from the PCRE codebase, and don't know how
   hard that would be.

 * There are outstanding bugs in the pcre2_pattern_convert()
   function. Grepping with -G and -E for all ASCII characters from
   1..127 both "$char" and "\\$char" will produce numerous
   differences. These are mostly obscure cases, I'm working out fixes
   to those with Philip.

1. https://bugs.exim.org/show_bug.cgi?id=2106

2. GIT_PERF_MAKE_COMMAND='grep -q LIBPCRE2 Makefile && make -j8 USE_LIBPCRE2=YesPlease USE_LIBPCRE2_BUNDLED=Y CC=~/perl5/installed/bin/gcc NO_R_TO_GCC_LINKER=YesPlease CFLAGS=-O3 || make -j8 USE_LIBPCRE=YesPlease CC=~/perl5/installed/bin/gcc NO_R_TO_GCC_LINKER=YesPlease CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre/inst LDFLAGS=-Wl,-rpath,/home/avar/g/pcre/inst/lib' ./run v2.13.0 HEAD -- p*grep*

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c                 | 97 +++++++++++++++++++++++++++++++++++---------------
 grep.h                 |  5 +++
 t/README               |  6 ++++
 t/t7008-grep-binary.sh | 13 +++++--
 t/test-lib.sh          |  1 +
 5 files changed, 90 insertions(+), 32 deletions(-)

diff --git a/grep.c b/grep.c
index 5db614cf80..0f6ee709c5 100644
--- a/grep.c
+++ b/grep.c
@@ -472,8 +472,48 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	const uint8_t *character_tables = NULL;
 	uint32_t canjit;
 	int jitret;
+	int icase = opt->regflags & REG_ICASE || p->ignore_case;
+	PCRE2_SPTR pattern = (PCRE2_SPTR)p->pattern;
+	PCRE2_SIZE length = p->patternlen;
+	int copied_pattern = 0;
+	struct strbuf pattern_sb = STRBUF_INIT;
+#ifdef PCRE2_CONVERT_POSIX_BASIC
+	int convret;
+	PCRE2_UCHAR *convpatbuf = NULL;
+	PCRE2_SIZE convpatlen;
+	int converted_pattern = 0;
+#endif
 
-	assert(opt->pcre2);
+	if (opt->fixed || has_null(p->pattern, p->patternlen) || is_fixed(p->pattern, p->patternlen)) {
+		if (icase)
+			strbuf_add(&pattern_sb, "(?i)", 4);
+		if (opt->fixed)
+			strbuf_add(&pattern_sb, "\\Q", 2);
+		strbuf_add(&pattern_sb, p->pattern, p->patternlen);
+		if (opt->fixed)
+			strbuf_add(&pattern_sb, "\\E", 2);
+
+		pattern = (PCRE2_SPTR)pattern_sb.buf;
+		length = pattern_sb.len;
+		copied_pattern = 1;
+	} else if (opt->pcre2_posix_emulation) {
+#ifdef PCRE2_CONVERT_POSIX_BASIC
+		convret = pcre2_pattern_convert(pattern, length,
+					       (opt->regflags & REG_EXTENDED
+						? PCRE2_CONVERT_POSIX_EXTENDED
+						: PCRE2_CONVERT_POSIX_BASIC),
+					       &convpatbuf, &convpatlen, NULL);
+		if (convret != 0) {
+			fprintf(stderr, "oh noes\n");
+			pcre2_get_error_message(convret, errbuf, sizeof(errbuf));
+			compile_regexp_failed(p, (const char *)&errbuf);
+		}
+		pattern = convpatbuf;
+		length = convpatlen;
+		converted_pattern = 1;
+#endif
+	} else
+		assert(opt->pcre2);
 
 	p->pcre2_compile_context = NULL;
 
@@ -488,11 +528,16 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	if (is_utf8_locale() && has_non_ascii(p->pattern))
 		options |= PCRE2_UTF;
 
-	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
-					 p->patternlen, options, &error, &erroffset,
-					 p->pcre2_compile_context);
+	p->pcre2_pattern = pcre2_compile(pattern, length, options, &error,
+					 &erroffset, p->pcre2_compile_context);
 
 	if (p->pcre2_pattern) {
+		if (copied_pattern)
+			strbuf_release(&pattern_sb);
+#ifdef PCRE2_CONVERT_POSIX_BASIC
+		if (converted_pattern)
+			pcre2_converted_pattern_free(convpatbuf);
+#endif
 		p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, NULL);
 		if (!p->pcre2_match_data)
 			die("BUG: Couldn't allocate PCRE2 match data");
@@ -580,7 +625,6 @@ static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre2_pattern(struct grep_pat *p)
 {
 }
-#endif /* !USE_LIBPCRE2 */
 
 static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
@@ -602,41 +646,21 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 		compile_regexp_failed(p, errbuf);
 	}
 }
+#endif /* !USE_LIBPCRE2 */
 
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
+#ifndef USE_LIBPCRE2
 	int icase, ascii_only;
+#endif
 	int err;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
+#ifndef USE_LIBPCRE2
 	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
 	ascii_only     = !has_non_ascii(p->pattern);
 
-#ifdef USE_LIBPCRE2
-	if (has_null(p->pattern, p->patternlen)) {
-		struct strbuf sb = STRBUF_INIT;
-		if (icase)
-			strbuf_add(&sb, "(?i)", 4);
-		if (opt->fixed)
-			strbuf_add(&sb, "\\Q", 2);		
-		strbuf_add(&sb, p->pattern, p->patternlen);
-		if (opt->fixed)
-			strbuf_add(&sb, "\\E", 2);
-
-		p->pattern = sb.buf;
-		p->patternlen = sb.len;
-
-		/* FIXME: Check in compile_pcre2_pattern() that we're
-		 * using basic rx using !opt->pcre2 && <something>
-		 */
-		opt->pcre2 = 1;
-
-		compile_pcre2_pattern(p, opt);
-		return;
-	}
-#endif
-
 	/*
 	 * Even when -F (fixed) asks us to do a non-regexp search, we
 	 * may not be able to correctly case-fold when -i
@@ -668,12 +692,26 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		compile_fixed_regexp(p, opt);
 		return;
 	}
+#endif
 
 	if (opt->pcre2) {
 		compile_pcre2_pattern(p, opt);
 		return;
 	}
 
+#ifdef USE_LIBPCRE2
+	if (opt->fixed || has_null(p->pattern, p->patternlen) || is_fixed(p->pattern, p->patternlen)) {
+		compile_pcre2_pattern(p, opt);
+		return;
+	}
+
+#ifdef PCRE2_CONVERT_POSIX_BASIC
+	opt->pcre2_posix_emulation = 1;
+	compile_pcre2_pattern(p, opt);
+	return;
+#endif
+#endif
+
 	if (opt->pcre1) {
 		compile_pcre1_regexp(p, opt);
 		return;
@@ -686,6 +724,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		regfree(&p->regexp);
 		compile_regexp_failed(p, errbuf);
 	}
+	return;
 }
 
 static struct grep_expr *compile_pattern_or(struct grep_pat **);
diff --git a/grep.h b/grep.h
index b40afc2e2f..39897489e4 100644
--- a/grep.h
+++ b/grep.h
@@ -29,6 +29,9 @@ typedef int pcre2_compile_context;
 typedef int pcre2_match_context;
 typedef int pcre2_jit_stack;
 #endif
+#ifndef PCRE2_CONVERT_POSIX_EXTENDED
+typedef int pcre2_convert_context;
+#endif
 #include "kwset.h"
 #include "thread-utils.h"
 #include "userdiff.h"
@@ -73,6 +76,7 @@ struct grep_pat {
 	pcre_jit_stack *pcre1_jit_stack;
 	const unsigned char *pcre1_tables;
 	int pcre1_jit_on;
+	pcre2_convert_context *pcre2_convert_context;
 	pcre2_code *pcre2_pattern;
 	pcre2_match_data *pcre2_match_data;
 	pcre2_compile_context *pcre2_compile_context;
@@ -143,6 +147,7 @@ struct grep_opt {
 	int use_reflog_filter;
 	int pcre1;
 	int pcre2;
+	int pcre2_posix_emulation;
 	int relative;
 	int pathname;
 	int null_following_name;
diff --git a/t/README b/t/README
index 1ff612ca65..0dbf5373a2 100644
--- a/t/README
+++ b/t/README
@@ -820,6 +820,12 @@ use these, and "test_set_prereq" for how to define your own.
    USE_LIBPCRE2=YesPlease. Wrap any PCRE using tests that for some
    reason need v2 of the PCRE library instead of v1 in these.
 
+ - LIBPCRE2_BUNDLED
+
+   Git was compiled with the bundled PCRE v2 support via
+   USE_LIBPCRE2=YesPlease &
+   USE_LIBPCRE2_BUNDLED=IWantPatternConvertAwesomeSauce.
+
  - CASE_INSENSITIVE_FS
 
    Test is run on a case insensitive file system.
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index fc86ed5fce..d9de5c986c 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -100,9 +100,16 @@ test_expect_success 'git grep ile a' '
 	git grep ile a
 '
 
-test_expect_failure 'git grep .fi a' '
-	git grep .fi a
-'
+if test_have_prereq LIBPCRE2_BUNDLED
+then
+	test_expect_success 'git grep .fi a' '
+		git grep .fi a
+	'
+else
+	test_expect_failure 'git grep .fi a' '
+		git grep .fi a
+	'
+fi
 
 nul_match 1 '-F' 'yQf'
 nul_match 0 '-F' 'yQx'
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 13ed81dc16..71760e01a0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1014,6 +1014,7 @@ test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE1$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
+test -n "$USE_LIBPCRE2_BUNDLED" && test_set_prereq LIBPCRE2_BUNDLED
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-- 
2.11.0

