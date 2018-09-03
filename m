Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F1D1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeICWcC (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:32:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33101 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbeICWcC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:32:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id m26-v6so1058135lfb.0
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLuudLyUCBBpfVLi2cVXJ9VsvQICp41jC4p1g60+Wu4=;
        b=V1sQxTD0bmG2UMbVgR56jlEYeLAm/JDDNIPF4wzUF1y1QHz4F8IN/w3ZA4eg/5U46S
         LhIElBowPN59LvR6GbuXyABogO4PDoa5zmq2Wm36ILF3G59mbZQQPFxGrGlp0PtMJsAV
         Bi6WzFCZo8rivBWMY9q7nkNL6IxNby70z+E3Lulcpphzjj3UkeqAF3dJWnll8by+Pvk0
         4P1vnwKjLOWebdBfYAQLkC2Q08vmSDsghBrUcYyDqfHbve/jAsBJLniN1A4zz0ZZjkst
         cJRqtzAZGM6OMEMjSL2s17wHp08zdeRJmhg1347v4Mi/lmDzFSiOjo2mOZyUmFllIIiF
         t9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLuudLyUCBBpfVLi2cVXJ9VsvQICp41jC4p1g60+Wu4=;
        b=NJNhQvIox3To4XvuQcffbD3MY5IyRJ0j8vxxWKjcRTuMsSc34kyB60KTDRGfeHk926
         91m7AIT7hfG7DxtdMmZycDSu2/tciVQfmmkpDl/dVjc5YITevR1CTF5KNoaIuTdffSk3
         1VLDAtUBh1oHgO+MIIjq9AN0kUIz0a/PnZPorvGCENJnY7olF5hedU5d+boYyWuKjESJ
         oQMpsiCDTGl7pMj7QrsyaxWCroRohmLJTSpX+tf0Dd04eHtRdRqKqFG/n9yQnZAH6JIS
         4jnFjtjOOFJ7OkylKyJF4D00d/MX+MYOt1hUuXmIIeTNri3smfFfXq8STo8IV+tU+Gq2
         18MQ==
X-Gm-Message-State: APzg51CkcjgijvN8Fh+Ybi5SHpKJlb769WJK7hrqLCDW6Cw3Vr40T+t4
        Nw7HEgmHbnYNHH1LfYPWINgdeqmd
X-Google-Smtp-Source: ANB0VdbEbrv7VFU4cUnvdBxLHx25lyV1NqMYXod+h0Ak+azAhnic4gCb29hJDapuOi9F1LiAjaapNw==
X-Received: by 2002:a19:7706:: with SMTP id s6-v6mr17784181lfc.84.1535998238624;
        Mon, 03 Sep 2018 11:10:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 24/24] Rename functions to avoid breaking in-flight topics
Date:   Mon,  3 Sep 2018 20:09:32 +0200
Message-Id: <20180903180932.32260-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The three functions init_revisions(), diff_setup() and rerere() are
prefixed temporarily with repo_ to avoid breaking other topics which
add new call sites for these functions. This is a temporary
measure. Once everything is merged, it will be reverted and the new
call sites fixed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c                          |  2 +-
 bisect.c                         |  4 ++--
 blame.c                          |  6 +++---
 builtin/add.c                    |  4 ++--
 builtin/am.c                     | 10 +++++-----
 builtin/blame.c                  |  2 +-
 builtin/checkout.c               |  4 ++--
 builtin/commit.c                 |  4 ++--
 builtin/describe.c               |  4 ++--
 builtin/diff-files.c             |  2 +-
 builtin/diff-index.c             |  2 +-
 builtin/diff-tree.c              |  2 +-
 builtin/diff.c                   |  2 +-
 builtin/fast-export.c            |  2 +-
 builtin/fmt-merge-msg.c          |  2 +-
 builtin/log.c                    | 18 +++++++++---------
 builtin/merge.c                  |  8 ++++----
 builtin/pack-objects.c           |  2 +-
 builtin/prune.c                  |  2 +-
 builtin/range-diff.c             |  2 +-
 builtin/reflog.c                 |  2 +-
 builtin/rerere.c                 |  2 +-
 builtin/rev-list.c               |  2 +-
 builtin/revert.c                 |  2 +-
 builtin/shortlog.c               |  2 +-
 builtin/submodule--helper.c      |  2 +-
 bundle.c                         |  4 ++--
 diff-lib.c                       |  4 ++--
 diff-no-index.c                  |  2 +-
 diff.c                           |  2 +-
 diff.h                           |  3 ++-
 http-push.c                      |  2 +-
 merge-recursive.c                |  4 ++--
 notes-merge.c                    |  4 ++--
 pack-bitmap-write.c              |  2 +-
 patch-ids.c                      |  2 +-
 read-cache.c                     |  2 +-
 ref-filter.c                     |  2 +-
 remote.c                         |  2 +-
 rerere.c                         |  2 +-
 rerere.h                         |  3 ++-
 revision.c                       |  4 ++--
 revision.h                       |  3 ++-
 sequencer.c                      | 12 ++++++------
 shallow.c                        |  2 +-
 submodule.c                      |  6 +++---
 t/helper/test-revision-walking.c |  2 +-
 tree-diff.c                      |  2 +-
 wt-status.c                      | 10 +++++-----
 49 files changed, 90 insertions(+), 87 deletions(-)

diff --git a/apply.c b/apply.c
index fc52993548..fdae1d423b 100644
--- a/apply.c
+++ b/apply.c
@@ -4632,7 +4632,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		}
 		string_list_clear(&cpath, 0);
 
-		rerere(state->repo, 0);
+		repo_rerere(state->repo, 0);
 	}
 
 	return errs;
diff --git a/bisect.c b/bisect.c
index e19c60829c..560493acd2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -632,7 +632,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	struct argv_array rev_argv = ARGV_ARRAY_INIT;
 	int i;
 
-	init_revisions(revs, the_repository, prefix);
+	repo_init_revisions(revs, the_repository, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
@@ -889,7 +889,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	struct rev_info opt;
 
 	/* diff-tree init */
-	init_revisions(&opt, the_repository, prefix);
+	repo_init_revisions(&opt, the_repository, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt.abbrev = 0;
 	opt.diff = 1;
diff --git a/blame.c b/blame.c
index 8dbd436e95..39fbd796c0 100644
--- a/blame.c
+++ b/blame.c
@@ -563,7 +563,7 @@ static struct blame_origin *find_origin(struct repository *r,
 	 * and origin first.  Most of the time they are the
 	 * same and diff-tree is fairly efficient about this.
 	 */
-	diff_setup(&diff_opts, r);
+	repo_diff_setup(&diff_opts, r);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -638,7 +638,7 @@ static struct blame_origin *find_rename(struct repository *r,
 	struct diff_options diff_opts;
 	int i;
 
-	diff_setup(&diff_opts, r);
+	repo_diff_setup(&diff_opts, r);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -1262,7 +1262,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	diff_setup(&diff_opts, sb->repo);
+	repo_diff_setup(&diff_opts, sb->repo);
 	diff_opts.flags.recursive = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 
diff --git a/builtin/add.c b/builtin/add.c
index 26e9cba9b6..c8f99083fc 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -110,7 +110,7 @@ int add_files_to_cache(const char *prefix,
 	memset(&data, 0, sizeof(data));
 	data.flags = flags;
 
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	if (pathspec)
 		copy_pathspec(&rev.prune_data, pathspec);
@@ -232,7 +232,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("Could not read the index"));
 
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	rev.diffopt.context = 7;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/builtin/am.c b/builtin/am.c
index 6f0990ad59..70afd6c15a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1372,7 +1372,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	FILE *fp;
 
 	fp = xfopen(am_path(state, "patch"), "w");
-	init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(&rev_info, the_repository, NULL);
 	rev_info.diff = 1;
 	rev_info.abbrev = 0;
 	rev_info.disable_stdin = 1;
@@ -1407,7 +1407,7 @@ static void write_index_patch(const struct am_state *state)
 				   the_repository->hash_algo->empty_tree);
 
 	fp = xfopen(am_path(state, "patch"), "w");
-	init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(&rev_info, the_repository, NULL);
 	rev_info.diff = 1;
 	rev_info.disable_stdin = 1;
 	rev_info.no_commit_id = 1;
@@ -1565,7 +1565,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		struct rev_info rev_info;
 		const char *diff_filter_str = "--diff-filter=AM";
 
-		init_revisions(&rev_info, the_repository, NULL);
+		repo_init_revisions(&rev_info, the_repository, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
 		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
 		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
@@ -1603,7 +1603,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		o.verbosity = 0;
 
 	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
-		rerere(the_repository, state->allow_rerere_autoupdate);
+		repo_rerere(the_repository, state->allow_rerere_autoupdate);
 		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
@@ -1898,7 +1898,7 @@ static void am_resolve(struct am_state *state)
 			goto next;
 	}
 
-	rerere(the_repository, 0);
+	repo_rerere(the_repository, 0);
 
 	do_commit(state);
 
diff --git a/builtin/blame.c b/builtin/blame.c
index b6ece2c3f5..20a5f15999 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -830,7 +830,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	revs.date_mode = blame_date_mode;
 	revs.diffopt.flags.allow_textconv = 1;
 	revs.diffopt.flags.follow_renames = 1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2563f8e1c3..be8f1b23dc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -392,7 +392,7 @@ static void show_local_changes(struct object *head,
 {
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
-	init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(&rev, the_repository, NULL);
 	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
 	diff_setup_done(&rev.diffopt);
@@ -801,7 +801,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	struct rev_info revs;
 	struct object *object = &old_commit->object;
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
 
 	object->flags &= ~UNINTERESTING;
diff --git a/builtin/commit.c b/builtin/commit.c
index cc06b5837c..84e49a33be 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -980,7 +980,7 @@ static const char *find_author_by_nickname(const char *name)
 	const char *av[20];
 	int ac = 0;
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	strbuf_addf(&buf, "--author=%s", name);
 	av[++ac] = "--all";
 	av[++ac] = "-i";
@@ -1651,7 +1651,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "new_index file. Check that disk is not full and quota is\n"
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
-	rerere(the_repository, 0);
+	repo_rerere(the_repository, 0);
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
diff --git a/builtin/describe.c b/builtin/describe.c
index 4d723665c7..bf116db7a0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -488,7 +488,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 		"--objects", "--in-commit-order", "--reverse", "HEAD",
 		NULL);
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
 		BUG("setup_revisions could not handle all args?");
 
@@ -636,7 +636,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			if (0 <= fd)
 				update_index_if_able(&the_index, &index_lock);
 
-			init_revisions(&revs, the_repository, prefix);
+			repo_init_revisions(&revs, the_repository, prefix);
 			argv_array_pushv(&args, diff_index_args);
 			if (setup_revisions(args.argc, args.argv, &revs, NULL) != 1)
 				BUG("malformed internal diff-index command line");
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 0217e9e2bf..d24c4176ac 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -25,7 +25,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		usage(diff_files_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 2c30c5adad..4151676fdd 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -22,7 +22,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index e1ebbb8b14..c398dd9631 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -110,7 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		usage(diff_tree_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	init_revisions(opt, the_repository, prefix);
+	repo_init_revisions(opt, the_repository, prefix);
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 	opt->abbrev = 0;
diff --git a/builtin/diff.c b/builtin/diff.c
index 0313dde133..948f0b04bc 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -318,7 +318,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	precompose_argv(argc, argv);
 
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 
 	if (no_index && argc != i + 2) {
 		if (no_index == DIFF_NO_INDEX_IMPLICIT) {
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 5034b995ba..b2c34aa06b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1033,7 +1033,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
 
-	init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(&revs, the_repository, prefix);
 	init_revision_sources(&revision_sources);
 	revs.topo_order = 1;
 	revs.sources = &revision_sources;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e2a01861d6..34bb948635 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -642,7 +642,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		struct rev_info rev;
 
 		head = lookup_commit_or_die(&head_oid, "HEAD");
-		init_revisions(&rev, the_repository, NULL);
+		repo_init_revisions(&rev, the_repository, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.ignore_merges = 1;
 		rev.limited = 1;
diff --git a/builtin/log.c b/builtin/log.c
index d9d1c22983..fd4741a4de 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -467,7 +467,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
 	memset(&opt, 0, sizeof(opt));
@@ -585,7 +585,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	git_config(git_log_config, NULL);
 
 	memset(&match_all, 0, sizeof(match_all));
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	rev.diff = 1;
 	rev.always_show_header = 1;
 	rev.no_walk = REVISION_WALK_NO_WALK_SORTED;
@@ -665,7 +665,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	init_reflog_walk(&rev.reflog_info);
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
@@ -704,7 +704,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
@@ -917,7 +917,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	init_patch_ids(ids, the_repository);
 
 	/* given a range a..b get all patch ids for b..a */
-	init_revisions(&check_rev, the_repository, rev->prefix);
+	repo_init_revisions(&check_rev, the_repository, rev->prefix);
 	check_rev.max_parents = 1;
 	o1->flags ^= UNINTERESTING;
 	o2->flags ^= UNINTERESTING;
@@ -1361,13 +1361,13 @@ static void prepare_bases(struct base_tree_info *bases,
 		return;
 
 	init_commit_base(&commit_base);
-	diff_setup(&diffopt, the_repository);
+	repo_diff_setup(&diffopt, the_repository);
 	diffopt.flags.recursive = 1;
 	diff_setup_done(&diffopt);
 
 	oidcpy(&bases->base_commit, &base->object.oid);
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	revs.max_parents = 1;
 	revs.topo_order = 1;
 	for (i = 0; i < total; i++) {
@@ -1528,7 +1528,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_cc.strdup_strings = 1;
 	init_log_defaults();
 	git_config(git_format_config, NULL);
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
@@ -1939,7 +1939,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(&revs, the_repository, prefix);
 	revs.max_parents = 1;
 
 	if (add_pending_commit(head, &revs, 0))
diff --git a/builtin/merge.c b/builtin/merge.c
index 6fe511521a..adf8029f3c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -389,7 +389,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 
 	printf(_("Squash commit -- not updating HEAD\n"));
 
-	init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(&rev, the_repository, NULL);
 	rev.ignore_merges = 1;
 	rev.commit_format = CMIT_FMT_MEDIUM;
 
@@ -452,7 +452,7 @@ static void finish(struct commit *head_commit,
 	}
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
-		diff_setup(&opts, the_repository);
+		repo_diff_setup(&opts, the_repository);
 		opts.stat_width = -1; /* use full terminal width */
 		opts.stat_graph_width = -1; /* respect statGraphWidth config */
 		opts.output_format |=
@@ -899,7 +899,7 @@ static int suggest_conflicts(void)
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
-	rerere(the_repository, allow_rerere_auto);
+	repo_rerere(the_repository, allow_rerere_auto);
 	printf(_("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n"));
 	return 1;
@@ -911,7 +911,7 @@ static int evaluate_result(void)
 	struct rev_info rev;
 
 	/* Check how many files differ. */
-	init_revisions(&rev, the_repository, "");
+	repo_init_revisions(&rev, the_repository, "");
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |=
 		DIFF_FORMAT_CALLBACK;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index aab2e43cd6..849616ecee 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2989,7 +2989,7 @@ static void get_object_list(int ac, const char **av)
 	char line[1000];
 	int flags = 0;
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
diff --git a/builtin/prune.c b/builtin/prune.c
index 1cea2b2b70..0a8108add4 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -120,7 +120,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	read_replace_refs = 0;
 	ref_paranoia = 1;
-	init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(&revs, the_repository, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 28794bfdc7..1de686e8a0 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -34,7 +34,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_ui_config, NULL);
 
-	diff_setup(&diffopt, the_repository);
+	repo_diff_setup(&diffopt, the_repository);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
 	diffopt.flags.suppress_diff_headers = 1;
 	diffopt.output_prefix = output_prefix_cb;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 9320228687..86c02a4767 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -567,7 +567,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 * from reflog if the repository was pruned with older git.
 	 */
 	if (cb.cmd.stalefix) {
-		init_revisions(&cb.cmd.revs, the_repository, prefix);
+		repo_init_revisions(&cb.cmd.revs, the_repository, prefix);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("Marking reachable objects...");
 		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
diff --git a/builtin/rerere.c b/builtin/rerere.c
index d1fc472d13..1ca271b711 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -70,7 +70,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		flags = RERERE_NOAUTOUPDATE;
 
 	if (argc < 1)
-		return rerere(the_repository, flags);
+		return repo_rerere(the_repository, flags);
 
 	if (!strcmp(argv[0], "forget")) {
 		struct pathspec pathspec;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 754cb11717..3bbb25bae7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -370,7 +370,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		usage(rev_list_usage);
 
 	git_config(git_default_config, NULL);
-	init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(&revs, the_repository, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 
diff --git a/builtin/revert.c b/builtin/revert.c
index 4db27e9c4b..8b18715a6a 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -174,7 +174,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	} else {
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
-		init_revisions(opts->revs, the_repository, NULL);
+		repo_init_revisions(opts->revs, the_repository, NULL);
 		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 22e92a62d6..467265881d 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -278,7 +278,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 701f2f42ce..210f31ac86 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -792,7 +792,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			 path, NULL);
 
 	git_config(git_diff_basic_config, NULL);
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	rev.abbrev = 0;
 	diff_files_args.argc = setup_revisions(diff_files_args.argc,
 					       diff_files_args.argv,
diff --git a/bundle.c b/bundle.c
index 05d4b7b4c9..4b9a7e81fd 100644
--- a/bundle.c
+++ b/bundle.c
@@ -140,7 +140,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
 		struct object *o = parse_object(the_repository, &e->oid);
@@ -441,7 +441,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 
 	/* write prerequisites */
 	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
diff --git a/diff-lib.c b/diff-lib.c
index 745c2c69ec..91a74f9b0c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -542,7 +542,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 {
 	struct rev_info revs;
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
 	revs.diffopt = *opt;
 
@@ -557,7 +557,7 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(&rev, the_repository, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = def;
 	setup_revisions(0, NULL, &rev, &opt);
diff --git a/diff-no-index.c b/diff-no-index.c
index b25f7225be..4a32d8ef55 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -246,7 +246,7 @@ void diff_no_index(struct repository *r,
 	 * FIXME: --no-index should not look at index and we should be
 	 * able to pass NULL repo. Maybe later.
 	 */
-	diff_setup(&revs->diffopt, r);
+	repo_diff_setup(&revs->diffopt, r);
 	for (i = 1; i < argc - 2; ) {
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
diff --git a/diff.c b/diff.c
index bb51833d8b..a435226b0b 100644
--- a/diff.c
+++ b/diff.c
@@ -4396,7 +4396,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
-void diff_setup(struct diff_options *options, struct repository *repo)
+void repo_diff_setup(struct diff_options *options, struct repository *repo)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
 
diff --git a/diff.h b/diff.h
index a594a501dc..d41042418c 100644
--- a/diff.h
+++ b/diff.h
@@ -336,7 +336,8 @@ int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
 int git_diff_ui_config(const char *var, const char *value, void *cb);
-void diff_setup(struct diff_options *, struct repository *);
+void repo_diff_setup(struct diff_options *, struct repository *);
+#define diff_setup(opts) repo_diff_setup(opts, the_repository)
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
 void diff_setup_done(struct diff_options *);
 int git_config_rename(const char *var, const char *value);
diff --git a/http-push.c b/http-push.c
index 5324b8511d..9b9f990d5e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1925,7 +1925,7 @@ int cmd_main(int argc, const char **argv)
 		if (!push_all && !is_null_oid(&ref->old_oid))
 			argv_array_pushf(&commit_argv, "^%s",
 					 oid_to_hex(&ref->old_oid));
-		init_revisions(&revs, the_repository, setup_git_directory());
+		repo_init_revisions(&revs, the_repository, setup_git_directory());
 		setup_revisions(commit_argv.argc, commit_argv.argv, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 733bfd413e..2b6d7e2d2c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1115,7 +1115,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	/* get all revisions that merge commit a */
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 		  oid_to_hex(&a->object.oid));
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
 	revs.single_worktree = path != NULL;
@@ -1813,7 +1813,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	diff_setup(&opts, the_repository);
+	repo_diff_setup(&opts, the_repository);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
 	opts.detect_rename = merge_detect_rename(o);
diff --git a/notes-merge.c b/notes-merge.c
index ea062b0ad6..5f7490e6d7 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -126,7 +126,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
 	       oid_to_hex(base), oid_to_hex(remote));
 
-	diff_setup(&opt, the_repository);
+	repo_diff_setup(&opt, the_repository);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
@@ -189,7 +189,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
 	       len, oid_to_hex(base), oid_to_hex(local));
 
-	diff_setup(&opt, the_repository);
+	repo_diff_setup(&opt, the_repository);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 9b54195dce..ed61e43f94 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -261,7 +261,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	if (writer.show_progress)
 		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	revs.tag_objects = 1;
 	revs.tree_objects = 1;
 	revs.blob_objects = 1;
diff --git a/patch-ids.c b/patch-ids.c
index 72ef9e4e8a..f80c7f4b9a 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -59,7 +59,7 @@ static int patch_id_cmp(const void *cmpfn_data,
 int init_patch_ids(struct patch_ids *ids, struct repository *repo)
 {
 	memset(ids, 0, sizeof(*ids));
-	diff_setup(&ids->diffopts, repo);
+	repo_diff_setup(&ids->diffopts, repo);
 	ids->diffopts.detect_rename = 0;
 	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
diff --git a/read-cache.c b/read-cache.c
index e12d54a39f..0e74fe6482 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2141,7 +2141,7 @@ int index_has_changes(struct index_state *istate,
 	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
-		diff_setup(&opt, the_repository);
+		repo_diff_setup(&opt, the_repository);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
diff --git a/ref-filter.c b/ref-filter.c
index 05a206f91d..896e260493 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2138,7 +2138,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 	struct ref_array *array = ref_cbdata->array;
 	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 
 	for (i = 0; i < array->nr; i++) {
 		struct ref_array_item *item = array->items[i];
diff --git a/remote.c b/remote.c
index d0081e86c0..3eff9fcf4d 100644
--- a/remote.c
+++ b/remote.c
@@ -1903,7 +1903,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 			 oid_to_hex(&theirs->object.oid));
 	argv_array_push(&argv, "--");
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	setup_revisions(argv.argc, argv.argv, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/rerere.c b/rerere.c
index d439077f83..8d4ac8426b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -915,7 +915,7 @@ int setup_rerere(struct string_list *merge_rr, int flags)
  * perform mergy operations, possibly leaving conflicted index entries
  * and working tree files.
  */
-int rerere(struct repository *r, int flags)
+int repo_rerere(struct repository *r, int flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	int fd, status;
diff --git a/rerere.h b/rerere.h
index 44773435a0..e01a8e5b22 100644
--- a/rerere.h
+++ b/rerere.h
@@ -24,7 +24,8 @@ struct rerere_id {
 };
 
 extern int setup_rerere(struct string_list *, int);
-extern int rerere(struct repository *repo, int);
+extern int repo_rerere(struct repository *repo, int);
+#define rerere(flags) repo_rerere(the_repository, flags)
 /*
  * Given the conflict ID and the name of a "file" used for replaying
  * the recorded resolution (e.g. "preimage", "postimage"), return the
diff --git a/revision.c b/revision.c
index a89d6e9689..fd71f58936 100644
--- a/revision.c
+++ b/revision.c
@@ -1440,7 +1440,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
-void init_revisions(struct rev_info *revs,
+void repo_init_revisions(struct rev_info *revs,
 		    struct repository *repo,
 		    const char *prefix)
 {
@@ -1472,7 +1472,7 @@ void init_revisions(struct rev_info *revs,
 	grep_init(&revs->grep_filter, revs->repo, prefix);
 	revs->grep_filter.status_only = 1;
 
-	diff_setup(&revs->diffopt, revs->repo);
+	repo_diff_setup(&revs->diffopt, revs->repo);
 	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
diff --git a/revision.h b/revision.h
index f819ea4151..c7fc8522b2 100644
--- a/revision.h
+++ b/revision.h
@@ -255,9 +255,10 @@ struct setup_revision_opt {
 	unsigned revarg_opt;
 };
 
-void init_revisions(struct rev_info *revs,
+void repo_init_revisions(struct rev_info *revs,
 		    struct repository *repo,
 		    const char *prefix);
+#define init_revisions(revs, prefix) repo_init_revisions(revs, the_repository, prefix)
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
diff --git a/sequencer.c b/sequencer.c
index 038cc62870..b81f7f68a8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1143,7 +1143,7 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	strbuf_release(&author_ident);
 	strbuf_release(&committer_ident);
 
-	init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(&rev, the_repository, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
 	rev.diff = 1;
@@ -1827,7 +1827,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		      : _("could not apply %s... %s"),
 		      short_commit_name(commit), msg.subject);
 		print_advice(res == 1, opts);
-		rerere(the_repository, opts->allow_rerere_auto);
+		repo_rerere(the_repository, opts->allow_rerere_auto);
 		goto leave;
 	}
 
@@ -2566,7 +2566,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-	init_revisions(&log_tree_opt, the_repository, NULL);
+	repo_init_revisions(&log_tree_opt, the_repository, NULL);
 	log_tree_opt.abbrev = 0;
 	log_tree_opt.diff = 1;
 	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -3146,7 +3146,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 
 	rollback_lock_file(&lock);
 	if (ret)
-		rerere(the_repository, opts->allow_rerere_auto);
+		repo_rerere(the_repository, opts->allow_rerere_auto);
 	else
 		/*
 		 * In case of problems, we now want to return a positive
@@ -3477,7 +3477,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			struct object_id orig, head;
 
 			memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-			init_revisions(&log_tree_opt, the_repository, NULL);
+			repo_init_revisions(&log_tree_opt, the_repository, NULL);
 			log_tree_opt.diff = 1;
 			log_tree_opt.diffopt.output_format =
 				DIFF_FORMAT_DIFFSTAT;
@@ -4212,7 +4212,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	revs.verbose_header = 1;
 	if (!rebase_merges)
 		revs.max_parents = 1;
diff --git a/shallow.c b/shallow.c
index 92bbb22117..9209582054 100644
--- a/shallow.c
+++ b/shallow.c
@@ -184,7 +184,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 
 	is_repository_shallow(the_repository); /* make sure shallows are read */
 
-	init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(&revs, the_repository, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
diff --git a/submodule.c b/submodule.c
index 841315ec63..eeb3e481a7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -428,7 +428,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 {
 	struct commit_list *list;
 
-	init_revisions(rev, the_repository, NULL);
+	repo_init_revisions(rev, the_repository, NULL);
 	setup_revisions(0, NULL, rev, NULL);
 	rev->left_right = 1;
 	rev->first_parent_only = 1;
@@ -773,7 +773,7 @@ static void collect_changed_submodules(struct index_state *istate,
 	struct rev_info rev;
 	const struct commit *commit;
 
-	init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(&rev, the_repository, NULL);
 	setup_revisions(argv->argc, argv->argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
@@ -784,7 +784,7 @@ static void collect_changed_submodules(struct index_state *istate,
 		data.changed = changed;
 		data.commit_oid = &commit->object.oid;
 
-		init_revisions(&diff_rev, the_repository, NULL);
+		repo_init_revisions(&diff_rev, the_repository, NULL);
 		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
 		diff_rev.diffopt.format_callback_data = &data;
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 58cad3bbae..ead4d96e28 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -32,7 +32,7 @@ static int run_revision_walk(void)
 	int argc = ARRAY_SIZE(argv) - 1;
 	int got_revision = 0;
 
-	init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(&rev, the_repository, NULL);
 	setup_revisions(argc, argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
diff --git a/tree-diff.c b/tree-diff.c
index 86cf5a3971..24ef60ab96 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -605,7 +605,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	diff_setup(&diff_opts, opt->repo);
+	repo_diff_setup(&diff_opts, opt->repo);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
diff --git a/wt-status.c b/wt-status.c
index 29bcfab3eb..22cf6cca25 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -582,7 +582,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 {
 	struct rev_info rev;
 
-	init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(&rev, the_repository, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.flags.dirty_submodules = 1;
@@ -607,7 +607,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(&rev, the_repository, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
@@ -982,7 +982,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	int dirty_submodules;
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(&rev, the_repository, NULL);
 	rev.diffopt.flags.allow_textconv = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 
@@ -2314,7 +2314,7 @@ int has_unstaged_changes(int ignore_submodules)
 	struct rev_info rev_info;
 	int result;
 
-	init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(&rev_info, the_repository, NULL);
 	if (ignore_submodules) {
 		rev_info.diffopt.flags.ignore_submodules = 1;
 		rev_info.diffopt.flags.override_submodule_config = 1;
@@ -2336,7 +2336,7 @@ int has_uncommitted_changes(int ignore_submodules)
 	if (is_cache_unborn())
 		return 0;
 
-	init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(&rev_info, the_repository, NULL);
 	if (ignore_submodules)
 		rev_info.diffopt.flags.ignore_submodules = 1;
 	rev_info.diffopt.flags.quick = 1;
-- 
2.19.0.rc0.337.ge906d732e7

