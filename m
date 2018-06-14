Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADFD1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964777AbeFNRS4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:18:56 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41721 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754723AbeFNRSy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:18:54 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so10594653lfa.8
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ztvJW6e3ncyVxJ9/WW1b8ci8wB2bZp05GMGqHegsqTg=;
        b=lTrC0Uqx66hS2Qckxk+2fD3jymX45panNZMWGf1kYyYLke9i/fEM5z96lRBlwWDm19
         DUqCLCB/42BB4QUcg+gu1uREbF/g4P28Fj4DkFOkYk111su7iuu9JxPaQeB49tpANOUJ
         K9K0vqPdEdMFg6FSVYLha0zxHza9GhMkBdQk4SfuKZtiYztcsqrJ62FqWY9Hlxe9OGsc
         /WJV5uflhI/yj88OfLcoJjYScWDyPsRhflntCowuA3UvcG14ejdvzgE+eCDpK2VXp7X6
         JbBHnh9Wva6+jX3XtBFmC6b8HMCvkY1IhgZJXOU/6gPRlusCA9lWnYoKkm86qtMYY/MJ
         sTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ztvJW6e3ncyVxJ9/WW1b8ci8wB2bZp05GMGqHegsqTg=;
        b=bAp7Tg2inLEL5OEXHgfEXt1F4sHkBTsbM1iRY+DO8n9PD7r1fj1NMIwqca0tT5oezj
         5qOLUiy+4n4q9C9ZQo2WBajomgYa79Q6Px+7/yxjAtWYGaMH9FJ8BikmJHcWKrDB6o1s
         S3J95cgDMPypKWmGN0+09HbgFokLS0q5QULjbaGHlN3gojoQ22RD5zvhboCVrVMcL+q5
         luPbAHpyeVijqWAOQg2YMxo7hZtyDy9sxyW7+qO3asU/PruKRmC08UvfqHlVJjubRp0T
         FVWYo2tuKW1bFDIqvr9bwFEEbLI3MqDcX/BV9eP9k6zs3z7yjfXasjVlDiCrjwYzs+hx
         jktA==
X-Gm-Message-State: APt69E3IvvGplLMwzvjMEtBXxFUg4NaMyJuJLY6BH6gAgNa46YgwU8Br
        pHoHmEKSgRYX4g+OhAkXL1nm9w==
X-Google-Smtp-Source: ADUXVKJiZvuqP1Ceb/lYhUOwjYLl+CIQ7RpE/jOTVaWwkIiQ4JWqhclFhdKLIjlKeZHHdVBj456akw==
X-Received: by 2002:a19:9390:: with SMTP id w16-v6mr6871752lfk.70.1528996732416;
        Thu, 14 Jun 2018 10:18:52 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b8-v6sm1163992lfh.6.2018.06.14.10.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 10:18:51 -0700 (PDT)
Date:   Thu, 14 Jun 2018 19:18:49 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 00/23] Fix incorrect use of the_index
Message-ID: <20180614171849.GA7675@duynguyen.home>
References: <20180606073933.14755-1-pclouds@gmail.com>
 <20180606165016.3285-1-pclouds@gmail.com>
 <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com>
 <CABPp-BGa+v2x1oeitVDMkQf3qFWx6kUT4wdWhCxjWwPyaW=3bg@mail.gmail.com>
 <CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com>
 <CABPp-BHYm57n=ufg_SqmA-UnOEMivWJZytnPPSU3WSYNeEph0g@mail.gmail.com>
 <CACsJy8AOzwu+GJLTsGtN0dCnwxoRBQYpM6gzVebN++zjpXNu7w@mail.gmail.com>
 <CABPp-BES3XFmM16TTqRxnCkO=sbqkSuWf6gBsbLYya8MzogMgQ@mail.gmail.com>
 <CACsJy8A17oqM4wTQo8A=KMcStGQ=xdQuq8pORVGEezPZJxHuOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8A17oqM4wTQo8A=KMcStGQ=xdQuq8pORVGEezPZJxHuOA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 06:49:00PM +0200, Duy Nguyen wrote:
> On Mon, Jun 11, 2018 at 6:44 PM Elijah Newren <newren@gmail.com> wrote:
> > > What about merge-recursive.c? Given that this whole thing will take
> > > many release cycles to finish, your work may get merged before mine
> > > and I could do the conversion now (and resolve conflicts and resubmit
> > > later). Of course if you like to keep merge-recursive.c the_index-free
> > > now, I will not stop you ;-)
> >
> > I was just worried that since I was making changes in
> > merge-recursive.c that it'd cause you conflict pain, so I offered to
> > convert it.  If that pain doesn't bother you, feel free to do the
> > conversion and we'll just work through the minor conflicts as we go.
> > Besides, sounds like you've converted nearly all of git, so it may
> > make sense to just keep it together in one big series.
> 
> OK let's just "quickly" get your series in then. I still have a few
> files to go and a couple more places to look back and ponder. I'm in
> no hurry to convert merge-recursive now :D

Actually could you quickly check if I pass the right index in the
following patch? I realize you only have one extra index, but I don't
know if it gets passed elsewhere and in some function I'm supposed to
use another index than the default "o->repo->index". Sometimes
o->repo->index is not the correct answer.

It takes many patches to get to this stage, so if you diff context
looks so strange to you, just ignore this for now. I'll eventually
send this one out in a series.

PS. I put a 'struct repository *' in 'struct merge_options' instead
because it turns out we do need full repo struct in some function.

-- 8< --
diff --git a/builtin/am.c b/builtin/am.c
index 3961878871..5d2ff9aa8c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1592,7 +1592,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	 * changes.
 	 */
 
-	init_merge_options(&o);
+	init_merge_options(&o, the_repository);
 
 	o.branch1 = "HEAD";
 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 528c6de7e1..4fd53cec6e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -570,7 +570,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * a pain; plumb in an option to set
 			 * o.renormalize?
 			 */
-			init_merge_options(&o);
+			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 0dd9021958..c4a9e575d6 100644
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
index db460a35cf..2ebd939b76 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -671,7 +671,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			return 2;
 		}
 
-		init_merge_options(&o);
+		init_merge_options(&o, the_repository);
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
diff --git a/merge-recursive.c b/merge-recursive.c
index a296ba3874..fd6556b6de 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -309,26 +309,29 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 }
 
 static int add_cacheinfo(struct merge_options *o,
-		unsigned int mode, const struct object_id *oid,
-		const char *path, int stage, int refresh, int options)
+			 unsigned int mode,
+			 const struct object_id *oid,
+			 const char *path, int stage,
+			 int refresh, int options)
 {
+	struct index_state *istate = o->repo->index;
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_index_entry(&the_index, mode, oid ? oid->hash : null_sha1, path, stage, 0);
+	ce = make_index_entry(istate, mode, oid ? oid->hash : null_sha1, path, stage, 0);
 	if (!ce)
 		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
-	ret = add_index_entry(&the_index, ce, options);
+	ret = add_index_entry(istate, ce, options);
 	if (refresh) {
 		struct cache_entry *nce;
 
-		nce = refresh_index_entry(&the_index, ce,
+		nce = refresh_index_entry(istate, ce,
 					  CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
 		if (!nce)
 			return err(o, _("add_cacheinfo failed to refresh for path '%s'; merge aborting."), path);
 		if (nce != ce)
-			ret = add_index_entry(&the_index, nce, options);
+			ret = add_index_entry(istate, nce, options);
 	}
 	return ret;
 }
@@ -356,7 +359,7 @@ static int unpack_trees_start(struct merge_options *o,
 	o->unpack_opts.merge = 1;
 	o->unpack_opts.head_idx = 2;
 	o->unpack_opts.fn = threeway_merge;
-	o->unpack_opts.src_index = &the_index;
+	o->unpack_opts.src_index = o->repo->index;
 	o->unpack_opts.dst_index = &tmp_index;
 	o->unpack_opts.aggressive = !merge_detect_rename(o);
 	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
@@ -366,16 +369,16 @@ static int unpack_trees_start(struct merge_options *o,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &o->unpack_opts);
-	cache_tree_free(&the_index.cache_tree);
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
@@ -390,12 +393,13 @@ static void unpack_trees_finish(struct merge_options *o)
 struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
+	struct index_state *istate = o->repo->index;
 
-	if (unmerged_index(&the_index)) {
+	if (unmerged_index(istate)) {
 		int i;
 		fprintf(stderr, "BUG: There are unmerged index entries:\n");
-		for (i = 0; i < the_index.cache_nr; i++) {
-			const struct cache_entry *ce = the_index.cache[i];
+		for (i = 0; i < istate->cache_nr; i++) {
+			const struct cache_entry *ce = istate->cache[i];
 			if (ce_stage(ce))
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
@@ -403,16 +407,16 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		BUG("unmerged index entries in merge-recursive.c");
 	}
 
-	if (!the_index.cache_tree)
-		the_index.cache_tree = cache_tree();
+	if (!istate->cache_tree)
+		istate->cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(the_index.cache_tree) &&
-	    cache_tree_update(&the_index, 0) < 0) {
+	if (!cache_tree_fully_valid(istate->cache_tree) &&
+	    cache_tree_update(istate, 0) < 0) {
 		err(o, _("error building trees"));
 		return NULL;
 	}
 
-	result = lookup_tree(&the_index.cache_tree->oid);
+	result = lookup_tree(&istate->cache_tree->oid);
 
 	return result;
 }
@@ -482,17 +486,17 @@ static struct stage_data *insert_stage_data(const char *path,
  * Create a dictionary mapping file names to stage_data objects. The
  * dictionary contains one entry for every path with a non-zero stage entry.
  */
-static struct string_list *get_unmerged(void)
+static struct string_list *get_unmerged(struct index_state *istate)
 {
 	struct string_list *unmerged = xcalloc(1, sizeof(struct string_list));
 	int i;
 
 	unmerged->strdup_strings = 1;
 
-	for (i = 0; i < the_index.cache_nr; i++) {
+	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
-		const struct cache_entry *ce = the_index.cache[i];
+		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
 
@@ -652,7 +656,7 @@ static int update_stages(struct merge_options *opt, const char *path,
 	int clear = 1;
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
 	if (clear)
-		if (remove_file_from_index(&the_index, path))
+		if (remove_file_from_index(opt->repo->index, path))
 			return -1;
 	if (o)
 		if (add_cacheinfo(opt, o->mode, &o->oid, path, 1, 0, options))
@@ -708,13 +712,13 @@ static int remove_file(struct merge_options *o, int clean,
 	int update_working_directory = !o->call_depth && !no_wd;
 
 	if (update_cache) {
-		if (remove_file_from_index(&the_index, path))
+		if (remove_file_from_index(o->repo->index, path))
 			return -1;
 	}
 	if (update_working_directory) {
 		if (ignore_case) {
 			struct cache_entry *ce;
-			ce = index_file_exists(&the_index, path, strlen(path),
+			ce = index_file_exists(o->repo->index, path, strlen(path),
 					       ignore_case);
 			if (ce && ce_stage(ce) == 0 && strcmp(path, ce->name))
 				return 0;
@@ -765,7 +769,8 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
  * check the working directory.  If empty_ok is non-zero, also return
  * 0 in the case where the working-tree dir exists but is empty.
  */
-static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
+static int dir_in_way(struct index_state *istate, const char *path,
+		      int check_working_copy, int empty_ok)
 {
 	int pos;
 	struct strbuf dirpath = STRBUF_INIT;
@@ -774,12 +779,12 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 	strbuf_addstr(&dirpath, path);
 	strbuf_addch(&dirpath, '/');
 
-	pos = index_name_pos(&the_index, dirpath.buf, dirpath.len);
+	pos = index_name_pos(istate, dirpath.buf, dirpath.len);
 
 	if (pos < 0)
 		pos = -1 - pos;
-	if (pos < the_index.cache_nr &&
-	    !strncmp(dirpath.buf, the_index.cache[pos]->name, dirpath.len)) {
+	if (pos < istate->cache_nr &&
+	    !strncmp(dirpath.buf, istate->cache[pos]->name, dirpath.len)) {
 		strbuf_release(&dirpath);
 		return 1;
 	}
@@ -822,7 +827,7 @@ static int was_tracked(struct merge_options *o, const char *path)
 	return 0;
 }
 
-static int would_lose_untracked(const char *path)
+static int would_lose_untracked(struct index_state *istate, const char *path)
 {
 	/*
 	 * This may look like it can be simplified to:
@@ -841,19 +846,19 @@ static int would_lose_untracked(const char *path)
 	 * update_file()/would_lose_untracked(); see every comment in this
 	 * file which mentions "update_stages".
 	 */
-	int pos = index_name_pos(&the_index, path, strlen(path));
+	int pos = index_name_pos(istate, path, strlen(path));
 
 	if (pos < 0)
 		pos = -1 - pos;
-	while (pos < the_index.cache_nr &&
-	       !strcmp(path, the_index.cache[pos]->name)) {
+	while (pos < istate->cache_nr &&
+	       !strcmp(path, istate->cache[pos]->name)) {
 		/*
 		 * If stage #0, it is definitely tracked.
 		 * If it has stage #2 then it was tracked
 		 * before this merge started.  All other
 		 * cases the path was not tracked.
 		 */
-		switch (ce_stage(the_index.cache[pos])) {
+		switch (ce_stage(istate->cache[pos])) {
 		case 0:
 		case 2:
 			return 0;
@@ -913,7 +918,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	 * Do not unlink a file in the work tree if we are not
 	 * tracking it.
 	 */
-	if (would_lose_untracked(path))
+	if (would_lose_untracked(o->repo->index, path))
 		return err(o, _("refusing to lose untracked file at '%s'"),
 			     path);
 
@@ -963,7 +968,7 @@ static int update_file_flags(struct merge_options *o,
 		}
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
-			if (convert_to_working_tree(&the_index, path, buf, size, &strbuf)) {
+			if (convert_to_working_tree(o->repo->index, path, buf, size, &strbuf)) {
 				free(buf);
 				size = strbuf.len;
 				buf = strbuf_detach(&strbuf, NULL);
@@ -1081,7 +1086,7 @@ static int merge_3way(struct merge_options *o,
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2,
-				&the_index, &ll_opts);
+				o->repo->index, &ll_opts);
 
 	free(base_name);
 	free(name1);
@@ -1092,8 +1097,9 @@ static int merge_3way(struct merge_options *o,
 	return merge_status;
 }
 
-static int find_first_merges(struct object_array *result, const char *path,
-		struct commit *a, struct commit *b)
+static int find_first_merges(struct repository *repo,
+			     struct object_array *result, const char *path,
+			     struct commit *a, struct commit *b)
 {
 	int i, j;
 	struct object_array merges = OBJECT_ARRAY_INIT;
@@ -1112,7 +1118,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	/* get all revisions that merge commit a */
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 			oid_to_hex(&a->object.oid));
-	init_revisions(&revs, the_repository, NULL);
+	init_revisions(&revs, repo, NULL);
 	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
 	revs.single_worktree = path != NULL;
@@ -1242,7 +1248,8 @@ static int merge_submodule(struct merge_options *o,
 		return 0;
 
 	/* find commit which merges them */
-	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
+	parent_count = find_first_merges(o->repo, &merges, path,
+					 commit_a, commit_b);
 	switch (parent_count) {
 	case 0:
 		output(o, 1, _("Failed to merge submodule %s (merge following commits not found)"), path);
@@ -1420,7 +1427,7 @@ static int conflict_rename_dir(struct merge_options *o,
 {
 	const struct diff_filespec *dest = pair->two;
 
-	if (!o->call_depth && would_lose_untracked(dest->path)) {
+	if (!o->call_depth && would_lose_untracked(o->repo->index, dest->path)) {
 		char *alt_path = unique_path(o, dest->path, rename_branch);
 
 		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
@@ -1458,8 +1465,8 @@ static int handle_change_delete(struct merge_options *o,
 	const char *update_path = path;
 	int ret = 0;
 
-	if (dir_in_way(path, !o->call_depth, 0) ||
-	    (!o->call_depth && would_lose_untracked(path))) {
+	if (dir_in_way(o->repo->index, path, !o->call_depth, 0) ||
+	    (!o->call_depth && would_lose_untracked(o->repo->index, path))) {
 		update_path = alt_path = unique_path(o, path, change_branch);
 	}
 
@@ -1469,7 +1476,7 @@ static int handle_change_delete(struct merge_options *o,
 		 * correct; since there is no true "middle point" between
 		 * them, simply reuse the base version for virtual merge base.
 		 */
-		ret = remove_file_from_index(&the_index, path);
+		ret = remove_file_from_index(o->repo->index, path);
 		if (!ret)
 			ret = update_file(o, 0, o_oid, o_mode, update_path);
 	} else {
@@ -1530,7 +1537,7 @@ static int conflict_rename_delete(struct merge_options *o,
 		return -1;
 
 	if (o->call_depth)
-		return remove_file_from_index(&the_index, dest->path);
+		return remove_file_from_index(o->repo->index, dest->path);
 	else
 		return update_stages(o, dest->path, NULL,
 				     rename_branch == o->branch1 ? dest : NULL,
@@ -1592,12 +1599,12 @@ static int handle_file(struct merge_options *o,
 		remove_file(o, 0, rename->path, ren_src_was_dirty);
 		dst_name = unique_path(o, rename->path, cur_branch);
 	} else {
-		if (dir_in_way(rename->path, !o->call_depth, 0)) {
+		if (dir_in_way(o->repo->index, rename->path, !o->call_depth, 0)) {
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
 		} else if (!o->call_depth &&
-			   would_lose_untracked(rename->path)) {
+			   would_lose_untracked(o->repo->index, rename->path)) {
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("Refusing to lose untracked file at %s; "
 				       "adding as %s instead"),
@@ -1665,14 +1672,14 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
 				return -1;
 		}
 		else
-			remove_file_from_index(&the_index, a->path);
+			remove_file_from_index(o->repo->index, a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
 		if (add) {
 			if (update_file(o, 0, &add->oid, add->mode, b->path))
 				return -1;
 		}
 		else
-			remove_file_from_index(&the_index, b->path);
+			remove_file_from_index(o->repo->index, b->path);
 	} else if (handle_file(o, a, 2, ci) || handle_file(o, b, 3, ci))
 		return -1;
 
@@ -1680,8 +1687,9 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
 }
 
 static int conflict_rename_rename_2to1(struct merge_options *o,
-					struct rename_conflict_info *ci)
+				       struct rename_conflict_info *ci)
 {
+	struct index_state *istate = o->repo->index;
 	/* Two files, a & b, were renamed to the same thing, c. */
 	struct diff_filespec *a = ci->pair1->one;
 	struct diff_filespec *b = ci->pair2->one;
@@ -1700,8 +1708,12 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 	       a->path, c1->path, ci->branch1,
 	       b->path, c2->path, ci->branch2);
 
-	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
-	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
+	remove_file(o, 1, a->path,
+		    (o->call_depth ||
+		     would_lose_untracked(istate, a->path)));
+	remove_file(o, 1, b->path,
+		    (o->call_depth ||
+		     would_lose_untracked(istate, b->path)));
 
 	path_side_1_desc = xstrfmt("%s (was %s)", path, a->path);
 	path_side_2_desc = xstrfmt("%s (was %s)", path, b->path);
@@ -1738,7 +1750,7 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 		if (was_dirty(o, path))
 			output(o, 1, _("Refusing to lose dirty file at %s"),
 			       path);
-		else if (would_lose_untracked(path))
+		else if (would_lose_untracked(istate, path))
 			/*
 			 * Only way we get here is if both renames were from
 			 * a directory rename AND user had an untracked file
@@ -1789,7 +1801,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	diff_setup(&opts, &the_index);
+	diff_setup(&opts, o->repo->index);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
 	opts.detect_rename = merge_detect_rename(o);
@@ -2949,8 +2961,8 @@ static int blob_unchanged(struct merge_options *opt,
 	 * performed.  Comparison can be skipped if both files are
 	 * unchanged since their sha1s have already been compared.
 	 */
-	if (renormalize_buffer(&the_index, path, o.buf, o.len, &o) |
-	    renormalize_buffer(&the_index, path, a.buf, a.len, &a))
+	if (renormalize_buffer(opt->repo->index, path, o.buf, o.len, &o) |
+	    renormalize_buffer(opt->repo->index, path, a.buf, a.len, &a))
 		ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
 
 error_return:
@@ -3028,7 +3040,7 @@ static int merge_content(struct merge_options *o,
 			 o->branch2 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
 
-		if (dir_in_way(path, !o->call_depth,
+		if (dir_in_way(o->repo->index, path, !o->call_depth,
 			       S_ISGITLINK(pair1->two->mode)))
 			df_conflict_remains = 1;
 	}
@@ -3066,7 +3078,7 @@ static int merge_content(struct merge_options *o,
 	if (df_conflict_remains || is_dirty) {
 		char *new_path;
 		if (o->call_depth) {
-			remove_file_from_index(&the_index, path);
+			remove_file_from_index(o->repo->index, path);
 		} else {
 			if (!mfi.clean) {
 				if (update_stages(o, path, &one, &a, &b))
@@ -3212,7 +3224,7 @@ static int process_entry(struct merge_options *o,
 			oid = b_oid;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(path,
+		if (dir_in_way(o->repo->index, path,
 			       !o->call_depth && !S_ISGITLINK(a_mode),
 			       0)) {
 			char *new_path = unique_path(o, path, add_branch);
@@ -3223,7 +3235,7 @@ static int process_entry(struct merge_options *o,
 			if (update_file(o, 0, oid, mode, new_path))
 				clean_merge = -1;
 			else if (o->call_depth)
-				remove_file_from_index(&the_index, path);
+				remove_file_from_index(o->repo->index, path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
@@ -3256,6 +3268,7 @@ int merge_trees(struct merge_options *o,
 		struct tree *common,
 		struct tree **result)
 {
+	struct index_state *istate = o->repo->index;
 	int code, clean;
 
 	if (o->subtree_shift) {
@@ -3266,7 +3279,7 @@ int merge_trees(struct merge_options *o,
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
-		if (!o->call_depth && index_has_changes(&the_index, &sb)) {
+		if (!o->call_depth && index_has_changes(istate, &sb)) {
 			err(o, _("Dirty index: cannot merge (dirty: %s)"),
 			    sb.buf);
 			return 0;
@@ -3287,7 +3300,7 @@ int merge_trees(struct merge_options *o,
 		return -1;
 	}
 
-	if (unmerged_index(&the_index)) {
+	if (unmerged_index(istate)) {
 		struct string_list *entries;
 		struct rename_info re_info;
 		int i;
@@ -3302,7 +3315,7 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, head);
 		get_files_dirs(o, merge);
 
-		entries = get_unmerged();
+		entries = get_unmerged(o->repo->index);
 		clean = handle_renames(o, common, head, merge, entries,
 				       &re_info);
 		record_df_conflict_files(o, entries);
@@ -3418,7 +3431,7 @@ int merge_recursive(struct merge_options *o,
 		 * overwritten it: the committed "conflicts" were
 		 * already resolved.
 		 */
-		discard_index(&the_index);
+		discard_index(o->repo->index);
 		saved_b1 = o->branch1;
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
@@ -3434,9 +3447,9 @@ int merge_recursive(struct merge_options *o,
 			return err(o, _("merge returned no commit"));
 	}
 
-	discard_index(&the_index);
+	discard_index(o->repo->index);
 	if (!o->call_depth)
-		repo_read_index(the_repository);
+		repo_read_index(o->repo);
 
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, get_commit_tree(h1), get_commit_tree(h2),
@@ -3501,7 +3514,7 @@ int merge_recursive_generic(struct merge_options *o,
 		}
 	}
 
-	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(o->repo, &lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
 	if (clean < 0) {
@@ -3509,7 +3522,7 @@ int merge_recursive_generic(struct merge_options *o,
 		return clean;
 	}
 
-	if (write_locked_index(&the_index, &lock,
+	if (write_locked_index(o->repo->index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		return err(o, _("Unable to write index."));
 
@@ -3533,10 +3546,12 @@ static void merge_recursive_config(struct merge_options *o)
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
index fa7bc6b683..b2985b621f 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -4,6 +4,8 @@
 #include "unpack-trees.h"
 #include "string-list.h"
 
+struct repository;
+
 struct merge_options {
 	const char *ancestor;
 	const char *branch1;
@@ -31,6 +33,7 @@ struct merge_options {
 	struct string_list df_conflict_file_set;
 	struct unpack_trees_options unpack_opts;
 	struct index_state orig_index;
+	struct repository *repo;
 };
 
 /*
@@ -89,7 +92,8 @@ int merge_recursive_generic(struct merge_options *o,
 			    const struct object_id **ca,
 			    struct commit **result);
 
-void init_merge_options(struct merge_options *o);
+void init_merge_options(struct merge_options *o,
+			struct repository *repo);
 struct tree *write_tree_from_memory(struct merge_options *o);
 
 int parse_merge_opt(struct merge_options *out, const char *s);
diff --git a/sequencer.c b/sequencer.c
index 5be3b5c79d..a8fb1861a3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -532,7 +532,7 @@ static int do_recursive_merge(struct repository *repo,
 
 	repo_read_index(repo);
 
-	init_merge_options(&o);
+	init_merge_options(&o, repo);
 	o.ancestor = base ? base_label : "(empty tree)";
 	o.branch1 = "HEAD";
 	o.branch2 = next ? next_label : "(empty tree)";
@@ -3022,7 +3022,7 @@ static int do_merge(struct repository *repo,
 	free_commit_list(bases);
 
 	repo_read_index(repo);
-	init_merge_options(&o);
+	init_merge_options(&o, repo);
 	o.branch1 = "HEAD";
 	o.branch2 = ref_name.buf;
 	o.buffer_output = 2;
-- 8< --

> -- 
> Duy
