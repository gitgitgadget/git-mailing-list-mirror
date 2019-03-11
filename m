Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF1020248
	for <e@80x24.org>; Mon, 11 Mar 2019 22:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfCKWQh (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 18:16:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38896 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfCKWQh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 18:16:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id a188so653691wmf.3
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3KLliQC259p5QZwJZVS5hF8v2ZxD0crP7HEJo+TS8Qk=;
        b=qG9Zt+V6cXUi2VOpVqwYwtPFWjvwjDn+y5N7YcwRwdm2UvuyFItJJdUOVchnauZXl7
         JjIAHt/bkpP+0svbqvbdnAYX4GWOjh/NqyKF4oE/xWWsV+Yj4KrsIBt/jAirYC0CNwvO
         NtrNC+5x3qdFsuMwIPp3dUi9+t5eeIbNCcdh1LRLJzPuJzrIpybA7ksrW3XStEBNnzLO
         D55xczXO3QaIdCDo1clUmUieUzfNxYJRear3vbPN3DHPsBXeeTckA0iUv+ZR2d2Izknv
         qF5HLZoRPoR0X6KlTvIsPn4e7VhVmEq1w6ci9PA+vsXglFpJWrJmXRigfHqBbNoqMd9q
         s7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3KLliQC259p5QZwJZVS5hF8v2ZxD0crP7HEJo+TS8Qk=;
        b=WdbfZyk/GDUVzCAYEXcwqrBdM6fUI952wL5PowotelMlDi2b/EcqEJSTVTs/BD+8WL
         8bOa7NUGTJpwXRtWCLBVA7hLPJ1cTbZQow055EdQn3Lnz/5V2E8CyaUmQtJ3JkE6iW7Q
         Lw9MX2VRnUmCcmsGeH7DjjrfLv1Z6/KfNBk+Hb1rJLCcqhqw2I68tmYZB2sdz1gHDkGQ
         8050fkZlJ3NLFeL3TqNsbE7Jph2swv6Og+OSp5WTtlkChZ7vQ3dmMlqmLLxJENraMnWr
         /XIDeO6tqYOxAaCGKXiz7ostS+J7PtVUj6X25J23M4gRRnYULyCq2QqlX9nr5VUSKQdl
         tShw==
X-Gm-Message-State: APjAAAWGz1cDzIdT6aO8QlLrlzHNSXYW7PxM0plwlKxQV02uHmnfeM5C
        LJQPjcnQvC7hy4eB7m/bwOE=
X-Google-Smtp-Source: APXvYqxoIwJayFCKvBgFf4EZ4ztJEvy1UYnAdvmQiAjQwt/kB7e3uTSnP9/hAyvP80FBT7AwCerhLQ==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr242041wme.93.1552342594442;
        Mon, 11 Mar 2019 15:16:34 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id g15sm849104wmg.16.2019.03.11.15.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:16:33 -0700 (PDT)
Date:   Mon, 11 Mar 2019 22:16:32 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: [PATCH v2] stash: pass pathspec as pointer
Message-ID: <20190311221624.GC16414@hank.intra.tgummerer.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
 <20190225231631.30507-19-t.gummerer@gmail.com>
 <20190307191836.GB29221@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
 <20190309182610.GD31533@hank.intra.tgummerer.com>
 <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com>
 <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com>
 <20190311214244.GB16414@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311214244.GB16414@hank.intra.tgummerer.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Passing the pathspec by value is potentially confusing, as the copy is
only a shallow copy, so save the overhead of the copy, and pass the
pathspec struct as a pointer.

In addition use copy_pathspec to copy the pathspec into
rev.prune_data, so the copy is a proper deep copy, and owned by the
revision API, as that's what the API expects.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

> Good catch on both acconts.  I'll send a new patch soon, adding the
> clear_pathspec() calls and rebasing it on top of Dscho's fix.

Here it is.  Thanks for the review of the first round Junio!

This is on top of Dscho's series at
<pull.159.git.gitgitgadget@gmail.com> applied to ps/stash-in-c.

 builtin/stash.c | 68 +++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 2f29d037c8..e0528d4cc8 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -826,11 +826,11 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 }
 
 static void add_pathspecs(struct argv_array *args,
-			  struct pathspec ps) {
+			  const struct pathspec *ps) {
 	int i;
 
-	for (i = 0; i < ps.nr; i++)
-		argv_array_push(args, ps.items[i].original);
+	for (i = 0; i < ps->nr; i++)
+		argv_array_push(args, ps->items[i].original);
 }
 
 /*
@@ -840,7 +840,7 @@ static void add_pathspecs(struct argv_array *args,
  * = 0 if there are not any untracked files
  * > 0 if there are untracked files
  */
-static int get_untracked_files(struct pathspec ps, int include_untracked,
+static int get_untracked_files(const struct pathspec *ps, int include_untracked,
 			       struct strbuf *untracked_files)
 {
 	int i;
@@ -853,12 +853,12 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
 	if (include_untracked != INCLUDE_ALL_FILES)
 		setup_standard_excludes(&dir);
 
-	seen = xcalloc(ps.nr, 1);
+	seen = xcalloc(ps->nr, 1);
 
-	max_len = fill_directory(&dir, the_repository->index, &ps);
+	max_len = fill_directory(&dir, the_repository->index, ps);
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (dir_path_match(&the_index, ent, &ps, max_len, seen)) {
+		if (dir_path_match(&the_index, ent, ps, max_len, seen)) {
 			found++;
 			strbuf_addstr(untracked_files, ent->name);
 			/* NUL-terminate: will be fed to update-index -z */
@@ -881,11 +881,12 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
  * = 0 if there are no changes.
  * > 0 if there are changes.
  */
-static int check_changes_tracked_files(struct pathspec ps)
+static int check_changes_tracked_files(const struct pathspec *ps)
 {
 	int result;
 	struct rev_info rev;
 	struct object_id dummy;
+	int ret = 0;
 
 	/* No initial commit. */
 	if (get_oid("HEAD", &dummy))
@@ -895,7 +896,7 @@ static int check_changes_tracked_files(struct pathspec ps)
 		return -1;
 
 	init_revisions(&rev, NULL);
-	rev.prune_data = ps;
+	copy_pathspec(&rev.prune_data, ps);
 
 	rev.diffopt.flags.quick = 1;
 	rev.diffopt.flags.ignore_submodules = 1;
@@ -905,22 +906,28 @@ static int check_changes_tracked_files(struct pathspec ps)
 	diff_setup_done(&rev.diffopt);
 
 	result = run_diff_index(&rev, 1);
-	if (diff_result_code(&rev.diffopt, result))
-		return 1;
+	if (diff_result_code(&rev.diffopt, result)) {
+		ret = 1;
+		goto done;
+	}
 
 	object_array_clear(&rev.pending);
 	result = run_diff_files(&rev, 0);
-	if (diff_result_code(&rev.diffopt, result))
-		return 1;
+	if (diff_result_code(&rev.diffopt, result)) {
+		ret = 1;
+		goto done;
+	}
 
-	return 0;
+done:
+	clear_pathspec(&rev.prune_data);
+	return ret;
 }
 
 /*
  * The function will fill `untracked_files` with the names of untracked files
  * It will return 1 if there were any changes and 0 if there were not.
  */
-static int check_changes(struct pathspec ps, int include_untracked,
+static int check_changes(const struct pathspec *ps, int include_untracked,
 			 struct strbuf *untracked_files)
 {
 	int ret = 0;
@@ -974,7 +981,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	return ret;
 }
 
-static int stash_patch(struct stash_info *info, struct pathspec ps,
+static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		       struct strbuf *out_patch, int quiet)
 {
 	int ret = 0;
@@ -1033,7 +1040,7 @@ static int stash_patch(struct stash_info *info, struct pathspec ps,
 	return ret;
 }
 
-static int stash_working_tree(struct stash_info *info, struct pathspec ps)
+static int stash_working_tree(struct stash_info *info, const struct pathspec *ps)
 {
 	int ret = 0;
 	struct rev_info rev;
@@ -1042,6 +1049,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	struct index_state istate = { NULL };
 
 	init_revisions(&rev, NULL);
+	copy_pathspec(&rev.prune_data, ps);
 
 	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
@@ -1050,7 +1058,6 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	}
 	set_alternate_index_output(NULL);
 
-	rev.prune_data = ps;
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = add_diff_to_buf;
 	rev.diffopt.format_callback_data = &diff_output;
@@ -1089,12 +1096,13 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	discard_index(&istate);
 	UNLEAK(rev);
 	object_array_clear(&rev.pending);
+	clear_pathspec(&rev.prune_data);
 	strbuf_release(&diff_output);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
 
-static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
+static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_buf,
 			   int include_untracked, int patch_mode,
 			   struct stash_info *info, struct strbuf *patch,
 			   int quiet)
@@ -1226,10 +1234,10 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	if (!check_changes_tracked_files(ps))
+	if (!check_changes_tracked_files(&ps))
 		return 0;
 
-	ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info,
+	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, &info,
 			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1238,7 +1246,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
+static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
 			 int keep_index, int patch_mode, int include_untracked)
 {
 	int ret = 0;
@@ -1258,15 +1266,15 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 	}
 
 	read_cache_preload(NULL);
-	if (!include_untracked && ps.nr) {
+	if (!include_untracked && ps->nr) {
 		int i;
-		char *ps_matched = xcalloc(ps.nr, 1);
+		char *ps_matched = xcalloc(ps->nr, 1);
 
 		for (i = 0; i < active_nr; i++)
-			ce_path_match(&the_index, active_cache[i], &ps,
+			ce_path_match(&the_index, active_cache[i], ps,
 				      ps_matched);
 
-		if (report_path_error(ps_matched, &ps, NULL)) {
+		if (report_path_error(ps_matched, ps, NULL)) {
 			fprintf_ln(stderr, _("Did you forget to 'git add'?"));
 			ret = -1;
 			free(ps_matched);
@@ -1313,7 +1321,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 			  stash_msg_buf.buf);
 
 	if (!patch_mode) {
-		if (include_untracked && !ps.nr) {
+		if (include_untracked && !ps->nr) {
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
@@ -1327,7 +1335,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 			}
 		}
 		discard_cache();
-		if (ps.nr) {
+		if (ps->nr) {
 			struct child_process cp_add = CHILD_PROCESS_INIT;
 			struct child_process cp_diff = CHILD_PROCESS_INIT;
 			struct child_process cp_apply = CHILD_PROCESS_INIT;
@@ -1468,7 +1476,7 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
-	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
+	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
 			     include_untracked);
 }
 
@@ -1505,7 +1513,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 		stash_msg = strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_push_stash(ps, stash_msg, quiet, keep_index,
+	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
 			    patch_mode, include_untracked);
 
 	strbuf_release(&stash_msg_buf);
-- 
2.21.0.474.g541d9dca55
