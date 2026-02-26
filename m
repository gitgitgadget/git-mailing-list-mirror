Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021932692B
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102027; cv=none; b=qbEqf6Y3zCoun5ikRwAAeJxrg/B1OOOyAmRGzr0vCb+TY5YE6X+FGGFrQja8PNH/BXQM7KK8IwG3S2mbYnAsHhiAYS23pT15DZTBohgQcbmqLqB6jwFTPD/6AQqQlL3wYe+bDqvZcKae3PfLKIxl3KO+s7b6dHe1oeRx3HsgjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102027; c=relaxed/simple;
	bh=sWWOLWtuGPy+crEDx/5SUbQspceXKI2+Ue+B38HBqD8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Se5F1j+QwyD9avVM5K4pX2E2LKasXCaWAN4XOW8WMJ042QYjZSZNkgsjuoZ6Rwm94+oExiJz1xp3FarT0vIpSd4wbbNkzmrjfk2ipnFYqxrdb326Bs5xMPxY6kD9v/I8wQW+Ho26JtO9Ef20Ez6kJL3LXlM5NwZz+BMDoKqiiwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8ieO0uc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8ieO0uc"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb3fb47559so68231285a.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 02:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772102024; x=1772706824; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCB9kPvfgG9h3k6Fwa+FbszqUvuHkUmD8d7PfUa/BXo=;
        b=l8ieO0ucot2+mAWr8yUTL4ia1/Rja2DjSCfNUStxYkE5vjL62zIrOjU98TwInpqbJN
         0aOUrOHZJlVEOhPlolJFydjCbX2dSGRVY78+H1nwfzaorGQUDKdVBE/BDWIahEZ8mEr0
         vY5hWEa+ASJtydn9WfAeevWLC2iHo1h8BnSz7F3nDMaNW3ubhQ36y6n2JQ5IijkF3MKL
         5AFBhoAL7ILHJ4NPN02D/iM05hEBRpOJTm3S5Y9DnscNIHFyv7gCBKbLKJI7PVuliN+f
         QddQPWlNaVw/aiQ/C08gW8760u7d/4wcqJj2otHBuDw0/A+KyiekWBKbutc3O2NN7PGs
         RX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772102024; x=1772706824;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kCB9kPvfgG9h3k6Fwa+FbszqUvuHkUmD8d7PfUa/BXo=;
        b=iXDFWQqkpAW8Jjr5sSCbwiLBs4BjmUnioJiocqqgI6SDrDzLD20LYCS7xNu87T6H0U
         A8Tj5bVrpfPIWqajM0zKQLqIoWCD32ncTkBUMKODeZp7pfZmNyhBooqhSWxhd7QOSO9q
         xvufevnUE2SvjTYtVx6x9i/E1XHujobWWRFEq87q8MaMhvCH6hNaxJB7iMAxi0vRPLXu
         aZ34O3vBp5xlZsKbhsUOY2AoZj4dGK9qrEr+tSzeSg5iRg9LyA4psDByxuTYplgQbAE7
         aS0rJNjuNEUiYWgHqrtakgEmtfamzaPzeZCBYr6YfFu0uAnkibZM5uV4Iu+BykyA+dFH
         aW8w==
X-Gm-Message-State: AOJu0Yx0J5WWr6f5zbF2hyySqwcxXNUFGEogFTSJYqh/YgaAENKijmjo
	ZN3qWvix7oQ2v/vEMtGqiOzaIoVJ4CkxhUpWGp2G2jLM4gQR4W7DMwjcNF6ZhA==
X-Gm-Gg: ATEYQzwu1f4YQ9GCmLATJZl+ydFhenIXnuq9Q/1ZjNkjETTTWP69nhtABNZV303IKlR
	OX0yP5O7K19CJFjNt+AyKtZiZo34qQfYBUImEnqJc9AaCVN6K0xvU73emSMfeSYqjZIFyxBzdCL
	vhwwrLg2xp1DBXkOYAvNI3acSxJqmQwf3cf/HmSmBdxucZ9C1y1S6kCYr3RhVdmR3Mfh/Vd5KV8
	sQ/5iyGM0Xu5Vgg5nTCa1fmRKaDGGe0C8yD1+vJnZGapUcppHT6Szs8YyHjroOkKTU0pAM3KEC1
	VwQ0Zvf2ZBeRboq6geUnez6QLc93Miqvg06k7/7TxYktuPP3MADa3nTNgd3uAFDPjLkRyC7xo3w
	2qZSosylTSMsQJCARH6mTxhSwIWHq+wv5djfAdX2b9fEoRcHYx/0qOt+qg93b3aUtBY8GABimLn
	i92fxp9koMbsFyBbV0IDaitoSv
X-Received: by 2002:a05:620a:4801:b0:8c9:f8e5:9f12 with SMTP id af79cd13be357-8cb8ca807b8mr2745783585a.57.1772102023678;
        Thu, 26 Feb 2026 02:33:43 -0800 (PST)
Received: from [127.0.0.1] ([52.150.29.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738cba0sm14204306d6.38.2026.02.26.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 02:33:42 -0800 (PST)
Message-Id: <pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
References: <pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 10:33:40 +0000
Subject: [PATCH v30 0/2] status: add status.compareBranches config for multiple branch comparisons
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im cc:
Jeff King peff@peff.net

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: add status.compareBranches config for multiple branch
    comparisons

 Documentation/config/status.adoc |  19 ++
 remote.c                         | 178 ++++++++++++++----
 t/t6040-tracking-info.sh         | 310 +++++++++++++++++++++++++++++++
 3 files changed, 470 insertions(+), 37 deletions(-)


base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v30
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v30
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v29:

 1:  48db1f4847 = 1:  7f517b8c7f refactor format_branch_comparison in preparation
 2:  6a88f41fa5 ! 2:  501bd40294 status: add status.compareBranches config for multiple branch comparisons
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +	if (!branch || !name)
      +		return NULL;
      +
     -+	if (!strcasecmp(name, "@{upstream}"))
     ++	if (!strcasecmp(name, "@{upstream}")) {
      +		resolved = branch_get_upstream(branch, NULL);
     -+	else if (!strcasecmp(name, "@{push}"))
     ++	} else if (!strcasecmp(name, "@{push}")) {
      +		resolved = branch_get_push(branch, NULL);
     -+	else {
     -+		warning(_("ignoring value '%s' for status.compareBranches; only @{upstream} and @{push} are supported"),
     ++	} else {
     ++		warning(_("ignoring value '%s' for status.compareBranches, "
     ++			  "only @{upstream} and @{push} are supported"),
      +			name);
      +		return NULL;
      +	}
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      -				     bool show_divergence_advice)
      +				     unsigned flags)
       {
     -+	bool enable_push_advice = (flags & ENABLE_ADVICE_PUSH) &&
     -+		advice_enabled(ADVICE_STATUS_HINTS);
     -+	bool enable_pull_advice = (flags & ENABLE_ADVICE_PULL) &&
     -+		advice_enabled(ADVICE_STATUS_HINTS);
     -+	bool enable_divergence_advice = (flags & ENABLE_ADVICE_DIVERGENCE) &&
     -+		advice_enabled(ADVICE_STATUS_HINTS);
     ++	bool use_push_advice = (flags & ENABLE_ADVICE_PUSH);
     ++	bool use_pull_advice = (flags & ENABLE_ADVICE_PULL);
     ++	bool use_divergence_advice = (flags & ENABLE_ADVICE_DIVERGENCE);
      +
       	if (up_to_date) {
       		strbuf_addf(sb,
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			    _("Your branch and '%s' refer to different commits.\n"),
       			    branch_name);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if (enable_push_advice)
     ++		if (use_push_advice && advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
       				    "git status --ahead-behind");
       	} else if (!theirs) {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   ours),
       			branch_name, ours);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if (enable_push_advice)
     ++		if (use_push_advice && advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addstr(sb,
       				_("  (use \"git push\" to publish your local commits)\n"));
       	} else if (!ours) {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   theirs),
       			branch_name, theirs);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if (enable_pull_advice)
     ++		if (use_pull_advice && advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" to update your local branch)\n"));
       	} else {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			branch_name, ours, theirs);
      -		if (show_divergence_advice &&
      -		    advice_enabled(ADVICE_STATUS_HINTS))
     -+		if (enable_divergence_advice)
     ++		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
       	}
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'setup for compareBranches tests' '
     -+	(
     -+		cd test &&
     -+		git config push.default current &&
     -+		git config status.compareBranches "@{upstream} @{push}"
     -+	)
     -+'
     -+
      +test_expect_success 'status.compareBranches from upstream has no duplicates' '
     -+	(
     -+		cd test &&
     -+		git checkout main &&
     -+		git status >../actual
     -+	) &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout main &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch main
      +	Your branch is up to date with ${SQ}origin/main${SQ}.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
     -+	(
     -+		cd test &&
     -+		git checkout -b feature2 origin/main &&
     -+		git push origin HEAD &&
     -+		advance work &&
     -+		git status >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout -b feature2 origin/main &&
     ++	git -C test push origin HEAD &&
     ++	(cd test && advance work) &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature2
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'checkout with status.compareBranches shows both branches' '
     -+	(
     -+		cd test &&
     -+		git checkout feature2 >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout feature2 >actual &&
      +	cat >expect <<-EOF &&
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
      +
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status.compareBranches shows diverged and ahead' '
     -+	(
     -+		cd test &&
     -+		git checkout feature4 &&
     -+		git branch --set-upstream-to origin/main &&
     -+		git push origin HEAD &&
     -+		advance work &&
     -+		git status >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout feature4 &&
     ++	git -C test branch --set-upstream-to origin/main &&
     ++	git -C test push origin HEAD &&
     ++	(cd test && advance work) &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature4
      +	Your branch and ${SQ}origin/main${SQ} have diverged,
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status --no-ahead-behind with status.compareBranches' '
     -+	(
     -+		cd test &&
     -+		git checkout feature4 &&
     -+		git status --no-ahead-behind >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout feature4 &&
     ++	git -C test status --no-ahead-behind >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature4
      +	Your branch and ${SQ}origin/main${SQ} refer to different commits.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	(
      +		cd test &&
      +		git remote add upstream ../. &&
     -+		git fetch upstream &&
     -+		git config remote.pushDefault origin
     ++		git fetch upstream
      +	)
      +'
      +
      +test_expect_success 'status.compareBranches with upstream and origin remotes' '
     -+	(
     -+		cd test &&
     -+		git checkout -b feature5 upstream/main &&
     -+		git push origin &&
     -+		advance work &&
     -+		git status >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout -b feature5 upstream/main &&
     ++	git -C test push origin &&
     ++	(cd test && advance work) &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature5
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status.compareBranches supports ordered upstream/push entries' '
     -+	(
     -+		cd test &&
     -+		git checkout -b feature6 upstream/main &&
     -+		git push origin &&
     -+		advance work &&
     -+		git -c status.compareBranches="@{push} @{upstream}" status >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test status.compareBranches "@{push} @{upstream}" &&
     ++	git -C test checkout -b feature6 upstream/main &&
     ++	git -C test push origin &&
     ++	(cd test && advance work) &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature6
      +	Your branch is ahead of ${SQ}origin/feature6${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status.compareBranches with diverged push branch' '
     -+	(
     -+		cd test &&
     -+		git checkout -b feature7 upstream/main &&
     -+		advance work &&
     -+		git push origin &&
     -+		git reset --hard upstream/main &&
     -+		advance work &&
     -+		git status >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout -b feature7 upstream/main &&
     ++	(cd test && advance work71) &&
     ++	git -C test push origin &&
     ++	git -C test reset --hard upstream/main &&
     ++	(cd test && advance work72) &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature7
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status.compareBranches shows up to date branches' '
     -+	(
     -+		cd test &&
     -+		git checkout -b feature8 upstream/main &&
     -+		git push origin &&
     -+		git status >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout -b feature8 upstream/main &&
     ++	git -C test push origin &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature8
      +	Your branch is up to date with ${SQ}upstream/main${SQ}.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status --no-ahead-behind with status.compareBranches up to date' '
     -+	(
     -+		cd test &&
     -+		git checkout feature8 &&
     -+		git push origin &&
     -+		git status --no-ahead-behind >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout feature8 >actual &&
     ++	git -C test push origin &&
     ++	git -C test status --no-ahead-behind >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature8
      +	Your branch is up to date with ${SQ}upstream/main${SQ}.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'checkout with status.compareBranches shows up to date' '
     -+	(
     -+		cd test &&
     -+		git checkout feature8 >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout feature8 >actual &&
      +	cat >expect <<-EOF &&
      +	Your branch is up to date with ${SQ}upstream/main${SQ}.
      +
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status.compareBranches with upstream behind and push up to date' '
     -+	(
     -+		cd test &&
     -+		git checkout -b ahead upstream/main &&
     -+		advance work &&
     -+		git push upstream HEAD &&
     -+		git checkout -b feature9 upstream/main &&
     -+		git push origin &&
     -+		git branch --set-upstream-to upstream/ahead &&
     -+		git status >../actual
     -+	) &&
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout -b ahead upstream/main &&
     ++	(cd test && advance work) &&
     ++	git -C test push upstream HEAD &&
     ++	git -C test checkout -b feature9 upstream/main &&
     ++	git -C test push origin &&
     ++	git -C test branch --set-upstream-to upstream/ahead &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature9
      +	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status.compareBranches with remapped push refspec' '
     -+	(
     -+		cd test &&
     -+		git checkout -b feature10 origin/main &&
     -+		git config remote.origin.push refs/heads/feature10:refs/heads/remapped &&
     -+		git push &&
     -+		advance work &&
     -+		git status >../actual
     -+	) &&
     ++	test_config -C test remote.origin.push refs/heads/feature10:refs/heads/remapped &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout -b feature10 origin/main &&
     ++	git -C test push &&
     ++	(cd test && advance work) &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature10
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +'
      +
      +test_expect_success 'status.compareBranches with remapped push and upstream remote' '
     -+	(
     -+		cd test &&
     -+		git checkout -b feature11 upstream/main &&
     -+		git config remote.origin.push refs/heads/feature11:refs/heads/remapped &&
     -+		git push origin &&
     -+		advance work &&
     -+		git status >../actual
     -+	) &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	test_config -C test remote.origin.push refs/heads/feature11:refs/heads/remapped &&
     ++	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     ++	git -C test checkout -b feature11 upstream/main &&
     ++	git -C test push origin &&
     ++	(cd test && advance work) &&
     ++	git -C test status >actual &&
      +	cat >expect <<-EOF &&
      +	On branch feature11
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	EOF
      +	test_cmp expect actual
      +'
     -+
     -+test_expect_success 'clean up after compareBranches tests' '
     -+	(
     -+		cd test &&
     -+		git config --unset status.compareBranches
     -+	)
     -+'
      +
       test_done

-- 
gitgitgadget
