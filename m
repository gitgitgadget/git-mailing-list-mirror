Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F081F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeA2WiI (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:08 -0500
Received: from mail-qk0-f201.google.com ([209.85.220.201]:38831 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeA2WiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:03 -0500
Received: by mail-qk0-f201.google.com with SMTP id w200so5460580qkb.5
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=b2clzQ2xX309r/OwqvKkPT5m4xocf1TlEm2aiS5Ni44=;
        b=p7k8xhv9RQ406jO/ITo//PADKOvT9VPbOr8uZ5Li/Wzj6os+Kl72NU/L0k5jMglyMm
         uYK9dpFIH8QPLlcYbh0RM/hPKwApyZWLlF9vSUeCjjgFUHr80sp1nQFspf1Stj7+XjeA
         XTAcIz3klfTWIrJXuYWpH7YVWxGCuYa5i6Fe8QqGcQl44tik8bZoAqfW3jaUJdZ/WLbT
         E+JJ1oiXsUrxsJkbD4jHapmwQ/FY5conPEANhnYttO+eQr88hlnt9a6EAlLCLFFS5SdN
         6hSE76wg9O4xJSD/eHzWfDWMMGjcqiQU77dKeHJvp/+TeWgMlNSN4fVxpy3F4rO4tb3w
         kz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=b2clzQ2xX309r/OwqvKkPT5m4xocf1TlEm2aiS5Ni44=;
        b=mS9kpqPz8K7Lv4N5msx2HUJGDaeu2QS5ub5urhGxO5me1h246+qknasHurKKM3/sQc
         k2ggQ5uVBllgSZwpYrWsRoLdhyqa8hlOQTm4W1f90hoLdxUInk9A7otPXAFm354inlLA
         jR0H+jM3nPwO6Sy8fK+y9FMSvfrALZentQihMgBpzdVjkZOmKKrIYyvTJEmLQQLFTU0z
         DkNl6oKK2kb+Q7pTJi0Z20zudC/2IwgRASAq0NJTsGmAckd+0XGf8CFA/UzWAK5dZDiH
         pw12x4F8wZy8mzgHP+aCk1nlCUgn7sJcefL3ss6h6oF9A/mGGO4F0nlWtKraeqVHEbVr
         b6qQ==
X-Gm-Message-State: AKwxytfzeCD4tug64omWbqqYUdC87Z4Tgo3ANBv2meDoEIaYIHvDYjze
        /h7fUWGK1ELaXtVsjtx5VQ8IK3P1sMBKYnsrdUNNrOAbuPMYZcS5bCVQJBZRiE7sLGyK8TZVKCr
        60ZloQ5RYOllSyLU8/dReDZswKmT+w9gdN6r9ixh6hrCzQVv/zh/SbAuBgg==
X-Google-Smtp-Source: AH8x224Q/DvQ8AHB0DxkNkPngdQfMQRyW4Bth3opcbzJlEnXXF0iW2lpOf/v8TMSBy5GECTZQF+5rELKt5Q=
MIME-Version: 1.0
X-Received: by 10.200.56.45 with SMTP id q42mr17511387qtb.26.1517265482372;
 Mon, 29 Jan 2018 14:38:02 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:00 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-10-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 09/37] checkout: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/checkout.c | 138 ++++++++++++++++++++++++++---------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c54c78df5..30f09ec50 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -54,14 +54,14 @@ struct checkout_opts {
 	struct tree *source_tree;
 };
 
-static int post_checkout_hook(struct commit *old, struct commit *new,
+static int post_checkout_hook(struct commit *old, struct commit *new_commit,
 			      int changed)
 {
 	return run_hook_le(NULL, "post-checkout",
 			   oid_to_hex(old ? &old->object.oid : &null_oid),
-			   oid_to_hex(new ? &new->object.oid : &null_oid),
+			   oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
 			   changed ? "1" : "0", NULL);
-	/* "new" can be NULL when checking out from the index before
+	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
 
 }
@@ -473,7 +473,7 @@ static void setup_branch_path(struct branch_info *branch)
 
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old,
-			      struct branch_info *new,
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
@@ -523,7 +523,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					   &old->commit->object.oid :
 					   the_hash_algo->empty_tree);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
-		tree = parse_tree_indirect(&new->commit->object.oid);
+		tree = parse_tree_indirect(&new_branch_info->commit->object.oid);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
 
 		ret = unpack_trees(2, trees, &topts);
@@ -571,18 +571,18 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
-			ret = reset_tree(new->commit->tree, opts, 1,
+			ret = reset_tree(new_branch_info->commit->tree, opts, 1,
 					 writeout_error);
 			if (ret)
 				return ret;
 			o.ancestor = old->name;
-			o.branch1 = new->name;
+			o.branch1 = new_branch_info->name;
 			o.branch2 = "local";
-			ret = merge_trees(&o, new->commit->tree, work,
+			ret = merge_trees(&o, new_branch_info->commit->tree, work,
 				old->commit->tree, &result);
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
@@ -618,7 +618,7 @@ static void report_tracking(struct branch_info *new)
 
 static void update_refs_for_switch(const struct checkout_opts *opts,
 				   struct branch_info *old,
-				   struct branch_info *new)
+				   struct branch_info *new_branch_info)
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc, *reflog_msg;
@@ -645,14 +645,14 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
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
 
 	old_desc = old->name;
@@ -662,40 +662,40 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
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
 			if (old->path &&
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
+			if (old->path && !strcmp(new_branch_info->path, old->path)) {
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
 		if (old->path && old->name) {
@@ -706,8 +706,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	remove_branch_state();
 	strbuf_release(&msg);
 	if (!opts->quiet &&
-	    (new->path || (!opts->force_detach && !strcmp(new->name, "HEAD"))))
-		report_tracking(new);
+	    (new_branch_info->path || (!opts->force_detach && !strcmp(new_branch_info->name, "HEAD"))))
+		report_tracking(new_branch_info);
 }
 
 static int add_pending_uninteresting_ref(const char *refname,
@@ -787,7 +787,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
  * HEAD.  If it is not reachable from any ref, this is the last chance
  * for the user to do so without resorting to reflog.
  */
-static void orphaned_commit_warning(struct commit *old, struct commit *new)
+static void orphaned_commit_warning(struct commit *old, struct commit *new_commit)
 {
 	struct rev_info revs;
 	struct object *object = &old->object;
@@ -799,7 +799,7 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	add_pending_object(&revs, object, oid_to_hex(&object->oid));
 
 	for_each_ref(add_pending_uninteresting_ref, &revs);
-	add_pending_oid(&revs, "HEAD", &new->object.oid, UNINTERESTING);
+	add_pending_oid(&revs, "HEAD", &new_commit->object.oid, UNINTERESTING);
 
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
@@ -813,7 +813,7 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 }
 
 static int switch_branches(const struct checkout_opts *opts,
-			   struct branch_info *new)
+			   struct branch_info *new_branch_info)
 {
 	int ret = 0;
 	struct branch_info old;
@@ -830,26 +830,26 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (old.path)
 		skip_prefix(old.path, "refs/heads/", &old.name);
 
-	if (!new->name) {
-		new->name = "HEAD";
-		new->commit = old.commit;
-		if (!new->commit)
+	if (!new_branch_info->name) {
+		new_branch_info->name = "HEAD";
+		new_branch_info->commit = old.commit;
+		if (!new_branch_info->commit)
 			die(_("You are on a branch yet to be born"));
-		parse_commit_or_die(new->commit);
+		parse_commit_or_die(new_branch_info->commit);
 	}
 
-	ret = merge_working_tree(opts, &old, new, &writeout_error);
+	ret = merge_working_tree(opts, &old, new_branch_info, &writeout_error);
 	if (ret) {
 		free(path_to_free);
 		return ret;
 	}
 
-	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
-		orphaned_commit_warning(old.commit, new->commit);
+	if (!opts->quiet && !old.path && old.commit && new_branch_info->commit != old.commit)
+		orphaned_commit_warning(old.commit, new_branch_info->commit);
 
-	update_refs_for_switch(opts, &old, new);
+	update_refs_for_switch(opts, &old, new_branch_info);
 
-	ret = post_checkout_hook(old.commit, new->commit, 1);
+	ret = post_checkout_hook(old.commit, new_branch_info->commit, 1);
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
2.16.0.rc1.238.g530d649a79-goog

