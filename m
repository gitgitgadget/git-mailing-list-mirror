Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4861C701F
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445243; cv=none; b=rSxacVGrZ1OZ3Ek0rOnCnOlUDpB2zmewQSIalP22txj6NDhW+0x+Rpk/DZwPvnTxsg8lptcjzq8PdIJYXc+JKfA0DQHailUldqSUPS1u/tNi7AvJokWkflZbncrPR9H4k/Q80IWHSi7yX29ghuucFJ4mrkZ6luHnIrOJaEZzaiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445243; c=relaxed/simple;
	bh=3kdWwoDELGj/CiP3pXCIo4JSRD3gwW5U4793vp9rOCM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NZi8ZTFBvRp6gckA2j1HJClQEnvdDX4eIvGWbmraxftdVKKen3COpTp6oajs7suY0QdeChMKjN+jgNC3ug9/nAMQcNOXOghSHHNtuRQyddIlPuDxNm7y7oBbNSnyLGQUqszA4lBS7x7omRtd+EkziMAxvTVaPJFsD6gbJE+q3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYEgs7H9; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYEgs7H9"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8bb6a27d407so1260447285a.0
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 05:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445240; x=1768050040; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRz46F7SJkSjAg1FBsJi5zpx5OQsWQUPPq/mouHI5qw=;
        b=nYEgs7H9FL/rrgjeI55448G3AwGceFqc+4N/dkQsABzDPg0/qH729Ocm5BxXvujKZJ
         iIdUfiii+hQUZ59hi9WrDUVxKfWuz3IAT/hsAAL0/Ia5gU2LTVse2UqIG37TkSRxjLsc
         9fv/HGExbOZq/p7X/DaZozdFn7xzU9gOG81JobawwkFLTs115gZXO11jYtFrIjgVlyOx
         JRkNfYK6kfewBlafrmXOq1kWYdGH758CYiggsQj2ylIaWNzgBQbki3Oizx7+mXemAQln
         IVwwMxtWPAOvaLsI41bqXL2JoOTl2hhJ7ypUE4aLLEFRV8UcBdcws6fqcghM1BccaCzb
         zVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445240; x=1768050040;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YRz46F7SJkSjAg1FBsJi5zpx5OQsWQUPPq/mouHI5qw=;
        b=IPhVniqN1crUSVT0F3WaQBSOU+S0CgdHXimIudrMlHFhu//gwR8DTCdyhC74Hxp/W0
         RtRphr8vyxCyGY00AlLkQvsgLnQhD6CqL61tXJ9xsDtbIOM+xJw07kKtX0y7wO1T3hQ4
         k9vbjufKvK6u8ujgkpcgmjkv6MHyj0itF9Rfn7LHhf36QXFHlprJXr1z90Fj/VT2pC9F
         I2PYFD9Hil2T2AVfKUr96tx3s5CzmHrsQUEDk3HXMz97rP3arbDNr4NOBFrWqfNPtVA0
         Kembw4G1HDwWbn+YrJHk3b5gGw00zf0hqstvvTNz+H2KyUrlFzVaf26eOMtwQgWXU0pT
         wPSQ==
X-Gm-Message-State: AOJu0YyeTjAH//82x6piIwgqm6Hbh55gMrAQ27fxmIfCkmyuWIHBECJz
	NfXaoNLaiu5NPnjjoHQca/ZRwzA+QBnUc0tUDW679krCy5tpfmfbn3r1fttnbQ==
X-Gm-Gg: AY/fxX7qS53K4K6BSkVI+7w70SVVnljPRScqXNqqCgHa5lfJuVQxqR58r8GdFut9/HV
	SijH18q3UyyQ9ykBpVlRrkSRhktDTZP6UZWUmPQ+EtAcqR+TZKMiC30oBwghcTuQIvAluTyHbqh
	6omub8+D1WVxYQH4vAde+XJh+4rur3ABtnMZuGNIWotio+B6wkUH4VWJNUlgkx96zDhR0+88WEd
	N6WIFF9xb9Ag7IbYippiD+Y+auTJ3LkOj9KFRG3vcsu9lHZFHQze2kGBKbz8USqzVlha9E/UB85
	m2Xf7Ik2t3TXq5AnXDRMxQd5tJqmbBuygbIDAgTr4N1+bqRB80I/BgiK4124aqFhn0Kx69bHX+5
	HNbyWDvcK4eaCPfE8RC3bCLystOxPSy9vTXJ/220KmCucIxwNlwPwxC8R+qwVeh+BJwD1uIBn0C
	vdHp6hPd0eKBoH
X-Google-Smtp-Source: AGHT+IErdqP/v1jFM+rLNuQFQ4fJkvjp6KDPs6YYU8agrugLTXTOkqPyaCyK2KwDavqWQVcVOlKAjA==
X-Received: by 2002:a05:620a:190d:b0:8b2:745c:f770 with SMTP id af79cd13be357-8c09001f026mr7257539985a.77.1767445239370;
        Sat, 03 Jan 2026 05:00:39 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5c18sm3365886185a.34.2026.01.03.05.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:00:38 -0800 (PST)
Message-Id: <b9b2f154982c216a3f19d567be97185196723350.1767445236.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
References: <pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
	<pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Jan 2026 13:00:36 +0000
Subject: [PATCH v14 2/2] status: show comparison with push remote tracking
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
 remote.c                 |  80 ++++++++++++++-
 t/t6040-tracking-info.sh | 210 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 289 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 58093f64b0..f5d690d377 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,6 +2237,58 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
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
+	ret = refs_shorten_unambiguous_ref(
+		get_main_ref_store(the_repository), resolved, 0);
+	free(tracking_ref);
+	return ret;
+}
+
 static void format_branch_comparison(struct strbuf *sb,
 				     int ahead, int behind,
 				     const char *branch_name,
@@ -2304,6 +2356,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	int push_ours, push_theirs, push_sti;
+	char *full_push = NULL;
+	char *push = NULL;
+	int show_push_comparison = 0;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2315,9 +2371,18 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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
@@ -2330,7 +2395,20 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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
index 0b719bbae6..68f298bf3a 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,214 @@ test_expect_success '--set-upstream-to @{-1}' '
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
