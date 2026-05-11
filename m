Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374728134C
	for <git@vger.kernel.org>; Mon, 11 May 2026 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482721; cv=none; b=STqkI2zJNc9EUZ+La++QmFkq5U2Y9NTrxu4UKZjg3TkADVzadvfihyq5e/WhSI5uyU6T+eWnd3iz4qN8ZXz1cGvg4gg3cCq4jSusk1hEtt5mrXsb44yBXmFCdlEhMAFEEdIY2I2e3SOgwfoch+tUYvpyKHD7i+ZnpiuTYeqXb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482721; c=relaxed/simple;
	bh=4nL11wUCGD0XxdYIXsltSR98ai/sVtG34dlAbArC0c8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DM5EX3wFBN1e9BawK4F08YTN63uJbvIJvUMmioJgNqGfnS4CiLt0j7Abqlu32w/Q8LwuidxZN0ATDEyLLTCxaimCA8syw6h1W7oQ92C08ZM1arCe0pLtEOP+FchU/0yJimkx8c6Or9AGqIgT1Zqtzvrp/ZoCFjO2PKPj4dos5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ62oSth; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ62oSth"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ec37d52c0dso583473485a.0
        for <git@vger.kernel.org>; Sun, 10 May 2026 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778482718; x=1779087518; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SHFEhIt6li2egPi7Yxks/BuMkvdIsBWq3auuZH82S4=;
        b=dZ62oSthJaenpzqLU2v/ySkovlEplUI+FG2cRf84CZwePKaHqI5kaUK9fGUA1MGSan
         bg+yq4eSGKOs451TyRsBwoVF+O2tc244OPxmAhD1vcWkIhsY8F0P8b4xl4piXNLFAqgm
         z4sVoFraOmuDvEhFU3K6TZPY35esgCJV8HcraaW99PpfYRayajykU6k4vaLATV6b1q8U
         tphn4B1uUyPQBMQNMNwe96nYoZPyLyNKtW4TmbnowAbLWyYW2Lqq6vCH2vLVgK6vbWDY
         /qU2hpj3YfBMWD/kHZnw+L5b03ZDdogeSLiUxbWjZeSL59rgNa32C2caldKxduAUAkiL
         r/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482718; x=1779087518;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SHFEhIt6li2egPi7Yxks/BuMkvdIsBWq3auuZH82S4=;
        b=Dul0grRqaNMh62E/r7kwDHHJr/FIy9vfT9QOoqer7v5IkOKpehrxT9DIISePu7Is8Q
         nooncVnlPx8n/BdfEKgjaK1a4xjs/rbfS9MDlrh/1/Qu4x1NOBKJuFcotFCxjEWnXLy+
         6bO811molohrFfCFqjqOjcC6BuLvPLdHN4VuxkfDrFzt1H+ZsauOa7iFnDFcqIG6f6/n
         E7KCgpkeXmujDbEhBtNHD4yVJZTmLb6YR1U3It2o9UwlsgqLZLM8CcT0IO5/NvOPqIPw
         kK1BWg361DwPAriVO1QJ0KCg9JqJPO36DiD/p0yv62OZkwXzHavKxG5VSPB7aTv6eR/w
         tqHw==
X-Gm-Message-State: AOJu0YwBWnD6259jI8KB4FF4qKe4iWKnDwFBkQxjzT/g/sS41XXeTqHz
	9wOyAWqdDUPomnUIM/SUUlH8yaQ0tg+fqb3fxfW/fwVRpBhoEWcfENBuKFN1Rf8x
X-Gm-Gg: Acq92OGYQOsVyZXehUjkIHPCUbUIE6jadY49WLPbEyoTMTPxbfXqFYwbfaAOj1SeFKj
	plB+IxCIircMLJqOKe+1UTjSqwLx/roZvM3/HiE4OJGHyG+ROLKCR98t+XDPw+sUxE8h9ollLSd
	yx0fwEPcKFzqFvNS3rboGYbP0ZAl5YdQR1c2SryM3eAxrGdpA8jk+xH5AuENWDOu0dne3N1s8Qa
	JKL5Tukl+m6WsWAPK0f3AnvE+8HqDKI/RxC/Sg2sDqdUKLGAYrR2JrC45Rj84SrfNNDpTGzVQLs
	snczk7qGcV6/tdM57xOcqfFiCDVUXuczs/sdEg4EgF+qnuLo3jScUOkLP3T4A6nYWdu1dEP62vr
	Fe3bjRP3OhRJdNBbRheNJ5acoPWqcQvRZ8hyPxEXPN3yIcRiHTJun+O6sSclmGris5/WY6RS7Bi
	iz45/OLqaZxS7yVoEG1pe1IiZqs0WEXIDKtjoaSg==
X-Received: by 2002:a05:620a:2901:b0:8ed:bafb:26b0 with SMTP id af79cd13be357-904d63e78d1mr3285706885a.37.1778482718108;
        Sun, 10 May 2026 23:58:38 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.236.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9c524bbsm961255585a.1.2026.05.10.23.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:58:36 -0700 (PDT)
Message-Id: <cf69fb5767645f7e0b0ad83d97468d5e55d834f0.1778482708.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
References: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
	<pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 06:58:27 +0000
Subject: [PATCH v5 4/5] branch: add branch.<name>.pruneMerged opt-out
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
 Documentation/git-branch.adoc    | 17 +++++++-------
 builtin/branch.c                 | 31 +++++++++++++++++++++----
 t/t3200-branch.sh                | 40 ++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 13 deletions(-)

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
index 80b20a55eb..9d4944d17e 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -216,16 +216,15 @@ Each _<remote>_ may be either the name of a configured remote
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
-By default, the local tip must also be reachable from the
-upstream remote-tracking branch (see `--no-merged`); branches with
-unpushed commits are refused. With `--force` (or `-f`), delete
-them regardless. The currently checked-out branch in any worktree
-is always preserved.
+The local tip must also be reachable from the upstream
+remote-tracking branch; branches with unpushed commits are refused.
+With `--force` (or `-f`), delete them regardless. The currently
+checked-out branch in any worktree is always preserved, as is
+any branch with `branch.<name>.pruneMerged` set to `false`.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index f2ca7b64d3..07d867373f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -834,13 +834,16 @@ static int prune_merged_branches(int argc, const char **argv, int force,
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
@@ -850,18 +853,38 @@ static int prune_merged_branches(int argc, const char **argv, int force,
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
index b41f8343b3..f9aca90f4d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1884,4 +1884,44 @@ test_expect_success '--prune-merged spares branches whose push ref is the defaul
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

