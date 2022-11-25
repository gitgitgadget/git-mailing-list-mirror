Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41086C433FE
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 02:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKYCpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 21:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYCpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 21:45:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF1E2B1AF
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 18:45:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p16so2476278wmc.3
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 18:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbirLwLxeacLcB0uCUaxVhU7gs5b024Ye2gbMComMqo=;
        b=Nzx9ge0wUX2oGdo7wzz9RvzFv+IhgDrlbiH/ii9HyUJiSNP9wJETGsLZPgJfHK0b+X
         NABQr9nujLfQ983vF6fXTRZUuTMQ5ROsqV4SJ4huAHMMaPdtnG8IsNRL/d7+RIElHova
         JaFrqAtoQhU/4U/sfW0TzHgVPTi7Iy2ThyKej/DaJBkB5vZb4ZdUAYCES8bHPBDUi+jC
         rIZBR/0bMgeh62HXYWcrKj9s1lxaWiBy8veLP7E7Wo2n265mpsFOaL1qZ87CwJaGnnxl
         Esmpq6atuo3MuFLZn54lkCpz0HMpMSVM+vqMiUeU+7kDFIUIu+MARTGgD/bOs0xVVANA
         vKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbirLwLxeacLcB0uCUaxVhU7gs5b024Ye2gbMComMqo=;
        b=zEy7tJwh920rGmo2BzpNTGFfbBoncYnwpP5UukR6B/HvlTt9Fb2Q79moak63/e1LLd
         bwdQnUA1CQb2WOpg8QTPHCdi8WkCRXQ0aGKfeLQ1BaUqhSjt3GxJj4ySjQCH7IFWwQAw
         gcuDsF+9VkUBzSQGScGaojx1JVxiuujLbpisT4ruTH93XcnicKOCiiL1laFMttk1a0KG
         U1RHvvh6ELrHWH0gkcNaTEwUGqBZ+3kXOBfUhvztjLPdi3R3aps4AoTQ2qx+7x4o3ZkZ
         iXUEtQzKrWu93NNVbZsG2Y7yBvTKK4FuigUMFD7nRdE0fECM2YgSNI6MrEhMhWjECGQN
         tl+w==
X-Gm-Message-State: ANoB5pl2ARR4LjwJ+rSN83sSoTPCuxBEH39x7eAtB74eKH9qR361L6a5
        98xGsg2q78nVh8sRLxoQvn+UmzCTHMA=
X-Google-Smtp-Source: AA0mqf4erjzBt+81DBC4BrXYOk3MqmUH0drG5UZ3DqYta9BopzTzDQoxq7L4YIFHqlkvGF7IUt20FA==
X-Received: by 2002:a1c:f401:0:b0:3c7:84d:72d with SMTP id z1-20020a1cf401000000b003c7084d072dmr11992469wma.181.1669344335596;
        Thu, 24 Nov 2022 18:45:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020a5d6944000000b0022cc0a2cbecsm2655643wrw.15.2022.11.24.18.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 18:45:34 -0800 (PST)
Message-Id: <pull.1398.v2.git.1669344333627.gitgitgadget@gmail.com>
In-Reply-To: <pull.1398.git.1667189512579.gitgitgadget@gmail.com>
References: <pull.1398.git.1667189512579.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 02:45:33 +0000
Subject: [PATCH v2] [RFC] diff: introduce --scope option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Many of git commands, such as "git grep", "git diff", they
will search the "full-tree" scope of the entire git repository,
which is reasonable under normal circumstances, but if the user
uses sparse checkout in a git monorepo, it's very possible that
he just wants to use files within the sparse specification,
perhaps because:

* He wants to be able to focus on his subprojects, the output
of other subprojects will only interfere with him.

* He's using partial cloning at the same time, and he doesn't
want to be able to execute the above git commands download a
large number of blobs which out of sparse specification, which
is a waste of time and may cause the size of the git repository
to gradually expand.

So we need a way to restrict git commands to the sparse
specification. Implementing "diff --scope" is the first step
in this plan. We are looking for a suitable option to choose:
restrict the path scope of diff to the sparse specification
or keep the full tree scope (default action now). "--scope=sparse",
"--scope=all" are the parameters corresponding to these two
cases.

It is worth noting that "--scope" option only works on diff
commands specify "--cached" or "REVISION", because normal
"git diff" has retrict the scope of diff files to the sparse
specificaiton by default, while "git diff --cached" or
"git diff REVSION" will compare to the commit history, and
"--scope" options can works here to restrict or not.

Add "--scope" option to git "diff-index" and "git diff-tree"
too, because they also meet the above: specify "--cached",
or "REVISION". Meanwhile, "git diff-no-index", "git diff-files"
don't have this option.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [RFC] diff: introduce scope option
    
    In [1], we discovered that users working on different sparse-checkout
    specification may download unnecessary blobs from each other's
    specification in collaboration. In [2] Junio suggested that maybe we can
    restrict some git command's filespec in sparse-checkout specification to
    elegantly solve this problem above. In [3]: Newren and Derrick Stolee
    prefer to name the option --scope={sparse, all}.
    
    So this patch is attempt to do this thing on git diff:
    
    v1:
    
     1. add --restrict option to git diff, which restrict diff filespec in
        sparse-checkout specification. [4]
    
    v2.
    
     1. rename --restrict to --scope={sparse, all}, support --no-scope.
     2. add config: diff.scope={sparse,all}.
    
    v3.
    
     1. with the help of newren's review, fix the wrong --scope behavior,
        its previous meaning was misrepresented as sparse patterns, and now
        it is fixed to match sparse specification. [5]
     2. remove wrong diff.scope config.
     3. apply --scope to git diff, git diff-index, git diff-tree.
    
    Since I split --scope into a separate option, this option will not be
    directly inherited by git commands such as git log, git format-patch,
    etc. If necessary, we can add it to git log or other commands in a
    similar way later.
    
    Global scope config haven’t implement yet... Since we haven't decided on
    an appropriate name for scope config. [6]
    
    [1]:
    https://lore.kernel.org/git/CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com/
    [2]: https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/ [3]:
    https://lore.kernel.org/git/07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com/
    [4]:
    https://lore.kernel.org/git/pull.1368.git.1664036052741.gitgitgadget@gmail.com/
    [5]:
    https://lore.kernel.org/git/CAOLTT8TceM-NpV2_hUCZj2Dx=W30f_9SHW8CcRH-pw32BRd-oA@mail.gmail.com/
    [6]:
    https://lore.kernel.org/git/CABPp-BGHMsMxP6e7p0HAZA=ugk+GY3XW6_EaTN=HzaLQYAzQYA@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1398%2Fadlternative%2Fzh%2Fdiff-scope-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1398/adlternative/zh/diff-scope-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1398

Contributor requested no range-diff. You can review it using these commands:
   git fetch https://github.com/gitgitgadget/git 63bba4fd 471a0691
   git range-diff <options> 63bba4fd..93ddbcbd c000d916..471a0691

 Documentation/diff-options.txt        |  33 +++
 builtin/diff-index.c                  |  29 ++-
 builtin/diff-tree.c                   |  15 ++
 builtin/diff.c                        |  46 ++++-
 cache.h                               |   5 +
 diff-lib.c                            |  44 ++++
 diff.c                                |   2 +
 diff.h                                |   8 +
 dir.c                                 |  20 ++
 dir.h                                 |   4 +
 t/t4070-diff-sparse-checkout-scope.sh | 286 ++++++++++++++++++++++++++
 tree-diff.c                           |  11 +
 12 files changed, 497 insertions(+), 6 deletions(-)
 create mode 100755 t/t4070-diff-sparse-checkout-scope.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3674ac48e92..778b22ae982 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -195,6 +195,39 @@ For instance, if you configured the `diff.algorithm` variable to a
 non-default value and want to use the default one, then you
 have to use `--diff-algorithm=default` option.
 
+ifdef::git-diff[]
+ifdef::git-diff-index[]
+ifdef::git-diff-tree[]
+
+--scope=[sparse|all]::
+	Restrict or not restrict diff path scope in sparse specification.
+	The variants are as follows:
+
++
+--
+`sparse`;;
+	When using diff to compare commit history, restrict the
+	scope of file path comparisons to the sparse specification.
+	See sparse specification in link:technical/sparse-checkout.html
+	[the sparse-checkout design document] for more information.
+`all`;;
+	When using diff to compare commit history, the file comparison
+	scope is full-tree. This is consistent with the current default
+	behavior.
+--
++
+
+Note that `--scope` option only take effect if diff command specify
+`--cached` or `REVISION`.
+
+The behavior of this `--scope` option is experimental and may change
+in the future. See link:technical/sparse-checkout.html [the sparse-checkout
+design document] for more information.
+
+endif::git-diff-tree[]
+endif::git-diff-index[]
+endif::git-diff[]
+
 --stat[=<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index aea139b9d8f..9cf37af8990 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -20,6 +20,14 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	unsigned int option = 0;
 	int i;
 	int result;
+	enum sparse_scope scope;
+
+	struct option sparse_scope_options[] = {
+		OPT_CALLBACK_F(0, "scope", &scope, N_("[sparse|all]"),
+				N_("restrict path scope in sparse specification"),
+				PARSE_OPT_NONEG, diff_opt_sparse_scope),
+		OPT_END()
+	};
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(diff_cache_usage);
@@ -36,6 +44,15 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	diff_merges_suppress_m_parsing();
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
+
+	argc = parse_options(argc, argv, prefix, sparse_scope_options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_NO_INTERNAL_HELP);
+
+	rev.diffopt.scope = scope;
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -66,9 +83,15 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 			perror("read_cache_preload");
 			return -1;
 		}
-	} else if (read_cache() < 0) {
-		perror("read_cache");
-		return -1;
+	} else {
+		if (read_cache() < 0) {
+			perror("read_cache");
+			return -1;
+		}
+		if (rev.diffopt.scope == SPARSE_SCOPE_SPARSE &&
+		    strcmp(rev.pending.objects[0].name, "HEAD"))
+			diff_collect_changes_index(&rev.diffopt.pathspec,
+						   &rev.diffopt.change_index_files);
 	}
 	result = run_diff_index(&rev, option);
 	result = diff_result_code(&rev.diffopt, result);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 85e8c81e594..5da13bdb5ca 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -114,6 +114,14 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	struct userformat_want w;
 	int read_stdin = 0;
 	int merge_base = 0;
+	enum sparse_scope scope;
+
+	struct option sparse_scope_options[] = {
+		OPT_CALLBACK_F(0, "scope", &scope, N_("[sparse|all]"),
+				N_("restrict path scope in sparse specification"),
+				PARSE_OPT_NONEG, diff_opt_sparse_scope),
+		OPT_END()
+	};
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(diff_tree_usage);
@@ -131,6 +139,13 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 	argc = setup_revisions(argc, argv, opt, &s_r_opt);
 
+	argc = parse_options(argc, argv, prefix, sparse_scope_options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_NO_INTERNAL_HELP);
+	opt->diffopt.scope = scope;
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 854d2c5a5c4..e30b3548c78 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -161,9 +161,15 @@ static int builtin_diff_index(struct rev_info *revs,
 			perror("read_cache_preload");
 			return -1;
 		}
-	} else if (read_cache() < 0) {
-		perror("read_cache");
-		return -1;
+	} else {
+		if (read_cache() < 0) {
+			perror("read_cache");
+			return -1;
+		}
+		if (revs->diffopt.scope == SPARSE_SCOPE_SPARSE &&
+		    strcmp(revs->pending.objects[0].name, "HEAD"))
+			diff_collect_changes_index(&revs->diffopt.pathspec,
+						   &revs->diffopt.change_index_files);
 	}
 	return run_diff_index(revs, option);
 }
@@ -388,6 +394,25 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 	sym->skip = map;
 }
 
+int diff_opt_sparse_scope(const struct option *option,
+				const char *optarg, int unset)
+{
+	enum sparse_scope *scope = option->value;
+
+	BUG_ON_OPT_NEG_NOARG(unset, optarg);
+
+	if (!core_apply_sparse_checkout)
+		return error(_("this git repository don't "
+			       "use sparse-checkout, --scope option cannot be used"));
+	if (!strcmp(optarg, "all"))
+		*scope = SPARSE_SCOPE_ALL;
+	else if (!strcmp(optarg, "sparse"))
+		*scope = SPARSE_SCOPE_SPARSE;
+	else
+		return error(_("invalid --scope value: %s"), optarg);
+	return 0;
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -399,6 +424,14 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int nongit = 0, no_index = 0;
 	int result = 0;
 	struct symdiff sdiff;
+	enum sparse_scope scope;
+
+	struct option sparse_scope_options[] = {
+		OPT_CALLBACK_F(0, "scope", &scope, N_("[sparse|all]"),
+				N_("restrict path scope in sparse specification"),
+				PARSE_OPT_NONEG, diff_opt_sparse_scope),
+		OPT_END()
+	};
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -504,6 +537,13 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		diff_setup_done(&rev.diffopt);
 	}
 
+	argc = parse_options(argc, argv, prefix, sparse_scope_options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_NO_INTERNAL_HELP);
+
+	rev.diffopt.scope = scope;
 	rev.diffopt.flags.recursive = 1;
 	rev.diffopt.rotate_to_strict = 1;
 
diff --git a/cache.h b/cache.h
index 26ed03bd6de..e3bb2f3dde0 100644
--- a/cache.h
+++ b/cache.h
@@ -1082,6 +1082,11 @@ extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
+enum sparse_scope {
+	SPARSE_SCOPE_ALL = 0,
+	SPARSE_SCOPE_SPARSE,
+};
+
 /*
  * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
  */
diff --git a/diff-lib.c b/diff-lib.c
index 2edea41a234..69770ca62a6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -445,6 +445,13 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 
 	match_missing = revs->match_missing;
 
+	if (revs->diffopt.scope == SPARSE_SCOPE_SPARSE &&
+	    ((o->index_only && revs->pending.objects[0].name &&
+	      strcmp(revs->pending.objects[0].name, "HEAD") &&
+	      !index_file_in_sparse_specification(idx ? idx : tree, &revs->diffopt.change_index_files)) ||
+	     (!o->index_only && !worktree_file_in_sparse_specification(idx))))
+		return;
+
 	if (cached && idx && ce_stage(idx)) {
 		struct diff_filepair *pair;
 		pair = diff_unmerge(&revs->diffopt, idx->name);
@@ -598,6 +605,43 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 	free_commit_list(merge_bases);
 }
 
+static void diff_collect_updated_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data) {
+	int i;
+	struct strset *change_index_files = (struct strset *)data;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+
+		strset_add(change_index_files, p->two->path);
+		if (p->status == DIFF_STATUS_RENAMED)
+			strset_add(change_index_files, p->one->path);
+	}
+}
+
+void diff_collect_changes_index(struct pathspec *pathspec, struct strset *change_index_files)
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt;
+
+	repo_init_revisions(the_repository, &rev, NULL);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	setup_revisions(0, NULL, &rev, &opt);
+
+	rev.diffopt.ita_invisible_in_index = 1;
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = diff_collect_updated_cb;
+	rev.diffopt.format_callback_data = change_index_files;
+	rev.diffopt.flags.recursive = 1;
+
+	copy_pathspec(&rev.prune_data, pathspec);
+	run_diff_index(&rev, 1);
+	release_revisions(&rev);
+}
+
+
 int run_diff_index(struct rev_info *revs, unsigned int option)
 {
 	struct object_array_entry *ent;
diff --git a/diff.c b/diff.c
index 9f9a92ec9d2..cdbcacd7332 100644
--- a/diff.c
+++ b/diff.c
@@ -4663,6 +4663,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 	options->color_moved = diff_color_moved_default;
 	options->color_moved_ws_handling = diff_color_moved_ws_default;
 
+	strset_init(&options->change_index_files);
 	prep_parse_options(options);
 }
 
@@ -6511,6 +6512,7 @@ void diff_free(struct diff_options *options)
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
 	FREE_AND_NULL(options->parseopts);
+	strset_clear(&options->change_index_files);
 }
 
 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index fd33caeb25d..4098a0cb123 100644
--- a/diff.h
+++ b/diff.h
@@ -8,6 +8,7 @@
 #include "pathspec.h"
 #include "object.h"
 #include "oidset.h"
+#include "strmap.h"
 
 /**
  * The diff API is for programs that compare two sets of files (e.g. two trees,
@@ -285,6 +286,9 @@ struct diff_options {
 	/* diff-filter bits */
 	unsigned int filter, filter_not;
 
+	/* diff sparse-checkout scope */
+	enum sparse_scope scope;
+
 	int use_color;
 
 	/* Number of context lines to generate in patch output. */
@@ -397,6 +401,7 @@ struct diff_options {
 	struct option *parseopts;
 	struct strmap *additional_path_headers;
 
+	struct strset change_index_files;
 	int no_free;
 };
 
@@ -696,4 +701,7 @@ void print_stat_summary(FILE *fp, int files,
 			int insertions, int deletions);
 void setup_diff_pager(struct diff_options *);
 
+void diff_collect_changes_index(struct pathspec *pathspec, struct strset *files);
+int diff_opt_sparse_scope(const struct option *option, const char *optarg, int unset);
+
 #endif /* DIFF_H */
diff --git a/dir.c b/dir.c
index d604d1bab98..010e243f24a 100644
--- a/dir.c
+++ b/dir.c
@@ -1503,6 +1503,26 @@ int path_in_cone_mode_sparse_checkout(const char *path,
 	return path_in_sparse_checkout_1(path, istate, 1);
 }
 
+int path_in_sparse_patterns(const char *path) {
+	return path_in_sparse_checkout_1(path, the_repository->index, core_sparse_checkout_cone);
+}
+
+/* Expand sparse-checkout specification (worktree) */
+int worktree_file_in_sparse_specification(const struct cache_entry *worktree_check_ce)
+{
+	return worktree_check_ce && !ce_skip_worktree(worktree_check_ce);
+}
+
+/* Expand sparse-checkout specification (index) */
+int index_file_in_sparse_specification(const struct cache_entry *ce, struct strset *change_index_files)
+{
+	if (!ce->ce_namelen)
+		return 0;
+	if (change_index_files && strset_contains(change_index_files, ce->name))
+		return 1;
+	return path_in_sparse_patterns(ce->name);
+}
+
 static struct path_pattern *last_matching_pattern_from_lists(
 		struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int pathlen,
diff --git a/dir.h b/dir.h
index 674747d93af..254268bb9a0 100644
--- a/dir.h
+++ b/dir.h
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "hashmap.h"
 #include "strbuf.h"
+#include "strmap.h"
 
 /**
  * The directory listing API is used to enumerate paths in the work tree,
@@ -401,6 +402,9 @@ int path_in_sparse_checkout(const char *path,
 			    struct index_state *istate);
 int path_in_cone_mode_sparse_checkout(const char *path,
 				      struct index_state *istate);
+int path_in_sparse_patterns(const char *path);
+int index_file_in_sparse_specification(const struct cache_entry *ce, struct strset *change_index_files);
+int worktree_file_in_sparse_specification(const struct cache_entry *worktree_check_ce);
 
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
diff --git a/t/t4070-diff-sparse-checkout-scope.sh b/t/t4070-diff-sparse-checkout-scope.sh
new file mode 100755
index 00000000000..b8e3bfbaf5b
--- /dev/null
+++ b/t/t4070-diff-sparse-checkout-scope.sh
@@ -0,0 +1,286 @@
+#!/bin/sh
+
+test_description='diff sparse-checkout scope'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init repo &&
+	(
+		cd repo &&
+		mkdir in out1 out2 &&
+		for i in $(test_seq 6)
+		do
+			echo "in $i" >in/"$i" &&
+			echo "out1 $i" >out1/"$i" &&
+			echo "out2 $i" >out2/"$i" || return 1
+		done &&
+		git add in out1 out2 &&
+		git commit -m init &&
+		for i in $(test_seq 6)
+		do
+			echo "in $i" >>in/"$i" &&
+			echo "out1 $i" >>out1/"$i" || return 1
+		done &&
+		git add in out1 &&
+		git commit -m change &&
+		git sparse-checkout set "in"
+	)
+'
+
+reset_sparse_checkout_state() {
+	git -C repo reset --hard HEAD &&
+	git -C repo sparse-checkout reapply
+}
+
+reset_and_change_index() {
+	reset_sparse_checkout_state &&
+	# add new ce
+	oid=$(echo "new thing" | git -C repo hash-object --stdin -w) &&
+	git -C repo update-index --add --cacheinfo 100644 $oid in/7 &&
+	git -C repo update-index --add --cacheinfo 100644 $oid out1/7 &&
+	# rm ce
+	git -C repo update-index --remove in/6 &&
+	git -C repo update-index --remove out1/6 &&
+	# modify ce
+	git -C repo update-index --cacheinfo 100644 $oid out1/5 &&
+	# mv ce1 -> ce2
+	oid=$(git -C repo ls-files --format="%(objectname)" in/4) &&
+	git -C repo update-index --add --cacheinfo 100644 $oid in/8 &&
+	git -C repo update-index --remove in/4 &&
+	oid=$(git -C repo ls-files --format="%(objectname)" out1/4) &&
+	git -C repo update-index --add --cacheinfo 100644 $oid out1/8 &&
+	git -C repo update-index --remove out1/4 &&
+	# chmod ce
+	git -C repo update-index --chmod +x in/3 &&
+	git -C repo update-index --chmod +x out1/3
+}
+
+reset_and_change_worktree() {
+	reset_sparse_checkout_state &&
+	rm -rf repo/out1 repo/out2 &&
+	mkdir repo/out1 repo/out2 &&
+	# add new file
+	echo "in 7" >repo/in/7 &&
+	echo "out1 7" >repo/out1/7 &&
+	git -C repo add --sparse in/7 out1/7 &&
+	# create out old file
+	>repo/out1/6 &&
+	# rm file
+	rm repo/in/6 &&
+	# modify file
+	echo "out1 x" >repo/out1/5 &&
+	# mv file1 -> file2
+	mv repo/in/4 repo/in/3 &&
+	# chmod file
+	chmod +x repo/in/2 &&
+	# add new file, mark skipworktree
+	echo "in 8" >repo/in/8 &&
+	echo "out1 8" >repo/out1/8 &&
+	echo "out2 8" >repo/out2/8 &&
+	git -C repo add --sparse in/8 out1/8 out2/8 &&
+	git -C repo update-index --skip-worktree in/8 &&
+	git -C repo update-index --skip-worktree out1/8 &&
+	git -C repo update-index --skip-worktree out2/8 &&
+	rm repo/in/8 repo/out1/8
+}
+
+# git diff --cached REV
+
+test_expect_success 'git diff --cached --scope=all' '
+	reset_and_change_index &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+A	in/7
+A	in/8
+M	out1/1
+M	out1/2
+M	out1/3
+M	out1/5
+D	out1/6
+A	out1/7
+R050	out1/4	out1/8
+	EOF
+	git -C repo diff --name-status --cached --scope=all HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff --cached --scope=sparse' '
+	reset_and_change_index &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+A	in/7
+A	in/8
+M	out1/3
+M	out1/5
+D	out1/6
+A	out1/7
+R050	out1/4	out1/8
+	EOF
+	git -C repo diff --name-status --cached --scope=sparse HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+# git diff REV
+
+test_expect_success 'git diff REVISION --scope=all' '
+	reset_and_change_worktree &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+D	in/4
+M	in/5
+D	in/6
+A	in/7
+M	out1/1
+M	out1/2
+M	out1/3
+M	out1/4
+M	out1/5
+M	out1/6
+A	out1/7
+A	out2/8
+	EOF
+	git -C repo diff --name-status --scope=all HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff REVISION --scope=sparse' '
+	reset_and_change_worktree &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+D	in/4
+M	in/5
+D	in/6
+A	in/7
+M	out1/5
+M	out1/6
+A	out1/7
+A	out2/8
+	EOF
+	git -C repo diff --name-status --scope=sparse HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+# git diff REV1 REV2
+
+test_expect_success 'git diff two REVISION --scope=all' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+M	out1/1
+M	out1/2
+M	out1/3
+M	out1/4
+M	out1/5
+M	out1/6
+	EOF
+	git -C repo diff --name-status --scope=all HEAD~ HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff two REVISION --scope=sparse' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+	EOF
+	git -C repo diff --name-status --scope=sparse HEAD~ HEAD >actual &&
+	test_cmp expected actual
+'
+
+# git diff-index
+
+test_expect_success 'git diff-index --cached --scope=all' '
+	reset_and_change_index &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+A	in/7
+A	in/8
+M	out1/1
+M	out1/2
+M	out1/3
+D	out1/4
+M	out1/5
+D	out1/6
+A	out1/7
+A	out1/8
+	EOF
+	git -C repo diff-index --name-status --cached --scope=all HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff-index --cached --scope=sparse' '
+	reset_and_change_index &&
+	cat >expected <<-EOF &&
+M	in/1
+M	in/2
+M	in/3
+M	in/4
+M	in/5
+M	in/6
+A	in/7
+A	in/8
+M	out1/3
+D	out1/4
+M	out1/5
+D	out1/6
+A	out1/7
+A	out1/8
+	EOF
+	git -C repo diff-index --name-status --cached --scope=sparse HEAD~ >actual &&
+	test_cmp expected actual
+'
+
+# git diff-tree
+
+test_expect_success 'git diff-tree --scope=all' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+M	in
+M	out1
+	EOF
+	git -C repo diff-tree --name-status --scope=all HEAD~ HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff-tree --scope=sparse' '
+	reset_sparse_checkout_state &&
+	cat >expected <<-EOF &&
+M	in
+	EOF
+	git -C repo diff-tree --name-status --scope=sparse HEAD~ HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/tree-diff.c b/tree-diff.c
index 69031d7cbae..921665d0286 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "dir.h"
 
 /*
  * internal mode marker, saying a tree entry != entry of tp[imin]
@@ -76,6 +77,16 @@ static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
 static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_diff_path *p)
 {
 	struct combine_diff_parent *p0 = &p->parent[0];
+
+	if (opt->scope == SPARSE_SCOPE_SPARSE) {
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_addstr(&sb, p->path);
+		if (S_ISDIR(p->mode) || S_ISDIR(p0->mode))
+			strbuf_addch(&sb, '/');
+		if (!path_in_sparse_patterns(sb.buf))
+			return 0;
+	}
 	if (p->mode && p0->mode) {
 		opt->change(opt, p0->mode, p->mode, &p0->oid, &p->oid,
 			1, 1, p->path, 0, 0);

base-commit: c000d916380bb59db69c78546928eadd076b9c7d
-- 
gitgitgadget
