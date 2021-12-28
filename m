Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F62C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhL1Vcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhL1Vca (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:32:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D47EC06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so5041381wme.2
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6TvHtjRK5E40k2krLTn+3gz0FHnsdhcBFGnsl/wJQPw=;
        b=YpdklIh/+G8Vej7hc8ja7G8X6YEBMI8uKgdor4Hh/HBYxsjQaIgE5KDUaKcdvG/Dm7
         Iet89LI616C6Bnz40kwQOsU0jmY7tXf7Ywuig+RfNUaOLtNmyA/W3p6vJ6q7tkHo1Wzf
         7+T6jSRVo1ZNy2pdjZ4qPvdbujjL+xcZrA/7468IZb2riXH4+i6uc4+HGplKi42ehsob
         1Ba/Tmd7lim7SFMwEwXzHgTgYgNRFsFnf+gw5n3Q1WtH717m+HXzwPhPwDEp5JeB6/GR
         x1hJ58vBLEdOH2bsWPNghg7ppxlHRLOP9Ghe8ofB7o5Xqb94I+Qd6gAJDjlaWAF7swsE
         ZD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6TvHtjRK5E40k2krLTn+3gz0FHnsdhcBFGnsl/wJQPw=;
        b=E7dHQqVNuEY7LNyg8QNxokMMjyqV6Ia5zbSfh4g9k4j7PaSb6bkmvWB0Ke0KDk7Pua
         qX/eT655/thf1cdy9Ez5sTwbdECAdllS8hnoqKUWmPuM1CxpEhYnmzTKLbzsVYcU5tLY
         gAWejuE/QkwHvQ3Wi2wfQ3yoxwCWZyswzhaRTvE43T/1+nYLNI0Ab6HjLXjg+FdUkH3k
         HyvDH0LWSLVeKwtdqBKSiMrL/yLi6v+S5V44HgTzU4HbYD9QHBWqGlhQAtereFb9aNFd
         8XjaVTHEmOb0Vfo1oj5cJY3JIisRgMETQrd30MvxZD7S3UT66zd4IueupT57TGggjVek
         VLGg==
X-Gm-Message-State: AOAM533SYeFLUxAIbFQNQDB4dO/BcSd5WlrJcatI9LDg4O/DaautDO5u
        Fil62vwjnBCIOFOXtMkr/gC0vFj8LLc=
X-Google-Smtp-Source: ABdhPJxqc753eIr6IaA1rxV+EzDThz5zVBZz5b8y9sJylI5qXUhrlLqiC3cbGTuVWCwV+D6hZdFDmA==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr18886841wme.181.1640727148689;
        Tue, 28 Dec 2021 13:32:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1sm22044840wml.26.2021.12.28.13.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:32:28 -0800 (PST)
Message-Id: <b200819c1bb564695b68d8ed2caebfca0302f93f.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
        <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 21:32:22 +0000
Subject: [PATCH v3 5/6] sparse-checkout: use repo_config_set_worktree_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change added repo_config_set_worktree_gently() to assist
writing config values into the worktree.config file, if enabled.

Let the sparse-checkout builtin use this helper instead of attempting to
initialize the worktree config on its own. This changes behavior of 'git
sparse-checkout set' in a few important ways:

 1. Git will no longer upgrade the repository format and add the
    worktree config extension. The user should run 'git worktree
    init-worktree-config' to enable this feature.

 2. If worktree config is disabled, then this command will set the
    core.sparseCheckout (and possibly core.sparseCheckoutCone and
    index.sparse) values in the common config file.

 3. If the main worktree is bare, then this command will not put the
    worktree in a broken state.

The main reason to use worktree-specific config for the sparse-checkout
builtin was to avoid enabling sparse-checkout patterns in one and
causing a loss of files in another. If a worktree does not have a
sparse-checkout patterns file, then the sparse-checkout logic will not
kick in on that worktree.

This new logic introduces a new user pattern that could lead to some
confusion. Suppose a user has not upgraded to worktree config and
follows these steps in order:

 1. Enable sparse-checkout in a worktree.

 2. Disable sparse-checkout in that worktree without deleting that
    worktree's sparse-checkout file.

 3. Enable sparse-checkout in another worktree.

After these steps, the first worktree will have sparse-checkout enabled
with whatever patterns exist. The worktree does not immediately have
those patterns applied, but a variety of Git commands would apply the
sparse-checkout patterns and update the worktree state to reflect those
patterns. This situation is likely very rare and the workaround is to
upgrade to worktree specific config on purpose. Users already in this
state used the sparse-checkout builtin with a version that upgraded to
worktree config, anyway.

Reported-by: Sean Allred <allred.sean@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 25 +++++--------
 sparse-index.c                     | 10 ++----
 t/t1091-sparse-checkout-builtin.sh | 57 +++++++++++++++++++++++++-----
 3 files changed, 60 insertions(+), 32 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 08f8df2648c..d0d6749593e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -359,26 +359,17 @@ enum sparse_checkout_mode {
 
 static int set_config(enum sparse_checkout_mode mode)
 {
-	const char *config_path;
-
-	if (upgrade_repository_format(the_repository, 1) < 0)
-		die(_("unable to upgrade repository format to enable worktreeConfig"));
-	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
-		error(_("failed to set extensions.worktreeConfig setting"));
+	if (repo_config_set_worktree_gently(the_repository,
+					    "core.sparseCheckout",
+					    mode ? "true" : "false") ||
+	    repo_config_set_worktree_gently(the_repository,
+					    "core.sparseCheckoutCone",
+					    mode == MODE_CONE_PATTERNS ?
+						"true" : "false"))
 		return 1;
-	}
-
-	config_path = git_path("config.worktree");
-	git_config_set_in_file_gently(config_path,
-				      "core.sparseCheckout",
-				      mode ? "true" : NULL);
-
-	git_config_set_in_file_gently(config_path,
-				      "core.sparseCheckoutCone",
-				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
 
 	if (mode == MODE_NO_PATTERNS)
-		set_sparse_index_config(the_repository, 0);
+		return set_sparse_index_config(the_repository, 0);
 
 	return 0;
 }
diff --git a/sparse-index.c b/sparse-index.c
index a1d505d50e9..e93609999e0 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -99,13 +99,9 @@ static int convert_to_sparse_rec(struct index_state *istate,
 
 int set_sparse_index_config(struct repository *repo, int enable)
 {
-	int res;
-	char *config_path = repo_git_path(repo, "config.worktree");
-	res = git_config_set_in_file_gently(config_path,
-					    "index.sparse",
-					    enable ? "true" : NULL);
-	free(config_path);
-
+	int res = repo_config_set_worktree_gently(repo,
+						  "index.sparse",
+						  enable ? "true" : "false");
 	prepare_repo_settings(repo);
 	repo->settings.sparse_index = enable;
 	return res;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 447a8669e02..15403158c49 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -146,15 +146,54 @@ test_expect_success 'interaction with clone --no-checkout (unborn index)' '
 '
 
 test_expect_success 'set enables config' '
-	git init empty-config &&
+	git init initial-config &&
 	(
-		cd empty-config &&
+		cd initial-config &&
+		test_commit file file &&
+		mkdir dir &&
+		test_commit dir dir/file &&
+		git worktree add --detach ../initial-worktree &&
+		git sparse-checkout set --cone
+	) &&
+	test_cmp_config -C initial-config true core.sparseCheckout &&
+	test_cmp_config -C initial-worktree true core.sparseCheckout &&
+	test_cmp_config -C initial-config true core.sparseCheckoutCone &&
+	test_cmp_config -C initial-worktree true core.sparseCheckoutCone &&
+
+	# initial-config has a sparse-checkout file
+	# that only contains files at root.
+	ls initial-config >only-file &&
+	cat >expect <<-EOF &&
+	file
+	EOF
+	test_cmp expect only-file &&
+
+	# initial-worktree does not have its own sparse-checkout
+	# file, so the repply does not modify the worktree at all.
+	git -C initial-worktree sparse-checkout reapply &&
+	ls initial-worktree >all &&
+	cat >expect <<-EOF &&
+	dir
+	file
+	EOF
+	test_cmp expect all
+'
+
+test_expect_success 'set enables worktree config, if enabled' '
+	git init worktree-config &&
+	(
+		cd worktree-config &&
 		test_commit test file &&
-		test_path_is_missing .git/config.worktree &&
-		git sparse-checkout set nothing &&
-		test_path_is_file .git/config.worktree &&
-		test_cmp_config true core.sparseCheckout
-	)
+		git worktree add --detach ../worktree-config2 &&
+		git worktree init-worktree-config &&
+		git sparse-checkout set --cone &&
+		git config --worktree core.sparseCheckout &&
+		git config --worktree core.sparseCheckoutCone
+	) &&
+	test_cmp_config -C worktree-config true core.sparseCheckout &&
+	test_must_fail git -C worktree-config2 core.sparseCheckout &&
+	test_cmp_config -C worktree-config true core.sparseCheckoutCone &&
+	test_must_fail git -C worktree-config2 core.sparseCheckoutCone
 '
 
 test_expect_success 'set sparse-checkout using builtin' '
@@ -202,6 +241,7 @@ test_expect_success 'add to sparse-checkout' '
 '
 
 test_expect_success 'cone mode: match patterns' '
+	git -C repo worktree init-worktree-config &&
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	rm -rf repo/a repo/folder1 repo/folder2 &&
 	git -C repo read-tree -mu HEAD 2>err &&
@@ -241,7 +281,7 @@ test_expect_success 'sparse-index enabled and disabled' '
 		test-tool -C repo read-cache --table >cache &&
 		! grep " tree " cache &&
 		git -C repo config --list >config &&
-		! grep index.sparse config
+		test_cmp_config -C repo false index.sparse
 	)
 '
 
@@ -380,6 +420,7 @@ test_expect_success 'fail when lock is taken' '
 '
 
 test_expect_success '.gitignore should not warn about cone mode' '
+	git -C repo worktree init-worktree-config &&
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	echo "**/bin/*" >repo/.gitignore &&
 	git -C repo reset --hard 2>err &&
-- 
gitgitgadget

