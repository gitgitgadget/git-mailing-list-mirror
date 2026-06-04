Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1134C83C
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587474; cv=none; b=iAVQ4zcbY5aUg9/REjedb1qrEQpY5rSpgRxq6y2VBx0r+LGmfg5xrtaJgd1CD68Q+De0mRcJx0+5NLevt4s6uQMBUOvhsO7+VK6Sa9eOmTRpo3fWIm4j2uUWys/F/KRnyqQ0b0NcoMrUPUVX7u4kPvb0CuiPoAAPDjJcH0qH1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587474; c=relaxed/simple;
	bh=uQnjibjOlO0eSoYewBH69aX67zlGUQVDDPjP17KPJZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdWuRg64+dbdgIb1vXaF/IAT5O40Sg4OCBGWwddvkKClZv7C0YJuIq1xqNjICP966CP/sKJqDSgSSCJ+gbMKO2hPQVvD7kuflbvzwjsT31HYd1htGESNkdIWMe1h2527os9AoQHEbXrGT+FWbFa40eD+Vk71keW+rZuQVhGgNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pDoaPCtn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDoaPCtn"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so9829575e9.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780587471; x=1781192271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/aqZuaK1x0dyFRBAHQt3X3cgF7Nvi3DMnuDUbUgaq/g=;
        b=pDoaPCtnE4AovTUEzaF0qkGPCpBXGPBw9JIqrErqP0vBI3wcC5BnTuXlRW4QKKcs0+
         54CqXNn8eKeXaLKULyHj5FanhfEVVvfNIY8bhAk7DU6bREIcZmp44Xf9gK+YYZH2teZG
         BXhcHi420q3+kgobv1/195LG1xopwJia/biIEDLRbXvjwzAiUHxOo9b4HSt+FRX48PTh
         2ihSjq/EDaTwrSJQGOZx/MoDq6EjdqkDkbLsiaIT9duvr9aAdp2YTZAkSV3Qvkb3Yau9
         2/Y+mKOKbnQF4ymUMOsbKFQoOAtYDfQy8k8AIAbigtNexCoOQe/EIO+6Lh8LqTBgb8ca
         5dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780587471; x=1781192271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aqZuaK1x0dyFRBAHQt3X3cgF7Nvi3DMnuDUbUgaq/g=;
        b=bb96zyRvrTD2pyoxuHrdffH5L8tR4b6Haj5tpgOS8IMYRw4SGIYzaJL9tNNMqrvRY1
         jLxh8JGigIZzTeUNbSG4//WezQDavClIZ0SLJG6GRRlWYCrqy63v6eAVBFICkA4ELirt
         mkFBfKSi2wwX+CbQ5SCNMbrGL1Ks2Os2jdezfMjGRSQdE/snF2HinJyX4MTvPFS0khHW
         cheLU/L1VA4E0Man+Ou9fNla0aEUHSfRUe+FKDgq9VmbwocGPbB1ZOEDNLvEiKj12XbW
         8DOuslOjaUKdpWBS22mYEubYMUA6G11dpzSMt272MXUxyK5SBsCo1AIpiGZW5l3hrx0H
         IWLg==
X-Forwarded-Encrypted: i=1; AFNElJ8vzxY7PTYovuSCIBIe/u93+l+HQrI4JcHl0LncqqyrzX7WWxLkuaddmHmgTR/v9YBSH7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUO3fsCgm6h/qxWZYunMpFgSEAqfhuim3fn9RwKngtra74C+2
	EF4f9Hc2hoYjdIDLnn+Muw/9qg8YPN2p2BtYIu1BH4YqoAzP0WgEU7cv
X-Gm-Gg: Acq92OFKx/SRC8MYvrkeOUcopAc9ky0IASYW6I/q97s4aw5P0SO4vTP/oKGUOHQ/VnY
	qLcCF+Hb2yIYVBXN/vI/16cCgx0cE6hC16dsUFVpskO7Fo9l9bpmC2iqTqsEjpxdk61n0XkocBK
	Hf96aCKIHzYL2+nS0zl+P2z0tHajQJDD6OdTvHnWsYHkGKrNRF40lj39ikXTr/gNq7hMoJQ8pW0
	X1/Q5KB7Ar5gY9mS3NGyf0WvvSfNAgZXw7sqPPfNBhFemdyznD5GKWzy25hKK9iChmMIwoDByvq
	j1tXlgoQIp/wZ/01wRgjeyreOWQUJ+ESymVRA9cv3TmBQ6hS3j8JybEfFC0/kFBDSA5W7B2fj5H
	cESlIJApj5lNf6I+nZWienVI6/3i9tJXgo4Ue9s/5uVaE60lmLZ555Rgm1CDBv7oUvaurPKPSt7
	vXoIrAvnLWhJdMNg10nf5aIb5F1uvv1NUyQY0aDF76xqhtSui9TLQQfuW4P4shGQDbn8wEOhm+e
	a1EY6yE+t1I8A==
X-Received: by 2002:a05:600c:1c05:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490bc4e034fmr75791115e9.8.1780587470707;
        Thu, 04 Jun 2026 08:37:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7c6b966sm137251555e9.2.2026.06.04.08.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 08:37:50 -0700 (PDT)
Message-ID: <f982c386-e329-4ab0-b695-e540bcb9de3d@gmail.com>
Date: Thu, 4 Jun 2026 16:37:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rebase: skip branch symref aliases
To: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.git.1779946921.gitgitgadget@gmail.com>
 <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 11:27, Son Luong Ngoc via GitGitGadget wrote:
> From: Son Luong Ngoc <sluongng@gmail.com>
> 
> git rebase --update-refs can fail after the normal rebase path has
> updated the current branch when another local branch is a symref to it.
> This can happen during a default-branch rename where refs/heads/main
> points at refs/heads/master while users migrate.
> 
> The sequencer queues update-ref commands from local branch decorations.
> Commit 106b6885c7 (rebase: ignore non-branch update-refs) filters out
> decorations that are not local branches, such as HEAD and tags. A branch
> symref is different: it is still a local branch decoration, but if it
> resolves to another branch then that target branch is itself present in
> the decoration list and will be updated as a concrete branch.
> 
> Skip branch decorations whose symrefs resolve to refs/heads/*, because
> those targets are already represented by concrete branch decorations.
> This prevents aliases from scheduling a second update for the same
> branch. Keep symrefs to non-branch targets on the existing path.

Makes sense

> Preserve the existing checked-out branch handling before applying these
> skips. Such refs still need a todo-list comment instead of an update-ref
> command, even when the checked-out ref is the branch being rebased or a
> branch symref alias. Use a copy of the resolved HEAD ref so later ref
> resolution does not overwrite it.

I don't quite understand this. A symref that points to another branch 
should always be skipped. When we look up which branches are checked out 
(see worktree.c:add_head_info()) we use

  	refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
				 "HEAD",
				 0,
				 &wt->head_oid, &flags);

so it will never report a symref as being checked out - it always 
resolves any symrefs first.

If we have a symref pointing somewhere outside of "refs/heads" then we 
need to check whether the target is checked out, not the symref itself. 
I'm not sure how likely that is to happen in practice.

> diff --git a/sequencer.c b/sequencer.c
> index 1ee4b2875b..6ab8b47108 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6445,28 +6445,46 @@ static int add_decorations_to_list(const struct commit *commit,
>   				   struct todo_add_branch_context *ctx)
>   {
>   	const struct name_decoration *decoration = get_name_decoration(&commit->object);
> -	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> -						       "HEAD",
> -						       RESOLVE_REF_READING,
> -						       NULL,
> -						       NULL);
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	char *head_ref = refs_resolve_refdup(refs, "HEAD",
> +					     RESOLVE_REF_READING,
> +					     NULL, NULL);

This part and the test look good now
>   	while (decoration) {
>   		struct todo_item *item;
>   		const char *path;
> +		const char *resolved_ref;
> +		int flags = 0;
>   		size_t base_offset = ctx->buf->len;
>   
>   		/*
> -		 * If the branch is the current HEAD, then it will be
> -		 * updated by the default rebase behavior.
> -		 * Exclude it from the list of refs to update,
> -		 * as well as any non-branch decorations.
>   		 * Non-branch decorations may be present if the pretty format
>   		 * includes "%d", which would have loaded all refs
>   		 * into the global decoration table.
>   		 */
> -		if ((head_ref && !strcmp(head_ref, decoration->name)) ||
> -		    (decoration->type != DECORATION_REF_LOCAL)) {
> +		if (decoration->type != DECORATION_REF_LOCAL) {
> +			decoration = decoration->next;
> +			continue;
> +		}

If a decoration matches the current branch why don't we just skip it 
like we used to? (As an aside the existing code in wrong because if the 
user runs "git rebase --update-refs <upstream> <branch>" HEAD does not 
point to "<branch>" but lets not worry about that now)

> +		path = branch_checked_out(decoration->name);

As I said above if the symref target is anther branch we should skip it 
and if the target is not a branch then we need to check if the target is 
checked out so we need to resolve the ref before calling 
branch_checked_out().

Thanks

Phillip

