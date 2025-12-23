Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153E176ADE
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766451221; cv=none; b=pklpzGhJqUoxnhrqBVAvSDwjERuDj40DWeEUC2HOoGaa+UtesVsSE5d1PEHkQZsuh5zhuRc5+Vz1n3b9jSMVJD6eWLJqii4CD3+CfXV0MgY+jKtDyqewPAB2KfvHVao4iX90c46vrR+AsY/8c3xA1ZdX31f0lUdNt9urSKLtB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766451221; c=relaxed/simple;
	bh=877SPCfZenY8Y2Q/CXTr3aAfhbTeHpHk8Omq+tmI4I4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dd5FCisPlnVYtausblCgsUgaO02ZfxqBIFQBpnUCOYkznhJgALZVaCHfvyW7q4UgyL+c4QA4uPb+ntuJifW2g3J6yKR4i8Gz0hYjbVNaaJFP66gIlXIXHlJzc6jGvsQiaTzlD5u+ZltkAlW5Py67TDljPWfq9QLg28TIYHOFBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgr+N2ws; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgr+N2ws"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eda057f3c0so49410981cf.2
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 16:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766451218; x=1767056018; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ciXp1tWPBX7se97azmITM73Ny1DdaHcHiAKEVQ1ydwo=;
        b=Vgr+N2wsVQ6OFGlIpaf4vHo/68M9Uphc7Z66Xf9/24RY4g6/BSj7MLGDeYcSxfun7v
         dSicQXLO+WCu3bwYzev6j2L4K0QGOd77huKSmY5jo6PRZyWs6pCUl+eo4gvNASVCTtV2
         BELpSNmRVINo/THTYi2/Kh49Dk6uaGijJquo7JJg9sT1ganKkwwktSKJ9BXcpe1gtXrH
         PgrCPxNfiJAWN34xGsb/7WXRVF96lG0smjaHyJhwWlfSXWt8UVYsCrW5x+uH6xhZh9+o
         wuS7K7w2oBQAgLJ+V5ADpJ0LHiSfQQdK5tXLFpEg8K9Naxf8FkCrijvzF5A2Kkq8ZCz0
         xoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766451218; x=1767056018;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciXp1tWPBX7se97azmITM73Ny1DdaHcHiAKEVQ1ydwo=;
        b=Wo16MO3Kmw0fwZOCDpvQOsFkc9jsYlRtIMo/qzN8TwX3lTbtSAQMYl4esarv5RkD/O
         wQ58L5EWuwbksDoA+sez7xiIT0UpsuUDpQz29b9C9FFSf4A1j+Uq8458My9NmoBZ1FE4
         +IsxSfuEwlibAyioMO+kS85nAQtD4ZP7G4PmGWeGechG4NQHB7Ck4WzIUzjSC+srnwZl
         z2Sa8eOPbJ025Hr8N5JBpNtwV4NQq2e9ChdFWLypl/Y9loYAiE4PE9vTJZ0YyS+Hg/j5
         ecjholarBQcNJ2+CQOUp92PdUbYuTIkjB92JAlq8iRcyHoo744c85bnY6U4gClSaFbgV
         wAyg==
X-Gm-Message-State: AOJu0Yzq8chVfTwi1RmOYYUrOlbBY5FrOueEYnC4b463SJ54IRRavWNE
	jwq0ZTxiBzmjjgovtii/wTCW6AUcp4mShYNl0Zzjwtcc8baiBz3tpLelSnl5Ibk2
X-Gm-Gg: AY/fxX4fhzZFSstFdSesY0ky5i7jRV7HTz6oyGhM8594JV7hEjb8R2oleFlPoYrciQi
	Wn1MSoI4eMS5xiKXWGp2zeN9ntLA/FYz/K03vxxP/ZwsJfbvUTBLf/RvYN6PcCje59ZyBHivx/r
	Cy9VB9ouAO0B6eUp5qeof+MEo8cMOcgk9fMtMUSYeGx4aisbxX7GHoRbEuA/M0fgR+9lYf9s8Yc
	XG9PY/hNyvfbLmoRvh5IEkUUAUO04YQpshgNDFQwq7IsoOdfaGqXOo7l0UrAi72WxrEnIFFuhT/
	cgicAWAQ3kSLoU5NkD+0OMKLm1nNBtTXeHBmmqUbLwmNRz447yLuGCDI4/Qc99LK6v1lU/eG5mq
	PFBL7h1VUai1sMrRgaxb5b2BbApqwKrpQXWzWwZlY12/F9yZPCzBWLUh3xHsJATk6ZTbLvs0hzP
	7Dysjl8e2geKCHXA==
X-Google-Smtp-Source: AGHT+IHenrPlo444k8FBMEH+3RBepS+nMRdaJ8WgwxkZ6qweUXFniNSIjjt/nCSYtDV2d/j+MaQ/tA==
X-Received: by 2002:ac8:5a15:0:b0:4ee:1f09:4c35 with SMTP id d75a77b69052e-4f4abd79a40mr192216991cf.52.1766451217962;
        Mon, 22 Dec 2025 16:53:37 -0800 (PST)
Received: from [127.0.0.1] ([172.178.119.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac62f59csm85649561cf.20.2025.12.22.16.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:53:37 -0800 (PST)
Message-Id: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Dec 2025 00:53:37 +0000
Subject: [PATCH] status: show default branch comparison when tracking
 non-default branch
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

When a branch tracks a non-default remote branch (e.g.,
origin/feature), git status now also displays how the branch
compares to the default branch (origin/main or upstream/main).
This helps users understand if their branch has drifted from the
main development line even when it's in sync with its tracking
branch.

The comparison is shown as a separate line after the tracking
branch status:
- "Ahead of 'origin/main' by N commits" when purely ahead
- "Behind 'origin/main' by N commits" when purely behind
- "Diverged from 'origin/main' by N commits" when diverged

Example output when tracking a feature branch:

    On branch feature
    Your branch is ahead of 'origin/feature' by 2 commits.
      (use "git push" to publish your local commits)

    Ahead of 'origin/main' by 5 commits.

The default branch is determined dynamically by checking:
1. refs/remotes/upstream/HEAD (if upstream remote exists)
2. refs/remotes/origin/HEAD (fallback)

This works with any default branch name (main, master, develop,
etc.) as long as the symbolic ref is configured. The comparison
is also shown when the branch is up-to-date with its tracking
branch but differs from the default branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    status: show default branch comparison when tracking non-default branch
    
    When a branch tracks a non-default remote branch (e.g., origin/feature),
    git status now also displays how the branch compares to the default
    branch (origin/main or upstream/main). This helps users understand if
    their branch has drifted from the main development line even when it's
    in sync with its tracking branch.
    
    The comparison is shown as a separate line after the tracking branch
    status:
    
     * "Ahead of 'origin/main' by N commits" when purely ahead
     * "Behind 'origin/main' by N commits" when purely behind
     * "Diverged from 'origin/main' by N commits" when diverged
    
    The default branch is determined dynamically by checking:
    
     1. refs/remotes/upstream/HEAD (if upstream remote exists)
     2. refs/remotes/origin/HEAD (fallback)
    
    This works with any default branch name (main, master, develop, etc.) as
    long as the symbolic ref is configured. The comparison is also shown
    when the branch is up-to-date with its tracking branch but differs from
    the default branch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v1
Pull-Request: https://github.com/git/git/pull/2138

 remote.c                 | 101 ++++++++++++++++
 t/t6040-tracking-info.sh | 246 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 347 insertions(+)

diff --git a/remote.c b/remote.c
index 59b3715120..9be5e5aa22 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,6 +2237,95 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static const char *get_default_remote_ref(char **full_ref_out)
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
+	const char *default_short;
+	int result = 0;
+
+	default_short = get_default_remote_ref(&default_full);
+	if (!default_short)
+		return 0;
+
+	result = !strcmp(name, default_short);
+
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
+	const char *default_short;
+
+	default_short = get_default_remote_ref(&default_full);
+	if (!default_short)
+		return;
+
+	if (stat_branch_pair(branch_refname, default_full,
+			     &default_ours, &default_theirs, abf) <= 0) {
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
+	free(default_full);
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2248,6 +2337,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	int show_default_branch_comparison;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2258,6 +2348,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
+
+	show_default_branch_comparison = !is_default_remote_branch(base);
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2269,6 +2362,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
 			base);
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
@@ -2285,6 +2380,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (!ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
@@ -2296,6 +2393,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
@@ -2310,6 +2409,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
