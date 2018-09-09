Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BFA91F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeIINng (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39784 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeIINnf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so15396195lji.6
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KsmLqqz0ElrWCkHqOPfcM1OIC/Xxj63SmsmLgQ2J9Cw=;
        b=X5MvfvX8HAStC147ytPKUVT0nmx06sAzeF5iFHkhKBlmoeXrLCapt3v20Qips1TkmH
         cW2j/LEm7vhQeGTeGD/TASC5yYzwSmdb4gjxvbCxNN3+TCegBSUTB3IYNYg5UM49AisH
         sk/IPljWPG9sbkw4+Ugc9jL8tp+BY4tyQySbw8GjpK4BtcKhury6TeHd0mLrn6ys85Hb
         iEQNzn8KjDhpUD7wBYqifO6E/3Gs6U+8sFf3pdzMCNFbls3l/XxlO643PnHfWgHIsNUB
         DMnzxAvH/GsXBOYMuimwrjVjJKXc/pZXa+cK/JijWJdEnfQlHRzRSk4bmewCB2ZTsDWS
         N/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KsmLqqz0ElrWCkHqOPfcM1OIC/Xxj63SmsmLgQ2J9Cw=;
        b=oK0Whdj0kWtZRZTfuKP7XbgLj0QqSxgIdVi3W80TFvQw/J6XxFuRh1hDy50dzFzS2p
         UUINaz1VxrMJdBhBALwovFTV4NIsSn69qiNVvsZM5zwBt9SGGi9WHKeQ11hnDNgtInfa
         s5jFmoh3/oO4zxRIijqD0SjDHFWKbyPX2LhKbDkM/pNlkkwBsdVgMyVlDXatjfW/Qmx9
         y1rdIEy2KvitYlao5SSirrWzgOVL9LCoE1tH/YHSbrncSOWXlOpYYynDb3X09BDDO6Zx
         xxVAaxh3RKKJ6iTZxb3k/UBCgd44F+le7jh4wOTchribypkv49I0o4w5UewEaAsjxehf
         LSuA==
X-Gm-Message-State: APzg51AzOJ7prqXMOjaziXN4U/qlcFF7kG8LiBoW5nZQLnCLyk0CrZ7F
        lyGR0uv0gGI3m7X4+gFM5Vs=
X-Google-Smtp-Source: ANB0VdZudo+Js8lpouEWYY5c2qZkKP7FXBVw3p2ONZTS/3e1uxERE1sGC6zuwphuC3unXhaYJBDWbA==
X-Received: by 2002:a2e:1517:: with SMTP id s23-v6mr9772793ljd.73.1536483270820;
        Sun, 09 Sep 2018 01:54:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/23] Kill the_index part 4
Date:   Sun,  9 Sep 2018 10:53:55 +0200
Message-Id: <20180909085418.31531-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last patch 24/24 has been merged into individual patches to add
repo_ prefix and avoid breaking in-flight topics. "repo" argument is
also moved up in rerere(), diff_setup() and init_revisions().

All three macros that take the_repository is wrapped in NO_THE_REPO...
similar to NO_THE_INDEX_... After part 5, these macros will be only
available to builtin/ (or even removed if no in-flight topics use
them)

Interdiff

diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
index 8b001de0db..30fc0e9c93 100644
--- a/Documentation/technical/api-diff.txt
+++ b/Documentation/technical/api-diff.txt
@@ -18,8 +18,8 @@ Calling sequence
 ----------------
 
 * Prepare `struct diff_options` to record the set of diff options, and
-  then call `diff_setup()` to initialize this structure.  This sets up
-  the vanilla default.
+  then call `repo_diff_setup()` to initialize this structure.  This
+  sets up the vanilla default.
 
 * Fill in the options structure to specify desired output format, rename
   detection, etc.  `diff_opt_parse()` can be used to parse options given
diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
index 55b878ade8..83e62533a0 100644
--- a/Documentation/technical/api-revision-walking.txt
+++ b/Documentation/technical/api-revision-walking.txt
@@ -15,7 +15,7 @@ revision list.
 Functions
 ---------
 
-`init_revisions`::
+`repo_init_revisions`::
 
 	Initialize a rev_info structure with default values. The second
 	parameter may be NULL or can be prefix path, and then the `.prefix`
diff --git a/bisect.c b/bisect.c
index 560493acd2..6ae5e5b49e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -632,7 +632,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	struct argv_array rev_argv = ARGV_ARRAY_INIT;
 	int i;
 
-	repo_init_revisions(revs, the_repository, prefix);
+	repo_init_revisions(the_repository, revs, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
@@ -889,7 +889,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	struct rev_info opt;
 
 	/* diff-tree init */
-	repo_init_revisions(&opt, the_repository, prefix);
+	repo_init_revisions(the_repository, &opt, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt.abbrev = 0;
 	opt.diff = 1;
diff --git a/blame.c b/blame.c
index 39fbd796c0..c229a10c0e 100644
--- a/blame.c
+++ b/blame.c
@@ -563,7 +563,7 @@ static struct blame_origin *find_origin(struct repository *r,
 	 * and origin first.  Most of the time they are the
 	 * same and diff-tree is fairly efficient about this.
 	 */
-	repo_diff_setup(&diff_opts, r);
+	repo_diff_setup(r, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -638,7 +638,7 @@ static struct blame_origin *find_rename(struct repository *r,
 	struct diff_options diff_opts;
 	int i;
 
-	repo_diff_setup(&diff_opts, r);
+	repo_diff_setup(r, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -1262,7 +1262,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	repo_diff_setup(&diff_opts, sb->repo);
+	repo_diff_setup(sb->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 
diff --git a/builtin/add.c b/builtin/add.c
index c8f99083fc..f94b614c1c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -110,7 +110,7 @@ int add_files_to_cache(const char *prefix,
 	memset(&data, 0, sizeof(data));
 	data.flags = flags;
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	if (pathspec)
 		copy_pathspec(&rev.prune_data, pathspec);
@@ -232,7 +232,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("Could not read the index"));
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diffopt.context = 7;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/builtin/am.c b/builtin/am.c
index 70afd6c15a..5c743ba4f5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1372,7 +1372,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	FILE *fp;
 
 	fp = xfopen(am_path(state, "patch"), "w");
-	repo_init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev_info, NULL);
 	rev_info.diff = 1;
 	rev_info.abbrev = 0;
 	rev_info.disable_stdin = 1;
@@ -1407,7 +1407,7 @@ static void write_index_patch(const struct am_state *state)
 				   the_repository->hash_algo->empty_tree);
 
 	fp = xfopen(am_path(state, "patch"), "w");
-	repo_init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev_info, NULL);
 	rev_info.diff = 1;
 	rev_info.disable_stdin = 1;
 	rev_info.no_commit_id = 1;
@@ -1565,7 +1565,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		struct rev_info rev_info;
 		const char *diff_filter_str = "--diff-filter=AM";
 
-		repo_init_revisions(&rev_info, the_repository, NULL);
+		repo_init_revisions(the_repository, &rev_info, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
 		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
 		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
diff --git a/builtin/blame.c b/builtin/blame.c
index 20a5f15999..a443af9ee9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -830,7 +830,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	revs.date_mode = blame_date_mode;
 	revs.diffopt.flags.allow_textconv = 1;
 	revs.diffopt.flags.follow_renames = 1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index be8f1b23dc..ae28478ff8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -392,7 +392,7 @@ static void show_local_changes(struct object *head,
 {
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
 	diff_setup_done(&rev.diffopt);
@@ -801,7 +801,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	struct rev_info revs;
 	struct object *object = &old_commit->object;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
 
 	object->flags &= ~UNINTERESTING;
diff --git a/builtin/commit.c b/builtin/commit.c
index 84e49a33be..9d8ce6cb3b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -980,7 +980,7 @@ static const char *find_author_by_nickname(const char *name)
 	const char *av[20];
 	int ac = 0;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	strbuf_addf(&buf, "--author=%s", name);
 	av[++ac] = "--all";
 	av[++ac] = "-i";
diff --git a/builtin/describe.c b/builtin/describe.c
index bf116db7a0..1fde0563fe 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -488,7 +488,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 		"--objects", "--in-commit-order", "--reverse", "HEAD",
 		NULL);
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
 		BUG("setup_revisions could not handle all args?");
 
@@ -636,7 +636,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			if (0 <= fd)
 				update_index_if_able(&the_index, &index_lock);
 
-			repo_init_revisions(&revs, the_repository, prefix);
+			repo_init_revisions(the_repository, &revs, prefix);
 			argv_array_pushv(&args, diff_index_args);
 			if (setup_revisions(args.argc, args.argv, &revs, NULL) != 1)
 				BUG("malformed internal diff-index command line");
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index d24c4176ac..48cfcb935d 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -25,7 +25,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		usage(diff_files_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 4151676fdd..fcccd1f10d 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -22,7 +22,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index c398dd9631..ef996126d7 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -110,7 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		usage(diff_tree_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	repo_init_revisions(opt, the_repository, prefix);
+	repo_init_revisions(the_repository, opt, prefix);
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 	opt->abbrev = 0;
diff --git a/builtin/diff.c b/builtin/diff.c
index 948f0b04bc..43bb71c1e0 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -318,7 +318,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	precompose_argv(argc, argv);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 
 	if (no_index && argc != i + 2) {
 		if (no_index == DIFF_NO_INDEX_IMPLICIT) {
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b2c34aa06b..9bd4a95a47 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1033,7 +1033,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
 
-	repo_init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 	init_revision_sources(&revision_sources);
 	revs.topo_order = 1;
 	revs.sources = &revision_sources;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 34bb948635..1adc84ed87 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -642,7 +642,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		struct rev_info rev;
 
 		head = lookup_commit_or_die(&head_oid, "HEAD");
-		repo_init_revisions(&rev, the_repository, NULL);
+		repo_init_revisions(the_repository, &rev, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.ignore_merges = 1;
 		rev.limited = 1;
diff --git a/builtin/log.c b/builtin/log.c
index fd4741a4de..717d20e115 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -467,7 +467,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
 	memset(&opt, 0, sizeof(opt));
@@ -585,7 +585,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	git_config(git_log_config, NULL);
 
 	memset(&match_all, 0, sizeof(match_all));
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diff = 1;
 	rev.always_show_header = 1;
 	rev.no_walk = REVISION_WALK_NO_WALK_SORTED;
@@ -665,7 +665,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
@@ -704,7 +704,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
@@ -914,10 +914,10 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
 
-	init_patch_ids(ids, the_repository);
+	init_patch_ids(the_repository, ids);
 
 	/* given a range a..b get all patch ids for b..a */
-	repo_init_revisions(&check_rev, the_repository, rev->prefix);
+	repo_init_revisions(the_repository, &check_rev, rev->prefix);
 	check_rev.max_parents = 1;
 	o1->flags ^= UNINTERESTING;
 	o2->flags ^= UNINTERESTING;
@@ -1361,13 +1361,13 @@ static void prepare_bases(struct base_tree_info *bases,
 		return;
 
 	init_commit_base(&commit_base);
-	repo_diff_setup(&diffopt, the_repository);
+	repo_diff_setup(the_repository, &diffopt);
 	diffopt.flags.recursive = 1;
 	diff_setup_done(&diffopt);
 
 	oidcpy(&bases->base_commit, &base->object.oid);
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	revs.max_parents = 1;
 	revs.topo_order = 1;
 	for (i = 0; i < total; i++) {
@@ -1528,7 +1528,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_cc.strdup_strings = 1;
 	init_log_defaults();
 	git_config(git_format_config, NULL);
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
@@ -1939,7 +1939,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	repo_init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 	revs.max_parents = 1;
 
 	if (add_pending_commit(head, &revs, 0))
diff --git a/builtin/merge.c b/builtin/merge.c
index adf8029f3c..a493f8d866 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -389,7 +389,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 
 	printf(_("Squash commit -- not updating HEAD\n"));
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	rev.ignore_merges = 1;
 	rev.commit_format = CMIT_FMT_MEDIUM;
 
@@ -452,7 +452,7 @@ static void finish(struct commit *head_commit,
 	}
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
-		repo_diff_setup(&opts, the_repository);
+		repo_diff_setup(the_repository, &opts);
 		opts.stat_width = -1; /* use full terminal width */
 		opts.stat_graph_width = -1; /* respect statGraphWidth config */
 		opts.output_format |=
@@ -911,7 +911,7 @@ static int evaluate_result(void)
 	struct rev_info rev;
 
 	/* Check how many files differ. */
-	repo_init_revisions(&rev, the_repository, "");
+	repo_init_revisions(the_repository, &rev, "");
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |=
 		DIFF_FORMAT_CALLBACK;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 849616ecee..3383ba43d0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2989,7 +2989,7 @@ static void get_object_list(int ac, const char **av)
 	char line[1000];
 	int flags = 0;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
diff --git a/builtin/prune.c b/builtin/prune.c
index 0a8108add4..41230f8215 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -120,7 +120,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	read_replace_refs = 0;
 	ref_paranoia = 1;
-	repo_init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 1de686e8a0..1c477c4dc5 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -34,7 +34,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_ui_config, NULL);
 
-	repo_diff_setup(&diffopt, the_repository);
+	repo_diff_setup(the_repository, &diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
 	diffopt.flags.suppress_diff_headers = 1;
 	diffopt.output_prefix = output_prefix_cb;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 86c02a4767..b5941c1ff3 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -567,7 +567,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 * from reflog if the repository was pruned with older git.
 	 */
 	if (cb.cmd.stalefix) {
-		repo_init_revisions(&cb.cmd.revs, the_repository, prefix);
+		repo_init_revisions(the_repository, &cb.cmd.revs, prefix);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("Marking reachable objects...");
 		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3bbb25bae7..c60504891a 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -370,7 +370,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		usage(rev_list_usage);
 
 	git_config(git_default_config, NULL);
-	repo_init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 
diff --git a/builtin/revert.c b/builtin/revert.c
index 8b18715a6a..c93393c89b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -174,7 +174,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	} else {
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
-		repo_init_revisions(opts->revs, the_repository, NULL);
+		repo_init_revisions(the_repository, opts->revs, NULL);
 		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 467265881d..88f88e97b2 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -278,7 +278,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 210f31ac86..a10b66a1eb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -792,7 +792,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			 path, NULL);
 
 	git_config(git_diff_basic_config, NULL);
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	diff_files_args.argc = setup_revisions(diff_files_args.argc,
 					       diff_files_args.argv,
diff --git a/bundle.c b/bundle.c
index 4b9a7e81fd..a5a71d059e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -140,7 +140,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
 		struct object *o = parse_object(the_repository, &e->oid);
@@ -441,7 +441,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 
 	/* write prerequisites */
 	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
diff --git a/diff-lib.c b/diff-lib.c
index 91a74f9b0c..9a3b798cb5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -542,7 +542,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 {
 	struct rev_info revs;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
 	revs.diffopt = *opt;
 
@@ -557,7 +557,7 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = def;
 	setup_revisions(0, NULL, &rev, &opt);
diff --git a/diff-no-index.c b/diff-no-index.c
index 4a32d8ef55..9414e922d1 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -246,7 +246,7 @@ void diff_no_index(struct repository *r,
 	 * FIXME: --no-index should not look at index and we should be
 	 * able to pass NULL repo. Maybe later.
 	 */
-	repo_diff_setup(&revs->diffopt, r);
+	repo_diff_setup(r, &revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
diff --git a/diff.c b/diff.c
index a435226b0b..c5b5e7ac41 100644
--- a/diff.c
+++ b/diff.c
@@ -4396,12 +4396,12 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
-void repo_diff_setup(struct diff_options *options, struct repository *repo)
+void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
 
 	options->file = stdout;
-	options->repo = repo;
+	options->repo = r;
 
 	options->abbrev = DEFAULT_ABBREV;
 	options->line_termination = '\n';
diff --git a/diff.h b/diff.h
index d41042418c..af26196224 100644
--- a/diff.h
+++ b/diff.h
@@ -336,8 +336,10 @@ int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
 int git_diff_ui_config(const char *var, const char *value, void *cb);
-void repo_diff_setup(struct diff_options *, struct repository *);
-#define diff_setup(opts) repo_diff_setup(opts, the_repository)
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
+#endif
+void repo_diff_setup(struct repository *, struct diff_options *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
 void diff_setup_done(struct diff_options *);
 int git_config_rename(const char *var, const char *value);
diff --git a/http-push.c b/http-push.c
index 9b9f990d5e..df504ab6a3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1925,7 +1925,7 @@ int cmd_main(int argc, const char **argv)
 		if (!push_all && !is_null_oid(&ref->old_oid))
 			argv_array_pushf(&commit_argv, "^%s",
 					 oid_to_hex(&ref->old_oid));
-		repo_init_revisions(&revs, the_repository, setup_git_directory());
+		repo_init_revisions(the_repository, &revs, setup_git_directory());
 		setup_revisions(commit_argv.argc, commit_argv.argv, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 2b6d7e2d2c..fec8188472 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1115,7 +1115,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	/* get all revisions that merge commit a */
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 		  oid_to_hex(&a->object.oid));
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
 	revs.single_worktree = path != NULL;
@@ -1813,7 +1813,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	repo_diff_setup(&opts, the_repository);
+	repo_diff_setup(the_repository, &opts);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
 	opts.detect_rename = merge_detect_rename(o);
diff --git a/notes-merge.c b/notes-merge.c
index 5f7490e6d7..13dd9ba158 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -126,7 +126,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
 	       oid_to_hex(base), oid_to_hex(remote));
 
-	repo_diff_setup(&opt, the_repository);
+	repo_diff_setup(the_repository, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
@@ -189,7 +189,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
 	       len, oid_to_hex(base), oid_to_hex(local));
 
-	repo_diff_setup(&opt, the_repository);
+	repo_diff_setup(the_repository, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index ed61e43f94..198fd13097 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -261,7 +261,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	if (writer.show_progress)
 		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	revs.tag_objects = 1;
 	revs.tree_objects = 1;
 	revs.blob_objects = 1;
diff --git a/patch-ids.c b/patch-ids.c
index f80c7f4b9a..7da86047d9 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -56,10 +56,10 @@ static int patch_id_cmp(const void *cmpfn_data,
 	return oidcmp(&a->patch_id, &b->patch_id);
 }
 
-int init_patch_ids(struct patch_ids *ids, struct repository *repo)
+int init_patch_ids(struct repository *r, struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
-	repo_diff_setup(&ids->diffopts, repo);
+	repo_diff_setup(r, &ids->diffopts);
 	ids->diffopts.detect_rename = 0;
 	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
diff --git a/patch-ids.h b/patch-ids.h
index 1d4cf618f9..82a12b66f8 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -21,7 +21,7 @@ struct patch_ids {
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    struct object_id *oid, int);
-int init_patch_ids(struct patch_ids *, struct repository *);
+int init_patch_ids(struct repository *, struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
 struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);
diff --git a/read-cache.c b/read-cache.c
index 0e74fe6482..b707edd044 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2141,7 +2141,7 @@ int index_has_changes(struct index_state *istate,
 	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
-		repo_diff_setup(&opt, the_repository);
+		repo_diff_setup(the_repository, &opt);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
diff --git a/ref-filter.c b/ref-filter.c
index 896e260493..f081a290cb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2138,7 +2138,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 	struct ref_array *array = ref_cbdata->array;
 	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 
 	for (i = 0; i < array->nr; i++) {
 		struct ref_array_item *item = array->items[i];
diff --git a/remote.c b/remote.c
index 3eff9fcf4d..348417f0a7 100644
--- a/remote.c
+++ b/remote.c
@@ -1903,7 +1903,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 			 oid_to_hex(&theirs->object.oid));
 	argv_array_push(&argv, "--");
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	setup_revisions(argv.argc, argv.argv, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/rerere.h b/rerere.h
index e01a8e5b22..5ad8864b3c 100644
--- a/rerere.h
+++ b/rerere.h
@@ -23,9 +23,11 @@ struct rerere_id {
 	int variant;
 };
 
-extern int setup_rerere(struct string_list *, int);
-extern int repo_rerere(struct repository *repo, int);
+int setup_rerere(struct string_list *, int);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define rerere(flags) repo_rerere(the_repository, flags)
+#endif
+int repo_rerere(struct repository *, int);
 /*
  * Given the conflict ID and the name of a "file" used for replaying
  * the recorded resolution (e.g. "preimage", "postimage"), return the
diff --git a/revision.c b/revision.c
index fd71f58936..28366eaccf 100644
--- a/revision.c
+++ b/revision.c
@@ -878,7 +878,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		return;
 
 	left_first = left_count < right_count;
-	init_patch_ids(&ids, revs->repo);
+	init_patch_ids(revs->repo, &ids);
 	ids.diffopts.pathspec = revs->diffopt.pathspec;
 
 	/* Compute patch-ids for one side */
@@ -1440,13 +1440,13 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
-void repo_init_revisions(struct rev_info *revs,
-		    struct repository *repo,
-		    const char *prefix)
+void repo_init_revisions(struct repository *r,
+			 struct rev_info *revs,
+			 const char *prefix)
 {
 	memset(revs, 0, sizeof(*revs));
 
-	revs->repo = repo;
+	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
 	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
@@ -1472,7 +1472,7 @@ void repo_init_revisions(struct rev_info *revs,
 	grep_init(&revs->grep_filter, revs->repo, prefix);
 	revs->grep_filter.status_only = 1;
 
-	repo_diff_setup(&revs->diffopt, revs->repo);
+	repo_diff_setup(revs->repo, &revs->diffopt);
 	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
diff --git a/revision.h b/revision.h
index c7fc8522b2..7e62a65bad 100644
--- a/revision.h
+++ b/revision.h
@@ -255,10 +255,12 @@ struct setup_revision_opt {
 	unsigned revarg_opt;
 };
 
-void repo_init_revisions(struct rev_info *revs,
-		    struct repository *repo,
-		    const char *prefix);
-#define init_revisions(revs, prefix) repo_init_revisions(revs, the_repository, prefix)
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
+#endif
+void repo_init_revisions(struct repository *r,
+			 struct rev_info *revs,
+			 const char *prefix);
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
diff --git a/sequencer.c b/sequencer.c
index b81f7f68a8..3f56f8ccfe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1143,7 +1143,7 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	strbuf_release(&author_ident);
 	strbuf_release(&committer_ident);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
 	rev.diff = 1;
@@ -2566,7 +2566,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-	repo_init_revisions(&log_tree_opt, the_repository, NULL);
+	repo_init_revisions(the_repository, &log_tree_opt, NULL);
 	log_tree_opt.abbrev = 0;
 	log_tree_opt.diff = 1;
 	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -3477,7 +3477,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			struct object_id orig, head;
 
 			memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-			repo_init_revisions(&log_tree_opt, the_repository, NULL);
+			repo_init_revisions(the_repository, &log_tree_opt, NULL);
 			log_tree_opt.diff = 1;
 			log_tree_opt.diffopt.output_format =
 				DIFF_FORMAT_DIFFSTAT;
@@ -4212,7 +4212,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	revs.verbose_header = 1;
 	if (!rebase_merges)
 		revs.max_parents = 1;
diff --git a/shallow.c b/shallow.c
index 9209582054..e656ce8b9c 100644
--- a/shallow.c
+++ b/shallow.c
@@ -184,7 +184,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 
 	is_repository_shallow(the_repository); /* make sure shallows are read */
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
diff --git a/submodule.c b/submodule.c
index eeb3e481a7..9fcaf0246f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -428,7 +428,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 {
 	struct commit_list *list;
 
-	repo_init_revisions(rev, the_repository, NULL);
+	repo_init_revisions(the_repository, rev, NULL);
 	setup_revisions(0, NULL, rev, NULL);
 	rev->left_right = 1;
 	rev->first_parent_only = 1;
@@ -773,7 +773,7 @@ static void collect_changed_submodules(struct index_state *istate,
 	struct rev_info rev;
 	const struct commit *commit;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	setup_revisions(argv->argc, argv->argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
@@ -784,7 +784,7 @@ static void collect_changed_submodules(struct index_state *istate,
 		data.changed = changed;
 		data.commit_oid = &commit->object.oid;
 
-		repo_init_revisions(&diff_rev, the_repository, NULL);
+		repo_init_revisions(the_repository, &diff_rev, NULL);
 		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
 		diff_rev.diffopt.format_callback_data = &data;
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index ead4d96e28..625b2dbf82 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -32,7 +32,7 @@ static int run_revision_walk(void)
 	int argc = ARRAY_SIZE(argv) - 1;
 	int got_revision = 0;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	setup_revisions(argc, argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
diff --git a/tree-diff.c b/tree-diff.c
index 24ef60ab96..16b28ff6d6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -605,7 +605,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	repo_diff_setup(&diff_opts, opt->repo);
+	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
diff --git a/wt-status.c b/wt-status.c
index 22cf6cca25..2f743941d5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -582,7 +582,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 {
 	struct rev_info rev;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.flags.dirty_submodules = 1;
@@ -607,7 +607,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
@@ -982,7 +982,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	int dirty_submodules;
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	rev.diffopt.flags.allow_textconv = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 
@@ -2314,7 +2314,7 @@ int has_unstaged_changes(int ignore_submodules)
 	struct rev_info rev_info;
 	int result;
 
-	repo_init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev_info, NULL);
 	if (ignore_submodules) {
 		rev_info.diffopt.flags.ignore_submodules = 1;
 		rev_info.diffopt.flags.override_submodule_config = 1;
@@ -2336,7 +2336,7 @@ int has_uncommitted_changes(int ignore_submodules)
 	if (is_cache_unborn())
 		return 0;
 
-	repo_init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev_info, NULL);
 	if (ignore_submodules)
 		rev_info.diffopt.flags.ignore_submodules = 1;
 	rev_info.diffopt.flags.quick = 1;
diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
index 8b001de0db..30fc0e9c93 100644
--- a/Documentation/technical/api-diff.txt
+++ b/Documentation/technical/api-diff.txt
@@ -18,8 +18,8 @@ Calling sequence
 ----------------
 
 * Prepare `struct diff_options` to record the set of diff options, and
-  then call `diff_setup()` to initialize this structure.  This sets up
-  the vanilla default.
+  then call `repo_diff_setup()` to initialize this structure.  This
+  sets up the vanilla default.
 
 * Fill in the options structure to specify desired output format, rename
   detection, etc.  `diff_opt_parse()` can be used to parse options given
diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
index 55b878ade8..83e62533a0 100644
--- a/Documentation/technical/api-revision-walking.txt
+++ b/Documentation/technical/api-revision-walking.txt
@@ -15,7 +15,7 @@ revision list.
 Functions
 ---------
 
-`init_revisions`::
+`repo_init_revisions`::
 
 	Initialize a rev_info structure with default values. The second
 	parameter may be NULL or can be prefix path, and then the `.prefix`
diff --git a/bisect.c b/bisect.c
index 560493acd2..6ae5e5b49e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -632,7 +632,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	struct argv_array rev_argv = ARGV_ARRAY_INIT;
 	int i;
 
-	repo_init_revisions(revs, the_repository, prefix);
+	repo_init_revisions(the_repository, revs, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
@@ -889,7 +889,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	struct rev_info opt;
 
 	/* diff-tree init */
-	repo_init_revisions(&opt, the_repository, prefix);
+	repo_init_revisions(the_repository, &opt, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt.abbrev = 0;
 	opt.diff = 1;
diff --git a/blame.c b/blame.c
index 39fbd796c0..c229a10c0e 100644
--- a/blame.c
+++ b/blame.c
@@ -563,7 +563,7 @@ static struct blame_origin *find_origin(struct repository *r,
 	 * and origin first.  Most of the time they are the
 	 * same and diff-tree is fairly efficient about this.
 	 */
-	repo_diff_setup(&diff_opts, r);
+	repo_diff_setup(r, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -638,7 +638,7 @@ static struct blame_origin *find_rename(struct repository *r,
 	struct diff_options diff_opts;
 	int i;
 
-	repo_diff_setup(&diff_opts, r);
+	repo_diff_setup(r, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -1262,7 +1262,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	repo_diff_setup(&diff_opts, sb->repo);
+	repo_diff_setup(sb->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 
diff --git a/builtin/add.c b/builtin/add.c
index c8f99083fc..f94b614c1c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -110,7 +110,7 @@ int add_files_to_cache(const char *prefix,
 	memset(&data, 0, sizeof(data));
 	data.flags = flags;
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	if (pathspec)
 		copy_pathspec(&rev.prune_data, pathspec);
@@ -232,7 +232,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("Could not read the index"));
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diffopt.context = 7;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/builtin/am.c b/builtin/am.c
index 70afd6c15a..5c743ba4f5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1372,7 +1372,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	FILE *fp;
 
 	fp = xfopen(am_path(state, "patch"), "w");
-	repo_init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev_info, NULL);
 	rev_info.diff = 1;
 	rev_info.abbrev = 0;
 	rev_info.disable_stdin = 1;
@@ -1407,7 +1407,7 @@ static void write_index_patch(const struct am_state *state)
 				   the_repository->hash_algo->empty_tree);
 
 	fp = xfopen(am_path(state, "patch"), "w");
-	repo_init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev_info, NULL);
 	rev_info.diff = 1;
 	rev_info.disable_stdin = 1;
 	rev_info.no_commit_id = 1;
@@ -1565,7 +1565,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		struct rev_info rev_info;
 		const char *diff_filter_str = "--diff-filter=AM";
 
-		repo_init_revisions(&rev_info, the_repository, NULL);
+		repo_init_revisions(the_repository, &rev_info, NULL);
 		rev_info.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
 		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.prefix);
 		add_pending_oid(&rev_info, "HEAD", &our_tree, 0);
diff --git a/builtin/blame.c b/builtin/blame.c
index 20a5f15999..a443af9ee9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -830,7 +830,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	revs.date_mode = blame_date_mode;
 	revs.diffopt.flags.allow_textconv = 1;
 	revs.diffopt.flags.follow_renames = 1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index be8f1b23dc..ae28478ff8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -392,7 +392,7 @@ static void show_local_changes(struct object *head,
 {
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
 	diff_setup_done(&rev.diffopt);
@@ -801,7 +801,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	struct rev_info revs;
 	struct object *object = &old_commit->object;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
 
 	object->flags &= ~UNINTERESTING;
diff --git a/builtin/commit.c b/builtin/commit.c
index 84e49a33be..9d8ce6cb3b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -980,7 +980,7 @@ static const char *find_author_by_nickname(const char *name)
 	const char *av[20];
 	int ac = 0;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	strbuf_addf(&buf, "--author=%s", name);
 	av[++ac] = "--all";
 	av[++ac] = "-i";
diff --git a/builtin/describe.c b/builtin/describe.c
index bf116db7a0..1fde0563fe 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -488,7 +488,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 		"--objects", "--in-commit-order", "--reverse", "HEAD",
 		NULL);
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
 		BUG("setup_revisions could not handle all args?");
 
@@ -636,7 +636,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			if (0 <= fd)
 				update_index_if_able(&the_index, &index_lock);
 
-			repo_init_revisions(&revs, the_repository, prefix);
+			repo_init_revisions(the_repository, &revs, prefix);
 			argv_array_pushv(&args, diff_index_args);
 			if (setup_revisions(args.argc, args.argv, &revs, NULL) != 1)
 				BUG("malformed internal diff-index command line");
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index d24c4176ac..48cfcb935d 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -25,7 +25,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		usage(diff_files_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 4151676fdd..fcccd1f10d 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -22,7 +22,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	precompose_argv(argc, argv);
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index c398dd9631..ef996126d7 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -110,7 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		usage(diff_tree_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	repo_init_revisions(opt, the_repository, prefix);
+	repo_init_revisions(the_repository, opt, prefix);
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 	opt->abbrev = 0;
diff --git a/builtin/diff.c b/builtin/diff.c
index 948f0b04bc..43bb71c1e0 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -318,7 +318,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config, NULL);
 	precompose_argv(argc, argv);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 
 	if (no_index && argc != i + 2) {
 		if (no_index == DIFF_NO_INDEX_IMPLICIT) {
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b2c34aa06b..9bd4a95a47 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1033,7 +1033,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
 
-	repo_init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 	init_revision_sources(&revision_sources);
 	revs.topo_order = 1;
 	revs.sources = &revision_sources;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 34bb948635..1adc84ed87 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -642,7 +642,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		struct rev_info rev;
 
 		head = lookup_commit_or_die(&head_oid, "HEAD");
-		repo_init_revisions(&rev, the_repository, NULL);
+		repo_init_revisions(the_repository, &rev, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
 		rev.ignore_merges = 1;
 		rev.limited = 1;
diff --git a/builtin/log.c b/builtin/log.c
index fd4741a4de..717d20e115 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -467,7 +467,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
 	memset(&opt, 0, sizeof(opt));
@@ -585,7 +585,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	git_config(git_log_config, NULL);
 
 	memset(&match_all, 0, sizeof(match_all));
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.diff = 1;
 	rev.always_show_header = 1;
 	rev.no_walk = REVISION_WALK_NO_WALK_SORTED;
@@ -665,7 +665,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
@@ -704,7 +704,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
@@ -914,10 +914,10 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
 
-	init_patch_ids(ids, the_repository);
+	init_patch_ids(the_repository, ids);
 
 	/* given a range a..b get all patch ids for b..a */
-	repo_init_revisions(&check_rev, the_repository, rev->prefix);
+	repo_init_revisions(the_repository, &check_rev, rev->prefix);
 	check_rev.max_parents = 1;
 	o1->flags ^= UNINTERESTING;
 	o2->flags ^= UNINTERESTING;
@@ -1361,13 +1361,13 @@ static void prepare_bases(struct base_tree_info *bases,
 		return;
 
 	init_commit_base(&commit_base);
-	repo_diff_setup(&diffopt, the_repository);
+	repo_diff_setup(the_repository, &diffopt);
 	diffopt.flags.recursive = 1;
 	diff_setup_done(&diffopt);
 
 	oidcpy(&bases->base_commit, &base->object.oid);
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	revs.max_parents = 1;
 	revs.topo_order = 1;
 	for (i = 0; i < total; i++) {
@@ -1528,7 +1528,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_cc.strdup_strings = 1;
 	init_log_defaults();
 	git_config(git_format_config, NULL);
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
@@ -1939,7 +1939,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	repo_init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 	revs.max_parents = 1;
 
 	if (add_pending_commit(head, &revs, 0))
diff --git a/builtin/merge.c b/builtin/merge.c
index adf8029f3c..a493f8d866 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -389,7 +389,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 
 	printf(_("Squash commit -- not updating HEAD\n"));
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	rev.ignore_merges = 1;
 	rev.commit_format = CMIT_FMT_MEDIUM;
 
@@ -452,7 +452,7 @@ static void finish(struct commit *head_commit,
 	}
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
-		repo_diff_setup(&opts, the_repository);
+		repo_diff_setup(the_repository, &opts);
 		opts.stat_width = -1; /* use full terminal width */
 		opts.stat_graph_width = -1; /* respect statGraphWidth config */
 		opts.output_format |=
@@ -911,7 +911,7 @@ static int evaluate_result(void)
 	struct rev_info rev;
 
 	/* Check how many files differ. */
-	repo_init_revisions(&rev, the_repository, "");
+	repo_init_revisions(the_repository, &rev, "");
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |=
 		DIFF_FORMAT_CALLBACK;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 849616ecee..3383ba43d0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2989,7 +2989,7 @@ static void get_object_list(int ac, const char **av)
 	char line[1000];
 	int flags = 0;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
diff --git a/builtin/prune.c b/builtin/prune.c
index 0a8108add4..41230f8215 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -120,7 +120,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	read_replace_refs = 0;
 	ref_paranoia = 1;
-	repo_init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 1de686e8a0..1c477c4dc5 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -34,7 +34,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_ui_config, NULL);
 
-	repo_diff_setup(&diffopt, the_repository);
+	repo_diff_setup(the_repository, &diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
 	diffopt.flags.suppress_diff_headers = 1;
 	diffopt.output_prefix = output_prefix_cb;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 86c02a4767..b5941c1ff3 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -567,7 +567,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 * from reflog if the repository was pruned with older git.
 	 */
 	if (cb.cmd.stalefix) {
-		repo_init_revisions(&cb.cmd.revs, the_repository, prefix);
+		repo_init_revisions(the_repository, &cb.cmd.revs, prefix);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("Marking reachable objects...");
 		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3bbb25bae7..c60504891a 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -370,7 +370,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		usage(rev_list_usage);
 
 	git_config(git_default_config, NULL);
-	repo_init_revisions(&revs, the_repository, prefix);
+	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 
diff --git a/builtin/revert.c b/builtin/revert.c
index 8b18715a6a..c93393c89b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -174,7 +174,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	} else {
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
-		repo_init_revisions(opts->revs, the_repository, NULL);
+		repo_init_revisions(the_repository, opts->revs, NULL);
 		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 467265881d..88f88e97b2 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -278,7 +278,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 210f31ac86..a10b66a1eb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -792,7 +792,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			 path, NULL);
 
 	git_config(git_diff_basic_config, NULL);
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	diff_files_args.argc = setup_revisions(diff_files_args.argc,
 					       diff_files_args.argv,
diff --git a/bundle.c b/bundle.c
index 4b9a7e81fd..a5a71d059e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -140,7 +140,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
 		struct object *o = parse_object(the_repository, &e->oid);
@@ -441,7 +441,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 
 	/* write prerequisites */
 	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
diff --git a/diff-lib.c b/diff-lib.c
index 91a74f9b0c..9a3b798cb5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -542,7 +542,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 {
 	struct rev_info revs;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
 	revs.diffopt = *opt;
 
@@ -557,7 +557,7 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = def;
 	setup_revisions(0, NULL, &rev, &opt);
diff --git a/diff-no-index.c b/diff-no-index.c
index 4a32d8ef55..9414e922d1 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -246,7 +246,7 @@ void diff_no_index(struct repository *r,
 	 * FIXME: --no-index should not look at index and we should be
 	 * able to pass NULL repo. Maybe later.
 	 */
-	repo_diff_setup(&revs->diffopt, r);
+	repo_diff_setup(r, &revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
diff --git a/diff.c b/diff.c
index a435226b0b..c5b5e7ac41 100644
--- a/diff.c
+++ b/diff.c
@@ -4396,12 +4396,12 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
-void repo_diff_setup(struct diff_options *options, struct repository *repo)
+void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
 
 	options->file = stdout;
-	options->repo = repo;
+	options->repo = r;
 
 	options->abbrev = DEFAULT_ABBREV;
 	options->line_termination = '\n';
diff --git a/diff.h b/diff.h
index d41042418c..af26196224 100644
--- a/diff.h
+++ b/diff.h
@@ -336,8 +336,10 @@ int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
 int git_diff_ui_config(const char *var, const char *value, void *cb);
-void repo_diff_setup(struct diff_options *, struct repository *);
-#define diff_setup(opts) repo_diff_setup(opts, the_repository)
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
+#endif
+void repo_diff_setup(struct repository *, struct diff_options *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
 void diff_setup_done(struct diff_options *);
 int git_config_rename(const char *var, const char *value);
diff --git a/http-push.c b/http-push.c
index 9b9f990d5e..df504ab6a3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1925,7 +1925,7 @@ int cmd_main(int argc, const char **argv)
 		if (!push_all && !is_null_oid(&ref->old_oid))
 			argv_array_pushf(&commit_argv, "^%s",
 					 oid_to_hex(&ref->old_oid));
-		repo_init_revisions(&revs, the_repository, setup_git_directory());
+		repo_init_revisions(the_repository, &revs, setup_git_directory());
 		setup_revisions(commit_argv.argc, commit_argv.argv, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 2b6d7e2d2c..fec8188472 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1115,7 +1115,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	/* get all revisions that merge commit a */
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 		  oid_to_hex(&a->object.oid));
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
 	revs.single_worktree = path != NULL;
@@ -1813,7 +1813,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	repo_diff_setup(&opts, the_repository);
+	repo_diff_setup(the_repository, &opts);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
 	opts.detect_rename = merge_detect_rename(o);
diff --git a/notes-merge.c b/notes-merge.c
index 5f7490e6d7..13dd9ba158 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -126,7 +126,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
 	       oid_to_hex(base), oid_to_hex(remote));
 
-	repo_diff_setup(&opt, the_repository);
+	repo_diff_setup(the_repository, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
@@ -189,7 +189,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
 	       len, oid_to_hex(base), oid_to_hex(local));
 
-	repo_diff_setup(&opt, the_repository);
+	repo_diff_setup(the_repository, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index ed61e43f94..198fd13097 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -261,7 +261,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	if (writer.show_progress)
 		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	revs.tag_objects = 1;
 	revs.tree_objects = 1;
 	revs.blob_objects = 1;
diff --git a/patch-ids.c b/patch-ids.c
index f80c7f4b9a..7da86047d9 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -56,10 +56,10 @@ static int patch_id_cmp(const void *cmpfn_data,
 	return oidcmp(&a->patch_id, &b->patch_id);
 }
 
-int init_patch_ids(struct patch_ids *ids, struct repository *repo)
+int init_patch_ids(struct repository *r, struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
-	repo_diff_setup(&ids->diffopts, repo);
+	repo_diff_setup(r, &ids->diffopts);
 	ids->diffopts.detect_rename = 0;
 	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
diff --git a/patch-ids.h b/patch-ids.h
index 1d4cf618f9..82a12b66f8 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -21,7 +21,7 @@ struct patch_ids {
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    struct object_id *oid, int);
-int init_patch_ids(struct patch_ids *, struct repository *);
+int init_patch_ids(struct repository *, struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
 struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);
diff --git a/read-cache.c b/read-cache.c
index 0e74fe6482..b707edd044 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2141,7 +2141,7 @@ int index_has_changes(struct index_state *istate,
 	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
-		repo_diff_setup(&opt, the_repository);
+		repo_diff_setup(the_repository, &opt);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
diff --git a/ref-filter.c b/ref-filter.c
index 896e260493..f081a290cb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2138,7 +2138,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 	struct ref_array *array = ref_cbdata->array;
 	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 
 	for (i = 0; i < array->nr; i++) {
 		struct ref_array_item *item = array->items[i];
diff --git a/remote.c b/remote.c
index 3eff9fcf4d..348417f0a7 100644
--- a/remote.c
+++ b/remote.c
@@ -1903,7 +1903,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 			 oid_to_hex(&theirs->object.oid));
 	argv_array_push(&argv, "--");
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	setup_revisions(argv.argc, argv.argv, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
diff --git a/rerere.h b/rerere.h
index e01a8e5b22..5ad8864b3c 100644
--- a/rerere.h
+++ b/rerere.h
@@ -23,9 +23,11 @@ struct rerere_id {
 	int variant;
 };
 
-extern int setup_rerere(struct string_list *, int);
-extern int repo_rerere(struct repository *repo, int);
+int setup_rerere(struct string_list *, int);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define rerere(flags) repo_rerere(the_repository, flags)
+#endif
+int repo_rerere(struct repository *, int);
 /*
  * Given the conflict ID and the name of a "file" used for replaying
  * the recorded resolution (e.g. "preimage", "postimage"), return the
diff --git a/revision.c b/revision.c
index fd71f58936..28366eaccf 100644
--- a/revision.c
+++ b/revision.c
@@ -878,7 +878,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		return;
 
 	left_first = left_count < right_count;
-	init_patch_ids(&ids, revs->repo);
+	init_patch_ids(revs->repo, &ids);
 	ids.diffopts.pathspec = revs->diffopt.pathspec;
 
 	/* Compute patch-ids for one side */
@@ -1440,13 +1440,13 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
-void repo_init_revisions(struct rev_info *revs,
-		    struct repository *repo,
-		    const char *prefix)
+void repo_init_revisions(struct repository *r,
+			 struct rev_info *revs,
+			 const char *prefix)
 {
 	memset(revs, 0, sizeof(*revs));
 
-	revs->repo = repo;
+	revs->repo = r;
 	revs->abbrev = DEFAULT_ABBREV;
 	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
@@ -1472,7 +1472,7 @@ void repo_init_revisions(struct rev_info *revs,
 	grep_init(&revs->grep_filter, revs->repo, prefix);
 	revs->grep_filter.status_only = 1;
 
-	repo_diff_setup(&revs->diffopt, revs->repo);
+	repo_diff_setup(revs->repo, &revs->diffopt);
 	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
diff --git a/revision.h b/revision.h
index c7fc8522b2..7e62a65bad 100644
--- a/revision.h
+++ b/revision.h
@@ -255,10 +255,12 @@ struct setup_revision_opt {
 	unsigned revarg_opt;
 };
 
-void repo_init_revisions(struct rev_info *revs,
-		    struct repository *repo,
-		    const char *prefix);
-#define init_revisions(revs, prefix) repo_init_revisions(revs, the_repository, prefix)
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
+#endif
+void repo_init_revisions(struct repository *r,
+			 struct rev_info *revs,
+			 const char *prefix);
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
diff --git a/sequencer.c b/sequencer.c
index b81f7f68a8..3f56f8ccfe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1143,7 +1143,7 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	strbuf_release(&author_ident);
 	strbuf_release(&committer_ident);
 
-	repo_init_revisions(&rev, the_repository, prefix);
+	repo_init_revisions(the_repository, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
 	rev.diff = 1;
@@ -2566,7 +2566,7 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-	repo_init_revisions(&log_tree_opt, the_repository, NULL);
+	repo_init_revisions(the_repository, &log_tree_opt, NULL);
 	log_tree_opt.abbrev = 0;
 	log_tree_opt.diff = 1;
 	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -3477,7 +3477,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			struct object_id orig, head;
 
 			memset(&log_tree_opt, 0, sizeof(log_tree_opt));
-			repo_init_revisions(&log_tree_opt, the_repository, NULL);
+			repo_init_revisions(the_repository, &log_tree_opt, NULL);
 			log_tree_opt.diff = 1;
 			log_tree_opt.diffopt.output_format =
 				DIFF_FORMAT_DIFFSTAT;
@@ -4212,7 +4212,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	revs.verbose_header = 1;
 	if (!rebase_merges)
 		revs.max_parents = 1;
diff --git a/shallow.c b/shallow.c
index 9209582054..e656ce8b9c 100644
--- a/shallow.c
+++ b/shallow.c
@@ -184,7 +184,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 
 	is_repository_shallow(the_repository); /* make sure shallows are read */
 
-	repo_init_revisions(&revs, the_repository, NULL);
+	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, NULL);
 
diff --git a/submodule.c b/submodule.c
index eeb3e481a7..9fcaf0246f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -428,7 +428,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 {
 	struct commit_list *list;
 
-	repo_init_revisions(rev, the_repository, NULL);
+	repo_init_revisions(the_repository, rev, NULL);
 	setup_revisions(0, NULL, rev, NULL);
 	rev->left_right = 1;
 	rev->first_parent_only = 1;
@@ -773,7 +773,7 @@ static void collect_changed_submodules(struct index_state *istate,
 	struct rev_info rev;
 	const struct commit *commit;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	setup_revisions(argv->argc, argv->argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
@@ -784,7 +784,7 @@ static void collect_changed_submodules(struct index_state *istate,
 		data.changed = changed;
 		data.commit_oid = &commit->object.oid;
 
-		repo_init_revisions(&diff_rev, the_repository, NULL);
+		repo_init_revisions(the_repository, &diff_rev, NULL);
 		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
 		diff_rev.diffopt.format_callback_data = &data;
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index ead4d96e28..625b2dbf82 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -32,7 +32,7 @@ static int run_revision_walk(void)
 	int argc = ARRAY_SIZE(argv) - 1;
 	int got_revision = 0;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	setup_revisions(argc, argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
diff --git a/tree-diff.c b/tree-diff.c
index 24ef60ab96..16b28ff6d6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -605,7 +605,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	repo_diff_setup(&diff_opts, opt->repo);
+	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
diff --git a/wt-status.c b/wt-status.c
index 22cf6cca25..2f743941d5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -582,7 +582,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 {
 	struct rev_info rev;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.flags.dirty_submodules = 1;
@@ -607,7 +607,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
@@ -982,7 +982,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	int dirty_submodules;
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	repo_init_revisions(&rev, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev, NULL);
 	rev.diffopt.flags.allow_textconv = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 
@@ -2314,7 +2314,7 @@ int has_unstaged_changes(int ignore_submodules)
 	struct rev_info rev_info;
 	int result;
 
-	repo_init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev_info, NULL);
 	if (ignore_submodules) {
 		rev_info.diffopt.flags.ignore_submodules = 1;
 		rev_info.diffopt.flags.override_submodule_config = 1;
@@ -2336,7 +2336,7 @@ int has_uncommitted_changes(int ignore_submodules)
 	if (is_cache_unborn())
 		return 0;
 
-	repo_init_revisions(&rev_info, the_repository, NULL);
+	repo_init_revisions(the_repository, &rev_info, NULL);
 	if (ignore_submodules)
 		rev_info.diffopt.flags.ignore_submodules = 1;
 	rev_info.diffopt.flags.quick = 1;

Nguyễn Thái Ngọc Duy (23):
  archive.c: remove implicit dependency the_repository
  read-cache.c: remove 'const' from index_has_changes()
  diff.c: reduce implicit dependency on the_index
  combine-diff.c: remove implicit dependency on the_index
  blame.c: rename "repo" argument to "r"
  diff.c: remove the_index dependency in textconv() functions
  grep.c: remove implicit dependency on the_index
  diff.c: remove implicit dependency on the_index
  read-cache.c: remove implicit dependency on the_index
  diff-lib.c: remove implicit dependency on the_index
  ll-merge.c: remove implicit dependency on the_index
  merge-blobs.c: remove implicit dependency on the_index
  merge.c: remove implicit dependency on the_index
  patch-ids.c: remove implicit dependency on the_index
  sha1-file.c: remove implicit dependency on the_index
  rerere.c: remove implicit dependency on the_index
  userdiff.c: remove implicit dependency on the_index
  line-range.c: remove implicit dependency on the_index
  submodule.c: remove implicit dependency on the_index
  tree-diff.c: remove implicit dependency on the_index
  ws.c: remove implicit dependency on the_index
  revision.c: remove implicit dependency on the_index
  revision.c: reduce implicit dependency the_repository

 Documentation/technical/api-diff.txt          |   4 +-
 .../technical/api-revision-walking.txt        |   2 +-
 apply.c                                       |  19 +-
 archive-zip.c                                 |  14 +-
 archive.c                                     |   2 +-
 bisect.c                                      |   4 +-
 blame.c                                       |  63 +++--
 builtin/add.c                                 |   4 +-
 builtin/am.c                                  |  10 +-
 builtin/blame.c                               |   4 +-
 builtin/cat-file.c                            |   6 +-
 builtin/checkout.c                            |   7 +-
 builtin/commit.c                              |   4 +-
 builtin/describe.c                            |   4 +-
 builtin/diff-files.c                          |   2 +-
 builtin/diff-index.c                          |   2 +-
 builtin/diff-tree.c                           |   2 +-
 builtin/diff.c                                |   4 +-
 builtin/difftool.c                            |   2 +-
 builtin/fast-export.c                         |   2 +-
 builtin/fmt-merge-msg.c                       |   2 +-
 builtin/grep.c                                |   7 +-
 builtin/hash-object.c                         |   2 +-
 builtin/log.c                                 |  25 +-
 builtin/merge-tree.c                          |   2 +-
 builtin/merge.c                               |  16 +-
 builtin/pack-objects.c                        |   2 +-
 builtin/prune.c                               |   2 +-
 builtin/pull.c                                |   9 +-
 builtin/range-diff.c                          |   2 +-
 builtin/reflog.c                              |   2 +-
 builtin/replace.c                             |   2 +-
 builtin/rerere.c                              |   6 +-
 builtin/reset.c                               |   1 +
 builtin/rev-list.c                            |   2 +-
 builtin/revert.c                              |   2 +-
 builtin/shortlog.c                            |   2 +-
 builtin/submodule--helper.c                   |   2 +-
 builtin/update-index.c                        |   2 +-
 bundle.c                                      |   4 +-
 cache.h                                       |  14 +-
 combine-diff.c                                |  32 ++-
 diff-lib.c                                    |  21 +-
 diff-no-index.c                               |   9 +-
 diff.c                                        | 261 ++++++++++--------
 diff.h                                        |  22 +-
 diffcore-break.c                              |  12 +-
 diffcore-delta.c                              |  12 +-
 diffcore-pickaxe.c                            |   8 +-
 diffcore-rename.c                             |  35 ++-
 diffcore.h                                    |  13 +-
 grep.c                                        |  34 ++-
 grep.h                                        |  10 +-
 http-push.c                                   |   2 +-
 line-log.c                                    |  25 +-
 line-range.c                                  |  22 +-
 line-range.h                                  |   6 +-
 list-objects.c                                |   8 +-
 ll-merge.c                                    |  17 +-
 ll-merge.h                                    |   5 +-
 merge-blobs.c                                 |  16 +-
 merge-blobs.h                                 |   7 +-
 merge-recursive.c                             |   7 +-
 merge.c                                       |  20 +-
 notes-merge.c                                 |   9 +-
 pack-bitmap-write.c                           |   2 +-
 patch-ids.c                                   |   4 +-
 patch-ids.h                                   |   3 +-
 read-cache.c                                  |  33 ++-
 ref-filter.c                                  |   2 +-
 remote.c                                      |   2 +-
 rerere.c                                      | 121 ++++----
 rerere.h                                      |  10 +-
 revision.c                                    |  76 ++---
 revision.h                                    |  15 +-
 sequencer.c                                   |  18 +-
 sha1-file.c                                   |  50 ++--
 shallow.c                                     |   2 +-
 submodule.c                                   |  34 ++-
 submodule.h                                   |   9 +-
 t/helper/test-revision-walking.c              |   2 +-
 transport.c                                   |   9 +-
 tree-diff.c                                   |   2 +-
 userdiff.c                                    |   5 +-
 userdiff.h                                    |   3 +-
 ws.c                                          |   5 +-
 wt-status.c                                   |  10 +-
 87 files changed, 748 insertions(+), 551 deletions(-)

-- 
2.19.0.rc0.337.ge906d732e7

