Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E218859F
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653553; cv=none; b=qvV0qBX0qZltEAiFv0JJVCM/wgUkJPnhOECVy5sCRv9jfXFascv843c0PiCJYjujOwCEKjnT7Ljsf1o9+73uHw22KWBZNRzzWQ1ibcEpgwahcDofCmiHFMA3sC/Q7+BIkkxYzoEQRSKISEwT8X4XVR1LXYznp33y1b1QX7WCxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653553; c=relaxed/simple;
	bh=TAc2ICT5ij3pK14wYG69ZuBqiuqv0MnzpsqRBoyhMkk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=FfFra9Z6Y+eQPpvbQeay9YB0MBBX/9DcEiCZG4m2QUMAt+vEA0A7d/rTwo6J4TsXzd5tyRGXQNdruMBmS8xLuY4WhqRhLR8DqndEc6FgfqRSje1ZQ8roF0ZGUlf03isGjjxs5C+VeI+Q/2SRsWHBUoyXkYuWtRhonKWdhDZbFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T979MOTr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T979MOTr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so11748605e9.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 22:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731653550; x=1732258350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jmqanwP5to4TnaGfNfM9zJca58RwBh8KwYmMSdtG16k=;
        b=T979MOTr6NmZXYXU59G6V5meQaxnlth39asDCF4tkhSGCtvkFfte4w0CFdyIJATMmN
         toPzvrfopkPlLHPIxwuYyPinTr4KxjUUpiqLK3MkjoODHgCeGOGca2+Bp3L0IhkEuVZn
         KtNGQnjlLjSeP4Y1CV0KXlLX7kOs24j1tgbrU+8tvadEgp/GtPp7W1eqn9lyJ7XN/bRA
         1EzcbtNXtQPeoA4ysYA6OUjpaxUN7yrXNBBXw8+S2fg+t5J2AEzrgWaKKrmA8401Czw8
         oYZ//R2AFwEWyNsOus4qilKJooghZvwaLT1Q1hr59X4TJp+O6CRR+pMJvB8Dqd3sLekV
         Rrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653550; x=1732258350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmqanwP5to4TnaGfNfM9zJca58RwBh8KwYmMSdtG16k=;
        b=afSJ6Slagy61r4THjL/tV6aEM/2kmv+wFI05otEHD7/kIYYwODLRxCENlcrSydr0Dh
         IDiqNbfJ1Zwql1C2nEcWpJplkSrEVhM+QhChO5nhzKrQWd0zWWFLpWv7YNgCs0k+AWpR
         JidvfdzSuLXIyxwcM7Z8a6B4PYKPnt79x5db4ow7gQNkeylVZ3SaAW9g3EeTDxRxcH2F
         SeJsjsyPBzRdFZ5RZWMUTsEBjlj2yK3hrY4d1XLvEfsZSoFPh07KtSGdaO6A22CgN6q1
         9kuj0EmH2kOU7VTZ6ZG/QUvS4QK2McGRdsbuLjMzrcs+TXwtQwd8QcNI7yc9/qpwYUqO
         fA8g==
X-Gm-Message-State: AOJu0YzpsyZ1ybpk1Cae0tMDzPwe891Eoe1L2HQQ/rfq5SSdI7/ybDrx
	LaXwrfuDDZYdW70MD5Bkhbrkx47M8QGeywt5VSpieURO5gPeTbn/Gd+BTw==
X-Google-Smtp-Source: AGHT+IEryaVKAJtcVaPEUl5xKNMTuXmCss77TCVKtjciqT8Me1xZfkgMc9pbywPoldHljCGZwjguhw==
X-Received: by 2002:a05:600c:5494:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-432df72a101mr10995805e9.8.1731653549752;
        Thu, 14 Nov 2024 22:52:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da244c69sm48312395e9.2.2024.11.14.22.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:52:29 -0800 (PST)
Message-Id: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
From: "Olga Pilipenco via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Nov 2024 06:52:28 +0000
Subject: [PATCH] worktree: detect from secondary worktree if main worktree is
 bare
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
Cc: Olga Pilipenco <olga.pilipenco@shopify.com>,
    Olga Pilipenco <olga.pilipenco@shopify.com>

From: Olga Pilipenco <olga.pilipenco@shopify.com>

Setup:
1. Have a bare repo with core.bare = true in config.worktree
2. Create a new worktree

Behavior:
From the secondary worktree the main worktree appears as non-bare.

Expected:
From the secondary worktree the main worktree should appear as bare.

Why current behavior is not good?
If the main worktree is detected as not bare it doesn't allow
checking out the branch of the main worktree. There are possibly
other problems associated with that behavior.

Why is it happening?
While we're inside the secondary worktree we don't initialize the main
worktree's repository with its configuration.

How is it fixed?
Load actual configs of the main worktree. Also, skip the config loading
step if we're already inside the current worktree because in that case we
rely on is_bare_repository() to return the correct result.

Other solutions considered:
Alternatively, instead of incorrectly always using
`the_repository` as the main worktree's repository, we can detect
and load the actual repository of the main worktree and then use
that repository's `is_bare` value extracted from correct configs.
However, this approach is a bit riskier and could also affect
performance. Since we had the assignment `worktree->repo =
the_repository` for a long time already, I decided it's safe to
keep it as it is for now; it can be still fixed separately from
this change.

Real life use case:
1. Have a bare repo
2. Create a worktree from the bare repo
3. In the secondary worktree enable sparse-checkout - this enables
extensions.worktreeConfig and keeps core.bare=true setting in
config.worktree of the bare worktree
4. The secondary worktree or any other non-bare worktree created
won't be able to use branch main (not even once), but it should be
able to.

Signed-off-by: Olga Pilipenco <olga.pilipenco@shopify.com>
---
    worktree: detect from secondary worktree if main worktree is bare

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1829%2Folga-mcbfe%2Ffix-bare-repo-detection-with-worktree-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1829/olga-mcbfe/fix-bare-repo-detection-with-worktree-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1829

 t/t3200-branch.sh | 14 ++++++++++++++
 worktree.c        | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ccfa6a720d0..819228a3344 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -411,6 +411,20 @@ test_expect_success 'bare main worktree has HEAD at branch deleted by secondary
 	git -C secondary branch -D main
 '
 
+test_expect_success 'secondary worktree can switch to main if common dir is bare worktree' '
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
index 77ff484d3ec..1bce505bdd7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -64,6 +64,28 @@ static int is_current_worktree(struct worktree *wt)
 	return is_current;
 }
 
+static int is_bare_git_dir(const char *git_dir)
+{
+	int bare = 0;
+	struct config_set cs = { { 0 } };
+	char *config_file;
+	char *worktree_config_file;
+
+	config_file = xstrfmt("%s/config", git_dir);
+	worktree_config_file = xstrfmt("%s/config.worktree",  git_dir);
+
+	git_configset_init(&cs);
+	git_configset_add_file(&cs, config_file);
+	git_configset_add_file(&cs, worktree_config_file);
+
+	git_configset_get_bool(&cs, "core.bare", &bare);
+
+	git_configset_clear(&cs);
+	free(config_file);
+	free(worktree_config_file);
+	return bare;
+}
+
 /**
  * get the main worktree
  */
@@ -76,18 +98,16 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	strbuf_strip_suffix(&worktree_path, "/.git");
 
 	CALLOC_ARRAY(worktree, 1);
+	/*
+	 * NEEDSWORK: the_repository is not always main worktree's repository
+	*/
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
+		(!worktree->is_current && is_bare_git_dir(repo_get_common_dir(the_repository)));
+
 	if (!skip_reading_head)
 		add_head_info(worktree);
 	return worktree;

base-commit: 25b0f41288718625b18495de23cc066394c09a92
-- 
gitgitgadget
