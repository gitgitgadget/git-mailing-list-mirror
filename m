Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795824748;
	b=2+Lf3AeQt0gtO6tavp+4R8pM5XKbQAU6EvsOEFWEDdrDZ5Iqu8CcugxV/x+/6gt8ffj9
	 xc9m2IwVbFZZtM1L8muHD/XGMnUBVxaFnWUaXLx+LljI4FUKTqemK/NWyjDsKv4nBwbSw
	 tGSDmsysbPZlefNOKUgfQ8p1zoim91cBzxnRH1zb+rQAH7SrGlib+iybXLhb6NHjyr27u
	 iyeS3/A8IipNaCALObfLfxebElTu4vaAm/cO5FdTn5AzutoDBbOZ3a1I/pgB/xTBy5ECI
	 BdKiVXkrTs71AZMslWDk7/OI3SbcjxXMDmt0hH2vF11dwWaaYo9bhEh6XGPOEObgNhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795824748;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gpAcKTdsPDXrejUfBPHvwE/AomHVk79xQrGPvVyT4zA=;
	b=LW5TeLOJ3vhCpxnmUcJuAJanGHvII3cEBXm+lpa1wsWCFVFpEODOai8fFLoRV2si9uQ7
	 0o2C6Up8Rd4Nkkvrk2pxPqg9FY6lEMZ0mHZLYOYHFt1yRHH9uHwQP87MKxXl8r1N1ACaZ
	 wna4Ky4u9w8l/I1Ajrb9O6+8ubRK03s18EvRWLS97fM/k4Ck53N2h+3z0XRYbWfcGEdNQ
	 JrEMN8Do3hVlIfyf/GGe0KowuCJESLHo1Jct7PZ83wdVbMi5+3yfv95wJJC1nsv8CTpQI
	 KY88MuSAXTpfEZF/8lslmLD/cMNvfF1FutHjrUG2avzr3yLXpx0mMW/w0lc3g/wUPKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZgnceXUi;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=II23Qs3f;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CB606A31E
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 00:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 654CB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZgnceXUi;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=II23Qs3f
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBE767A0495
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 19:12:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Nov 2026 19:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795824746; x=1795911146; bh=gpAcKTdsPD
	XrejUfBPHvwE/AomHVk79xQrGPvVyT4zA=; b=ZgnceXUiLYbb1yuTCVPE4ahidR
	sUGSO68hmys5qo/8+iXDI7eFihUc2sQnuYHizUX7BH/I17hGTWhfgRTcmdpOj4CF
	3vVM5ZkMbkAvE77Zc5WnBB5tV8InTdJEsbvbaI0caExHKVEFykUwWActVlfC4DQg
	ACZcuUDlkxddZO5dxp2lsDK0l9egTFoNGHT+rspYI4pFAOQ2pZLau9TCM4h6/JcT
	Khq0N8qL5Vwc/tF0kuoGJSI4AQyvpL2YUGFsCFAMXS+JHk+PghIIK2N4kdCZlMpc
	3iZkU9eVeIubCNls9bzxUlZYzHnOF4QlPQjUjaKz1b5R7beiSJUJ3aR6Pspg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795824746; x=1795911146; bh=gpAcKTdsPDXrejUfBPHvwE/AomHVk79xQrG
	PvVyT4zA=; b=II23Qs3frvTFvqShY5RVDCKawLp+mTopQT+QKwUcfv2TmFTujvn
	GMgVKPmphbLuyPAXBTttnAEQ1b7JlNN86b6LC41xfwWPt8tlTTqvTzcmDWiKVdy4
	nxhFtl2/b59RSQcfsSX1TOrdD3wVcvMZRowYMtRHGmZKXNgUWIYveHwK5R7f2Xec
	bpRia8buuwnM2CfoQIj7I2J4Q4h7tKWjgS1B1AUw4cUTjFNC8tJbprTzVfln8IKM
	sHYLDgdKX0WrUq2K/RAzH//nmscu3fDdBiypPB8L2ncZ5eoxd0mKcf00M2okeIyM
	LujFcj9Wu1wM7ivA8lmvaHkeNvMNIXO6m/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795824746; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:f5aY/3Z2iJ7rnW6IAwmFQNbr37g2fH0XIlJjngixP5cPLxU
	52ux/lcn2om3zzFVPej4b0mcX+Hu5YAJ5Z/hLE0rZJ1aw0X08viCscs/K+W8k/fi
	9YVSYBM+69BESWHdGzYybeKmnbTqKAtXonhF4oUH5+N1U+z6XhdyEKa+MGwqGbKy
	R6Uc2D98NQ3fG8bA0zgjJe3yGTd72Y+Vudpr3hys8jNaeXLj06VQUHTysY0YwR2D
	Ky4IMoIcxcK6BNqHKmNyWcDy6VNXvQd1gqdV84NHRSVlcw2cMgog6ztVEM9W4PRO
	jwkNJc3Mm/nolmgDkl0BDzfvQfQq+0SB6Ms/saQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tXygiu3m2o7l1IFjEr8L9qOO+RjX6vD1I1cHeR4EMVg=:LSpIN5GVHBvsaTMvVA4gbRYbi921HoaeKSkuW/HeHWQ=;
X-ME-Sender: <xms:ahwKayF6ccBSeZQqnfAIm7sgmsgcdbAw9gTDsTY_1ITkrIQYhUAxYA>
    <xme:ahwKa1mqRBcO-Rl_xiC45YdUg6-krUkJTKCJDwbKwCCR8-nLhEoQgcWcMe_KQClCR
    RZWlgGWR5l6bv3qnWPKi9IhyfTl5dOdeJtcxvQDVnuj1d6qpIf8pA>
X-ME-Received: <xmr:ahwKa-ZZmLw-x6LUw18QzeEHRtbWefhRsFq14sPzXoXToJ_tPyJ9vTzx8C7fWY57_aLsZ31mQ_CaVREufw-UVQurJOHWpNt906txLxo>
X-ME-Proxy-Cause: dmFkZTGCYOttayErU/IyFSCQlKV8eIRit4D4rZ1xc0Pm6/wH4izfV9Y23TFnlexqyYKobX
    sfd1N9h8CTNeGdsVg0sutp1oV2sdqHDwjpdYSOJo31yp+gn0lhocxaTCV75MLX9SH0RlgN
    5xMET5fs115CG38697cfiWqlyao32BCcxgzcZIDhuiodOZT1DOIzunXE+0N1W+1V61cwaA
    evRPGLdFNbAZ842JyDFZdLOBBS5lFsrOYoMKEVm9jjNesSbr8iFfXm394ydpFnmA//e2dX
    RW8gtp5BMLL7LH4twtFblncoLpkl7GYDeVbHroEnclqbOP6kH24BQ3x3r3jgSdNky70EZl
    uFJoWkYaUEpuINS9eYLRj7I1cyiIZ0lS5gNopo17RHIJ46BlREsn45FW1ijM7Ru/VQLCLW
    2R/lT2Jwlzt7mAIE2Irvv8Q24uALMOKZmEgg4vdoqEH4NywqmvEc518TEl7U2HhjU8c0rs
    Kn9r8j96t3B+8XVNhHkTkAx2vnHNDWt5y6dXIWKMFkJ6vawaVtHgIxtlmPQQRdl7zbu42l
    HV8tyHQhodOqnxv/lsrqFkB6X9nKdaMPJIXzBuf8CI/xOgxVyzCjr0ckqX3+wXEwBvmS+B
    fduvRkIiECHz/lAAmXIfbfM9RQHIUCVadab6aJScEGXRGODVzFrZ6njBDAYg
X-ME-Proxy: <xmx:ahwKayFZWhBxECxVXyTIFu3DqxGuIWoLh4owphth9y0k779qqdyThQ>
    <xmx:ahwKa3JtrDIxslaQqtIfV8BPqXWUlqAS63XOFMPnJJfzbtArBvRGQQ>
    <xmx:ahwKa1NlJJHaQTLoYUJWikUsEHlgc6d0TIGVGokOoqucIGsFwUkp5Q>
    <xmx:ahwKa_kR5lVIvto2WzyWiIkoP8K7V5rocvssJZudqssNf_LPBIx6_A>
    <xmx:ahwKa7Bqyeq2FA7vRkgRjM_faR8viEt90jUPjEnj3Qps7u2lS1ykpewR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 19:12:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Toon Claes
 <toon@iotcl.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Nikita Bobko
 <nikita@nbobko.com>
Subject: Re: [PATCH v2] history: refuse to rewrite branches used by other
 worktrees
In-Reply-To: <20261127173252.7794-1-aniketgupta3001@gmail.com> (Aniket Gupta's
	message of "Fri, 27 Nov 2026 23:02:52 +0530")
References: <20261123103911.98860-1-aniketgupta3001@gmail.com>
	<20261127173252.7794-1-aniketgupta3001@gmail.com>
Date: Fri, 27 Nov 2026 16:12:24 -0800
Message-ID: <xmqqse0l3jbr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> ... A bare repository
> has no such worktree, and branch_checked_out() records only one worktree
> per branch, so ask the other worktrees whether they use the branch
> instead of skipping it by name. --update-refs=head refuses in the same
> cases.

Checking the other worktrees for the current HEAD target instead of
skipping it by name is a neat way to handle both bare repositories and
branches forced into multiple worktrees.  

I had to read "--update-refs=head refuses in the same cases" above a few
times to unconfuse myself.  I initially took it to mean that it rejects
whenever "--update-refs=branches" would reject, but "--update-refs=head"
specifically leaves unrelated branches in other worktrees alone and only
refuses when HEAD's target branch itself is used elsewhere (either
checked out or when a rebase or bisect is in progress).

Spelling that out directly would make the paragraph easier to follow.

> diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
> index 3d91c90eda..65f3ff0e02 100644
> --- a/Documentation/config/advice.adoc
> +++ b/Documentation/config/advice.adoc
> @@ -60,9 +60,10 @@ all advice messages.
>  		Shown when the user tries to delete a not fully merged
>  		branch without the force option set.
>  	historyUpdateRefs::
> -		Shown when `git history squash` refuses because a local branch
> -		cannot be rewritten as a descendant of the squashed commit, to
> -		tell the user about `--update-refs=head`.
> +		Shown when `git history` refuses to run because a local branch is
> +		used by another worktree, or, for `squash`, because it cannot be
> +		rewritten as a descendant of the squashed commit, to tell the
> +		user about `--update-refs=head`.

As tested in t/t3450-history.sh, when a branch is being rebased in the
current worktree, this advice is also shown when the current worktree is
rebasing or bisecting the branch with HEAD detached, not only when it is
used by another worktree.

> diff --git a/builtin/history.c b/builtin/history.c
> index 43ba76f5a1..d0a3287c1d 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -2,6 +2,7 @@
>  
>  #include "builtin.h"
>  #include "advice.h"
> +#include "branch.h"
>  #include "cache-tree.h"
>  #include "commit.h"
>  #include "commit-reach.h"
> @@ -11,6 +12,7 @@
>  #include "gettext.h"
>  #include "hex.h"
>  #include "lockfile.h"
> +#include "log-tree.h"

What new things from log-tree.h are referenced by this patch?
The file seems to compile without this new inclusion.

> @@ -260,15 +263,100 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
>  	return 0;
>  }
>  
> -static int revwalk_contains_merges(struct repository *repo,
> -				   const struct strvec *revwalk_args)
> +/*
> + * Return the path of the worktree that uses "refname", if rewriting it would
> + * leave the index and working tree of that worktree behind. The branch that
> + * the current worktree has checked out is fine, unless another worktree has
> + * it checked out as well.
> + */
> +static char *branch_used_elsewhere(struct repository *repo,
> +				   const char *refname,
> +				   const char *head_target)
> +{
> +	char *path = NULL;
> +
> +	if (head_target && !strcmp(refname, head_target)) {
> +		struct worktree **worktrees = get_worktrees(repo);
> +
> +		for (int i = 0; worktrees[i]; i++) {
> +			if (!worktrees[i]->is_current &&
> +			    is_shared_symref(worktrees[i], "HEAD", refname)) {
> +				path = xstrdup(worktrees[i]->path);
> +				break;
> +			}
> +		}
> +		free_worktrees(worktrees);
> +	} else {
> +		const char *checked_out = branch_checked_out(refname);
> +
> +		if (checked_out)
> +			path = xstrdup(checked_out);
> +	}
> +
> +	return path;
> +}

This separation makes sense, given how branch_checked_out() works in
branch.c.  Because branch.c:prepare_checked_out_branches() populates the
current_checked_out_branches strmap, a branch checked out in two
worktrees only keeps one path in the map, so branch_checked_out() cannot
tell whether another worktree also uses head_target.

Asking non-current worktrees via is_shared_symref() covers symrefs,
detached rebases, and bisects in other worktrees, and also works when
run in a bare repository where the current worktree is bare.

> +/* "git rebase --abort" would throw away a rewrite of the detached HEAD. */
> +static bool rebase_in_progress(struct repository *repo)
> +{
> +	struct worktree **worktrees = get_worktrees(repo);
> +	struct wt_status_state state = { 0 };
> +	bool ret = false;
> +
> +	for (int i = 0; worktrees[i]; i++) {
> +		if (worktrees[i]->is_current) {
> +			wt_status_check_rebase(worktrees[i], &state);
> +			ret = state.rebase_in_progress ||
> +			      state.rebase_interactive_in_progress;
> +			break;
> +		}
> +	}

Instead of enumerating every worktree with get_worktrees() just to pick
out '.is_current', we could call get_current_worktree(repo) and
free_worktree(), as wt-status.c does in wt_status_get_state().  It would
avoid reading HEAD for all linked worktrees, no?

> @@ -281,17 +369,59 @@ static int revwalk_contains_merges(struct repository *repo,
>  		goto out;
>  	}
>  
> -	if (get_revision(&revs)) {
> -		ret = error(_("replaying merge commits is not supported yet!"));
> +	if (action == REF_ACTION_BRANCHES)
> +		collect_used_branches(repo, original, head_target, &used,
> +				      &rewrites_head);
> +
> +	while ((commit = get_revision(&revs))) {
> +		if (commit->parents && commit->parents->next) {
> +			ret = error(_("replaying merge commits is not supported yet!"));
> +			goto out;
> +		}
> +		if (action == REF_ACTION_BRANCHES)
> +			collect_used_branches(repo, commit, head_target, &used,
> +					      &rewrites_head);
> +	}

Merging the merge-commit check and the branch/HEAD check into a single
walk in validate_revwalk() is clean.

In setup_revwalk(), the revision args include --ancestry-path=<original>
and ^<original>, so original is excluded from get_revision() and
checking it once before the loop will not visit any branch decoration
twice.  All five subcommands also normalize REF_ACTION_DEFAULT to
REF_ACTION_BRANCHES and call setup_revwalk() before opening an editor or
modifying refs or the index, and moving reset_revision_walk() to the
'out:' label keeps object flags clean on error paths too.

>  out:
> +	reset_revision_walk();
>  	release_revisions(&revs);
> +	string_list_clear(&used, 1);
>  	strvec_clear(&args);
> +	free(head_target);
>  	return ret;
>  }


> diff --git a/t/t3450-history.sh b/t/t3450-history.sh
> index f513463b92..03bd375ef8 100755
> --- a/t/t3450-history.sh
> +++ b/t/t3450-history.sh
> @@ -14,4 +14,269 @@ test_expect_success 'raises an error with unknown argument' '
>  	test_grep "unknown subcommand: .garbage." err
>  '

The new tests in t/t3450-history.sh cover the worktree, bare
repository, shared checkout, rebase, bisect, advice, --dry-run,
--update-refs=head, and pre-editor refusal cases well.

Overall this looks solid to me.
