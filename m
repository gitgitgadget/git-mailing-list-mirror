Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181138E5F2
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306324; cv=none; b=TLi9wSyKMcKo9G42vZL+j4Wrd2y7tAVb0XoPCgLoCgxOc3CKzDCuMt1nzWjqbzTvm9IdyehLF1rjjZTqI7J/7ZXgmaycQV5z7O+I0ki9Ud5S2ZncWgnSlCRDHKpKBRXqY6PtD4IpFrbLbOc+uHQLy4E55OlFTt9CCckZJTWiCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306324; c=relaxed/simple;
	bh=E4ArZw2I2h4YKXE/X5RZPe57v8mFrfYYa8CP0ZUGvCs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Dwv4rjWhuj5xAATArumpUbIE/kzjFGSE+Z7Z08R/RW0SEdT0Jo8oZpUsRx1uWrm5zipjBroag83DIoVtCpGCr+j7J4rqS28Dy60i4mHZI5fZVQ7xUrkrZuqr5jiDqTGNr4aI9f7nnKHE2h575vxJr5CMcnGRXMUtAjpTv865hR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOBgh245; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOBgh245"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-890228ed342so78456636d6.2
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 04:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306321; x=1768911121; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebzHnoxAYR74U6DtIRdmCsdKy2ai2ecLod9T174ItyA=;
        b=VOBgh245FC/PPf6RzktUFU8epF7IlhJxk9PlN2RkwE7Qs9XURMILxRRdieu3GkscJm
         5kRW09ByTSykIzEyAnhyx0iZxE/CP4fcf2+9wjKIurS5KG1/wlJcatCdiu8jAr7jhgvU
         5kL8F/kWKY8gJE/ocO96yY/r1PngJ/8kwVoS37uF/99Mzwob2r1mSrLdPaIaPl0Ri6mN
         Kew9adC5wOFIPl4RZZps/OXQ3HDvAic1Ey4tbwMyYGz7oRN57DnwrcDiNqxjQXxeWlUP
         O3W1qAPKU5rc+lUBjlsmaSBX18FHoJ5682txLVAUj6E5RY+snAYcCDQivPFMhZzAh8W6
         QAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306321; x=1768911121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ebzHnoxAYR74U6DtIRdmCsdKy2ai2ecLod9T174ItyA=;
        b=DBhbfp7LInhur3R3zic70LehaRjMXaBTk3GChtY19qPvV8VY+lu3GDbOqBvYo9E0LQ
         JpPNN28ma/UD/CCmpHQtyJFNxtXdi7KaUijhfw6Q2LN3juUNhRGYIcdaNqVNPQB0MH2v
         n6LgUxglJBsTlcKum8uujtjfeS8SRX+pPtMlG6MhYYBdGvH9wAls7q8U0IiMcSE8OmKE
         3BCfgh8rK/C1UUdu7/zga8xho8Ue2wgy9lBYLByC65Pc7aomhbdieb+Ygd2zFM+GjAC4
         BirYNjSv9d6gUhfi61BWYjFKBuGrvu1G2GlmgJvzLZXfEaW9ZRgQy/DVGT3GoT3aBmMF
         tOrA==
X-Gm-Message-State: AOJu0Yw17kIPuL502ipg/0XKdphUQQTzJG5DZ6oZm1iE0O8ylG2OwJGv
	qdAC6j032ImGaVTovNB/D7UFFa145/qDvh7paoBqXzo6a5BL6V6wN1RVyLK0/Q==
X-Gm-Gg: AY/fxX5PUsrPoAwIkwJTLOYe2QOuxbi5i66zp9Pjs/S83rXIe74S8iVvpV8NgJ4p7EY
	0j6HDw4JoEyv138bWicW7FDQbYqp/eRxTKhvYC1U6sr/aTp01gUr3VMmrRhuPNFiuF6CD22DBP1
	cSdzVGOIDKbwRiQ8wthYcaLUFHDlugqAnYg12xZoZdizdK8M0xOPld6cvDG6/9F5wiF7G8dk7wq
	1eCPknjtRp0ZzZGa9xVePVCqH35LSO+euIRf/LdTCgA3CwlVk8Zs5Y6Np9dm0w4Pu5mxMj9GDNo
	gly4aMv9/Vxu3WUFNZHiqlTkVSe0IaZ7lVF0jUJyjdB+AUAvJ1zWR7XhHRq0U4QxHGQEh16MWMN
	1EIn3NiN1n5bEFvsIV2/ep8bLefnAR51TQM4ghscozLCgoF38IQ5V0t0O43P+/vh7LcypEXpuwF
	0in9bfZsyJl6MDJQ==
X-Google-Smtp-Source: AGHT+IHEOJuE3cgZRlJIiJHJEtUCupriGbEfNCWJnqYYGndEQO2BmRWHgDkpTskDPlOYVpFdtGWDtw==
X-Received: by 2002:a05:6214:5b01:b0:87f:b58f:154f with SMTP id 6a1803df08f44-890842f0eb8mr285821536d6.50.1768306320604;
        Tue, 13 Jan 2026 04:12:00 -0800 (PST)
Received: from [127.0.0.1] ([64.236.142.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077267b9esm166284436d6.48.2026.01.13.04.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:12:00 -0800 (PST)
Message-Id: <fa744efc598cd902e9a3a4a17b24134351ca5803.1768306316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
References: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
	<pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Jan 2026 12:11:56 +0000
Subject: [PATCH v25 2/2] status: show comparison with push remote tracking
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
 remote.c                 | 105 ++++++++++++++-
 t/t6040-tracking-info.sh | 285 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 383 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index fd592ec659..8d64a3bee6 100644
--- a/remote.c
+++ b/remote.c
@@ -29,6 +29,12 @@
 
 enum map_direction { FROM_SRC, FROM_DST };
 
+enum {
+	ENABLE_ADVICE_PULL       = (1 << 0),
+	ENABLE_ADVICE_PUSH       = (1 << 1),
+	ENABLE_ADVICE_DIVERGENCE = (1 << 2),
+};
+
 struct counted_string {
 	size_t len;
 	const char *s;
@@ -2230,13 +2236,69 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_remote_push_branch(struct branch *branch)
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
+	ret = xstrdup(resolved);
+	free(tracking_ref);
+	return ret;
+}
+
 static void format_branch_comparison(struct strbuf *sb,
 				     bool up_to_date,
 				     int ours, int theirs,
 				     const char *branch_name,
 				     enum ahead_behind_flags abf,
-				     bool show_divergence_advice)
+				     unsigned flags)
 {
+	bool enable_push_advice = (flags & ENABLE_ADVICE_PUSH) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+	bool enable_pull_advice = (flags & ENABLE_ADVICE_PULL) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+	bool enable_divergence_advice = (flags & ENABLE_ADVICE_DIVERGENCE) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+
 	if (up_to_date) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
@@ -2245,7 +2307,7 @@ static void format_branch_comparison(struct strbuf *sb,
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
 			    branch_name);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_push_advice)
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
 	} else if (!theirs) {
@@ -2254,7 +2316,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_push_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2265,7 +2327,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_pull_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2278,8 +2340,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
-		    advice_enabled(ADVICE_STATUS_HINTS))
+		if (enable_divergence_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
@@ -2296,6 +2357,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	unsigned base_branch_flags = ENABLE_ADVICE_PULL | ENABLE_ADVICE_PUSH;
+	int push_ours, push_theirs, push_cmp_fetch;
+	char *full_push;
+	char *push = NULL;
+	unsigned push_branch_flags = 0;
 
 	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (cmp_fetch < 0) {
@@ -2307,6 +2373,20 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
+	full_push = get_remote_push_branch(branch);
+	if (full_push) {
+		push = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+						     full_push, 0);
+		if (push && base && strcmp(base, push)) {
+			push_cmp_fetch = stat_branch_pair(branch->refname, full_push,
+						   &push_ours, &push_theirs, abf);
+			if (push_cmp_fetch >= 0) {
+				base_branch_flags = ENABLE_ADVICE_PULL;
+				push_branch_flags = ENABLE_ADVICE_PUSH;
+			}
+		}
+	}
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2315,10 +2395,21 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else {
-		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
+		if (show_divergence_advice)
+			base_branch_flags |= ENABLE_ADVICE_DIVERGENCE;
+		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf,
+					 base_branch_flags);
+	}
+
+	if (push_branch_flags & ENABLE_ADVICE_PUSH) {
+		strbuf_addstr(sb, "\n");
+		format_branch_comparison(sb, !push_cmp_fetch, push_ours, push_theirs, push, abf,
+					 push_branch_flags);
 	}
 
 	free(base);
+	free(full_push);
+	free(push);
 	return 1;
 }
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..da5696113e 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,289 @@ test_expect_success '--set-upstream-to @{-1}' '
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
+test_expect_success 'status with upstream ahead and push branch up to date' '
+	(
+		cd test &&
+		git checkout -b ahead upstream/main &&
+		advance work &&
+		git push upstream HEAD &&
+		git checkout -b feature8 upstream/main &&
+		git push origin &&
+		git branch --set-upstream-to upstream/ahead &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature8
+	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull" to update your local branch)
+
+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status shows remapped push refspec' '
+	(
+		cd test &&
+		git checkout -b feature9 origin/main &&
+		git config remote.origin.push refs/heads/feature9:refs/heads/remapped &&
+		git push &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature9
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
+		git checkout -b feature10 upstream/main &&
+		git config remote.origin.push refs/heads/feature10:refs/heads/remapped &&
+		git push origin &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature10
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
