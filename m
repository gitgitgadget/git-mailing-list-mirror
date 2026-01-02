Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78E2EAD09
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352669; cv=none; b=lMzJGxJ3lhXgwuKzmJR2S8tLO+I8+5zpd1tSMjUQknTFnxKgruKQP2gHy1Kwv32Lxe3+cCV2TF2Q0O2RMb8Ypt4KMGKyuTmXNhHXIEIhiwdTNcqsaI9Kz9I1wsRiPTqwi56LOwARtFA0lJI/WwFAfxQjuDQb17pqfR3C00nUGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352669; c=relaxed/simple;
	bh=sthdZiw7kEc4hbmtQ6g9usUl1lAQ/GXolrfwHLOp4Y0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d8T06z8lh6dEb+ECA8vx39ns+dY3CYd6rnfhF3G6Jv36U0bkwVF0jyZXyVx2lHlSdprT4KwX3pTMq0JT4R7g5ntcEVrx8v4XahpBaPniocUkYjI6f3VVtm9J9ZPySImKKiBCqOPnxBoUJr+y1DCTqX++F8fIXZKCUvPFwtRKx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CErsYC9v; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CErsYC9v"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so11674641eec.0
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767352665; x=1767957465; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWcn/mXiFDlY6bbsfAybk+IeBNraQW65Cf0CZLPJTvY=;
        b=CErsYC9vFbCQA2sMw2EspMfYXvB41fecuFR9qC9V5UIhdqJ2taCo/F9aebLEh80fgR
         n71lvRn14/LiMEEX7dvNwYy0E8E/eE4K7k9L6JTuwPxowEIGpo9lqBh25efcSg6ZrMF+
         Y/pVacxqO8usSuztXEk2gjpS9CC1LM8hznOOD7QNbWtgmXGJ0puijXQ+Oh5S1bHvNAIQ
         7+iCEDiQva0Am64Ss3qmp9sme9UaSOE98yo+Bm5zT2udxPTVe0J9nbUPb3IwSyBZpNUW
         wivw40Ph8Prx5cQCpYjntYeQmoE2P+w3tQxtTwyaLMi3g5T3cDPZT3IzLn2kMgN4i3Mo
         5/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767352665; x=1767957465;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kWcn/mXiFDlY6bbsfAybk+IeBNraQW65Cf0CZLPJTvY=;
        b=cdp3THEi42DqMSp70O3scoPLWYQySEnOZC7uFFVZTF/9Mh6dF8JrTpOG6aXE3gvWt5
         Jr3qMz9AmU6SxMz41iYtyFY+9oD5haXVFDY6eqWxUTAS1FzKv1+m1NVSdVIo6D/55n1W
         BXUb/KveNSTECHfsUfQse1CVBXoRoeLCKu8MpTsDo5TLzzyV2qDm69qu5X1Ox9ZLOtCD
         m/HvE17gFK0ZPFVBDDAO3U4JGW8eK7BhbbQ9KkM/tIk3rUYUOXjx4LB705cHpK7hyO0W
         QcFtmPn8dvosR1moGxVj9v0Nx7vhYIpUPOYhiYJozq3s21+f4L+z1bGlOYsOW14vXSLS
         QqXQ==
X-Gm-Message-State: AOJu0YwudlNee2Is2qMtw38/5jShgPdt96PkEDqftsH2PhcQydMYXtKJ
	3u8l7YjOHhM6MyrS1pPXe1p+y+NGSG2H+BuimEhGJ1yFCjw1kTUmqGGpX1fEIA==
X-Gm-Gg: AY/fxX7ll2tcuigo+1/6F7i1edM7wV5SEFB7BuV2MhLCAsqdTaiOU+hO1Z4VnsO2gAx
	BuVjg6fhhkRtV1/6dkC84J3wb5CuAujX7+Y4Fd0IYlbLsXeOjOY+HlBfWvvxIesy7att1hXW1Ek
	KVTrtVkGPemffphew1fYhD+7iZTpS8p7kWHZ9Y7IsOJGOd5nJnc7Fny5Zc+dqAnufVTY0AmwiTt
	dSqICznjhHv10sN66xrw7yEWT+LWA87tOenR/y2JtxMc7wEQ2+kZ97+aZiq9/0NIXLs/nNBu1g+
	qFRBDRY3zeidFQoUfjfXXP9iuuP9C6OBLpibeFmsttJjk27SuF98uk56dKJozz2MKfrOIaqg5K+
	lsAtFKJQE0oIEnjhAv8FAlZpn9gK4ABql2uHhCss9kLsskjU3+5Hv8pqa74tp285SIazcljbLni
	0fIg5IGpIVBVkAgm8=
X-Google-Smtp-Source: AGHT+IG7ZwJxvq+BtR6GWaqe86S66BPudRWtHpI/6Bd8tGmi790dPNfO4D+4JbMkFH8M5UN5YZfblw==
X-Received: by 2002:a05:7301:4882:b0:2ae:5022:fe7c with SMTP id 5a478bee46e88-2b04cafa887mr28042516eec.1.1767352664722;
        Fri, 02 Jan 2026 03:17:44 -0800 (PST)
Received: from [127.0.0.1] ([172.182.226.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b06a046e99sm104585953eec.6.2026.01.02.03.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 03:17:44 -0800 (PST)
Message-Id: <pull.2138.v11.git.git.1767352663477.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com>
References: <pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 11:17:43 +0000
Subject: [PATCH v11] status: show comparison with push remote tracking branch
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

"git status" on a branch that follows a remote branch compares
commits on the current branch and the remote-tracking branch it
builds upon, to show "ahead", "behind", or "diverged" status.

When working on a feature branch that tracks a remote feature branch,
but you also want to track progress relative to the push remote's
tracking branch (which may differ from the upstream branch), git status
now shows an additional comparison.

When a push remote is configured (via branch.<name>.pushRemote or
remote.pushDefault), git status shows both the comparison with the
upstream tracking branch (as before) and an additional comparison with
the push remote's tracking branch, if it differs from the upstream
tracking branch. The push branch comparison appears on a separate
line after the upstream branch status, using the same format:
- "Ahead of 'origin/feature' by N commits" when purely ahead
- "Behind 'origin/feature' by N commits" when purely behind
- "Diverged from 'origin/feature' by N commits" when diverged

Example output when tracking upstream/main with pushRemote set to origin:
    On branch feature
    Your branch is ahead of 'upstream/main' by 2 commits.
      (use "git pull" if you want to integrate the remote branch with yours)

    Ahead of 'origin/feature' by 5 commits.

The comparison is only shown when a push remote is configured and the
push remote's tracking branch differs from the upstream tracking branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    status: show comparison with push remote tracking branch
    
    cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
    ychin.macvim@gmail.com cc: "brian m. carlson"
    sandals@crustytoothpaste.net cc: Ben Knoble ben.knoble@gmail.com cc:
    "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v11
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v10:

 1:  43a75944fb ! 1:  53bb1cb6bb status: show comparison with configured goal branch
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    status: show comparison with configured goal branch
     +    status: show comparison with push remote tracking branch
      
          "git status" on a branch that follows a remote branch compares
          commits on the current branch and the remote-tracking branch it
          builds upon, to show "ahead", "behind", or "diverged" status.
      
          When working on a feature branch that tracks a remote feature branch,
     -    but you also want to track progress relative to a goal branch (e.g.,
     -    upstream/main), you can configure status.goalBranch to show an
     -    additional comparison.
     +    but you also want to track progress relative to the push remote's
     +    tracking branch (which may differ from the upstream branch), git status
     +    now shows an additional comparison.
      
     -    Add support for status.goalBranch configuration option that specifies
     -    a remote/branch to compare against. When set, git status shows both
     -    the comparison with the tracking branch (as before) and an additional
     -    comparison with the configured goal branch, if it differs from the
     -    tracking branch. The goal branch comparison appears on a separate
     -    line after the tracking branch status, using the same format:
     -    - "Ahead of 'upstream/main' by N commits" when purely ahead
     -    - "Behind 'upstream/main' by N commits" when purely behind
     -    - "Diverged from 'upstream/main' by N commits" when diverged
     +    When a push remote is configured (via branch.<name>.pushRemote or
     +    remote.pushDefault), git status shows both the comparison with the
     +    upstream tracking branch (as before) and an additional comparison with
     +    the push remote's tracking branch, if it differs from the upstream
     +    tracking branch. The push branch comparison appears on a separate
     +    line after the upstream branch status, using the same format:
     +    - "Ahead of 'origin/feature' by N commits" when purely ahead
     +    - "Behind 'origin/feature' by N commits" when purely behind
     +    - "Diverged from 'origin/feature' by N commits" when diverged
      
     -    Example output when tracking a feature branch with status.goalBranch
     -    set to upstream/main:
     +    Example output when tracking upstream/main with pushRemote set to origin:
              On branch feature
     -        Your branch is ahead of 'origin/feature' by 2 commits.
     -          (use "git push" to publish your local commits)
     +        Your branch is ahead of 'upstream/main' by 2 commits.
     +          (use "git pull" if you want to integrate the remote branch with yours)
      
     -        Ahead of 'upstream/main' by 5 commits.
     +        Ahead of 'origin/feature' by 5 commits.
      
     -    The comparison is only shown when status.goalBranch is configured
     -    and the goal branch differs from the tracking branch.
     +    The comparison is only shown when a push remote is configured and the
     +    push remote's tracking branch differs from the upstream tracking branch.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
       }
       
     -+static char *get_goal_branch_ref(char **full_ref_out)
     ++static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
      +{
     -+	const char *config_value;
     ++	const char *push_remote;
      +	const char *resolved;
      +	int flag;
      +	struct strbuf ref_buf = STRBUF_INIT;
     -+	char *slash_pos;
      +	char *ret = NULL;
      +
     -+	if (repo_config_get_value(the_repository, "status.goalBranch", &config_value))
     ++	if (!branch)
      +		return NULL;
      +
     -+	if (!config_value || !*config_value)
     ++	push_remote = pushremote_for_branch(branch, NULL);
     ++	if (!push_remote)
      +		return NULL;
      +
     -+	slash_pos = strchr(config_value, '/');
     -+	if (!slash_pos || slash_pos == config_value || !slash_pos[1]) {
     -+		warning(_("invalid value for status.goalBranch: '%s' (expected format: remote/branch)"),
     -+			config_value);
     -+		return NULL;
     -+	}
     -+
     -+	strbuf_addf(&ref_buf, "refs/remotes/%.*s/%s",
     -+		    (int)(slash_pos - config_value), config_value,
     -+		    slash_pos + 1);
     ++	strbuf_addf(&ref_buf, "refs/remotes/%s/%s", push_remote, branch->name);
      +
      +	resolved = refs_resolve_ref_unsafe(
      +		get_main_ref_store(the_repository),
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +	return ret;
      +}
      +
     -+static void format_goal_branch_comparison(struct strbuf *sb,
     ++static void format_push_branch_comparison(struct strbuf *sb,
      +					     const char *branch_refname,
     -+					     const char *goal_full,
     -+					     const char *goal_short,
     ++					     const char *push_full,
     ++					     const char *push_short,
      +					     enum ahead_behind_flags abf)
      +{
     -+	int goal_ahead = 0, goal_behind = 0;
     ++	int push_ahead = 0, push_behind = 0;
     ++	int stat_result;
      +
     -+	if (stat_branch_pair(branch_refname, goal_full,
     -+			     &goal_ahead, &goal_behind, abf) <= 0)
     ++	stat_result = stat_branch_pair(branch_refname, push_full,
     ++				       &push_ahead, &push_behind, abf);
     ++	if (stat_result < 0)
      +		return;
      +
      +	strbuf_addstr(sb, "\n");
      +
     -+	if (goal_ahead > 0 && goal_behind == 0) {
     ++	if (stat_result == 0 || (push_ahead == 0 && push_behind == 0)) {
     ++		strbuf_addf(sb,
     ++			_("Your branch is up to date with '%s'.\n"),
     ++			push_short);
     ++	} else if (push_ahead > 0 && push_behind == 0) {
      +		strbuf_addf(sb,
      +			Q_("Ahead of '%s' by %d commit.\n",
      +			   "Ahead of '%s' by %d commits.\n",
     -+			   goal_ahead),
     -+			goal_short, goal_ahead);
     -+	} else if (goal_behind > 0 && goal_ahead == 0) {
     ++			   push_ahead),
     ++			push_short, push_ahead);
     ++	} else if (push_behind > 0 && push_ahead == 0) {
      +		strbuf_addf(sb,
      +			Q_("Behind '%s' by %d commit.\n",
      +			   "Behind '%s' by %d commits.\n",
     -+			   goal_behind),
     -+			goal_short, goal_behind);
     -+	} else if (goal_ahead > 0 && goal_behind > 0) {
     ++			   push_behind),
     ++			push_short, push_behind);
     ++	} else if (push_ahead > 0 && push_behind > 0) {
      +		strbuf_addf(sb,
      +			Q_("Diverged from '%s' by %d commit.\n",
      +			   "Diverged from '%s' by %d commits.\n",
     -+			   goal_ahead + goal_behind),
     -+			goal_short, goal_ahead + goal_behind);
     ++			   push_ahead + push_behind),
     ++			push_short, push_ahead + push_behind);
      +	}
      +}
      +
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	}
      +
      +	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
     -+		char *goal_full = NULL;
     -+		char *goal_short = get_goal_branch_ref(&goal_full);
     ++		char *push_full = NULL;
     ++		char *push_short = get_remote_push_branch(branch, &push_full);
      +
     -+		if (goal_short && strcmp(base, goal_short))
     -+			format_goal_branch_comparison(sb, branch->refname, goal_full,
     -+						     goal_short, abf);
     ++		if (push_short && strcmp(base, push_short))
     ++			format_push_branch_comparison(sb, branch->refname, push_full,
     ++						     push_short, abf);
      +
     -+		free(goal_short);
     -+		free(goal_full);
     ++		free(push_short);
     ++		free(push_full);
      +	}
      +
       	free(base);
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       }
      
       ## t/t6040-tracking-info.sh ##
     -@@ t/t6040-tracking-info.sh: test_expect_success setup '
     - 	git clone . test &&
     - 	(
     - 		cd test &&
     -+		git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main &&
     - 		git checkout -b b1 origin &&
     - 		git reset --hard HEAD^ &&
     - 		advance d &&
      @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
       	test_cmp expect actual
       '
       
     -+test_expect_success 'setup for ahead of non-main tracking branch' '
     -+	(
     -+		cd test &&
     -+		git checkout -b feature origin/main &&
     -+		advance feature1 &&
     -+		git push origin feature &&
     -+		git checkout -b work --track origin/feature &&
     -+		advance work1 &&
     -+		advance work2
     -+	)
     -+'
     -+
     -+test_expect_success 'status shows ahead of both tracked branch and origin/main' '
     ++test_expect_success 'status tracking origin/main shows only main' '
      +	(
      +		cd test &&
     -+		git checkout work >/dev/null &&
     -+		git config status.goalBranch origin/main &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch work
     -+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
     -+  (use "git push" to publish your local commits)
     -+
     -+Ahead of '\''origin/main'\'' by 3 commits.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     ++		git checkout b4 &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch b4
     ++	Your branch is ahead of ${SQ}origin/main${SQ} by 2 commits.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'checkout shows ahead of both tracked branch and origin/main' '
     ++test_expect_success 'status shows ahead of both origin/main and feature branch' '
      +	(
      +		cd test &&
     -+		git checkout main >/dev/null &&
     -+		git config status.goalBranch origin/main &&
     -+		git checkout work 2>&1
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+Switched to branch '\''work'\''
     -+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
     -+  (use "git push" to publish your local commits)
     -+
     -+Ahead of '\''origin/main'\'' by 3 commits.
     -+EOF
     ++		git checkout -b feature2 origin/main &&
     ++		git push origin HEAD &&
     ++		advance work &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature2
     ++	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status tracking origin/main shows only main' '
     ++test_expect_success 'checkout shows ahead of both origin/main and feature branch' '
      +	(
      +		cd test &&
     -+		git checkout b4 >/dev/null &&
     -+		git status --long -b
     -+	) >actual &&
     -+	test_grep "ahead of .origin/main. by 2 commits" actual &&
     -+	test_grep ! "Ahead of" actual
     ++		git checkout feature2 >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success 'setup for ahead of tracked but diverged from main' '
      +	(
      +		cd test &&
     ++		git checkout -b feature4 origin/main &&
     ++		advance work1 &&
      +		git checkout origin/main &&
     -+		git checkout -b oldfeature &&
     -+		advance oldfeature1 &&
     -+		git push origin oldfeature &&
     -+		git checkout origin/main &&
     -+		advance main_newer &&
     ++		advance work2 &&
      +		git push origin HEAD:main &&
     -+		git checkout -b work2 --track origin/oldfeature &&
     -+		advance work2_commit
     -+	)
     -+'
     -+
     -+test_expect_success 'status shows ahead of tracked and diverged from origin/main' '
     -+	(
     -+		cd test &&
     -+		git checkout work2 >/dev/null &&
     -+		git config status.goalBranch origin/main &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch work2
     -+Your branch is ahead of '\''origin/oldfeature'\'' by 1 commit.
     -+  (use "git push" to publish your local commits)
     -+
     -+Diverged from '\''origin/main'\'' by 3 commits.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'setup for diverged from tracked but behind main' '
     -+	(
     -+		cd test &&
     -+		git fetch origin &&
     -+		git checkout origin/main &&
     -+		git checkout -b work2b &&
     -+		git branch --set-upstream-to=origin/oldfeature &&
     -+		git checkout origin/main &&
     -+		advance main_extra &&
     -+		git push origin HEAD:main
     -+	)
     -+'
     -+
     -+test_expect_success 'status shows diverged from tracked and behind origin/main' '
     -+	(
     -+		cd test &&
     -+		git checkout work2b >/dev/null &&
     -+		git config status.goalBranch origin/main &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch work2b
     -+Your branch and '\''origin/oldfeature'\'' have diverged,
     -+and have 1 and 1 different commits each, respectively.
     -+  (use "git pull" if you want to integrate the remote branch with yours)
     -+
     -+Behind '\''origin/main'\'' by 1 commit.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'setup for behind tracked but ahead of main' '
     -+	(
     -+		cd test &&
     -+		git fetch origin &&
     -+		git checkout origin/main &&
     -+		git checkout -b feature3 &&
     -+		advance feature3_1 &&
     -+		advance feature3_2 &&
     -+		advance feature3_3 &&
     -+		git push origin feature3 &&
     -+		git checkout -b work3 --track origin/feature3 &&
     -+		git reset --hard HEAD~2
     ++		git checkout feature4 &&
     ++		advance work3
      +	)
      +'
      +
     -+test_expect_success 'status shows behind tracked and ahead of origin/main' '
     ++test_expect_success 'status shows diverged from origin/main and ahead of feature branch' '
      +	(
      +		cd test &&
     -+		git checkout work3 >/dev/null &&
     -+		git config status.goalBranch origin/main &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch work3
     -+Your branch is behind '\''origin/feature3'\'' by 2 commits, and can be fast-forwarded.
     -+  (use "git pull" to update your local branch)
     -+
     -+Ahead of '\''origin/main'\'' by 1 commit.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     ++		git checkout feature4 &&
     ++		git branch --set-upstream-to origin/main &&
     ++		git push origin HEAD &&
     ++		advance work &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature4
     ++	Your branch and ${SQ}origin/main${SQ} have diverged,
     ++	and have 3 and 1 different commits each, respectively.
     ++	  (use "git pull" if you want to integrate the remote branch with yours)
     ++
     ++	Ahead of ${SQ}origin/feature4${SQ} by 1 commit.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'setup upstream remote preference' '
     ++test_expect_success 'setup upstream remote' '
      +	(
      +		cd test &&
      +		git remote add upstream ../. &&
      +		git fetch upstream &&
     -+		git symbolic-ref refs/remotes/upstream/HEAD refs/remotes/upstream/main
     ++		git config remote.pushDefault origin
      +	)
      +'
      +
     -+test_expect_success 'status prefers upstream remote over origin for comparison' '
     ++test_expect_success 'status with upstream remote and push.default set to origin' '
      +	(
      +		cd test &&
     -+		git checkout work >/dev/null &&
     -+		git config status.goalBranch upstream/main &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch work
     -+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
     -+  (use "git push" to publish your local commits)
     -+
     -+Diverged from '\''upstream/main'\'' by 5 commits.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     ++		git checkout -b feature5 upstream/main &&
     ++		git push origin &&
     ++		advance work &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature5
     ++	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	Ahead of ${SQ}origin/feature5${SQ} by 1 commit.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'setup for up to date with tracked but ahead of default' '
     -+	(
     -+		cd test &&
     -+		git checkout origin/feature &&
     -+		git checkout -b synced_feature --track origin/feature &&
     -+		git checkout origin/main &&
     -+		advance main_ahead &&
     -+		git push origin HEAD:main
     -+	)
     -+'
     -+
     -+test_expect_success 'status shows up to date with tracked but diverged from default' '
     ++test_expect_success 'status with upstream remote and push.default set to origin and diverged' '
      +	(
      +		cd test &&
     -+		git checkout synced_feature >/dev/null &&
     -+		git config status.goalBranch upstream/main &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch synced_feature
     -+Your branch is up to date with '\''origin/feature'\''.
     -+
     -+Diverged from '\''upstream/main'\'' by 3 commits.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     ++		git checkout -b feature6 upstream/main &&
     ++		advance work &&
     ++		git push origin &&
     ++		git reset --hard upstream/main &&
     ++		advance work &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature6
     ++	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	Diverged from ${SQ}origin/feature6${SQ} by 2 commits.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'setup for up to date with tracked but ahead of origin/main' '
     ++test_expect_success 'status with upstream remote and push branch up to date' '
      +	(
      +		cd test &&
     -+		git remote remove upstream &&
     -+		git checkout origin/feature &&
     -+		git checkout -b synced_feature2 --track origin/feature &&
     -+		git checkout origin/main &&
     -+		advance main_ahead2 &&
     -+		git push origin HEAD:main
     -+	)
     -+'
     -+
     -+test_expect_success 'status shows up to date with tracked but diverged from origin/main' '
     -+	(
     -+		cd test &&
     -+		git checkout synced_feature2 >/dev/null &&
     -+		git config status.goalBranch origin/main &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch synced_feature2
     -+Your branch is up to date with '\''origin/feature'\''.
     -+
     -+Diverged from '\''origin/main'\'' by 5 commits.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     ++		git checkout -b feature7 upstream/main &&
     ++		git push origin &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature7
     ++	Your branch is up to date with ${SQ}upstream/main${SQ}.
     ++
     ++	Your branch is up to date with ${SQ}origin/feature7${SQ}.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'setup for up to date with tracked but purely ahead of origin/main' '
     ++test_expect_success 'checkout shows push branch up to date' '
      +	(
      +		cd test &&
     -+		git checkout origin/feature &&
     -+		git checkout -b synced_feature3 --track origin/feature
     -+	)
     -+'
     ++		git checkout feature7 >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	Your branch is up to date with ${SQ}upstream/main${SQ}.
      +
     -+test_expect_success 'status shows up to date with tracked but shows default branch comparison' '
     -+	(
     -+		cd test &&
     -+		git checkout synced_feature3 >/dev/null &&
     -+		git config status.goalBranch origin/main &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch synced_feature3
     -+Your branch is up to date with '\''origin/feature'\''.
     -+
     -+Diverged from '\''origin/main'\'' by 5 commits.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'status with status.goalBranch unset shows no default comparison' '
     -+	(
     -+		cd test &&
     -+		git checkout synced_feature3 >/dev/null &&
     -+		git config --unset status.goalBranch 2>/dev/null || true &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch synced_feature3
     -+Your branch is up to date with '\''origin/feature'\''.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'status with status.goalBranch set uses configured branch' '
     -+	(
     -+		cd test &&
     -+		git checkout synced_feature3 >/dev/null &&
     -+		git config status.goalBranch origin/main &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch synced_feature3
     -+Your branch is up to date with '\''origin/feature'\''.
     -+
     -+Diverged from '\''origin/main'\'' by 5 commits.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'status with status.goalBranch set to different remote/branch' '
     -+	(
     -+		cd test &&
     -+		git checkout work >/dev/null &&
     -+		git config status.goalBranch origin/feature &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch work
     -+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
     -+  (use "git push" to publish your local commits)
     -+
     -+nothing to commit, working tree clean
     -+EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'status with status.goalBranch set to non-existent branch' '
     -+	(
     -+		cd test &&
     -+		git checkout synced_feature3 >/dev/null &&
     -+		git config status.goalBranch origin/nonexistent &&
     -+		git status --long -b
     -+	) >actual &&
     -+	cat >expect <<-\EOF &&
     -+On branch synced_feature3
     -+Your branch is up to date with '\''origin/feature'\''.
     -+
     -+nothing to commit, working tree clean
     -+EOF
     ++	Your branch is up to date with ${SQ}origin/feature7${SQ}.
     ++	EOF
      +	test_cmp expect actual
      +'
      +
 2:  e6d24b8b6a < -:  ---------- improve tests
 3:  13c2a03b0a < -:  ---------- use pushRemote and tracking branch


 remote.c                 |  89 +++++++++++++++++++++
 t/t6040-tracking-info.sh | 167 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 256 insertions(+)

diff --git a/remote.c b/remote.c
index 59b3715120..2317725f7d 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,6 +2237,81 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
+{
+	const char *push_remote;
+	const char *resolved;
+	int flag;
+	struct strbuf ref_buf = STRBUF_INIT;
+	char *ret = NULL;
+
+	if (!branch)
+		return NULL;
+
+	push_remote = pushremote_for_branch(branch, NULL);
+	if (!push_remote)
+		return NULL;
+
+	strbuf_addf(&ref_buf, "refs/remotes/%s/%s", push_remote, branch->name);
+
+	resolved = refs_resolve_ref_unsafe(
+		get_main_ref_store(the_repository),
+		ref_buf.buf,
+		RESOLVE_REF_READING,
+		NULL, &flag);
+
+	if (resolved) {
+		if (full_ref_out)
+			*full_ref_out = xstrdup(resolved);
+		ret = refs_shorten_unambiguous_ref(
+			get_main_ref_store(the_repository), resolved, 0);
+	}
+
+	strbuf_release(&ref_buf);
+	return ret;
+}
+
+static void format_push_branch_comparison(struct strbuf *sb,
+					     const char *branch_refname,
+					     const char *push_full,
+					     const char *push_short,
+					     enum ahead_behind_flags abf)
+{
+	int push_ahead = 0, push_behind = 0;
+	int stat_result;
+
+	stat_result = stat_branch_pair(branch_refname, push_full,
+				       &push_ahead, &push_behind, abf);
+	if (stat_result < 0)
+		return;
+
+	strbuf_addstr(sb, "\n");
+
+	if (stat_result == 0 || (push_ahead == 0 && push_behind == 0)) {
+		strbuf_addf(sb,
+			_("Your branch is up to date with '%s'.\n"),
+			push_short);
+	} else if (push_ahead > 0 && push_behind == 0) {
+		strbuf_addf(sb,
+			Q_("Ahead of '%s' by %d commit.\n",
+			   "Ahead of '%s' by %d commits.\n",
+			   push_ahead),
+			push_short, push_ahead);
+	} else if (push_behind > 0 && push_ahead == 0) {
+		strbuf_addf(sb,
+			Q_("Behind '%s' by %d commit.\n",
+			   "Behind '%s' by %d commits.\n",
+			   push_behind),
+			push_short, push_behind);
+	} else if (push_ahead > 0 && push_behind > 0) {
+		strbuf_addf(sb,
+			Q_("Diverged from '%s' by %d commit.\n",
+			   "Diverged from '%s' by %d commits.\n",
+			   push_ahead + push_behind),
+			push_short, push_ahead + push_behind);
+	}
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2258,6 +2333,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2311,6 +2387,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
+
+	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
+		char *push_full = NULL;
+		char *push_short = get_remote_push_branch(branch, &push_full);
+
+		if (push_short && strcmp(base, push_short))
+			format_push_branch_comparison(sb, branch->refname, push_full,
+						     push_short, abf);
+
+		free(push_short);
+		free(push_full);
+	}
+
 	free(base);
 	return 1;
 }
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..f27ae719ad 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,171 @@ test_expect_success '--set-upstream-to @{-1}' '
 	test_cmp expect actual
 '
 
+test_expect_success 'status tracking origin/main shows only main' '
+	(
+		cd test &&
+		git checkout b4 &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch b4
+	Your branch is ahead of ${SQ}origin/main${SQ} by 2 commits.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status shows ahead of both origin/main and feature branch' '
+	(
+		cd test &&
+		git checkout -b feature2 origin/main &&
+		git push origin HEAD &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature2
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows ahead of both origin/main and feature branch' '
+	(
+		cd test &&
+		git checkout feature2 >../actual
+	) &&
+	cat >expect <<-EOF &&
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	Ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for ahead of tracked but diverged from main' '
+	(
+		cd test &&
+		git checkout -b feature4 origin/main &&
+		advance work1 &&
+		git checkout origin/main &&
+		advance work2 &&
+		git push origin HEAD:main &&
+		git checkout feature4 &&
+		advance work3
+	)
+'
+
+test_expect_success 'status shows diverged from origin/main and ahead of feature branch' '
+	(
+		cd test &&
+		git checkout feature4 &&
+		git branch --set-upstream-to origin/main &&
+		git push origin HEAD &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature4
+	Your branch and ${SQ}origin/main${SQ} have diverged,
+	and have 3 and 1 different commits each, respectively.
+	  (use "git pull" if you want to integrate the remote branch with yours)
+
+	Ahead of ${SQ}origin/feature4${SQ} by 1 commit.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup upstream remote' '
+	(
+		cd test &&
+		git remote add upstream ../. &&
+		git fetch upstream &&
+		git config remote.pushDefault origin
+	)
+'
+
+test_expect_success 'status with upstream remote and push.default set to origin' '
+	(
+		cd test &&
+		git checkout -b feature5 upstream/main &&
+		git push origin &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature5
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	Ahead of ${SQ}origin/feature5${SQ} by 1 commit.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with upstream remote and push.default set to origin and diverged' '
+	(
+		cd test &&
+		git checkout -b feature6 upstream/main &&
+		advance work &&
+		git push origin &&
+		git reset --hard upstream/main &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature6
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	Diverged from ${SQ}origin/feature6${SQ} by 2 commits.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with upstream remote and push branch up to date' '
+	(
+		cd test &&
+		git checkout -b feature7 upstream/main &&
+		git push origin &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature7
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows push branch up to date' '
+	(
+		cd test &&
+		git checkout feature7 >../actual
+	) &&
+	cat >expect <<-EOF &&
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
+	EOF
+	test_cmp expect actual
+'
+
 test_done

base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
-- 
gitgitgadget
