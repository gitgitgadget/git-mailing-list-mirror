Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80563E173E
	for <git@vger.kernel.org>; Fri, 22 May 2026 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449516; cv=none; b=HXyENjBF6HgmX7XmMzvVO/goz2+gWZiVmKRaKSQXTF+zV1WM0Vfv0cDf5b70L+sYt0epbDrAkqkWMzeY1HgREPsQ/DUtWDL3vCdaRR2TajBHWWEYOME9lsCtMlJCKNtnoArSENPeyzhV6GgF1UwfPPYu4bvYw6xcZ377lQsec9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449516; c=relaxed/simple;
	bh=+BmN/Cnbu8pf8SO07NIqV0iqgA+xYBbFd+Wd97kVov8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KWndxfd4I5DTgCYp9xzeISh04ThU/LkgxYCmbmHaVqOR4rIlguk9F3EaMswjS3ZVK4TrcYm8YlCMjkoovTwJ47awqxzQMNHckJtD57/JGcvc4ujNDcLkWNP9OtHR8nVDMY9IAIP5UXPlm2dz1Bi80UQGu53LIEG7Yduw5iAMRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoIJ3x4f; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoIJ3x4f"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7c52e49d978so74493547b3.2
        for <git@vger.kernel.org>; Fri, 22 May 2026 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779449508; x=1780054308; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eRNBQ3dJVNLTJDeduNlhbFl7bfkhddcAfcgx0yE05E=;
        b=DoIJ3x4f6LpicUWvUdIrUjh0nQOUI+4oUJEXk+ONoWrPTBuuhw1MpNoeL6/0HzSKG1
         VTVrX9tH8JBtvKpoZMJ30WP3HgdUMOSAXAcy5cFN6V/aKyhd76RWnjITHYl5B9y94Bed
         4t2tzAHWCYfyvo8IB5dYBvQXP+dvu8nzyZMMjPPqArh3AngZK+hquvZv01vJxiZAZLhn
         j1Luhz2aXR40QC8w6OaNvzjN0No2rfr4FKDIH/0bNyUT/nggC3Y6Eph7AgY9xpWNtVLW
         VbclnGwcf5Jm0Yxy1qtL2Q5cl46oyu0iZ3agaJD2LcSOXjYjgIsVeVYyH097Kjv/PWKm
         hsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779449508; x=1780054308;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4eRNBQ3dJVNLTJDeduNlhbFl7bfkhddcAfcgx0yE05E=;
        b=MCiapcQzoyvyNEcCN3jDAXumn3N6ZgyKt3QKsmE92I/l5Q97iPnlAkbYTF2oRRMWbI
         xWhl1GysFJybXNwrBeP/Pzn1NHAug1W4IuqLwrecsPdnqyQftV9/MCnhgDZRYCBP7F0z
         kngmhIxTGWhJOy2/W2sVDOuLe/wEjIbQITygd+hc9I7jQqu5Zc5R0UC0zCWuqYL4+7R8
         mx3xj5pX3TH+6GxZ9WfTL7q+TwGhcr20PskhBDYK53NGZzdgciiqf18/8yKuex1OeRnz
         a5ZXhh3xwkNZ0veVdA4pLi8hSh7xqnLtqOAu8gmIfustt8xoMzrKJmyztj5INYU6Q6UV
         OX3w==
X-Gm-Message-State: AOJu0YzVAGKEFkmLb2HK7AYg/Ox1eDGfepMzwUnesa2bI4abYx5k0IKo
	LIzWuWOsKcEMVFoAByUbTkkaeGnx7wekHpKrThHHJYae/7u8kwlRIX5JwMtZ4Q8c
X-Gm-Gg: Acq92OHXP0VtmD6Mf7ffGzfdJ8l13YVhkR6i2KU3Q4ff0crXdMwO+QfVXKOc8iVSze/
	zvxAUIhoMeBtyMQYVLThft+2IvYO6sPIw06rltj0sUpe4JThCZRx4BENFUcgR6I7ZlFgxIpHCpK
	aNs1j6LiOma9nAsmhg994v2StckQrxp3809/xHSY04u8RXAJkbizVa222T1BMgT9eqM3F4rGOba
	BoWiSwt0BFy3gQp9Lblt+e9fdMrAY4pS/c1ek3z5C4SY3fPraeoHjCLW9D/ct/W3b1zzQgqm/j0
	3wWN78SDYLcKUDe3g3CKkRHUDmEsYrOcNW2ATi7ZCo485LjqIE0LKulnpi2l28k1317Jzsug+xS
	X3ZBYjuVKBLbiqc2TDIVZGLbd0VxBz4xtbqtf3tMSJnRpDIANSr8+p0pkGwLMvtESSWENihcBVF
	bOFjz9HtVp8OmZs+mX9f+xvjJ1RXccTCe7YpQ/
X-Received: by 2002:a05:690c:4483:b0:7d1:c256:b5c5 with SMTP id 00721157ae682-7d3355db72fmr37812437b3.10.1779449508335;
        Fri, 22 May 2026 04:31:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.47.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm15007846d6.38.2026.05.22.04.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:31:47 -0700 (PDT)
Message-Id: <a1a42a6b1950bf49762b9f8d6555210aa5119b10.1779449498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
References: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 11:31:38 +0000
Subject: [PATCH v11 6/6] branch: add --dry-run for --prune-merged
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
delete -- one "Would delete branch <name>" line per candidate --
and exits without touching any ref.

This is the natural sanity check before letting a broad pattern
like 'origin/*' run for real: the @{push}-vs-@{upstream} and
unmerged filtering still applies, so the dry-run output is
exactly the set that the live run would delete.

--dry-run is only meaningful in combination with --prune-merged
and is rejected otherwise.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  8 ++++++-
 builtin/branch.c              | 13 ++++++++---
 t/t3200-branch.sh             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 1bd28c4e37..ee9a6354fd 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,7 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch --forked <branch>...
-git branch --prune-merged <branch>...
+git branch --prune-merged [--dry-run] <branch>...
 
 DESCRIPTION
 -----------
@@ -235,6 +235,12 @@ Branches refused by the "fully merged" safety check are listed as
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
index 187d5d1563..7a2db11cd4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -857,7 +857,8 @@ static int list_forked_branches(int argc, const char **argv)
 	return 0;
 }
 
-static int prune_merged_branches(int argc, const char **argv, int quiet)
+static int prune_merged_branches(int argc, const char **argv, int quiet,
+				 int dry_run)
 {
 	struct ref_store *refs = get_main_ref_store(the_repository);
 	struct string_list candidates = STRING_LIST_INIT_DUP;
@@ -914,7 +915,7 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
 				      quiet,
 				      1, /* warn_only */
 				      1, /* no_head_fallback */
-				      0  /* dry_run */);
+				      dry_run);
 
 	strvec_clear(&deletable);
 	string_list_clear(&candidates, 0);
@@ -964,6 +965,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
 	int prune_merged = 0;
+	int dry_run = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1021,6 +1023,8 @@ int cmd_branch(int argc,
 			N_("list local branches whose upstream matches the given <branch>...")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches whose upstream matches the given <branch>... and is merged")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+			N_("with --prune-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1079,6 +1083,9 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (dry_run && !prune_merged)
+		die(_("--dry-run requires --prune-merged"));
+
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
@@ -1120,7 +1127,7 @@ int cmd_branch(int argc,
 		ret = list_forked_branches(argc, argv);
 		goto out;
 	} else if (prune_merged) {
-		ret = prune_merged_branches(argc, argv, quiet);
+		ret = prune_merged_branches(argc, argv, quiet, dry_run);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index da7e174e09..0e0629d19e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2020,4 +2020,48 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
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
+	git -C pm-dry branch --prune-merged --dry-run "origin/*" >actual &&
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
+	git -C pm-dry-mixed branch --prune-merged --dry-run "origin/*" >out &&
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
