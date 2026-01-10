Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37A29AAF7
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074984; cv=none; b=upoJQsCDUz/oIMjpO6QWvQ0wMB5X0CxyDp24cQrv6wSjaecx5LruzSY6gMupHKb4vzDVU/82+AxWZhX4UNsHy9jJyZ4+6UGK2H1cOQQx6+zzRbUp6cSB/zY+1x2ART5L46L+Cp8PuuKgawyyKsMd+wNdbvLz/K+4sD02hTJqEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074984; c=relaxed/simple;
	bh=OLjJr5+H+wOYZYRhOKgYcOs4oRCG2NQEhUgphmPZhLE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pHV0lLPeBn2SeVjcOkD204YL6sXmFBxHeA+VDdZvMgu6ZonzcGKtzqOD8Ng1d67PgGZoMPh0O+aJFb1eQZ3dGygr5ZY5T0iET6KQWpH9an7Z61gNeezzPB1QV8lsWhuD2DioySnPzpPnnLz3ywvN2CIZcUqZ/sRxY7DTWnGRtZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOhQxVRc; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOhQxVRc"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12056277571so6045523c88.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768074981; x=1768679781; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zRX+vrLqvL80uoAawgA9C6QfvC47kiFb3P52HYDU9Q=;
        b=cOhQxVRcj47lhQDYgJybrtNFA4m0w+VVjqMEnSTvOjF58RTNrQ35p5/ux1NM0ZdPr2
         nslGSFoMSooFcdeHXQs90KEjEPxbQtxaIEUlNT1rZNMPk5ZpTGyTHKPNpOrdoYFDs6y3
         AgqoEZqVqJgJix7cz5Ss3ZV0YnfLEo+xHPxzapOY9KrE0ZfRjMyD2T6v66L91iwtpGpd
         1/mwVysvxBDxslxtcrSvydAtQ+hCM2vkDK1sPGE9vXQ30aEQqfDut9aIDeWzyTtG45au
         sDck9YB0V2zOCce6OuP4puwf4xP+Qmkdphnjn012kVSeaWUkh/fkla35c93rsrk98WJK
         UJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768074981; x=1768679781;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zRX+vrLqvL80uoAawgA9C6QfvC47kiFb3P52HYDU9Q=;
        b=WI8e/7iHaM9TMhlq9E//ybJ/CxkuA/MhffM8NKfGm8ZERwfNyrU78WW2+UthvttLen
         dL3JegQd8IzqVNyPQuthPtHuFHlJx/fDRqy2a5S1p5pE15hFPKqk3Qt+OUfnh25Oda5K
         ikY2Ep/nQCqN1kxab3kHSUeccsYtzBjM7HC5q1K3gzvIxGA0mmGlvdn/bZt3dHRTZES5
         1c2je5rmGDMyf1USEroRyF4QBqY/HmVa2YOEXf6xPxIogJYT/+AaGlHnp8X9p1ENLSqy
         SQ0qDdzHe5Z+/GvqCDhmrvlEIQY8SsAwHSALDrC0//obJH+jAktY3K1ZRt+d4kswWRKh
         FDow==
X-Gm-Message-State: AOJu0Yzh2Whg2QSXsp3Kwoq0wmtiDzuG2vW5fOstK0bCcfM7nbEMwpga
	PcJNqR47YRaOsBT9+lye4KJBxZ5WYa8bukFMK33AHL6Zqlvt5AkktXma5JFKJA==
X-Gm-Gg: AY/fxX6jkyws2McsKRmdgs8zzrgApVxOwnVNwZlSV+CPR41/rX6Pi9nCl4hp945VBaU
	8/1cTttf8kadptaYCAwSIojyKjjCXbtDS2QnED9mQiAXgoDILcoxs8clvryNaP0d+8iRalzMYQj
	KnVkHsl+8429P+FtJnEu+7vIcIrqvFSPp7MXR/lYZmLiB/Jjn+MumeLefN3RYXzwOa8TWQdRtRd
	6CICLFXBjuYGLttu+w1Vz3ErR3d40oWBUcOlMU62H5KLO+EMNGjvNrjD9fsmJg8SzJP0QgYga+V
	4r+dmSJzwDvyzd2X9PF5HOU6ohOZ3tD6ceyR3T3+ilZgVjkVNSctRbhyHoMEMPMIgeo0k8JQ7EE
	Xtt38lsPpxL6hJ8jgnFfPlC9yVXj9/rswrIiUM2Su9Z7kuo/QooznydMg+gjEz2BPDGzagrZ012
	5xcSA51SJQxOS3oxE=
X-Google-Smtp-Source: AGHT+IHlqFtBrZdeqvWQNNilXPQk1qF+FW2wtXyIsNIyuGixAb9IlB+mwaGV7vkAP8tBYyppKInO5g==
X-Received: by 2002:a05:7022:613:b0:11b:9386:826c with SMTP id a92af1059eb24-121f8b8ba61mr14186928c88.41.1768074980660;
        Sat, 10 Jan 2026 11:56:20 -0800 (PST)
Received: from [127.0.0.1] ([172.215.216.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f2434abesm20222306c88.4.2026.01.10.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 11:56:20 -0800 (PST)
Message-Id: <b7e29887d99ad1f41f32cc39b65e011c01854e21.1768074976.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v22.git.git.1768074976.gitgitgadget@gmail.com>
References: <pull.2138.v21.git.git.1768058653.gitgitgadget@gmail.com>
	<pull.2138.v22.git.git.1768074976.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 19:56:16 +0000
Subject: [PATCH v22 2/2] status: show comparison with push remote tracking
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
 remote.c                 | 102 ++++++++++++++-
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 358 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index d5a6486026..f9aa4c61bc 100644
--- a/remote.c
+++ b/remote.c
@@ -29,6 +29,11 @@
 
 enum map_direction { FROM_SRC, FROM_DST };
 
+enum {
+	BRANCH_MODE_PULL = (1 << 0),
+	BRANCH_MODE_PUSH = (1 << 1),
+};
+
 struct counted_string {
 	size_t len;
 	const char *s;
@@ -2237,13 +2242,75 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
+{
+	struct remote *remote;
+	const char *push_remote;
+	char *push_dst = NULL;
+	char *tracking_ref;
+	const char *resolved;
+	char *ret;
+
+	if (!branch)
+		return NULL;
+
+	push_remote = pushremote_for_branch(branch, NULL);
+	if (!push_remote)
+		return NULL;
+
+	remote = remotes_remote_get(the_repository, push_remote);
+	if (!remote)
+		return NULL;
+
+	push_dst = remote_ref_for_branch(branch, 1);
+	if (!push_dst) {
+		if (remote->push.nr)
+			return NULL;
+		push_dst = xstrdup(branch->refname);
+	}
+
+	tracking_ref = (char *)tracking_for_push_dest(remote, push_dst, NULL);
+	free(push_dst);
+
+	if (!tracking_ref)
+		return NULL;
+
+	resolved = refs_resolve_ref_unsafe(
+		get_main_ref_store(the_repository),
+		tracking_ref,
+		RESOLVE_REF_READING,
+		NULL, NULL);
+
+	if (!resolved) {
+		free(tracking_ref);
+		return NULL;
+	}
+
+	if (full_ref_out)
+		*full_ref_out = xstrdup(resolved);
+
+	ret = refs_shorten_unambiguous_ref(
+		get_main_ref_store(the_repository), resolved, 0);
+	free(tracking_ref);
+	return ret;
+}
+
 static void format_branch_comparison(struct strbuf *sb,
 				     bool up_to_date,
 				     int ours, int theirs,
 				     const char *branch_name,
 				     enum ahead_behind_flags abf,
+				     unsigned flags,
 				     bool show_divergence_advice)
 {
+	bool want_push_advice = (flags & BRANCH_MODE_PUSH) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+	bool want_pull_advice = (flags & BRANCH_MODE_PULL) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+	bool want_divergence_advice = (flags & BRANCH_MODE_PULL) &&
+		show_divergence_advice &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+
 	if (up_to_date) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
@@ -2252,7 +2319,7 @@ static void format_branch_comparison(struct strbuf *sb,
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
 			    branch_name);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (want_push_advice)
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
 	} else if (!theirs) {
@@ -2261,7 +2328,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (want_push_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2272,7 +2339,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (want_pull_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2285,8 +2352,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
-		    advice_enabled(ADVICE_STATUS_HINTS))
+		if (want_divergence_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
@@ -2303,6 +2369,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	unsigned base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;
+	int push_ours, push_theirs, push_cmp_fetch;
+	char *full_push = NULL;
+	char *push = NULL;
+	unsigned push_branch_modes = 0;
 
 	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (cmp_fetch < 0) {
@@ -2314,6 +2385,16 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
+	push = get_remote_push_branch(branch, &full_push);
+	if (push && strcmp(base, push)) {
+		push_cmp_fetch = stat_branch_pair(branch->refname, full_push,
+					   &push_ours, &push_theirs, abf);
+		if (push_cmp_fetch >= 0) {
+			base_branch_modes = BRANCH_MODE_PULL;
+			push_branch_modes = BRANCH_MODE_PUSH;
+		}
+	}
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2322,10 +2403,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else {
-		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
+		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf,
+					 base_branch_modes, show_divergence_advice);
+	}
+
+	if (push_branch_modes & BRANCH_MODE_PUSH) {
+		strbuf_addstr(sb, "\n");
+		format_branch_comparison(sb, !push_cmp_fetch, push_ours, push_theirs, push, abf,
+					 push_branch_modes, show_divergence_advice);
 	}
 
 	free(base);
+	free(full_push);
+	free(push);
 	return 1;
 }
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..cf5a926dcd 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,266 @@ test_expect_success '--set-upstream-to @{-1}' '
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
+test_expect_success 'status --no-ahead-behind tracking origin/main shows only main' '
+	(
+		cd test &&
+		git checkout b4 &&
+		git status --no-ahead-behind >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch b4
+	Your branch and ${SQ}origin/main${SQ} refer to different commits.
+	  (use "git status --ahead-behind" for details)
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
+test_expect_success 'status --no-ahead-behind shows diverged from origin/main and ahead of feature branch' '
+	(
+		cd test &&
+		git checkout feature4 &&
+		git status --no-ahead-behind >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature4
+	Your branch and ${SQ}origin/main${SQ} refer to different commits.
+
+	Your branch and ${SQ}origin/feature4${SQ} refer to different commits.
+	  (use "git status --ahead-behind" for details)
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
+test_expect_success 'status --no-ahead-behind with upstream remote and push branch up to date' '
+	(
+		cd test &&
+		git checkout feature7 &&
+		git push origin &&
+		git status --no-ahead-behind >../actual
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
+test_expect_success 'status shows remapped push refspec' '
+	(
+		cd test &&
+		git checkout -b feature8 origin/main &&
+		git config remote.origin.push refs/heads/feature8:refs/heads/remapped &&
+		git push &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature8
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status shows remapped push refspec with upstream remote' '
+	(
+		cd test &&
+		git checkout -b feature9 upstream/main &&
+		git config remote.origin.push refs/heads/feature9:refs/heads/remapped &&
+		git push origin &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature9
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
