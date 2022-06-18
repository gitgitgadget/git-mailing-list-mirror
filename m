Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E8C433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383765AbiFRAVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383739AbiFRAV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7356E663C9
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so7510433wrd.8
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x8732zrRviVYi7oflkB1AFK8oc6/ARNmZOK3eguro0U=;
        b=I6V/kQ+ehLP8ozpkftZIyBRmiHgkY6c9IkOHvxlFcc+cOgSy0XIMBye67ltoXex/+H
         tuKV0XU9efmZB0t1NXd9XhfkytJ41ytaUJvWaXzZjbqPuNmER9FhnqrZjIdhzDOyQbcb
         9NGZGioF+JXLtHcmWJRkyc2QsfHX0RtQriAMzgyCZ6vtF+WGhjgDgPwx5deyeOVo8NsD
         +mANNQV1UvbiZiV1CZSuvgwwWHoiKdX/YE3FYQEClRbeZ464tKaIf7HMu379PDdovkkt
         +sBZ8Gb6LPwEYybFhNG970sJAHCRrHtZ+14D+67dDIep3g43SJE4Iret8wYg1O87b2uf
         d7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x8732zrRviVYi7oflkB1AFK8oc6/ARNmZOK3eguro0U=;
        b=GHwCXB3d05j9cj1B7TXtkn5ZLP3GQrnITn2UANPcARa96Puipm9LagysFgG9hdZwm8
         yEFV0Prkq+Mf7wDNEoZ6tYZnkZ3jtu23B2UsSqoHOX8aHItORzmvZhVZF5K2V3DkRY60
         QE3u2weHaF4q6wW9lPo3zz34UgFg0KiW7+Jiz5jYGh9Hn+M0iBaj/fNcxeHvNMcV11wN
         FTxiYsnVYtzJk4bxVTOwZSpQHOhKC6N4GEqnEaA44al1j6Yu6a7v5jR0KoM54EzUIVIc
         BMpdfr3I1iL8dJOeTUuvO8Me13wZBqgQdmnhePJ1IKbLUKnpZUpiJRDHaKyoSn9tWWeP
         yMdA==
X-Gm-Message-State: AJIora+2L2whViaJWwkppCcynPyCJlTrYvBkl0UikZmjGPkeFTNfHTI/
        Xz01OONJXUhobB9mA0OaHfc7nS0GDWWdYA==
X-Google-Smtp-Source: AGRyM1vo+rEdwq0BfV1FV5ifpMwUtJ0lxXucYpbgqxsCQUGzSxiisTj94h1iuIDujtYB9jCDwYTm0A==
X-Received: by 2002:adf:db91:0:b0:21a:2731:fca8 with SMTP id u17-20020adfdb91000000b0021a2731fca8mr11291640wri.520.1655511677524;
        Fri, 17 Jun 2022 17:21:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b0039c4ba160absm20391697wmq.2.2022.06.17.17.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:16 -0700 (PDT)
Message-Id: <6b47c0fdbd7764275325ae75d534c506da4fe4d5.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:55 +0000
Subject: [PATCH v7 12/17] merge-ort: make `path_messages` a strmap to a
 string_list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This allows us once again to get away with less data copying.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c      | 27 ++++++++++++++++++++-------
 merge-ort.c | 34 +---------------------------------
 merge-ort.h |  2 +-
 3 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/diff.c b/diff.c
index e71cf758861..2214ae49e4b 100644
--- a/diff.c
+++ b/diff.c
@@ -3362,23 +3362,23 @@ struct userdiff_driver *get_textconv(struct repository *r,
 	return userdiff_get_textconv(r, one->driver);
 }
 
-static struct strbuf *additional_headers(struct diff_options *o,
-					 const char *path)
+static struct string_list *additional_headers(struct diff_options *o,
+					      const char *path)
 {
 	if (!o->additional_path_headers)
 		return NULL;
 	return strmap_get(o->additional_path_headers, path);
 }
 
-static void add_formatted_headers(struct strbuf *msg,
-				  struct strbuf *more_headers,
+static void add_formatted_header(struct strbuf *msg,
+				  const char *header,
 				  const char *line_prefix,
 				  const char *meta,
 				  const char *reset)
 {
-	char *next, *newline;
+	const char *next, *newline;
 
-	for (next = more_headers->buf; *next; next = newline) {
+	for (next = header; *next; next = newline) {
 		newline = strchrnul(next, '\n');
 		strbuf_addf(msg, "%s%s%.*s%s\n", line_prefix, meta,
 			    (int)(newline - next), next, reset);
@@ -3387,6 +3387,19 @@ static void add_formatted_headers(struct strbuf *msg,
 	}
 }
 
+static void add_formatted_headers(struct strbuf *msg,
+				  struct string_list *more_headers,
+				  const char *line_prefix,
+				  const char *meta,
+				  const char *reset)
+{
+	int i;
+
+	for (i = 0; i < more_headers->nr; i++)
+		add_formatted_header(msg, more_headers->items[i].string,
+				     line_prefix, meta, reset);
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -4314,7 +4327,7 @@ static void fill_metainfo(struct strbuf *msg,
 	const char *set = diff_get_color(use_color, DIFF_METAINFO);
 	const char *reset = diff_get_color(use_color, DIFF_RESET);
 	const char *line_prefix = diff_line_prefix(o);
-	struct strbuf *more_headers = NULL;
+	struct string_list *more_headers = NULL;
 
 	*must_show_header = 1;
 	strbuf_init(msg, PATH_MAX * 2 + 300);
diff --git a/merge-ort.c b/merge-ort.c
index 668aec64f13..dfec08c88be 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4370,8 +4370,6 @@ void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
 	struct merge_options_internal *opti = result->priv;
-	struct hashmap_iter iter;
-	struct strmap_entry *e;
 
 	if (opt->renormalize)
 		git_attr_set_direction(GIT_ATTR_CHECKIN);
@@ -4379,15 +4377,6 @@ void merge_finalize(struct merge_options *opt,
 
 	clear_or_reinit_internal_opts(opti, 0);
 	FREE_AND_NULL(opti);
-
-	/* Release and free each strbuf found in path_messages */
-	strmap_for_each_entry(result->path_messages, &iter, e) {
-		struct strbuf *buf = e->value;
-
-		strbuf_release(buf);
-	}
-	strmap_clear(result->path_messages, 1);
-	FREE_AND_NULL(result->path_messages);
 }
 
 /*** Function Grouping: helper functions for merge_incore_*() ***/
@@ -4611,8 +4600,6 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 					    struct merge_result *result)
 {
 	struct object_id working_tree_oid;
-	struct hashmap_iter iter;
-	struct strmap_entry *e;
 
 	if (opt->subtree_shift) {
 		side2 = shift_tree_object(opt->repo, side1, side2,
@@ -4653,26 +4640,7 @@ redo:
 	trace2_region_leave("merge", "process_entries", opt->repo);
 
 	/* Set return values */
-	result->path_messages = xcalloc(1, sizeof(*result->path_messages));
-	strmap_init_with_options(result->path_messages, NULL, 0);
-	strmap_for_each_entry(&opt->priv->conflicts, &iter, e) {
-		const char *path = e->key;
-		struct strbuf *buf = strmap_get(result->path_messages, path);
-		struct string_list *conflicts = e->value;
-
-		if (!buf) {
-			buf = xcalloc(1, sizeof(*buf));
-			strbuf_init(buf, 0);
-			strmap_put(result->path_messages, path, buf);
-		}
-
-		for (int i = 0; i < conflicts->nr; i++) {
-			if (buf->len)
-				strbuf_addch(buf, '\n');
-			strbuf_addstr(buf, conflicts->items[i].string);
-			strbuf_trim_trailing_newline(buf);
-		}
-	}
+	result->path_messages = &opt->priv->conflicts;
 
 	result->tree = parse_tree_indirect(&working_tree_oid);
 	/* existence of conflicted entries implies unclean */
diff --git a/merge-ort.h b/merge-ort.h
index f9c536ed8c4..c4909bcbf96 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -28,7 +28,7 @@ struct merge_result {
 	/*
 	 * Special messages and conflict notices for various paths
 	 *
-	 * This is a map of pathnames to strbufs. It contains various
+	 * This is a map of pathnames to a string_list. It contains various
 	 * warning/conflict/notice messages (possibly multiple per path)
 	 * that callers may want to use.
 	 */
-- 
gitgitgadget

