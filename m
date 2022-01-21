Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7069DC433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 19:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiAUTMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 14:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiAUTMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 14:12:31 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32ADC06173D
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso15443045wmh.4
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 11:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2NmfFQRBnIwE//dIuq0V8oIvdy2aUwh7Fz41UnhXWvA=;
        b=HkHOAZkISTkU3Ij8RtW6zt9e7w22II7T85DSCzEyawRs1sTxQiArYgCjYGdx2RWW41
         KkcetNL36feGmgvTGdHWHQMTuWsV1d4YRaILqCIo7/VZduBpPA95RZODvScVmK7nlhYx
         twlPDoxPMQAdI+BtgbdQN5Op3eJpVx1X3BkKdHGSGd5HMN6IZ/Jp2wolHch+5OrvRxf1
         pde7M60xrQH8/PsGnBAxYbXh/erKWcagLXlgof0bxVqO0B+etxn37Bn7eNOaVxJwf8Aj
         6zukOeyvMr4CCIyiZSGX/6pTb6s+NzKaqOLc02zaanEAO+VFujJph435gwSzQDbOk2EH
         t3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2NmfFQRBnIwE//dIuq0V8oIvdy2aUwh7Fz41UnhXWvA=;
        b=FRye7+qHwcEftRZStDT+/O0gmhw4nY+DBeIsbV1yqp0oC2TCOFL827fTS2IhO0HoQ9
         ONqNjX3aD+lr3fe5j3oh0NxINLUkF7Equroy8J3z/0ZE03IkUBPOekueKsfREyrnMKD1
         AoSeglE2/KRMaIczAWNlVu2++7VgpanmhGf0VfJbs8gBMxU94gzNh4lglVU5d0MOFGhY
         Mx3iVdH0MGwXwqtOOxq8k/8/4ebxDCuUjE8U1IPXXYCQu3t1AiNlHzpW0sUHZ7jWeG7m
         m4hoHBQBGcWs5F1P7lG13YB9VHGPGzdUL6bcSA0MHP2zSIPRyjR62fwF2sPvF2gmTpau
         hSbA==
X-Gm-Message-State: AOAM532LRH6/SFFCwuMaSMJU0hjvuHIbg8xBL2TIWr6nkLfdIB49gSZR
        IdthbqVUl7gVcAiI+NxtPTzHDd6ZhrY=
X-Google-Smtp-Source: ABdhPJzB/U7faHwAi7FXg27rP6N0zKImi1n2lAPmlVF8oJtMdmkJBlq9eYfiR24Qtl8wJ6g7Sr/ClQ==
X-Received: by 2002:a05:600c:1987:: with SMTP id t7mr1948919wmq.124.1642792349052;
        Fri, 21 Jan 2022 11:12:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm6929858wri.101.2022.01.21.11.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:12:28 -0800 (PST)
Message-Id: <62734beb693a6a6256106f0ffad9519a76c9d6d8.1642792341.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
        <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 19:12:17 +0000
Subject: [PATCH v4 07/10] diff: add ability to insert additional headers for
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When additional headers are provided, we need to
  * add diff_filepairs to diff_queued_diff for each paths in the
    additional headers map which, unless that path is part of
    another diff_filepair already found in diff_queued_diff
  * format the headers (colorization, line_prefix for --graph)
  * make sure the various codepaths that attempt to return early
    if there are "no changes" take into account the headers that
    need to be shown.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 diff.h     |   3 +-
 log-tree.c |   2 +-
 3 files changed, 123 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 861282db1c3..1bfb01c18ec 100644
--- a/diff.c
+++ b/diff.c
@@ -27,6 +27,7 @@
 #include "help.h"
 #include "promisor-remote.h"
 #include "dir.h"
+#include "strmap.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -3406,6 +3407,31 @@ struct userdiff_driver *get_textconv(struct repository *r,
 	return userdiff_get_textconv(r, one->driver);
 }
 
+static struct strbuf *additional_headers(struct diff_options *o,
+					 const char *path)
+{
+	if (!o->additional_path_headers)
+		return NULL;
+	return strmap_get(o->additional_path_headers, path);
+}
+
+static void add_formatted_headers(struct strbuf *msg,
+				  struct strbuf *more_headers,
+				  const char *line_prefix,
+				  const char *meta,
+				  const char *reset)
+{
+	char *next, *newline;
+
+	for (next = more_headers->buf; *next; next = newline) {
+		newline = strchrnul(next, '\n');
+		strbuf_addf(msg, "%s%s%.*s%s\n", line_prefix, meta,
+			    (int)(newline - next), next, reset);
+		if (*newline)
+			newline++;
+	}
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -3464,6 +3490,17 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
+	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
+		/*
+		 * We should only reach this point for pairs from
+		 * create_filepairs_for_header_only_notifications().  For
+		 * these, we should avoid the "/dev/null" special casing
+		 * above, meaning we avoid showing such pairs as either
+		 * "new file" or "deleted file" below.
+		 */
+		lbl[0] = a_one;
+		lbl[1] = b_two;
+	}
 	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
@@ -4328,6 +4365,7 @@ static void fill_metainfo(struct strbuf *msg,
 	const char *set = diff_get_color(use_color, DIFF_METAINFO);
 	const char *reset = diff_get_color(use_color, DIFF_RESET);
 	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf *more_headers = NULL;
 
 	*must_show_header = 1;
 	strbuf_init(msg, PATH_MAX * 2 + 300);
@@ -4364,6 +4402,11 @@ static void fill_metainfo(struct strbuf *msg,
 	default:
 		*must_show_header = 0;
 	}
+	if ((more_headers = additional_headers(o, name))) {
+		add_formatted_headers(msg, more_headers,
+				      line_prefix, set, reset);
+		*must_show_header = 1;
+	}
 	if (one && two && !oideq(&one->oid, &two->oid)) {
 		const unsigned hexsz = the_hash_algo->hexsz;
 		int abbrev = o->abbrev ? o->abbrev : DEFAULT_ABBREV;
@@ -5852,12 +5895,27 @@ int diff_unmodified_pair(struct diff_filepair *p)
 
 static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 {
-	if (diff_unmodified_pair(p))
+	int include_conflict_headers =
+	    (additional_headers(o, p->one->path) &&
+	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
+
+	/*
+	 * Check if we can return early without showing a diff.  Note that
+	 * diff_filepair only stores {oid, path, mode, is_valid}
+	 * information for each path, and thus diff_unmodified_pair() only
+	 * considers those bits of info.  However, we do not want pairs
+	 * created by create_filepairs_for_header_only_notifications()
+	 * (which always look like unmodified pairs) to be ignored, so
+	 * return early if both p is unmodified AND we don't want to
+	 * include_conflict_headers.
+	 */
+	if (diff_unmodified_pair(p) && !include_conflict_headers)
 		return;
 
+	/* Actually, we can also return early to avoid showing tree diffs */
 	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
-		return; /* no tree diffs in patch format */
+		return;
 
 	run_diff(p, o);
 }
@@ -5888,10 +5946,17 @@ static void diff_flush_checkdiff(struct diff_filepair *p,
 	run_checkdiff(p, o);
 }
 
-int diff_queue_is_empty(void)
+int diff_queue_is_empty(struct diff_options *o)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
+	int include_conflict_headers =
+	    (o->additional_path_headers &&
+	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
+
+	if (include_conflict_headers)
+		return 0;
+
 	for (i = 0; i < q->nr; i++)
 		if (!diff_unmodified_pair(q->queue[i]))
 			return 0;
@@ -6325,6 +6390,54 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(_(rename_limit_advice), varname, needed);
 }
 
+static void create_filepairs_for_header_only_notifications(struct diff_options *o)
+{
+	struct strset present;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	int i;
+
+	strset_init_with_options(&present, /*pool*/ NULL, /*strdup*/ 0);
+
+	/*
+	 * Find out which paths exist in diff_queued_diff, preferring
+	 * one->path for any pair that has multiple paths.
+	 */
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		char *path = p->one->path ? p->one->path : p->two->path;
+
+		if (strmap_contains(o->additional_path_headers, path))
+			strset_add(&present, path);
+	}
+
+	/*
+	 * Loop over paths in additional_path_headers; for each NOT already
+	 * in diff_queued_diff, create a synthetic filepair and insert that
+	 * into diff_queued_diff.
+	 */
+	strmap_for_each_entry(o->additional_path_headers, &iter, e) {
+		if (!strset_contains(&present, e->key)) {
+			struct diff_filespec *one, *two;
+			struct diff_filepair *p;
+
+			one = alloc_filespec(e->key);
+			two = alloc_filespec(e->key);
+			fill_filespec(one, null_oid(), 0, 0);
+			fill_filespec(two, null_oid(), 0, 0);
+			p = diff_queue(q, one, two);
+			p->status = DIFF_STATUS_MODIFIED;
+		}
+	}
+
+	/* Re-sort the filepairs */
+	diffcore_fix_diff_index();
+
+	/* Cleanup */
+	strset_clear(&present);
+}
+
 static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
@@ -6337,6 +6450,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	if (o->color_moved)
 		o->emitted_symbols = &esm;
 
+	if (o->additional_path_headers)
+		create_filepairs_for_header_only_notifications(o);
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
@@ -6413,7 +6529,7 @@ void diff_flush(struct diff_options *options)
 	 * Order: raw, stat, summary, patch
 	 * or:    name/name-status/checkdiff (other bits clear)
 	 */
-	if (!q->nr)
+	if (!q->nr && !options->additional_path_headers)
 		goto free_queue;
 
 	if (output_format & (DIFF_FORMAT_RAW |
diff --git a/diff.h b/diff.h
index 8ba85c5e605..ce9e2cf2e4f 100644
--- a/diff.h
+++ b/diff.h
@@ -395,6 +395,7 @@ struct diff_options {
 
 	struct repository *repo;
 	struct option *parseopts;
+	struct strmap *additional_path_headers;
 
 	int no_free;
 };
@@ -593,7 +594,7 @@ void diffcore_fix_diff_index(void);
 "                show all files diff when -S is used and hit is found.\n" \
 "  -a  --text    treat all files as text.\n"
 
-int diff_queue_is_empty(void);
+int diff_queue_is_empty(struct diff_options *o);
 void diff_flush(struct diff_options*);
 void diff_free(struct diff_options*);
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
diff --git a/log-tree.c b/log-tree.c
index d4655b63d75..33c28f537a6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -850,7 +850,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 	opt->shown_dashes = 0;
 	diffcore_std(&opt->diffopt);
 
-	if (diff_queue_is_empty()) {
+	if (diff_queue_is_empty(&opt->diffopt)) {
 		int saved_fmt = opt->diffopt.output_format;
 		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
 		diff_flush(&opt->diffopt);
-- 
gitgitgadget

