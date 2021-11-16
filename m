Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B0C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CADD63214
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbhKPPlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhKPPlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 10:41:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D25C061764
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 07:38:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s13so38465107wrb.3
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 07:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y77U37cTnkT1w5QLgVlKE9hoI4xdnDH+cttncX23s5E=;
        b=awute/MFqxF89TSPyxU2HlWRV4/olr56S5p1xmvXhDHr0rQYJg58hlpu2dP45pJKst
         LcTNJIV3kpNrHxmVAKDckE84+IZ36KipgqqFy6zTZ4JFnCR2MzxI/7qhwIp5cg1xNQPQ
         G10qRJvnz6piqHmzqR8kNAt8OAUqniQ5WL8A0+ZHhKEAUrKSoujbm80nmIqssByh8efu
         2KAiNF2I9oZKDeJXMLANTmUPdKGW3GOEEvVaI9b15ZBFwXLpN5ND61ZucGIPmBZWYQSS
         YsC4BqBVQIVPwYHkAlEKS32QnoqiB2u2vJ7z64OFvV8P0y6/PQAjluYJ3Qgq676fnimB
         7W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y77U37cTnkT1w5QLgVlKE9hoI4xdnDH+cttncX23s5E=;
        b=D9pw9J04yuiBfgTNma2LZTzajMW3oK+mVZyWquJ2JsOoGZcFl3esKISDiaLRs95zuk
         khPauPNYIOkmv5vi1OikHVml3V02BS5as3IYnE7lgMH+yNnULWnSy7KfJnBIMZ4/TC2g
         CZPTewH+fXs/nSn6wxeDNO5Nki4DD4JzfUh+3ZxcTPIo9msJdfJBmqVy9/JchywqrBpS
         hTb/M8Egwtxs86L9uRqxx3vX1SF2IrIihZxAbaUZXQDyWnnpFjNX7jb99ugJHC3CwtIY
         pDBPUkB77xkH4gBQBecP1A6HuByxRXUSnpDcD0AAdmK8t2N6d9n0Lo7ZzgU8iDVVfziz
         Ea+g==
X-Gm-Message-State: AOAM531f9B7FXHXIKzRs5k57iPiOHhoDUUK93AtAQSfxwOapq06UOgJW
        o14zasizoZ6N/MYwv1zaaxvEbucaNZU=
X-Google-Smtp-Source: ABdhPJzekmJrr49ESCm41p8BIxLeBKnViAy+LIn/1RrTf5fi+6xZws02clzuxU8RkDIlTgsumjXkPw==
X-Received: by 2002:a5d:6e82:: with SMTP id k2mr10694508wrz.147.1637077085554;
        Tue, 16 Nov 2021 07:38:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8sm2656303wmg.24.2021.11.16.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:38:05 -0800 (PST)
Message-Id: <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 15:38:02 +0000
Subject: [PATCH 2/2] ls-files: add --sparse option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Existing callers to 'git ls-files' are expecting file names, not
directories. It is best to expand a sparse index to show all of the
contained files in this case.

However, expert users may want to inspect the contents of the index
itself including which directories are sparse. Add a --sparse option to
allow users to request this information.

During testing, I noticed that options such as --modified did not affect
the output when the files in question were outside the sparse-checkout
definition. Tests are added to document this preexisting behavior and
how it remains unchanged with the sparse index and the --sparse option.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-ls-files.txt           |  4 ++
 builtin/ls-files.c                       | 12 +++++-
 t/t1092-sparse-checkout-compatibility.sh | 47 ++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 6d11ab506b7..1c5d5f85ec5 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -187,6 +187,10 @@ Both the <eolinfo> in the index ("i/<eolinfo>")
 and in the working tree ("w/<eolinfo>") are shown for regular files,
 followed by the  ("attr/<eolattr>").
 
+--sparse::
+	If the index is sparse, show the sparse directories without expanding
+	to the contained files.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 031fef1bcaa..c151eb1fb77 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -37,6 +37,7 @@ static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
 static int skipping_duplicates;
+static int show_sparse_dirs;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -315,8 +316,10 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 
 	if (!(show_cached || show_stage || show_deleted || show_modified))
 		return;
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(repo->index);
+
+	if (!show_sparse_dirs)
+		ensure_full_index(repo->index);
+
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
 		struct stat st;
@@ -670,6 +673,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_BOOL(0, "deduplicate", &skipping_duplicates,
 			 N_("suppress duplicate entries")),
+		OPT_BOOL(0, "sparse", &show_sparse_dirs,
+			 N_("show sparse directories in the presence of a sparse index")),
 		OPT_END()
 	};
 	int ret = 0;
@@ -677,6 +682,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(ls_files_usage, builtin_ls_files_options);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f8a8dde60af..ffb6052ff60 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -814,6 +814,12 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index reset -- folder1/a &&
 	test_region index convert_to_sparse trace2.txt &&
+	test_region index ensure_full_index trace2.txt &&
+
+	# ls-files expands on read, but does not write.
+	rm trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index ls-files &&
 	test_region index ensure_full_index trace2.txt
 '
 
@@ -838,6 +844,7 @@ test_expect_success 'sparse-index is not expanded' '
 	init_repos &&
 
 	ensure_not_expanded status &&
+	ensure_not_expanded ls-files --sparse &&
 	ensure_not_expanded commit --allow-empty -m empty &&
 	echo >>sparse-index/a &&
 	ensure_not_expanded commit -a -m a &&
@@ -942,6 +949,46 @@ test_expect_success 'sparse index is not expanded: fetch/pull' '
 	ensure_not_expanded pull full base
 '
 
+test_expect_success 'ls-files' '
+	init_repos &&
+
+	# Behavior agrees by default. Sparse index is expanded.
+	test_all_match git ls-files &&
+
+	# With --sparse, the sparse index data changes behavior.
+	git -C sparse-index ls-files --sparse >sparse-index-out &&
+	grep "^folder1/\$" sparse-index-out &&
+	grep "^folder2/\$" sparse-index-out &&
+
+	# With --sparse and no sparse index, nothing changes.
+	git -C sparse-checkout ls-files --sparse >sparse-checkout-out &&
+	grep "^folder1/0/0/0\$" sparse-checkout-out &&
+	! grep "/\$" sparse-checkout-out &&
+
+	write_script edit-content <<-\EOF &&
+	mkdir folder1 &&
+	echo content >>folder1/a
+	EOF
+	run_on_sparse ../edit-content &&
+
+	# ls-files does not notice modified files whose
+	# cache entries are marked SKIP_WORKTREE.
+	test_sparse_match git ls-files --modified &&
+	test_must_be_empty sparse-checkout-out &&
+	test_must_be_empty sparse-index-out &&
+
+	git -C sparse-index ls-files --sparse --modified >sparse-index-out &&
+	test_must_be_empty sparse-index-out &&
+
+	run_on_sparse git sparse-checkout add folder1 &&
+	test_sparse_match git ls-files --modified &&
+	grep "^folder1/a\$" sparse-checkout-out &&
+	grep "^folder1/a\$" sparse-index-out &&
+
+	# Double-check index expansion
+	ensure_not_expanded ls-files --sparse
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget
