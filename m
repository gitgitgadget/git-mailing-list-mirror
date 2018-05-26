Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A1E1F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbeEZNzq (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:55:46 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34476 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752598AbeEZNzl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:41 -0400
Received: by mail-wr0-f173.google.com with SMTP id j1-v6so13545740wrm.1
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78B4EFQ4o0DoJb1fOyPZ37XwZP7XvpCy7yQmEnSnwxo=;
        b=ZeC7l4zbSod67f27yCfGdoB4efTkwEhuuRgGKoGRDKqiJRTj7Z1rkQfNUTC6l11sgE
         DrZq1fOOUq7fTBaHCMR5Ww14pdF4dY71pa8IzgxnMcfmWNU5j392WDJxwSyeD/bntNu7
         9IXG8z3KKP9xpTv7XkMS2Hot9EEQj39FatJ+QUNrroMaPbMuuK1VxU8eElrWuRxmF43P
         SP2h2AZlcaiZTFrKJikdPrr5V8nj2fjWlsKPJQU14upb6sKAEXDgcZlqfN+oIQdq/T72
         IMJF3Y7xUUir2S6DRiplt9hjZgKoFLRUwZp2Fqfn8nfkQ6UixxW8uIlabAnu5/hEJZ8G
         Z1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78B4EFQ4o0DoJb1fOyPZ37XwZP7XvpCy7yQmEnSnwxo=;
        b=i8/N5sfYl0DFDcogH1nFP+IYblXZY+2y4ueyJpwckFoH346CgwZ4j0moxz3YcYOniN
         16Up9NZn/YfS1EuopBfZaLBNK7hbBLkygMNSso0RLlYNYdy+H4kmJaDVacWUMLC0WRfW
         9/b7tCWNSIYy6X3Cx15/4O2Edp2Q2VDUutnKTS8q/k6rzie7bF78jrP3u1KzXrpguDF3
         3HjDqmD7Sj/nNk/l37F7tycoPVeKqRLBc+Pq/Mbpv6cbUn/HfnxbI6XpllqBiWtMeB3S
         YTOfzQiq0v6jEiQXnIvKuuBpY8+hc1u4lkhu1RL0xt01eP6X7dHCjaTGyrhaoKRyXFWe
         fFNQ==
X-Gm-Message-State: ALKqPwcXiDSXQZXYCYFKk5cFvb8JkhQzlDSE+3CzSkooierS01aHsdyC
        JaKle3cjrRjjvfONWNTrE7M=
X-Google-Smtp-Source: ADUXVKL2sv1S1cM3LUuIoCEd7uidF+oUdhCsf5HsWkeJ14RKt/HjRqJuvTd8EO/bO9KIGG3iJ8bC2g==
X-Received: by 2002:a19:e497:: with SMTP id x23-v6mr3705877lfi.40.1527342940462;
        Sat, 26 May 2018 06:55:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 02/11] grep: keep all colors in an array
Date:   Sat, 26 May 2018 15:55:22 +0200
Message-Id: <20180526135531.4516-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
 <20180526135531.4516-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more inline with how we handle color slots in other code. It
also allows us to get the list of configurable color slots later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 grep.c | 106 ++++++++++++++++++++++++++-------------------------------
 grep.h |  21 +++++++-----
 2 files changed, 62 insertions(+), 65 deletions(-)

diff --git a/grep.c b/grep.c
index 45ec7e636c..d94e2c4aeb 100644
--- a/grep.c
+++ b/grep.c
@@ -13,6 +13,17 @@ static int grep_source_is_binary(struct grep_source *gs);
 
 static struct grep_opt grep_defaults;
 
+static const char *color_grep_slots[] = {
+	[GREP_COLOR_CONTEXT]	    = "context",
+	[GREP_COLOR_FILENAME]	    = "filename",
+	[GREP_COLOR_FUNCTION]	    = "function",
+	[GREP_COLOR_LINENO]	    = "lineNumber",
+	[GREP_COLOR_MATCH_CONTEXT]  = "matchContext",
+	[GREP_COLOR_MATCH_SELECTED] = "matchSelected",
+	[GREP_COLOR_SELECTED]	    = "selected",
+	[GREP_COLOR_SEP]	    = "separator",
+};
+
 static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 {
 	fwrite(buf, size, 1, stdout);
@@ -42,14 +53,14 @@ void init_grep_defaults(void)
 	opt->pathname = 1;
 	opt->max_depth = -1;
 	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
-	color_set(opt->color_context, "");
-	color_set(opt->color_filename, "");
-	color_set(opt->color_function, "");
-	color_set(opt->color_lineno, "");
-	color_set(opt->color_match_context, GIT_COLOR_BOLD_RED);
-	color_set(opt->color_match_selected, GIT_COLOR_BOLD_RED);
-	color_set(opt->color_selected, "");
-	color_set(opt->color_sep, GIT_COLOR_CYAN);
+	color_set(opt->colors[GREP_COLOR_CONTEXT], "");
+	color_set(opt->colors[GREP_COLOR_FILENAME], "");
+	color_set(opt->colors[GREP_COLOR_FUNCTION], "");
+	color_set(opt->colors[GREP_COLOR_LINENO], "");
+	color_set(opt->colors[GREP_COLOR_MATCH_CONTEXT], GIT_COLOR_BOLD_RED);
+	color_set(opt->colors[GREP_COLOR_MATCH_SELECTED], GIT_COLOR_BOLD_RED);
+	color_set(opt->colors[GREP_COLOR_SELECTED], "");
+	color_set(opt->colors[GREP_COLOR_SEP], GIT_COLOR_CYAN);
 	opt->color = -1;
 	opt->output = std_output;
 }
@@ -76,7 +87,7 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = &grep_defaults;
-	char *color = NULL;
+	const char *slot;
 
 	if (userdiff_config(var, value) < 0)
 		return -1;
@@ -103,32 +114,18 @@ int grep_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value);
-	else if (!strcmp(var, "color.grep.context"))
-		color = opt->color_context;
-	else if (!strcmp(var, "color.grep.filename"))
-		color = opt->color_filename;
-	else if (!strcmp(var, "color.grep.function"))
-		color = opt->color_function;
-	else if (!strcmp(var, "color.grep.linenumber"))
-		color = opt->color_lineno;
-	else if (!strcmp(var, "color.grep.matchcontext"))
-		color = opt->color_match_context;
-	else if (!strcmp(var, "color.grep.matchselected"))
-		color = opt->color_match_selected;
-	else if (!strcmp(var, "color.grep.selected"))
-		color = opt->color_selected;
-	else if (!strcmp(var, "color.grep.separator"))
-		color = opt->color_sep;
-	else if (!strcmp(var, "color.grep.match")) {
-		int rc = 0;
-		if (!value)
-			return config_error_nonbool(var);
-		rc |= color_parse(value, opt->color_match_context);
-		rc |= color_parse(value, opt->color_match_selected);
-		return rc;
-	}
-
-	if (color) {
+	if (!strcmp(var, "color.grep.match")) {
+		if (grep_config("color.grep.matchcontext", value, cb) < 0)
+			return -1;
+		if (grep_config("color.grep.matchselected", value, cb) < 0)
+			return -1;
+	} else if (skip_prefix(var, "color.grep.", &slot)) {
+		int i = LOOKUP_CONFIG(color_grep_slots, slot);
+		char *color;
+
+		if (i < 0)
+			return -1;
+		color = opt->colors[i];
 		if (!value)
 			return config_error_nonbool(var);
 		return color_parse(value, color);
@@ -144,6 +141,7 @@ int grep_config(const char *var, const char *value, void *cb)
 void grep_init(struct grep_opt *opt, const char *prefix)
 {
 	struct grep_opt *def = &grep_defaults;
+	int i;
 
 	memset(opt, 0, sizeof(*opt));
 	opt->prefix = prefix;
@@ -160,14 +158,8 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->relative = def->relative;
 	opt->output = def->output;
 
-	color_set(opt->color_context, def->color_context);
-	color_set(opt->color_filename, def->color_filename);
-	color_set(opt->color_function, def->color_function);
-	color_set(opt->color_lineno, def->color_lineno);
-	color_set(opt->color_match_context, def->color_match_context);
-	color_set(opt->color_match_selected, def->color_match_selected);
-	color_set(opt->color_selected, def->color_selected);
-	color_set(opt->color_sep, def->color_sep);
+	for (i = 0; i < NR_GREP_COLORS; i++)
+		color_set(opt->colors[i], def->colors[i]);
 }
 
 static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
@@ -1098,12 +1090,12 @@ static void output_sep(struct grep_opt *opt, char sign)
 	if (opt->null_following_name)
 		opt->output(opt, "\0", 1);
 	else
-		output_color(opt, &sign, 1, opt->color_sep);
+		output_color(opt, &sign, 1, opt->colors[GREP_COLOR_SEP]);
 }
 
 static void show_name(struct grep_opt *opt, const char *name)
 {
-	output_color(opt, name, strlen(name), opt->color_filename);
+	output_color(opt, name, strlen(name), opt->colors[GREP_COLOR_FILENAME]);
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
@@ -1370,28 +1362,28 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	} else if (opt->pre_context || opt->post_context || opt->funcbody) {
 		if (opt->last_shown == 0) {
 			if (opt->show_hunk_mark) {
-				output_color(opt, "--", 2, opt->color_sep);
+				output_color(opt, "--", 2, opt->colors[GREP_COLOR_SEP]);
 				opt->output(opt, "\n", 1);
 			}
 		} else if (lno > opt->last_shown + 1) {
-			output_color(opt, "--", 2, opt->color_sep);
+			output_color(opt, "--", 2, opt->colors[GREP_COLOR_SEP]);
 			opt->output(opt, "\n", 1);
 		}
 	}
 	if (opt->heading && opt->last_shown == 0) {
-		output_color(opt, name, strlen(name), opt->color_filename);
+		output_color(opt, name, strlen(name), opt->colors[GREP_COLOR_FILENAME]);
 		opt->output(opt, "\n", 1);
 	}
 	opt->last_shown = lno;
 
 	if (!opt->heading && opt->pathname) {
-		output_color(opt, name, strlen(name), opt->color_filename);
+		output_color(opt, name, strlen(name), opt->colors[GREP_COLOR_FILENAME]);
 		output_sep(opt, sign);
 	}
 	if (opt->linenum) {
 		char buf[32];
 		xsnprintf(buf, sizeof(buf), "%d", lno);
-		output_color(opt, buf, strlen(buf), opt->color_lineno);
+		output_color(opt, buf, strlen(buf), opt->colors[GREP_COLOR_LINENO]);
 		output_sep(opt, sign);
 	}
 	if (opt->color) {
@@ -1401,15 +1393,15 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		int eflags = 0;
 
 		if (sign == ':')
-			match_color = opt->color_match_selected;
+			match_color = opt->colors[GREP_COLOR_MATCH_SELECTED];
 		else
-			match_color = opt->color_match_context;
+			match_color = opt->colors[GREP_COLOR_MATCH_CONTEXT];
 		if (sign == ':')
-			line_color = opt->color_selected;
+			line_color = opt->colors[GREP_COLOR_SELECTED];
 		else if (sign == '-')
-			line_color = opt->color_context;
+			line_color = opt->colors[GREP_COLOR_CONTEXT];
 		else if (sign == '=')
-			line_color = opt->color_function;
+			line_color = opt->colors[GREP_COLOR_FUNCTION];
 		*eol = '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
 			if (match.rm_so == match.rm_eo)
@@ -1816,7 +1808,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			if (binary_match_only) {
 				opt->output(opt, "Binary file ", 12);
 				output_color(opt, gs->name, strlen(gs->name),
-					     opt->color_filename);
+					     opt->colors[GREP_COLOR_FILENAME]);
 				opt->output(opt, " matches\n", 9);
 				return 1;
 			}
@@ -1890,7 +1882,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		char buf[32];
 		if (opt->pathname) {
 			output_color(opt, gs->name, strlen(gs->name),
-				     opt->color_filename);
+				     opt->colors[GREP_COLOR_FILENAME]);
 			output_sep(opt, ':');
 		}
 		xsnprintf(buf, sizeof(buf), "%u\n", count);
diff --git a/grep.h b/grep.h
index 399381c908..ed25be271b 100644
--- a/grep.h
+++ b/grep.h
@@ -62,6 +62,18 @@ enum grep_header_field {
 	GREP_HEADER_FIELD_MAX
 };
 
+enum grep_color {
+	GREP_COLOR_CONTEXT,
+	GREP_COLOR_FILENAME,
+	GREP_COLOR_FUNCTION,
+	GREP_COLOR_LINENO,
+	GREP_COLOR_MATCH_CONTEXT,
+	GREP_COLOR_MATCH_SELECTED,
+	GREP_COLOR_SELECTED,
+	GREP_COLOR_SEP,
+	NR_GREP_COLORS
+};
+
 struct grep_pat {
 	struct grep_pat *next;
 	const char *origin;
@@ -155,14 +167,7 @@ struct grep_opt {
 	int funcbody;
 	int extended_regexp_option;
 	int pattern_type_option;
-	char color_context[COLOR_MAXLEN];
-	char color_filename[COLOR_MAXLEN];
-	char color_function[COLOR_MAXLEN];
-	char color_lineno[COLOR_MAXLEN];
-	char color_match_context[COLOR_MAXLEN];
-	char color_match_selected[COLOR_MAXLEN];
-	char color_selected[COLOR_MAXLEN];
-	char color_sep[COLOR_MAXLEN];
+	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
 	unsigned post_context;
 	unsigned last_shown;
-- 
2.17.0.705.g3525833791

