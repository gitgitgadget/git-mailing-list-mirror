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
	by dcvr.yhbt.net (Postfix) with ESMTP id 423411F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfFXJz5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:55:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37271 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfFXJz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:55:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so7212480pfa.4
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uuS8+nvnnfw+NpZR3l5bQYvXCNHID+xxwPZ3nL+gIA=;
        b=uRibMM7NhOJ7O/YGt5YgTIGNUvE8BVfUWBxpvtnRyAlfBULFDNi3ap354PkTvFUeTM
         wmk9O6URhAsYwtgJizsYQvZJWbcC6WMUdqqCc3QXWqGGTyKhsbEkrc2eJnkYE8qHoFFI
         Fvp7m6nlHCJUOyU/vtYW66MY+DBJcYJ41TKAdtN4TbZdI3MW2Szds6Z+XDOKjYOUKVon
         2QDQJS+WC2UlQ/IvXdpomnEmtAmTu80niU+ezEnmA2hTttXSip9uVZryFt8WTONknqVv
         7Np/kibNiRo1pv/Jmtnb2FDz+FBDrsxnt9HnuVqpSR2tPRNNhPHh6ssgulHMwjV2Djfi
         I5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uuS8+nvnnfw+NpZR3l5bQYvXCNHID+xxwPZ3nL+gIA=;
        b=Dw37TIqMdMaaPOnUzryW6OJpEXl/Qo0X2knoBF6Y+h0uJS87i9FyjI5gb0t4qSo9hZ
         CAPRmxE+HuOGLlhsGUPCJ4n5qCSpwN2edsv59x1FFd5wwHD3eGrvaA7/8XOady8ghx9D
         Le0f6K3f6GdXHIvQ+8HX+zgwa+C3QhVWTPbQnUDG0tvGBo+EiGmwr76Sn8xv1vTC4c/s
         Yt6B+xlZNAjjNI8an/ZnjBAJLDS32aprXoqM1LcrSuDI9o6uwj+sn0LpWexmfZKYnvd1
         NZ41DHz+WZZF3F6ztxJ5QPDzOEEj9Nhx9Z+Nmb+8/+HeiDfC+eGxrcB3MQNAh+t+4YAi
         4+0Q==
X-Gm-Message-State: APjAAAXaZMbA9Tfx+wuzuGDyzYpq8LUQ2ADcA3wXaHZb72PB6eS35VFC
        Rh+FuIeM58LpByctjVOpUnv7KO4p
X-Google-Smtp-Source: APXvYqy8MoBLqZOTokLUfW+Gf+tbnr3X6drgtu34hOshMnXPApeqlfecv+s8LlT6aciV2LPR3i+yFQ==
X-Received: by 2002:a63:1723:: with SMTP id x35mr27235458pgl.233.1561370155954;
        Mon, 24 Jun 2019 02:55:55 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id y11sm11343674pfb.119.2019.06.24.02.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:55:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 16:55:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/6] tree-walk.c: remove the_repo from get_tree_entry()
Date:   Mon, 24 Jun 2019 16:55:30 +0700
Message-Id: <20190624095533.22162-4-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c              |  4 +++-
 blame.c                |  4 ++--
 builtin/rm.c           |  2 +-
 builtin/update-index.c |  2 +-
 line-log.c             |  7 ++++---
 match-trees.c          |  6 +++---
 merge-recursive.c      |  8 +++++---
 notes.c                |  2 +-
 sha1-name.c            |  9 +++++----
 tree-walk.c            | 18 ++++++++++++------
 tree-walk.h            |  2 +-
 11 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/archive.c b/archive.c
index 53141c1f0e..a8da0fcc4f 100644
--- a/archive.c
+++ b/archive.c
@@ -418,7 +418,9 @@ static void parse_treeish_arg(const char **argv,
 		unsigned short mode;
 		int err;
 
-		err = get_tree_entry(&tree->object.oid, prefix, &tree_oid,
+		err = get_tree_entry(ar_args->repo,
+				     &tree->object.oid,
+				     prefix, &tree_oid,
 				     &mode);
 		if (err || !S_ISDIR(mode))
 			die(_("current working directory is untracked"));
diff --git a/blame.c b/blame.c
index 145eaf2faf..ef022809e9 100644
--- a/blame.c
+++ b/blame.c
@@ -101,7 +101,7 @@ static void verify_working_tree_path(struct repository *r,
 		struct object_id blob_oid;
 		unsigned short mode;
 
-		if (!get_tree_entry(commit_oid, path, &blob_oid, &mode) &&
+		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode) &&
 		    oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
 			return;
 	}
@@ -532,7 +532,7 @@ static int fill_blob_sha1_and_mode(struct repository *r,
 {
 	if (!is_null_oid(&origin->blob_oid))
 		return 0;
-	if (get_tree_entry(&origin->commit->object.oid, origin->path, &origin->blob_oid, &origin->mode))
+	if (get_tree_entry(r, &origin->commit->object.oid, origin->path, &origin->blob_oid, &origin->mode))
 		goto error_out;
 	if (oid_object_info(r, &origin->blob_oid, NULL) != OBJ_BLOB)
 		goto error_out;
diff --git a/builtin/rm.c b/builtin/rm.c
index be8edc6d1e..2eacda42b4 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -179,7 +179,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 * way as changed from the HEAD.
 		 */
 		if (no_head
-		     || get_tree_entry(head, name, &oid, &mode)
+		     || get_tree_entry(the_repository, head, name, &oid, &mode)
 		     || ce->ce_mode != create_ce_mode(mode)
 		     || !oideq(&ce->oid, &oid))
 			staged_changes = 1;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3f8cc6ccb4..dff2f4b837 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -601,7 +601,7 @@ static struct cache_entry *read_one_ent(const char *which,
 	struct object_id oid;
 	struct cache_entry *ce;
 
-	if (get_tree_entry(ent, path, &oid, &mode)) {
+	if (get_tree_entry(the_repository, ent, path, &oid, &mode)) {
 		if (which)
 			error("%s: not in %s branch.", path, which);
 		return NULL;
diff --git a/line-log.c b/line-log.c
index 0a17b21187..3aff1849e7 100644
--- a/line-log.c
+++ b/line-log.c
@@ -496,12 +496,13 @@ static struct commit *check_single_commit(struct rev_info *revs)
 	return (struct commit *) commit;
 }
 
-static void fill_blob_sha1(struct commit *commit, struct diff_filespec *spec)
+static void fill_blob_sha1(struct repository *r, struct commit *commit,
+			   struct diff_filespec *spec)
 {
 	unsigned short mode;
 	struct object_id oid;
 
-	if (get_tree_entry(&commit->object.oid, spec->path, &oid, &mode))
+	if (get_tree_entry(r, &commit->object.oid, spec->path, &oid, &mode))
 		die("There is no path %s in the commit", spec->path);
 	fill_filespec(spec, &oid, 1, mode);
 
@@ -585,7 +586,7 @@ parse_lines(struct repository *r, struct commit *commit,
 					name_part);
 
 		spec = alloc_filespec(full_name);
-		fill_blob_sha1(commit, spec);
+		fill_blob_sha1(r, commit, spec);
 		fill_line_ends(r, spec, &lines, &ends);
 		cb_data.spec = spec;
 		cb_data.lines = lines;
diff --git a/match-trees.c b/match-trees.c
index 9d1ec8d6b0..de7e8a6783 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -290,7 +290,7 @@ void shift_tree(const struct object_id *hash1,
 		if (!*del_prefix)
 			return;
 
-		if (get_tree_entry(hash2, del_prefix, shifted, &mode))
+		if (get_tree_entry(the_repository, hash2, del_prefix, shifted, &mode))
 			die("cannot find path %s in tree %s",
 			    del_prefix, oid_to_hex(hash2));
 		return;
@@ -317,12 +317,12 @@ void shift_tree_by(const struct object_id *hash1,
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry(hash1, shift_prefix, &sub1, &mode1) &&
+	if (!get_tree_entry(the_repository, hash1, shift_prefix, &sub1, &mode1) &&
 	    S_ISDIR(mode1))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry(hash2, shift_prefix, &sub2, &mode2) &&
+	if (!get_tree_entry(the_repository, hash2, shift_prefix, &sub2, &mode2) &&
 	    S_ISDIR(mode2))
 		candidate |= 2;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index d2e380b7ed..b051066795 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -475,7 +475,7 @@ static int get_tree_entry_if_blob(const struct object_id *tree,
 {
 	int ret;
 
-	ret = get_tree_entry(tree, path, &dfs->oid, &dfs->mode);
+	ret = get_tree_entry(the_repository, tree, path, &dfs->oid, &dfs->mode);
 	if (S_ISDIR(dfs->mode)) {
 		oidcpy(&dfs->oid, &null_oid);
 		dfs->mode = 0;
@@ -1905,7 +1905,8 @@ static int tree_has_path(struct tree *tree, const char *path)
 	struct object_id hashy;
 	unsigned short mode_o;
 
-	return !get_tree_entry(&tree->object.oid, path,
+	return !get_tree_entry(the_repository,
+			       &tree->object.oid, path,
 			       &hashy, &mode_o);
 }
 
@@ -2500,7 +2501,8 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 	 * the various handle_rename_*() functions update the index
 	 * explicitly rather than relying on unpack_trees() to have done it.
 	 */
-	get_tree_entry(&tree->object.oid,
+	get_tree_entry(opt->repo,
+		       &tree->object.oid,
 		       pair->two->path,
 		       &re->dst_entry->stages[stage].oid,
 		       &re->dst_entry->stages[stage].mode);
diff --git a/notes.c b/notes.c
index 2522b87d77..75c028b300 100644
--- a/notes.c
+++ b/notes.c
@@ -1015,7 +1015,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
-	if (get_tree_entry(&object_oid, "", &oid, &mode))
+	if (get_tree_entry(the_repository, &object_oid, "", &oid, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, oid_to_hex(&object_oid));
 
diff --git a/sha1-name.c b/sha1-name.c
index 728e6f1f61..e8fb215e5c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1677,7 +1677,8 @@ int repo_get_oid_blob(struct repository *r,
 }
 
 /* Must be called only when object_name:filename doesn't exist. */
-static void diagnose_invalid_oid_path(const char *prefix,
+static void diagnose_invalid_oid_path(struct repository *r,
+				      const char *prefix,
 				      const char *filename,
 				      const struct object_id *tree_oid,
 				      const char *object_name,
@@ -1695,7 +1696,7 @@ static void diagnose_invalid_oid_path(const char *prefix,
 	if (is_missing_file_error(errno)) {
 		char *fullname = xstrfmt("%s%s", prefix, filename);
 
-		if (!get_tree_entry(tree_oid, fullname, &oid, &mode)) {
+		if (!get_tree_entry(r, tree_oid, fullname, &oid, &mode)) {
 			die("Path '%s' exists, but not '%s'.\n"
 			    "Did you mean '%.*s:%s' aka '%.*s:./%s'?",
 			    fullname,
@@ -1902,10 +1903,10 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 					filename, oid, &oc->symlink_path,
 					&oc->mode);
 			} else {
-				ret = get_tree_entry(&tree_oid, filename, oid,
+				ret = get_tree_entry(repo, &tree_oid, filename, oid,
 						     &oc->mode);
 				if (ret && only_to_die) {
-					diagnose_invalid_oid_path(prefix,
+					diagnose_invalid_oid_path(repo, prefix,
 								   filename,
 								   &tree_oid,
 								   name, len);
diff --git a/tree-walk.c b/tree-walk.c
index c5569b3e9f..506e12a031 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -502,7 +502,9 @@ struct dir_state {
 	struct object_id oid;
 };
 
-static int find_tree_entry(struct tree_desc *t, const char *name, struct object_id *result, unsigned short *mode)
+static int find_tree_entry(struct repository *r, struct tree_desc *t,
+			   const char *name, struct object_id *result,
+			   unsigned short *mode)
 {
 	int namelen = strlen(name);
 	while (t->size) {
@@ -532,19 +534,23 @@ static int find_tree_entry(struct tree_desc *t, const char *name, struct object_
 			oidcpy(result, &oid);
 			return 0;
 		}
-		return get_tree_entry(&oid, name + entrylen, result, mode);
+		return get_tree_entry(r, &oid, name + entrylen, result, mode);
 	}
 	return -1;
 }
 
-int get_tree_entry(const struct object_id *tree_oid, const char *name, struct object_id *oid, unsigned short *mode)
+int get_tree_entry(struct repository *r,
+		   const struct object_id *tree_oid,
+		   const char *name,
+		   struct object_id *oid,
+		   unsigned short *mode)
 {
 	int retval;
 	void *tree;
 	unsigned long size;
 	struct object_id root;
 
-	tree = read_object_with_reference(the_repository, tree_oid, tree_type, &size, &root);
+	tree = read_object_with_reference(r, tree_oid, tree_type, &size, &root);
 	if (!tree)
 		return -1;
 
@@ -559,7 +565,7 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
 	} else {
 		struct tree_desc t;
 		init_tree_desc(&t, tree, size);
-		retval = find_tree_entry(&t, name, oid, mode);
+		retval = find_tree_entry(r, &t, name, oid, mode);
 	}
 	free(tree);
 	return retval;
@@ -681,7 +687,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, c
 		}
 
 		/* Look up the first (or only) path component in the tree. */
-		find_result = find_tree_entry(&t, namebuf.buf,
+		find_result = find_tree_entry(the_repository, &t, namebuf.buf,
 					      &current_tree_oid, mode);
 		if (find_result) {
 			goto done;
diff --git a/tree-walk.h b/tree-walk.h
index 9aa1042642..639f79187f 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -68,7 +68,7 @@ struct traverse_info {
 	int show_all_errors;
 };
 
-int get_tree_entry(const struct object_id *, const char *, struct object_id *, unsigned short *);
+int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
 char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n);
 void setup_traverse_info(struct traverse_info *info, const char *base);
 
-- 
2.22.0.rc0.322.g2b0371e29a

