Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3758D1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfFXJ4K (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:56:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40085 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfFXJ4J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:56:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so6820957pgj.7
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQ8G66IzFhrmiOyU+hGHIzgJstNvX3ln1rvQL+ojkA0=;
        b=GpqBybjBVz2iqo7kYwqYunBoUx/U/9I/RUzFAQeSCmLHh3pNH+n+IRqEuzMAYT8b5X
         4MV7nnuREHDwLHCe/4jMVGUC2ofLhyQKfN1bt6AMinqDY1meXOHxnJtzlfswbVDZ0Kvn
         4C3R8j9+GgK44nrD5SPMZt23TLjh4DWSswyYVJbTyBw4wLDQgltP5FGkI5qV5/DaSySN
         nSQYmiq/L38/cr6CdZ2XEsaykM5Ihx9+wYIF/KpM+AXEYc2o1YM3/wQwVokTT4eBqo2x
         pwjrMzaPjGQKvTqvgQi4uLyJavuVAgkipVgCvnCm90p4FNwA9Wn3LD72TIrYZ33TVz3O
         bhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQ8G66IzFhrmiOyU+hGHIzgJstNvX3ln1rvQL+ojkA0=;
        b=CcmIyr40ssiEWN12nRppA8Zi+lYfk1c2QFI9donaMtSPpmXYcrKSddroCmG88xm0zh
         R7tBZpuQr3v3P6wCcWGdiJDl61Favcj0n+haagIvmICyoU7d7XQ8NDOAsZQH23XXtw6d
         nJJQNl6bnvjNqULcv92c3erNsmJXyLuuEy9AOa8Em4nQTx3h7KluCH/jllx1OMXd/K3/
         mz1MQVpf0+k1rhwyeof8WwBjnsu9sO5ol4SUy5Vz5+/aYbu/SRLFSCGqFC9rFjvCriCZ
         kisaZRhR2heb15SbhrAps+OeL076d6WBONKkAI2mMwwoeeU7r98psNJtFvf0jRzuF000
         7XOQ==
X-Gm-Message-State: APjAAAW9KzoRdyOJ1oMFCgVuSKfMK0k/c+fyOeI6wEYUJuCx5/z9mbTs
        a/JiPyr+sTLC6PYcTykEVC5mlS+V
X-Google-Smtp-Source: APXvYqwvCmyxR+KI88NNvhIoLobCt0dvQaBaX+1FIPAxd+JybJvLdVvSYrjcmHAohskXqDKDF9wj1w==
X-Received: by 2002:a63:5247:: with SMTP id s7mr30740956pgl.29.1561370168945;
        Mon, 24 Jun 2019 02:56:08 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id p65sm12085258pfp.58.2019.06.24.02.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:56:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 16:56:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 6/6] Use the right 'struct repository' instead of the_repository
Date:   Mon, 24 Jun 2019 16:55:33 +0700
Message-Id: <20190624095533.22162-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624095533.22162-1-pclouds@gmail.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a couple of places where 'struct repository' is already passed
around, but the_repository is still used. Use the right repo.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 merge-recursive.c | 35 ++++++++++++++++++++---------------
 sequencer.c       |  4 ++--
 sha1-name.c       |  6 ++----
 shallow.c         |  3 ++-
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6d772eb0eb..12300131fc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -465,17 +465,18 @@ static void get_files_dirs(struct merge_options *opt, struct tree *tree)
 {
 	struct pathspec match_all;
 	memset(&match_all, 0, sizeof(match_all));
-	read_tree_recursive(the_repository, tree, "", 0, 0,
+	read_tree_recursive(opt->repo, tree, "", 0, 0,
 			    &match_all, save_files_dirs, opt);
 }
 
-static int get_tree_entry_if_blob(const struct object_id *tree,
+static int get_tree_entry_if_blob(struct repository *r,
+				  const struct object_id *tree,
 				  const char *path,
 				  struct diff_filespec *dfs)
 {
 	int ret;
 
-	ret = get_tree_entry(the_repository, tree, path, &dfs->oid, &dfs->mode);
+	ret = get_tree_entry(r, tree, path, &dfs->oid, &dfs->mode);
 	if (S_ISDIR(dfs->mode)) {
 		oidcpy(&dfs->oid, &null_oid);
 		dfs->mode = 0;
@@ -487,15 +488,16 @@ static int get_tree_entry_if_blob(const struct object_id *tree,
  * Returns an index_entry instance which doesn't have to correspond to
  * a real cache entry in Git's index.
  */
-static struct stage_data *insert_stage_data(const char *path,
+static struct stage_data *insert_stage_data(struct repository *r,
+		const char *path,
 		struct tree *o, struct tree *a, struct tree *b,
 		struct string_list *entries)
 {
 	struct string_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
-	get_tree_entry_if_blob(&o->object.oid, path, &e->stages[1]);
-	get_tree_entry_if_blob(&a->object.oid, path, &e->stages[2]);
-	get_tree_entry_if_blob(&b->object.oid, path, &e->stages[3]);
+	get_tree_entry_if_blob(r, &o->object.oid, path, &e->stages[1]);
+	get_tree_entry_if_blob(r, &a->object.oid, path, &e->stages[2]);
+	get_tree_entry_if_blob(r, &b->object.oid, path, &e->stages[3]);
 	item = string_list_insert(entries, path);
 	item->util = e;
 	return e;
@@ -1900,12 +1902,13 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 	return ret;
 }
 
-static int tree_has_path(struct tree *tree, const char *path)
+static int tree_has_path(struct repository *r, struct tree *tree,
+			 const char *path)
 {
 	struct object_id hashy;
 	unsigned short mode_o;
 
-	return !get_tree_entry(the_repository,
+	return !get_tree_entry(r,
 			       &tree->object.oid, path,
 			       &hashy, &mode_o);
 }
@@ -2057,7 +2060,7 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
 	 */
 	if (collision_ent->reported_already) {
 		clean = 0;
-	} else if (tree_has_path(tree, new_path)) {
+	} else if (tree_has_path(opt->repo, tree, new_path)) {
 		collision_ent->reported_already = 1;
 		strbuf_add_separated_string_list(&collision_paths, ", ",
 						 &collision_ent->source_files);
@@ -2135,7 +2138,7 @@ static void handle_directory_level_conflicts(struct merge_options *opt,
 			string_list_append(&remove_from_merge,
 					   merge_ent->dir)->util = merge_ent;
 			strbuf_release(&merge_ent->new_dir);
-		} else if (tree_has_path(head, head_ent->dir)) {
+		} else if (tree_has_path(opt->repo, head, head_ent->dir)) {
 			/* 2. This wasn't a directory rename after all */
 			string_list_append(&remove_from_head,
 					   head_ent->dir)->util = head_ent;
@@ -2149,7 +2152,7 @@ static void handle_directory_level_conflicts(struct merge_options *opt,
 	hashmap_iter_init(dir_re_merge, &iter);
 	while ((merge_ent = hashmap_iter_next(&iter))) {
 		head_ent = dir_rename_find_entry(dir_re_head, merge_ent->dir);
-		if (tree_has_path(merge, merge_ent->dir)) {
+		if (tree_has_path(opt->repo, merge, merge_ent->dir)) {
 			/* 2. This wasn't a directory rename after all */
 			string_list_append(&remove_from_merge,
 					   merge_ent->dir)->util = merge_ent;
@@ -2478,7 +2481,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		if (pair->status == 'R')
 			re->dst_entry->processed = 1;
 
-		re->dst_entry = insert_stage_data(new_path,
+		re->dst_entry = insert_stage_data(opt->repo, new_path,
 						  o_tree, a_tree, b_tree,
 						  entries);
 		item = string_list_insert(entries, new_path);
@@ -2587,14 +2590,16 @@ static struct string_list *get_renames(struct merge_options *opt,
 		re->dir_rename_original_dest = NULL;
 		item = string_list_lookup(entries, re->pair->one->path);
 		if (!item)
-			re->src_entry = insert_stage_data(re->pair->one->path,
+			re->src_entry = insert_stage_data(opt->repo,
+					re->pair->one->path,
 					o_tree, a_tree, b_tree, entries);
 		else
 			re->src_entry = item->util;
 
 		item = string_list_lookup(entries, re->pair->two->path);
 		if (!item)
-			re->dst_entry = insert_stage_data(re->pair->two->path,
+			re->dst_entry = insert_stage_data(opt->repo,
+					re->pair->two->path,
 					o_tree, a_tree, b_tree, entries);
 		else
 			re->dst_entry = item->util;
diff --git a/sequencer.c b/sequencer.c
index d565fcf2b1..64428ac28f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3733,7 +3733,7 @@ static int pick_commits(struct repository *r,
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
-			unlink(git_path_merge_head(the_repository));
+			unlink(git_path_merge_head(r));
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 			if (item->command == TODO_BREAK)
@@ -4107,7 +4107,7 @@ static int commit_staged_changes(struct repository *r,
 			   opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
-	unlink(git_path_merge_head(the_repository));
+	unlink(git_path_merge_head(r));
 	if (final_fixup) {
 		unlink(rebase_path_fixup_msg());
 		unlink(rebase_path_squash_msg());
diff --git a/sha1-name.c b/sha1-name.c
index 3c9fa10af8..6069fe006b 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -478,7 +478,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	 * or migrated from loose to packed.
 	 */
 	if (status == MISSING_OBJECT) {
-		reprepare_packed_git(the_repository);
+		reprepare_packed_git(r);
 		find_short_object_filename(&ds);
 		find_short_packed_object(&ds);
 		status = finish_object_disambiguation(&ds, oid);
@@ -1389,9 +1389,7 @@ int repo_get_oid_mb(struct repository *r,
 	two = lookup_commit_reference_gently(r, &oid_tmp, 0);
 	if (!two)
 		return -1;
-	if (r != the_repository)
-		BUG("sorry get_merge_bases() can't take struct repository yet");
-	mbs = get_merge_bases(one, two);
+	mbs = repo_get_merge_bases(r, one, two);
 	if (!mbs || mbs->next)
 		st = -1;
 	else {
diff --git a/shallow.c b/shallow.c
index ce45297940..5fa2b15d37 100644
--- a/shallow.c
+++ b/shallow.c
@@ -248,7 +248,8 @@ static void check_shallow_file_for_update(struct repository *r)
 	if (r->parsed_objects->is_shallow == -1)
 		BUG("shallow must be initialized by now");
 
-	if (!stat_validity_check(r->parsed_objects->shallow_stat, git_path_shallow(the_repository)))
+	if (!stat_validity_check(r->parsed_objects->shallow_stat,
+				 git_path_shallow(r)))
 		die("shallow file has changed since we read it");
 }
 
-- 
2.22.0.rc0.322.g2b0371e29a

