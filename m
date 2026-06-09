Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F443F44C0
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999927; cv=none; b=IzgPoHOOIZ16ArddlGALvgDVbY5OwrnUnChY55u3xeJiaBwcEBK+RzNdtvtJ1xS5WfYVHzTwKZ4TwGVONlIQFT4wJ6+KyZ3fV6rjgzSyt161tZ8gKSyb2V65Mk0dnhQPtRTEqcEKJKQElc5ti25z5Lo05DiU+zmT4pCkEuiQJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999927; c=relaxed/simple;
	bh=NXT1t8D2ByfAoBymXOOKRcjXdfpBLPZryyuPguSLgAk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B6MPZg2T9QoyRVj77VevrX5AiwqWuf5zHCZ7GCL8MFbIxFkNktNfEhRckdXPzEyPVqQjYLN1Xot5aSJKbdZFZvCXwJhRPKvwd9wjxzTgCANhPi0D4GyH/i2I4p/NUb+n5fWEJasT2uO2viXV2fwr60vsnHhU6NN4TDXghqXSHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmXIpOIC; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmXIpOIC"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce9df48e1bso53040486d6.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999925; x=1781604725; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rctPqhIR3IhxiwOQopgVwF0PJcIZ2oSDC5ZI96ROrCk=;
        b=SmXIpOICqbkviD126W1wke7ONvbaL8M2Yq556EPWCOTegFB01gf48UXRgZQPz9B0H3
         k/2bF4WmU0ycnw5yMTFsJCVsnjlCxpxNbvcLBX0dWYJCU9RxnFiA7/WKSu/5TDKVEPgu
         qZ21b30GUEXjL7Yd6o74mmBDobOEU1GkIxOErQDoxed+liRPHmrcl4ZB5SIAZ8b5lgP1
         l+oLYf3+lUw5T1SkPMbEsSf7WzOhVxKsFBm4hs8Prqcgtq6+YsD5F/zLZI796l7ERvWo
         mfpQuCq+EJF70a0WtXwqYj5XW4pu+6gzK1Nws/c78OxaPEZoY/5rDewYiYI2ib8nO5uM
         VmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999925; x=1781604725;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rctPqhIR3IhxiwOQopgVwF0PJcIZ2oSDC5ZI96ROrCk=;
        b=U1474Wcl4wOm1C64wLXifbmGo09/9uqzVwwNPkVjYKU/A1nu1r8O9guJYLKzb9uKPU
         l/uCDN7U0NgypldfVupNNLh/XinCjp7U4S54ufpUJ73pODMUmX6lK6w3Xr7n5X1vqxUo
         yzcpfYbPanlllKbg1uExpIM2IoItbnn2dj0bdP1S3ACPj6z3FK6xT0M9dydstH1LarzK
         h563+GFA3pAPzvMCKKI67fba+Tlv9e4rbyBcqKvVVXd8S+0/Z6o9+D7qKTc9O0A7iY++
         nEBF+TRE3xwxl0tpRpvibJDGQlKw7oxKYjxBS7YD07xnjNK2ZRcwBVnKPAQOGySIZpv7
         v/+w==
X-Gm-Message-State: AOJu0YzNKa/Sl+e8OIorJ5ZcjG/+TC849iv/2OeJys0iOdMmxCUk11+D
	Vr7+KMrnLOyaXYaIY4ehgSBlbKAmm/bjBahgXpZ7AFlkHOEsziZPVWkv8yz4hDMT
X-Gm-Gg: Acq92OEcqbXZOy3HMJ0fKtNyPMiDdGMztLMp17QyLl6mvp4mD9HLFbL3Rwb/xi4bPml
	o4NqxFBvintEKXhGK655qUmjLr3uGc9AhUEQSASfqQ+Y5Un1Ww7HG7Nh28E91ZfEF+V+FADAfuw
	m/ahXsianXaVp2Lb9wWr90TqiesEyxhaBeHqercDVCwaFDEasrSwW6fEapWLZkGTAd61T0MMKIb
	+vaoLAtsxQwL3oiuZxFk0m731Rpa0XUidJ8PqgwpGXiVKZ/OSfqu3+4XmQhkTa3JKZcqQ7ttj9k
	Z/1pDKgqsAIrbTakzKuRzU0tIaOTUbSALDNQJVnis3P7Ao9bEqIENQtHcbeYbhMVK8QjEe6AdjX
	NI51TBZKOdbHwSsoayKEaTwC03Jw1KyxhL7329Fs+sRdCTnhdDtD2w3gXw5z0ui7vd8qah7G51x
	7yrkkpPY/TZrBsdt3n+qy6mMBZeMP7gF0GTw==
X-Received: by 2002:a0c:e6ca:0:b0:8cc:f882:2564 with SMTP id 6a1803df08f44-8cee61528afmr231475076d6.40.1780999924714;
        Tue, 09 Jun 2026 03:12:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.9.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb9fc0sm200483076d6.17.2026.06.09.03.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:12:04 -0700 (PDT)
Message-Id: <ede8c6172963fb8d15f0ae28f4e11501cf42be6c.1780999917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jun 2026 10:11:57 +0000
Subject: [PATCH v14 6/6] branch: add --dry-run for --prune-merged
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

With --dry-run, --prune-merged prints the local branches it would
delete, one "Would delete branch <name>" line each, and exits
without touching any ref. The same filtering applies, so the output
is exactly the set that the real run would delete.

--dry-run is only meaningful together with --prune-merged and is
rejected otherwise.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  8 ++++++-
 builtin/branch.c              | 13 ++++++++---
 t/t3200-branch.sh             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 5c43dc55a8..1f49a831fd 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch --prune-merged <branch>...
+git branch [--dry-run] --prune-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -226,6 +226,12 @@ Branches refused by the "fully merged" safety check are listed as
 warnings and skipped; pass them to `git branch -D` explicitly if
 you want them gone.
 
+`--dry-run`::
+	With `--prune-merged`, print which branches would be
+	deleted and exit without touching any ref.  Useful for
+	sanity-checking a wide pattern like `'origin/*'` before
+	committing to the deletion.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 52a0371292..7c52a88af2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -717,7 +717,7 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 }
 
 static int prune_merged_branches(int argc, const char **argv,
-				 int quiet)
+				 int quiet, int dry_run)
 {
 	struct ref_store *refs = get_main_ref_store(the_repository);
 	struct ref_filter filter = REF_FILTER_INIT;
@@ -777,7 +777,8 @@ static int prune_merged_branches(int argc, const char **argv,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_WARN_ONLY |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      (quiet ? DELETE_BRANCH_QUIET : 0));
+				      (quiet ? DELETE_BRANCH_QUIET : 0) |
+				      (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
 
 	strvec_clear(&deletable);
 	ref_array_clear(&candidates);
@@ -827,6 +828,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int prune_merged = 0;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -882,6 +884,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches whose upstream matches <branch> and is merged")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --prune-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -944,6 +948,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !prune_merged)
+		die(_("--dry-run requires --prune-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -983,7 +990,7 @@ int cmd_branch(int argc,
 				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
 	} else if (prune_merged) {
-		ret = prune_merged_branches(argc, argv, quiet);
+		ret = prune_merged_branches(argc, argv, quiet, dry_run);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3f7b1fc3d6..305c0141fc 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2040,4 +2040,48 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 '
 
+test_expect_success '--prune-merged --dry-run lists but does not delete' '
+	test_when_finished "rm -rf pm-dry" &&
+	git clone pm-upstream pm-dry &&
+	git -C pm-dry remote add fork ../pm-fork &&
+	test_config -C pm-dry remote.pushDefault fork &&
+	test_config -C pm-dry push.default current &&
+	git -C pm-dry branch one one-commit &&
+	git -C pm-dry branch --set-upstream-to=origin/next one &&
+	git -C pm-dry branch two two-commit &&
+	git -C pm-dry branch --set-upstream-to=origin/next two &&
+
+	git -C pm-dry branch --dry-run --prune-merged "origin/*" >actual &&
+	test_grep "Would delete branch one " actual &&
+	test_grep "Would delete branch two " actual &&
+
+	git -C pm-dry rev-parse --verify refs/heads/one &&
+	git -C pm-dry rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--prune-merged --dry-run only lists branches the live run would delete' '
+	test_when_finished "rm -rf pm-dry-mixed" &&
+	git clone pm-upstream pm-dry-mixed &&
+	git -C pm-dry-mixed remote add fork ../pm-fork &&
+	test_config -C pm-dry-mixed remote.pushDefault fork &&
+	test_config -C pm-dry-mixed push.default current &&
+	git -C pm-dry-mixed checkout -b wip origin/next &&
+	git -C pm-dry-mixed branch --set-upstream-to=origin/next wip &&
+	test_commit -C pm-dry-mixed local-only &&
+	git -C pm-dry-mixed checkout - &&
+	git -C pm-dry-mixed branch merged one-commit &&
+	git -C pm-dry-mixed branch --set-upstream-to=origin/next merged &&
+
+	git -C pm-dry-mixed branch --dry-run --prune-merged "origin/*" >out &&
+	test_grep "Would delete branch merged" out &&
+	test_grep ! "Would delete branch wip" out &&
+	git -C pm-dry-mixed rev-parse --verify refs/heads/wip &&
+	git -C pm-dry-mixed rev-parse --verify refs/heads/merged
+'
+
+test_expect_success '--dry-run without --prune-merged is rejected' '
+	test_must_fail git -C forked branch --dry-run 2>err &&
+	test_grep "requires --prune-merged" err
+'
+
 test_done
-- 
gitgitgadget
