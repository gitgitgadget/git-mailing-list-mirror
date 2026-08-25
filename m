Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D73C1978
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691886; cv=none; b=GrX5PL58qLnuQxvgUZwRthiKPUq5qTFKj01WcUit7YhQLcabINHjuoo5hhZJkkPE++eGt9R/x7WZZ1yuQsWeABPQdPXYhMf+tZ3QOIkPiu/DrKeJ3vc73kDFEbmujUNSc2IM8dRxsYcwgN93MQpgrt1Kvs7/p1wCncwd+kvjyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691886; c=relaxed/simple;
	bh=aPn09J8XHphtmZ6EoN6j3uY3tPwlQBSbqSRp/D4D7eM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lwaKSzh36tZsK0D5HPSMkr/RQTo5huzOnLzu6zZ9HfyLuYrwW/XcGH0IfVsEPuELMcNZVDzb83B7nw4myPLOj6Yl5BJkQneMr73a71qi+w3hpwbOqAHXVJ+ZJr2vXu9DStNQHW5jeHoY39w18vY5VQ2LFUlJn56UXUi8fkRA8Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPUC9pNS; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPUC9pNS"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4a483a552efso210960b6e.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787691883; x=1788296683; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DSAQJtONuhy4htQLdmcrCEoDotLQEM1Xc+7Kv4D2cew=;
        b=cPUC9pNSHPqkj/BjOuqL3slkRA6ohQnFvpSOliDt2QxSdS4BK8KGMMYCKOBV99cSln
         Yf9sYucOFJ73iEMaPaiC6b1DeAdGr0IQV3jDptZ3+h8vVMjSuLuUwr/7c/V21c0L3mAK
         XqjfhftSUD4/s/GH+Ejw70133869DAlzT7/CkX86Ez6ypU+gWA1/SWza09dvSgxubxSC
         kXKkgNlf9W80cbRTtAD5oFl2Ivfd1wKqDc5LXHrVucabzrLVW4RHscWEM7IX2i87nI7g
         TzF+35TuXkIGAE36yvdPCfBDTfjyaY4MrqQKM4zsCLIHb+zoqbaqsaZloYxrLyV9MDSF
         Ttsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787691883; x=1788296683;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSAQJtONuhy4htQLdmcrCEoDotLQEM1Xc+7Kv4D2cew=;
        b=G0h1TZUaiCL2IEcF0+STJ9n+opljhshTdTgbDpsiWQZ7kRMZON3/lqzECh8UhsX5OD
         RsO6InN7vG5ohed+Y5YPXfPaKfGht53FXlRfe0LhoeC/CyuOQkSm2tD0+66Dveze/1nX
         0saZcYiY+lWchQj1pnAcLLyzyCpRms7GRM6GDXhZouFdcFTDE0bcu+iWSDdcV/hVPM0q
         bkKyIyXJHMbbw/EHX3U/5sBZzHduNGLgtMZImgdGTM9ruAaokzBV0B/GY+JnKuTl24Zt
         JmUclNVikoMQZ4FEclNtrMSfCFbitF0/0sY6o85L+4Ewn1KAwnGtn7ZTlHVMNwzMM54Q
         CLog==
X-Gm-Message-State: AFuF++mgrdTyd1QzCYe77ZE77ux2ivsA2e7IddqwXC+8cwxicNUP412C
	6rAUybVFeHNGc37/8sYTWLz5XizXXAcAkLQB09hUsLqy9kD3IlZeDz6bKW1koA==
X-Gm-Gg: AR+sD13SeeffbqewjlWtmG8d0864QNbw7H7GQTGHmDWgeTPza2HfNpS0YoQxo7Io8Xi
	S0+lYjhmGAdhAUsb9qbNJUv+r9kzhvcMFYkQOy6q/fi1lStesUcORnfw7IHTv4xbVANNQxVq/XG
	uo3yGO5o0eVaH556141/4xk9ADnURDLy8U6c3c7L2EhxXDaE3EkCNW1KK9OZtv6i0nY2tuqtsqf
	1TicWFHeZy6pBVfPFXJtlexo5awFAVtb1jXFA7FgVKAtB0PpiGROi1PMg4tqvwBDmMcUDI2Zh25
	GT9OrJd2SpwsX5fov30+Xg+zk6/wy3jzZbqYpf1HmGynWND5Ik2LPsPdKl/QN2Eivk92WAkOzPl
	OWGaJEg1nYYYGjD17M23unz2QMV7sZU8+Uj77bA0itscaAfrwlA42seyaxfcEKnQIweqlF+PfIG
	IuQTlNrwUolbGaspE02fZOP08mBbqEGbfof3sDzjub4JAnVk9Pu6OTmJyOrGLF5Zh33A==
X-Received: by 2002:a05:6808:c164:b0:496:2b3:ae71 with SMTP id 5614622812f47-4b366b59758mr2657787b6e.18.1787691883023;
        Tue, 25 Aug 2026 14:04:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.165.178])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b36a7b06c2sm31324b6e.7.2026.08.25.14.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:04:42 -0700 (PDT)
Message-Id: <095a5796d4c92012825daa07eef67140a7461018.1787691875.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v8.git.1787691875.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v8.git.1787691875.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 21:04:34 +0000
Subject: [PATCH v8 3/4] worktree add: improve message for ambiguous remote
 branch name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When the user runs 'git worktree add ../foo-dir bar-topic' without
specifying a remote, and there is no local branch named bar-topic, we
try to guess which remote branch bar-topic refers to, then create a
new branch named bar-topic that tracks the remote branch.

If multiple remotes have a branch named bar-topic, we silently gave
up, leaving the variable 'branch' intact.  We then entered the
conditional clause 'if (!opts.orphan &&
!lookup_commit_reference_by_name(branch))' and triggered an "invalid
reference" error.  This error message did not provide enough
information to resolve the ambiguity.

When multiple matching branches are found, display a hint and a
descriptive error message and die immediately.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/worktree.c      | 37 ++++++++++++++++++++++++++++++++++---
 t/t2400-worktree-add.sh |  4 ++--
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 22c8e5e131..320b18873d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -788,6 +788,25 @@ static char *dwim_branch(const char *path, char **new_branch)
 	return NULL;
 }
 
+static void advise_disambiguating_remotes(const char *path, const char *branch,
+					  const struct string_list *matched_remote_names)
+{
+	struct string_list_item *item;
+
+	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
+		 "<remote>, you can do so by:\n"
+		 "\n"
+		 "    git worktree add -b %s %s <remote>/%s\n"
+		 "\n"
+		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
+		 "consider setting checkout.defaultRemote=origin in your config."),
+	       branch, path, branch);
+}
+
 static int add(int ac, const char **av, const char *prefix,
 	       struct repository *repo UNUSED)
 {
@@ -898,17 +917,29 @@ static int add(int ac, const char **av, const char *prefix,
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac == 2) {
-		struct object_id oid;
 		struct commit *commit;
-		char *remote;
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL, NULL);
+			struct object_id oid;
+			char *remote;
+			int num_matches = 0;
+			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
+
+			remote = unique_tracking_name(branch, &oid, &num_matches,
+						      &matched_remote_names);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet &&
+				    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+					advise_disambiguating_remotes(path, branch,
+								      &matched_remote_names);
+				die(_("'%s' matched multiple (%d) remote tracking branches"),
+				    branch, num_matches);
 			}
+			string_list_clear(&matched_remote_names, 0);
 		}
 
 		if (!strcmp(branch, "HEAD"))
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..5c105cf252 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual
-- 
gitgitgadget

