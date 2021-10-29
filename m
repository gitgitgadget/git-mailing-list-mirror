Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452B6C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAC260524
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhJ2VSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhJ2VSB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:18:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057B6C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d3so18590292wrh.8
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e9Ii73Ow9usTCyIKzcIqCTN0ARWdmnCruxStEs2he/c=;
        b=jkXcfGu1fsi9cMJ8FkzRIuFWLcqxZouYtlKKYlb9apZu436/L/Y2DZjyCiYYcvI+9B
         RFTShbec659+IzO2UiGVavVMrdSVV2jCyMdT+C5o3X7UbuNzqnUNAGsYSAlD3R1ARQHg
         G9MPuJr3PFQuPNdc+tV3iVzi1nXaAa+YyNzoPLqhNn2NE+1R5NPSsW9ubGO6jWGDTlyU
         buBH6T+Cw/Ygd1wO/36uEy7YJsusQbOzNBvgNdxdWa5gRUFLh+xRLapokaX+DuOt2EHC
         REk1bLzJZ5FzHjnKasBDXd5FrLUPm5/t3T6a7qYrfPu9Be0r6vA685WYKaDF0HksG56y
         Xvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e9Ii73Ow9usTCyIKzcIqCTN0ARWdmnCruxStEs2he/c=;
        b=Sx+6JMZB6Gk12cuh/hHAt1XAzpVFNCRJNjx4aaV7YM6V2fJ0gVb+02ArwUc/3gi0/L
         ddKB5EoThZdqiL3QwIdVIWOISGplIljjOp1arTEZQXUK2yIs22MGqEnMOZiFHvEEa5Rl
         AImvusznTTdrbFx635BObexeenSHefKAAbT6eB9eo+XzazRAXEoRn4LyJJ2P6QTNkoaw
         vxwhuBBK87Fl6uPSCll9NxhPtYDrahv0r9ZEy9vvLr7Pv5TBgxKva044tWkWBSH9JAsS
         VQZ7NGC2/Ip6GYwts6yhhG87OkZ/WE3zK4VYIC0kgsvWhTQEJq/pOASLcFMdybluWwpP
         RAqQ==
X-Gm-Message-State: AOAM531y70noQQwCeqKF09RQOGYggqLg6yfOQMzWf7ygNzkV3XXor25n
        IH5P0+ZysBBFsd3EZ+WO4GNd3a19YG198w==
X-Google-Smtp-Source: ABdhPJxhu/QJmGCwuteLE493XC+jfsI18a/J1jEAeljVds3EUr0KVwz35mB2IHA+6lMlR6n6iVSeTg==
X-Received: by 2002:adf:9c11:: with SMTP id f17mr17642154wrc.147.1635542130394;
        Fri, 29 Oct 2021 14:15:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16sm735168wmc.46.2021.10.29.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:15:30 -0700 (PDT)
Message-Id: <54530e1e009f7bbebb3be1c7710f766112a492fb.1635542128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
References: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 21:15:25 +0000
Subject: [PATCH 2/4] oneline: print newline after decorations if flag provided
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

* log-tree.c: pass in format, oneline, abbrev so format_decorations can
  print a newline with an indentation.
* log-tree.h: adding parameters in header file
* pretty.c: pass in arguments format, oneline to format_decorations call
  but these don't get used in this context

Signed-off-by: John Cai <johncai86@gmail.com>
---
 log-tree.c | 20 ++++++++++++++++----
 log-tree.h |  7 +++++--
 pretty.c   |  4 ++--
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 644893fd8cf..d2f1eeeebf5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -285,6 +285,9 @@ static void show_name(struct strbuf *sb, const struct name_decoration *decoratio
 void format_decorations_extended(struct strbuf *sb,
 			const struct commit *commit,
 			int use_color,
+			int format,
+			int abbrev_len,
+			int newline,
 			const char *prefix,
 			const char *separator,
 			const char *suffix)
@@ -333,11 +336,16 @@ void format_decorations_extended(struct strbuf *sb,
 	strbuf_addstr(sb, color_commit);
 	strbuf_addstr(sb, suffix);
 	strbuf_addstr(sb, color_reset);
+	if ((format == CMIT_FMT_ONELINE) && newline == 1) {
+		strbuf_addstr(sb, "\n");
+		strbuf_addchars(sb, ' ', abbrev_len);
+	}
 }
 
 void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
+	int newline = 0;
 
 	if (opt->sources) {
 		char **slot = revision_sources_peek(opt->sources, commit);
@@ -347,7 +355,11 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 	}
 	if (!opt->show_decorations)
 		return;
-	format_decorations(&sb, commit, opt->diffopt.use_color);
+
+	if (opt->newlineafter == NEWLINEAFTER_DECORATIONS)
+		newline = 1;
+
+	format_decorations(&sb, commit, opt->diffopt.use_color, opt->commit_format, opt->abbrev, newline);
 	fputs(sb.buf, opt->diffopt.file);
 	strbuf_release(&sb);
 }
@@ -623,6 +635,7 @@ void show_log(struct rev_info *opt)
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : the_hash_algo->hexsz;
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
+	char hex[GIT_MAX_HEXSZ + 1];
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
@@ -692,9 +705,8 @@ void show_log(struct rev_info *opt)
 
 		if (!opt->graph)
 			put_revision_mark(opt, commit);
-		fputs(find_unique_abbrev(&commit->object.oid,
-					 abbrev_commit),
-		      opt->diffopt.file);
+		opt->abbrev = find_unique_abbrev_r(hex, &commit->object.oid, abbrev_commit);
+		fputs(hex, opt->diffopt.file);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit, opt->diffopt.file);
 		if (opt->children.name)
diff --git a/log-tree.h b/log-tree.h
index e7e4641cf83..a401e659d4c 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -19,11 +19,14 @@ int log_tree_commit(struct rev_info *, struct commit *);
 void show_log(struct rev_info *opt);
 void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
 			     int use_color,
+			     int format,
+			     int abbrev_len,
+			     int newline,
 			     const char *prefix,
 			     const char *separator,
 			     const char *suffix);
-#define format_decorations(strbuf, commit, color) \
-			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
+#define format_decorations(strbuf, commit, color, format, abbrev_len, newline) \
+			     format_decorations_extended((strbuf), (commit), (color), (format), (abbrev_len), (newline), " (", ", ", ")")
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
diff --git a/pretty.c b/pretty.c
index fe95107ae5a..98144deac5c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1385,10 +1385,10 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decorations(sb, commit, c->auto_color);
+		format_decorations(sb, commit, c->auto_color, c->pretty_ctx->fmt, 0, 0);
 		return 1;
 	case 'D':
-		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
+		format_decorations_extended(sb, commit, c->auto_color, c->pretty_ctx->fmt, 0, 0, "", ", ", "");
 		return 1;
 	case 'S':		/* tag/branch like --source */
 		if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
-- 
gitgitgadget

