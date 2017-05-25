Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1531209FD
	for <e@80x24.org>; Thu, 25 May 2017 19:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970180AbdEYTrc (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34821 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036738AbdEYTrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so35875167wmc.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozBmGe0mxm7FoNleoX9PB/NOx0uE4rRk80hfUM0P1O0=;
        b=nyQTciubgbzkxNAy2sWSzYolkkjejG/f7QUK9dc9liJPpT2obsENy6hwk47WOQxOil
         apzYVWw7tiwu0S8VPR6+t2UcsHzg2rHN/jabl7ZuL0FR9Hq/Ioae5xhJH95joKWvLdZP
         axDJmr8ydZ0qBI151bE/yYjGjmmLMr0xK6gLmqnsIEfMuL9UTk4oy8oCenLgiy5mrnkh
         SalFrmmmfQIH3EH8p7sDz0r9pUZH8WRpMAS42oA0RCPo87se6yoMl3OS5KhUzBlLAeV4
         K5IMPmYmm1LGDssK84hF0yXbUrX5H8Lz4VhYheXv6mW8togFEfjkyTjBiQQx7zwdbAYn
         t2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozBmGe0mxm7FoNleoX9PB/NOx0uE4rRk80hfUM0P1O0=;
        b=kfMHN6uAQeo9lacrgrPhouGkQ58Vp0hscnZ66mJXqa2Tv4v7reD34XqfdCLDt8d2jA
         Vcg7dy/Ujv5QDDhplhu7B3nDCJ9g3QrLtmCDCkiwtQ8q7nA1HKYvItjFUzpWQ1lgYZ9r
         lkWDR2g1m6kMYktadyvLD5BrwZv1JCSCKuGM4C1Xo2SemWAYQxXNTMSPWNtVXpYVgXS1
         so0E7LBl+Gcp6bSnWCmRL0EfVphP4W/Jc1s3XkVHpz6cGCZEOeeFf3xFQ9ZErJEfrBK/
         MVGe2uWS7JwDq41VpKxmejgLjMU1tM5iOjZvSBex6hTo3yr5FftzvjR3WpQDJi8RSWJ5
         Khqw==
X-Gm-Message-State: AODbwcCUWyiCm0f4l4Iv991FlHDf8nOkhTRIaY852PPFEixJKrgq/rel
        Yk3AR+5Z3pJn3Q==
X-Received: by 10.223.165.14 with SMTP id i14mr29870913wrb.127.1495741639864;
        Thu, 25 May 2017 12:47:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:18 -0700 (PDT)
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
Subject: [PATCH v4 25/31] grep: change internal *pcre* variable & function names to be *pcre1*
Date:   Thu, 25 May 2017 19:45:29 +0000
Message-Id: <20170525194535.9324-26-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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
index 7a3858a1c3..2d54baeaa3 100644
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
@@ -479,8 +479,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
-	if (opt->pcre) {
-		compile_pcre_regexp(p, opt);
+	if (opt->pcre1) {
+		compile_pcre1_regexp(p, opt);
 		return;
 	}
 
@@ -836,8 +836,8 @@ void free_grep_patterns(struct grep_opt *opt)
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
@@ -916,8 +916,8 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 
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
2.13.0.303.g4ebf302169

