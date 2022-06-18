Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD1C433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383784AbiFRAVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383734AbiFRAV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290459974
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so5051255wma.4
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NjCsXM44Os9LwG0J5rgBxCUbk4ZjcUC52aWZ+4EwgJE=;
        b=MoqSrJoEGXKqTEV8mrWOuC4o63OAyxBZ0sZgGPCo9Lw55p7mVe3HMTAd9YHUQ1kyJf
         leJn6uf7LiH7rVzf1uNioNyWYP+NTYXXfg454Qg+LJ2vew3LigvbzvqfVr4O3QwfCcu7
         vgVaJ1aIimSl5MPsjVAvl3utk9WPXtUV922DnTgGJvL/JxyPoFeXgjJMZZpQF5sQCdaH
         l4GfHpUuv57TiuCcB4Q5eAnwe2QYUr5Aqw4JEu98wRI+YZLKwNsNzWXYk/ZVobGg4rnu
         HiuxTBmqzrpOzQuT91FmnfJVZFVz+D6KAgF3cylg3Rw5kI/Z6KAStH8P6nElkYZX6qzz
         lqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NjCsXM44Os9LwG0J5rgBxCUbk4ZjcUC52aWZ+4EwgJE=;
        b=CsXd7ZCrdXpxtYZs4CVr+WUOo8BfsdWPtNDWQ3PjKyUgam8UCMp+W3ZtVUl1+KUUO2
         TugXG0IoxOZJdOGkOc8wVHX6sM7psuRGSmA+MFOCkGWuRGkgQk21QA1sh4fIz9fS0aTu
         9M1yT2vcSjIJhuF3tip4d3z2ABUnqVWsydKm/0dfA9OKLEqSZ0faDkt30/CdNyuF6zTh
         L2xFrZHbQmX+FNpDnF221zYvHChOblbKJIpxbSU2meIcUdsHNVXbRD8UdHC9jzOX4jdf
         MY7yWRBvQosmOab6iF16N/pcB2yVTq7mEIRniUzL/YSZF5CDsXthsvYYTjzbbr+zKDap
         O0ZQ==
X-Gm-Message-State: AJIora9OxLjNTVrGgA1pA4s2s1Lh2mzCU4RcAFR/y53snVBe+VyneCz4
        zBpVhLiYDIlxJ548vyJ0olvrK7i1ta/REA==
X-Google-Smtp-Source: AGRyM1sCdf80W88s5faAN0X1tyCcLeT1Xd2N+w+vMvSgiQT++kPpcJO+LPmWcsbFH7/u/Br0RtJbug==
X-Received: by 2002:a7b:ce08:0:b0:39c:8f58:2414 with SMTP id m8-20020a7bce08000000b0039c8f582414mr12531552wmc.74.1655511676247;
        Fri, 17 Jun 2022 17:21:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1-20020adff0c1000000b002103cfd2fbasm6066441wro.65.2022.06.17.17.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:15 -0700 (PDT)
Message-Id: <f523b08ab5af32d1074d016e5d122df688f5371d.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:54 +0000
Subject: [PATCH v7 11/17] merge-ort: store messages in a list, not in a single
 strbuf
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

To prepare for using the `merge-ort` machinery in server operations, we
cannot simply produce a free-form string that combines a variable-length
list of messages.

Instead, we need to list them one by one. The natural fit for this is a
`string_list`.

We will subsequently add even more information in the `util` attribute
of the string list items.

Based-on-a-patch-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 123 ++++++++++++++++++++++++++++++++++------------------
 merge-ort.h |   2 +-
 2 files changed, 81 insertions(+), 44 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 7e8b9cd6ea7..668aec64f13 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -349,13 +349,15 @@ struct merge_options_internal {
 	struct mem_pool pool;
 
 	/*
-	 * output: special messages and conflict notices for various paths
+	 * conflicts: logical conflicts and messages stored by _primary_ path
 	 *
 	 * This is a map of pathnames (a subset of the keys in "paths" above)
-	 * to strbufs.  It gathers various warning/conflict/notice messages
-	 * for later processing.
+	 * to struct string_list, with each item's `util` containing a
+	 * `struct logical_conflict_info`. Note, though, that for each path,
+	 * it only stores the logical conflicts for which that path is the
+	 * primary path; the path might be part of additional conflicts.
 	 */
-	struct strmap output;
+	struct strmap conflicts;
 
 	/*
 	 * renames: various data relating to rename detection
@@ -567,20 +569,20 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		struct strmap_entry *e;
 
 		/* Release and free each strbuf found in output */
-		strmap_for_each_entry(&opti->output, &iter, e) {
-			struct strbuf *sb = e->value;
-			strbuf_release(sb);
+		strmap_for_each_entry(&opti->conflicts, &iter, e) {
+			struct string_list *list = e->value;
 			/*
-			 * While strictly speaking we don't need to free(sb)
-			 * here because we could pass free_values=1 when
-			 * calling strmap_clear() on opti->output, that would
-			 * require strmap_clear to do another
-			 * strmap_for_each_entry() loop, so we just free it
-			 * while we're iterating anyway.
+			 * While strictly speaking we don't need to
+			 * free(conflicts) here because we could pass
+			 * free_values=1 when calling strmap_clear() on
+			 * opti->conflicts, that would require strmap_clear
+			 * to do another strmap_for_each_entry() loop, so we
+			 * just free it while we're iterating anyway.
 			 */
-			free(sb);
+			string_list_clear(list, 1);
+			free(list);
 		}
-		strmap_clear(&opti->output, 0);
+		strmap_clear(&opti->conflicts, 0);
 	}
 
 	mem_pool_discard(&opti->pool, 0);
@@ -634,7 +636,9 @@ static void path_msg(struct merge_options *opt,
 		     const char *fmt, ...)
 {
 	va_list ap;
-	struct strbuf *sb, *dest;
+	struct string_list *path_conflicts;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf *dest;
 	struct strbuf tmp = STRBUF_INIT;
 
 	if (opt->record_conflict_msgs_as_headers && omittable_hint)
@@ -642,14 +646,16 @@ static void path_msg(struct merge_options *opt,
 	if (opt->priv->call_depth && opt->verbosity < 5)
 		return; /* Ignore messages from inner merges */
 
-	sb = strmap_get(&opt->priv->output, path);
-	if (!sb) {
-		sb = xmalloc(sizeof(*sb));
-		strbuf_init(sb, 0);
-		strmap_put(&opt->priv->output, path, sb);
+	/* Ensure path_conflicts (ptr to array of logical_conflict) allocated */
+	path_conflicts = strmap_get(&opt->priv->conflicts, path);
+	if (!path_conflicts) {
+		path_conflicts = xmalloc(sizeof(*path_conflicts));
+		string_list_init_dup(path_conflicts);
+		strmap_put(&opt->priv->conflicts, path, path_conflicts);
 	}
 
-	dest = (opt->record_conflict_msgs_as_headers ? &tmp : sb);
+	/* Handle message and its format, in normal case */
+	dest = (opt->record_conflict_msgs_as_headers ? &tmp : &buf);
 
 	va_start(ap, fmt);
 	if (opt->priv->call_depth) {
@@ -660,32 +666,31 @@ static void path_msg(struct merge_options *opt,
 	strbuf_vaddf(dest, fmt, ap);
 	va_end(ap);
 
+	/* Handle specialized formatting of message under --remerge-diff */
 	if (opt->record_conflict_msgs_as_headers) {
 		int i_sb = 0, i_tmp = 0;
 
 		/* Start with the specified prefix */
 		if (opt->msg_header_prefix)
-			strbuf_addf(sb, "%s ", opt->msg_header_prefix);
+			strbuf_addf(&buf, "%s ", opt->msg_header_prefix);
 
 		/* Copy tmp to sb, adding spaces after newlines */
-		strbuf_grow(sb, sb->len + 2*tmp.len); /* more than sufficient */
+		strbuf_grow(&buf, buf.len + 2*tmp.len); /* more than sufficient */
 		for (; i_tmp < tmp.len; i_tmp++, i_sb++) {
 			/* Copy next character from tmp to sb */
-			sb->buf[sb->len + i_sb] = tmp.buf[i_tmp];
+			buf.buf[buf.len + i_sb] = tmp.buf[i_tmp];
 
 			/* If we copied a newline, add a space */
 			if (tmp.buf[i_tmp] == '\n')
-				sb->buf[++i_sb] = ' ';
+				buf.buf[++i_sb] = ' ';
 		}
 		/* Update length and ensure it's NUL-terminated */
-		sb->len += i_sb;
-		sb->buf[sb->len] = '\0';
+		buf.len += i_sb;
+		buf.buf[buf.len] = '\0';
 
 		strbuf_release(&tmp);
 	}
-
-	/* Add final newline character to sb */
-	strbuf_addch(sb, '\n');
+	string_list_append_nodup(path_conflicts, strbuf_detach(&buf, NULL));
 }
 
 static struct diff_filespec *pool_alloc_filespec(struct mem_pool *pool,
@@ -4256,7 +4261,6 @@ void merge_display_update_messages(struct merge_options *opt,
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 	struct string_list olist = STRING_LIST_INIT_NODUP;
-	int i;
 
 	if (opt->record_conflict_msgs_as_headers)
 		BUG("Either display conflict messages or record them as headers, not both");
@@ -4264,20 +4268,20 @@ void merge_display_update_messages(struct merge_options *opt,
 	trace2_region_enter("merge", "display messages", opt->repo);
 
 	/* Hack to pre-allocate olist to the desired size */
-	ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
+	ALLOC_GROW(olist.items, strmap_get_size(&opti->conflicts),
 		   olist.alloc);
 
 	/* Put every entry from output into olist, then sort */
-	strmap_for_each_entry(&opti->output, &iter, e) {
+	strmap_for_each_entry(&opti->conflicts, &iter, e) {
 		string_list_append(&olist, e->key)->util = e->value;
 	}
 	string_list_sort(&olist);
 
 	/* Iterate over the items, printing them */
-	for (i = 0; i < olist.nr; ++i) {
-		struct strbuf *sb = olist.items[i].util;
-
-		printf("%s", sb->buf);
+	for (int path_nr = 0; path_nr < olist.nr; ++path_nr) {
+		struct string_list *conflicts = olist.items[path_nr].util;
+		for (int i = 0; i < conflicts->nr; i++)
+			puts(conflicts->items[i].string);
 	}
 	string_list_clear(&olist, 0);
 
@@ -4366,6 +4370,8 @@ void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
 	struct merge_options_internal *opti = result->priv;
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
 
 	if (opt->renormalize)
 		git_attr_set_direction(GIT_ATTR_CHECKIN);
@@ -4373,6 +4379,15 @@ void merge_finalize(struct merge_options *opt,
 
 	clear_or_reinit_internal_opts(opti, 0);
 	FREE_AND_NULL(opti);
+
+	/* Release and free each strbuf found in path_messages */
+	strmap_for_each_entry(result->path_messages, &iter, e) {
+		struct strbuf *buf = e->value;
+
+		strbuf_release(buf);
+	}
+	strmap_clear(result->path_messages, 1);
+	FREE_AND_NULL(result->path_messages);
 }
 
 /*** Function Grouping: helper functions for merge_incore_*() ***/
@@ -4531,11 +4546,11 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	strmap_init_with_options(&opt->priv->conflicted, pool, 0);
 
 	/*
-	 * keys & strbufs in output will sometimes need to outlive "paths",
-	 * so it will have a copy of relevant keys.  It's probably a small
-	 * subset of the overall paths that have special output.
+	 * keys & string_lists in conflicts will sometimes need to outlive
+	 * "paths", so it will have a copy of relevant keys.  It's probably
+	 * a small subset of the overall paths that have special output.
 	 */
-	strmap_init(&opt->priv->output);
+	strmap_init(&opt->priv->conflicts);
 
 	trace2_region_leave("merge", "allocate/init", opt->repo);
 }
@@ -4596,6 +4611,8 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 					    struct merge_result *result)
 {
 	struct object_id working_tree_oid;
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
 
 	if (opt->subtree_shift) {
 		side2 = shift_tree_object(opt->repo, side1, side2,
@@ -4636,7 +4653,27 @@ redo:
 	trace2_region_leave("merge", "process_entries", opt->repo);
 
 	/* Set return values */
-	result->path_messages = &opt->priv->output;
+	result->path_messages = xcalloc(1, sizeof(*result->path_messages));
+	strmap_init_with_options(result->path_messages, NULL, 0);
+	strmap_for_each_entry(&opt->priv->conflicts, &iter, e) {
+		const char *path = e->key;
+		struct strbuf *buf = strmap_get(result->path_messages, path);
+		struct string_list *conflicts = e->value;
+
+		if (!buf) {
+			buf = xcalloc(1, sizeof(*buf));
+			strbuf_init(buf, 0);
+			strmap_put(result->path_messages, path, buf);
+		}
+
+		for (int i = 0; i < conflicts->nr; i++) {
+			if (buf->len)
+				strbuf_addch(buf, '\n');
+			strbuf_addstr(buf, conflicts->items[i].string);
+			strbuf_trim_trailing_newline(buf);
+		}
+	}
+
 	result->tree = parse_tree_indirect(&working_tree_oid);
 	/* existence of conflicted entries implies unclean */
 	result->clean &= strmap_empty(&opt->priv->conflicted);
diff --git a/merge-ort.h b/merge-ort.h
index ddcc39d7270..f9c536ed8c4 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -28,7 +28,7 @@ struct merge_result {
 	/*
 	 * Special messages and conflict notices for various paths
 	 *
-	 * This is a map of pathnames to strbufs.  It contains various
+	 * This is a map of pathnames to strbufs. It contains various
 	 * warning/conflict/notice messages (possibly multiple per path)
 	 * that callers may want to use.
 	 */
-- 
gitgitgadget

