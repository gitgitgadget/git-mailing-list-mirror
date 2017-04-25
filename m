Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4428D207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954738AbdDYVGt (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35451 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954722AbdDYVGo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id d79so28447540wmi.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqfOd+twiQ/bNftEAhGElCicH8wpWsa3PwQdFAnxSmo=;
        b=seMy50+dIqJX7ufnkBf79oQlZJhY93RKAtF7aqMvsQb89QNagghaL2mhYyhs/tTRtB
         DVHIN8LzJjKnpO5q6ChrsfPJ+HNSzZPqJAQ96HDzkLa0iMxiA9iBb1JppcZU3SVKkKfL
         +lyU8Py1GBff9JEg1VFLLtR448EMuDW9lbywIJmVg8+/El78IBMiBQEOL0pEucXaEFol
         yDyF5X7iJjGGsuDoOH5sHWdOTNGJivfA9dGnCJUSoIbv7+voMcrMg+V47kFsroqM0F1b
         i5YUN2DZ9hDD46J6m6z5zZD76A2WJ6XN5bzVPUpr+1rTMniuC00XtXDX21PThgzFATf2
         587Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqfOd+twiQ/bNftEAhGElCicH8wpWsa3PwQdFAnxSmo=;
        b=cyAs46i62uDd/6X2m5DTuTLlDMh662NQmvznMKQVViN/ijRcVjYA2GcGMWAC6YOorQ
         DP8yaa+JY3QMJuzqRsZZJpiYXruYpNE7wiTj0xSBj+tpz7io1upTWHrIUvvO7BjkwsGp
         I6g4Pss9j+h7HYGkE87RDrp+Z6pXBA0ZBgYB35UsdFEz7vza4LcdoNLYnNUVfKDRIq50
         l5+4lN0su+I3EDdW0KC/aUGNT+XV9hiV8EhqCYWGYDayJDYp/6shBMQINi0WFlcSSd4B
         No2dN3fdTsu7HJyL0hNfm0Uq9d7WUlJ+KQ4mHApMK+Ap7LqK4cMNG7J1kc10ParyhElv
         y7Jw==
X-Gm-Message-State: AN3rC/79nw6praIyYoPDpu1imsPadx6H+4KDZivCScVca39Wn0AaKlPR
        mpo8Puoikcg7ww==
X-Received: by 10.28.40.198 with SMTP id o189mr3498270wmo.108.1493154403074;
        Tue, 25 Apr 2017 14:06:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:42 -0700 (PDT)
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
Subject: [PATCH v4 14/19] grep: change the internal PCRE code & header names to be PCRE1
Date:   Tue, 25 Apr 2017 21:05:43 +0000
Message-Id: <20170425210548.24612-15-avarab@gmail.com>
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

Change the internal PCRE variable & function names to have a "1"
suffix. This is for preparation for libpcre2 support, where having
non-versioned names would be confusing.

The earlier "grep: change the internal PCRE macro names to be PCRE1"
change elaborates on the motivations behind this commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c |  4 ++--
 grep.c         | 56 ++++++++++++++++++++++++++++----------------------------
 grep.h         | 10 +++++-----
 revision.c     |  2 +-
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index be3dbd6957..28e0dd3236 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -490,7 +490,7 @@ static void compile_submodule_options(const struct grep_opt *opt,
 	case GREP_PATTERN_TYPE_FIXED:
 		argv_array_push(&submodule_options, "-F");
 		break;
-	case GREP_PATTERN_TYPE_PCRE:
+	case GREP_PATTERN_TYPE_PCRE1:
 		argv_array_push(&submodule_options, "-P");
 		break;
 	case GREP_PATTERN_TYPE_UNSPECIFIED:
@@ -1022,7 +1022,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_FIXED),
 		OPT_SET_INT('P', "perl-regexp", &pattern_type_arg,
 			    N_("use Perl-compatible regular expressions"),
-			    GREP_PATTERN_TYPE_PCRE),
+			    GREP_PATTERN_TYPE_PCRE1),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
diff --git a/grep.c b/grep.c
index a378b7edaa..c61e69deaa 100644
--- a/grep.c
+++ b/grep.c
@@ -63,7 +63,7 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 	else if (!strcmp(arg, "perl") ||
 		 !strcmp(arg, "pcre") ||
 		 !strcmp(arg, "pcre1"))
-		return GREP_PATTERN_TYPE_PCRE;
+		return GREP_PATTERN_TYPE_PCRE1;
 	die("bad %s argument: %s", opt, arg);
 }
 
@@ -180,23 +180,23 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 
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
 
-	case GREP_PATTERN_TYPE_PCRE:
+	case GREP_PATTERN_TYPE_PCRE1:
 		opt->fixed = 0;
-		opt->pcre = 1;
+		opt->pcre1 = 1;
 		break;
 	}
 }
@@ -324,7 +324,7 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 }
 
 #ifdef USE_LIBPCRE1
-static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
+static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
 	const char *error;
 	int erroffset;
@@ -332,23 +332,23 @@ static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
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
@@ -356,7 +356,7 @@ static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
-	ret = pcre_exec(p->pcre_regexp, p->pcre_extra_info, line, eol - line,
+	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
 			0, flags, ovector, ARRAY_SIZE(ovector));
 	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
 		die("pcre_exec failed with error code %d", ret);
@@ -369,25 +369,25 @@ static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
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
@@ -473,8 +473,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
-	if (opt->pcre) {
-		compile_pcre_regexp(p, opt);
+	if (opt->pcre1) {
+		compile_pcre1_regexp(p, opt);
 		return;
 	}
 
@@ -830,8 +830,8 @@ void free_grep_patterns(struct grep_opt *opt)
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
@@ -910,8 +910,8 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 
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
index 073b0e4c92..fa2ab9485f 100644
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
@@ -68,7 +68,7 @@ enum grep_pattern_type {
 	GREP_PATTERN_TYPE_BRE,
 	GREP_PATTERN_TYPE_ERE,
 	GREP_PATTERN_TYPE_FIXED,
-	GREP_PATTERN_TYPE_PCRE
+	GREP_PATTERN_TYPE_PCRE1
 };
 
 struct grep_expr {
@@ -111,7 +111,7 @@ struct grep_opt {
 	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
-	int pcre;
+	int pcre1;
 	int relative;
 	int pathname;
 	int null_following_name;
diff --git a/revision.c b/revision.c
index 03a3a012de..7a10a8570a 100644
--- a/revision.c
+++ b/revision.c
@@ -1996,7 +1996,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
 	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
-		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
+		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE1;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
 	} else if (!strcmp(arg, "--invert-grep")) {
-- 
2.11.0

