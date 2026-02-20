Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5E303A18
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574838; cv=none; b=Jhgt4tM3DNRmU2pW+nOKSyajeu98NDSn9ZUMGLGSzUfukClVSa44g0PnZWC4ja+X0vje9I1yH/C6qPLtRH44xgY2O0NVAP2RFupzdukxri0qiKhuwaC0FboxvOU12LWFr7n95HzO3P2XNUGQ/unYtKlizLsgWT34/vXt3ix/zYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574838; c=relaxed/simple;
	bh=ECejJIHYc+XC1hgBVPzCyLtaOaRyv3gQHMxn46O3DtI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Tg00WyUOErSphvG0S1PzD/prQvmie+YV6Uf8m/RtHYjhhC97JzL1QPEbJ/vaGj33Fdr0mT9uTUY9WIqoD6MabKPKbewcP9fty0/sZT1fMVvoqaLfsT5mo0OPVZr/KaUDkEykqana5/s61giGdnFKfX16+kLzqX8gQQH1UcxPr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c101k1sD; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c101k1sD"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso3525982eec.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 00:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771574835; x=1772179635; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MfzNzMif67lAowI38V3ld+bnKYUaNHXawwh2o4+Im64=;
        b=c101k1sDPPATV7ZgBKsTOcXR1SdLJYfiHYbWCrgbMlssxXnduaRm56Uzntgj/PWmC3
         1BLpzSHomYfmwaWXZ25301QC7lODspz9usWFyTYRXx+IcYymuc/6UiNIzqcHqkiqsWbx
         RLDms8cug57HhKVRxnkBlUQiy8LF5tAaM5kKG9BwEsqJlwc0WM/hjY6kbX16yV3nxqlK
         83KSQU28tnNxmQ/xdVSWCu9x05pAviw4PNC8DlTwAM7nYbY9oX0p9AxRKgzqm8MYzkpt
         ntU6lKNWMCCjfeOPTQ0bURV/sGz28K99O+VI+HQ7L5XmTm6GUVfZb7cZWYvTMY8kQR6T
         9Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771574835; x=1772179635;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfzNzMif67lAowI38V3ld+bnKYUaNHXawwh2o4+Im64=;
        b=IvJ7JwDVfH1qgYj5si3k9YGt4Zkr5PEAKi3gmfjE5rsRK3BC7plx+Fby3vsg5UsCjh
         SASUj9EMStOoHgYdm5005XRA1P8XzxHmD+5twODGJs73cpxMeIPINQc/H1v21XIKiPuC
         jRvVKgE8MCF0i3G9wXTMjWditryi3qoO9jwzuxOSzRq3b/CtEr8VqoQlowbI12rZCTHx
         PLaRWhZb91tj69Phc9aYSLaqLekHqOTelXx2FutiyzTx5TlQn5sqLOomgem0Vc40r2mD
         GSQEtV/RrAAO8mrSkufcUgcUncqZ5Z29JXOzw3DTaXBvkVfgcdnLSRmQDtB7Nlap5Pjk
         D/QA==
X-Gm-Message-State: AOJu0Yy1Pocblb5mXmVBoE6Tnw6dLtLwscQalQfo4zF2tN+DBQ1nzLeG
	VAxaG1Ns+otpr9qvNUSwRq9Jnd/OwtY84maS3Wdc8vlENdj099y1bIeEaljA0A==
X-Gm-Gg: AZuq6aKvww0NJKJM3U12gxujTdv09CHvDJh8vzHL8sQpA7MQzlcYGiauDRx8K/UdNi9
	1Hqq+h9Cxu6wWJqsmQD//v3JDcucVNdkSNQclpGp5U2PYDdgO+wESg6f/FEzAH8KOsl0VDPeI/M
	4pmBbkr2YxLSoWbAeiN0LMdDfqUw/Qgktwi86Hr+9VSP+dWE6zMmY7WRJbg3TG3cyKmlw0wPdWu
	1+w2/RwlcINBkPQ4px15DHLFzIWNPTadrtMngzTVYXg6kYtOiKC+fAHK1tRroCE8+hmuGj3RDzH
	0GoJT/wb6Jcb5YcLCQEM3RmMsg1qrG7KAvzFKHx2qw03G5NY8PhDhnP/9FNO9IvX7AZEsfBUuqI
	RxNI7FfjO0DnzguRieMXNZgAKlzLe09JD4qwCyDOksgKp65LUqix5KhbIZAGa63dmjiwETWhCHr
	yVpqX6zIQSc/IsGhDvSe2FTns38i/9G2nVsLFP
X-Received: by 2002:a05:7301:1f05:b0:2b0:571a:28a5 with SMTP id 5a478bee46e88-2bd733590e1mr390466eec.18.1771574835310;
        Fri, 20 Feb 2026 00:07:15 -0800 (PST)
Received: from [127.0.0.1] ([20.168.117.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb555b6esm23633506eec.8.2026.02.20.00.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 00:07:14 -0800 (PST)
Message-Id: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com>
From: "Yoann Valeri via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 08:07:13 +0000
Subject: [PATCH] branch: add 'branch.addCurrentBranchAsPrefix' config param
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
    Yoann Valeri <yoann.valeri@cea.fr>,
    VALERI Yoann <yoann.valeri@cea.fr>

From: VALERI Yoann <yoann.valeri@cea.fr>

This patch adds a new configuration parameter for the branch creation
feature: 'branch.addCurrentBranchAsPrefix'. When set to true, if one
creates a new branch with either `git branch`, `git checkout -[bB]` or
`git switch -[cC]`, we will now retrieve the current branch's name, and
use it as prefix for the name of the newly created branch, alongside a
hyphen separating the two.

For instance, using this parameter, and attempting to create a branch
'test' while on the 'main' branch will instead create a branch
'main-test'.

This parameters is useful for projects handling many branches, with
features often needing backport on different branches, so as to reduce
the time taken to create branches without having to come up with clever
names.

Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
---
    branch: add 'branch.addCurrentBranchAsPrefix' config param

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2202%2Fvaleriyoann%2Fbranch-with-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2202/valeriyoann/branch-with-prefix-v1
Pull-Request: https://github.com/git/git/pull/2202

 Documentation/config/branch.adoc |  7 +++++
 branch.c                         | 14 +++++++++
 branch.h                         |  8 +++++
 builtin/branch.c                 | 17 ++++++-----
 builtin/checkout.c               | 52 +++++++++++++++++++++++---------
 t/t2018-checkout-branch.sh       | 26 ++++++++++++++++
 t/t2060-switch.sh                | 26 ++++++++++++++++
 t/t3200-branch.sh                | 14 +++++++++
 8 files changed, 142 insertions(+), 22 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..bd153ea406 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -35,6 +35,13 @@ This option defaults to `never`.
 	value of this variable will be used as the default.
 	See linkgit:git-for-each-ref[1] field names for valid values.
 
+`branch.addCurrentBranchAsPrefix`::
+	When a new branch is created with `git branch`, `git switch` or `git
+	checkout` use the name of the current branch as a prefix for the new
+	branch's name, alongside the one provided by the user, with a hyphen in the
+	middle. For instance, using this configuration variable, creating the branch
+	`test` while on `main` will create the branch `main-test`. False by default.
+
 `branch.<name>.remote`::
 	When on branch _<name>_, it tells `git fetch` and `git push`
 	which remote to fetch from or push to.  The remote to push to
diff --git a/branch.c b/branch.c
index 243db7d0fc..f2d348b046 100644
--- a/branch.c
+++ b/branch.c
@@ -365,6 +365,20 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
+void add_branch_prefix(const char *current_branch,
+					   const char *target_branch, struct strbuf *buf)
+{
+	int value = 0;
+
+	repo_config_get_bool(the_repository,
+						 "branch.addCurrentBranchAsPrefix", &value);
+
+	if (value)
+		strbuf_addf(buf, "%s-%s", current_branch, target_branch);
+	else
+		strbuf_addstr(buf, target_branch);
+}
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/branch.h b/branch.h
index ec2f35fda4..060de1b72c 100644
--- a/branch.h
+++ b/branch.h
@@ -148,6 +148,14 @@ int install_branch_config(int flag, const char *local, const char *origin, const
  */
 int read_branch_desc(struct strbuf *, const char *branch_name);
 
+/*
+ * Fetch the configuration parameter 'branch.addCurrentBranchAsPrefix' and
+ * fill the buffer 'buf' with '<current_branch>-<target_branch>' if true,
+ * otherwise just '<current_branch>'.
+ */
+void add_branch_prefix(const char *current_branch,
+					   const char *target_branch, struct strbuf *buf);
+
 /*
  * Check if a branch is checked out in the main worktree or any linked
  * worktree and die (with a message describing its checkout location) if
diff --git a/builtin/branch.c b/builtin/branch.c
index c577b5d20f..2fbf2d9722 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -995,6 +995,7 @@ int cmd_branch(int argc,
 	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
 		const char *branch_name = argv[0];
 		const char *start_name = argc == 2 ? argv[1] : head;
+		struct strbuf new_branch_name = STRBUF_INIT;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("the -a, and -r, options to 'git branch' do not take a branch name.\n"
@@ -1003,15 +1004,17 @@ int cmd_branch(int argc,
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
-		if (recurse_submodules) {
-			create_branches_recursively(the_repository, branch_name,
+		add_branch_prefix(start_name, branch_name, &new_branch_name);
+
+		if (recurse_submodules)
+			create_branches_recursively(the_repository, new_branch_name.buf,
 						    start_name, NULL, force,
 						    reflog, quiet, track, 0);
-			ret = 0;
-			goto out;
-		}
-		create_branch(the_repository, branch_name, start_name, force, 0,
-			      reflog, quiet, track, 0);
+		else
+			create_branch(the_repository, new_branch_name.buf, start_name,
+						  force, 0, reflog, quiet, track, 0);
+
+		strbuf_release(&new_branch_name);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0ba4f03f2e..950198d8f3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1170,31 +1170,42 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	release_revisions(&revs);
 }
 
+static void get_current_branch_info(struct branch_info *branch_info)
+{
+	struct object_id rev;
+	int flag;
+
+	branch_info->path = refs_resolve_refdup(get_main_ref_store(the_repository),
+											"HEAD", 0, &rev, &flag);
+
+	if (branch_info->path)
+		branch_info->commit = lookup_commit_reference_gently(the_repository,
+															 &rev, 1);
+
+	if (!(flag & REF_ISSYMREF))
+		FREE_AND_NULL(branch_info->path);
+
+	if (branch_info->path) {
+		const char *const prefix = "refs/heads/";
+		const char *p;
+
+		if (skip_prefix(branch_info->path, prefix, &p))
+			branch_info->name = xstrdup(p);
+	}
+}
+
 static int switch_branches(const struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
 	int ret = 0;
 	struct branch_info old_branch_info = { 0 };
-	struct object_id rev;
-	int flag, writeout_error = 0;
+	int writeout_error = 0;
 	int do_merge = 1;
 
 	trace2_cmd_mode("branch");
 
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
-	old_branch_info.path = refs_resolve_refdup(get_main_ref_store(the_repository),
-						   "HEAD", 0, &rev, &flag);
-	if (old_branch_info.path)
-		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
-	if (!(flag & REF_ISSYMREF))
-		FREE_AND_NULL(old_branch_info.path);
-
-	if (old_branch_info.path) {
-		const char *const prefix = "refs/heads/";
-		const char *p;
-		if (skip_prefix(old_branch_info.path, prefix, &p))
-			old_branch_info.name = xstrdup(p);
-	}
+	get_current_branch_info(&old_branch_info);
 
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
 		if (new_branch_info->name)
@@ -1772,6 +1783,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	int parseopt_flags = 0;
 	struct branch_info new_branch_info = { 0 };
 	int ret;
+	struct strbuf full_branch_name = { 0 };
 
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
@@ -1962,7 +1974,15 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if (opts->new_branch) {
+		struct branch_info current_branch = { 0 };
 		struct strbuf buf = STRBUF_INIT;
+		strbuf_init(&full_branch_name, 0);
+
+		get_current_branch_info(&current_branch);
+		add_branch_prefix(current_branch.name, opts->new_branch,
+						  &full_branch_name);
+		branch_info_release(&current_branch);
+		opts->new_branch = full_branch_name.buf;
 
 		if (opts->new_branch_force)
 			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
@@ -1981,6 +2001,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	clear_pathspec(&opts->pathspec);
 	free(opts->pathspec_from_file);
 	free(options);
+	if (full_branch_name.buf)
+		strbuf_release(&full_branch_name);
 
 	return ret;
 }
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index a48ebdbf4d..8345a509dc 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -285,4 +285,30 @@ test_expect_success 'checkout -b rejects an extra path argument' '
 	test_grep "Cannot update paths and switch to branch" err
 '
 
+test_expect_success 'checkout -b with prefix is valid' '
+	git checkout -b main &&
+	git checkout -b checkoutb-with-prefix &&
+	git checkout main &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	test_must_fail git checkout -b checkoutb-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git checkout -b checkoutb-with-prefix &&
+	git checkout -b checkoutb-with-prefix &&
+	test_ref_exists refs/heads/checkoutb-with-prefix &&
+	test_ref_exists refs/heads/main-checkoutb-with-prefix &&
+	test_ref_exists refs/heads/main-checkoutb-with-prefix-checkoutb-with-prefix
+'
+
+test_expect_success 'checkout -B with prefix is valid' '
+	git checkout main &&
+	git checkout -B checkoutB-with-prefix &&
+	git checkout main &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	git checkout -B checkoutB-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git checkout -B checkoutB-with-prefix &&
+	test_ref_exists refs/heads/checkoutB-with-prefix &&
+	test_ref_exists refs/heads/checkoutB-with-prefix-checkoutB-with-prefix
+'
+
 test_done
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index c91c4db936..458f8b9f3f 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -177,4 +177,30 @@ test_expect_success 'switch back when temporarily detached and checked out elsew
 	git -C wt2 switch --ignore-other-worktrees shared
 '
 
+test_expect_success 'switch -c with prefix is valid' '
+	git switch main &&
+	git switch -c switchc-with-prefix &&
+	git checkout main &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	test_must_fail git switch -c switchc-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git switch -c switchc-with-prefix &&
+	git switch -c switchc-with-prefix &&
+	test_ref_exists refs/heads/switchc-with-prefix &&
+	test_ref_exists refs/heads/main-switchc-with-prefix &&
+	test_ref_exists refs/heads/main-switchc-with-prefix-switchc-with-prefix
+'
+
+test_expect_success 'switch -C with prefix is valid' '
+	git switch main &&
+	git switch -C switchC-with-prefix &&
+	git checkout main &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	git switch -C switchC-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git switch -C switchC-with-prefix &&
+	test_ref_exists refs/heads/switchC-with-prefix &&
+	test_ref_exists refs/heads/switchC-with-prefix-switchC-with-prefix
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c58e505c43..496b034d0b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1716,4 +1716,18 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create branch with prefix' '
+	git config branch.autosetupmerge false &&
+	git branch branch-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix false &&
+	test_must_fail git branch branch-with-prefix &&
+	test_config branch.addCurrentBranchAsPrefix true &&
+	git branch branch-with-prefix &&
+	git checkout branch-with-prefix &&
+	git branch branch-with-prefix &&
+	test_ref_exists refs/heads/branch-with-prefix &&
+	test_ref_exists refs/heads/main-branch-with-prefix &&
+	test_ref_exists refs/heads/branch-with-prefix-branch-with-prefix
+'
+
 test_done

base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
-- 
gitgitgadget
