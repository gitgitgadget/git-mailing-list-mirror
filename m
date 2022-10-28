Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC01BECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 11:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJ1Lzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 07:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJ1Lzt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 07:55:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A8191D58
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 04:55:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j15so6302149wrq.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwKp05XmZylT+zrOlEdGRO8egATMxZ9PArJh6uoTbes=;
        b=DZH9SfhPds6LXdxXLkK51vYQtMCDEpntI8l7ANbW8hSjgBbmAbBNejl11r98B8ICK0
         iTX0SBePSOhHN259B7qsRTLr4FNJg+M73CuA0hxlU55ogQ5lHPaIUNn71MjVKJAWPG+t
         Kg0srfxm41wdf6EbxWFwOLFi6VA41H59Hi6ZzLcgORYJ7Dh9JwP+1EagOKEHPLJi5ozj
         I47jrTcfN+RAZzAgSK5QIvpzV2gPPxp3RIxjeHCS7irxtIDuFVh1gw1RbX9q2KB4KAZu
         +2h1tU386kn7oeNIwVEwea0AyJGy2cTFWmw+q1U6IpNoOq0AT4/qF1xXCh0WLR7v6gKB
         O06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwKp05XmZylT+zrOlEdGRO8egATMxZ9PArJh6uoTbes=;
        b=EhcLgwC9l58X3HkgNDNWBhietMGB7enw9fS91+EF3udVMJGjBrbwEDYFgYOzVO2qpM
         o+Zp7PiWRryYpAWo7XJpGDFm7Zgy7bEGOy7OEPJs3eE0/LW8GcnKDbjKhavuKhDkYiFd
         EwJVS0Ye8TSRORuu/8C81Udte2RZ+W1HiuLvQwhTtl93efmdk3S+iczyWvUUSSUifhEh
         wtDKy17ZGg4ewTUPxs3NxNL1Qmq6MHjuOh64nz3bwsShW0LlVZxB6A6kIbafvNPpU0Hl
         +fAmbLtFRuXuYyfnoBLm19ycYankZBz/ISkv+SCyArsw8W+L2sRAzjeeka59WO2kTzRI
         wC1Q==
X-Gm-Message-State: ACrzQf3myYUU5SHO19wZ8SPBIvhZWb1BspEULIFtUEzQy4+zkSjnsfJG
        zSU3uiu/0t3Nrfw7DWfBZUOdlFE1Nfo=
X-Google-Smtp-Source: AMsMyM7qlHm8zsJDAH3+ECgVhOWuaRKkbA8k9UogqM6hSHDxCGcGLTIVDe0JJ6A7oIWP2j9d4HhWgw==
X-Received: by 2002:a5d:5186:0:b0:236:79a2:af1 with SMTP id k6-20020a5d5186000000b0023679a20af1mr14418831wrv.648.1666958145209;
        Fri, 28 Oct 2022 04:55:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b003b3365b38f9sm3952210wmf.10.2022.10.28.04.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 04:55:44 -0700 (PDT)
Message-Id: <pull.1397.v2.git.1666958144017.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>
References: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 11:55:43 +0000
Subject: [PATCH v2] merge-tree.c: add --merge-base=<commit> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

This patch will give our callers more flexibility to use `git merge-tree`,
such as:

    git merge-tree --write-tree --merge-base=branch^ HEAD branch

It would cherry-pick the commit at the tip of the branch on top of the
current commit even if the repository is bare.

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
    merge-tree: allow specifying a base commit when --write-tree is passed
    
    Thanks for Elijah's work. I'm very excited that merge-ort is integrated
    into the git merge-tree, which means that we can use merge-ort in bare
    repositories to optimize merge performance.
    
    In this patch, I introduce a new --merge-base=<commit> option to allow
    callers to specify a merge-base for the merge. This may allow users to
    implement git cherry-pick and git rebase in bare repositories with git
    merge-tree cmd.
    
    Changes since v1:
    
     * Changed merge_incore_nonrecursive() to merge_incore_recursive() when
       merge-base is specified.
     * Fixed c style problem.
     * Moved commit lookup/die logic out to the parsing logic in
       cmd_merge_tree().
     * use test_commit for test

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1397

Range-diff vs v1:

 1:  965e544c849 ! 1:  ab4e5d5ad08 merge-tree.c: add --merge-base=<commit> option
     @@ Metadata
       ## Commit message ##
          merge-tree.c: add --merge-base=<commit> option
      
     -    This option allows users to specify a merge-base commit for the merge.
     +    This patch will give our callers more flexibility to use `git merge-tree`,
     +    such as:
      
     -    It will give our callers more flexibility to use the `git merge-tree`.
     -    For example:
     +        git merge-tree --write-tree --merge-base=branch^ HEAD branch
      
     -        git merge-tree --merge-base=<sha1>^1 source-branch <sha1>
     -
     -    This allows us to implement `git cherry-pick` in bare repositories.
     +    It would cherry-pick the commit at the tip of the branch on top of the
     +    current commit even if the repository is bare.
      
          Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
      
     @@ builtin/merge-tree.c: struct merge_tree_options {
       	int allow_unrelated_histories;
       	int show_messages;
       	int name_only;
     -+	char* merge_base;
     ++	const struct commit *base_commit;
       };
       
       static int real_merge(struct merge_tree_options *o,
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
      -	 * merge_incore_recursive in merge-ort.h
      -	 */
      -	merge_bases = get_merge_bases(parent1, parent2);
     -+	if (o->merge_base) {
     -+		struct commit *c = lookup_commit_reference_by_name(o->merge_base);
     -+		if (!c)
     -+			die(_("could not lookup commit %s"), o->merge_base);
     -+		commit_list_insert(c, &merge_bases);
     +-	if (!merge_bases && !o->allow_unrelated_histories)
     +-		die(_("refusing to merge unrelated histories"));
     +-	merge_bases = reverse_commit_list(merge_bases);
     ++	if (o->base_commit) {
     ++		struct tree *base_tree, *parent1_tree, *parent2_tree;
     ++
     ++		opt.ancestor = "specified merge base";
     ++		base_tree = get_commit_tree(o->base_commit);
     ++		parent1_tree = get_commit_tree(parent1);
     ++		parent2_tree = get_commit_tree(parent2);
     ++		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
      +	} else {
      +		/*
      +		 * Get the merge bases, in reverse order; see comment above
      +		 * merge_incore_recursive in merge-ort.h
      +		 */
      +		merge_bases = get_merge_bases(parent1, parent2);
     ++		if (!merge_bases && !o->allow_unrelated_histories)
     ++			die(_("refusing to merge unrelated histories"));
     ++		merge_bases = reverse_commit_list(merge_bases);
     ++		merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
      +	}
     - 	if (!merge_bases && !o->allow_unrelated_histories)
     - 		die(_("refusing to merge unrelated histories"));
     - 	merge_bases = reverse_commit_list(merge_bases);
     + 
     +-	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
     + 	if (result.clean < 0)
     + 		die(_("failure to merge"));
     + 
     +@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
     + 
     + int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     + {
     ++	const char *merge_base = NULL;
     + 	struct merge_tree_options o = { .show_messages = -1 };
     + 	int expected_remaining_argc;
     + 	int original_argc;
      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
       			   &o.allow_unrelated_histories,
       			   N_("allow merging unrelated histories"),
       			   PARSE_OPT_NONEG),
      +		OPT_STRING(0, "merge-base",
     -+			 &o.merge_base,
     ++			 &merge_base,
      +			 N_("commit"),
     -+			 N_("specify a merge-base commit for the merge")),
     ++			 N_("specify a merge-base for the merge")),
       		OPT_END()
       	};
       
     +@@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     + 		usage_with_options(merge_tree_usage, mt_options);
     + 
     + 	/* Do the relevant type of merge */
     +-	if (o.mode == MODE_REAL)
     ++	if (o.mode == MODE_REAL) {
     ++		if (merge_base) {
     ++			o.base_commit = lookup_commit_reference_by_name(merge_base);
     ++			if (!o.base_commit)
     ++				die(_("could not lookup commit %s"), merge_base);
     ++		}
     + 		return real_merge(&o, argv[0], argv[1], prefix);
     ++	}
     + 	else
     + 		return trivial_merge(argv[0], argv[1], argv[2]);
     + }
      
       ## t/t4301-merge-tree-write-tree.sh ##
      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository
       	test_must_fail git -C read-only merge-tree side1 side2
       '
       
     -+# specify merge-base as parent of branch2.
     -+# git merge-tree --merge-base=A O B
     -+#   Commit O: foo, bar
     -+#   Commit A: modify foo after Commit O
     -+#   Commit B: modify bar after Commit A
     -+#   Expected: foo is unchanged, modify bar
     -+
      +test_expect_success 'specify merge-base as parent of branch2' '
      +	# Setup
      +	git init base-b2-p && (
      +		cd base-b2-p &&
     -+		echo foo >foo &&
     -+		echo bar >bar &&
     -+		git add foo bar &&
     -+		git commit -m O &&
     -+
     -+		git branch O &&
     -+		git branch A &&
     -+
     -+		git checkout A &&
     -+		echo "A" >foo &&
     -+		git add foo &&
     -+		git commit -m A &&
     -+
     -+		git checkout -b B &&
     -+		echo "B" >bar &&
     -+		git add bar &&
     -+		git commit -m B
     ++		test_commit c1 file1 &&
     ++		test_commit c2 file2 &&
     ++		test_commit c3 file3
      +	) &&
      +	# Testing
      +	(
      +		cd base-b2-p &&
     -+		TREE_OID=$(git merge-tree --merge-base=A O B) &&
     ++		TREE_OID=$(git merge-tree --write-tree --merge-base=c2 c1 c3) &&
      +
      +		q_to_tab <<-EOF >expect &&
     -+		100644 blob $(git rev-parse B:bar)Qbar
     -+		100644 blob $(git rev-parse O:foo)Qfoo
     ++		100644 blob $(git rev-parse c1:file1)Qfile1
     ++		100644 blob $(git rev-parse c3:file3)Qfile3
      +		EOF
      +
      +		git ls-tree $TREE_OID >actual &&


 Documentation/git-merge-tree.txt |  4 +++
 builtin/merge-tree.c             | 43 ++++++++++++++++++++++++--------
 t/t4301-merge-tree-write-tree.sh | 23 +++++++++++++++++
 3 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index d6c356740ef..e762209b76d 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -64,6 +64,10 @@ OPTIONS
 	share no common history.  This flag can be given to override that
 	check and make the merge proceed anyway.
 
+--merge-base=<commit>::
+	Instead of finding the merge-bases for <branch1> and <branch2>,
+	specify a merge-base for the merge.
+
 [[OUTPUT]]
 OUTPUT
 ------
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ae5782917b9..089ea8fac81 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,6 +3,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "help.h"
+#include "commit.h"
 #include "commit-reach.h"
 #include "merge-ort.h"
 #include "object-store.h"
@@ -402,6 +403,7 @@ struct merge_tree_options {
 	int allow_unrelated_histories;
 	int show_messages;
 	int name_only;
+	const struct commit *base_commit;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -430,16 +432,26 @@ static int real_merge(struct merge_tree_options *o,
 	opt.branch1 = branch1;
 	opt.branch2 = branch2;
 
-	/*
-	 * Get the merge bases, in reverse order; see comment above
-	 * merge_incore_recursive in merge-ort.h
-	 */
-	merge_bases = get_merge_bases(parent1, parent2);
-	if (!merge_bases && !o->allow_unrelated_histories)
-		die(_("refusing to merge unrelated histories"));
-	merge_bases = reverse_commit_list(merge_bases);
+	if (o->base_commit) {
+		struct tree *base_tree, *parent1_tree, *parent2_tree;
+
+		opt.ancestor = "specified merge base";
+		base_tree = get_commit_tree(o->base_commit);
+		parent1_tree = get_commit_tree(parent1);
+		parent2_tree = get_commit_tree(parent2);
+		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
+	} else {
+		/*
+		 * Get the merge bases, in reverse order; see comment above
+		 * merge_incore_recursive in merge-ort.h
+		 */
+		merge_bases = get_merge_bases(parent1, parent2);
+		if (!merge_bases && !o->allow_unrelated_histories)
+			die(_("refusing to merge unrelated histories"));
+		merge_bases = reverse_commit_list(merge_bases);
+		merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+	}
 
-	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
 	if (result.clean < 0)
 		die(_("failure to merge"));
 
@@ -478,6 +490,7 @@ static int real_merge(struct merge_tree_options *o,
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
+	const char *merge_base = NULL;
 	struct merge_tree_options o = { .show_messages = -1 };
 	int expected_remaining_argc;
 	int original_argc;
@@ -505,6 +518,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.allow_unrelated_histories,
 			   N_("allow merging unrelated histories"),
 			   PARSE_OPT_NONEG),
+		OPT_STRING(0, "merge-base",
+			 &merge_base,
+			 N_("commit"),
+			 N_("specify a merge-base for the merge")),
 		OPT_END()
 	};
 
@@ -544,8 +561,14 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 		usage_with_options(merge_tree_usage, mt_options);
 
 	/* Do the relevant type of merge */
-	if (o.mode == MODE_REAL)
+	if (o.mode == MODE_REAL) {
+		if (merge_base) {
+			o.base_commit = lookup_commit_reference_by_name(merge_base);
+			if (!o.base_commit)
+				die(_("could not lookup commit %s"), merge_base);
+		}
 		return real_merge(&o, argv[0], argv[1], prefix);
+	}
 	else
 		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 013b77144bd..64bfe6f4a41 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -819,4 +819,27 @@ test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository
 	test_must_fail git -C read-only merge-tree side1 side2
 '
 
+test_expect_success 'specify merge-base as parent of branch2' '
+	# Setup
+	git init base-b2-p && (
+		cd base-b2-p &&
+		test_commit c1 file1 &&
+		test_commit c2 file2 &&
+		test_commit c3 file3
+	) &&
+	# Testing
+	(
+		cd base-b2-p &&
+		TREE_OID=$(git merge-tree --write-tree --merge-base=c2 c1 c3) &&
+
+		q_to_tab <<-EOF >expect &&
+		100644 blob $(git rev-parse c1:file1)Qfile1
+		100644 blob $(git rev-parse c3:file3)Qfile3
+		EOF
+
+		git ls-tree $TREE_OID >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: 5af5e54106e20f65c913550c80aec3186b859e9b
-- 
gitgitgadget
