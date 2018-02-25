Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37051F404
	for <e@80x24.org>; Sun, 25 Feb 2018 20:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeBYUfz (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 15:35:55 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44902 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeBYUfw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 15:35:52 -0500
Received: by mail-wr0-f195.google.com with SMTP id v65so19116879wrc.11
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQzcVTVNNovVfPPD4uS7UgWZFagaf4/lG9LBF6Z+APE=;
        b=Fez4zZWxzpVOOgPwP03fCCbGm8UNL98uba+V1m7TCdqDdyoUu2HW08VaFfApXLrJKf
         H4yyZ8NQsrzUT9e9LKG7zSomW96jaRjEAGnJKh3H9V2H031BGHljhKcKUppDPI6ie2NE
         tNn9NoRMoG4jXojqMmUrjylknkFPydAa9zntdRgE3ecJcG8EMcppW/PJ6RPR+9MzHEmU
         2ycwx2rM5NyickbTqWxTTcuuTHFwjG4DBxQJgQeHYBKXzIMaZ3dLakkXVy75hIZNq0DN
         QfL0f2qKOXvKvgsfGIdbyCff9f+sFMwKrFWN/oNM3V6voPUKg/SWDBJmPPCDuKJLTTYM
         40MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQzcVTVNNovVfPPD4uS7UgWZFagaf4/lG9LBF6Z+APE=;
        b=oXolp6S2/fxse6nJw38jqmztidKE9djj2IQYlt+/01Old6X00a5Xd3LBqUC6HYU2Bm
         d8sCaYg1aoxuDWWQ7NPVbtFT3ju7TP5AnfKRpChgQHC7C79a9qQ/oXihViAwInjMT1fH
         8qB4iowy3tGzNbvbCp4AGHWntWID3OYRm4Fw+O8rASz89COkHMqBhvJXhJ8PtSRpkMfd
         S6t/WK2M5+PDt3wH5lYBryNSfiUTzQS7c+shKa1Xfw2EdYDQ0HDN2DI4mzLbULQWVhrZ
         8HNNKWSB9ly3h0uYBxIpBKd5844aA7io65gDoHywQXCos6+b/z0NB9FeMxZGBorw3L+S
         HmyA==
X-Gm-Message-State: APf1xPCfizS2yvPJc+2uk3DTFLvHo/x008jgndAYFwwBB3HcdCtx/GBa
        rA5/8BOZTXrRmo29jzMf/SFti8aI
X-Google-Smtp-Source: AH8x2256zCeZnimWGS4IcCoe8/9kpf89LMLWJMr0BIQyR+PLRdC2hO2+T1GJQyzfAS9Rvs4ZEB6uMg==
X-Received: by 10.223.153.23 with SMTP id x23mr7205968wrb.134.1519590950713;
        Sun, 25 Feb 2018 12:35:50 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 7sm6564268wmq.42.2018.02.25.12.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 12:35:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] wildmatch: use the new precompiling wildmatch()
Date:   Sun, 25 Feb 2018 20:35:37 +0000
Message-Id: <20180225203537.28318-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180225203537.28318-1-avarab@gmail.com>
References: <20180225203537.28318-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make some limited use of the wildmatch() interface for "precompiling"
patterns, although the current implementation does not do this yet.

The main hot codepath in dir.c is not being touched yet, but some
other invocations where we repeatedly match the same glob against
multiple strings have been migrated.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/name-rev.c | 7 ++++++-
 builtin/replace.c  | 7 ++++---
 config.c           | 8 ++++++--
 refs.c             | 7 ++++---
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 9e088ebd11..c75ac8d9af 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -128,14 +128,19 @@ static void name_rev(struct commit *commit,
 static int subpath_matches(const char *path, const char *filter)
 {
 	const char *subpath = path;
+	struct wildmatch_compiled *wildmatch_compiled =
+		wildmatch_compile(filter, 0);
 
 	while (subpath) {
-		if (!wildmatch(filter, subpath, 0))
+		if (!wildmatch_match(wildmatch_compiled, subpath)) {
+			wildmatch_free(wildmatch_compiled);
 			return subpath - path;
+		}
 		subpath = strchr(subpath, '/');
 		if (subpath)
 			subpath++;
 	}
+	wildmatch_free(wildmatch_compiled);
 	return -1;
 }
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 83d3235721..9be72f2b7b 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -32,7 +32,7 @@ enum replace_format {
 };
 
 struct show_data {
-	const char *pattern;
+	struct wildmatch_compiled *wildmatch_compiled;
 	enum replace_format format;
 };
 
@@ -41,7 +41,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 {
 	struct show_data *data = cb_data;
 
-	if (!wildmatch(data->pattern, refname, 0)) {
+	if (!wildmatch_match(data->wildmatch_compiled, refname)) {
 		if (data->format == REPLACE_FORMAT_SHORT)
 			printf("%s\n", refname);
 		else if (data->format == REPLACE_FORMAT_MEDIUM)
@@ -70,7 +70,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 
 	if (pattern == NULL)
 		pattern = "*";
-	data.pattern = pattern;
+	data.wildmatch_compiled = wildmatch_compile(pattern, 0);
 
 	if (format == NULL || *format == '\0' || !strcmp(format, "short"))
 		data.format = REPLACE_FORMAT_SHORT;
@@ -84,6 +84,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 		    format);
 
 	for_each_replace_ref(show_reference, (void *)&data);
+	wildmatch_free(data.wildmatch_compiled);
 
 	return 0;
 }
diff --git a/config.c b/config.c
index b0c20e6cb8..0f595de971 100644
--- a/config.c
+++ b/config.c
@@ -210,6 +210,7 @@ static int include_by_gitdir(const struct config_options *opts,
 	int ret = 0, prefix;
 	const char *git_dir;
 	int already_tried_absolute = 0;
+	struct wildmatch_compiled *wildmatch_compiled = NULL;
 
 	if (opts->git_dir)
 		git_dir = opts->git_dir;
@@ -237,8 +238,10 @@ static int include_by_gitdir(const struct config_options *opts,
 			goto done;
 	}
 
-	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
-			 icase ? WM_CASEFOLD : 0);
+	if (!wildmatch_compiled)
+		wildmatch_compiled = wildmatch_compile(pattern.buf + prefix,
+						       icase ? WM_CASEFOLD : 0);
+	ret = !wildmatch_match(wildmatch_compiled, text.buf + prefix);
 
 	if (!ret && !already_tried_absolute) {
 		/*
@@ -257,6 +260,7 @@ static int include_by_gitdir(const struct config_options *opts,
 done:
 	strbuf_release(&pattern);
 	strbuf_release(&text);
+	wildmatch_free(wildmatch_compiled);
 	return ret;
 }
 
diff --git a/refs.c b/refs.c
index 20ba82b434..c631793d1e 100644
--- a/refs.c
+++ b/refs.c
@@ -213,7 +213,7 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 
 /* The argument to filter_refs */
 struct ref_filter {
-	const char *pattern;
+	struct wildmatch_compiled *code;
 	each_ref_fn *fn;
 	void *cb_data;
 };
@@ -291,7 +291,7 @@ static int filter_refs(const char *refname, const struct object_id *oid,
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 
-	if (wildmatch(filter->pattern, refname, 0))
+	if (wildmatch_match(filter->code, refname))
 		return 0;
 	return filter->fn(refname, oid, flags, filter->cb_data);
 }
@@ -454,12 +454,13 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 		strbuf_addch(&real_pattern, '*');
 	}
 
-	filter.pattern = real_pattern.buf;
+	filter.code = wildmatch_compile(real_pattern.buf, 0);
 	filter.fn = fn;
 	filter.cb_data = cb_data;
 	ret = for_each_ref(filter_refs, &filter);
 
 	strbuf_release(&real_pattern);
+	wildmatch_free(filter.code);
 	return ret;
 }
 
-- 
2.15.1.424.g9478a66081

