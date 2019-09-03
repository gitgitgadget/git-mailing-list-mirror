Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BADF31F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfICSFB (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:05:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53302 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfICSFA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:05:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id q19so474204wmc.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jNv7lxr5KUrORFhK0WlGegrj3lEmBGUBMCfGAL18m7o=;
        b=POIL2XIFNgC+2uFohnpdwigTwNbtJx9E5CW3VfGDwwZwqKpa9ig5FdiN47orc7dvFN
         KAl8XiYwdZxOhRpOwCO4UPjY52nuKqAk3cpiLMtjuDHJqc1f1olux3hCMN7ZFOw7KZ0k
         PHytAm0XHA7tQpCQh7k26Mc6Qy2tF3L4ZcWVEykoBiPk3e9ecnCyXyFS3HaTT7dVvznG
         mv+6oWrNZX5TDbg459BBgOVwoKvywEINtH/dujCP2+wOh0AmdF4ScY7qCnm9tXZmgzTh
         XwcXpb0KE3879XXz+V5Qs32yjFOpLIvHVEOOkQekhFkoJUdJdWhMVqmzkSs1trCZZFTx
         g90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jNv7lxr5KUrORFhK0WlGegrj3lEmBGUBMCfGAL18m7o=;
        b=ixwBgPDTetrW2k+H4OUN9/Xv1OdnUu7JebyXGDsScDU3p5X+v9p6edtFRS7+Hhj04n
         S4vvA5zJAOOwqnoJW+149v6xYbx1+I0DVQ8rJvzabHt6NPezih1/UKPgXbJOes5c2Op+
         qmLY9W4X08MODHRdDBiXyXhhI1VdhLNrX/4YAZc+ML9Og80Q2DTHtciQ+1XnIGSqZPaM
         doBxUdLUPsnJuUl2NTjHYbNONrfxIRtT4OwEQ5FaLjaC/QEGeq4k3SnOCA5g1a0Zy25R
         6yOkp+Y60v/Ol9dSM7dcRJAK18dyamksvFvg7hs9yU4wxW/rsAsQBr4Fkrb9kW2RdxZR
         hLpA==
X-Gm-Message-State: APjAAAWHh/YsD7JzmXRmTHFiSJK7uffjjyeeaNFjrtB9EHZn2Jh57F04
        SztU1CIzhV2JHOFgIC239nlKzEXx
X-Google-Smtp-Source: APXvYqxf3CCFsHqOrckl9zu79qjVzz7kkQEvRqaxdN+S+vhOtTQN/Ssce09+rOxhLs256AbGCPeoiw==
X-Received: by 2002:a7b:c045:: with SMTP id u5mr656674wmc.139.1567533897423;
        Tue, 03 Sep 2019 11:04:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm11752631wrq.22.2019.09.03.11.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:04:56 -0700 (PDT)
Date:   Tue, 03 Sep 2019 11:04:56 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 18:04:51 GMT
Message-Id: <7972c559ff13dd2c108dcfba913e14733c9cb7d2.1567533893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.329.git.gitgitgadget@gmail.com>
References: <pull.329.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/5] treewide: rename 'EXCL_FLAG_' to 'PATTERN_FLAG_'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, pclouds@gmail.com, peff@peff.net,
        jon@jonsimons.org, matvore@comcast.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The first consumer of pattern-matching filenames was the
.gitignore feature. In that context, storing a list of patterns
as a 'struct exclude_list'  makes sense. However, the
sparse-checkout feature then adopted these structures and methods,
but with the opposite meaning: these patterns match the files
that should be included!

It would be clearer to rename this entire library as a "pattern
matching" library, and the callers apply exclusion/inclusion
logic accordingly based on their needs.

This commit replaces 'EXCL_FLAG_' to 'PATTERN_FLAG_' in the
names of the flags used on 'struct path_pattern'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 attr.c                 |  8 ++++----
 builtin/check-ignore.c |  4 ++--
 dir.c                  | 22 +++++++++++-----------
 dir.h                  | 10 +++++-----
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/attr.c b/attr.c
index 93dc16b59c..d90239869a 100644
--- a/attr.c
+++ b/attr.c
@@ -259,7 +259,7 @@ struct pattern {
 	const char *pattern;
 	int patternlen;
 	int nowildcardlen;
-	unsigned flags;		/* EXC_FLAG_* */
+	unsigned flags;		/* PATTERN_FLAG_* */
 };
 
 /*
@@ -404,7 +404,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
 				      &res->u.pat.nowildcardlen);
-		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
+		if (res->u.pat.flags & PATTERN_FLAG_NEGATIVE) {
 			warning(_("Negative patterns are ignored in git attributes\n"
 				  "Use '\\!' for literal leading exclamation."));
 			goto fail_return;
@@ -991,10 +991,10 @@ static int path_matches(const char *pathname, int pathlen,
 	int prefix = pat->nowildcardlen;
 	int isdir = (pathlen && pathname[pathlen - 1] == '/');
 
-	if ((pat->flags & EXC_FLAG_MUSTBEDIR) && !isdir)
+	if ((pat->flags & PATTERN_FLAG_MUSTBEDIR) && !isdir)
 		return 0;
 
-	if (pat->flags & EXC_FLAG_NODIR) {
+	if (pat->flags & PATTERN_FLAG_NODIR) {
 		return match_basename(pathname + basename_offset,
 				      pathlen - basename_offset - isdir,
 				      pattern, prefix,
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 97108ccb9c..28b8f14999 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -34,8 +34,8 @@ static const struct option check_ignore_options[] = {
 
 static void output_pattern(const char *path, struct path_pattern *pattern)
 {
-	char *bang  = (pattern && pattern->flags & EXC_FLAG_NEGATIVE)  ? "!" : "";
-	char *slash = (pattern && pattern->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
+	char *bang  = (pattern && pattern->flags & PATTERN_FLAG_NEGATIVE)  ? "!" : "";
+	char *slash = (pattern && pattern->flags & PATTERN_FLAG_MUSTBEDIR) ? "/" : "";
 	if (!nul_term_line) {
 		if (!verbose) {
 			write_name_quoted(path, stdout, '\n');
diff --git a/dir.c b/dir.c
index b522d61ee0..640f10973e 100644
--- a/dir.c
+++ b/dir.c
@@ -571,20 +571,20 @@ void parse_exclude_pattern(const char **pattern,
 
 	*flags = 0;
 	if (*p == '!') {
-		*flags |= EXC_FLAG_NEGATIVE;
+		*flags |= PATTERN_FLAG_NEGATIVE;
 		p++;
 	}
 	len = strlen(p);
 	if (len && p[len - 1] == '/') {
 		len--;
-		*flags |= EXC_FLAG_MUSTBEDIR;
+		*flags |= PATTERN_FLAG_MUSTBEDIR;
 	}
 	for (i = 0; i < len; i++) {
 		if (p[i] == '/')
 			break;
 	}
 	if (i == len)
-		*flags |= EXC_FLAG_NODIR;
+		*flags |= PATTERN_FLAG_NODIR;
 	*nowildcardlen = simple_length(p);
 	/*
 	 * we should have excluded the trailing slash from 'p' too,
@@ -594,7 +594,7 @@ void parse_exclude_pattern(const char **pattern,
 	if (*nowildcardlen > len)
 		*nowildcardlen = len;
 	if (*p == '*' && no_wildcard(p + 1))
-		*flags |= EXC_FLAG_ENDSWITH;
+		*flags |= PATTERN_FLAG_ENDSWITH;
 	*pattern = p;
 	*patternlen = len;
 }
@@ -608,7 +608,7 @@ void add_exclude(const char *string, const char *base,
 	int nowildcardlen;
 
 	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
-	if (flags & EXC_FLAG_MUSTBEDIR) {
+	if (flags & PATTERN_FLAG_MUSTBEDIR) {
 		FLEXPTR_ALLOC_MEM(pattern, pattern, string, patternlen);
 	} else {
 		pattern = xmalloc(sizeof(*pattern));
@@ -940,7 +940,7 @@ int match_basename(const char *basename, int basenamelen,
 		if (patternlen == basenamelen &&
 		    !fspathncmp(pattern, basename, basenamelen))
 			return 1;
-	} else if (flags & EXC_FLAG_ENDSWITH) {
+	} else if (flags & PATTERN_FLAG_ENDSWITH) {
 		/* "*literal" matching against "fooliteral" */
 		if (patternlen - 1 <= basenamelen &&
 		    !fspathncmp(pattern + 1,
@@ -1039,14 +1039,14 @@ static struct path_pattern *last_exclude_matching_from_list(const char *pathname
 		const char *exclude = pattern->pattern;
 		int prefix = pattern->nowildcardlen;
 
-		if (pattern->flags & EXC_FLAG_MUSTBEDIR) {
+		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR) {
 			if (*dtype == DT_UNKNOWN)
 				*dtype = get_dtype(NULL, istate, pathname, pathlen);
 			if (*dtype != DT_DIR)
 				continue;
 		}
 
-		if (pattern->flags & EXC_FLAG_NODIR) {
+		if (pattern->flags & PATTERN_FLAG_NODIR) {
 			if (match_basename(basename,
 					   pathlen - (basename - pathname),
 					   exclude, prefix, pattern->patternlen,
@@ -1083,7 +1083,7 @@ int is_excluded_from_list(const char *pathname,
 	pattern = last_exclude_matching_from_list(pathname, pathlen, basename,
 						  dtype, pl, istate);
 	if (pattern)
-		return pattern->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
+		return pattern->flags & PATTERN_FLAG_NEGATIVE ? 0 : 1;
 	return -1; /* undecided */
 }
 
@@ -1198,7 +1198,7 @@ static void prep_exclude(struct dir_struct *dir,
 				dir->basebuf.buf + current, &dt);
 			dir->basebuf.buf[stk->baselen - 1] = '/';
 			if (dir->pattern &&
-			    dir->pattern->flags & EXC_FLAG_NEGATIVE)
+			    dir->pattern->flags & PATTERN_FLAG_NEGATIVE)
 				dir->pattern = NULL;
 			if (dir->pattern) {
 				dir->exclude_stack = stk;
@@ -1298,7 +1298,7 @@ int is_excluded(struct dir_struct *dir, struct index_state *istate,
 	struct path_pattern *pattern =
 		last_exclude_matching(dir, istate, pathname, dtype_p);
 	if (pattern)
-		return pattern->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
+		return pattern->flags & PATTERN_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
 }
 
diff --git a/dir.h b/dir.h
index 4114d6bf78..87eb10662f 100644
--- a/dir.h
+++ b/dir.h
@@ -11,10 +11,10 @@ struct dir_entry {
 	char name[FLEX_ARRAY]; /* more */
 };
 
-#define EXC_FLAG_NODIR 1
-#define EXC_FLAG_ENDSWITH 4
-#define EXC_FLAG_MUSTBEDIR 8
-#define EXC_FLAG_NEGATIVE 16
+#define PATTERN_FLAG_NODIR 1
+#define PATTERN_FLAG_ENDSWITH 4
+#define PATTERN_FLAG_MUSTBEDIR 8
+#define PATTERN_FLAG_NEGATIVE 16
 
 struct path_pattern {
 	/*
@@ -28,7 +28,7 @@ struct path_pattern {
 	int nowildcardlen;
 	const char *base;
 	int baselen;
-	unsigned flags;		/* EXC_FLAG_* */
+	unsigned flags;		/* PATTERN_FLAG_* */
 
 	/*
 	 * Counting starts from 1 for line numbers in ignore files,
-- 
gitgitgadget

