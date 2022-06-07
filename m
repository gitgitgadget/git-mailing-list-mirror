Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA28C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386567AbiFHA35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839413AbiFHADJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 20:03:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7D1EEB93
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:42:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k16so25702147wrg.7
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C3VeTaSpsyjNjv445FZ5ATeKLyQuS87OAVtCJM+JQzE=;
        b=cBskUPcVirFGxYRKecOty/qShfOx32Z88XIOyLzOXQSDSgD4q7AzoLXSSqMqlevkAX
         LyzhwQ6tqpublcv/KtDSIPvJH9BAe0jRaUPLI24pQbX1M7CK1OezN0FKkdWtrZU25HlP
         AEIMcvXwhNCTe9VKoMXEupPshJoCa9i+/5mYX4/baIbEEa3etL95nUibwF6lC0gecdXc
         I9CzKrT8fmQlXo/IpuhwyMg0eLuMvyxKBZxmFGWTLEuLGLHohQOOvT6dd5Y1I34B6Jm1
         9lHVy/OBw74YtR4tS2R5Mr0+tLEfrma53ZWZHKkXMlAD5J91JFVj3FVFYIyRW17r4XpB
         DttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C3VeTaSpsyjNjv445FZ5ATeKLyQuS87OAVtCJM+JQzE=;
        b=RUCdzdPwzBlTqghU4OfzQCpD8WrN5lqXTP19OvA22GXRDfPgPKifRaNdbeof+SgsDb
         cJ2JAFlCAXhr9Gx+zDpDsP+qK1vIRKfXLgE/9LI9lTy9CFiyJrbLk814rTkxE+hWHA/J
         LO4myouDZaU6AIOJYaXSFloCdYGAKbq2GTVaUN1MMmMS4l1p6ZFZLiwnlqY/rLoDXx/a
         +eiflZ74+z8AycPUmRmKXT5vsNf1hjjD2WCZeRKxGaDzNd+45EjSukW9J0UYmAkooT4q
         0r8tdQrrwHPKIoYVDYjQo5QBPYQiUrXZgY0zZ+bEumzzjZk5ojmkoO/0RjWpyGDM37Tf
         Bf/g==
X-Gm-Message-State: AOAM530V4DkRNJZ+GTWpmkLkaWxPBiG67dL0ySAkZ3tCoqUGG5o2Mc57
        xr27Sv1cojd87hQ1OGs6bQBHei9nATUF9PnL
X-Google-Smtp-Source: ABdhPJzRvknDl00rrsQKSPjonq6iUjfuTIcrGZGKWygcKQIWhuEIHNXRvB1Ol1WNQFCQRxP1E0sujA==
X-Received: by 2002:a5d:570c:0:b0:210:32e1:7250 with SMTP id a12-20020a5d570c000000b0021032e17250mr30368720wrv.368.1654634572517;
        Tue, 07 Jun 2022 13:42:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b00213b93cff5fsm14641587wri.98.2022.06.07.13.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:42:51 -0700 (PDT)
Message-Id: <4f9f34876413927d819313a70fcdefcad5b35689.1654634569.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:42:43 +0000
Subject: [PATCH v2 1/7] log-tree: create for_each_decoration()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It can be helpful to iterate through all the decorations on a commit
without necessarily writing them to a stream. Implement
for_each_decoration() and reimplement format_decorations_extended() to
use that iterator.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 log-tree.c | 111 ++++++++++++++++++++++++++++++++++++-----------------
 log-tree.h |   4 ++
 2 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index d0ac0a6327a..b15a7c9db22 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -282,6 +282,54 @@ static void show_name(struct strbuf *sb, const struct name_decoration *decoratio
 		strbuf_addstr(sb, decoration->name);
 }
 
+struct format_decorations_context {
+	struct strbuf *sb;
+	int use_color;
+	const char *prefix;
+	const char *separator;
+	const char *suffix;
+	const char *color_commit;
+	const char *color_reset;
+	const struct name_decoration *current_and_HEAD;
+};
+
+static int append_decoration(const struct name_decoration *d,
+			     void *data)
+{
+	struct format_decorations_context *ctx = data;
+	/*
+	 * When both current and HEAD are there, only
+	 * show HEAD->current where HEAD would have
+	 * appeared, skipping the entry for current.
+	 */
+	if (d != ctx->current_and_HEAD) {
+		strbuf_addstr(ctx->sb, ctx->color_commit);
+		strbuf_addstr(ctx->sb, ctx->prefix);
+		strbuf_addstr(ctx->sb, ctx->color_reset);
+		strbuf_addstr(ctx->sb, decorate_get_color(ctx->use_color, d->type));
+		if (d->type == DECORATION_REF_TAG)
+			strbuf_addstr(ctx->sb, "tag: ");
+
+		show_name(ctx->sb, d);
+
+		if (ctx->current_and_HEAD &&
+		    d->type == DECORATION_REF_HEAD) {
+			strbuf_addstr(ctx->sb, " -> ");
+			strbuf_addstr(ctx->sb, ctx->color_reset);
+			strbuf_addstr(ctx->sb,
+				      decorate_get_color(
+						ctx->use_color,
+						ctx->current_and_HEAD->type));
+			show_name(ctx->sb, ctx->current_and_HEAD);
+		}
+		strbuf_addstr(ctx->sb, ctx->color_reset);
+
+		ctx->prefix = ctx->separator;
+	}
+
+	return 0;
+}
+
 /*
  * The caller makes sure there is no funny color before calling.
  * format_decorations_extended makes sure the same after return.
@@ -294,49 +342,42 @@ void format_decorations_extended(struct strbuf *sb,
 			const char *suffix)
 {
 	const struct name_decoration *decoration;
-	const struct name_decoration *current_and_HEAD;
-	const char *color_commit =
-		diff_get_color(use_color, DIFF_COMMIT);
-	const char *color_reset =
-		decorate_get_color(use_color, DECORATION_NONE);
+	struct format_decorations_context ctx = {
+		.sb = sb,
+		.use_color = use_color,
+		.prefix = prefix,
+		.separator = separator,
+		.suffix = suffix,
+		.color_commit =	diff_get_color(use_color, DIFF_COMMIT),
+		.color_reset = decorate_get_color(use_color, DECORATION_NONE),
+	};
 
 	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
 		return;
 
-	current_and_HEAD = current_pointed_by_HEAD(decoration);
-	while (decoration) {
-		/*
-		 * When both current and HEAD are there, only
-		 * show HEAD->current where HEAD would have
-		 * appeared, skipping the entry for current.
-		 */
-		if (decoration != current_and_HEAD) {
-			strbuf_addstr(sb, color_commit);
-			strbuf_addstr(sb, prefix);
-			strbuf_addstr(sb, color_reset);
-			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
-			if (decoration->type == DECORATION_REF_TAG)
-				strbuf_addstr(sb, "tag: ");
-
-			show_name(sb, decoration);
-
-			if (current_and_HEAD &&
-			    decoration->type == DECORATION_REF_HEAD) {
-				strbuf_addstr(sb, " -> ");
-				strbuf_addstr(sb, color_reset);
-				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
-				show_name(sb, current_and_HEAD);
-			}
-			strbuf_addstr(sb, color_reset);
+	ctx.current_and_HEAD = current_pointed_by_HEAD(decoration);
 
-			prefix = separator;
-		}
+	for_each_decoration(commit, append_decoration, &ctx);
+
+	strbuf_addstr(sb, ctx.color_commit);
+	strbuf_addstr(sb, ctx.suffix);
+	strbuf_addstr(sb, ctx.color_reset);
+}
+
+int for_each_decoration(const struct commit *c, decoration_fn fn, void *data)
+{
+	const struct name_decoration *decoration;
+
+	decoration = get_name_decoration(&c->object);
+	while (decoration) {
+		int res;
+		if ((res = fn(decoration, data)))
+			return res;
 		decoration = decoration->next;
 	}
-	strbuf_addstr(sb, color_commit);
-	strbuf_addstr(sb, suffix);
-	strbuf_addstr(sb, color_reset);
+
+	return 0;
 }
 
 void show_decorations(struct rev_info *opt, struct commit *commit)
diff --git a/log-tree.h b/log-tree.h
index e7e4641cf83..ea07da2625b 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -35,4 +35,8 @@ void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
 void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
 void fmt_output_email_subject(struct strbuf *, struct rev_info *);
 
+typedef int decoration_fn(const struct name_decoration *d,
+			  void *data);
+int for_each_decoration(const struct commit *c, decoration_fn fn, void *data);
+
 #endif
-- 
gitgitgadget

