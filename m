Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F8E1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162519AbeBNTBL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:11 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:46937 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162506AbeBNTBH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:07 -0500
Received: by mail-oi0-f74.google.com with SMTP id 16so11379113oin.13
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=qKx8pZ5dPXPV1UAH/VPqR5iM0lyL74CTLqiqgVILd+8=;
        b=VOG79g89Woy0QMG0fedIvn9DgVa0l2M5obHSCnkVCDgKRbl8a6EiPjYu7N7F0NJXnm
         xJtiIuyQTqXjgZwlPr3EubIHyBeCId34AewJ64HBBF/RmszQ3IJX1KmOGg6ezLdbcUWb
         7NA5z9MZlT6EGeDInwXtWZYeSvfCtZODoPs+oxrpvqthm26c5EtYEGLqK4FhABUwLWeC
         YrZFLkztwjHH+FsJDjpnGEDJFi7bjQlcFwsgB3k27Ax1zTSanp+BqijXVlhWAeAQ5jeb
         3i5XXeV2MbDNj6TVEsSrApr+iPmykY5AkIACV85nfafNBYkJebkWVJKjTCSsSUumcn5I
         jjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=qKx8pZ5dPXPV1UAH/VPqR5iM0lyL74CTLqiqgVILd+8=;
        b=pIkWUokL6k5fsBIL5mw8QZJ6ggdrMTJjpLODMiTlHxRgv/n7VBVQP49NN509tXjsKn
         Sq8axzY4fQa1I/NwSVwZN71TpD1OzE09KI2g9eH4Go2J9r2MNdo/6z1BlDy95ASStuoW
         Hlauo8iSsVyaCPBDzRpbyeoDv/k+XMUZeCikJnFX6anMp+f5C2LXWJ3bmNXDbMksCgqp
         IlS2bh9psWGfGIsMMr8c7gdqVDaF2zKIiWAbltKRMQyRSWNnabri3JdzQzHvvENVRKnT
         nRSnqIT1iPkPwU/KTD6/p9QnaIewA3S7el4AVLLNhMfEJikeoqL0J7UAXxSikphnJwQF
         d3tg==
X-Gm-Message-State: APf1xPCF5PA2ZyrElsOkei4mWB9XRf+j0FN151K2r9RN+BeIvb+/L/q9
        TUi2/Ef/4vM03kfJN11KrikAqB6DKnhibWMGg1eszQj8Doj1tTWuq2iM39z84i+HlcgHRCnfUXu
        uZvGWKyYPn/Zv4n7jxxfZ5jFXxTC9bbOpdlfFMadClDrJfhwGVT15rEu8gw==
X-Google-Smtp-Source: AH8x225N6NCjcZu73muQuWLSZKX7jyENYvmA/+0cqBLI2rp5ZLe1sXSN8X8TfEXx2fJoBLcb7KIpRfr38J0=
MIME-Version: 1.0
X-Received: by 10.202.67.7 with SMTP id q7mr29829oia.49.1518634866809; Wed, 14
 Feb 2018 11:01:06 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:31 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-10-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 09/37] checkout: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/checkout.c | 196 ++++++++++++++++++++++-----------------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c54c78df5..ed3d655f2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -54,14 +54,14 @@ struct checkout_opts {
 	struct tree *source_tree;
 };
 
-static int post_checkout_hook(struct commit *old, struct commit *new,
+static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
 	return run_hook_le(NULL, "post-checkout",
-			   oid_to_hex(old ? &old->object.oid : &null_oid),
-			   oid_to_hex(new ? &new->object.oid : &null_oid),
+			   oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
+			   oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
 			   changed ? "1" : "0", NULL);
-	/* "new" can be NULL when checking out from the index before
+	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
 
 }
@@ -472,8 +472,8 @@ static void setup_branch_path(struct branch_info *branch)
 }
 
 static int merge_working_tree(const struct checkout_opts *opts,
-			      struct branch_info *old,
-			      struct branch_info *new,
+			      struct branch_info *old_branch_info,
+			      struct branch_info *new_branch_info,
 			      int *writeout_error)
 {
 	int ret;
@@ -485,7 +485,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 	resolve_undo_clear();
 	if (opts->force) {
-		ret = reset_tree(new->commit->tree, opts, 1, writeout_error);
+		ret = reset_tree(new_branch_info->commit->tree, opts, 1, writeout_error);
 		if (ret)
 			return ret;
 	} else {
@@ -511,7 +511,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.initial_checkout = is_cache_unborn();
 		topts.update = 1;
 		topts.merge = 1;
-		topts.gently = opts->merge && old->commit;
+		topts.gently = opts->merge && old_branch_info->commit;
 		topts.verbose_update = opts->show_progress;
 		topts.fn = twoway_merge;
 		if (opts->overwrite_ignore) {
@@ -519,11 +519,11 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			topts.dir->flags |= DIR_SHOW_IGNORED;
 			setup_standard_excludes(topts.dir);
 		}
-		tree = parse_tree_indirect(old->commit ?
-					   &old->commit->object.oid :
+		tree = parse_tree_indirect(old_branch_info->commit ?
+					   &old_branch_info->commit->object.oid :
 					   the_hash_algo->empty_tree);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
-		tree = parse_tree_indirect(&new->commit->object.oid);
+		tree = parse_tree_indirect(&new_branch_info->commit->object.oid);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
@@ -540,10 +540,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				return 1;
 
 			/*
-			 * Without old->commit, the below is the same as
+			 * Without old_branch_info->commit, the below is the same as
 			 * the two-tree unpack we already tried and failed.
 			 */
-			if (!old->commit)
+			if (!old_branch_info->commit)
 				return 1;
 
 			/* Do more real merge */
@@ -571,18 +571,18 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
-			ret = reset_tree(new->commit->tree, opts, 1,
+			ret = reset_tree(new_branch_info->commit->tree, opts, 1,
 					 writeout_error);
 			if (ret)
 				return ret;
-			o.ancestor = old->name;
-			o.branch1 = new->name;
+			o.ancestor = old_branch_info->name;
+			o.branch1 = new_branch_info->name;
 			o.branch2 = "local";
-			ret = merge_trees(&o, new->commit->tree, work,
-				old->commit->tree, &result);
+			ret = merge_trees(&o, new_branch_info->commit->tree, work,
+				old_branch_info->commit->tree, &result);
 			if (ret < 0)
 				exit(128);
-			ret = reset_tree(new->commit->tree, opts, 0,
+			ret = reset_tree(new_branch_info->commit->tree, opts, 0,
 					 writeout_error);
 			strbuf_release(&o.obuf);
 			if (ret)
@@ -600,15 +600,15 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		die(_("unable to write new index file"));
 
 	if (!opts->force && !opts->quiet)
-		show_local_changes(&new->commit->object, &opts->diff_options);
+		show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
 
 	return 0;
 }
 
-static void report_tracking(struct branch_info *new)
+static void report_tracking(struct branch_info *new_branch_info)
 {
 	struct strbuf sb = STRBUF_INIT;
-	struct branch *branch = branch_get(new->name);
+	struct branch *branch = branch_get(new_branch_info->name);
 
 	if (!format_tracking_info(branch, &sb))
 		return;
@@ -617,8 +617,8 @@ static void report_tracking(struct branch_info *new)
 }
 
 static void update_refs_for_switch(const struct checkout_opts *opts,
-				   struct branch_info *old,
-				   struct branch_info *new)
+				   struct branch_info *old_branch_info,
+				   struct branch_info *new_branch_info)
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc, *reflog_msg;
@@ -645,69 +645,69 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			free(refname);
 		}
 		else
-			create_branch(opts->new_branch, new->name,
+			create_branch(opts->new_branch, new_branch_info->name,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log,
 				      opts->quiet,
 				      opts->track);
-		new->name = opts->new_branch;
-		setup_branch_path(new);
+		new_branch_info->name = opts->new_branch;
+		setup_branch_path(new_branch_info);
 	}
 
-	old_desc = old->name;
-	if (!old_desc && old->commit)
-		old_desc = oid_to_hex(&old->commit->object.oid);
+	old_desc = old_branch_info->name;
+	if (!old_desc && old_branch_info->commit)
+		old_desc = oid_to_hex(&old_branch_info->commit->object.oid);
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (!reflog_msg)
 		strbuf_addf(&msg, "checkout: moving from %s to %s",
-			old_desc ? old_desc : "(invalid)", new->name);
+			old_desc ? old_desc : "(invalid)", new_branch_info->name);
 	else
 		strbuf_insert(&msg, 0, reflog_msg, strlen(reflog_msg));
 
-	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
+	if (!strcmp(new_branch_info->name, "HEAD") && !new_branch_info->path && !opts->force_detach) {
 		/* Nothing to do. */
-	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
-		update_ref(msg.buf, "HEAD", &new->commit->object.oid, NULL,
+	} else if (opts->force_detach || !new_branch_info->path) {	/* No longer on any branch. */
+		update_ref(msg.buf, "HEAD", &new_branch_info->commit->object.oid, NULL,
 			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
-			if (old->path &&
+			if (old_branch_info->path &&
 			    advice_detached_head && !opts->force_detach)
-				detach_advice(new->name);
-			describe_detached_head(_("HEAD is now at"), new->commit);
+				detach_advice(new_branch_info->name);
+			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
-	} else if (new->path) {	/* Switch branches. */
-		if (create_symref("HEAD", new->path, msg.buf) < 0)
+	} else if (new_branch_info->path) {	/* Switch branches. */
+		if (create_symref("HEAD", new_branch_info->path, msg.buf) < 0)
 			die(_("unable to update HEAD"));
 		if (!opts->quiet) {
-			if (old->path && !strcmp(new->path, old->path)) {
+			if (old_branch_info->path && !strcmp(new_branch_info->path, old_branch_info->path)) {
 				if (opts->new_branch_force)
 					fprintf(stderr, _("Reset branch '%s'\n"),
-						new->name);
+						new_branch_info->name);
 				else
 					fprintf(stderr, _("Already on '%s'\n"),
-						new->name);
+						new_branch_info->name);
 			} else if (opts->new_branch) {
 				if (opts->branch_exists)
-					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new->name);
+					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new_branch_info->name);
 				else
-					fprintf(stderr, _("Switched to a new branch '%s'\n"), new->name);
+					fprintf(stderr, _("Switched to a new branch '%s'\n"), new_branch_info->name);
 			} else {
 				fprintf(stderr, _("Switched to branch '%s'\n"),
-					new->name);
+					new_branch_info->name);
 			}
 		}
-		if (old->path && old->name) {
-			if (!ref_exists(old->path) && reflog_exists(old->path))
-				delete_reflog(old->path);
+		if (old_branch_info->path && old_branch_info->name) {
+			if (!ref_exists(old_branch_info->path) && reflog_exists(old_branch_info->path))
+				delete_reflog(old_branch_info->path);
 		}
 	}
 	remove_branch_state();
 	strbuf_release(&msg);
 	if (!opts->quiet &&
-	    (new->path || (!opts->force_detach && !strcmp(new->name, "HEAD"))))
-		report_tracking(new);
+	    (new_branch_info->path || (!opts->force_detach && !strcmp(new_branch_info->name, "HEAD"))))
+		report_tracking(new_branch_info);
 }
 
 static int add_pending_uninteresting_ref(const char *refname,
@@ -787,10 +787,10 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
  * HEAD.  If it is not reachable from any ref, this is the last chance
  * for the user to do so without resorting to reflog.
  */
-static void orphaned_commit_warning(struct commit *old, struct commit *new)
+static void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit)
 {
 	struct rev_info revs;
-	struct object *object = &old->object;
+	struct object *object = &old_commit->object;
 
 	init_revisions(&revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
@@ -799,57 +799,57 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	add_pending_object(&revs, object, oid_to_hex(&object->oid));
 
 	for_each_ref(add_pending_uninteresting_ref, &revs);
-	add_pending_oid(&revs, "HEAD", &new->object.oid, UNINTERESTING);
+	add_pending_oid(&revs, "HEAD", &new_commit->object.oid, UNINTERESTING);
 
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
-	if (!(old->object.flags & UNINTERESTING))
-		suggest_reattach(old, &revs);
+	if (!(old_commit->object.flags & UNINTERESTING))
+		suggest_reattach(old_commit, &revs);
 	else
-		describe_detached_head(_("Previous HEAD position was"), old);
+		describe_detached_head(_("Previous HEAD position was"), old_commit);
 
 	/* Clean up objects used, as they will be reused. */
 	clear_commit_marks_all(ALL_REV_FLAGS);
 }
 
 static int switch_branches(const struct checkout_opts *opts,
-			   struct branch_info *new)
+			   struct branch_info *new_branch_info)
 {
 	int ret = 0;
-	struct branch_info old;
+	struct branch_info old_branch_info;
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
-	memset(&old, 0, sizeof(old));
-	old.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
-	if (old.path)
-		old.commit = lookup_commit_reference_gently(&rev, 1);
+	memset(&old_branch_info, 0, sizeof(old_branch_info));
+	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
+	if (old_branch_info.path)
+		old_branch_info.commit = lookup_commit_reference_gently(&rev, 1);
 	if (!(flag & REF_ISSYMREF))
-		old.path = NULL;
+		old_branch_info.path = NULL;
 
-	if (old.path)
-		skip_prefix(old.path, "refs/heads/", &old.name);
+	if (old_branch_info.path)
+		skip_prefix(old_branch_info.path, "refs/heads/", &old_branch_info.name);
 
-	if (!new->name) {
-		new->name = "HEAD";
-		new->commit = old.commit;
-		if (!new->commit)
+	if (!new_branch_info->name) {
+		new_branch_info->name = "HEAD";
+		new_branch_info->commit = old_branch_info.commit;
+		if (!new_branch_info->commit)
 			die(_("You are on a branch yet to be born"));
-		parse_commit_or_die(new->commit);
+		parse_commit_or_die(new_branch_info->commit);
 	}
 
-	ret = merge_working_tree(opts, &old, new, &writeout_error);
+	ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 	if (ret) {
 		free(path_to_free);
 		return ret;
 	}
 
-	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
-		orphaned_commit_warning(old.commit, new->commit);
+	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
+		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
 
-	update_refs_for_switch(opts, &old, new);
+	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
-	ret = post_checkout_hook(old.commit, new->commit, 1);
+	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
 	free(path_to_free);
 	return ret || writeout_error;
 }
@@ -870,7 +870,7 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
-				struct branch_info *new,
+				struct branch_info *new_branch_info,
 				struct checkout_opts *opts,
 				struct object_id *rev)
 {
@@ -988,22 +988,22 @@ static int parse_branchname_arg(int argc, const char **argv,
 	argv++;
 	argc--;
 
-	new->name = arg;
-	setup_branch_path(new);
+	new_branch_info->name = arg;
+	setup_branch_path(new_branch_info);
 
-	if (!check_refname_format(new->path, 0) &&
-	    !read_ref(new->path, &branch_rev))
+	if (!check_refname_format(new_branch_info->path, 0) &&
+	    !read_ref(new_branch_info->path, &branch_rev))
 		oidcpy(rev, &branch_rev);
 	else
-		new->path = NULL; /* not an existing branch */
+		new_branch_info->path = NULL; /* not an existing branch */
 
-	new->commit = lookup_commit_reference_gently(rev, 1);
-	if (!new->commit) {
+	new_branch_info->commit = lookup_commit_reference_gently(rev, 1);
+	if (!new_branch_info->commit) {
 		/* not a commit */
 		*source_tree = parse_tree_indirect(rev);
 	} else {
-		parse_commit_or_die(new->commit);
-		*source_tree = new->commit->tree;
+		parse_commit_or_die(new_branch_info->commit);
+		*source_tree = new_branch_info->commit->tree;
 	}
 
 	if (!*source_tree)                   /* case (1): want a tree */
@@ -1043,7 +1043,7 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 }
 
 static int checkout_branch(struct checkout_opts *opts,
-			   struct branch_info *new)
+			   struct branch_info *new_branch_info)
 {
 	if (opts->pathspec.nr)
 		die(_("paths cannot be used with switching branches"));
@@ -1072,21 +1072,21 @@ static int checkout_branch(struct checkout_opts *opts,
 	} else if (opts->track == BRANCH_TRACK_UNSPECIFIED)
 		opts->track = git_branch_track;
 
-	if (new->name && !new->commit)
+	if (new_branch_info->name && !new_branch_info->commit)
 		die(_("Cannot switch branch to a non-commit '%s'"),
-		    new->name);
+		    new_branch_info->name);
 
-	if (new->path && !opts->force_detach && !opts->new_branch &&
+	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
 		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
 		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
-			die_if_checked_out(new->path, 1);
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
+			die_if_checked_out(new_branch_info->path, 1);
 		free(head_ref);
 	}
 
-	if (!new->commit && opts->new_branch) {
+	if (!new_branch_info->commit && opts->new_branch) {
 		struct object_id rev;
 		int flag;
 
@@ -1094,13 +1094,13 @@ static int checkout_branch(struct checkout_opts *opts,
 		    (flag & REF_ISSYMREF) && is_null_oid(&rev))
 			return switch_unborn_to_new_branch(opts);
 	}
-	return switch_branches(opts, new);
+	return switch_branches(opts, new_branch_info);
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	struct branch_info new;
+	struct branch_info new_branch_info;
 	char *conflict_style = NULL;
 	int dwim_new_local_branch = 1;
 	struct option options[] = {
@@ -1138,7 +1138,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	};
 
 	memset(&opts, 0, sizeof(opts));
-	memset(&new, 0, sizeof(new));
+	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts.overwrite_ignore = 1;
 	opts.prefix = prefix;
 	opts.show_progress = -1;
@@ -1210,7 +1210,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts.new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new, &opts, &rev);
+					     &new_branch_info, &opts, &rev);
 		argv += n;
 		argc -= n;
 	}
@@ -1253,7 +1253,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	UNLEAK(opts);
 	if (opts.patch_mode || opts.pathspec.nr)
-		return checkout_paths(&opts, new.name);
+		return checkout_paths(&opts, new_branch_info.name);
 	else
-		return checkout_branch(&opts, &new);
+		return checkout_branch(&opts, &new_branch_info);
 }
-- 
2.16.1.291.g4437f3f132-goog

