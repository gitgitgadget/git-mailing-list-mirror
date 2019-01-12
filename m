Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDDB1211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 02:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfALCOq (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 21:14:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45602 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALCOq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 21:14:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so7758838pfd.12
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 18:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRC4aEedm+YhBUFOr6a8IvUCtNqhUrwo63KaN/4AaI8=;
        b=ppyKmx2QAiniF3DV/VhNJ6loDINfS6nwuPZ6BOvuGVOwq0LjFDISdsuxOSM2eugQsq
         BygBzOeChC+x34mzfqRpBWLHrMbizgjHEceM+47gE0rTRj7Wh3RW9HiEyNpizQ7Ambly
         DIJczuvP1P3L7nIwobABudfXTydaBW1F/b/A633Y3FFvcVYoGm8k+zBN9MkFmMlC9JJS
         wT1g8B5EpRN10D5jPU+iSWvkfu8kCf8iR2v62MqRujpqUiab2XBqyRmvFG/S2xRqeHEV
         z6aM3ftZ0p4XtAmzya9L1GTcN0n5kBccgLsssrM2lnpyLCx5Q9RCXSaFOMreUmaBQ0mG
         kDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRC4aEedm+YhBUFOr6a8IvUCtNqhUrwo63KaN/4AaI8=;
        b=pLF9RZimuMvjMn/C8x/5vhsmQlxeBNuJxTiKL/HiFt6p8y5vfk27v+Hhv3KWDg0ePj
         c9mS5+g2BNGc8C59PMQnM8OmR57fGDigZc6bmV7XOMeKXejb9aP2Em4zY0PCpHHk44Rc
         YDHAQhqOtt+8x/v8LGefPvVRA7/Z4ulRaGtgE0oXV/k/j/AMk03fs3xk5TZoTssdcASx
         Dn8TnT94xUWnokG9OAaT5dQEM3u4Col1kWTVt6PWAoFO9xU/h9vlydIgl2BL0Sf77XPq
         pIGhxyzQq8CdRRf6EC3JhnpqpBXkNMdIA4GVUwEwhzGSXVg4JlBuR/p5Wjh7m6BsnNMJ
         3EgQ==
X-Gm-Message-State: AJcUukcssUNC7oe7zTKiVcK2Bc1XqN45K3+1Jp1UxbpUGZj0kzIpamJ+
        1+dzPizlwPDUjF6BasbEBuj6pOcq
X-Google-Smtp-Source: ALg8bN5V1xev8vVcykqMDveyXYZ7tuizghfh62UXGbUnnF600nt1m3zEqfHAhKYIqqluT2PrAv31Pw==
X-Received: by 2002:a62:1e87:: with SMTP id e129mr16712808pfe.221.1547259284764;
        Fri, 11 Jan 2019 18:14:44 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id e123sm97434630pgc.58.2019.01.11.18.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 18:14:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Jan 2019 09:14:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/11] merge-recursive.c: remove implicit dependency on the_index
Date:   Sat, 12 Jan 2019 09:13:29 +0700
Message-Id: <20190112021332.11066-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190112021332.11066-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
 <20190112021332.11066-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c              |   2 +-
 builtin/checkout.c        |   2 +-
 builtin/merge-recursive.c |   2 +-
 builtin/merge.c           |   2 +-
 merge-recursive.c         | 148 ++++++++++++++++++++------------------
 merge-recursive.h         |   6 +-
 sequencer.c               |   4 +-
 7 files changed, 91 insertions(+), 75 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 901dc55078..611712dc95 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1545,7 +1545,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	 * changes.
 	 */
 
-	init_merge_options(&o);
+	init_merge_options(&o, the_repository);
 
 	o.branch1 = "HEAD";
 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1b672a9fd9..a95ba2c6dc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -670,7 +670,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * a pain; plumb in an option to set
 			 * o.renormalize?
 			 */
-			init_merge_options(&o);
+			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 9b2f707c29..4864f7b22f 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -28,7 +28,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	struct merge_options o;
 	struct commit *result;
 
-	init_merge_options(&o);
+	init_merge_options(&o, the_repository);
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
diff --git a/builtin/merge.c b/builtin/merge.c
index dc0b7cc521..bc1aecfe70 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -702,7 +702,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			return 2;
 		}
 
-		init_merge_options(&o);
+		init_merge_options(&o, the_repository);
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 5fbd4253c1..28f44c73ec 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -343,22 +343,24 @@ static int add_cacheinfo(struct merge_options *o,
 			 unsigned int mode, const struct object_id *oid,
 			 const char *path, int stage, int refresh, int options)
 {
+	struct index_state *istate = o->repo->index;
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_cache_entry(&the_index, mode, oid ? oid : &null_oid, path, stage, 0);
+	ce = make_cache_entry(istate, mode, oid ? oid : &null_oid, path, stage, 0);
 	if (!ce)
 		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
-	ret = add_cache_entry(ce, options);
+	ret = add_index_entry(istate, ce, options);
 	if (refresh) {
 		struct cache_entry *nce;
 
-		nce = refresh_cache_entry(&the_index, ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
+		nce = refresh_cache_entry(istate, ce,
+					  CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
 		if (!nce)
 			return err(o, _("add_cacheinfo failed to refresh for path '%s'; merge aborting."), path);
 		if (nce != ce)
-			ret = add_cache_entry(nce, options);
+			ret = add_index_entry(istate, nce, options);
 	}
 	return ret;
 }
@@ -386,7 +388,7 @@ static int unpack_trees_start(struct merge_options *o,
 	o->unpack_opts.merge = 1;
 	o->unpack_opts.head_idx = 2;
 	o->unpack_opts.fn = threeway_merge;
-	o->unpack_opts.src_index = &the_index;
+	o->unpack_opts.src_index = o->repo->index;
 	o->unpack_opts.dst_index = &tmp_index;
 	o->unpack_opts.aggressive = !merge_detect_rename(o);
 	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
@@ -396,16 +398,16 @@ static int unpack_trees_start(struct merge_options *o,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &o->unpack_opts);
-	cache_tree_free(&active_cache_tree);
+	cache_tree_free(&o->repo->index->cache_tree);
 
 	/*
-	 * Update the_index to match the new results, AFTER saving a copy
+	 * Update o->repo->index to match the new results, AFTER saving a copy
 	 * in o->orig_index.  Update src_index to point to the saved copy.
 	 * (verify_uptodate() checks src_index, and the original index is
 	 * the one that had the necessary modification timestamps.)
 	 */
-	o->orig_index = the_index;
-	the_index = tmp_index;
+	o->orig_index = *o->repo->index;
+	*o->repo->index = tmp_index;
 	o->unpack_opts.src_index = &o->orig_index;
 
 	return rc;
@@ -420,12 +422,13 @@ static void unpack_trees_finish(struct merge_options *o)
 struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
+	struct index_state *istate = o->repo->index;
 
-	if (unmerged_cache()) {
+	if (unmerged_index(istate)) {
 		int i;
 		fprintf(stderr, "BUG: There are unmerged index entries:\n");
-		for (i = 0; i < active_nr; i++) {
-			const struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < istate->cache_nr; i++) {
+			const struct cache_entry *ce = istate->cache[i];
 			if (ce_stage(ce))
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
@@ -433,16 +436,16 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		BUG("unmerged index entries in merge-recursive.c");
 	}
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!istate->cache_tree)
+		istate->cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(active_cache_tree) &&
-	    cache_tree_update(&the_index, 0) < 0) {
+	if (!cache_tree_fully_valid(istate->cache_tree) &&
+	    cache_tree_update(istate, 0) < 0) {
 		err(o, _("error building trees"));
 		return NULL;
 	}
 
-	result = lookup_tree(the_repository, &active_cache_tree->oid);
+	result = lookup_tree(the_repository, &istate->cache_tree->oid);
 
 	return result;
 }
@@ -512,17 +515,17 @@ static struct stage_data *insert_stage_data(const char *path,
  * Create a dictionary mapping file names to stage_data objects. The
  * dictionary contains one entry for every path with a non-zero stage entry.
  */
-static struct string_list *get_unmerged(void)
+static struct string_list *get_unmerged(struct index_state *istate)
 {
 	struct string_list *unmerged = xcalloc(1, sizeof(struct string_list));
 	int i;
 
 	unmerged->strdup_strings = 1;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
 
@@ -682,7 +685,7 @@ static int update_stages(struct merge_options *opt, const char *path,
 	int clear = 1;
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
 	if (clear)
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(opt->repo->index, path))
 			return -1;
 	if (o)
 		if (add_cacheinfo(opt, o->mode, &o->oid, path, 1, 0, options))
@@ -717,13 +720,14 @@ static int remove_file(struct merge_options *o, int clean,
 	int update_working_directory = !o->call_depth && !no_wd;
 
 	if (update_cache) {
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(o->repo->index, path))
 			return -1;
 	}
 	if (update_working_directory) {
 		if (ignore_case) {
 			struct cache_entry *ce;
-			ce = cache_file_exists(path, strlen(path), ignore_case);
+			ce = index_file_exists(o->repo->index, path, strlen(path),
+					       ignore_case);
 			if (ce && ce_stage(ce) == 0 && strcmp(path, ce->name))
 				return 0;
 		}
@@ -773,7 +777,8 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
  * check the working directory.  If empty_ok is non-zero, also return
  * 0 in the case where the working-tree dir exists but is empty.
  */
-static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
+static int dir_in_way(struct index_state *istate, const char *path,
+		      int check_working_copy, int empty_ok)
 {
 	int pos;
 	struct strbuf dirpath = STRBUF_INIT;
@@ -782,12 +787,12 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 	strbuf_addstr(&dirpath, path);
 	strbuf_addch(&dirpath, '/');
 
-	pos = cache_name_pos(dirpath.buf, dirpath.len);
+	pos = index_name_pos(istate, dirpath.buf, dirpath.len);
 
 	if (pos < 0)
 		pos = -1 - pos;
-	if (pos < active_nr &&
-	    !strncmp(dirpath.buf, active_cache[pos]->name, dirpath.len)) {
+	if (pos < istate->cache_nr &&
+	    !strncmp(dirpath.buf, istate->cache[pos]->name, dirpath.len)) {
 		strbuf_release(&dirpath);
 		return 1;
 	}
@@ -830,8 +835,10 @@ static int was_tracked(struct merge_options *o, const char *path)
 	return 0;
 }
 
-static int would_lose_untracked(const char *path)
+static int would_lose_untracked(struct merge_options *o, const char *path)
 {
+	struct index_state *istate = o->repo->index;
+
 	/*
 	 * This may look like it can be simplified to:
 	 *   return !was_tracked(o, path) && file_exists(path)
@@ -849,19 +856,19 @@ static int would_lose_untracked(const char *path)
 	 * update_file()/would_lose_untracked(); see every comment in this
 	 * file which mentions "update_stages".
 	 */
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(istate, path, strlen(path));
 
 	if (pos < 0)
 		pos = -1 - pos;
-	while (pos < active_nr &&
-	       !strcmp(path, active_cache[pos]->name)) {
+	while (pos < istate->cache_nr &&
+	       !strcmp(path, istate->cache[pos]->name)) {
 		/*
 		 * If stage #0, it is definitely tracked.
 		 * If it has stage #2 then it was tracked
 		 * before this merge started.  All other
 		 * cases the path was not tracked.
 		 */
-		switch (ce_stage(active_cache[pos])) {
+		switch (ce_stage(istate->cache[pos])) {
 		case 0:
 		case 2:
 			return 0;
@@ -921,7 +928,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	 * Do not unlink a file in the work tree if we are not
 	 * tracking it.
 	 */
-	if (would_lose_untracked(path))
+	if (would_lose_untracked(o, path))
 		return err(o, _("refusing to lose untracked file at '%s'"),
 			   path);
 
@@ -971,7 +978,7 @@ static int update_file_flags(struct merge_options *o,
 		}
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
-			if (convert_to_working_tree(&the_index, path, buf, size, &strbuf)) {
+			if (convert_to_working_tree(o->repo->index, path, buf, size, &strbuf)) {
 				free(buf);
 				size = strbuf.len;
 				buf = strbuf_detach(&strbuf, NULL);
@@ -1091,7 +1098,7 @@ static int merge_3way(struct merge_options *o,
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2,
-				&the_index, &ll_opts);
+				o->repo->index, &ll_opts);
 
 	free(base_name);
 	free(name1);
@@ -1102,7 +1109,8 @@ static int merge_3way(struct merge_options *o,
 	return merge_status;
 }
 
-static int find_first_merges(struct object_array *result, const char *path,
+static int find_first_merges(struct repository *repo,
+			     struct object_array *result, const char *path,
 			     struct commit *a, struct commit *b)
 {
 	int i, j;
@@ -1122,7 +1130,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	/* get all revisions that merge commit a */
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 		  oid_to_hex(&a->object.oid));
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(repo, &revs, NULL);
 	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
 	revs.single_worktree = path != NULL;
@@ -1252,7 +1260,8 @@ static int merge_submodule(struct merge_options *o,
 		return 0;
 
 	/* find commit which merges them */
-	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
+	parent_count = find_first_merges(o->repo, &merges, path,
+					 commit_a, commit_b);
 	switch (parent_count) {
 	case 0:
 		output(o, 1, _("Failed to merge submodule %s (merge following commits not found)"), path);
@@ -1400,7 +1409,7 @@ static int handle_rename_via_dir(struct merge_options *o,
 	 */
 	const struct diff_filespec *dest = pair->two;
 
-	if (!o->call_depth && would_lose_untracked(dest->path)) {
+	if (!o->call_depth && would_lose_untracked(o, dest->path)) {
 		char *alt_path = unique_path(o, dest->path, rename_branch);
 
 		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
@@ -1438,8 +1447,8 @@ static int handle_change_delete(struct merge_options *o,
 	const char *update_path = path;
 	int ret = 0;
 
-	if (dir_in_way(path, !o->call_depth, 0) ||
-	    (!o->call_depth && would_lose_untracked(path))) {
+	if (dir_in_way(o->repo->index, path, !o->call_depth, 0) ||
+	    (!o->call_depth && would_lose_untracked(o, path))) {
 		update_path = alt_path = unique_path(o, path, change_branch);
 	}
 
@@ -1449,7 +1458,7 @@ static int handle_change_delete(struct merge_options *o,
 		 * correct; since there is no true "middle point" between
 		 * them, simply reuse the base version for virtual merge base.
 		 */
-		ret = remove_file_from_cache(path);
+		ret = remove_file_from_index(o->repo->index, path);
 		if (!ret)
 			ret = update_file(o, 0, o_oid, o_mode, update_path);
 	} else {
@@ -1525,7 +1534,7 @@ static int handle_rename_delete(struct merge_options *o,
 		return -1;
 
 	if (o->call_depth)
-		return remove_file_from_cache(dest->path);
+		return remove_file_from_index(o->repo->index, dest->path);
 	else
 		return update_stages(o, dest->path, NULL,
 				     rename_branch == o->branch1 ? dest : NULL,
@@ -1606,10 +1615,10 @@ static int handle_file_collision(struct merge_options *o,
 	/* Remove rename sources if rename/add or rename/rename(2to1) */
 	if (prev_path1)
 		remove_file(o, 1, prev_path1,
-			    o->call_depth || would_lose_untracked(prev_path1));
+			    o->call_depth || would_lose_untracked(o, prev_path1));
 	if (prev_path2)
 		remove_file(o, 1, prev_path2,
-			    o->call_depth || would_lose_untracked(prev_path2));
+			    o->call_depth || would_lose_untracked(o, prev_path2));
 
 	/*
 	 * Remove the collision path, if it wouldn't cause dirty contents
@@ -1620,7 +1629,7 @@ static int handle_file_collision(struct merge_options *o,
 		output(o, 1, _("Refusing to lose dirty file at %s"),
 		       collide_path);
 		update_path = alt_path = unique_path(o, collide_path, "merged");
-	} else if (would_lose_untracked(collide_path)) {
+	} else if (would_lose_untracked(o, collide_path)) {
 		/*
 		 * Only way we get here is if both renames were from
 		 * a directory rename AND user had an untracked file
@@ -1716,12 +1725,12 @@ static char *find_path_for_conflict(struct merge_options *o,
 				    const char *branch2)
 {
 	char *new_path = NULL;
-	if (dir_in_way(path, !o->call_depth, 0)) {
+	if (dir_in_way(o->repo->index, path, !o->call_depth, 0)) {
 		new_path = unique_path(o, path, branch1);
 		output(o, 1, _("%s is a directory in %s adding "
 			       "as %s instead"),
 		       path, branch2, new_path);
-	} else if (would_lose_untracked(path)) {
+	} else if (would_lose_untracked(o, path)) {
 		new_path = unique_path(o, path, branch1);
 		output(o, 1, _("Refusing to lose untracked file"
 			       " at %s; adding as %s instead"),
@@ -1782,14 +1791,14 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 				return -1;
 		}
 		else
-			remove_file_from_cache(a->path);
+			remove_file_from_index(o->repo->index, a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
 		if (add) {
 			if (update_file(o, 0, &add->oid, add->mode, b->path))
 				return -1;
 		}
 		else
-			remove_file_from_cache(b->path);
+			remove_file_from_index(o->repo->index, b->path);
 	} else {
 		/*
 		 * For each destination path, we need to see if there is a
@@ -1886,7 +1895,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	repo_diff_setup(the_repository, &opts);
+	repo_diff_setup(o->repo, &opts);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
 	opts.detect_rename = merge_detect_rename(o);
@@ -3041,8 +3050,8 @@ static int blob_unchanged(struct merge_options *opt,
 	 * performed.  Comparison can be skipped if both files are
 	 * unchanged since their sha1s have already been compared.
 	 */
-	if (renormalize_buffer(&the_index, path, o.buf, o.len, &o) |
-	    renormalize_buffer(&the_index, path, a.buf, a.len, &a))
+	if (renormalize_buffer(opt->repo->index, path, o.buf, o.len, &o) |
+	    renormalize_buffer(opt->repo->index, path, a.buf, a.len, &a))
 		ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
 
 error_return:
@@ -3123,7 +3132,7 @@ static int handle_content_merge(struct merge_options *o,
 		a.path = (char *)path1;
 		b.path = (char *)path2;
 
-		if (dir_in_way(path, !o->call_depth,
+		if (dir_in_way(o->repo->index, path, !o->call_depth,
 			       S_ISGITLINK(pair1->two->mode)))
 			df_conflict_remains = 1;
 	}
@@ -3157,8 +3166,8 @@ static int handle_content_merge(struct merge_options *o,
 		pos = index_name_pos(&o->orig_index, path, strlen(path));
 		ce = o->orig_index.cache[pos];
 		if (ce_skip_worktree(ce)) {
-			pos = index_name_pos(&the_index, path, strlen(path));
-			ce = the_index.cache[pos];
+			pos = index_name_pos(o->repo->index, path, strlen(path));
+			ce = o->repo->index->cache[pos];
 			ce->ce_flags |= CE_SKIP_WORKTREE;
 		}
 		return mfi.clean;
@@ -3177,7 +3186,7 @@ static int handle_content_merge(struct merge_options *o,
 	if (df_conflict_remains || is_dirty) {
 		char *new_path;
 		if (o->call_depth) {
-			remove_file_from_cache(path);
+			remove_file_from_index(o->repo->index, path);
 		} else {
 			if (!mfi.clean) {
 				if (update_stages(o, path, &one, &a, &b))
@@ -3337,7 +3346,7 @@ static int process_entry(struct merge_options *o,
 			oid = b_oid;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(path,
+		if (dir_in_way(o->repo->index, path,
 			       !o->call_depth && !S_ISGITLINK(a_mode),
 			       0)) {
 			char *new_path = unique_path(o, path, add_branch);
@@ -3348,7 +3357,7 @@ static int process_entry(struct merge_options *o,
 			if (update_file(o, 0, oid, mode, new_path))
 				clean_merge = -1;
 			else if (o->call_depth)
-				remove_file_from_cache(path);
+				remove_file_from_index(o->repo->index, path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
@@ -3396,10 +3405,11 @@ int merge_trees(struct merge_options *o,
 		struct tree *common,
 		struct tree **result)
 {
+	struct index_state *istate = o->repo->index;
 	int code, clean;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!o->call_depth && index_has_changes(&the_index, head, &sb)) {
+	if (!o->call_depth && index_has_changes(istate, head, &sb)) {
 		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
 		return -1;
@@ -3427,7 +3437,7 @@ int merge_trees(struct merge_options *o,
 		return -1;
 	}
 
-	if (unmerged_cache()) {
+	if (unmerged_index(istate)) {
 		struct string_list *entries;
 		struct rename_info re_info;
 		int i;
@@ -3442,7 +3452,7 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, head);
 		get_files_dirs(o, merge);
 
-		entries = get_unmerged();
+		entries = get_unmerged(o->repo->index);
 		clean = detect_and_process_renames(o, common, head, merge,
 						   entries, &re_info);
 		record_df_conflict_files(o, entries);
@@ -3558,7 +3568,7 @@ int merge_recursive(struct merge_options *o,
 		 * overwritten it: the committed "conflicts" were
 		 * already resolved.
 		 */
-		discard_cache();
+		discard_index(o->repo->index);
 		saved_b1 = o->branch1;
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
@@ -3574,9 +3584,9 @@ int merge_recursive(struct merge_options *o,
 			return err(o, _("merge returned no commit"));
 	}
 
-	discard_cache();
+	discard_index(o->repo->index);
 	if (!o->call_depth)
-		repo_read_index(the_repository);
+		repo_read_index(o->repo);
 
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, get_commit_tree(h1), get_commit_tree(h2),
@@ -3643,7 +3653,7 @@ int merge_recursive_generic(struct merge_options *o,
 		}
 	}
 
-	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(o->repo, &lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 				result);
 	if (clean < 0) {
@@ -3651,7 +3661,7 @@ int merge_recursive_generic(struct merge_options *o,
 		return clean;
 	}
 
-	if (write_locked_index(&the_index, &lock,
+	if (write_locked_index(o->repo->index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		return err(o, _("Unable to write index."));
 
@@ -3675,10 +3685,12 @@ static void merge_recursive_config(struct merge_options *o)
 	git_config(git_xmerge_config, NULL);
 }
 
-void init_merge_options(struct merge_options *o)
+void init_merge_options(struct merge_options *o,
+			struct repository *repo)
 {
 	const char *merge_verbosity;
 	memset(o, 0, sizeof(struct merge_options));
+	o->repo = repo;
 	o->verbosity = 2;
 	o->buffer_output = 1;
 	o->diff_rename_limit = -1;
diff --git a/merge-recursive.h b/merge-recursive.h
index e6a0828eca..c2b7bb65c6 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -6,6 +6,8 @@
 
 struct commit;
 
+struct repository;
+
 struct merge_options {
 	const char *ancestor;
 	const char *branch1;
@@ -34,6 +36,7 @@ struct merge_options {
 	struct string_list df_conflict_file_set;
 	struct unpack_trees_options unpack_opts;
 	struct index_state orig_index;
+	struct repository *repo;
 };
 
 /*
@@ -92,7 +95,8 @@ int merge_recursive_generic(struct merge_options *o,
 			    const struct object_id **ca,
 			    struct commit **result);
 
-void init_merge_options(struct merge_options *o);
+void init_merge_options(struct merge_options *o,
+			struct repository *repo);
 struct tree *write_tree_from_memory(struct merge_options *o);
 
 int parse_merge_opt(struct merge_options *out, const char *s);
diff --git a/sequencer.c b/sequencer.c
index c2c9cc7e2b..cede6ea095 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -545,7 +545,7 @@ static int do_recursive_merge(struct repository *r,
 
 	repo_read_index(r);
 
-	init_merge_options(&o);
+	init_merge_options(&o, r);
 	o.ancestor = base ? base_label : "(empty tree)";
 	o.branch1 = "HEAD";
 	o.branch2 = next ? next_label : "(empty tree)";
@@ -3300,7 +3300,7 @@ static int do_merge(struct repository *r,
 	free_commit_list(bases);
 
 	repo_read_index(r);
-	init_merge_options(&o);
+	init_merge_options(&o, r);
 	o.branch1 = "HEAD";
 	o.branch2 = ref_name.buf;
 	o.buffer_output = 2;
-- 
2.20.0.482.g66447595a7

