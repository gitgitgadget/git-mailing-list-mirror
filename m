Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F7C38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 11:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjAWLqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 06:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjAWLqR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 06:46:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096A1C17F
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 03:46:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l8so8770367wms.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 03:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQzvsRk71r2E7o5WZlurIX0aWOk3gGJST2D4wrMABas=;
        b=kss/5xi7yuHNZNcmzdBs6KELf4KpvHybSeKNoQj8xj3eSkarndJtmnvSa3Jho2zS++
         9XydeAWCn3K+3kCDINrjQVu0fow+nOuw6vYtW1/cMZfqnQV1uou7ci30QnKOyf/Mea3B
         LYDZPRallZ9OYV4glLGYpt3FcY+rvbohBbcvNSpluGPYWH0Euv1/dQf0NorIkDrJdYsm
         ynuOMs2fz80BuJAQlco/e9YMhUysdqXxyRtUZJFSMMgy98yeeNFg+Sib6ywVSNYud+i1
         4MzQBoDawReWpa5nHoX9yCLkQCb+WhnzTcWhh2y6rUtqMFxNJS17a8Wwn+QbBlqhKcaC
         Sltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQzvsRk71r2E7o5WZlurIX0aWOk3gGJST2D4wrMABas=;
        b=aFEEb+ZX3NgvJgn3xqngRaXXmbPRoKCgLzL5ZokI/3TP3kae9YpuNHkXoqG99HXOow
         3yGEFeaDTLBZqV/dg2c+DW8o6Z+1dhUKm/Tp150/RG1P2ILVzEdB/oYt9AzSz4liLuyZ
         l3q+upZrld3U5PbI5GApPmo+4bphikw6QDti2eNTFOoBBdGTjAH/cj2fddHA1HdqHHr0
         +d4ufk70llUwrpw9JMvTR9RtShiO3FtidMBtKxLJn50gSrV7COaiqGrMO9whwK9JQ/2X
         foN1y0+vlI/9AQ4sS3MQzmags2tV3sVTu4N8SZjvHqNf0u70NizkJCFdPmyiBrv+75M8
         mVlA==
X-Gm-Message-State: AFqh2kr3mit6IxpwXMLrrGQMq2cEgis8ic6pHlW3GIku/2sjlw0SX4Cd
        bzXHCPr1FF4EK33JLsXmclKeTFiWU9U=
X-Google-Smtp-Source: AMrXdXvs+pZmZdGunQdRY+M/KUXdvQoehB9NsKKnTdxmGIa1dd7hYzweowS6ePdT2lHYp8vabc9ang==
X-Received: by 2002:a05:600c:1d8e:b0:3d1:ebdf:d586 with SMTP id p14-20020a05600c1d8e00b003d1ebdfd586mr23160352wms.29.1674474373064;
        Mon, 23 Jan 2023 03:46:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6-20020adffb06000000b002423620d356sm22090158wrr.35.2023.01.23.03.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 03:46:12 -0800 (PST)
Message-Id: <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
In-Reply-To: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 11:46:11 +0000
Subject: [PATCH v2] ls-tree: add --sparse-filter-oid argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>,
        William Sprent <williams@unity3d.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Sprent <williams@unity3d.com>

There is currently no way to ask git the question "which files would be
part of a sparse checkout of commit X with sparse checkout patterns Y".
One use-case would be that tooling may want know whether sparse checkouts
of two commits contain the same content even if the full trees differ.
Another interesting use-case would be for tooling to use in conjunction
with 'git update-index --index-info'.

'rev-list --objects --filter=sparse:oid' comes close, but as rev-list is
concerned with objects rather than directory trees, it leaves files out
when the same blob occurs in at two different paths.

It is possible to ask git about the sparse status of files currently in
the index with 'ls-files -t'. However, this does not work well when the
caller is interested in another commit, intererested in sparsity
patterns that aren't currently in '.git/info/sparse-checkout', or when
working in with bare repo.

To fill this gap, add a new argument to ls-tree '--sparse-filter-oid'
which takes the object id of a blob containing sparse checkout patterns
that filters the output of 'ls-tree'. When filtering with given sparsity
patterns, 'ls-tree' only outputs blobs and commit objects that
match the given patterns.

While it may be valid in some situations to output a tree object -- e.g.
when a cone pattern matches all blobs recursively contained in a tree --
it is less unclear what should be output if a sparse pattern matches
parts of a tree.

To allow for reusing the pattern matching logic found in
'path_in_sparse_checkout_1()' in 'dir.c' with arbitrary patterns,
extract the pattern matching part of the function into its own new
function 'recursively_match_path_with_sparse_patterns()'.

Signed-off-by: William Sprent <williams@unity3d.com>
---
    ls-tree: add --sparse-filter-oid argument
    
    I'm resubmitting this change as rebased on top of 'master', as it
    conflicted with the topic 'ls-tree.c: clean-up works' 1
    [https://public-inbox.org/git/20230112091135.20050-1-tenglong.tl@alibaba-inc.com],
    which was merged to 'master' recently.
    
    This versions also incorporates changes based on the comments made in 2
    [https://public-inbox.org/git/CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com/].
    
    I'm also looping in contributors that have touched ls-tree and/or
    sparse-checkouts recently. I hope that's okay.
    
    William

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1459%2Fwilliams-unity%2Fls-tree-sparse-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1459/williams-unity/ls-tree-sparse-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1459

Contributor requested no range-diff. You can review it using these commands:
   git fetch https://github.com/gitgitgadget/git a38d39a4 07a4e24e
   git range-diff <options> a38d39a4..8891b110 56c8fb1e..07a4e24e

 Documentation/git-ls-tree.txt      |  6 ++
 builtin/ls-tree.c                  | 79 +++++++++++++++++++++++-
 dir.c                              | 45 ++++++++------
 dir.h                              |  5 ++
 t/t3106-ls-tree-sparse-checkout.sh | 99 ++++++++++++++++++++++++++++++
 5 files changed, 213 insertions(+), 21 deletions(-)
 create mode 100755 t/t3106-ls-tree-sparse-checkout.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 0240adb8eec..724bb1f9dbd 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
+	    [--sparse-filter-oid=<blob-ish>]
 	    <tree-ish> [<path>...]
 
 DESCRIPTION
@@ -48,6 +49,11 @@ OPTIONS
 	Show tree entries even when going to recurse them. Has no effect
 	if `-r` was not passed. `-d` implies `-t`.
 
+--sparse-filter-oid=<blob-ish>::
+	Omit showing tree objects and paths that do not match the
+	sparse-checkout specification contained in the blob
+	(or blob-expression) <blob-ish>.
+
 -l::
 --long::
 	Show object size of blob (file) entries.
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 72eb70823d5..46a815fc7dc 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -13,6 +13,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "pathspec.h"
+#include "dir.h"
 
 static const char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
@@ -364,6 +365,65 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
 	},
 };
 
+struct sparse_filter_data {
+	read_tree_fn_t fn;
+	struct pattern_list pl;
+	struct strbuf full_path_buf;
+	struct ls_tree_options *options;
+};
+
+static void init_sparse_filter_data(struct sparse_filter_data **d, struct ls_tree_options *options,
+	const char *sparse_oid_name, read_tree_fn_t fn)
+{
+	struct object_id sparse_oid;
+	struct object_context oc;
+
+	(*d) = xcalloc(1, sizeof(**d));
+	(*d)->fn = fn;
+	(*d)->pl.use_cone_patterns = core_sparse_checkout_cone;
+	(*d)->options = options;
+	strbuf_init(&(*d)->full_path_buf, 0);
+
+	if (get_oid_with_context(the_repository, sparse_oid_name, GET_OID_BLOB,
+			&sparse_oid, &oc))
+		die(_("unable to access sparse blob in '%s'"), sparse_oid_name);
+	if (add_patterns_from_blob_to_list(&sparse_oid, "", 0, &(*d)->pl) < 0)
+		die(_("unable to parse sparse filter data in %s"),
+		    oid_to_hex(&sparse_oid));
+}
+
+static void free_sparse_filter_data(struct sparse_filter_data *d)
+{
+	clear_pattern_list(&d->pl);
+	strbuf_release(&d->full_path_buf);
+	free(d);
+}
+
+static int path_matches_sparse_checkout_patterns(struct strbuf *full_path, struct pattern_list *pl, int dtype)
+{
+	enum pattern_match_result match = recursively_match_path_with_sparse_patterns(full_path->buf, the_repository->index, dtype, pl);
+	return match > 0;
+}
+
+static int filter_sparse(const struct object_id *oid, struct strbuf *base,
+			 const char *pathname, unsigned mode, void *context)
+{
+	struct sparse_filter_data *data = context;
+
+	int do_recurse = show_recursive(data->options, base->buf, base->len, pathname);
+	if (object_type(mode) == OBJ_TREE)
+		return do_recurse;
+
+	strbuf_reset(&data->full_path_buf);
+	strbuf_addbuf(&data->full_path_buf, base);
+	strbuf_addstr(&data->full_path_buf, pathname);
+
+	if (!path_matches_sparse_checkout_patterns(&data->full_path_buf, &data->pl, DT_REG))
+			return 0;
+
+	return data->fn(oid, base, pathname, mode, data->options);
+}
+
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	struct object_id oid;
@@ -372,7 +432,11 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	read_tree_fn_t fn = NULL;
 	enum ls_tree_cmdmode cmdmode = MODE_DEFAULT;
 	int null_termination = 0;
+
 	struct ls_tree_options options = { 0 };
+	char *sparse_oid_name = NULL;
+	void *read_tree_context = NULL;
+	struct sparse_filter_data *sparse_filter_data = NULL;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &options.ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -399,6 +463,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 					 N_("format to use for the output"),
 					 PARSE_OPT_NONEG),
 		OPT__ABBREV(&options.abbrev),
+		OPT_STRING_F(0, "filter-sparse-oid", &sparse_oid_name, N_("filter-sparse-oid"),
+			   N_("filter output with sparse-checkout specification contained in the blob"),
+			     PARSE_OPT_NONEG),
 		OPT_END()
 	};
 	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
@@ -474,7 +541,17 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	ret = !!read_tree(the_repository, tree, &options.pathspec, fn, &options);
+	if (sparse_oid_name) {
+		init_sparse_filter_data(&sparse_filter_data, &options, sparse_oid_name, fn);
+		read_tree_context = sparse_filter_data;
+		fn = filter_sparse;
+	} else
+		read_tree_context = &options;
+
+	ret = !!read_tree(the_repository, tree, &options.pathspec, fn, read_tree_context);
 	clear_pathspec(&options.pathspec);
+	if (sparse_filter_data)
+		free_sparse_filter_data(sparse_filter_data);
+
 	return ret;
 }
diff --git a/dir.c b/dir.c
index 4e99f0c868f..122ebced08e 100644
--- a/dir.c
+++ b/dir.c
@@ -1457,45 +1457,50 @@ int init_sparse_checkout_patterns(struct index_state *istate)
 	return 0;
 }
 
-static int path_in_sparse_checkout_1(const char *path,
-				     struct index_state *istate,
-				     int require_cone_mode)
+int recursively_match_path_with_sparse_patterns(const char *path,
+						struct index_state *istate,
+						int dtype,
+						struct pattern_list *pl)
 {
-	int dtype = DT_REG;
 	enum pattern_match_result match = UNDECIDED;
 	const char *end, *slash;
-
-	/*
-	 * We default to accepting a path if the path is empty, there are no
-	 * patterns, or the patterns are of the wrong type.
-	 */
-	if (!*path ||
-	    init_sparse_checkout_patterns(istate) ||
-	    (require_cone_mode &&
-	     !istate->sparse_checkout_patterns->use_cone_patterns))
-		return 1;
-
 	/*
 	 * If UNDECIDED, use the match from the parent dir (recursively), or
 	 * fall back to NOT_MATCHED at the topmost level. Note that cone mode
 	 * never returns UNDECIDED, so we will execute only one iteration in
 	 * this case.
 	 */
-	for (end = path + strlen(path);
-	     end > path && match == UNDECIDED;
+	for (end = path + strlen(path); end > path && match == UNDECIDED;
 	     end = slash) {
-
 		for (slash = end - 1; slash > path && *slash != '/'; slash--)
 			; /* do nothing */
 
 		match = path_matches_pattern_list(path, end - path,
 				slash > path ? slash + 1 : path, &dtype,
-				istate->sparse_checkout_patterns, istate);
+				pl, istate);
 
 		/* We are going to match the parent dir now */
 		dtype = DT_DIR;
 	}
-	return match > 0;
+
+	return match;
+}
+
+static int path_in_sparse_checkout_1(const char *path,
+				     struct index_state *istate,
+				     int require_cone_mode)
+{
+	/*
+	 * We default to accepting a path if the path is empty, there are no
+	 * patterns, or the patterns are of the wrong type.
+	 */
+	if (!*path ||
+	    init_sparse_checkout_patterns(istate) ||
+	    (require_cone_mode &&
+	     !istate->sparse_checkout_patterns->use_cone_patterns))
+		return 1;
+
+	return recursively_match_path_with_sparse_patterns(path, istate, DT_REG, istate->sparse_checkout_patterns) > 0;
 }
 
 int path_in_sparse_checkout(const char *path,
diff --git a/dir.h b/dir.h
index 8acfc044181..d186d271606 100644
--- a/dir.h
+++ b/dir.h
@@ -403,6 +403,11 @@ int path_in_sparse_checkout(const char *path,
 int path_in_cone_mode_sparse_checkout(const char *path,
 				      struct index_state *istate);
 
+int recursively_match_path_with_sparse_patterns(const char *path,
+						struct index_state *istate,
+						int dtype,
+						struct pattern_list *pl);
+
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
 				  const char *pathname, int len);
diff --git a/t/t3106-ls-tree-sparse-checkout.sh b/t/t3106-ls-tree-sparse-checkout.sh
new file mode 100755
index 00000000000..945f3ed1888
--- /dev/null
+++ b/t/t3106-ls-tree-sparse-checkout.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+test_description='ls-tree with sparse filter patterns'
+
+. ./test-lib.sh
+
+check_agrees_with_ls_files () {
+	REPO=repo  &&
+	git -C $REPO submodule deinit -f --all &&
+	git -C $REPO cat-file -p $filter_oid >"$REPO/.git/info/sparse-checkout" &&
+	git -C $REPO sparse-checkout init --cone &&
+	git -C $REPO submodule init &&
+	git -C $REPO ls-files -t >out &&
+	sed -n "/^S /!s/^. //p" out >expect &&
+	test_cmp expect actual
+}
+
+check_same_result_in_bare_repo () {
+	FILTER_OID=$1 &&
+	git -C repo cat-file -p $FILTER_OID >out &&
+	git -C bare hash-object -w --stdin <out &&
+	git -C bare ls-tree --name-only --filter-sparse-oid=$FILTER_OID -r HEAD >bare-result &&
+	test_cmp expect bare-result
+}
+
+test_expect_success 'setup' '
+	git init submodule &&
+	test_commit -C submodule file &&
+	git init repo &&
+	(
+		cd repo &&
+		mkdir dir &&
+		test_commit dir/sub-file &&
+		test_commit dir/sub-file2 &&
+		mkdir dir2 &&
+		test_commit dir2/sub-file1 &&
+		test_commit dir2/sub-file2 &&
+		test_commit top-file &&
+		git clone ../submodule submodule &&
+		git submodule add ./submodule &&
+		git submodule absorbgitdirs &&
+		git commit -m"add submodule" &&
+		git sparse-checkout init --cone
+	) &&
+	git clone --bare ./repo bare
+'
+
+test_expect_success 'toplevel filter only shows toplevel file' '
+	filter_oid=$(git -C repo hash-object -w --stdin <<-\EOF
+	/*
+	!/*/
+	EOF
+	) &&
+	cat >expect <<-EOF &&
+	.gitmodules
+	submodule
+	top-file.t
+	EOF
+	git -C repo ls-tree --name-only --filter-sparse-oid=$filter_oid -r HEAD >actual &&
+	test_cmp expect actual &&
+	check_agrees_with_ls_files &&
+	check_same_result_in_bare_repo $filter_oid
+'
+
+test_expect_success 'non cone single file filter' '
+	filter_oid=$(git -C repo hash-object -w --stdin <<-\EOF
+	/dir/sub-file.t
+	EOF
+	) &&
+	cat >expect <<-EOF &&
+	dir/sub-file.t
+	EOF
+	git -C repo ls-tree --name-only --filter-sparse-oid=$filter_oid -r HEAD >actual &&
+	test_cmp expect actual &&
+	check_agrees_with_ls_files &&
+	check_same_result_in_bare_repo $filter_oid
+'
+
+test_expect_success 'cone filter matching one dir' '
+	filter_oid=$(git -C repo hash-object -w --stdin <<-\EOF
+	/*
+	!/*/
+	/dir/
+	EOF
+	) &&
+	cat >expect <<-EOF &&
+	.gitmodules
+	dir/sub-file.t
+	dir/sub-file2.t
+	submodule
+	top-file.t
+	EOF
+	git -C repo ls-tree --name-only --filter-sparse-oid=$filter_oid -r HEAD >actual &&
+	test_cmp expect actual &&
+	check_agrees_with_ls_files &&
+	check_same_result_in_bare_repo $filter_oid
+'
+
+test_done

base-commit: 56c8fb1e95377900ec9d53c07886022af0a5d3c2
-- 
gitgitgadget
