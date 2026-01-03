Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47220CCDC
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767409713; cv=none; b=ocI/eTyQimiO1Ea8xo7bQ1/w4cZiGwdkh8pbQ6cqmVnc1uyxwPRgEWzWe31nhyQRbrDt7uHlFyzTUsDDCmhYZnzjRgO5+QEmF0aG2NjapkUmzNwFWE39VSQTiPQ0wfJmYUSO/gUtG5iczcFDrHF/p38c2GWMl2Pblc59BJKznA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767409713; c=relaxed/simple;
	bh=cQ2OBBcAGtSy1otnk7bwGPUORZprUPCJC+lGy1prjrU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B60lnGkj1hMgYYWGYtf6QgutYS6a0cmeq67uPBp9M02GRgBwOX3E6Q0ZI8YG9PeviRIkZuuUNWwMIrK1fDl4vq7X+BwfRm/zAazzYNWXmqUV8IkQCFBZDpK7aTf4VT/nNXFyGrN1VJgXyF8svYwa07EA6DWW3zmiWduinI0dtfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbencOzL; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbencOzL"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45090ef26c6so3360457b6e.2
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 19:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767409709; x=1768014509; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnPYSR7nzvLUKXcMS57IlouK7IPW8ZLrv454d5W/nao=;
        b=SbencOzLV0A0O85Jy+abC7puJWNjszFJniOlSHaA60vDXtdcThAZQ2IP1EhWNa9Hiw
         mdEBx5ChIwtcf7xZXkVn0zLu8CfgkWbNSW1PqcnDl6xUknKB8NaHqBUOD7h0QZtL9R22
         exbKP2JAq6WrU2iXWGS0A7Qv2+sV5yVyz0+SNCaN3dVBm1bRcRwkC6aGBRVCz7VNoGwt
         EbHIREQBp0OlwlXNsRg+HXJYoBpqW+AkaH6vP1xCy/nlAq7NOshhsPeYb7UIap4yQlgJ
         T4tXy8ZUlUANT9xSJD1FXJeTGRSftEH2hwCxBK6Jgr/vLfnRRaUS2jaCWiELKrKLmvCk
         z9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767409709; x=1768014509;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnPYSR7nzvLUKXcMS57IlouK7IPW8ZLrv454d5W/nao=;
        b=MLENtZdKG1gosqGnIebo5iExUXv5qjWzLBpx3AiN2+avmap+RzLTqc58Afy74/Uewp
         vgw5gbAeOQX3DgHV9rxuCOTy0mvFkNbdOwQZCFriSanS4U5ZPxz4m2lk684pTOOpQuam
         n5IPqWhGfKfBqMsFU3ww0Clc4AsTXzKOpUmxji5c84/Aq8OGh54JpHARR1iclKbS/cOU
         Z/nsh96Z25bbp1qDquid1rHTaFynwi53rtmzhCZ9cZ0FuQfGQ1th5lUDTzwKZJ5cNoZo
         9CgoxaccnVh3K6o5HVXfiFbGLNCoLZvx9aPOamU+u5o61utDqtDnACG+UWSWO5KcEiBy
         SG2w==
X-Gm-Message-State: AOJu0YzkEwyMmPbjgOOaF2i3+w4+/Xxyi3sctiWmjkrPgidPLcNMU7YQ
	WP/19Vvep9aXeCMaHp7Ed+WIHbn8ac/XJSmIY8/DRxQt1g4pW5AQRYfYRsJDJAoQ
X-Gm-Gg: AY/fxX57kBqXRee7+jFRHPu3KEs4JxGBhPe6ozztS5rE9zDwGddGPmwfABNWLJ8QsiW
	p7UJXy/9WMn4QctA6IchzAAlP7YMiQRjJB4XRTcCsjT37d6yHlh6RGMdWhOjOhC8aiF/5hdLKaD
	3yjeMIf37U58N7YjjSMuorV8vDy+7neyDom1AjOdXLIvA4uLe+JLkC+zC9hk65coeEZX45VQE9R
	PFcPIB/JE7tJ+vPSkOvUSmucUPxIla+17FmCdd4h/l4PGvIt1iAu8Lb4vvslVrKWIoeGpW9AB04
	Ci0HOAZ1r+hbj2B/yn0UICE7EkARI4P1fFlt55/o1Z9gBh9dJQGOotn5yAkBB/vTCq4TSHiBQJg
	Hd2hy2R777t5ovszATfTuhr2svJYYSACPtMjUlXSa0hWuJEIWrZuR10vL+tzgSwga9aHQiRKyHr
	VMrWDZG8b9d58Wog==
X-Google-Smtp-Source: AGHT+IHe2LBUsKCNLT5p4eO+E+KmauPWalFLa7nmYfQiRjD2epxLM5ZDUwdMLCwTLg4c3EfTA/do+A==
X-Received: by 2002:a05:6808:6199:b0:459:993c:6f1c with SMTP id 5614622812f47-459993c7236mr10143486b6e.31.1767409709320;
        Fri, 02 Jan 2026 19:08:29 -0800 (PST)
Received: from [127.0.0.1] ([52.165.213.178])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-459d35531a2sm8018350b6e.14.2026.01.02.19.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 19:08:28 -0800 (PST)
Message-Id: <891239211e8bd59c46d5ee4b0d024467f02597d4.1767409701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
References: <pull.2138.v12.git.git.1767389649.gitgitgadget@gmail.com>
	<pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Jan 2026 03:08:21 +0000
Subject: [PATCH v13 2/2] status: show comparison with push remote tracking
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
 remote.c                 |  61 +++++++++++++-
 t/t6040-tracking-info.sh | 168 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 58093f64b0..c90441fe42 100644
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
@@ -2304,6 +2337,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	int push_ours, push_theirs, push_sti;
+	char *full_push = NULL;
+	char *push = NULL;
+	int show_push_comparison = 0;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2315,9 +2352,18 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
+	push = get_remote_push_branch(branch, &full_push);
+	if (push && strcmp(base, push)) {
+		push_sti = stat_branch_pair(branch->refname, full_push,
+					   &push_ours, &push_theirs, abf);
+		if (push_sti >= 0)
+			show_push_comparison = 1;
+	}
+
 	format_branch_comparison(sb, ours, theirs, base, upstream_is_gone, abf, sti);
 	if (sti > 0 && abf != AHEAD_BEHIND_QUICK) {
-		if (!theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
+		if (!theirs && !show_push_comparison &&
+		    advice_enabled(ADVICE_STATUS_HINTS)) {
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 		} else if (!ours && advice_enabled(ADVICE_STATUS_HINTS)) {
@@ -2330,7 +2376,20 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		}
 	}
 
+	if (show_push_comparison) {
+		strbuf_addstr(sb, "\n");
+		format_branch_comparison(sb, push_ours, push_theirs, push, 0, abf, push_sti);
+		if (push_sti > 0 && abf != AHEAD_BEHIND_QUICK) {
+			if (!push_theirs && advice_enabled(ADVICE_STATUS_HINTS)) {
+				strbuf_addstr(sb,
+					_("  (use \"git push\" to publish your local commits)\n"));
+			}
+		}
+	}
+
 	free(base);
+	free(full_push);
+	free(push);
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
