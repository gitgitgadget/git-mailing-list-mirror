Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087E4315A
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738346888; cv=none; b=JVhl3OVcgMxRun4Vs+S75K4O4xgxg/NjgHwy7h0kMD6vroH2+0OzwSnuqoiNtgzOJeh4qDsCW+s8dpdD3Zu+1nirvpsv83Ldh5TNyE5vje6/a7y7U5+pimnCMruzqGc4sXrkOq4JO/h1PHX4WBJb61ild88eRix+1YotgsZ5vTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738346888; c=relaxed/simple;
	bh=4n7sSrKfo5y/dLNY8xgOd7UyftyvuccIRprODYqMxHQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Mt0fSvF4YQBUyVQI0rwhFvDS3376qeaPBMMaSBymTk+igt6ggrL9es+ibS24swO4yOh/rmvasCiU/ONeBQar+U8gAdr+a1eP1OXPLoRBXDUU4PTtAiCDS1QSwtEOG1uwyJOqCro2bY4yxWV6LG9gJe86ZHZfopj3PK0sI0PbqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsjVmiwK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsjVmiwK"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab39f84cbf1so408955566b.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738346884; x=1738951684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TEP3dAZyL7VY2p0QdhS3oc8ACp4gdpN8Q8/+jv5/PI=;
        b=LsjVmiwKXuNizB+ZuJdVpoVMRv0QfF5yFBgB6tcwKcGxCU8+db/9PsDtugzZn4fv3L
         o3dHurYlY4uUbOaKOWvN/U5t5+G38NzsbBYbCFJc5nZZpwbQesBrDhxaH4k1Kp2mTlyu
         R179OpNhVoQ2lU+RS8UbFqCN+BYBAmr3oBbVORWniB4ep7R/U/ENj2LPzMdrytXL9dt7
         U8eyi7tQquNtxE5yPUWUpHDky1rfmm6N974NKZQlb+VpPNZThgt+Tc1B/N+Pq6S3Peyb
         peJQCErunvJwhFq66K6Y5PCZM+VAyppRH4LQ7cF5qhZwAd7yXVx33u22fheu827uzc7r
         IlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738346884; x=1738951684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TEP3dAZyL7VY2p0QdhS3oc8ACp4gdpN8Q8/+jv5/PI=;
        b=lJN4gByk8yRPsShlx4uvU9cpMdkEJ6rQwCfjUGh77hhpwZaHDN9ogLTtZkCj3HfXqD
         rl8j/SrZ6gIMYruCJiNJXu4DxpMIU22V6SbCsntXCdwDtx4DYtWqvO2aKNQqzi+GZu5Y
         FeStL1WSV6nhSGXuxAIFtkuQpJhqTS0A5wpXspoqJTrshkl8B6mPjNClVRR57KHIDYR7
         y7SKyCDfO3EdkBpJlRm95Yn6xpoMg/OXp0YteaubNzNAy9pu/bl96g+wAJupN7h5EfT2
         EOBNrsu7sbdQYMetUb4py3aTRDkjuCAS0wpAqoR9ZcgfNey7ZGS/eLHM7OunfM558S6X
         pI/w==
X-Gm-Message-State: AOJu0Yzs6sjBNwbujWW2aVMiU51GMS3ghk5E3j3fdfF/ErZCKV989lNF
	Y9Qlz581nqr8dqHzBI77L9h2awlKjx82AjuIZtyBPRwULW099F/mdn/BZg==
X-Gm-Gg: ASbGncv/jEuRNZ/FmRaMRjPvboNBp/EhpS23TwL2TRGKKkGNbzrL7bT2LSaqG6otqi7
	/55CdBDHbFQ59SX50nr2AHMZVNVlNZi7Ixxd11E5mhQPzRRCsLUo3elg7UdOTgBsjbvIpCvnnOE
	mdicJ9QrE8mxX7GxUhX7eejoyrUT3Wv88NomDq0fgDazQtDCAkIcRzJdKMWUJRWRLZTI8m7rAsi
	8QmVTyONsMjVY+CIwxB8VBuM6kOhdZVfMZkljaoE4EVW8QXgZwmMLji6l2yK5TVbSeBniPYx3Yt
	McDzuigwwBt5Ea0p
X-Google-Smtp-Source: AGHT+IEXdygqh/roIiDxEbUX8faxAeJd/0eUAK+wEU795zKsIB2GUzlfhsyCSHNAMtOzMpgVsRTBvQ==
X-Received: by 2002:a17:907:3f8c:b0:ab6:e5d9:5027 with SMTP id a640c23a62f3a-ab6e5d95279mr799029566b.49.1738346883287;
        Fri, 31 Jan 2025 10:08:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff3d4sm329509366b.112.2025.01.31.10.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 10:08:02 -0800 (PST)
Message-Id: <pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com>
In-Reply-To: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
References: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
From: "Olga Pilipenco via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 31 Jan 2025 18:08:01 +0000
Subject: [PATCH v3] worktree: detect from secondary worktree if main worktree
 is bare
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Junio C Hamano <gitster@pobox.com>,
    Olga Pilipenco <olga.pilipenco@shopify.com>,
    Olga Pilipenco <olga.pilipenco@shopify.com>

From: Olga Pilipenco <olga.pilipenco@shopify.com>

When extensions.worktreeConfig is true and the main worktree is
bare -- that is, its config.worktree file contains core.bare=true
-- commands run from secondary worktrees incorrectly see the main
worktree as not bare. As such, those commands incorrectly think
that the repository's default branch (typically "main" or
"master") is checked out in the bare repository even though it's
not. This makes it impossible, for instance, to checkout or delete
the default branch from a secondary worktree, among other
shortcomings.

This problem occurs because, when extensions.worktreeConfig is
true, commands run in secondary worktrees only consult
$commondir/config and $commondir/worktrees/<id>/config.worktree,
thus they never see the main worktree's core.bare=true setting in
$commondir/config.worktree.

Fix this problem by consulting the main worktree's config.worktree
file when checking whether it is bare. (This extra work is
performed only when running from a secondary worktree.)

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Olga Pilipenco <olga.pilipenco@shopify.com>
---
    worktree: detect from secondary worktree if main worktree is bare
    
    Changes since v2, all results of the amazing review:
    
     * updated description & comments;
     * private function is_bare_git_dir is replaced with
       is_main_worktree_bare. The new implementation only checks if main
       worktree's worktree.config contains information if main worktree is
       bare or not. It's assumed that other configs of main worktree are
       already checked for bareness prior this call.
     * notation { { 0 } } is replaced with {0} that is preferred by the
       project.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1829%2Folga-mcbfe%2Ffix-bare-repo-detection-with-worktree-config-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1829/olga-mcbfe/fix-bare-repo-detection-with-worktree-config-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1829

Range-diff vs v2:

 1:  17f4b24d1da ! 1:  f9207746b38 worktree: detect from secondary worktree if main worktree is bare
     @@ Metadata
       ## Commit message ##
          worktree: detect from secondary worktree if main worktree is bare
      
     -    Setup:
     -    1. Have a bare repo with core.bare = true in config.worktree
     -    2. Create a new worktree
     +    When extensions.worktreeConfig is true and the main worktree is
     +    bare -- that is, its config.worktree file contains core.bare=true
     +    -- commands run from secondary worktrees incorrectly see the main
     +    worktree as not bare. As such, those commands incorrectly think
     +    that the repository's default branch (typically "main" or
     +    "master") is checked out in the bare repository even though it's
     +    not. This makes it impossible, for instance, to checkout or delete
     +    the default branch from a secondary worktree, among other
     +    shortcomings.
      
     -    Behavior:
     -    From the secondary worktree the main worktree appears as non-bare.
     +    This problem occurs because, when extensions.worktreeConfig is
     +    true, commands run in secondary worktrees only consult
     +    $commondir/config and $commondir/worktrees/<id>/config.worktree,
     +    thus they never see the main worktree's core.bare=true setting in
     +    $commondir/config.worktree.
      
     -    Expected:
     -    From the secondary worktree the main worktree should appear as bare.
     -
     -    Why current behavior is not good?
     -    If the main worktree is detected as not bare it doesn't allow
     -    checking out the branch of the main worktree. There are possibly
     -    other problems associated with that behavior.
     -
     -    Why is it happening?
     -    While we're inside the secondary worktree we don't initialize the main
     -    worktree's repository with its configuration.
     -
     -    How is it fixed?
     -    Load actual configs of the main worktree. Also, skip the config loading
     -    step if we're already inside the current worktree because in that case we
     -    rely on is_bare_repository() to return the correct result.
     -
     -    Other solutions considered:
     -    Alternatively, instead of incorrectly always using
     -    `the_repository` as the main worktree's repository, we can detect
     -    and load the actual repository of the main worktree and then use
     -    that repository's `is_bare` value extracted from correct configs.
     -    However, this approach is a bit riskier and could also affect
     -    performance. Since we had the assignment `worktree->repo =
     -    the_repository` for a long time already, I decided it's safe to
     -    keep it as it is for now; it can be still fixed separately from
     -    this change.
     -
     -    Real life use case:
     -    1. Have a bare repo
     -    2. Create a worktree from the bare repo
     -    3. In the secondary worktree enable sparse-checkout - this enables
     -    extensions.worktreeConfig and keeps core.bare=true setting in
     -    config.worktree of the bare worktree
     -    4. The secondary worktree or any other non-bare worktree created
     -    won't be able to use branch main (not even once), but it should be
     -    able to.
     +    Fix this problem by consulting the main worktree's config.worktree
     +    file when checking whether it is bare. (This extra work is
     +    performed only when running from a secondary worktree.)
      
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Olga Pilipenco <olga.pilipenco@shopify.com>
      
       ## t/t3200-branch.sh ##
     @@ t/t3200-branch.sh: test_expect_success 'bare main worktree has HEAD at branch de
       	git -C secondary branch -D main
       '
       
     -+test_expect_success 'secondary worktree can switch to main if common dir is bare worktree' '
     ++test_expect_success 'secondary worktrees recognize core.bare=true in main config.worktree' '
      +	test_when_finished "rm -rf bare_repo non_bare_repo secondary_worktree" &&
      +	git init -b main non_bare_repo &&
      +	test_commit -C non_bare_repo x &&
     @@ worktree.c: static int is_current_worktree(struct worktree *wt)
       	return is_current;
       }
       
     -+static int is_bare_git_dir(const char *git_dir)
     ++/*
     ++* When in a secondary worktree, and when extensions.worktreeConfig
     ++* is true, only $commondir/config and $commondir/worktrees/<id>/
     ++* config.worktree are consulted, hence any core.bare=true setting in
     ++* $commondir/config.worktree gets overlooked. Thus, check it manually
     ++* to determine if the repository is bare.
     ++*/
     ++static int is_main_worktree_bare(struct repository *repo)
      +{
      +	int bare = 0;
     -+	struct config_set cs = { { 0 } };
     -+	char *config_file;
     -+	char *worktree_config_file;
     -+
     -+	config_file = xstrfmt("%s/config", git_dir);
     -+	worktree_config_file = xstrfmt("%s/config.worktree",  git_dir);
     ++	struct config_set cs = {0};
     ++	char *worktree_config = xstrfmt("%s/config.worktree", repo_get_common_dir(repo));
      +
      +	git_configset_init(&cs);
     -+	git_configset_add_file(&cs, config_file);
     -+	git_configset_add_file(&cs, worktree_config_file);
     -+
     ++	git_configset_add_file(&cs, worktree_config);
      +	git_configset_get_bool(&cs, "core.bare", &bare);
      +
      +	git_configset_clear(&cs);
     -+	free(config_file);
     -+	free(worktree_config_file);
     ++	free(worktree_config);
      +	return bare;
      +}
      +
     @@ worktree.c: static int is_current_worktree(struct worktree *wt)
        * get the main worktree
        */
      @@ worktree.c: static struct worktree *get_main_worktree(int skip_reading_head)
     - 	strbuf_strip_suffix(&worktree_path, "/.git");
     - 
       	CALLOC_ARRAY(worktree, 1);
     -+	/*
     -+	 * NEEDSWORK: the_repository is not always main worktree's repository
     -+	*/
       	worktree->repo = the_repository;
       	worktree->path = strbuf_detach(&worktree_path, NULL);
      -	/*
     @@ worktree.c: static struct worktree *get_main_worktree(int skip_reading_head)
       	worktree->is_current = is_current_worktree(worktree);
      +	worktree->is_bare = (is_bare_repository_cfg == 1) ||
      +		is_bare_repository() ||
     -+		(!worktree->is_current && is_bare_git_dir(repo_get_common_dir(the_repository)));
     ++		(!worktree->is_current && is_main_worktree_bare(the_repository));
      +
       	if (!skip_reading_head)
       		add_head_info(worktree);


 t/t3200-branch.sh | 14 ++++++++++++++
 worktree.c        | 35 ++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a3a21c54cf6..f3e720dc10d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -410,6 +410,20 @@ test_expect_success 'bare main worktree has HEAD at branch deleted by secondary
 	git -C secondary branch -D main
 '
 
+test_expect_success 'secondary worktrees recognize core.bare=true in main config.worktree' '
+	test_when_finished "rm -rf bare_repo non_bare_repo secondary_worktree" &&
+	git init -b main non_bare_repo &&
+	test_commit -C non_bare_repo x &&
+
+	git clone --bare non_bare_repo bare_repo &&
+	git -C bare_repo config extensions.worktreeConfig true &&
+	git -C bare_repo config unset core.bare &&
+	git -C bare_repo config --worktree core.bare true &&
+
+	git -C bare_repo worktree add ../secondary_worktree &&
+	git -C secondary_worktree checkout main
+'
+
 test_expect_success 'git branch --list -v with --abbrev' '
 	test_when_finished "git branch -D t" &&
 	git branch t &&
diff --git a/worktree.c b/worktree.c
index 248bbb39d43..6df4ccf97f7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -65,6 +65,28 @@ static int is_current_worktree(struct worktree *wt)
 	return is_current;
 }
 
+/*
+* When in a secondary worktree, and when extensions.worktreeConfig
+* is true, only $commondir/config and $commondir/worktrees/<id>/
+* config.worktree are consulted, hence any core.bare=true setting in
+* $commondir/config.worktree gets overlooked. Thus, check it manually
+* to determine if the repository is bare.
+*/
+static int is_main_worktree_bare(struct repository *repo)
+{
+	int bare = 0;
+	struct config_set cs = {0};
+	char *worktree_config = xstrfmt("%s/config.worktree", repo_get_common_dir(repo));
+
+	git_configset_init(&cs);
+	git_configset_add_file(&cs, worktree_config);
+	git_configset_get_bool(&cs, "core.bare", &bare);
+
+	git_configset_clear(&cs);
+	free(worktree_config);
+	return bare;
+}
+
 /**
  * get the main worktree
  */
@@ -79,16 +101,11 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	CALLOC_ARRAY(worktree, 1);
 	worktree->repo = the_repository;
 	worktree->path = strbuf_detach(&worktree_path, NULL);
-	/*
-	 * NEEDSWORK: If this function is called from a secondary worktree and
-	 * config.worktree is present, is_bare_repository_cfg will reflect the
-	 * contents of config.worktree, not the contents of the main worktree.
-	 * This means that worktree->is_bare may be set to 0 even if the main
-	 * worktree is configured to be bare.
-	 */
-	worktree->is_bare = (is_bare_repository_cfg == 1) ||
-		is_bare_repository();
 	worktree->is_current = is_current_worktree(worktree);
+	worktree->is_bare = (is_bare_repository_cfg == 1) ||
+		is_bare_repository() ||
+		(!worktree->is_current && is_main_worktree_bare(the_repository));
+
 	if (!skip_reading_head)
 		add_head_info(worktree);
 	return worktree;

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
-- 
gitgitgadget
