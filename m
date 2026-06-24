Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A2265CDD
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338102; cv=none; b=ChOjIbEpgzWuvR1CLRZgZxrygt52YkeMn2uLv2ixoMpVyGc6pKKQTVauemCPRBmTC1afcxvKwKzaRwu+ObCTOLhxRMnMGk/FRTxFAxSzudcBIfBk/ZnKKhxpYU/KKeb6dG7TIZXITZKXxxGp/ZUlS2Qm8gM0fk4SrR6h5FoloU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338102; c=relaxed/simple;
	bh=aAi7XwM62PkDPALgyw8aI1TIC9A+U3KXXORlNTd8vPA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rBrNTwdHHe5unml9SfNLYcLN1Wko1qaFfVlYsP7fJ2wg+5uDusiZU7GWkszrdHgDJkoXJO+0ZGvibpkSURbttZMvbpDO1xHf48jNbyaehKkyEIxBDs8EPTv5J2Q/5+s3WSHiAKAdodTSF7WxEnQOhDWKSeiFLXMTW6q1XJeip2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2EwbKxd; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2EwbKxd"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9157ec935c5so163249385a.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338100; x=1782942900; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh1IJbgq6IhzrJtrjtWcG6hUXgCxDZ+D3AxBwGFchWI=;
        b=Y2EwbKxduEtxxwjKkP5avwlnzZ5yD+lB4JCrtfw90fqM0O2SbDhLjEUy5AygHvW5+I
         XZceUGkDKm+Ccq3KKVKTCrfTGUA/an9KCwsrUOp+fFVIBEDk1hDgy4yQ+S4ZCVbwVShm
         ROd+Phzk+75L7BY0V9ImkqGllmvCg4L/EUuls+bEZp+aDdD8N0RfHhgswxO8FW28DLyF
         A1KWiWFMYh4ChjZN6bhDumW5kxv+z5kahjte6Otk1xmBGGkV0kRkwPtVC1zYuG6Aa4iy
         9xRRxEZGMsDP1FqauzjpigmUtTpNGA5WZSp5CXf4PdTirm8ke6J2Cogz7vDNw8c/vJDJ
         1Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338100; x=1782942900;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gh1IJbgq6IhzrJtrjtWcG6hUXgCxDZ+D3AxBwGFchWI=;
        b=S6wCRQRhZVMlQIA1JCqYpgUtAL1IqoxtDDISVdJrqdz8aWioYaapKXy6jWoThmv/lx
         j+A4Dy+SJwNy+4EGpHUh/uJvMdA+HV2ZpAwf3OXzm5BuAxQ4YBaniWGolSo3+a7OXuD1
         sy2LzaOhUn/L2+hO5Bx8iQFeRnXOTglgD2eD5NO9qsHuKx0MI3E11IFSdaVSGF45Vppa
         PerNj68P/IgqvF3CL69vDPHA9gNRz3v7cEmPUGIQ/AQbfxaEngdqNKpnaQFG5pQ69GID
         P5sbkpZ90KZDd1F97ZFKy749h9H5CL5UBFsm9n+D8cxOSahAy7s5hUIlcIw3jh8fQkDq
         pNcQ==
X-Gm-Message-State: AOJu0YwNteEeJTtmi/J+ueZEC8z3DlJZdK8qqALq4qKrzt95je1q5U9X
	HPglyWs0PLKnr42QgeZcgkRuvxurAL2GeQ8nmuh14wvFT8DZSNQdD/0Asnrbeg==
X-Gm-Gg: AfdE7cm1cok//dColVrNvDuUR9B40kHIWnBWZhHsaobqSIPeEkEgb6JUC3ywLCez8/S
	OrZTxx+PCOghiE6HnlR9wVpuXU7sQ1d41qmy280b+pCdKt6gYoDGvmOaeX0IPmamx9znz4wZ1KV
	uUlZxYrEtPk8zxi8ZAZpUnwv8TQDpdC7+hsV/IQBtUekxwwc3yV8XK2tyhsg0gHGpn/BcrEqECo
	ASTP5iY0cOJktAI7RyYLw/3kK0mfTyMyWQhPuVPiZseIviFLmp9y4C6ro7/0lQobUpKaaaitnaF
	43UTR7XyZmMqEfDRS0C/1HT4RwIrS2rh7tPnPTorgBktHXqx00JhoS+qhX3l0idghOjQen/w3BR
	QaCrr9i8+pxouvbP0QNnu65g4i075NqdR189IxT5ow+j638bqv/MhW07nHxOD7YSZVUZfxwQwBD
	geRA+67WaRSF8xOUwE
X-Received: by 2002:a05:620a:2b81:b0:915:9a1b:83df with SMTP id af79cd13be357-9277fbb553cmr830552385a.57.1782338099833;
        Wed, 24 Jun 2026 14:54:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.91.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7aae6sm661078585a.44.2026.06.24.14.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:54:59 -0700 (PDT)
Message-Id: <pull.2281.v15.git.git.1782338098.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
References: <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:54:56 +0000
Subject: [PATCH v15 0/2] checkout: --track=fetch
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
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Marc Branchaud <marcnarc@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Extend checkout --track with a fetch mode to refresh start-point.

Changes in v15:

 * Reword commit message to lead with motivation.
 * Drop RESOLVE_REF_NO_RECURSE so <ns>/HEAD lookup matches what git checkout
   does for the same ref. Drop redundant check_refname_format on a ref we
   just read. Replace memset with brace initializer. Use refs_ref_exists and
   pass NULL for the OID out-params.
 * Split the "set HEAD" error onto its own line via die_message and advise,
   matching the suggested format.
 * Remove 6 redundant tests, replace test $a = $b with test_cmp_rev, and
   rename test titles to avoid "namespace".

Changes in v14:

 * Handle .h files in a better way.

Changes in v13:

 * Create a preparatory commit that exposes find_tracking_remote_for_ref()
   and advise_ambiguous_fetch_refspec() from branch.c, so checkout can reuse
   the same lookup git branch --track uses.
 * Use advise_ambiguous_fetch_refspec() for the "multiple remotes match"
   case, so the wording matches git branch --track.

Harald Nordgren (2):
  branch: expose helpers for finding the remote owning a tracking ref
  checkout: extend --track with a "fetch" mode to refresh start-point

 Documentation/git-checkout.adoc |  17 ++-
 Documentation/git-switch.adoc   |   5 +-
 branch.c                        |  96 +++++++-------
 branch.h                        |  16 +++
 builtin/checkout.c              | 138 +++++++++++++++++++-
 t/t7201-co.sh                   | 222 ++++++++++++++++++++++++++++++++
 6 files changed, 443 insertions(+), 51 deletions(-)


base-commit: ab776a62a78576513ee121424adb19597fbb7613
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v15
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v15
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v14:

 1:  f79689c23d = 1:  8139490c36 branch: expose helpers for finding the remote owning a tracking ref
 2:  8518f090b1 ! 2:  b7e387f123 checkout: extend --track with a "fetch" mode to refresh start-point
     @@ Metadata
       ## Commit message ##
          checkout: extend --track with a "fetch" mode to refresh start-point
      
     -    Add a "fetch" mode to the "--track" option of "git checkout" / "git
     -    switch" that refreshes <start-point> before checking it out:
     +    Forking from an existing remote branch without refreshing first often
     +    has consequences: you start work that has already been done, or you
     +    build on an old version of the code which causes big conflicts later
     +    when you pull. The workaround is two commands ("git fetch <remote>
     +    <branch> && git checkout -b <topic> <remote>/<branch>"), and when
     +    the fetch is skipped the checkout silently starts from a stale tip.
      
     -        git checkout -b new_branch --track=fetch origin/some-branch
     +    Users may already expect "<remote>/<branch>" to refer to the latest
     +    tip on the remote. While this blurs the line between fetch and
     +    checkout, git already does this in places where it pays off: "git
     +    clone" fetches and checks out, and "git pull" fetches and merges.
      
     -    is shorthand for
     +    Add a "fetch" mode to "--track" that refreshes <start-point> before
     +    checking it out:
      
     -        git fetch origin some-branch
     -        git checkout -b new_branch --track origin/some-branch
     +        git checkout -b new_branch --track=fetch origin/some-branch
      
     -    Identify the remote whose configured fetch refspec maps to
     -    <start-point> using find_tracking_remote_for_ref() (the same lookup
     -    "--track" uses to pick which remote to record in
     -    branch.<name>.remote), then run "git fetch <remote> <src-ref>" for
     -    just that ref so other remote-tracking branches are left untouched.
     -    When <start-point> is a bare <remote> (e.g. "origin"), follow
     -    refs/remotes/<remote>/HEAD to learn which branch to refresh. If
     -    "git fetch" fails but the remote-tracking ref already exists locally,
     -    warn and proceed from the existing tip; otherwise abort.
     +    Only the requested branch is fetched so other remote-tracking
     +    branches are left untouched. When <start-point> is a bare <remote>
     +    (e.g. "origin"), follow refs/remotes/<remote>/HEAD to learn which
     +    branch to refresh. If "git fetch" fails but the remote-tracking ref
     +    already exists locally, warn and proceed from the existing tip,
     +    otherwise abort.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ builtin/checkout.c: struct branch_info {
      +static void fetch_remote_for_start_point(const char *arg, int quiet)
      +{
      +	struct strbuf dst = STRBUF_INIT;
     -+	struct tracking tracking;
     ++	struct tracking tracking = { 0 };
      +	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
      +	struct string_list ambiguous_remotes = STRING_LIST_INIT_DUP;
      +	struct child_process cmd = CHILD_PROCESS_INIT;
     -+	struct object_id oid;
      +	struct remote *named_remote;
      +	int bare_ns;
      +
     @@ builtin/checkout.c: struct branch_info {
      +		const char *head_target =
      +			refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
      +						head_path,
     -+						RESOLVE_REF_READING |
     -+						RESOLVE_REF_NO_RECURSE,
     -+						&oid, NULL);
     ++						RESOLVE_REF_READING,
     ++						NULL, NULL);
      +		if (head_target &&
      +		    starts_with(head_target, dst.buf) &&
     -+		    head_target[dst.len] == '/' &&
     -+		    !check_refname_format(head_target, 0)) {
     ++		    head_target[dst.len] == '/') {
      +			strbuf_reset(&dst);
      +			strbuf_addstr(&dst, head_target);
      +			bare_ns = 0;
     @@ builtin/checkout.c: struct branch_info {
      +		free(head_path);
      +	}
      +
     -+	memset(&tracking, 0, sizeof(tracking));
      +	tracking.spec.dst = dst.buf;
      +	tracking.srcs = &tracking_srcs;
      +	find_tracking_remote_for_ref(&tracking, &ambiguous_remotes);
     @@ builtin/checkout.c: struct branch_info {
      +
      +	if (!tracking.matches) {
      +		if (bare_ns && named_remote &&
     -+		    remote_is_configured(named_remote, 1))
     -+			die(_("cannot fetch start-point '%s': "
     -+			      "'refs/remotes/%s/HEAD' is not set; run "
     -+			      "'git remote set-head %s --auto' to set it"),
     -+			    arg, arg, arg);
     ++		    remote_is_configured(named_remote, 1)) {
     ++			int status = die_message(_("cannot fetch start-point '%s' "
     ++						   "because 'refs/remotes/%s/HEAD' "
     ++						   "does not exist."), arg, arg);
     ++			advise(_("To create it run\n"
     ++				 "\n"
     ++				 "    git remote set-head %s --auto\n"), arg);
     ++			exit(status);
     ++		}
      +		die(_("cannot fetch start-point '%s': no configured remote's "
      +		      "fetch refspec matches it"), arg);
      +	}
     @@ builtin/checkout.c: struct branch_info {
      +		     tracking_srcs.items[0].string, NULL);
      +	cmd.git_cmd = 1;
      +	if (run_command(&cmd)) {
     -+		if (!refs_read_ref(get_main_ref_store(the_repository),
     -+				   dst.buf, &oid))
     ++		if (refs_ref_exists(get_main_ref_store(the_repository), dst.buf))
      +			warning(_("failed to fetch start-point '%s'; "
      +				  "using existing '%s'"), arg, dst.buf);
      +		else
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	git -C fetch_upstream checkout -b fetch_other &&
      +	test_commit -C fetch_upstream u_other_pre &&
      +	git fetch fetch_upstream &&
     -+	other_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_other) &&
     ++	git update-ref refs/heads/snapshot_other refs/remotes/fetch_upstream/fetch_other &&
      +	git -C fetch_upstream checkout fetch_target &&
      +	test_commit -C fetch_upstream u_target_post &&
      +	git -C fetch_upstream checkout fetch_other &&
      +	test_commit -C fetch_upstream u_other_post &&
      +	git checkout --track=fetch -b local_target fetch_upstream/fetch_target &&
      +	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
     -+	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
     ++	test_cmp_rev refs/remotes/fetch_upstream/fetch_other snapshot_other
      +'
      +
      +test_expect_success 'checkout --track=fetch with bare remote name fetches only <remote>/HEAD target' '
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	git -C fetch_upstream checkout -b fetch_unrelated &&
      +	test_commit -C fetch_upstream u_unrelated_pre &&
      +	git fetch fetch_upstream fetch_unrelated &&
     -+	unrelated_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated) &&
     ++	git update-ref refs/heads/snapshot_unrelated \
     ++		refs/remotes/fetch_upstream/fetch_unrelated &&
      +	git -C fetch_upstream checkout main &&
      +	test_commit -C fetch_upstream u_main_post &&
      +	git -C fetch_upstream checkout fetch_unrelated &&
      +	test_commit -C fetch_upstream u_unrelated_post &&
      +	git checkout --track=fetch -b local_from_remote fetch_upstream &&
      +	test_cmp_rev refs/remotes/fetch_upstream/main HEAD &&
     -+	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated)" = "$unrelated_before"
     ++	test_cmp_rev refs/remotes/fetch_upstream/fetch_unrelated snapshot_unrelated
      +'
      +
      +test_expect_success 'checkout --track=fetch aborts and does not create branch when no existing ref' '
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
      +'
      +
     -+test_expect_success 'checkout --track=fetch on namespace bare name follows <ns>/HEAD' '
     ++test_expect_success 'checkout --track=fetch on bare remote-tracking prefix follows <prefix>/HEAD' '
      +	git checkout main &&
      +	git remote add fetch_ns ./fetch_upstream &&
      +	test_when_finished "git remote remove fetch_ns" &&
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_cmp_config refs/heads/main branch.local_ns.merge
      +'
      +
     -+test_expect_success '--track=fetch on bare hierarchical remote name follows <ns>/HEAD' '
     -+	git checkout main &&
     -+	git remote add nested/bare ./fetch_upstream &&
     -+	test_when_finished "git remote remove nested/bare" &&
     -+	test_when_finished "git update-ref -d refs/remotes/nested/bare/HEAD" &&
     -+	git fetch nested/bare &&
     -+	git symbolic-ref refs/remotes/nested/bare/HEAD \
     -+		refs/remotes/nested/bare/main &&
     -+	git -C fetch_upstream checkout main &&
     -+	test_commit -C fetch_upstream u_nested_bare_post &&
     -+	git checkout --track=fetch -b local_nested_bare nested/bare &&
     -+	test_cmp_rev refs/remotes/nested/bare/main HEAD
     -+'
     -+
     -+test_expect_success 'checkout --track=fetch handles hierarchical remote name' '
     -+	git checkout main &&
     -+	git remote add nested/remote ./fetch_upstream &&
     -+	test_when_finished "git remote remove nested/remote" &&
     -+	git -C fetch_upstream checkout -b fetch_hier &&
     -+	test_commit -C fetch_upstream u_hier &&
     -+	test_must_fail git rev-parse --verify refs/remotes/nested/remote/fetch_hier &&
     -+	git checkout --track=fetch -b local_hier nested/remote/fetch_hier &&
     -+	test_cmp_rev refs/remotes/nested/remote/fetch_hier HEAD
     -+'
     -+
      +test_expect_success 'checkout --track=fetch dies on bare remote name with no <ns>/HEAD' '
      +	git checkout main &&
      +	git remote add fetch_nohead ./fetch_upstream &&
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_must_fail git rev-parse --verify refs/heads/local_unknown
      +'
      +
     -+test_expect_success 'checkout --track=fetch rejects <ns>/HEAD pointing outside namespace' '
     ++test_expect_success 'checkout --track=fetch rejects <ns>/HEAD pointing outside the tracking prefix' '
      +	git checkout main &&
      +	git remote add fetch_crossns ./fetch_upstream &&
      +	test_when_finished "git remote remove fetch_crossns" &&
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_must_fail git rev-parse --verify refs/heads/local_invalid
      +'
      +
     -+test_expect_success 'checkout --track=fetch,inherit rejects invalid refname components' '
     -+	git checkout main &&
     -+	test_must_fail git checkout --track=fetch,inherit -b local_invalid \
     -+		"foo..bar" 2>err &&
     -+	test_grep "valid" err &&
     -+	test_must_fail git rev-parse --verify refs/heads/local_invalid
     -+'
     -+
      +test_expect_success 'checkout --track=inherit,direct is rejected' '
      +	test_must_fail git checkout --track=inherit,direct -b bad fetch_upstream/fetch_new 2>err &&
      +	test_grep "cannot combine" err
      +'
      +
     -+test_expect_success 'checkout --track=direct,inherit is rejected' '
     -+	test_must_fail git checkout --track=direct,inherit -b bad fetch_upstream/fetch_new 2>err &&
     -+	test_grep "cannot combine" err
     -+'
     -+
      +test_expect_success 'checkout --track=fetch then --track=direct drops fetch (last-one-wins)' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_lastwin &&
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin
      +'
      +
     -+test_expect_success 'checkout --track=fetch then --no-track drops fetch' '
     -+	git checkout main &&
     -+	git -C fetch_upstream checkout -b fetch_notrack &&
     -+	test_commit -C fetch_upstream u_notrack &&
     -+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_notrack &&
     -+	test_must_fail git checkout --track=fetch --no-track \
     -+		-b local_notrack fetch_upstream/fetch_notrack &&
     -+	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_notrack
     -+'
     -+
      +test_expect_success 'checkout --track=fetch,inherit fetches remote-tracking start-point' '
      +	git checkout main &&
      +	git -C fetch_upstream checkout -b fetch_inherit &&
     @@ t/t7201-co.sh: test_expect_success 'tracking info copied with autoSetupMerge=inh
      +	test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD
      +'
      +
     -+test_expect_success 'checkout --track=fetch,inherit errors when start-point does not map to a remote' '
     -+	git checkout main &&
     -+	test_must_fail git checkout --track=fetch,inherit -b bad main 2>err &&
     -+	test_grep "no configured remote" err &&
     -+	test_must_fail git rev-parse --verify refs/heads/bad
     -+'
     -+
      +test_expect_success 'checkout --track=fetch on local start-point errors' '
      +	git checkout main &&
      +	test_must_fail git checkout --track=fetch -b bad main 2>err &&

-- 
gitgitgadget
