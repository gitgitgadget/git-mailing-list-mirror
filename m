Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B9E20188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758881AbdEMXRO (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:17:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35426 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757675AbdEMXRM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:17:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so11222949qtb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWFnOCdqJceSRwMpPzGfL/9QotCMYkFiaT+O6LxDZMI=;
        b=J5G7e29msQrO8tFTbcSOEmvq/rMUMOc0hwcTYmWWM/8GwVJrnomuaBK1yQCEcLlMgy
         7f5jDq8bOzp+0xaSItFLSi+4AjzeSNXeD+dVqG0BnV/4r90V5OrZ2kg58YTc/pQQMB0j
         HB+pv1isFuvGl8O11vw2gKOtJs6jc3cL0tESusPucubUK9aNsMM1IGqExe8+TMix+BB9
         QQPM9cpH5Hm4zUvDJ274Pwoywo1pFL3ZLknHozMWzOy3M2JJpRheuwJpNbGpVAY7XS8v
         pfaQPoT3BS3eZp/QasYgf4MWcC//zEO3tU7EWI1hYzNLvhMDWRZKbNwDj5S1o5gi7YlP
         DAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWFnOCdqJceSRwMpPzGfL/9QotCMYkFiaT+O6LxDZMI=;
        b=flaER7GoCSatVkNX7gBWUjTmtrhfIkmLah8PE5M54SIHgYrmO8GB1cTKm1+P+xE8zJ
         k/4dImNyyqwoXGPBowg5Oi7IftTMq3bF72pZyco0troH/XhyfBhfey1u0ed+3eVuZptu
         VlaUmJGaG72Zx1EouP+cP/abRIuiCuuQ7Vt0xGh0LEy/TVc52k+WP7yblwwY5ryd6v5r
         MZ9Is2x1mXKLupfcwtsxOdelIPVE/VsbtMTqDegLKWb1vXzaOpkyzRVVyud4KWORBLW6
         LONwS0ZIjhBZaWwD6VA6KFbcHKC7ge+ILnPBSC45NRvl9z5HwBDKaLUNXDFCvOjrquw7
         y4MA==
X-Gm-Message-State: AODbwcDWHbzh6M4cUJcqMv+dPID1CWJ6yx2ec6aD2KqGABUrtbEBPAUX
        XYL0e/zQdOvwiA==
X-Received: by 10.200.1.72 with SMTP id f8mr9888838qtg.172.1494717427017;
        Sat, 13 May 2017 16:17:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:17:06 -0700 (PDT)
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
Subject: [PATCH v2 23/29] grep: change internal *pcre* variable & function names to be *pcre1*
Date:   Sat, 13 May 2017 23:15:03 +0000
Message-Id: <20170513231509.7834-24-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the internal PCRE variable & function names to have a "1"
suffix. This is for preparation for libpcre2 support, where having
non-versioned names would be confusing.

An earlier change in this series ("grep: change the internal PCRE
macro names to be PCRE1", 2017-04-07) elaborates on the motivations
behind this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 52 ++++++++++++++++++++++++++--------------------------
 grep.h |  8 ++++----
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/grep.c b/grep.c
index 854f2404be..07512346b1 100644
--- a/grep.c
+++ b/grep.c
@@ -178,23 +178,23 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 
 	case GREP_PATTERN_TYPE_BRE:
 		opt->fixed = 0;
-		opt->pcre = 0;
+		opt->pcre1 = 0;
 		break;
 
 	case GREP_PATTERN_TYPE_ERE:
 		opt->fixed = 0;
-		opt->pcre = 0;
+		opt->pcre1 = 0;
 		opt->regflags |= REG_EXTENDED;
 		break;
 
 	case GREP_PATTERN_TYPE_FIXED:
 		opt->fixed = 1;
-		opt->pcre = 0;
+		opt->pcre1 = 0;
 		break;
 
 	case GREP_PATTERN_TYPE_PCRE:
 		opt->fixed = 0;
-		opt->pcre = 1;
+		opt->pcre1 = 1;
 		break;
 	}
 }
@@ -334,7 +334,7 @@ static int has_null(const char *s, size_t len)
 }
 
 #ifdef USE_LIBPCRE1
-static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
+static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
 	const char *error;
 	int erroffset;
@@ -342,23 +342,23 @@ static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern))
-			p->pcre_tables = pcre_maketables();
+			p->pcre1_tables = pcre_maketables();
 		options |= PCRE_CASELESS;
 	}
 	if (is_utf8_locale() && has_non_ascii(p->pattern))
 		options |= PCRE_UTF8;
 
-	p->pcre_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
-				      p->pcre_tables);
-	if (!p->pcre_regexp)
+	p->pcre1_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
+				      p->pcre1_tables);
+	if (!p->pcre1_regexp)
 		compile_regexp_failed(p, error);
 
-	p->pcre_extra_info = pcre_study(p->pcre_regexp, 0, &error);
-	if (!p->pcre_extra_info && error)
+	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, 0, &error);
+	if (!p->pcre1_extra_info && error)
 		die("%s", error);
 }
 
-static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
+static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 		regmatch_t *match, int eflags)
 {
 	int ovector[30], ret, flags = 0;
@@ -366,7 +366,7 @@ static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
-	ret = pcre_exec(p->pcre_regexp, p->pcre_extra_info, line, eol - line,
+	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
 			0, flags, ovector, ARRAY_SIZE(ovector));
 	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
 		die("pcre_exec failed with error code %d", ret);
@@ -379,25 +379,25 @@ static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
 	return ret;
 }
 
-static void free_pcre_regexp(struct grep_pat *p)
+static void free_pcre1_regexp(struct grep_pat *p)
 {
-	pcre_free(p->pcre_regexp);
-	pcre_free(p->pcre_extra_info);
-	pcre_free((void *)p->pcre_tables);
+	pcre_free(p->pcre1_regexp);
+	pcre_free(p->pcre1_extra_info);
+	pcre_free((void *)p->pcre1_tables);
 }
 #else /* !USE_LIBPCRE1 */
-static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
+static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
 	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE");
 }
 
-static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
+static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 		regmatch_t *match, int eflags)
 {
 	return 1;
 }
 
-static void free_pcre_regexp(struct grep_pat *p)
+static void free_pcre1_regexp(struct grep_pat *p)
 {
 }
 #endif /* !USE_LIBPCRE1 */
@@ -477,8 +477,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
-	if (opt->pcre) {
-		compile_pcre_regexp(p, opt);
+	if (opt->pcre1) {
+		compile_pcre1_regexp(p, opt);
 		return;
 	}
 
@@ -834,8 +834,8 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN_BODY:
 			if (p->kws)
 				kwsfree(p->kws);
-			else if (p->pcre_regexp)
-				free_pcre_regexp(p);
+			else if (p->pcre1_regexp)
+				free_pcre1_regexp(p);
 			else
 				regfree(&p->regexp);
 			free(p->pattern);
@@ -914,8 +914,8 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 
 	if (p->fixed)
 		hit = !fixmatch(p, line, eol, match);
-	else if (p->pcre_regexp)
-		hit = !pcrematch(p, line, eol, match, eflags);
+	else if (p->pcre1_regexp)
+		hit = !pcre1match(p, line, eol, match, eflags);
 	else
 		hit = !regexec_buf(&p->regexp, line, eol - line, 1, match,
 				   eflags);
diff --git a/grep.h b/grep.h
index 073b0e4c92..38ac82b638 100644
--- a/grep.h
+++ b/grep.h
@@ -46,9 +46,9 @@ struct grep_pat {
 	size_t patternlen;
 	enum grep_header_field field;
 	regex_t regexp;
-	pcre *pcre_regexp;
-	pcre_extra *pcre_extra_info;
-	const unsigned char *pcre_tables;
+	pcre *pcre1_regexp;
+	pcre_extra *pcre1_extra_info;
+	const unsigned char *pcre1_tables;
 	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
@@ -111,7 +111,7 @@ struct grep_opt {
 	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
-	int pcre;
+	int pcre1;
 	int relative;
 	int pathname;
 	int null_following_name;
-- 
2.11.0

