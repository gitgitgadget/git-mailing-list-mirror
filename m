Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E85402BB7
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097060; cv=none; b=Y6zYcJdlEdRkhxklgUogJsXvORMInzVGwaun93SxFV/luy5Gy7ojcse07Uo7BzhDhHB78OqT2t8rkq2p8gH/PUJhf/DpvAUJJ3CJsQYAhDzeVxfSNIcSv4kOsh7XR/fNSefJw1nqw9zl5MG78mnQcB+VIASvUE73NsSPc55qDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097060; c=relaxed/simple;
	bh=Vei+ePkqpgJow7y8v0YM9+W2mXiDaC8St8stxUosLKM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hox3U218JnHqZdRW9RfyxnJiHmdxSBLr+qH0rTFqKdvoqwaYMQ7+XWgmkIsKRL+zojYwM7DnC1fdjYsBsD2ZVBKNm9jK08APgTg4vy2EIAzRF7qQEmv6Pb+8X2YDV4PV3IGum2xCqUs+N6/SvF1+UrelMjXUClOsclLfuVvj/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h66fFM3o; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h66fFM3o"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490e1904089so1088625e9.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097057; x=1781701857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mm7mboUicK9GMPQzop702tvTbzCImUVbKVZYw+IIy/4=;
        b=h66fFM3oF8HCls6PM0zm9c5//76nEcVMPnJyZnELbhkxqCCxXn2mxh1ulyFpWQdubR
         6NLvBBMTnMYV8ZUrDsr0qghYpbr4ypYDw/dZ0WlGJTwnC0r2rdApy6x3c/PDqh9Ps6P9
         DzB0iqOOlDNoeua1N5ktHe3APFK/saOYLuf3J7yljHS9/H+GCOIXkkLv2MGt1S4O8Okv
         X7HaNu8ZLagmJnIhJu9Z6PTBF9ziHf53/7oR5TAx9l3HD5sJ8ujjOQyFgMj1+4M9sTJW
         QfxtaC9Nqsp2dMQkTUj0Qf5qyDGmw6yOdZQb9aFigsePEfNAXOWew5kX1Nw705w2ZH/N
         TJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097057; x=1781701857;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mm7mboUicK9GMPQzop702tvTbzCImUVbKVZYw+IIy/4=;
        b=E+EyUKyLEZu2TKF7FU40NfWAVLoPeJt9If0F8lEPD3Jb/D7TnjkFmjoDDUUse1vTBS
         p0ypE7FAAuceKtOU9qb1xIakQJLm5mbu9cF2q9IVF1CliThjOGtmnNAF+iU73K8zPoaZ
         JLhwq5Bc0VKHOc3Thgaz+mKQp1om9i+06QU/pYb7d6wDEQRwlEo8GamHrz4z09n+8bZy
         bLr2qIBD0Q8ep9TZQODV3tih6uzBa08CGjk1tE+YHJLDEye1Zjlam34VpGzPwvZPn3HV
         F97lAADAtA7a7hX46Y6vosxzglFcxncGSNyB+ceJsjvat9Nbk0g5JlIvK0/7Gl6IWlvt
         p0ug==
X-Forwarded-Encrypted: i=1; AFNElJ9IyOXyZh5HbozVTsKfhDuykoNzm1cbXo2MAZeq0nRefPdWSml48Jvg4hOVno0FlBJ+8B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv31W7nGHpCa07UPmvHpa/yo4rxczkqMcQQ3UUI0+U6aN3nHlI
	4a4tV5pOsbaA2O4D3xfuYnr5GoGtFKV66J3fhfWAzUtk1ZsCrPYU9peh
X-Gm-Gg: Acq92OH8lqgpT5eQOzWufYhoqZlk6VR3oYGSsF3P1RY7aO2pHavBgEXsZk0A/2Wzw9o
	NyY2Cb+1sGBI2ae+5j1W7JLgeZT5iZ5lpPN+w2RytU/oWmG6Yni7K4TWss46tVteIWDsYaeTqLU
	VHotUjarBG7Q5NbHp0Xl0ZQGUMIrcmTqP0JPVO27Q27mr3kQI7WfgkjZ+MdH/G9gjLRF3sHoY8O
	l66s+I7HBTjGqTJ2t9dD5cbtEawSH+5wsv3xs9xTiQKXDbbKvbjIEdYCoejcGGvOXlLGdrtlYxb
	YXzXIq+xX9yefbbt11VVVz0eW2VNfjvCKci5bCWKurKMPk2e0MBsKm/zI7ctFjJrWGRnFjjf6SQ
	pbGKhQCAopoo7pFPxn7nUyQytD+7/+H1YCDfxLd0NgL0HorWd/R2BYuotMco++10IG5oChwEftv
	xXH6odAjDGru4evtm3FJb//7yq6BbWmdUuQGPkN64XO+2hCoyvojKfanD7drHeR9dXHxShchGFz
	O1TpjpsqhAnw48R
X-Received: by 2002:a05:600c:4f54:b0:490:e1a6:4d13 with SMTP id 5b1f17b1804b1-490e1a64d39mr4586585e9.15.1781097057204;
        Wed, 10 Jun 2026 06:10:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b59f0sm643277145e9.2.2026.06.10.06.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:10:56 -0700 (PDT)
Message-ID: <f886affe-66fe-4589-babd-937106b9c3fb@gmail.com>
Date: Wed, 10 Jun 2026 14:10:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 04/10] reset: modernize flags passed to
 `reset_working_tree()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
 <20260610-b4-pks-history-drop-v4-4-70d5f0ae8c25@pks.im>
Content-Language: en-US
In-Reply-To: <20260610-b4-pks-history-drop-v4-4-70d5f0ae8c25@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 10/06/2026 09:52, Patrick Steinhardt wrote:
> The flags passed to `reset_working_tree()` are declared as defines. This
> has fallen a bit out of practice nowadays, where we instead prefer to
> use enums. Furthermore, the prefix of those flags does not match the
> function name anymore after the rename in the preceding commit.
> 
> Adapt the code to follow modern best practices and adapt the flag names.

This looks good

Thanks

Phillip

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   builtin/rebase.c | 15 ++++++++-------
>   reset.c          | 12 ++++++------
>   reset.h          | 31 +++++++++++++++++++------------
>   sequencer.c      |  9 ++++++---
>   4 files changed, 39 insertions(+), 28 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 22fbba3c62..06dcbaf5e8 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -607,7 +607,7 @@ static int move_to_original_branch(struct rebase_options *opts)
>   	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
>   		    opts->reflog_action, opts->head_name);
>   	ropts.branch = opts->head_name;
> -	ropts.flags = RESET_HEAD_REFS_ONLY;
> +	ropts.flags = RESET_WORKING_TREE_REFS_ONLY;
>   	ropts.branch_msg = branch_reflog.buf;
>   	ropts.head_msg = head_reflog.buf;
>   	ret = reset_working_tree(the_repository, &ropts);
> @@ -862,9 +862,9 @@ static int checkout_up_to_date(struct rebase_options *options)
>   		    options->reflog_action, options->switch_to);
>   	ropts.oid = &options->orig_head->object.oid;
>   	ropts.branch = options->head_name;
> -	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +	ropts.flags = RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
>   	if (!ropts.branch)
> -		ropts.flags |=  RESET_HEAD_DETACH;
> +		ropts.flags |=  RESET_WORKING_TREE_DETACH;
>   	ropts.head_msg = buf.buf;
>   	if (reset_working_tree(the_repository, &ropts) < 0)
>   		ret = error(_("could not switch to %s"), options->switch_to);
> @@ -1384,7 +1384,7 @@ int cmd_rebase(int argc,
>   
>   		rerere_clear(the_repository, &merge_rr);
>   		string_list_clear(&merge_rr, 1);
> -		ropts.flags = RESET_HEAD_HARD;
> +		ropts.flags = RESET_WORKING_TREE_HARD;
>   		if (reset_working_tree(the_repository, &ropts) < 0)
>   			die(_("could not discard worktree changes"));
>   		remove_branch_state(the_repository, 0);
> @@ -1409,7 +1409,7 @@ int cmd_rebase(int argc,
>   		ropts.oid = &options.orig_head->object.oid;
>   		ropts.head_msg = head_msg.buf;
>   		ropts.branch = options.head_name;
> -		ropts.flags = RESET_HEAD_HARD;
> +		ropts.flags = RESET_WORKING_TREE_HARD;
>   		if (reset_working_tree(the_repository, &ropts) < 0)
>   			die(_("could not move back to %s"),
>   			    oid_to_hex(&options.orig_head->object.oid));
> @@ -1876,8 +1876,9 @@ int cmd_rebase(int argc,
>   		    options.reflog_action, options.onto_name);
>   	ropts.oid = &options.onto->object.oid;
>   	ropts.orig_head = &options.orig_head->object.oid;
> -	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
> -			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +	ropts.flags = RESET_WORKING_TREE_DETACH |
> +		      RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
> +		      RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
>   	ropts.head_msg = msg.buf;
>   	ropts.default_reflog_action = options.reflog_action;
>   	if (reset_working_tree(the_repository, &ropts)) {
> diff --git a/reset.c b/reset.c
> index 799596398b..4ca7f23a25 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -16,9 +16,9 @@ static int update_refs(struct repository *repo,
>   		       const struct object_id *oid,
>   		       const struct object_id *head)
>   {
> -	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
> -	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> -	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
> +	unsigned detach_head = opts->flags & RESET_WORKING_TREE_DETACH;
> +	unsigned run_hook = opts->flags & RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
> +	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
>   	const struct object_id *orig_head = opts->orig_head;
>   	const char *switch_to_branch = opts->branch;
>   	const char *reflog_branch = opts->branch_msg;
> @@ -90,9 +90,9 @@ int reset_working_tree(struct repository *r,
>   {
>   	const struct object_id *oid = opts->oid;
>   	const char *switch_to_branch = opts->branch;
> -	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
> -	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
> -	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
> +	unsigned reset_hard = opts->flags & RESET_WORKING_TREE_HARD;
> +	unsigned refs_only = opts->flags & RESET_WORKING_TREE_REFS_ONLY;
> +	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
>   	struct object_id *head = NULL, head_oid;
>   	struct tree_desc desc[2] = { { NULL }, { NULL } };
>   	struct lock_file lock = LOCK_INIT;
> diff --git a/reset.h b/reset.h
> index f130152014..2e5826de99 100644
> --- a/reset.h
> +++ b/reset.h
> @@ -6,16 +6,22 @@
>   
>   #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
>   
> -/* Request a detached checkout */
> -#define RESET_HEAD_DETACH (1<<0)
> -/* Request a reset rather than a checkout */
> -#define RESET_HEAD_HARD (1<<1)
> -/* Run the post-checkout hook */
> -#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
> -/* Only update refs, do not touch the worktree */
> -#define RESET_HEAD_REFS_ONLY (1<<3)
> -/* Update ORIG_HEAD as well as HEAD */
> -#define RESET_ORIG_HEAD (1<<4)
> +enum reset_working_tree_flags {
> +	/* Request a detached checkout */
> +	RESET_WORKING_TREE_DETACH = (1 << 0),
> +
> +	/* Request a reset rather than a checkout */
> +	RESET_WORKING_TREE_HARD = (1 << 1),
> +
> +	/* Run the post-checkout hook */
> +	RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK = (1 << 2),
> +
> +	/* Only update refs, do not touch the worktree */
> +	RESET_WORKING_TREE_REFS_ONLY = (1 << 3),
> +
> +	/* Update ORIG_HEAD as well as HEAD */
> +	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 4),
> +};
>   
>   struct reset_working_tree_options {
>   	/*
> @@ -33,7 +39,7 @@ struct reset_working_tree_options {
>   	/*
>   	 * Flags defined above.
>   	 */
> -	unsigned flags;
> +	enum reset_working_tree_flags flags;
>   	/*
>   	 * Optional reflog message for branch, defaults to head_msg.
>   	 */
> @@ -45,7 +51,8 @@ struct reset_working_tree_options {
>   	const char *head_msg;
>   	/*
>   	 * Optional reflog message for ORIG_HEAD, if this omitted and flags
> -	 * contains RESET_ORIG_HEAD then default_reflog_action must be given.
> +	 * contains RESET_WORKING_TREE_UPDATE_ORIG_HEAD then
> +	 * default_reflog_action must be given.
>   	 */
>   	const char *orig_head_msg;
>   	/*
> diff --git a/sequencer.c b/sequencer.c
> index d73ecf0384..4efe831178 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4677,7 +4677,9 @@ static void create_autostash_internal(struct repository *r,
>   	if (has_unstaged_changes(r, 1) ||
>   	    has_uncommitted_changes(r, 1)) {
>   		struct child_process stash = CHILD_PROCESS_INIT;
> -		struct reset_working_tree_options ropts = { .flags = RESET_HEAD_HARD };
> +		struct reset_working_tree_options ropts = {
> +			.flags = RESET_WORKING_TREE_HARD,
> +		};
>   		struct object_id oid;
>   
>   		strvec_pushl(&stash.args,
> @@ -4870,8 +4872,9 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>   	struct reset_working_tree_options ropts = {
>   		.oid = onto,
>   		.orig_head = orig_head,
> -		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
> -				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
> +		.flags = RESET_WORKING_TREE_DETACH |
> +			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
> +			 RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK,
>   		.head_msg = reflog_message(opts, "start", "checkout %s",
>   					   onto_name),
>   		.default_reflog_action = sequencer_reflog_action(opts)
> 

