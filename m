Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7ED420970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbdDHN0a (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:26:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35023 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbdDHN0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:26:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id t20so23483454wra.2
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=weaB5o4wCL1sPEeoelS9xbUzLiRW5L2Bvo1TwTwEnX4=;
        b=ZxOW1gKKhyyCUBG88ynYeZrUaF63zAUYLbGsEIcni6C5wkRqy8dv5ezwI5y5AgdntQ
         dPWIZ2BX/eUbmZoxagvjMS54TQW12FrpAVVHzd9PYrKdgNH690ssi46EJzzhcwZbZq54
         mET7/o7BDxT2Ie83Z0b9GQU8zJegulqG6vQ0Hi2zpltJxUZn3CPd7/BSm5MxxsSsXK3p
         e3xs5tmnlcgEZxQzd7s9SZpKhe6g/1GuultRFLLhJBhfAq8nLHhlXU6xEIvk9p4qA7Z5
         SMI4uM2ETHoKuayM8NpCYjp5xMZMpT5zRVUDOu5wsdCb83VV5Q1fqhL3z+7vw/gCNOls
         3XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weaB5o4wCL1sPEeoelS9xbUzLiRW5L2Bvo1TwTwEnX4=;
        b=q2KN0KOSnZtw33o8BJ051akpi3a5ORCSs2FbO0KYwB5VynjfW0i25MH8g6lHSFTw6Y
         MUhkDvLivLLxdOEV6E7HHJfsIyVqSkC6FP+cGIKsaw+OtdALPRd+wuEQpdKFp6YdG5ne
         HU6FchBl5JWnquWWl+XrbvDAWzGSsf+ckmLvhmpUCMnFXOFZv4XYN4soZ6cEbHmarU/r
         lu7mgxG7zmkz6H6NPKVUiZ4RT05EDGTBHHIDhZY9AZ+UfyFxsrZhbYiguopaGl3ZxWgL
         oe2QXvlYrNfodyzo1kp8p4SL5m/X0iZxH+hwUMyGkkOSb/HDU0SljLl6gmVRIioudYcP
         tKLw==
X-Gm-Message-State: AN3rC/7hijQQqvJfqtKtY+Ab0LXra6eCD1vGpFjWIYV09ihm5OTxIiBOL7TmRBooEDtVwg==
X-Received: by 10.223.182.174 with SMTP id j46mr431309wre.143.1491657978211;
        Sat, 08 Apr 2017 06:26:18 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:26:17 -0700 (PDT)
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
Subject: [PATCH 11/12] grep: change the internal PCRE code & header names to be PCRE1
Date:   Sat,  8 Apr 2017 13:25:05 +0000
Message-Id: <20170408132506.5415-12-avarab@gmail.com>
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
index 9478ab5dff..dffb9743b8 100644
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
@@ -1036,7 +1036,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_FIXED),
 		OPT_SET_INT('P', "perl-regexp", &pattern_type_arg,
 			    N_("use Perl-compatible regular expressions"),
-			    GREP_PATTERN_TYPE_PCRE),
+			    GREP_PATTERN_TYPE_PCRE1),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
diff --git a/grep.c b/grep.c
index 99b9e9447f..ac7d6f9bbf 100644
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
 
@@ -180,25 +180,25 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 
 	case GREP_PATTERN_TYPE_BRE:
 		opt->fixed = 0;
-		opt->pcre = 0;
+		opt->pcre1 = 0;
 		opt->regflags &= ~REG_EXTENDED;
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
 		opt->regflags &= ~REG_EXTENDED;
 		break;
 
-	case GREP_PATTERN_TYPE_PCRE:
+	case GREP_PATTERN_TYPE_PCRE1:
 		opt->fixed = 0;
-		opt->pcre = 1;
+		opt->pcre1 = 1;
 		break;
 	}
 }
@@ -326,7 +326,7 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 }
 
 #ifdef USE_LIBPCRE1
-static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
+static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
 	const char *error;
 	int erroffset;
@@ -334,23 +334,23 @@ static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
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
@@ -358,7 +358,7 @@ static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
-	ret = pcre_exec(p->pcre_regexp, p->pcre_extra_info, line, eol - line,
+	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
 			0, flags, ovector, ARRAY_SIZE(ovector));
 	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
 		die("pcre_exec failed with error code %d", ret);
@@ -371,25 +371,25 @@ static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
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
@@ -476,8 +476,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
-	if (opt->pcre) {
-		compile_pcre_regexp(p, opt);
+	if (opt->pcre1) {
+		compile_pcre1_regexp(p, opt);
 		return;
 	}
 
@@ -833,8 +833,8 @@ void free_grep_patterns(struct grep_opt *opt)
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
@@ -913,8 +913,8 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 
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

