Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F6C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiCAU1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiCAU0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:26:46 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D338F61B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t11so1311295wrm.5
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 12:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lgcgVoMVx+nLmbesIjkdMYJ1oZbkOITvLIpr6PYRAR4=;
        b=FJCv5u1niLvkDKQsGEFX83emRIh0MDuXhgCKysg5BcRpsjCnaezIqwxacAL2ODEhbM
         Pr2j2YY+bFE2+ns6gj2mSKXvnlex1n5EivKIrulY2d9SnNFDGLxdwXgvhNUyzEj3Yrdk
         orBr0yiH7Qm/31v86GvB9tKPpWnEna/Vvqe6SmRbj252165urbTMmWOCbQoCYm4b1aRN
         O1hyy1bHdFh57j66t/W0H6btv1z7dUoz68HytSAmlD0Fiw/b1FBKX/fM8hRAA1eLt2oq
         25qZV7K8OmgfZHUQMkkDVW9H6s6fEX3K9qj+dHa+ohHC08GScC3oOvndre7Od33XZnrc
         Rq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lgcgVoMVx+nLmbesIjkdMYJ1oZbkOITvLIpr6PYRAR4=;
        b=P98KSM7++B4LmHyywFU53nakK/i8nH6kfo4hh2BfbPCTy/+GZ/q97jQNAwGrRgE6s9
         COzL44zxY92vNJhou0ueIn3sY92byps0wHkMVaHJwE5+KrrouPGTkDJETE3KAJleJYYP
         3VTMCUViu7Qz5Rf22mq/cDDXXOvtmQpJdGjjtXmmu7UYL0uPO0Ln7ZavpXdquAmdNVTf
         xrDS9WQamSHVEqH4igZHuGemmXsJX4+OrGgGRm4kUldOAR1Mdw2QAB2ZHnWwdLpBUKDu
         P2qmXcjYWwqq2ToQrgdxH+sIps/jt+SSz2srqf8PO6xaejaEYuGFSl+fq2aCqy/uBa6N
         Butg==
X-Gm-Message-State: AOAM533J+bPyYByiNihlyGgO87U7LH1lgBf++diYPcfDgkZ1NoJ7g/8o
        N6w3A5iaTG+NkXbudCyiq9tgAyUX/FM=
X-Google-Smtp-Source: ABdhPJxuB2Enr8S6pqQ3jmh9csUaQPmGxyDE+m1W9WbldB3vzj+DKN8VsQDVkQrW5f1k/409omfRnw==
X-Received: by 2002:a05:6000:128c:b0:1ea:99b7:80e with SMTP id f12-20020a056000128c00b001ea99b7080emr19739767wrx.540.1646166276681;
        Tue, 01 Mar 2022 12:24:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm1614464wmg.7.2022.03.01.12.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:24:36 -0800 (PST)
Message-Id: <015618a9f292fc6eb20b21d40619cade343a9a0d.1646166271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
        <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 20:24:28 +0000
Subject: [PATCH v3 5/8] read-tree: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable use of sparse index in 'git read-tree'. The integration in this patch
is limited only to usage of 'read-tree' that does not need additional
functional changes for the sparse index to behave as expected (i.e., produce
the same user-facing results as a non-sparse index sparse-checkout). To
ensure no unexpected behavior occurs, the index is explicitly expanded when:

* '--no-sparse-checkout' is specified (because it disables sparse-checkout)
* '--prefix' is specified (if the prefix is inside a sparse directory, the
  prefixed tree cannot be properly traversed)
* two or more <tree-ish> arguments are specified ('twoway_merge' and
  'threeway_merge' do not yet support merging sparse directories)

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      | 21 +++++++++++++++++++--
 t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index c1a401971c2..0a52cab7752 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -160,8 +160,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	argc = parse_options(argc, argv, cmd_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
@@ -173,6 +171,11 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.reset)
 		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+
 	/*
 	 * NEEDSWORK
 	 *
@@ -214,6 +217,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
+	/* TODO: audit sparse index behavior in unpack_trees */
+	if (opts.skip_sparse_checkout || opts.prefix)
+		ensure_full_index(&the_index);
+
 	if (opts.merge) {
 		switch (stage - 1) {
 		case 0:
@@ -223,11 +230,21 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			opts.fn = opts.prefix ? bind_merge : oneway_merge;
 			break;
 		case 2:
+			/*
+			 * TODO: update twoway_merge to handle edit/edit conflicts in
+			 * sparse directories.
+			 */
+			ensure_full_index(&the_index);
 			opts.fn = twoway_merge;
 			opts.initial_checkout = is_cache_unborn();
 			break;
 		case 3:
 		default:
+			/*
+			 * TODO: update threeway_merge to handle edit/edit conflicts in
+			 * sparse directories.
+			 */
+			ensure_full_index(&the_index);
 			opts.fn = threeway_merge;
 			break;
 		}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9bb5aeb979c..86241b01a59 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1409,6 +1409,17 @@ test_expect_success 'sparse index is not expanded: fetch/pull' '
 	ensure_not_expanded pull full base
 '
 
+test_expect_success 'sparse index is not expanded: read-tree' '
+	init_repos &&
+
+	ensure_not_expanded checkout -b test-branch update-folder1 &&
+	for MERGE_TREES in "update-folder2"
+	do
+		ensure_not_expanded read-tree -mu $MERGE_TREES &&
+		ensure_not_expanded reset --hard || return 1
+	done
+'
+
 test_expect_success 'ls-files' '
 	init_repos &&
 
-- 
gitgitgadget

