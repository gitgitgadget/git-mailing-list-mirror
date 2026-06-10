Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983328FFF6
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097072; cv=none; b=BeHUC4blhXCcnEVm7Cm3YSPcHCZohKnlAT1pKU5GAmCtRxgG8iX95xK+0f1DkxuMJCPAQLqpIZRx3IVjsphC1yoLIQvr2Fm01NdK0tOMcDqpzdULwAJT/p8J3RR7aCnGgThs+XW7JUDIHusEfx2Hu4P5QAOJ1+NAmmIj0TOLRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097072; c=relaxed/simple;
	bh=L/1Anj+loIQ+156WFLzvI08MDSGeUxT2mVHjXm4tuNo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=axwxpJDTE8iBN/fygtwNDqQ2Uqt7LX4ok1HKYg7QvxCc8N/1jKHs8aFDPnUv6n+tBKkxmGuz1Ay+8dPDAAMz80DUpZdm1N/co5xETd+yUFUftck+mndPOB2+uM2h0RUXJPRLsCxQc4f2SyXk7FFpcexIxnJOTtPbhm3QvNen2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tINP+Xwl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tINP+Xwl"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so46101225e9.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097069; x=1781701869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGGkTraAD0p7vX1IpLNujGlYq1oxpkkVn3JacM319dU=;
        b=tINP+XwlYvDMFt0hE5pcqpXq9gHZsKieIh/iRNosmno+wht05j9bCMIR6kN4Yv6d7T
         iujIeA/PlUl3egJpb/3sw2TyPyVriOnAJXpqNh1ULul6ALL+/fGUYfz5Fh/s9P+OSqGj
         AY0JwC78DgaFSXMKO1cLYAidnnDdtk9s5Om8YVXSqM6h5qZF6hzrZA4b+UlWB4Fci5jB
         W6n1gfIRuHvpm6Mo0wA9Cbe2dCwBDSJbpWk1TfTHR1+v0A0ZYsSn1Shk/VnVgYT1ZKga
         R1SOcQZM8iqjcXgxe0N2sJonOrFLvP2LNkdJKO5sSXTm3Pb8hkte8oR65ATZm6TkuPYV
         LhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097069; x=1781701869;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGGkTraAD0p7vX1IpLNujGlYq1oxpkkVn3JacM319dU=;
        b=eoSL6q+hamiQEtBHK3Vau/yjyY2Vxsz0+r5lJ3OL7miehSAv2D3azu/8nFdwfi739N
         zwo/L5oi9sSmMDMZa871fgnttDk8b3PNS4WXMnmHk2RuFdwSSLhvW2P6L02HQ8BkgtyE
         EawgQ3gX7sO41W+iX+cbK/vULdxIEnZUtfBa1rcpJFFBCHKk+I0EIPv13NNxIy8mTwlB
         BfDYFVxJseDmDgsK30b7Ke2SGVmndE78+pQE+Dxu3IPHyDSbvUXTYMx3NFpnryLmlOL1
         0dPFMmhfqyaVPGnqIwjkEk9u18hY8H4e8dFRzvMi95X1YBXPW1Xei8M7NsnFHQtyCdYS
         DKtA==
X-Forwarded-Encrypted: i=1; AFNElJ+2A8FfZXnICCbfY60VSwo4bb8SWBMY110oKls8KZl4nz9SxRHC1Tj89qj3EJUQ8oavWAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcP/1qrcEcIJXTJH7UdT4HzEOm6wep487SUS6GUvtq+eHKJSs
	wehRchEOHzTTnwrWJtee0hFfUW/PtGpjJwdFIIquzIrTEKEUApuLwsP+
X-Gm-Gg: Acq92OEXr70dPxOD4I0gA5vZCFhz7viiID1RLJR2h2fyg1LqQdrYe411ncYg9SCuYQl
	Yj4eHyHNIJ8zj/RocEyBzbvC8JDOkWr8SLu05DLhtHNcdnvCkmonBmgW6b8//SAGIRKRZ97R1iE
	DSmNhx7ieAn5igHZHEdFsrF8qiMmRloIxbYvLL0k8LrfaO1Yo8drqoM25nxNnKyf4mLrnHr6iZ2
	N0lbHQgD/Ua9OjeccdZxjoQdSIsjGHUc0HTqs1cm7MNrm00upgkZobK5/csxd7ivDP8q952UdH/
	qTlyGVNdl/0F899SAFLUibEjt4Q+J3PA7PDGsMIU5d86h5cZ5p3tdV4haXgmTNAQt9ySiJWcYLm
	P5MYryJibzdDyjNNeFRF3upfYpQrirR+vlI9ehvGO3JsRrG9HW+K8UTVgWetsmafKfLYDKZuIfe
	uJAn2a+LbXUbA/643wdcr6hWOrq9WPIbmiVG/4EDH17iriRlgCfaS5gju6ZlnsosQCE/e4uI4jJ
	l7M/rgwKsy7N4dC
X-Received: by 2002:a05:600c:5252:b0:490:b2a6:8c1d with SMTP id 5b1f17b1804b1-490c25adb2fmr417816755e9.10.1781097069257;
        Wed, 10 Jun 2026 06:11:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm77742135f8f.36.2026.06.10.06.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:11:08 -0700 (PDT)
Message-ID: <cfade236-75bc-4679-a74a-6da82e6a5135@gmail.com>
Date: Wed, 10 Jun 2026 14:11:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 06/10] reset: introduce ability to skip updating HEAD
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
 <20260610-b4-pks-history-drop-v4-6-70d5f0ae8c25@pks.im>
Content-Language: en-US
In-Reply-To: <20260610-b4-pks-history-drop-v4-6-70d5f0ae8c25@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 10/06/2026 09:52, Patrick Steinhardt wrote:
> In a subsequent commit we'll introduce a new caller to
> `reset_working_tree()` that really only wants to update the index and
> working tree, without updating any references. Introduce a new flag that
> makes the caller opt in to updating HEAD and adapt all callers to set
> that flag.
> 
> Note that in a previous iteration we instead introduced a flag that made
> callers opt out of updating any references. This was somewhat awkward
> though because we already have the `UPDATE_ORIG_HEAD` flag, so the
> result was somewhat inconsistent.

Thanks for doing this. I've grepped for all the callers of reset_head() 
to confirm this patch adds RESET_HEAD_UPDATE_HEAD to them all.

I wonder if we should add a check for passing 
RESET_HEAD_UPDATE_ORIG_HEAD without RESET_HEAD_UPDATE_HEAD that calls 
BUG() as we don't support that. Everything else looks good.

Thanks

Phillip

> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   builtin/rebase.c | 14 ++++++++++----
>   reset.c          |  6 ++++--
>   reset.h          |  9 ++++++---
>   sequencer.c      |  4 +++-
>   4 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 06dcbaf5e8..10a306310c 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -607,7 +607,8 @@ static int move_to_original_branch(struct rebase_options *opts)
>   	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
>   		    opts->reflog_action, opts->head_name);
>   	ropts.branch = opts->head_name;
> -	ropts.flags = RESET_WORKING_TREE_REFS_ONLY;
> +	ropts.flags = RESET_WORKING_TREE_REFS_ONLY |
> +		      RESET_WORKING_TREE_UPDATE_HEAD;
>   	ropts.branch_msg = branch_reflog.buf;
>   	ropts.head_msg = head_reflog.buf;
>   	ret = reset_working_tree(the_repository, &ropts);
> @@ -693,6 +694,7 @@ static int run_am(struct rebase_options *opts)
>   		ropts.oid = &opts->orig_head->object.oid;
>   		ropts.branch = opts->head_name;
>   		ropts.default_reflog_action = opts->reflog_action;
> +		ropts.flags = RESET_WORKING_TREE_UPDATE_HEAD;
>   		reset_working_tree(the_repository, &ropts);
>   		error(_("\ngit encountered an error while preparing the "
>   			"patches to replay\n"
> @@ -862,7 +864,8 @@ static int checkout_up_to_date(struct rebase_options *options)
>   		    options->reflog_action, options->switch_to);
>   	ropts.oid = &options->orig_head->object.oid;
>   	ropts.branch = options->head_name;
> -	ropts.flags = RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
> +	ropts.flags = RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK |
> +		      RESET_WORKING_TREE_UPDATE_HEAD;
>   	if (!ropts.branch)
>   		ropts.flags |=  RESET_WORKING_TREE_DETACH;
>   	ropts.head_msg = buf.buf;
> @@ -1384,7 +1387,8 @@ int cmd_rebase(int argc,
>   
>   		rerere_clear(the_repository, &merge_rr);
>   		string_list_clear(&merge_rr, 1);
> -		ropts.flags = RESET_WORKING_TREE_HARD;
> +		ropts.flags = RESET_WORKING_TREE_HARD |
> +			      RESET_WORKING_TREE_UPDATE_HEAD;
>   		if (reset_working_tree(the_repository, &ropts) < 0)
>   			die(_("could not discard worktree changes"));
>   		remove_branch_state(the_repository, 0);
> @@ -1409,7 +1413,8 @@ int cmd_rebase(int argc,
>   		ropts.oid = &options.orig_head->object.oid;
>   		ropts.head_msg = head_msg.buf;
>   		ropts.branch = options.head_name;
> -		ropts.flags = RESET_WORKING_TREE_HARD;
> +		ropts.flags = RESET_WORKING_TREE_HARD |
> +			      RESET_WORKING_TREE_UPDATE_HEAD;
>   		if (reset_working_tree(the_repository, &ropts) < 0)
>   			die(_("could not move back to %s"),
>   			    oid_to_hex(&options.orig_head->object.oid));
> @@ -1877,6 +1882,7 @@ int cmd_rebase(int argc,
>   	ropts.oid = &options.onto->object.oid;
>   	ropts.orig_head = &options.orig_head->object.oid;
>   	ropts.flags = RESET_WORKING_TREE_DETACH |
> +		      RESET_WORKING_TREE_UPDATE_HEAD |
>   		      RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
>   		      RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
>   	ropts.head_msg = msg.buf;
> diff --git a/reset.c b/reset.c
> index 99f2c1b012..3ac99a51c0 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -92,6 +92,7 @@ int reset_working_tree(struct repository *r,
>   	const char *switch_to_branch = opts->branch;
>   	unsigned reset_hard = opts->flags & RESET_WORKING_TREE_HARD;
>   	unsigned refs_only = opts->flags & RESET_WORKING_TREE_REFS_ONLY;
> +	unsigned update_head = opts->flags & RESET_WORKING_TREE_UPDATE_HEAD;
>   	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
>   	unsigned dry_run = opts->flags & RESET_WORKING_TREE_DRY_RUN;
>   	struct object_id *head = NULL, head_oid;
> @@ -129,7 +130,7 @@ int reset_working_tree(struct repository *r,
>   		oid = &head_oid;
>   
>   	if (refs_only) {
> -		if (!dry_run)
> +		if (update_head)
>   			return update_refs(r, opts, oid, head);
>   		return 0;
>   	}
> @@ -197,7 +198,8 @@ int reset_working_tree(struct repository *r,
>   		goto leave_reset_head;
>   	}
>   
> -	if (oid != &head_oid || update_orig_head || switch_to_branch)
> +	if (update_head &&
> +	    (oid != &head_oid || update_orig_head || switch_to_branch))
>   		ret = update_refs(r, opts, oid, head);
>   
>   leave_reset_head:
> diff --git a/reset.h b/reset.h
> index 898e4a1e95..38b2891b53 100644
> --- a/reset.h
> +++ b/reset.h
> @@ -19,14 +19,17 @@ enum reset_working_tree_flags {
>   	/* Only update refs, do not touch the worktree */
>   	RESET_WORKING_TREE_REFS_ONLY = (1 << 3),
>   
> -	/* Update ORIG_HEAD as well as HEAD */
> -	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 4),
> +	/* Update HEAD */
> +	RESET_WORKING_TREE_UPDATE_HEAD = (1 << 4),
> +
> +	/* Update ORIG_HEAD */
> +	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 5),
>   
>   	/*
>   	 * Perform a dry-run by performing the operation without updating
>   	 * any user-visible state.
>   	 */
> -	RESET_WORKING_TREE_DRY_RUN = (1 << 5),
> +	RESET_WORKING_TREE_DRY_RUN = (1 << 6),
>   };
>   
>   struct reset_working_tree_options {
> diff --git a/sequencer.c b/sequencer.c
> index 4efe831178..e905b1b2d9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4678,7 +4678,8 @@ static void create_autostash_internal(struct repository *r,
>   	    has_uncommitted_changes(r, 1)) {
>   		struct child_process stash = CHILD_PROCESS_INIT;
>   		struct reset_working_tree_options ropts = {
> -			.flags = RESET_WORKING_TREE_HARD,
> +			.flags = RESET_WORKING_TREE_HARD |
> +				 RESET_WORKING_TREE_UPDATE_HEAD,
>   		};
>   		struct object_id oid;
>   
> @@ -4873,6 +4874,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>   		.oid = onto,
>   		.orig_head = orig_head,
>   		.flags = RESET_WORKING_TREE_DETACH |
> +			 RESET_WORKING_TREE_UPDATE_HEAD |
>   			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
>   			 RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK,
>   		.head_msg = reflog_message(opts, "start", "checkout %s",
> 

