Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672EA352C5B
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284468; cv=none; b=BkIMHemlAdAMtNmKE6xYkuXOwJ77u6UzJEfHDQLv2+AODwkxvLukQzLwDn7N0Vs0A4PFzo4r2X+H+BdAPWTgq+JOhCpm4eTgT5EvlL2fw7FuAbyNjgWWHNhGgXlE7JzLcv7gydXY5SigabPYKguQxkiq7tLmKxumlmjLWCxrS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284468; c=relaxed/simple;
	bh=k25m0dsq4WdD4T/dPgGT6NCzQIQ/2RkiFPlRCqz0dZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ri6MbIqQU5lbbkplhIZdk6MEt2f5P5hdpJMTDmUIiPMna9fF80g6tJB7aSYLwxvMZTeh4Jv8meWMYR64zBE372r/NDwruVxuKWTXNy82QjYy0MSVVMt+drbr+6rRU2gkeGSGBinXsfVv9Zu3Q+sqV6gLx4u7Jy1UJFkZwKSDZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wke/hkZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HieUXkFR; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wke/hkZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HieUXkFR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87DC814001CC;
	Thu, 20 Aug 2026 23:54:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 20 Aug 2026 23:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787284466; x=1787370866; bh=hUhb7Y/7Sv
	PgLEL9cjS7Ro1ujtn0F1/vrWN27qqNGM0=; b=Wke/hkZW7cx36XL0FJ7bPsv6a7
	lVw26StEUuEtwmqADu8Pcl/VsruAnwyFj2pxpKsEoK56Wid0DMnmGch/eetX4/ng
	Bgqup4v8Xp0CZdabBhG9j5R7zTgti1VUUtVcWjVjFdIx2nj9qyjsdqiLus4mYhjy
	pYRt3mjqN7J+fjFPfoFdZVYfLEw9cOjAuk50Rtro0MqBkuzveR9CS7JXBz2Ks4AN
	Z6fFxzwKXZfgkkxRR+k4NWpia8q68ZVC84Q32c4wZ/aN1Su/hXKSq25G35jL9tcL
	SS57xp3U0H9xYmWUDj8QX85WVZw/PT0bOQTzn0OtF/jmMuUcnZkLq6XMiJEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787284466; x=1787370866; bh=hUhb7Y/7SvPgLEL9cjS7Ro1ujtn0F1/vrWN
	27qqNGM0=; b=HieUXkFRusRUlhrj3Kz68aQPLLNwc0tw53Sy9Ys8vNer0AwZlA8
	6qolOzvVusPG3yNeWXNtKN2YGAtaE2Bc+1zN3D4QOTw86GkntxAP//Qm8cIcLF7B
	bstyF1sdeEeHNS/+NaG2N2JoUMGF2sEwuArMey9PWYta1a8bAne31BAmXs60G1AX
	zXDwvdGJ/+NnnJ1yzD9URwFOpuhJiyrTCs3m/ayvUx5fHOAaMCBvZFw3Ji94CyJj
	up5Eb96Kg4rEFCAnIwmeuKz2QMSJa6ED6arq+vUlNQCnaqW0HysULSCsZ6FjnCVM
	nR3QTcx/R/4bXbBjM1tCNI4P57iliQx4f3Q==
X-ME-Sender: <xms:8suHan9svxlvIhGQYAEfkNvigj53Qj7lrspwpAsTvvPAgt2bchs81g>
    <xme:8suHanaNgBDLZuDkjTZ_vj51oSueLtMXu71QvqfEQJsUe7M3bmx7g74WZ85wBcOei
    Zi2VtSdu1LWth1yw0ln-c5hWF-_bv511RRQL8HLokQGUabKmtT_0A>
X-ME-Received: <xmr:8suHau2ZX4sDd2FdlWwttUZSXNAViXJrXSq-hRRN0__mVddfieyEy_Tq9O9xG2BVV_retkhwzg-xStqufnJMiV-pLxuIajtoGg>
X-ME-Proxy-Cause: dmFkZTEGSzY3iV0EtcZwyzhSF+Ia/q5tXd2tPaY5G6CgimwbV4DKRMvbH81g463OjmVjls
    CdHyKEt5mIdaSNWvQxBUPyhMCJUnkRatsMldGqxkAFd+Caoqp3iofYOt+xtIB2GMnlq0Co
    Uzy6gvSjeS/rJFKhC9b7hVNz/llofPIx/EWu7H2O0x1qT+a5puVRZNRJA1RpOsY66JEZfw
    Cn8EHJCjzjH20O4If2jlcL9DQ5r3i4Lz31U7BDOeb7XRm1T/WimuVA45ACafxDLGmdOVcn
    WmlarSOvg8fKvGZq2+dyPVMtvEtbAB1WXb3r3Ge5iHPRz1HvZIbZWbdFVq3S+SGnIykwaF
    ybNe8As3i47kkKh4nx7cBK899ydLSOD1RCF3J3aZjo0IJlokFv6D0lP6sKOY1NRx4G/xJr
    OOjWwdZ/+uGbEXJIHzcmAL6ufdG7BXDoHYZvBwgsgvzbd6LK6gHBWccK46CkIapZMSiHck
    DGq/u/cNp+WXbWks2xBj3gRyY9KDDwVbJRaQ+BXde+OZhe4FUYU0UiNRP5Au81IC+FCiq8
    A+FiSd9VCYh7//0nAyPs1QLKYJ8C/J6zLENq4g4XemFPSyurWyI1xUnVsXDckuXaI8ZQtx
    3F3q71LMiS/gIlAPstifI113dx1MxkToa/5NiiEEOJFQX77nkFToWbcJUZQw
X-ME-Proxy: <xmx:8suHaqbnaIyzNjudE--gZ_GhJL7k89VwQoc6VDYy1UyaPHX7k_w0wQ>
    <xmx:8suHauKUR_AQLj-dInR02IrEv-ZctfP2XwLu8SFwjY8KUxXyXca9gQ>
    <xmx:8suHahGPxWntUSGsA2xb57HUiYxCOfc5UwOIuk7VzeOuFW96OnCNBg>
    <xmx:8suHatumWzfM1ja3E3-_i6-DO36yrcNtsjbBeX1tUcz7tZ-rDaZ4wQ>
    <xmx:8suHaohnZczZud6iyUSp2k0xMLYQIj-4OiBfVxH79dQhzmG_oviwkWb6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 23:54:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,
  Yoichi Nakayama <yoichi.nakayama@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 3/3] worktree add: improve message for ambiguous
 remote branch name
In-Reply-To: <dcb84a69a6a65085d468a0a212cea0281605c5d0.1787259838.git.gitgitgadget@gmail.com>
	(Yoichi NAKAYAMA via GitGitGadget's message of "Thu, 20 Aug 2026
	21:03:58 +0000")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
	<dcb84a69a6a65085d468a0a212cea0281605c5d0.1787259838.git.gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 20:54:24 -0700
Message-ID: <xmqqa4qgruvj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> When the user runs 'git worktree add ../foo-dir bar-topic' command
> that does not exactly say which remote they want to work with, and
> there is no local branch named bar-topic, we try to guess which remote
> by passing bar-topic then create a new branch named bar-topic which
> tracks the remote branch.
>
> If there are multiple remotes that have branch named bar-topic, we
> silently gave up, leaving the variable 'branch' intact.  Then we
> entered the conditional clause 'if (!opts.orphan &&
> !lookup_commit_reference_by_name(branch))' and triggered "invalid
> reference" error.  This error message did not contain enough
> information to resolve the issue where the remote could not be
> guessed.
>
> To improve the situation, we display a hint and a descriptive error
> message and die immediately when multiple matching branches are found.
>
> Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> ---
>  builtin/worktree.c      | 35 +++++++++++++++++++++++++++++++++--
>  t/t2400-worktree-add.sh |  4 ++--
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 22c8e5e131..8286c283e0 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -788,6 +788,25 @@ static char *dwim_branch(const char *path, char **new_branch)
>  	return NULL;
>  }
>  
> +static void advise_disambiguating_remotes(const char *path, const char *branch,
> +					  const struct string_list *matched_remote_names)
> +{
> +	struct string_list_item *item;
> +
> +	advise(_("Branches with the same name appears in multiple remotes:"));

The subject "Branches" calls for plural verb "appear" (not
"appears").  The same issue appears in [PATCH 2/3].

>  		if (!commit) {
> -			remote = unique_tracking_name(branch, &oid, NULL, NULL);
> +			char *remote;
> +			int num_matches = 0;
> +			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
> +
> +			remote = unique_tracking_name(branch, &oid, &num_matches,
> +						      &matched_remote_names);
>  			if (remote) {
>  				new_branch = branch;
>  				branch = new_branch_to_free = remote;
> +			} else if (num_matches > 1) {
> +				if (!opts.quiet &&
> +				    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
> +					advise_disambiguating_remotes(path, branch,
> +								      &matched_remote_names);
> +				die(_("'%s' matched multiple (%d) remote tracking branches"),
> +				    branch, num_matches);
>  			}
> +			string_list_clear(&matched_remote_names, 0);
>  		}

This appears inside "} else if (ac == 2) {" to catch an invocation
like

	git worktree add ../over-there topic-branch

where the origin of topic-branch is ambiguous (in other words,
appears in multiple remotes).  But don't we have the same issue for
1 argument case that appears just above this (ac == 2) case that
handles

	git worktree add ../topic-branch

invocation?  The code reads like:

	} else if (ac < 2) {
		/* DWIM: Guess branch name from path. */
		char *s = dwim_branch(path, &new_branch_to_free);
		if (s)
			branch = branch_to_free = s;
		new_branch = new_branch_to_free;

		/* DWIM: Infer --orphan when repo has no refs. */
		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
	} else if (ac == 2) {

where the branch name "topic-branch" is guessed from the path by
calling dwim_branch(), and we would get NULL in s.  branch is left
as-is, so it becomes "HEAD" that was assigned much earlier in the
same function.

        branch = ac < 2 ? "HEAD" : av[1];

We would create a new directory in ../topic-branch next door, and
then which branch would we check out?  Would dwim_orphan() kick in?

Perhaps we want to update that code path to disambiguate the same way?

> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 87b926728a..5c105cf252 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
>  test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
>  	test_when_finished rm -rf repo_upstream repo_dwim foo &&
>  	setup_remote_repo repo_upstream repo_dwim &&
> -	git init repo_dwim &&
>  	(
>  		cd repo_dwim &&
>  		git remote add repo_upstream2 ../repo_upstream &&
>  		git fetch repo_upstream2 &&
> -		test_must_fail git worktree add ../foo foo &&
> +		test_must_fail git worktree add ../foo foo 2>error.actual &&
> +		test_grep "matched multiple (2) remote tracking branches" error.actual &&
>  		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
>  		git status -uno --porcelain >status.actual &&
>  		test_must_be_empty status.actual
