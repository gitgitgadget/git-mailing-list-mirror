Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0839207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbdEBWXk (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:23:40 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34600 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdEBWXd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:33 -0400
Received: by mail-pg0-f52.google.com with SMTP id v1so68091325pgv.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tYTzQK4K96zE9WoYXqlq3bih6OvhaYkuTJgviSr90+I=;
        b=TQprnFPVUiJGSdr3w40HeZ/EcATFBoU+BUYEwKEg+y9UHYMvhrzUBYrD9TTsdSSxdK
         Kmf0m5/udWVzfJrWGRGE6qDHZo5c9uhLnrAA1Dkja94aHr2UpywhRVLb2in5rGC9vyBa
         RUcPfBAlY7LU/0lRjYbm0Tl/MhPcNwS9sCTCh6rgo5/z2An9/v4ZBI5uInU6bb6pA8pJ
         8zrr0r5FXr57+qu/H8SaciKKa9OkixBD3g+jfY1RKSq//LP8goFw4RtF2gJlpMDJQajM
         QEx+MP0XaLyS29KHo7ypTwMm2sePII0RVF+jvPmd1VQ4VRMnkUnEzVVwTVdDBWtPc1n3
         mEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tYTzQK4K96zE9WoYXqlq3bih6OvhaYkuTJgviSr90+I=;
        b=eCMlUK03/uf5yQTJ9O3lE8DW3u903IEIDIWkjpldNWBe+tQBjaH1Dt2qRDa6rnvPN3
         kzPsIotNjN5Mw8l2Q+bvr28ga+bbGLj5dE18gsGPiMyx/o4bCNxDBRfs9TWZDQ8v6Lgj
         utfT2f7jDuF8R6ke7lTKu/N6XYB/jCxz+Fvh0fXedZ3gV19vEEWLdTQM6IQv+s08WHPV
         4SEz5FabQ5NDvTc5/fP7Vc5xvwC6aHnT1GUvkp9PsNbFUeLfUl9XFns/rfdcEqTJnE9A
         76bOgxQXpVJcy7sI6zKUN1XjJlykoHBaiChkZQlL3ZW1DMFdkI34R/Mr/JMP5FFWVDxi
         90IQ==
X-Gm-Message-State: AN3rC/5z9tXND4QG4638TjHUw7LKDc0ttCpbYqNFR6cEayPJRwbyqQ6F
        OmErbd59qKlBUxdX
X-Received: by 10.99.23.67 with SMTP id 3mr29629892pgx.4.1493763811611;
        Tue, 02 May 2017 15:23:31 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id 190sm717289pfz.15.2017.05.02.15.23.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/24] cache.h: drop active_* macros
Date:   Tue,  2 May 2017 15:23:00 -0700
Message-Id: <20170502222322.21055-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on the coccinelle patch:

@@ @@
-active_cache
+the_index.cache
@@ @@
-active_nr
+the_index.cache_nr
@@ @@
-active_alloc
+the_index.cache_alloc
@@ @@
-active_cache_changed
+the_index.cache_changed
@@ @@
-active_cache_tree
+the_index.cache_tree

Additional manual editing:
* drop the macros from cache.h
* fix the whitespace issue that apply complained about in
  builtin/checkout.c
* builtin/commit.c had an occurrence of active_cache_tree->sha1, which
  was not picked up with the coccinelle patch.
* diff.c and t/t2107-update-index-basic.sh referenced
  active_cache[_changed] in comments, fix them up.
* ative_nr was referenced in comments in read-cache.c and
  builtin/update-index.c, fix them.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c                          |  6 ++---
 builtin/add.c                    |  6 ++---
 builtin/am.c                     |  6 ++---
 builtin/blame.c                  |  6 ++---
 builtin/checkout-index.c         |  8 +++----
 builtin/checkout.c               | 49 ++++++++++++++++++++--------------------
 builtin/commit.c                 | 20 ++++++++--------
 builtin/fsck.c                   | 12 +++++-----
 builtin/grep.c                   |  8 +++----
 builtin/ls-files.c               | 36 ++++++++++++++---------------
 builtin/merge-index.c            | 10 ++++----
 builtin/merge.c                  | 12 +++++-----
 builtin/mv.c                     | 10 ++++----
 builtin/read-tree.c              |  2 +-
 builtin/rm.c                     | 16 ++++++-------
 builtin/submodule--helper.c      |  8 +++----
 builtin/update-index.c           | 48 ++++++++++++++++++++-------------------
 cache.h                          |  6 -----
 check-racy.c                     |  4 ++--
 diff-lib.c                       |  6 ++---
 diff.c                           |  8 +++----
 dir.c                            | 20 ++++++++--------
 merge-recursive.c                | 28 +++++++++++------------
 pathspec.c                       | 14 ++++++------
 read-cache.c                     |  2 +-
 rerere.c                         | 26 ++++++++++-----------
 revision.c                       | 18 +++++++--------
 sequencer.c                      | 19 ++++++++--------
 sha1_name.c                      | 14 ++++++------
 submodule.c                      | 12 +++++-----
 t/helper/test-dump-cache-tree.c  |  2 +-
 t/helper/test-scrap-cache-tree.c |  2 +-
 t/t2107-update-index-basic.sh    |  2 +-
 tree.c                           |  8 +++----
 wt-status.c                      | 12 +++++-----
 35 files changed, 232 insertions(+), 234 deletions(-)

diff --git a/apply.c b/apply.c
index 82701d6580..ae1b659b68 100644
--- a/apply.c
+++ b/apply.c
@@ -3499,7 +3499,7 @@ static int load_current(struct apply_state *state,
 	pos = cache_name_pos(name, strlen(name));
 	if (pos < 0)
 		return error(_("%s: does not exist in index"), name);
-	ce = active_cache[pos];
+	ce = the_index.cache[pos];
 	if (lstat(name, &st)) {
 		if (errno != ENOENT)
 			return error_errno("%s", name);
@@ -3671,7 +3671,7 @@ static int check_preimage(struct apply_state *state,
 				goto is_new;
 			return error(_("%s: does not exist in index"), old_name);
 		}
-		*ce = active_cache[pos];
+		*ce = the_index.cache[pos];
 		if (stat_ret < 0) {
 			if (checkout_target(&the_index, *ce, st))
 				return -1;
@@ -4001,7 +4001,7 @@ static int get_current_oid(struct apply_state *state, const char *path,
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		return -1;
-	oidcpy(oid, &active_cache[pos]->oid);
+	oidcpy(oid, &the_index.cache[pos]->oid);
 	return 0;
 }
 
diff --git a/builtin/add.c b/builtin/add.c
index ab6d04e8db..f6d71b10d0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -34,8 +34,8 @@ static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
 {
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 
 		if (pathspec && !ce_path_match(ce, pathspec, NULL))
 			continue;
@@ -458,7 +458,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	unplug_bulk_checkin();
 
 finish:
-	if (active_cache_changed) {
+	if (the_index.cache_changed) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
diff --git a/builtin/am.c b/builtin/am.c
index 4405d7307c..c6a679d8e1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1155,12 +1155,12 @@ static int index_has_changes(struct strbuf *sb)
 		diff_flush(&opt);
 		return DIFF_OPT_TST(&opt, HAS_CHANGES) != 0;
 	} else {
-		for (i = 0; sb && i < active_nr; i++) {
+		for (i = 0; sb && i < the_index.cache_nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, active_cache[i]->name);
+			strbuf_addstr(sb, the_index.cache[i]->name);
 		}
-		return !!active_nr;
+		return !!the_index.cache_nr;
 	}
 }
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 59955208fd..cbb7c1fd9d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2242,8 +2242,8 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos >= 0)
 		; /* path is in the index */
-	else if (-1 - pos < active_nr &&
-		 !strcmp(active_cache[-1 - pos]->name, path))
+	else if (-1 - pos < the_index.cache_nr &&
+		 !strcmp(the_index.cache[-1 - pos]->name, path))
 		; /* path is in the index, unmerged */
 	else
 		die("no such path '%s' in HEAD", path);
@@ -2401,7 +2401,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	if (!mode) {
 		int pos = cache_name_pos(path, len);
 		if (0 <= pos)
-			mode = active_cache[pos]->ce_mode;
+			mode = the_index.cache[pos]->ce_mode;
 		else
 			/* Let's not bother reading from HEAD tree */
 			mode = S_IFREG | 0644;
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 676b9419f0..1c3dcc1a8b 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -54,8 +54,8 @@ static int checkout_file(const char *name, const char *prefix)
 	if (pos < 0)
 		pos = -pos - 1;
 
-	while (pos < active_nr) {
-		struct cache_entry *ce = active_cache[pos];
+	while (pos < the_index.cache_nr) {
+		struct cache_entry *ce = the_index.cache[pos];
 		if (ce_namelen(ce) != namelen ||
 		    memcmp(ce->name, name, namelen))
 			break;
@@ -95,8 +95,8 @@ static void checkout_all(const char *prefix, int prefix_length)
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
-	for (i = 0; i < active_nr ; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr ; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 		if (ce_stage(ce) != checkout_stage
 		    && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
 			continue;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f33..0aac616ad6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -109,7 +109,7 @@ static int update_some(const unsigned char *sha1, struct strbuf *base,
 	 */
 	pos = cache_name_pos(ce->name, ce->ce_namelen);
 	if (pos >= 0) {
-		struct cache_entry *old = active_cache[pos];
+		struct cache_entry *old = the_index.cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
 		    !oidcmp(&ce->oid, &old->oid)) {
 			old->ce_flags |= CE_UPDATE;
@@ -135,17 +135,17 @@ static int read_tree_some(struct tree *tree, const struct pathspec *pathspec)
 
 static int skip_same_name(const struct cache_entry *ce, int pos)
 {
-	while (++pos < active_nr &&
-	       !strcmp(active_cache[pos]->name, ce->name))
+	while (++pos < the_index.cache_nr &&
+	       !strcmp(the_index.cache[pos]->name, ce->name))
 		; /* skip */
 	return pos;
 }
 
 static int check_stage(int stage, const struct cache_entry *ce, int pos)
 {
-	while (pos < active_nr &&
-	       !strcmp(active_cache[pos]->name, ce->name)) {
-		if (ce_stage(active_cache[pos]) == stage)
+	while (pos < the_index.cache_nr &&
+	       !strcmp(the_index.cache[pos]->name, ce->name)) {
+		if (ce_stage(the_index.cache[pos]) == stage)
 			return 0;
 		pos++;
 	}
@@ -160,8 +160,8 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
 	unsigned seen = 0;
 	const char *name = ce->name;
 
-	while (pos < active_nr) {
-		ce = active_cache[pos];
+	while (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos];
 		if (strcmp(name, ce->name))
 			break;
 		seen |= (1 << ce_stage(ce));
@@ -176,10 +176,11 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
 static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 			  const struct checkout *state)
 {
-	while (pos < active_nr &&
-	       !strcmp(active_cache[pos]->name, ce->name)) {
-		if (ce_stage(active_cache[pos]) == stage)
-			return checkout_entry(active_cache[pos], state, NULL);
+	while (pos < the_index.cache_nr &&
+	       !strcmp(the_index.cache[pos]->name, ce->name)) {
+		if (ce_stage(the_index.cache[pos]) == stage)
+			return checkout_entry(the_index.cache[pos], state,
+					      NULL);
 		pos++;
 	}
 	if (stage == 2)
@@ -190,7 +191,7 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 
 static int checkout_merged(int pos, const struct checkout *state)
 {
-	struct cache_entry *ce = active_cache[pos];
+	struct cache_entry *ce = the_index.cache[pos];
 	const char *path = ce->name;
 	mmfile_t ancestor, ours, theirs;
 	int status;
@@ -200,7 +201,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	unsigned mode = 0;
 
 	memset(threeway, 0, sizeof(threeway));
-	while (pos < active_nr) {
+	while (pos < the_index.cache_nr) {
 		int stage;
 		stage = ce_stage(ce);
 		if (!stage || strcmp(path, ce->name))
@@ -209,7 +210,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 		if (stage == 2)
 			mode = create_ce_mode(ce->ce_mode);
 		pos++;
-		ce = active_cache[pos];
+		ce = the_index.cache[pos];
 	}
 	if (is_null_oid(&threeway[1]) || is_null_oid(&threeway[2]))
 		return error(_("path '%s' does not have necessary versions"), path);
@@ -306,8 +307,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	 * Make sure all pathspecs participated in locating the paths
 	 * to be checked out.
 	 */
-	for (pos = 0; pos < active_nr; pos++) {
-		struct cache_entry *ce = active_cache[pos];
+	for (pos = 0; pos < the_index.cache_nr; pos++) {
+		struct cache_entry *ce = the_index.cache[pos];
 		ce->ce_flags &= ~CE_MATCHED;
 		if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
 			continue;
@@ -349,8 +350,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 		unmerge_marked_index(&the_index);
 
 	/* Any unmerged paths? */
-	for (pos = 0; pos < active_nr; pos++) {
-		const struct cache_entry *ce = active_cache[pos];
+	for (pos = 0; pos < the_index.cache_nr; pos++) {
+		const struct cache_entry *ce = the_index.cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce))
 				continue;
@@ -374,8 +375,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	state.force = 1;
 	state.refresh_cache = 1;
 	state.istate = &the_index;
-	for (pos = 0; pos < active_nr; pos++) {
-		struct cache_entry *ce = active_cache[pos];
+	for (pos = 0; pos < the_index.cache_nr; pos++) {
+		struct cache_entry *ce = the_index.cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce)) {
 				errs |= checkout_entry(ce, &state, NULL);
@@ -597,10 +598,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 	}
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!the_index.cache_tree)
+		the_index.cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(active_cache_tree))
+	if (!cache_tree_fully_valid(the_index.cache_tree))
 		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
diff --git a/builtin/commit.c b/builtin/commit.c
index 7cd08841a1..01d298c836 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -257,8 +257,8 @@ static int list_paths(struct string_list *list, const char *with_tree,
 		free(max_prefix);
 	}
 
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 		struct string_list_item *item;
 
 		if (ce->ce_flags & CE_UPDATE)
@@ -418,10 +418,10 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	if (!only && !pathspec.nr) {
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
-		if (active_cache_changed
-		    || !cache_tree_fully_valid(active_cache_tree))
+		if (the_index.cache_changed
+		    || !cache_tree_fully_valid(the_index.cache_tree))
 			update_main_cache_tree(WRITE_TREE_SILENT);
-		if (active_cache_changed) {
+		if (the_index.cache_changed) {
 			if (write_locked_index(&the_index, &index_lock,
 					       COMMIT_LOCK))
 				die(_("unable to write new_index file"));
@@ -888,7 +888,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct object_id oid;
 		const char *parent = "HEAD";
 
-		if (!active_nr && read_index(&the_index) < 0)
+		if (!the_index.cache_nr && read_index(&the_index) < 0)
 			die(_("Cannot read index"));
 
 		if (amend)
@@ -897,10 +897,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (get_sha1(parent, oid.hash)) {
 			int i, ita_nr = 0;
 
-			for (i = 0; i < active_nr; i++)
-				if (ce_intent_to_add(active_cache[i]))
+			for (i = 0; i < the_index.cache_nr; i++)
+				if (ce_intent_to_add(the_index.cache[i]))
 					ita_nr++;
-			commitable = active_nr - ita_nr > 0;
+			commitable = the_index.cache_nr - ita_nr > 0;
 		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
@@ -1758,7 +1758,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
 
-	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->sha1,
+	if (commit_tree_extended(sb.buf, sb.len, the_index.cache_tree->sha1,
 			 parents, oid.hash, author_ident.buf, sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 35e03556cb..c5d6593d30 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -773,15 +773,15 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	if (keep_cache_objects) {
 		verify_index_checksum = 1;
 		read_index(&the_index);
-		for (i = 0; i < active_nr; i++) {
+		for (i = 0; i < the_index.cache_nr; i++) {
 			unsigned int mode;
 			struct blob *blob;
 			struct object *obj;
 
-			mode = active_cache[i]->ce_mode;
+			mode = the_index.cache[i]->ce_mode;
 			if (S_ISGITLINK(mode))
 				continue;
-			blob = lookup_blob(active_cache[i]->oid.hash);
+			blob = lookup_blob(the_index.cache[i]->oid.hash);
 			if (!blob)
 				continue;
 			obj = &blob->object;
@@ -789,11 +789,11 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			if (name_objects)
 				add_decoration(fsck_walk_options.object_names,
 					obj,
-					xstrfmt(":%s", active_cache[i]->name));
+					xstrfmt(":%s", the_index.cache[i]->name));
 			mark_object_reachable(obj);
 		}
-		if (active_cache_tree)
-			fsck_cache_tree(active_cache_tree);
+		if (the_index.cache_tree)
+			fsck_cache_tree(the_index.cache_tree);
 	}
 
 	check_connectivity();
diff --git a/builtin/grep.c b/builtin/grep.c
index 5153dbf262..a1150e6f87 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -678,8 +678,8 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	read_index(&the_index);
 
-	for (nr = 0; nr < active_nr; nr++) {
-		const struct cache_entry *ce = active_cache[nr];
+	for (nr = 0; nr < the_index.cache_nr; nr++) {
+		const struct cache_entry *ce = the_index.cache[nr];
 		strbuf_setlen(&name, name_base_len);
 		strbuf_addstr(&name, ce->name);
 
@@ -711,8 +711,8 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (ce_stage(ce)) {
 			do {
 				nr++;
-			} while (nr < active_nr &&
-				 !strcmp(ce->name, active_cache[nr]->name));
+			} while (nr < the_index.cache_nr &&
+				 !strcmp(ce->name, the_index.cache[nr]->name));
 			nr--; /* compensate for loop control */
 		}
 		if (hit && opt->status_only)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index da4779ec0b..edcad6e8e1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -139,20 +139,20 @@ static void show_killed_files(struct dir_struct *dir)
 					die("BUG: killed-file %.*s not found",
 						ent->len, ent->name);
 				pos = -pos - 1;
-				while (pos < active_nr &&
-				       ce_stage(active_cache[pos]))
+				while (pos < the_index.cache_nr &&
+				       ce_stage(the_index.cache[pos]))
 					pos++; /* skip unmerged */
-				if (active_nr <= pos)
+				if (the_index.cache_nr <= pos)
 					break;
 				/* pos points at a name immediately after
 				 * ent->name in the cache.  Does it expect
 				 * ent->name to be a directory?
 				 */
-				len = ce_namelen(active_cache[pos]);
+				len = ce_namelen(the_index.cache[pos]);
 				if ((ent->len < len) &&
-				    !strncmp(active_cache[pos]->name,
+				    !strncmp(the_index.cache[pos]->name,
 					     ent->name, ent->len) &&
-				    active_cache[pos]->name[ent->len] == '/')
+				    the_index.cache[pos]->name[ent->len] == '/')
 					killed = 1;
 				break;
 			}
@@ -340,8 +340,8 @@ static void show_files(struct dir_struct *dir)
 			show_killed_files(dir);
 	}
 	if (show_cached || show_stage) {
-		for (i = 0; i < active_nr; i++) {
-			const struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < the_index.cache_nr; i++) {
+			const struct cache_entry *ce = the_index.cache[i];
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
 			    !ce_excluded(dir, ce))
 				continue;
@@ -354,8 +354,8 @@ static void show_files(struct dir_struct *dir)
 		}
 	}
 	if (show_deleted || show_modified) {
-		for (i = 0; i < active_nr; i++) {
-			const struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < the_index.cache_nr; i++) {
+			const struct cache_entry *ce = the_index.cache[i];
 			struct stat st;
 			int err;
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
@@ -388,19 +388,19 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 	if (pos < 0)
 		pos = -pos-1;
 	first = pos;
-	last = active_nr;
+	last = the_index.cache_nr;
 	while (last > first) {
 		int next = (last + first) >> 1;
-		const struct cache_entry *ce = active_cache[next];
+		const struct cache_entry *ce = the_index.cache[next];
 		if (!strncmp(ce->name, prefix, prefixlen)) {
 			first = next+1;
 			continue;
 		}
 		last = next;
 	}
-	memmove(active_cache, active_cache + pos,
+	memmove(the_index.cache, the_index.cache + pos,
 		(last - pos) * sizeof(struct cache_entry *));
-	active_nr = last - pos;
+	the_index.cache_nr = last - pos;
 }
 
 /*
@@ -426,8 +426,8 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 		die("bad tree-ish %s", tree_name);
 
 	/* Hoist the unmerged entries up to stage #3 to make room */
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 		if (!ce_stage(ce))
 			continue;
 		ce->ce_flags |= CE_STAGEMASK;
@@ -443,8 +443,8 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 	if (read_tree(tree, 1, &pathspec))
 		die("unable to read tree entries %s", tree_name);
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 		switch (ce_stage(ce)) {
 		case 0:
 			last_stage0 = ce;
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 51fb590dfa..d867ee73f0 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -12,11 +12,11 @@ static int merge_entry(int pos, const char *path)
 	char hexbuf[4][GIT_MAX_HEXSZ + 1];
 	char ownbuf[4][60];
 
-	if (pos >= active_nr)
+	if (pos >= the_index.cache_nr)
 		die("git merge-index: %s not in the cache", path);
 	found = 0;
 	do {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = the_index.cache[pos];
 		int stage = ce_stage(ce);
 
 		if (strcmp(ce->name, path))
@@ -26,7 +26,7 @@ static int merge_entry(int pos, const char *path)
 		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
-	} while (++pos < active_nr);
+	} while (++pos < the_index.cache_nr);
 	if (!found)
 		die("git merge-index: %s not in the cache", path);
 
@@ -57,8 +57,8 @@ static void merge_one_path(const char *path)
 static void merge_all(void)
 {
 	int i;
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 		if (!ce_stage(ce))
 			continue;
 		i += merge_entry(i, ce->name)-1;
diff --git a/builtin/merge.c b/builtin/merge.c
index 703827f006..4d4c56050c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -615,7 +615,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	if (!trees[nr_trees++])
 		return -1;
 	opts.fn = threeway_merge;
-	cache_tree_free(&active_cache_tree);
+	cache_tree_free(&the_index.cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
@@ -640,7 +640,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	refresh_cache(REFRESH_QUIET);
-	if (active_cache_changed &&
+	if (the_index.cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
 	rollback_lock_file(&lock);
@@ -680,7 +680,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				remoteheads->item, reversed, &result);
 		if (clean < 0)
 			exit(128);
-		if (active_cache_changed &&
+		if (the_index.cache_changed &&
 		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 			die (_("unable to write %s"), get_index_file());
 		rollback_lock_file(&lock);
@@ -703,8 +703,8 @@ static int count_unmerged_entries(void)
 {
 	int i, ret = 0;
 
-	for (i = 0; i < active_nr; i++)
-		if (ce_stage(active_cache[i]))
+	for (i = 0; i < the_index.cache_nr; i++)
+		if (ce_stage(the_index.cache[i]))
 			ret++;
 
 	return ret;
@@ -787,7 +787,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	refresh_cache(REFRESH_QUIET);
-	if (active_cache_changed &&
+	if (the_index.cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
 	rollback_lock_file(&lock);
diff --git a/builtin/mv.c b/builtin/mv.c
index 6fd7a3a9d8..3b887a9490 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -78,7 +78,7 @@ static void prepare_move_submodule(const char *src, int first,
 				   const char **submodule_gitfile)
 {
 	struct strbuf submodule_dotgit = STRBUF_INIT;
-	if (!S_ISGITLINK(active_cache[first]->ce_mode))
+	if (!S_ISGITLINK(the_index.cache[first]->ce_mode))
 		die(_("Directory %s is in index and no submodule?"), src);
 	if (!is_staging_gitmodules_ok())
 		die(_("Please stage your changes to .gitmodules or stash them to proceed"));
@@ -102,8 +102,8 @@ static int index_range_of_same_dir(const char *src, int length,
 		die(_("%.*s is in index"), len_w_slash, src_w_slash);
 
 	first = -1 - first;
-	for (last = first; last < active_nr; last++) {
-		const char *path = active_cache[last]->name;
+	for (last = first; last < the_index.cache_nr; last++) {
+		const char *path = the_index.cache[last]->name;
 		if (strncmp(path, src_w_slash, len_w_slash))
 			break;
 	}
@@ -209,7 +209,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				dst_len = strlen(dst);
 
 				for (j = 0; j < last - first; j++) {
-					const char *path = active_cache[first + j]->name;
+					const char *path = the_index.cache[first + j]->name;
 					source[argc + j] = path;
 					destination[argc + j] =
 						prefix_path(dst, dst_len, path + length + 1);
@@ -293,7 +293,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (gitmodules_modified)
 		stage_updated_gitmodules();
 
-	if (active_cache_changed &&
+	if (the_index.cache_changed &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("Unable to write new index file"));
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 23e212ee8c..f997814933 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -251,7 +251,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	if (opts.debug_unpack)
 		opts.fn = debug_merge;
 
-	cache_tree_free(&active_cache_tree);
+	cache_tree_free(&the_index.cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
 		parse_tree(tree);
diff --git a/builtin/rm.c b/builtin/rm.c
index d0eecbdaac..0813d0a853 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -30,8 +30,8 @@ static int get_ours_cache_pos(const char *path, int pos)
 {
 	int i = -pos - 1;
 
-	while ((i < active_nr) && !strcmp(active_cache[i]->name, path)) {
-		if (ce_stage(active_cache[i]) == 2)
+	while ((i < the_index.cache_nr) && !strcmp(the_index.cache[i]->name, path)) {
+		if (ce_stage(the_index.cache[i]) == 2)
 			return i;
 		i++;
 	}
@@ -73,7 +73,7 @@ static void submodules_absorb_gitdir_if_needed(const char *prefix)
 			if (pos < 0)
 				continue;
 		}
-		ce = active_cache[pos];
+		ce = the_index.cache[pos];
 
 		if (!S_ISGITLINK(ce->ce_mode) ||
 		    !file_exists(ce->name) ||
@@ -122,11 +122,11 @@ static int check_local_mod(struct object_id *head, int index_only)
 			if (pos < 0)
 				continue;
 
-			if (!S_ISGITLINK(active_cache[pos]->ce_mode) ||
+			if (!S_ISGITLINK(the_index.cache[pos]->ce_mode) ||
 			    is_empty_dir(name))
 				continue;
 		}
-		ce = active_cache[pos];
+		ce = the_index.cache[pos];
 
 		if (lstat(ce->name, &st) < 0) {
 			if (errno != ENOENT && errno != ENOTDIR)
@@ -278,8 +278,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	seen = xcalloc(pathspec.nr, 1);
 
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 		if (!ce_path_match(ce, &pathspec, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
@@ -386,7 +386,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			stage_updated_gitmodules();
 	}
 
-	if (active_cache_changed) {
+	if (the_index.cache_changed) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1281056312..822c3b3e57 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -243,8 +243,8 @@ static int module_list_compute(int argc, const char **argv,
 	if (read_index(&the_index) < 0)
 		die(_("index file corrupt"));
 
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
 				    0, ps_matched, 1) ||
@@ -253,8 +253,8 @@ static int module_list_compute(int argc, const char **argv,
 
 		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
 		list->entries[list->nr++] = ce;
-		while (i + 1 < active_nr &&
-		       !strcmp(ce->name, active_cache[i + 1]->name))
+		while (i + 1 < the_index.cache_nr &&
+		       !strcmp(ce->name, the_index.cache[i + 1]->name))
 			/*
 			 * Skip entries with the same name in different stages
 			 * to make sure an entry is returned only once.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7a4b914af4..9b93e09765 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -228,12 +228,12 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	int pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
 		if (mark)
-			active_cache[pos]->ce_flags |= flag;
+			the_index.cache[pos]->ce_flags |= flag;
 		else
-			active_cache[pos]->ce_flags &= ~flag;
-		active_cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
+			the_index.cache[pos]->ce_flags &= ~flag;
+		the_index.cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
 		cache_tree_invalidate_path(&the_index, path);
-		active_cache_changed |= CE_ENTRY_CHANGED;
+		the_index.cache_changed |= CE_ENTRY_CHANGED;
 		return 0;
 	}
 	return -1;
@@ -321,7 +321,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = the_index.cache[pos];
 		if (S_ISGITLINK(ce->ce_mode)) {
 
 			/* Do nothing to the index if there is no HEAD! */
@@ -336,8 +336,8 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* Inexact match: is there perhaps a subdirectory match? */
 	pos = -pos-1;
-	while (pos < active_nr) {
-		const struct cache_entry *ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		const struct cache_entry *ce = the_index.cache[pos++];
 
 		if (strncmp(ce->name, path, len))
 			break;
@@ -369,7 +369,7 @@ static int process_path(const char *path)
 		return error("'%s' is beyond a symbolic link", path);
 
 	pos = cache_name_pos(path, len);
-	ce = pos < 0 ? NULL : active_cache[pos];
+	ce = pos < 0 ? NULL : the_index.cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
 		 * working directory version is assumed "good"
@@ -431,7 +431,7 @@ static void chmod_path(char flip, const char *path)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
-	ce = active_cache[pos];
+	ce = the_index.cache[pos];
 	if (chmod_cache_entry(ce, flip) < 0)
 		goto fail;
 
@@ -614,8 +614,8 @@ static int unresolve_one(const char *path)
 	if (0 <= pos) {
 		/* already merged */
 		pos = unmerge_cache_entry_at(pos);
-		if (pos < active_nr) {
-			const struct cache_entry *ce = active_cache[pos];
+		if (pos < the_index.cache_nr) {
+			const struct cache_entry *ce = the_index.cache[pos];
 			if (ce_stage(ce) &&
 			    ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen))
@@ -628,8 +628,8 @@ static int unresolve_one(const char *path)
 		 * want to do anything in the former case.
 		 */
 		pos = -pos-1;
-		if (pos < active_nr) {
-			const struct cache_entry *ce = active_cache[pos];
+		if (pos < the_index.cache_nr) {
+			const struct cache_entry *ce = the_index.cache[pos];
 			if (ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen)) {
 				fprintf(stderr,
@@ -724,8 +724,8 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		has_head = 0;
  redo:
-	for (pos = 0; pos < active_nr; pos++) {
-		const struct cache_entry *ce = active_cache[pos];
+	for (pos = 0; pos < the_index.cache_nr; pos++) {
+		const struct cache_entry *ce = the_index.cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
 		char *path;
@@ -740,16 +740,18 @@ static int do_reupdate(int ac, const char **av,
 			free(old);
 			continue; /* unchanged */
 		}
-		/* Be careful.  The working tree may not have the
+		/*
+		 * Be careful.  The working tree may not have the
 		 * path anymore, in which case, under 'allow_remove',
-		 * or worse yet 'allow_replace', active_nr may decrease.
+		 * or worse yet 'allow_replace', the_index.cache_nr
+		 * may decrease.
 		 */
-		save_nr = active_nr;
+		save_nr = the_index.cache_nr;
 		path = xstrdup(ce->name);
 		update_one(path);
 		free(path);
 		free(old);
-		if (save_nr != active_nr)
+		if (save_nr != the_index.cache_nr)
 			goto redo;
 	}
 	clear_pathspec(&pathspec);
@@ -878,7 +880,7 @@ static int unresolve_callback(struct parse_opt_ctx_t *ctx,
 	*has_errors = do_unresolve(ctx->argc, ctx->argv,
 				prefix, prefix ? strlen(prefix) : 0);
 	if (*has_errors)
-		active_cache_changed = 0;
+		the_index.cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -896,7 +898,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
 	*has_errors = do_reupdate(ctx->argc, ctx->argv,
 				prefix, prefix ? strlen(prefix) : 0);
 	if (*has_errors)
-		active_cache_changed = 0;
+		the_index.cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -1075,7 +1077,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
 		if (the_index.version != preferred_index_format)
-			active_cache_changed |= SOMETHING_CHANGED;
+			the_index.cache_changed |= SOMETHING_CHANGED;
 		the_index.version = preferred_index_format;
 	}
 
@@ -1146,7 +1148,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
-	if (active_cache_changed) {
+	if (the_index.cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
diff --git a/cache.h b/cache.h
index 9a1ea38a14..4e913d1346 100644
--- a/cache.h
+++ b/cache.h
@@ -354,12 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define active_cache (the_index.cache)
-#define active_nr (the_index.cache_nr)
-#define active_alloc (the_index.cache_alloc)
-#define active_cache_changed (the_index.cache_changed)
-#define active_cache_tree (the_index.cache_tree)
-
 #define read_cache_from(path) read_index_from(&the_index, (path))
 #define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
 #define is_cache_unborn() is_index_unborn(&the_index)
diff --git a/check-racy.c b/check-racy.c
index f50b21cb06..6599ae84cf 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -7,8 +7,8 @@ int main(int ac, char **av)
 
 	dirty = clean = racy = 0;
 	read_index(&the_index);
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 		struct stat st;
 
 		if (lstat(ce->name, &st)) {
diff --git a/diff-lib.c b/diff-lib.c
index 52447466b5..de59ec0459 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -95,10 +95,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
-	entries = active_nr;
+	entries = the_index.cache_nr;
 	for (i = 0; i < entries; i++) {
 		unsigned int oldmode, newmode;
-		struct cache_entry *ce = active_cache[i];
+		struct cache_entry *ce = the_index.cache[i];
 		int changed;
 		unsigned dirty_submodule = 0;
 		const unsigned char *old_sha1, *new_sha1;
@@ -142,7 +142,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			dpath->mode = wt_mode;
 
 			while (i < entries) {
-				struct cache_entry *nce = active_cache[i];
+				struct cache_entry *nce = the_index.cache[i];
 				int stage;
 
 				if (strcmp(ce->name, nce->name))
diff --git a/diff.c b/diff.c
index 05d0312265..37083914c5 100644
--- a/diff.c
+++ b/diff.c
@@ -2736,7 +2736,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * by diff-cache --cached, which does read the cache before
 	 * calling us.
 	 */
-	if (!active_cache)
+	if (!the_index.cache)
 		return 0;
 
 	/* We want to avoid the working directory if our caller
@@ -2762,7 +2762,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	pos = cache_name_pos(name, len);
 	if (pos < 0)
 		return 0;
-	ce = active_cache[pos];
+	ce = the_index.cache[pos];
 
 	/*
 	 * This is not the sha1 we are looking for, or
@@ -3490,10 +3490,10 @@ void diff_setup_done(struct diff_options *options)
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit = diff_rename_limit_default;
 	if (options->setup & DIFF_SETUP_USE_CACHE) {
-		if (!active_cache)
+		if (!the_index.cache)
 			/* read-cache does not die even when it fails
 			 * so it is safe for us to do this here.  Also
-			 * it does not smudge active_cache or active_nr
+			 * it does not smudge cache or nr of the_index
 			 * when it fails, so we do not have to worry about
 			 * cleaning it up ourselves either.
 			 */
diff --git a/dir.c b/dir.c
index f451bfa48c..8abad1b969 100644
--- a/dir.c
+++ b/dir.c
@@ -599,9 +599,9 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 	pos = cache_name_pos(path, len);
 	if (pos < 0)
 		return NULL;
-	if (!ce_skip_worktree(active_cache[pos]))
+	if (!ce_skip_worktree(the_index.cache[pos]))
 		return NULL;
-	data = read_sha1_file(active_cache[pos]->oid.hash, &type, &sz);
+	data = read_sha1_file(the_index.cache[pos]->oid.hash, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
@@ -609,7 +609,7 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 	*size = xsize_t(sz);
 	if (sha1_stat) {
 		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
-		hashcpy(sha1_stat->sha1, active_cache[pos]->oid.hash);
+		hashcpy(sha1_stat->sha1, the_index.cache[pos]->oid.hash);
 	}
 	return data;
 }
@@ -786,11 +786,11 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 				; /* no content change, ss->sha1 still good */
 			else if (check_index &&
 				 (pos = cache_name_pos(fname, strlen(fname))) >= 0 &&
-				 !ce_stage(active_cache[pos]) &&
-				 ce_uptodate(active_cache[pos]) &&
+				 !ce_stage(the_index.cache[pos]) &&
+				 ce_uptodate(the_index.cache[pos]) &&
 				 !would_convert_to_git(fname))
 				hashcpy(sha1_stat->sha1,
-					active_cache[pos]->oid.hash);
+					the_index.cache[pos]->oid.hash);
 			else
 				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
 			fill_stat_data(&sha1_stat->stat, &st);
@@ -1293,8 +1293,8 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
 	pos = cache_name_pos(dirname, len);
 	if (pos < 0)
 		pos = -pos-1;
-	while (pos < active_nr) {
-		const struct cache_entry *ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		const struct cache_entry *ce = the_index.cache[pos++];
 		unsigned char endchar;
 
 		if (strncmp(ce->name, dirname, len))
@@ -1478,8 +1478,8 @@ static int get_index_dtype(const char *path, int len)
 	if (pos >= 0)
 		return DT_UNKNOWN;
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos++];
 		if (strncmp(ce->name, path, len))
 			break;
 		if (ce->name[len] > '/')
diff --git a/merge-recursive.c b/merge-recursive.c
index 3cfaf33faa..57ca250c88 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -275,7 +275,7 @@ static int git_merge_trees(int index_only,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &opts);
-	cache_tree_free(&active_cache_tree);
+	cache_tree_free(&the_index.cache_tree);
 	return rc;
 }
 
@@ -286,8 +286,8 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 	if (unmerged_cache()) {
 		int i;
 		fprintf(stderr, "BUG: There are unmerged index entries:\n");
-		for (i = 0; i < active_nr; i++) {
-			const struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < the_index.cache_nr; i++) {
+			const struct cache_entry *ce = the_index.cache[i];
 			if (ce_stage(ce))
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
@@ -295,16 +295,16 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		die("BUG: unmerged index entries in merge-recursive.c");
 	}
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!the_index.cache_tree)
+		the_index.cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(active_cache_tree) &&
+	if (!cache_tree_fully_valid(the_index.cache_tree) &&
 	    cache_tree_update(&the_index, 0) < 0) {
 		err(o, _("error building trees"));
 		return NULL;
 	}
 
-	result = lookup_tree(active_cache_tree->sha1);
+	result = lookup_tree(the_index.cache_tree->sha1);
 
 	return result;
 }
@@ -370,10 +370,10 @@ static struct string_list *get_unmerged(void)
 
 	unmerged->strdup_strings = 1;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < the_index.cache_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = the_index.cache[i];
 		if (!ce_stage(ce))
 			continue;
 
@@ -683,8 +683,8 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 
 	if (pos < 0)
 		pos = -1 - pos;
-	if (pos < active_nr &&
-	    !strncmp(dirpath.buf, active_cache[pos]->name, dirpath.len)) {
+	if (pos < the_index.cache_nr &&
+	    !strncmp(dirpath.buf, the_index.cache[pos]->name, dirpath.len)) {
 		strbuf_release(&dirpath);
 		return 1;
 	}
@@ -709,9 +709,9 @@ static int was_tracked(const char *path)
 	 * had the path tracked (and resulted in a conflict).
 	 */
 	for (pos = -1 - pos;
-	     pos < active_nr && !strcmp(path, active_cache[pos]->name);
+	     pos < the_index.cache_nr && !strcmp(path, the_index.cache[pos]->name);
 	     pos++)
-		if (ce_stage(active_cache[pos]) == 2)
+		if (ce_stage(the_index.cache[pos]) == 2)
 			return 1;
 	return 0;
 }
@@ -2145,7 +2145,7 @@ int merge_recursive_generic(struct merge_options *o,
 	if (clean < 0)
 		return clean;
 
-	if (active_cache_changed &&
+	if (the_index.cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 		return err(o, _("Unable to write index."));
 
diff --git a/pathspec.c b/pathspec.c
index 50f76fff45..25c2afef30 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -32,8 +32,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 		ce_path_match(ce, pathspec, seen);
 	}
 }
@@ -391,7 +391,7 @@ static void strip_submodule_slash_cheap(struct pathspec_item *item)
 	if (item->len >= 1 && item->match[item->len - 1] == '/') {
 		int i = cache_name_pos(item->match, item->len - 1);
 
-		if (i >= 0 && S_ISGITLINK(active_cache[i]->ce_mode)) {
+		if (i >= 0 && S_ISGITLINK(the_index.cache[i]->ce_mode)) {
 			item->len--;
 			item->match[item->len] = '\0';
 		}
@@ -402,8 +402,8 @@ static void strip_submodule_slash_expensive(struct pathspec_item *item)
 {
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 		int ce_len = ce_namelen(ce);
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -428,8 +428,8 @@ static void die_inside_submodule_path(struct pathspec_item *item)
 {
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 		int ce_len = ce_namelen(ce);
 
 		if (!S_ISGITLINK(ce->ce_mode))
diff --git a/read-cache.c b/read-cache.c
index f1bdb006f4..6681376f5b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1791,7 +1791,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	while (src_offset <= mmap_size - 20 - 8) {
-		/* After an array of active_nr index entries,
+		/* After an array of the_index.cache_nr index entries,
 		 * there can be arbitrary number of extended
 		 * sections, each of which is prefixed with
 		 * extension name (4-byte) and section length
diff --git a/rerere.c b/rerere.c
index 770b34a5c9..b9b39a959e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -523,7 +523,7 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
  */
 static int check_one_conflict(int i, int *type)
 {
-	const struct cache_entry *e = active_cache[i];
+	const struct cache_entry *e = the_index.cache[i];
 
 	if (!ce_stage(e)) {
 		*type = RESOLVED;
@@ -531,13 +531,13 @@ static int check_one_conflict(int i, int *type)
 	}
 
 	*type = PUNTED;
-	while (ce_stage(active_cache[i]) == 1)
+	while (ce_stage(the_index.cache[i]) == 1)
 		i++;
 
 	/* Only handle regular files with both stages #2 and #3 */
-	if (i + 1 < active_nr) {
-		const struct cache_entry *e2 = active_cache[i];
-		const struct cache_entry *e3 = active_cache[i + 1];
+	if (i + 1 < the_index.cache_nr) {
+		const struct cache_entry *e2 = the_index.cache[i];
+		const struct cache_entry *e3 = the_index.cache[i + 1];
 		if (ce_stage(e2) == 2 &&
 		    ce_stage(e3) == 3 &&
 		    ce_same_name(e, e3) &&
@@ -547,7 +547,7 @@ static int check_one_conflict(int i, int *type)
 	}
 
 	/* Skip the entries with the same name */
-	while (i < active_nr && ce_same_name(e, active_cache[i]))
+	while (i < the_index.cache_nr && ce_same_name(e, the_index.cache[i]))
 		i++;
 	return i;
 }
@@ -569,9 +569,9 @@ static int find_conflict(struct string_list *conflict)
 	if (read_index(&the_index) < 0)
 		return error("Could not read index");
 
-	for (i = 0; i < active_nr;) {
+	for (i = 0; i < the_index.cache_nr;) {
 		int conflict_type;
-		const struct cache_entry *e = active_cache[i];
+		const struct cache_entry *e = the_index.cache[i];
 		i = check_one_conflict(i, &conflict_type);
 		if (conflict_type == THREE_STAGED)
 			string_list_insert(conflict, (const char *)e->name);
@@ -602,9 +602,9 @@ int rerere_remaining(struct string_list *merge_rr)
 	if (read_index(&the_index) < 0)
 		return error("Could not read index");
 
-	for (i = 0; i < active_nr;) {
+	for (i = 0; i < the_index.cache_nr;) {
 		int conflict_type;
-		const struct cache_entry *e = active_cache[i];
+		const struct cache_entry *e = the_index.cache[i];
 		i = check_one_conflict(i, &conflict_type);
 		if (conflict_type == PUNTED)
 			string_list_insert(merge_rr, (const char *)e->name);
@@ -718,7 +718,7 @@ static void update_paths(struct string_list *update)
 			item->string);
 	}
 
-	if (active_cache_changed) {
+	if (the_index.cache_changed) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 			die("Unable to write new index file");
 	} else
@@ -971,11 +971,11 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 		return -1;
 	pos = -pos - 1;
 
-	while (pos < active_nr) {
+	while (pos < the_index.cache_nr) {
 		enum object_type type;
 		unsigned long size;
 
-		ce = active_cache[pos++];
+		ce = the_index.cache[pos++];
 		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
 			break;
 		i = ce_stage(ce) - 1;
diff --git a/revision.c b/revision.c
index bb6250ef02..57d71abdbf 100644
--- a/revision.c
+++ b/revision.c
@@ -1268,8 +1268,8 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 	int i;
 
 	read_index(&the_index);
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 		struct blob *blob;
 
 		if (S_ISGITLINK(ce->ce_mode))
@@ -1282,9 +1282,9 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 					     ce->ce_mode, ce->name);
 	}
 
-	if (active_cache_tree) {
+	if (the_index.cache_tree) {
 		struct strbuf path = STRBUF_INIT;
-		add_cache_tree(active_cache_tree, revs, &path);
+		add_cache_tree(the_index.cache_tree, revs, &path);
 		strbuf_release(&path);
 	}
 }
@@ -1407,10 +1407,10 @@ static void prepare_show_merge(struct rev_info *revs)
 	free_commit_list(bases);
 	head->object.flags |= SYMMETRIC_LEFT;
 
-	if (!active_nr)
+	if (!the_index.cache_nr)
 		read_index(&the_index);
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 		if (!ce_stage(ce))
 			continue;
 		if (ce_path_match(ce, &revs->prune_data, NULL)) {
@@ -1419,8 +1419,8 @@ static void prepare_show_merge(struct rev_info *revs)
 			prune[prune_num-2] = ce->name;
 			prune[prune_num-1] = NULL;
 		}
-		while ((i+1 < active_nr) &&
-		       ce_same_name(ce, active_cache[i+1]))
+		while ((i+1 < the_index.cache_nr) &&
+		       ce_same_name(ce, the_index.cache[i+1]))
 			i++;
 	}
 	clear_pathspec(&revs->prune_data);
diff --git a/sequencer.c b/sequencer.c
index b7ec4e3221..9409b65aaa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -413,12 +413,12 @@ void append_conflicts_hint(struct strbuf *msgbuf)
 
 	strbuf_addch(msgbuf, '\n');
 	strbuf_commented_addf(msgbuf, "Conflicts:\n");
-	for (i = 0; i < active_nr;) {
-		const struct cache_entry *ce = active_cache[i++];
+	for (i = 0; i < the_index.cache_nr;) {
+		const struct cache_entry *ce = the_index.cache[i++];
 		if (ce_stage(ce)) {
 			strbuf_commented_addf(msgbuf, "\t%s\n", ce->name);
-			while (i < active_nr && !strcmp(ce->name,
-							active_cache[i]->name))
+			while (i < the_index.cache_nr && !strcmp(ce->name,
+							the_index.cache[i]->name))
 				i++;
 		}
 	}
@@ -462,7 +462,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (clean < 0)
 		return clean;
 
-	if (active_cache_changed &&
+	if (the_index.cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		/* TRANSLATORS: %s will be "revert", "cherry-pick" or
 		 * "rebase -i".
@@ -501,14 +501,15 @@ static int is_index_unchanged(void)
 	if (parse_commit(head_commit))
 		return -1;
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!the_index.cache_tree)
+		the_index.cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(active_cache_tree))
+	if (!cache_tree_fully_valid(the_index.cache_tree))
 		if (cache_tree_update(&the_index, 0))
 			return error(_("unable to update cache tree\n"));
 
-	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
+	return !hashcmp(the_index.cache_tree->sha1,
+			head_commit->tree->object.oid.hash);
 }
 
 static int write_author_script(const char *message)
diff --git a/sha1_name.c b/sha1_name.c
index 38473b1e6d..b73e261498 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1444,8 +1444,8 @@ static void diagnose_invalid_index_path(int stage,
 	pos = cache_name_pos(filename, namelen);
 	if (pos < 0)
 		pos = -pos - 1;
-	if (pos < active_nr) {
-		ce = active_cache[pos];
+	if (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos];
 		if (ce_namelen(ce) == namelen &&
 		    !memcmp(ce->name, filename, namelen))
 			die("Path '%s' is in the index, but not at stage %d.\n"
@@ -1460,8 +1460,8 @@ static void diagnose_invalid_index_path(int stage,
 	pos = cache_name_pos(fullname.buf, fullname.len);
 	if (pos < 0)
 		pos = -pos - 1;
-	if (pos < active_nr) {
-		ce = active_cache[pos];
+	if (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos];
 		if (ce_namelen(ce) == fullname.len &&
 		    !memcmp(ce->name, fullname.buf, fullname.len))
 			die("Path '%s' is in the index, but not '%s'.\n"
@@ -1551,13 +1551,13 @@ static int get_sha1_with_context_1(const char *name,
 
 		strlcpy(oc->path, cp, sizeof(oc->path));
 
-		if (!active_cache)
+		if (!the_index.cache)
 			read_index(&the_index);
 		pos = cache_name_pos(cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
-		while (pos < active_nr) {
-			ce = active_cache[pos];
+		while (pos < the_index.cache_nr) {
+			ce = the_index.cache[pos];
 			if (ce_namelen(ce) != namelen ||
 			    memcmp(ce->name, cp, namelen))
 				break;
diff --git a/submodule.c b/submodule.c
index 4d77291b11..b225ff6d1f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -182,16 +182,16 @@ void gitmodules_config(void)
 		pos = cache_name_pos(".gitmodules", 11);
 		if (pos < 0) { /* .gitmodules not found or isn't merged */
 			pos = -1 - pos;
-			if (active_nr > pos) {  /* there is a .gitmodules */
-				const struct cache_entry *ce = active_cache[pos];
+			if (the_index.cache_nr > pos) {  /* there is a .gitmodules */
+				const struct cache_entry *ce = the_index.cache[pos];
 				if (ce_namelen(ce) == 11 &&
 				    !memcmp(ce->name, ".gitmodules", 11))
 					gitmodules_is_unmerged = 1;
 			}
-		} else if (pos < active_nr) {
+		} else if (pos < the_index.cache_nr) {
 			struct stat st;
 			if (lstat(".gitmodules", &st) == 0 &&
-			    ce_match_stat(active_cache[pos], &st, 0) & DATA_CHANGED)
+			    ce_match_stat(the_index.cache[pos], &st, 0) & DATA_CHANGED)
 				gitmodules_is_modified = 1;
 		}
 
@@ -1038,11 +1038,11 @@ static int get_next_submodule(struct child_process *cp,
 	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
 
-	for (; spf->count < active_nr; spf->count++) {
+	for (; spf->count < the_index.cache_nr; spf->count++) {
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
-		const struct cache_entry *ce = active_cache[spf->count];
+		const struct cache_entry *ce = the_index.cache[spf->count];
 		const char *git_dir, *default_argv;
 		const struct submodule *submodule;
 
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index ed037a52f4..1ba09f86d6 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -64,5 +64,5 @@ int cmd_main(int ac, const char **av)
 	istate = the_index;
 	istate.cache_tree = another;
 	cache_tree_update(&istate, WRITE_TREE_DRY_RUN);
-	return dump_cache_tree(active_cache_tree, another, "");
+	return dump_cache_tree(the_index.cache_tree, another, "");
 }
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index b02a679166..1c640752cd 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -11,7 +11,7 @@ int cmd_main(int ac, const char **av)
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	if (read_index(&the_index) < 0)
 		die("unable to read index file");
-	active_cache_tree = NULL;
+	the_index.cache_tree = NULL;
 	if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		die("unable to write index file");
 	return 0;
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 32ac6e09bd..224d509f9f 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -74,7 +74,7 @@ test_expect_success '.lock files cleaned up' '
 	cd repo &&
 	git config core.worktree ../../worktree &&
 	# --refresh triggers late setup_work_tree,
-	# active_cache_changed is zero, rollback_lock_file fails
+	# the_index.cache_changed is zero, rollback_lock_file fails
 	git update-index --refresh &&
 	! test -f .git/index.lock
 	)
diff --git a/tree.c b/tree.c
index ce345c5511..82a6ae2a19 100644
--- a/tree.c
+++ b/tree.c
@@ -164,8 +164,8 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match)
 	 * do it the original slow way, otherwise, append and then
 	 * sort at the end.
 	 */
-	for (i = 0; !fn && i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; !fn && i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 		if (ce_stage(ce) == stage)
 			fn = read_one_entry;
 	}
@@ -179,8 +179,8 @@ int read_tree(struct tree *tree, int stage, struct pathspec *match)
 	/*
 	 * Sort the cache entry -- we need to nuke the cache tree, though.
 	 */
-	cache_tree_free(&active_cache_tree);
-	QSORT(active_cache, active_nr, cmp_cache_name_compare);
+	cache_tree_free(&the_index.cache_tree);
+	QSORT(the_index.cache, the_index.cache_nr, cmp_cache_name_compare);
 	return 0;
 }
 
diff --git a/wt-status.c b/wt-status.c
index 0375484962..750ed28b49 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -487,8 +487,8 @@ static int unmerged_mask(const char *path)
 
 	mask = 0;
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos++];
 		if (strcmp(ce->name, path) || !ce_stage(ce))
 			break;
 		mask |= (1 << (ce_stage(ce) - 1));
@@ -614,10 +614,10 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 {
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < the_index.cache_nr; i++) {
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = the_index.cache[i];
 
 		if (!ce_path_match(ce, &s->pathspec, NULL))
 			continue;
@@ -2099,8 +2099,8 @@ static void wt_porcelain_v2_print_unmerged_entry(
 	pos = cache_name_pos(it->string, strlen(it->string));
 	assert(pos < 0);
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos++];
 		stage = ce_stage(ce);
 		if (strcmp(ce->name, it->string) || !stage)
 			break;
-- 
2.13.0.rc1.39.ga6db8bfa24

