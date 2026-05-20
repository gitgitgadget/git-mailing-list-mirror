Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C32C0260
	for <git@vger.kernel.org>; Wed, 20 May 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282632; cv=none; b=ZD9HKEZ0lN9zkv73hFjW3hhqn6nU2NbX7iq1bNmV4M0RxkhRxevwsqZI/8C1F9F27rqpDLoeTxak+Bx14y9gyj33ZGbA6OXegxrZDOWw3WYfgnZxrujLtu6HUbaDSlYpigbXmzW4iA6yHPWYKDVDCjvnuEfTJbSiAOK3ZVy+PJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282632; c=relaxed/simple;
	bh=LX+QSRr5mNDF43LrTudIAlp+mgofQ/bhK2TQzpV29+4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YlIREClIKcSZ8BeHqgqTGM4OVsbxV3s1IsnxF8D9X7M6l1nvpgwf7CcoweN9YhZAkexNrHaosb1HMSjR2rOdD8Wo6SiH5QxOPFxTXjlVyh96EApUdlE0Z4LfA3Gy/7XxyRWxdOty6kYZtAC4+8XdQ3UzseyPNFpZEgacxbeilKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIYBY6pt; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIYBY6pt"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9568159ee07so3294443241.1
        for <git@vger.kernel.org>; Wed, 20 May 2026 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779282627; x=1779887427; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBSAwtsViCTZd0sTzG8Pg11PAqo687zhPrFuyL14zVo=;
        b=dIYBY6ptkZVu8cZiGmGjjVmDHdaZTF1SDef04Nc0EgcLwWjQoy4LWTRF8e+WZRww1E
         CqVzukfWxI5cezarcPnuZkXc2jhSzpglvKeeijxo9DsX7mtf7DmSlfFJUBrMjmB2dYNV
         KGw9ISuVZVYVPdmyArggduaFOnkMI3M1R6/jnTkMmpLtnG0vwVtgkEHyenNxqrLyfuKa
         IO10Xow80fCbGJDf8ShtwEb7s1lfjDyRG7D/Bp9Tm3TgRZvfpBOoInvIHMnad5NKAs4r
         VES78uF7CgoYXwaMhkqZLCdWx8hxgOhvvSHzfO4uW0/trB+fkXGA0wPBrOL+/s+vw5J4
         p+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779282627; x=1779887427;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBSAwtsViCTZd0sTzG8Pg11PAqo687zhPrFuyL14zVo=;
        b=UDSUD9IVs0hq6uXDK5ADFH25SmYQZJBkME3DeBg9zVk8GfLD8vGhm6q5TzIH0DIY7W
         /6N7x/Roa9yS2jyh+30hHPqPKFFIWbUcUwHAO95+O+6wtxu9b9fa5P10TrSmJW5USGCT
         H4pyiHRjVckD916obddEZdDrsmUs5jtRZl284Awa2vqocGomNqiZ+dtRXf8PDubiWjkX
         KmfuQfs2Cfltlz6LysGM8LgkUwSkKQg+lLay8mE7NySNSxzHgK5gSlt2M4bmBoWkPdp4
         SzLC8sJBDobc7nPzxtURHMgDrP6DeruK2uoqKG0d3UGDYHhWs4CI7l6FqUh+QrBqVVN3
         NamA==
X-Gm-Message-State: AOJu0Yy9Ns6572HX9Gyw/jT7uD8lyb2PsQ2dsZ5hCBCVZ9Bd/7S+t9IR
	i0aM1yWiMa5vOYBFkfH9UFT1sqEs0B2dkK50eiLe4P2gZjS6bds2ZUP+nD1S5w==
X-Gm-Gg: Acq92OEeRKR5SoBUqMkEzs4moohoCOwxPUAO5nAKvGcE4qjuyi/2lZJ85XTOOiWeR4v
	DWk64UwGdBMpBqulgYklCNVWHVbkmIDmeEmlCAkgbDJ81DNFtA0WUtPikx0BNa1l5SJdl/M9wfm
	nXDNG/7InqPoiwsRsdpzgOEhRYQUBeSmQW+QzxKVKFXE2JoNr6NTonHMarF8cQyvA74VlGikIfQ
	y9DRiUejwYdnbxaEHJy5u5p1I2p4w9E0QsGdYY3ZeS8xb7c0u8r9bCdprC2qwGyTcrbJh1vdueb
	42mM283H+J1nOTdH66xuCBSssu92xH2tHwxJoRdNgkVJjwFRfEmkP66RXNXFz2NcKwAovgLspmo
	lIMRUwe9jirOGw0F2t8oyyxj600HQuvkNcqrfL4cjUxJT4xuWgrSaLMnYJXnug+XKPkFJzfbZQQ
	pOzsdKeX8aft6GE5u9gbXTYIHcO+G6
X-Received: by 2002:a05:6102:358e:b0:605:5d09:8631 with SMTP id ada2fe7eead31-63a3fc98de6mr12563696137.29.1779282627190;
        Wed, 20 May 2026 06:10:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.190.121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086a61sm122508046d6.4.2026.05.20.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:10:26 -0700 (PDT)
Message-Id: <pull.2301.v3.git.git.1779282625696.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.v2.git.git.1778665812261.gitgitgadget@gmail.com>
References: <pull.2301.v2.git.git.1778665812261.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 20 May 2026 13:10:25 +0000
Subject: [PATCH v3] remote: qualify "git pull" advice for non-upstream
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
    
     * Only suggest git pull <remote> <branch> when plain git pull wouldn't
       do the right thing.
     * Tests: when upstream and push are the same ref, the message stays
       plain git pull.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2301%2FHaraldNordgren%2Fstatus-pull-advice-qualified-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2301/HaraldNordgren/status-pull-advice-qualified-v3
Pull-Request: https://github.com/git/git/pull/2301

Range-diff vs v2:

 1:  1f06873f82 ! 1:  3703be9aac remote: qualify "git pull" advice for non-upstream branches
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    remote: qualify "git pull" advice for non-upstream branches
     +    remote: qualify "git pull" advice for non-upstream compareBranches
      
     -    When "git status" reports the local branch is behind the push
     -    branch, the advice suggested a bare "git pull". That follows the
     -    upstream, which may live on a different remote, so emit
     -    "git pull <remote> <branch>" instead.
     +    Enable ENABLE_ADVICE_PULL for push-branch comparisons too, not just
     +    the upstream entry, so the "use git pull" hint prints when the local
     +    branch is behind its push branch.
      
     -    Also enable the pull advice for push-branch comparisons; it was
     -    previously only set for the upstream.
     +    Spell out "git pull <remote> <branch>" so running the suggested
     +    command actually pulls the ref the user was told about; plain
     +    "git pull" would fetch the upstream instead.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       			flags |= ENABLE_ADVICE_DIVERGENCE;
      +		if (is_push) {
      +			flags |= ENABLE_ADVICE_PUSH;
     -+			push_remote_name = pushremote_for_branch(branch, NULL);
     -+			if (push_remote_name &&
     -+			    skip_prefix(full_ref, "refs/remotes/", &push_branch_name) &&
     -+			    skip_prefix(push_branch_name, push_remote_name, &push_branch_name) &&
     -+			    *push_branch_name == '/')
     -+				push_branch_name++;
     -+			else
     -+				push_remote_name = NULL;
     ++			if (!upstream_ref || strcmp(upstream_ref, full_ref)) {
     ++				push_remote_name = pushremote_for_branch(branch, NULL);
     ++				if (push_remote_name &&
     ++				    skip_prefix(full_ref, "refs/remotes/", &push_branch_name) &&
     ++				    skip_prefix(push_branch_name, push_remote_name, &push_branch_name) &&
     ++				    *push_branch_name == '/')
     ++					push_branch_name++;
     ++				else
     ++					push_remote_name = NULL;
     ++			}
      +		}
       		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
      +					 push_remote_name, push_branch_name,
     @@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches with remap
       	test_cmp expect actual
       '
       
     -+test_expect_success 'status.compareBranches with behind push branch suggests qualified pull' '
     ++test_expect_success 'status.compareBranches behind both upstream and push' '
      +	test_config -C test push.default current &&
      +	test_config -C test remote.pushDefault origin &&
      +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
      +	git -C test checkout -b feature13 upstream/main &&
      +	(cd test && advance work13) &&
      +	git -C test push origin &&
     ++	git -C test branch --set-upstream-to upstream/ahead &&
      +	git -C test reset --hard HEAD^ &&
      +	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature13
     -+	Your branch is up to date with ${SQ}upstream/main${SQ}.
     ++	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
     ++	  (use "git pull" to update your local branch)
      +
      +	Your branch is behind ${SQ}origin/feature13${SQ} by 1 commit, and can be fast-forwarded.
      +	  (use "git pull origin feature13" to update your local branch)
     @@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches with remap
      +	EOF
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'status.compareBranches with behind push branch and no upstream' '
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test status.compareBranches "@{push}" &&
     ++	git -C test checkout --no-track -b feature15 upstream/main &&
     ++	(cd test && advance work15) &&
     ++	git -C test push origin &&
     ++	git -C test reset --hard HEAD^ &&
     ++	git -C test status >actual &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature15
     ++	Your branch is behind ${SQ}origin/feature15${SQ} by 1 commit, and can be fast-forwarded.
     ++	  (use "git pull origin feature15" to update your local branch)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status.compareBranches behind upstream-equals-push suggests plain pull' '
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout -b feature16 origin/main &&
     ++	(cd test && advance work16) &&
     ++	git -C test push origin HEAD:main &&
     ++	git -C test reset --hard HEAD^ &&
     ++	git -C test status >actual &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature16
     ++	Your branch is behind ${SQ}origin/main${SQ} by 1 commit, and can be fast-forwarded.
     ++	  (use "git pull" to update your local branch)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
      +
       test_done


 remote.c                 | 46 +++++++++++++++++++-----
 t/t6040-tracking-info.sh | 78 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 9 deletions(-)

diff --git a/remote.c b/remote.c
index a664cd166a..2b82f6b312 100644
--- a/remote.c
+++ b/remote.c
@@ -2267,6 +2267,8 @@ static void format_branch_comparison(struct strbuf *sb,
 				     bool up_to_date,
 				     int ours, int theirs,
 				     const char *branch_name,
+				     const char *push_remote_name,
+				     const char *push_branch_name,
 				     enum ahead_behind_flags abf,
 				     unsigned flags)
 {
@@ -2302,9 +2304,15 @@ static void format_branch_comparison(struct strbuf *sb,
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
@@ -2315,9 +2323,15 @@ static void format_branch_comparison(struct strbuf *sb,
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
 
@@ -2355,6 +2369,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		int ours, theirs, cmp;
 		int is_upstream, is_push;
 		unsigned flags = 0;
+		const char *push_remote_name = NULL;
+		const char *push_branch_name = NULL;
 
 		full_ref = resolve_compare_branch(branch,
 						  branches.items[i].string);
@@ -2396,13 +2412,25 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (reported)
 			strbuf_addstr(sb, "\n");
 
-		if (is_upstream)
+		if (is_upstream || is_push)
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
+				    *push_branch_name == '/')
+					push_branch_name++;
+				else
+					push_remote_name = NULL;
+			}
+		}
 		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
+					 push_remote_name, push_branch_name,
 					 abf, flags);
 		reported = 1;
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0242b5bf7a..b613aba33a 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -646,4 +646,82 @@ test_expect_success 'status.compareBranches with remapped push and upstream remo
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
 test_done

base-commit: 7bcaabddcf68bd0702697da5904c3b68c52f94cf
-- 
gitgitgadget
