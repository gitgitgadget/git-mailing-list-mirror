Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2707218FC80
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767389658; cv=none; b=bNgK+cVADs+Q7rGSWJmTwnHU9q9/Y2SGDGT0TwmtTIJmSG1ZtyqqNXeieGbg32lrpEPx8BiqnZhNpYSgNvtsf7ndWN0TwSPdIRZqMS/d7fwAL9Szj7ElZmQn1ItR1lwP/R7VcZ6kA1w7hewOO1E+V6yT2lgyJogQBu2nwZ2Co7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767389658; c=relaxed/simple;
	bh=ROrrJpIydxmsDSEngJCr7YPk0g2hjrIvOM0BQqoSktA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C71aja06fQcs1BiU0iJgoEJSW0Kt9MKZw1XO8OLrUcF009WICkiEWLx9XLFtUPbS1Ae4TRU8DnwJuqB1K939amnObDQZiBo9CiCKCBeT8vtPcR5HrC6AizeZXcYfiUHmgG8ynUtzL+oNZITqoEjHbX4I+jsoLhAXykFYiynBUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFTVHkEm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFTVHkEm"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c0f15e8247so1487902785a.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767389652; x=1767994452; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0Dm/lX+rftOvg5P7bq1eb3keQO0P9znn0zWLfv5iwA=;
        b=ZFTVHkEm4POmdKs1ETC0XbHcgIP/QPFdn03wcv6RiV6QrT8oXQGlFAnpW7H7pkoQ1T
         oCeDqQ8//CPeNYaZ3XJczi4k9VSvNQj6B+xMEGvPE/w63+XF4WYHYJFHGqVUD/WUzZ3p
         U+x9Ryt/bmo/xqXPQYsMLfHvPWTAdtQdDHofgLybud/EA+0VRizkWmkjVQBRe45fb6gG
         wh/AGCm2+7KZSFIo5fb7qZqJOAvDfeC7Cq/ap2OAssS6Oj/GLDSX+tgu94TBlOY0yQxN
         fK51I9PAeo8nk1B6CIevfDt+b3SgHZIH1H32a2erBK/op+Zfbrm8PNI1Pdpu+xA/65cN
         h7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767389652; x=1767994452;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c0Dm/lX+rftOvg5P7bq1eb3keQO0P9znn0zWLfv5iwA=;
        b=GAI2WV1nLqtvkcWCJRjg48M6nNn6HDCR/54qocd4cyP4NuxxBxSqSzaTtf5WXS+4wU
         9rFRlEG5LayQIadeeAesNDHU2jasKELQW0Dk8zlkKwzyxNNFsxAa97t67pGbtfrjRMqA
         ArHQwN/MhQF0j3pWZVG/2Oi3twTpAQz/j1ejl8E5R15lufnxztHwvO4ctaj6tdO54rz1
         B6FY2Nd6EdAnvujb/W9xPdpiWG8PtyBlxeXSpcc/mZSgTRCGDZRyhqCTJZ9vD0c+0M8J
         8VjW+apzlxVKW8C5PnK6mlEBmzpTo09yo56way0KXn/Hd7c6XLlL0qMsMc73/NzNxnIJ
         haPg==
X-Gm-Message-State: AOJu0YyIcQrXteQ/rcah2MG+1Y8qO8UBXf7AwOOXh3SZKe3pGFvYn637
	o2zyhYs1U61jumnBA9eC8ZhVOuQUI/CzeEuvbcZH9pJmzwem1re3iGWt3uNpqs/u
X-Gm-Gg: AY/fxX43zPwb+xd/L945eCVcm6226kMwCMf70dsoQqF5zalVMa6fdk37xT4q+bXgmL/
	r0byl2mydhwB+vGW0zDK8twekN6qGpfbEMtKPJr1E0lAvIy5odzHLLH7zk5iBhuUmQB6lPKrwZP
	2x8jHNV8F0E17XT5/4iRdmi3Et6TtfiJtpZN0mpFMfgpMjLdeWr6H+0+zmvcZ8Ue/NZmLjfpPav
	N3I1UVTcn6T0G5J/4tWpAy8Cjm1GrbJTguS5y+xNgePWHqrLsLVgApVgdNdqbcWL9FCYDl3BLIP
	Umr4sjrj9NulBxxYx/4zU6eHxASPrCgslR0UMSasAoQTylTVE28OQB55Gf14FjutQlUION/Oso+
	6D5CI40DQ9u2yTVEVK+90hm/2ZBaiZcUKc/58MjdZ9zoQ3u5ApmaujqcBDqsSEejdp8aur6rtjN
	G4YObyq1oVJq5U
X-Google-Smtp-Source: AGHT+IFOL/Z9U3s767HJjLXBEuirHE8/JXgam7fbOotFf36enCWwGtMUVGMQ4Y0+lQVl2bF+7ycI9w==
X-Received: by 2002:a05:620a:199f:b0:8b2:7331:28e6 with SMTP id af79cd13be357-8c08fd1a8ddmr5832716285a.86.1767389652510;
        Fri, 02 Jan 2026 13:34:12 -0800 (PST)
Received: from [127.0.0.1] ([20.161.70.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f880bsm3256394885a.32.2026.01.02.13.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 13:34:11 -0800 (PST)
Message-Id: <a586038d1f9daafb0c6428ace7d396f79b036ed4.1767389649.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v12.git.git.1767389649.gitgitgadget@gmail.com>
References: <pull.2138.v11.git.git.1767352663477.gitgitgadget@gmail.com>
	<pull.2138.v12.git.git.1767389649.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 21:34:09 +0000
Subject: [PATCH v12 2/2] status: show comparison with push remote tracking
 branch
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
but you also want to track progress relative to the push destination
tracking branch (which may differ from the upstream branch), git status
now shows an additional comparison.

When the upstream tracking branch differs from the push destination
tracking branch, git status shows both the comparison with the upstream
tracking branch (as before) and an additional comparison with the push
destination tracking branch. The push branch comparison appears on a
separate line after the upstream branch status, using the same format.

Example output when tracking origin/main but push destination is
origin/feature:
    On branch feature
    Your branch and 'origin/main' have diverged,
    and have 3 and 1 different commits each, respectively.
      (use "git pull" if you want to integrate the remote branch with yours)

    Your branch is ahead of 'origin/feature' by 1 commit.
      (use "git push" to publish your local commits)

The comparison is only shown when the push destination tracking branch
differs from the upstream tracking branch, even if they are on the same
remote.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 |  73 ++++++++++++++++-
 t/t6040-tracking-info.sh | 168 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 58093f64b0..1663bd9236 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,6 +2237,39 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
+{
+	const char *push_remote;
+	const char *resolved;
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
+		NULL, NULL);
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
 static void format_branch_comparison(struct strbuf *sb,
 				     int ahead, int behind,
 				     const char *branch_name,
@@ -2304,6 +2337,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	int push_ours = 0, push_theirs = 0;
+	int push_stat_result = -1;
+	int will_show_push_comparison = 0;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2315,9 +2351,25 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
+	if (!upstream_is_gone && abf != AHEAD_BEHIND_QUICK) {
+		char *push_full = NULL;
+		char *push_short = get_remote_push_branch(branch, &push_full);
+
+		if (push_short && strcmp(base, push_short)) {
+			push_stat_result = stat_branch_pair(branch->refname, push_full,
+							    &push_ours, &push_theirs, abf);
+			if (push_stat_result >= 0)
+				will_show_push_comparison = 1;
+		}
+
+		free(push_short);
+		free(push_full);
+	}
+
 	format_branch_comparison(sb, ours, theirs, base, upstream_is_gone, abf, sti);
 	if (sti > 0 && abf != AHEAD_BEHIND_QUICK) {
-		if (!theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
+		if (!theirs && !will_show_push_comparison &&
+		    advice_enabled(ADVICE_STATUS_HINTS)) {
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 		} else if (!ours && advice_enabled(ADVICE_STATUS_HINTS)) {
@@ -2330,6 +2382,25 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		}
 	}
 
+	if (will_show_push_comparison) {
+		char *push_full = NULL;
+		char *push_short = get_remote_push_branch(branch, &push_full);
+
+		if (push_short && strcmp(base, push_short)) {
+			strbuf_addstr(sb, "\n");
+			format_branch_comparison(sb, push_ours, push_theirs, push_short, 0, abf,
+						push_ours || push_theirs);
+			if (push_ours > 0 && push_theirs == 0 &&
+			    advice_enabled(ADVICE_STATUS_HINTS)) {
+				strbuf_addstr(sb,
+					_("  (use \"git push\" to publish your local commits)\n"));
+			}
+		}
+
+		free(push_short);
+		free(push_full);
+	}
+
 	free(base);
 	return 1;
 }
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..8eb1f3e1f1 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,172 @@ test_expect_success '--set-upstream-to @{-1}' '
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
+
+	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
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
+
+	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
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
+	Your branch is ahead of ${SQ}origin/feature4${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
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
+
+	Your branch is ahead of ${SQ}origin/feature5${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
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
+
+	Your branch and ${SQ}origin/feature6${SQ} have diverged,
+	and have 1 and 1 different commits each, respectively.
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
-- 
gitgitgadget
