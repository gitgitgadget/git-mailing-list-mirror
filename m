Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD54949FF
	for <git@vger.kernel.org>; Tue, 12 May 2026 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574244; cv=none; b=n+Ke5vCt5+3wY0p0xQfMllto94xo+zgrgq0e21zXDykGAx+TdPjqyPXWHLuQq2q0U2vXUxLH7aF8Z8nCp/gdmyASqVpn98Hu9vc/RVQXnwY5TkUartz39eHMYTwzQgS9cqafKFRlB4QpZ/oNDrcUdOxzi7y1AQnwCyRYKpBTKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574244; c=relaxed/simple;
	bh=kbCE+dvSbs12DhYf9ZTDkSAnMl2ehOvBNguuPpUR4sE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mUYRVwpxRsfu15SHLSctUyYM6eYY5zATwcbbH2dU6FQvL1hDsunyHk/5Wz4N2xPTm6NNtNQECTI4yIes2zr1D8Mg9IZEwgFJ9gTDEGmo+tNxQfRjBccJ7KuQdljUI/9IOmzKjEDh0F+z9CjdBhWfMu/WyYgBMCcdNVti8wA1/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhOHwH+a; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhOHwH+a"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8eb5ad01402so528449485a.2
        for <git@vger.kernel.org>; Tue, 12 May 2026 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778574238; x=1779179038; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaYniimATF/0F8jcDqqwLPQxDQ785TQHxuq1daMGlqY=;
        b=VhOHwH+aaoa4W29tp4PucFXx0pWVNu13EnwpPqgev3rqB6KKKs7SCL22dRRQhCArap
         FCRoSkdMA/z1ZFS7CEvSc2LwTmybMbO8DqtL5OS5cfXabFMp8BbipNDjbM5jw4mPmBOI
         I3AYNdqHb9CqYMJaxJpDPjQhW2noOp+oR3NAvmk8poZBrAkYV0rnBubnuv9m/UCIxOFs
         p0KP/PGlmTNRZiF4fD50mHfGhOCX2sb1odjcW/aT4Bly8vhp/76jNVSborLi6EpLoJgb
         stRzCzi9XTqjMPwU8xQwkiyQKk5DMIAs4jjx+70n2d680F+gXJ/PihNVfvwgZqw8CdEG
         sGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778574238; x=1779179038;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gaYniimATF/0F8jcDqqwLPQxDQ785TQHxuq1daMGlqY=;
        b=F72rPtggR0xjM6Iu8JPYlyhagy1DI1JwewwqLdSPHwlZaTxvSMIRngsLAjxwHYhJz3
         N2my08+Nq3+harJ0FrEJxV/z97lD+l7mW8waBuj2DTeyxVurZJ8pZZ6oprHagShJPrVk
         UXxSnT/CZdAfflJ14kws0349AS3suK1xHtEZLIwnnyd6LOERo+Ua5MpkYoBj6vbKAhMz
         HX9VOgZWz/dXLTE6HZzzCyUYKS7s4Kz6J+4KY4WB2+YfE0vSikEe2r8GAJwzP1xwr6K9
         fhfWKUrYEdNTcoQTuKwoV/uPm+xgbpB031qKSEyPLABrqrwtIYiZDrPGmP2RT0GItUx5
         BCWg==
X-Gm-Message-State: AOJu0YzPWnoVGA+6UksBNocM6aEPxY532vm6+TZ0YkHDqXY4ay33KcY5
	4pn3Vbt65NCZuJx/azmxGBqdyNOkYXE0Y0RHihiwlzyrSjWsUrTALMhiRfaCTw==
X-Gm-Gg: Acq92OH+M88baW9ImWXpK30+DKvKn5SLPrUl3YtTMGOVE1Z9bGTLmaKlKruXO6S4YpT
	ZdGUH7TVfXOkT5qK0Bzsp/Ht+2Zwqe95w+ooLg7r76Q2c9TTeeRsmjnLLgOna5Bu5ukCrRjSdwy
	8V2fKO5qBpBWoEhxUW9lD+4Yoa6+sjVPZnQxkDQxG2U7h54t0PxUgZwTgVMxSekoBXCK80E+qbF
	6eOBqVfJ8YcO3++a4dddEoobHr1/iX/IVSVdNvwX4DNZr/QlQPlMF9n0+Z+xiKkGu4Kt62BmR6a
	9HmTR6mzJ/p/CHdkii3r9u7jx30z+N8j9xsKYhZaIQyAuTAyCjrViLGM4dHzD/+fn0m/Xva4Nzq
	1JRtPBkWRTMBipjKjI3TsiQx6M7YvCQaeukPCJYBF5P22UGXkrI6eKefqx8mTCT4230FnumbHOw
	6sSURDQWcV+2O0f2k6pNkvJAhc
X-Received: by 2002:a05:620a:25cd:b0:8d6:7dc4:6906 with SMTP id af79cd13be357-90cfeac0572mr256010985a.33.1778574238108;
        Tue, 12 May 2026 01:23:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90d8014fee5sm31608885a.44.2026.05.12.01.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:23:57 -0700 (PDT)
Message-Id: <2c3f7515693f14f5f782337fe58fd122e40a3b63.1778574229.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
References: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
	<pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 08:23:48 +0000
Subject: [PATCH v7 4/5] branch: add branch.<name>.pruneMerged opt-out
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.pruneMerged=false exempts that branch from
--prune-merged (and from fetch --prune-merged), even with --force.
Useful for keeping a topic branch around between rounds.

Explicit deletion via 'git branch -d' is unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 ++++++
 Documentation/git-branch.adoc    | 10 ++++----
 builtin/branch.c                 | 31 +++++++++++++++++++++----
 t/t3200-branch.sh                | 40 ++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..4662ef35c1 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.pruneMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --prune-merged`.
+	Useful for topic branches you intend to develop further after
+	an initial round has been merged upstream. Defaults to true.
+	Explicit deletion via `git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 1a5a5a9a54..87a26da0cc 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -216,16 +216,16 @@ Each _<remote>_ may be either the name of a configured remote
 	Delete the local branches that `--forked` would list for
 	the same _<remote>_ arguments, but only when the branch's
 	push destination remote-tracking branch (the branch `git push`
-	would update; see `branch_get_push` semantics) no longer
-	resolves locally. In other words: the branch was pushed
-	under some name on _<remote>_, and that name has since
-	been pruned upstream.
+	would update) no longer resolves locally. In other words:
+	the branch was pushed under some name on _<remote>_, and
+	that name has since been pruned upstream.
 +
 As a safety check, branches with commits not yet integrated into
 their upstream remote-tracking branch are refused; if the upstream
 itself is gone, the remote's default branch is consulted instead.
 With `--force` (or `-f`), delete refused branches regardless. The
-currently checked-out branch in any worktree is always preserved.
+currently checked-out branch in any worktree is always preserved,
+as is any branch with `branch.<name>.pruneMerged` set to `false`.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 2eb7433b28..c48af54301 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -864,13 +864,16 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
 		struct strbuf full = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
 		struct branch *branch;
 		const char *push_ref;
 		const char *upstream;
+		int opt_out = 0;
 
 		strbuf_addf(&full, "refs/heads/%s", short_name);
 		if (branch_checked_out(full.buf)) {
 			strbuf_release(&full);
+			strbuf_release(&key);
 			continue;
 		}
 		strbuf_release(&full);
@@ -880,18 +883,38 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 		if (upstream &&
 		    string_list_has_string(&protected_default_refs, upstream)) {
 			const char *leaf = strrchr(upstream, '/');
-			if (leaf && !strcmp(leaf + 1, short_name))
+			if (leaf && !strcmp(leaf + 1, short_name)) {
+				strbuf_release(&key);
 				continue;
+			}
 		}
 
 		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
-		if (!push_ref)
+		if (!push_ref) {
+			strbuf_release(&key);
 			continue;
+		}
 		if (refs_ref_exists(get_main_ref_store(the_repository),
-				    push_ref))
+				    push_ref)) {
+			strbuf_release(&key);
+			continue;
+		}
+		if (string_list_has_string(&protected_default_refs, push_ref)) {
+			strbuf_release(&key);
 			continue;
-		if (string_list_has_string(&protected_default_refs, push_ref))
+		}
+
+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr, _("Skipping '%s' "
+						  "(branch.%s.pruneMerged is false)\n"),
+					short_name, short_name);
+			strbuf_release(&key);
 			continue;
+		}
+		strbuf_release(&key);
 
 		strvec_push(&deletable, short_name);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f0d1250dbf..23b82615f5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1917,4 +1917,44 @@ test_expect_success '--prune-merged spares branches whose push ref is the defaul
 	git -C pm-pushdefault rev-parse --verify refs/heads/topic
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout branch one --track origin/one &&
+	git -C pm-optout branch two --track origin/two &&
+	git -C pm-optout config branch.one.pruneMerged false &&
+
+	git -C pm-optout update-ref -d refs/remotes/origin/one &&
+	git -C pm-optout update-ref -d refs/remotes/origin/two &&
+	git -C pm-optout branch --prune-merged origin 2>err &&
+
+	git -C pm-optout rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
+	test_grep "Skipping .one." err
+'
+
+test_expect_success '--prune-merged --force still honours pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout-force" &&
+	git clone pm-upstream pm-optout-force &&
+	git -C pm-optout-force checkout -b one --track origin/one &&
+	test_commit -C pm-optout-force unpushed &&
+	git -C pm-optout-force checkout - &&
+	git -C pm-optout-force config branch.one.pruneMerged false &&
+
+	git -C pm-optout-force update-ref -d refs/remotes/origin/one &&
+	git -C pm-optout-force branch --force --prune-merged origin &&
+
+	git -C pm-optout-force rev-parse --verify refs/heads/one
+'
+
+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one --track origin/one &&
+	git -C pm-optout-d config branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

