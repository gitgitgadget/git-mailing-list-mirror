Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD49385D76
	for <git@vger.kernel.org>; Tue, 12 May 2026 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605671; cv=none; b=T3Fx7h0esS1Rf+gBruw4DIaomn9UZlMxS6dpicI7rzttgZwJZgBWaWAMsH/GkvgHO7x1RJ5gfmRTrRwKwqGC5z9ZpeeyBgGxmiOoddvTN+mWJQ9pD5EVdeDG6rhQAOsh12IBVscnC682TPpJdjZ0lwTtX5B+6YsnZMjOjaOPzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605671; c=relaxed/simple;
	bh=jHL/M6hMNQLt8iJt6w3P37BCK117gAQeNqguxDK20Go=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n253DE1RqysjaqBfJoHxVLzw+1DYPy6IDrWWVAvnCuaMQYKx8ERUlZ0iExr3T8J4BGI0zgspSDyQuYgWC4VDH2krgykZUByf6i8V7WTm3s+Qgb/YoWNQw0TLUt1m4OxCwPeIwG1gQl3W7wZeYR3lmF77ybmiDo0g4rTNC6blSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHfng8gT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHfng8gT"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bccb978bd9so13854525ad.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605669; x=1779210469; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl5J2Z16YugsHnU1TdGHMyQkKP12WLszLlGXfWosPOs=;
        b=LHfng8gThBPIVYIRI6pP4P3cBEInhPU/AOm3yFRZYIMjnXuhU3kBOYmMDltEsUr4a9
         /MhBOiOxIkQ5UU8yvv6VmCbf5OEVZTCRuv9zOzhbzXbS0HeNmIrX173p3hcfcGZh3DHe
         QUhbXTOWYvhIgMvWGudGTx+WDwu2cw8r+vyjhHkpDvzminNYxeScODdU+bDqQ0+ummXS
         dpy3xOgzTVrJbmaZ4uczq5M2biLQN/kxOyPrULsPHNzV9YcBjmAQ32Ap6oijcg9und48
         mzAbeWlIDskoVclibuDuELJgGDEAIct/j1xsHW7OPWFXOdooneNmWAQnsOZeMm8upz+Y
         i2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605669; x=1779210469;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jl5J2Z16YugsHnU1TdGHMyQkKP12WLszLlGXfWosPOs=;
        b=ru37kA/NfFm7neHbbujB9Ujs4gqmM65l4Sy0piocpWR/aqLk/Ly5NydMK2IgIQMfhU
         ueq7GoUcnVjFZYnFNQpe7LXPcsohjq2KyKMBjVjQT70bSdGNzhImR7/PtWqZPIQD//JS
         MvWuwg/IYB01sDC9Ki2DBvniDz9mBLACVnwFRm+amhWpz2HwAz2fTJkc0Dg9lsY0077x
         TyBQguS1tqKai/XCfeyEEv/loSUJg1QCXnJa78yhyAuMACwcb5gKMlahnD3vzASuB6RL
         K0w1eE8ulism14h6OkqQE6Hjc/QfTx0VPgLo9akT/a5dk2vNxMrmnOZSVpawfp8GWVfU
         PwLA==
X-Gm-Message-State: AOJu0YxXDZwklDWv6/Mj2qzbxBzBvmFqKNisTji6yPcVATcud12P9Se+
	tI+OGJrUQMf/qWZM/Ny8uz91Fs5TI1+1KEG0+cmUoPb3IdNGg28SIh5k0H5Hmnfg
X-Gm-Gg: Acq92OEYF9l8cC34suyFpi6CMkZ+6OT62uZN/fmyciIx5hZRHjIiJ3cV7+OEznx1OLK
	UwWrsoA5jllx9/BEjmFNB1cpCn6yvBzVCdTj1xe9W0B6pBNvaGDEfC7JG49v2SDqj0GU48MiZnG
	Hao9pYnfwWP4jIfD+uxk1HcZJBXb6TEnp+e389g5bR1P6Mj8Y2n4Epualuc2sBHAZw+6IbMCgg4
	kZzR1IreQq4rOdBX602HQnTxf8dFtg8euEbU6IcV25rz+/EexqecP9ia3EP60X4TWNxuIsRKjGH
	s/Fn5aw3U3LdP86fqOK/2Wqc2KLN+yaAM6nwBxMefrnzbv3O+iBwTvKQsrdTfi3HEsXB1QzovaJ
	rNOtPPqFhVG17pvQVFA2F8wEvinw+WPPt63iGEd9O3f+2dWILg4EugCoNlxhKWSm85WQI+5mjQ4
	rg03WYp9pbQkBfvdKg7RICCpcAnXE=
X-Received: by 2002:a17:902:d642:b0:2bd:417:8b6 with SMTP id d9443c01a7336-2bd04170df5mr21203325ad.23.1778605668840;
        Tue, 12 May 2026 10:07:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.246.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d271d1sm142644385ad.11.2026.05.12.10.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:07:48 -0700 (PDT)
Message-Id: <dd333093442dc2b9ffafc761d6ca23f94fe9ec1f.1778605658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
References: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
	<pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 17:07:37 +0000
Subject: [PATCH v8 4/5] branch: add branch.<name>.pruneMerged opt-out
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
--prune-merged, even with --force. Useful for keeping a topic
branch around between rounds.

Explicit deletion via 'git branch -d' is unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 ++++++
 Documentation/git-branch.adoc    |  3 ++-
 builtin/branch.c                 | 23 ++++++++++++++++--
 t/t3200-branch.sh                | 41 ++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 3 deletions(-)

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
index c3f5150f03..080cdc218a 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -229,7 +229,8 @@ A branch whose upstream no longer resolves locally is left alone
 integrated). With `--force` (or `-f`), the reachability check is
 skipped and every branch in the candidate set is deleted. The
 currently checked-out branch in any worktree is always preserved,
-as is the local branch that mirrors _<remote>_'s default branch.
+as is any branch with `branch.<name>.pruneMerged` set to `false`,
+and the local branch that mirrors _<remote>_'s default branch.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 50bf9774a8..2969780210 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -836,12 +836,15 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
 		struct strbuf full = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
 		struct branch *branch;
 		const char *upstream;
+		int opt_out = 0;
 
 		strbuf_addf(&full, "refs/heads/%s", short_name);
 		if (branch_checked_out(full.buf)) {
 			strbuf_release(&full);
+			strbuf_release(&key);
 			continue;
 		}
 		strbuf_release(&full);
@@ -850,13 +853,29 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
 		if (!upstream ||
 		    !refs_ref_exists(get_main_ref_store(the_repository),
-				     upstream))
+				     upstream)) {
+			strbuf_release(&key);
 			continue;
+		}
 		if (string_list_has_string(&protected_default_refs, upstream)) {
 			const char *leaf = strrchr(upstream, '/');
-			if (leaf && !strcmp(leaf + 1, short_name))
+			if (leaf && !strcmp(leaf + 1, short_name)) {
+				strbuf_release(&key);
 				continue;
+			}
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
+			continue;
 		}
+		strbuf_release(&key);
 
 		strvec_push(&deletable, short_name);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ca071338d3..8e877862f5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1867,4 +1867,45 @@ test_expect_success '--prune-merged protects only the default branch by name, no
 	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout branch one one-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next one &&
+	git -C pm-optout branch two two-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next two &&
+	git -C pm-optout config branch.one.pruneMerged false &&
+
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
+	git -C pm-optout-force checkout -b wip origin/wip &&
+	git -C pm-optout-force branch --set-upstream-to=origin/next wip &&
+	test_commit -C pm-optout-force local-only &&
+	git -C pm-optout-force checkout - &&
+	git -C pm-optout-force config branch.wip.pruneMerged false &&
+
+	git -C pm-optout-force branch --force --prune-merged origin &&
+
+	git -C pm-optout-force rev-parse --verify refs/heads/wip
+'
+
+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one one-commit &&
+	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
+	git -C pm-optout-d config branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

