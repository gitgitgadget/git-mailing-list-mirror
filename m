Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEA2EACF9
	for <git@vger.kernel.org>; Thu, 21 May 2026 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372373; cv=none; b=FNGdltDp3DEc/PrP5LMSmS0eU7yZZNehyoEr7/CbJErH0QabIXCpPY1uvOjy2LeHAqel3OfYfJrdjh/i/NpMOdy5yWalOcwAzmbA8vp609Qo0zoP8I4ibnfftNcjWqkKx8X8+embOcq5jRJwCtN8Bu0jz250Sn1rXuyF+TLIQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372373; c=relaxed/simple;
	bh=EM2uFLh49VK8PtwvuopJ8J8WICPOWBVbp9PSv/YPbBw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NzPWTJDxf40EcLGKCGfDHxrhLoDmG39eKLVQM1tKs3SYeIzQHwOeEIg2NDBf0LV2ScuBNkmuHKwFyGQ9yIFf7Mq5eBhcPk4ZMFaIlfuOFPYZfcE7Tdgy4zd7v+/w+NkRe5yqjPECq8fbi7D91wm5rT0qjoUML2ajbuDhKcWS0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdBrCJTL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdBrCJTL"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so2406073a12.2
        for <git@vger.kernel.org>; Thu, 21 May 2026 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779372370; x=1779977170; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9ITk/NKfMxb2C5LJFDgID1Hn2mM/AA3uMrDPvHYREg=;
        b=XdBrCJTL6gHv/fC4lP/6DDWTjJeVZwLrgJeXOtVxhLhePMg72TQ4YwzjDR/mzJsM0D
         UrIe/ZnIgtWfhc0mlCe2ChaQkdV2aGYpgsQbXzv2LXkPuuKGXmFu1+5g33NjfpXzrH/T
         AlCCw+6UqFp8R+VGHc/Y8GQ5itFPPitfBHWM8FZVeQuk+Mt0+dAsM3nqQqJ2mJBQBZUO
         4M9sZQB03RfxaMNh5tdTkIOnewoe8M9rcjFz3MLCxxamxvBmEneL5hZfZJqHwJba7Wws
         59qDMaHdYNzusqYry1/uSQqypAxr9FPupMb1XKjIeQWtOymzqktB8fVwwu4mlU/a7Vxr
         N3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372370; x=1779977170;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9ITk/NKfMxb2C5LJFDgID1Hn2mM/AA3uMrDPvHYREg=;
        b=JokfAO+p1UY/bXMTT4CZcr9+vVrn8WSIEDD8G/Vf945tCrljsm8LypwZhk6PAeAVcw
         bWsm1iv+2heajfRbojC2IidXVSattSsDIAU0z8ZXQzPV6xGkkSKLk0AGODcVA2SZTVxt
         aYRBml/uNqiByoy+jqpVK4gaMlJVdyBHBdDcqbTmP+mnqU1J1No1lz6R3srzl4FspaTA
         XAs3tRX4NzdDd3hb+jEFxT8yGk2obU+0glGAPeWPQ7SqW9MZYGVlm7svY4IGuIUEwcug
         xdkusoFC/3q/4pnnwDrFkOCc1lo0isqsB/iATg4Y/Fejo26WnfyLYa+jb0PlC8lfWDBh
         TxeQ==
X-Gm-Message-State: AOJu0YxiOIrHQQ3x9GtFUTaslnnSRRPPd4aCVeK/Q22Vh5/cigL98nJ3
	U2nE2r/NmoFmgOMcyq6iPNUhjvc9EOOeTO22SeugtTGx/dgbOgNR1ezB5AbOF0Ea
X-Gm-Gg: Acq92OF0wwW1WR2CSCXljbfrrJzrVWv+JS7kO2TL0QAIuVawav3aAjP79E7so2oImTF
	tLMrsQrZ39Tu1Hg3SHmQ0wM1jLndxRDh0n806kUlcsDDmirdO5QM2OtX0RuAo1b6fXgj6gyflXD
	gA46U1AHA/9FRO/YnR6zS8KVuGldj9v6bNefNDNHvU+QqrAdHPiL3jcsVGkNOrpIAZhfjOsLO9I
	hqhH8YxHqF02EuPTMLjFqh+Tmq7TAFgY+uCjoEJtk1pf3gfAQax0aSt4mRVVVqhF6VHHCV72aJb
	x78CLSUxMzZ5bm+o5cWc5CRK5NpmL9E5cN8OEqhVLroIx8skWVSeC+li9MR56/eRKYflZSU5SrQ
	xljY+5+fhlD4PkQUjird3txW8TjD+lreqQR4QMdPf3hB5dDE7E8UeUb75oMbH4/CU0nxEpYPtZv
	ItmYlBZYDzVg8cah0cTlQ+2O1v0As=
X-Received: by 2002:a17:907:c19:b0:bda:3458:48df with SMTP id a640c23a62f3a-bdc13570802mr168327366b.20.1779372369527;
        Thu, 21 May 2026 07:06:09 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.200.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a410c93sm51945966b.31.2026.05.21.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:06:08 -0700 (PDT)
Message-Id: <pull.2301.v4.git.git.1779372367317.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.v3.git.git.1779282625696.gitgitgadget@gmail.com>
References: <pull.2301.v3.git.git.1779282625696.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 14:06:07 +0000
Subject: [PATCH v4] remote: qualify "git pull" advice for non-upstream
 compareBranches
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
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Enable ENABLE_ADVICE_PULL for push-branch comparisons too, not just
the upstream entry, so the "use git pull" hint prints when the local
branch is behind its push branch.

Spell out "git pull <remote> <branch>" so running the suggested
command actually pulls the ref the user was told about; plain
"git pull" would fetch the upstream instead.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    remote: qualify "git pull" advice for non-upstream branches
    
     * Don't suggest git pull when we have no good command to suggest.
     * New test for this. Asserts the behind line shows with no follow-up
       advice.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2301%2FHaraldNordgren%2Fstatus-pull-advice-qualified-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2301/HaraldNordgren/status-pull-advice-qualified-v4
Pull-Request: https://github.com/git/git/pull/2301

Range-diff vs v3:

 1:  3703be9aac ! 1:  ef54dacb07 remote: qualify "git pull" advice for non-upstream compareBranches
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       		full_ref = resolve_compare_branch(branch,
       						  branches.items[i].string);
      @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     - 		if (reported)
     - 			strbuf_addstr(sb, "\n");
       
     --		if (is_upstream)
     -+		if (is_upstream || is_push)
     + 		if (is_upstream)
       			flags |= ENABLE_ADVICE_PULL;
      -		if (is_push)
      -			flags |= ENABLE_ADVICE_PUSH;
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +				if (push_remote_name &&
      +				    skip_prefix(full_ref, "refs/remotes/", &push_branch_name) &&
      +				    skip_prefix(push_branch_name, push_remote_name, &push_branch_name) &&
     -+				    *push_branch_name == '/')
     ++				    *push_branch_name == '/') {
      +					push_branch_name++;
     -+				else
     ++					flags |= ENABLE_ADVICE_PULL;
     ++				} else {
      +					push_remote_name = NULL;
     ++				}
     ++			} else {
     ++				flags |= ENABLE_ADVICE_PULL;
      +			}
      +		}
       		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
     @@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches with remap
      +	EOF
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'status.compareBranches suppresses advice when push tracking ref is unconventional' '
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.imported.url ../. &&
     ++	test_config -C test remote.imported.fetch "+refs/heads/*:refs/imported/imported/*" &&
     ++	test_config -C test branch.feature17.pushRemote imported &&
     ++	test_config -C test status.compareBranches "@{push}" &&
     ++	git -C test fetch imported &&
     ++	git -C test checkout --no-track -b feature17 refs/imported/imported/main &&
     ++	(cd test && advance work17) &&
     ++	git -C test push imported HEAD:feature17 &&
     ++	git -C test fetch imported &&
     ++	git -C test reset --hard HEAD^ &&
     ++	git -C test status >actual &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature17
     ++	Your branch is behind ${SQ}imported/imported/feature17${SQ} by 1 commit, and can be fast-forwarded.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
      +
       test_done


 remote.c                 |  48 +++++++++++++++----
 t/t6040-tracking-info.sh | 100 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 24a8118d25..193e1dd1f1 100644
--- a/remote.c
+++ b/remote.c
@@ -2268,6 +2268,8 @@ static void format_branch_comparison(struct strbuf *sb,
 				     bool up_to_date,
 				     int ours, int theirs,
 				     const char *branch_name,
+				     const char *push_remote_name,
+				     const char *push_branch_name,
 				     enum ahead_behind_flags abf,
 				     unsigned flags)
 {
@@ -2303,9 +2305,15 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (use_pull_advice && advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git pull\" to update your local branch)\n"));
+		if (use_pull_advice && advice_enabled(ADVICE_STATUS_HINTS)) {
+			if (push_remote_name && push_branch_name)
+				strbuf_addf(sb,
+					_("  (use \"git pull %s %s\" to update your local branch)\n"),
+					push_remote_name, push_branch_name);
+			else
+				strbuf_addstr(sb,
+					_("  (use \"git pull\" to update your local branch)\n"));
+		}
 	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
@@ -2316,9 +2324,15 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
+		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS)) {
+			if (push_remote_name && push_branch_name)
+				strbuf_addf(sb,
+					_("  (use \"git pull %s %s\" if you want to integrate the remote branch with yours)\n"),
+					push_remote_name, push_branch_name);
+			else
+				strbuf_addstr(sb,
+					_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
+		}
 	}
 }
 
@@ -2356,6 +2370,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		int ours, theirs, cmp;
 		int is_upstream, is_push;
 		unsigned flags = 0;
+		const char *push_remote_name = NULL;
+		const char *push_branch_name = NULL;
 
 		full_ref = resolve_compare_branch(branch,
 						  branches.items[i].string);
@@ -2399,11 +2415,27 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 		if (is_upstream)
 			flags |= ENABLE_ADVICE_PULL;
-		if (is_push)
-			flags |= ENABLE_ADVICE_PUSH;
 		if (show_divergence_advice && is_upstream)
 			flags |= ENABLE_ADVICE_DIVERGENCE;
+		if (is_push) {
+			flags |= ENABLE_ADVICE_PUSH;
+			if (!upstream_ref || strcmp(upstream_ref, full_ref)) {
+				push_remote_name = pushremote_for_branch(branch, NULL);
+				if (push_remote_name &&
+				    skip_prefix(full_ref, "refs/remotes/", &push_branch_name) &&
+				    skip_prefix(push_branch_name, push_remote_name, &push_branch_name) &&
+				    *push_branch_name == '/') {
+					push_branch_name++;
+					flags |= ENABLE_ADVICE_PULL;
+				} else {
+					push_remote_name = NULL;
+				}
+			} else {
+				flags |= ENABLE_ADVICE_PULL;
+			}
+		}
 		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
+					 push_remote_name, push_branch_name,
 					 abf, flags);
 		reported = 1;
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0242b5bf7a..91cbb8775d 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -646,4 +646,104 @@ test_expect_success 'status.compareBranches with remapped push and upstream remo
 	test_cmp expect actual
 '
 
+test_expect_success 'status.compareBranches behind both upstream and push' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature13 upstream/main &&
+	(cd test && advance work13) &&
+	git -C test push origin &&
+	git -C test branch --set-upstream-to upstream/ahead &&
+	git -C test reset --hard HEAD^ &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature13
+	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull" to update your local branch)
+
+	Your branch is behind ${SQ}origin/feature13${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull origin feature13" to update your local branch)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with remapped push and behind push branch' '
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test remote.origin.push refs/heads/feature14:refs/heads/remapped14 &&
+	test_config -C test status.compareBranches "@{push}" &&
+	git -C test checkout -b feature14 upstream/main &&
+	(cd test && advance work14) &&
+	git -C test push &&
+	git -C test reset --hard HEAD^ &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature14
+	Your branch is behind ${SQ}origin/remapped14${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull origin remapped14" to update your local branch)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with behind push branch and no upstream' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{push}" &&
+	git -C test checkout --no-track -b feature15 upstream/main &&
+	(cd test && advance work15) &&
+	git -C test push origin &&
+	git -C test reset --hard HEAD^ &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature15
+	Your branch is behind ${SQ}origin/feature15${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull origin feature15" to update your local branch)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches behind upstream-equals-push suggests plain pull' '
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature16 origin/main &&
+	(cd test && advance work16) &&
+	git -C test push origin HEAD:main &&
+	git -C test reset --hard HEAD^ &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature16
+	Your branch is behind ${SQ}origin/main${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull" to update your local branch)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches suppresses advice when push tracking ref is unconventional' '
+	test_config -C test push.default current &&
+	test_config -C test remote.imported.url ../. &&
+	test_config -C test remote.imported.fetch "+refs/heads/*:refs/imported/imported/*" &&
+	test_config -C test branch.feature17.pushRemote imported &&
+	test_config -C test status.compareBranches "@{push}" &&
+	git -C test fetch imported &&
+	git -C test checkout --no-track -b feature17 refs/imported/imported/main &&
+	(cd test && advance work17) &&
+	git -C test push imported HEAD:feature17 &&
+	git -C test fetch imported &&
+	git -C test reset --hard HEAD^ &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature17
+	Your branch is behind ${SQ}imported/imported/feature17${SQ} by 1 commit, and can be fast-forwarded.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_done

base-commit: aec3f587505a472db67e9462d0702e7d463a449d
-- 
gitgitgadget
