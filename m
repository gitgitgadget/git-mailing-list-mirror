Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D01299931
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766530455; cv=none; b=ODpwKJQ5O2bHS2b2GyM20h75Jv894upra3dQBux1kkN9eRk5rAgo+i/vMiK+yKIlEs1EnW275mBUzNDKG8yZ1Tjt8aGiIsrwY3wWgOWPAYF1C1lk6G/M3uWFXkwZjW2pynT0Y9PqgYUT981xJ3nJuf9XRs6ArT5k5NS99thzNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766530455; c=relaxed/simple;
	bh=MMyGEqA2dNGnNngUW17cNMS6p/QxHG3zNwdVAxCJh8w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KgHYi5+3qvL+RY+nTvSqzrbhFEZetQ4kQmVpdUI/+re+vjJjMEpsbGeNUjCeRb9sTLxHT03w9fQuFQJl1RDlfA7P2eCmUY/eFn/KgAe02swbV7K17RBUCs7KmIJXAC3gQzzapPDxWrpXL0ffYmHfuq9dpDLC1qtaIGUGuN7Gx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJtZfPe6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJtZfPe6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so4336595b3a.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 14:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766530452; x=1767135252; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJM8Fvvm4JVu8q5tOpyLZwjaBbWHg/Q824d3a8dQF10=;
        b=JJtZfPe69cMKnuhWkRf/IlRgPyStjuIkItVGlGDktgwG9ydPywZI8+ZCUKZ1EBo9e2
         yHb48qneEb8/BOHhNGCULrpse6Yd663K1xcHfo9EBfuD9tYicMmjbk+DhjLI2+eag3Ai
         N7l/7R2vjDm1SmZbtlXvBXvZQm3iWUV1lCNElVvxWAzF3Bve0uoATqpMkJicY6ZLxFhj
         rayE3CK3OmLwqkSC73fncTevm4poYlUr5smM5WijI489TTeQD+AReEUj8Fgw6GBT3EDF
         SESUVcRKTOdGulF2Z0UScxSak8P0UoAo92qpDBYw0xncqfvtlSgtqE3DoKW2JY0Vp5Qq
         c3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766530452; x=1767135252;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJM8Fvvm4JVu8q5tOpyLZwjaBbWHg/Q824d3a8dQF10=;
        b=T7H/n2JcKqLFWWxXG2n29VV8FbfmBJdUENoRNsrFyQHk6uymdtrq1MpTXcYkeinVvI
         aB3uqk7Dd9AZHEfJXVCP4YovMeF1JR+nVABp7d5d/enpHjs5daNbNnyTQTfpN860VtLk
         pyfEnaefI1fqAV6WIzFUFYpHZcVIqVfruvhAdA0YDAx0Ai7iiiHs24qGIuYSo3Y6xoJj
         OIKj1sHnmPsB1zANGKxC9Sg8PncwnGXjsdLRfRX5yVkhr2lPwh0NMLs9r7V8E/cw9xN1
         92lfifxL+5p5U++beuAhTupmAwgWbLJQ/qc7TF9nUj9Ael9QBYzZj04ceRfZkAXFWHTc
         wGgA==
X-Gm-Message-State: AOJu0YxY3gcgAjfn+45bZOpZLGr0G5+Ohn/AwA+5c/tO1/Kr4Xg9WyLw
	xfWlmJRxIH2iGzbqAc5ct2cXQJJRJVjs5AEv6txAnRrG4dOhD2YHrf4Itof7wuMq
X-Gm-Gg: AY/fxX42dVI77ZcAhYWpvR1WlqzDjDJuzXBlr2ISdYk+zqj2895nBDFVT60EtG+2B8g
	41bz3qfDPtV3xuxynqpUtZf5D1MAwc4BITTQwWitJUITv/dNJHAppZYQFlQ4UbeXLGX7IBYWirl
	heLo0dIe9PS9rhdq6ibEWxnaWHP+cvHzeG82lY6ORIeyRDNAxXw/A6i/Atr7gI6U++Hi/JT3LmC
	zjZK/zByH4udRZVPjGZ3P9dnBzzr+rGe9Rho2LhLiYpHd9DiR3MSOeZVAuCTqtxLZ2G3uzamGqJ
	6CD9qpTk+rPk0wsEemV0moieEnHe1c3DSBpXKWwSEts1DtWPdFOaOHOB756ZNKDxCRinG5vNeae
	25Azt7AzHjErVpU7sfQ1vO2oUmLqik5ReCqhW7kVuaEHaH3SQWJ4bRsO4lDLaUloYst61lEmm+1
	rwyD1FIy2Hh6K7gRwsy07t2XY=
X-Google-Smtp-Source: AGHT+IESj2YtQ8bSypKxb339CxiMDp5pvpRqo0LTGaggHKQN2e0S+PuRYcP+gp8j+BERHa86XVdeeQ==
X-Received: by 2002:a05:6a00:4c90:b0:7fb:e662:5c8 with SMTP id d2e1a72fcca58-7ff64ec2a93mr14087048b3a.30.1766530452189;
        Tue, 23 Dec 2025 14:54:12 -0800 (PST)
Received: from [127.0.0.1] ([52.160.166.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328aesm14754936b3a.5.2025.12.23.14.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 14:54:10 -0800 (PST)
Message-Id: <a3800aed18e576e42de273c9dae0e25bbe26ac6a.1766530448.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
	<pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Dec 2025 22:54:07 +0000
Subject: [PATCH v2 1/2] status: show comparison with upstream default branch
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
builds upon, to show "ahead" (i.e. you have built new history,
while others are not touching it), "behind" (i.e. you haven't
added any work since you were in-sync, while others have added
their work on the branch), "diverged" (i.e. you have commits
that you haven't pushed out, while others have added commits).

When you fork a branch 'feature' from the 'main' branch of the
remote, but then create 'feature' branch at the remote and push
there, while you still occasionally pull from or rebase onto
their 'main', you'd also want to know how much you have diverged
from 'main', in addition to how your 'feature' and their
'feature' compares. Currently the comparison with 'main' is not
given, making it hard to know when to start thinking about
rebasing onto the upstream default branch.

Show two sets of comparison: one with the tracking branch (as
before), and another with the upstream's default branch (what
their HEAD points to, typically 'main' or 'master'). The latter
comparison appears on a separate line after the tracking branch
status, using the same format:
- "Ahead of 'origin/main' by N commits" when purely ahead
- "Behind 'origin/main' by N commits" when purely behind
- "Diverged from 'origin/main' by N commits" when diverged

Example output when tracking a feature branch:
    On branch feature
    Your branch is ahead of 'origin/feature' by 2 commits.
      (use "git push" to publish your local commits)

    Ahead of 'origin/main' by 5 commits.

The upstream default branch is determined by checking symbolic refs:
1. refs/remotes/upstream/HEAD (if upstream remote exists)
2. refs/remotes/origin/HEAD (fallback)

This works with any default branch name (main, master, develop,
etc.) as long as the symbolic ref is configured. The comparison
is also shown when the branch is up-to-date with its tracking
branch but differs from the upstream default branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 | 104 +++++++++++++++++
 t/t6040-tracking-info.sh | 246 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 350 insertions(+)

diff --git a/remote.c b/remote.c
index 59b3715120..b2a1e980b1 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,6 +2237,98 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_default_remote_ref(char **full_ref_out)
+{
+	int flag;
+	const char *resolved;
+	static const char *remotes[] = { "upstream", "origin", NULL };
+	int i;
+
+	for (i = 0; remotes[i]; i++) {
+		struct strbuf head_ref = STRBUF_INIT;
+		strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remotes[i]);
+
+		resolved = refs_resolve_ref_unsafe(
+			get_main_ref_store(the_repository),
+			head_ref.buf,
+			RESOLVE_REF_READING,
+			NULL, &flag);
+
+		strbuf_release(&head_ref);
+
+		if (resolved && (flag & REF_ISSYMREF)) {
+			if (full_ref_out)
+				*full_ref_out = xstrdup(resolved);
+			return refs_shorten_unambiguous_ref(
+				get_main_ref_store(the_repository), resolved, 0);
+		}
+	}
+
+	return NULL;
+}
+
+static int is_default_remote_branch(const char *name)
+{
+	char *default_full = NULL;
+	char *default_short;
+	int result = 0;
+
+	default_short = get_default_remote_ref(&default_full);
+	if (!default_short)
+		return 0;
+
+	result = !strcmp(name, default_short);
+
+	free(default_short);
+	free(default_full);
+	return result;
+}
+
+static void format_default_branch_comparison(struct strbuf *sb,
+					     const char *branch_refname,
+					     enum ahead_behind_flags abf)
+{
+	int default_ours = 0, default_theirs = 0;
+	char *default_full = NULL;
+	char *default_short;
+
+	default_short = get_default_remote_ref(&default_full);
+	if (!default_short)
+		return;
+
+	if (stat_branch_pair(branch_refname, default_full,
+			     &default_ours, &default_theirs, abf) <= 0) {
+		free(default_short);
+		free(default_full);
+		return;
+	}
+
+	strbuf_addstr(sb, "\n");
+
+	if (default_ours > 0 && default_theirs == 0) {
+		strbuf_addf(sb,
+			Q_("Ahead of '%s' by %d commit.\n",
+			   "Ahead of '%s' by %d commits.\n",
+			   default_ours),
+			default_short, default_ours);
+	} else if (default_theirs > 0 && default_ours == 0) {
+		strbuf_addf(sb,
+			Q_("Behind '%s' by %d commit.\n",
+			   "Behind '%s' by %d commits.\n",
+			   default_theirs),
+			default_short, default_theirs);
+	} else if (default_ours > 0 && default_theirs > 0) {
+		strbuf_addf(sb,
+			Q_("Diverged from '%s' by %d commit.\n",
+			   "Diverged from '%s' by %d commits.\n",
+			   default_ours + default_theirs),
+			default_short, default_ours + default_theirs);
+	}
+
+	free(default_short);
+	free(default_full);
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2248,6 +2340,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	int show_default_branch_comparison;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2258,6 +2351,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
+
+	show_default_branch_comparison = !is_default_remote_branch(base);
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2269,6 +2365,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
 			base);
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
@@ -2285,6 +2383,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (!ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
@@ -2296,6 +2396,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
@@ -2310,6 +2412,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	}
 	free(base);
 	return 1;
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..e2bd48f858 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -21,6 +21,7 @@ test_expect_success setup '
 	git clone . test &&
 	(
 		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main &&
 		git checkout -b b1 origin &&
 		git reset --hard HEAD^ &&
 		advance d &&
@@ -292,4 +293,249 @@ test_expect_success '--set-upstream-to @{-1}' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for ahead of non-main tracking branch' '
+	(
+		cd test &&
+		git checkout -b feature origin/main &&
+		advance feature1 &&
+		git push origin feature &&
+		git checkout -b work --track origin/feature &&
+		advance work1 &&
+		advance work2
+	)
+'
+
+test_expect_success 'status shows ahead of both tracked branch and origin/main' '
+	(
+		cd test &&
+		git checkout work >/dev/null &&
+		git status --long -b | head -5
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Ahead of '\''origin/main'\'' by 3 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows ahead of both tracked branch and origin/main' '
+	(
+		cd test &&
+		git checkout main >/dev/null &&
+		git checkout work 2>&1 | grep -E "(Switched|Your branch|Ahead of)" | head -3
+	) >actual &&
+	cat >expect <<-\EOF &&
+Switched to branch '\''work'\''
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+Ahead of '\''origin/main'\'' by 3 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status tracking origin/main shows only main' '
+	(
+		cd test &&
+		git checkout b4 >/dev/null &&
+		git status --long -b
+	) >actual &&
+	test_grep "ahead of .origin/main. by 2 commits" actual &&
+	test_grep ! "Ahead of" actual
+'
+
+test_expect_success 'setup for ahead of tracked but diverged from main' '
+	(
+		cd test &&
+		git checkout origin/main &&
+		git checkout -b oldfeature &&
+		advance oldfeature1 &&
+		git push origin oldfeature &&
+		git checkout origin/main &&
+		advance main_newer &&
+		git push origin HEAD:main &&
+		git checkout -b work2 --track origin/oldfeature &&
+		advance work2_commit
+	)
+'
+
+test_expect_success 'status shows ahead of tracked and diverged from origin/main' '
+	(
+		cd test &&
+		git checkout work2 >/dev/null &&
+		git status --long -b | head -5
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work2
+Your branch is ahead of '\''origin/oldfeature'\'' by 1 commit.
+  (use "git push" to publish your local commits)
+
+Diverged from '\''origin/main'\'' by 3 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for diverged from tracked but behind main' '
+	(
+		cd test &&
+		git fetch origin &&
+		git checkout origin/main &&
+		git checkout -b work2b &&
+		git branch --set-upstream-to=origin/oldfeature &&
+		git checkout origin/main &&
+		advance main_extra &&
+		git push origin HEAD:main
+	)
+'
+
+test_expect_success 'status shows diverged from tracked and behind origin/main' '
+	(
+		cd test &&
+		git checkout work2b >/dev/null &&
+		git status --long -b | head -6
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work2b
+Your branch and '\''origin/oldfeature'\'' have diverged,
+and have 1 and 1 different commits each, respectively.
+  (use "git pull" if you want to integrate the remote branch with yours)
+
+Behind '\''origin/main'\'' by 1 commit.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for behind tracked but ahead of main' '
+	(
+		cd test &&
+		git fetch origin &&
+		git checkout origin/main &&
+		git checkout -b feature3 &&
+		advance feature3_1 &&
+		advance feature3_2 &&
+		advance feature3_3 &&
+		git push origin feature3 &&
+		git checkout -b work3 --track origin/feature3 &&
+		git reset --hard HEAD~2
+	)
+'
+
+test_expect_success 'status shows behind tracked and ahead of origin/main' '
+	(
+		cd test &&
+		git checkout work3 >/dev/null &&
+		git status --long -b | head -5
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work3
+Your branch is behind '\''origin/feature3'\'' by 2 commits, and can be fast-forwarded.
+  (use "git pull" to update your local branch)
+
+Ahead of '\''origin/main'\'' by 1 commit.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup upstream remote preference' '
+	(
+		cd test &&
+		git remote add upstream ../. &&
+		git fetch upstream &&
+		git symbolic-ref refs/remotes/upstream/HEAD refs/remotes/upstream/main
+	)
+'
+
+test_expect_success 'status prefers upstream remote over origin for comparison' '
+	(
+		cd test &&
+		git checkout work >/dev/null &&
+		git status --long -b | head -5
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Diverged from '\''upstream/main'\'' by 5 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for up to date with tracked but ahead of default' '
+	(
+		cd test &&
+		git checkout origin/feature &&
+		git checkout -b synced_feature --track origin/feature &&
+		git checkout origin/main &&
+		advance main_ahead &&
+		git push origin HEAD:main
+	)
+'
+
+test_expect_success 'status shows up to date with tracked but diverged from default' '
+	(
+		cd test &&
+		git checkout synced_feature >/dev/null &&
+		git status --long -b | head -4
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''upstream/main'\'' by 3 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for up to date with tracked but ahead of origin/main' '
+	(
+		cd test &&
+		git remote remove upstream &&
+		git checkout origin/feature &&
+		git checkout -b synced_feature2 --track origin/feature &&
+		git checkout origin/main &&
+		advance main_ahead2 &&
+		git push origin HEAD:main
+	)
+'
+
+test_expect_success 'status shows up to date with tracked but diverged from origin/main' '
+	(
+		cd test &&
+		git checkout synced_feature2 >/dev/null &&
+		git status --long -b | head -4
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature2
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for up to date with tracked but purely ahead of origin/main' '
+	(
+		cd test &&
+		git checkout origin/feature &&
+		git checkout -b synced_feature3 --track origin/feature
+	)
+'
+
+test_expect_success 'status shows up to date with tracked but shows default branch comparison' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git status --long -b | head -4
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

