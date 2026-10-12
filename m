Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D033EB10
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814238; cv=none; b=A+vJvx3Rsx8zeE3qJiOu/+aqExeDidpFx7ElQPzQMlI3aHfMuQCoHXfmyavlsg3LrloyFFHzLfN0pTJyBO/EoxnH3tSL89/a/Yh47z8dTKbl1vt9FJw7/Kke4RxLeG3btuSglaJYGwdKg5kX8cfedL2dQ5uZWPoXlBofL65x96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814238; c=relaxed/simple;
	bh=21JbSD9Gnzd2CmS0xan7cZRXu/aP13dNd7wt+1i1Jhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chAXnCpiOZVfTarXyQEwnLE/jQyZTCnqGbUBPQYApbE6XJpNMyiDdDIF450P0TgyCzAxozs0TQoVNBmE5rcXI85+IvohRghboejbQMF5rIVPsh2uNxQBxT+J51I9q5nOfNZNfeAHkmFagawLt3rNygqVqEvOelRuZO66OjOV4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3zXyRic; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3zXyRic"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so20093145e9.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814235; x=1792419035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+gStG4ITvBljQz01VMx3CcHronHeDRg07AIV2kdx+jI=;
        b=P3zXyRicioxzfAwo/ZZpmcydk9uvkKLt/2ZnU1BtzCJQis44EGWb8xeuyzBAT52VM4
         HdOwjjqdH2fg6PcTyQ4v7C8IxCy1Yde2n7tEwJTKtEB9EAdfybxhXQYYl3i5CbwoA+/V
         b5xl7Ao9cVZ5NZTMJkHH3RNtnOMIDaRt1/mAyybBzFCJdcgF/QiwkbLN/ZYI6He1XK2x
         ZIKkA+h2+qlkVdI3O4ULtwFZafLtohv3amVQy8QsqBW2QNxep8lyU9z4gYRsyE2fLTKR
         zVR4GUXX6HBNOPV4q+LkfrfZBIlF6ZpywX/Us/OVw9uqrjvCSj8H3yliwqvQMRPeGqFt
         ObqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814235; x=1792419035;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+gStG4ITvBljQz01VMx3CcHronHeDRg07AIV2kdx+jI=;
        b=QtQ9bTNJtzZRGjvSin+s4r67QlfNdWqGeDVk1zfIdrYALYD5iYNxgUStlY5px3rSEn
         fjNb7ur5W8UR6bdPkCmLvqpDlpyLfU61QHazJEZhe6/HiXNgZyHtFcCvvY1u7Yu7qw9c
         WjZVVtxSW+IqaMsUR16e0b59g67orFcFDYeLVJjc6XacTtsQhj8cebEtMUfpfo+v+GvL
         IGTx5OlYFOywymFJ13Fg1AJFxvmPEEncwbAF1LAedpBIZ/tFWg3m4DH6lPSgZiqab52Q
         dHtCA0/fghMrDwFmIwzISXgQOHf0eiXfuMNdhF4Imgo6POG29HqXLaNGTEmiI700LeQa
         jsIA==
X-Gm-Message-State: AFq9FYLEEIGdKQEc97ikQnv/GWOBMpTnG3e57iP1dq7rwOCpG3m1g7EC
	NrAQXx3czA4gCHew0MPZeL5URKPieA6OeQ12PDX2s9wXHaw2/RR2VTop
X-Gm-Gg: AYBFou2r5zEpIGSK6231mLamKzqqMpcKbESsMime+EFRODBnokrszlQ74xfMCFK/91N
	JI6N8KiR9RWQmQ8K9GrzJU1Vj+/diEexDOGoJ3L0J/3tfGpN13dAKPai9Xyqcg4wN9fgl2jofY0
	12UUIYC0ERFdB5UD1iaKxSeUWf+uiib8SjpA5lyz/cB2Op2xaJXHhekn9ZoYhTHYAIBcYXgejT6
	HYmFtzUi5tcsw74rYvwEu3iGrlsRmyxKHvOc+LEJqAW0AFaPvGubkN5LG7P8ldWVlr5bTKMjpfa
	Txl7m/WkmY7L6B1WV5RDMBqB5hqtf4aKmYqEkDz7zE3jZCnnlJlJ5t0ZN993wvGg+qzjSiwD+0j
	5DFalidfv4z4+O8fgYLM/GCRNqWaYjXDxOHxI0Qw9dSpxpsTxeuB+NW30T8gZUzY9BDe5FFIon7
	/XAJdM+3hTI1aKm9z2Aeqs+b0WHnjkiI8OuElfgtd0k3JsUocg1iMLlCrtAJvZjl6Gd1SkVV0jt
	8GwdXHauOGKyjN7QmLoTOH7swpH3p2r/Gv5NVFG0e80IQt/kXCA
X-Received: by 2002:a05:600c:c165:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a18e4988ecmr179355845e9.7.1791814234901;
        Mon, 12 Oct 2026 07:10:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be96549sm405457455e9.6.2026.10.12.07.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 07:10:34 -0700 (PDT)
Message-ID: <9ac1a744-b326-4b61-869a-546fee80da20@gmail.com>
Date: Mon, 12 Oct 2026 15:10:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] merge: remember conflict labels
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Johannes Sixt <j6t@kdbg.org>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <cover.1791537203.git.phillip.wood@dunelm.org.uk>
 <182edb2e8874986206a38a0af005e4df9ef9dd8f.1791537203.git.phillip.wood@dunelm.org.uk>
 <xmqq1p9yjtcp.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq1p9yjtcp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 10/10/2026 01:24, Junio C Hamano wrote:
> 
> This function is called once for each conflicted path, which means
> we would read the "merge.renormalize" configuration variable and the
> MERGE_LABELS file, both of which will stay constant during a single
> conflicted "checkout -m".  The issue is shared with the original,
> but looking up the same configuration variable repeatedly would be
> helped with in-core configset cache.  Compared to that, the overhead
> added by this patch is to open the same unchanging file, read & parse,
> allocate and deallocate.
> 
> Perhaps we want to have another preliminary [PATCH 1.5/2] before
> this step to allow setting these "per invocation constants" once to
> be reused?  Then step [PATCH 2/2] can read labels in the prepare
> phace just once, use it from the data structure in
> checkout_merged(), and free them in release phase when we are done.

That's a good idea, I'll re-roll using the diff below (I assume you're 
happy for me to add your sign off?)

Thanks

Phillip

> 
> 
>   builtin/checkout.c | 37 +++++++++++++++++++++++++++++++------
>   1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git i/builtin/checkout.c w/builtin/checkout.c
> index c0f0d2c700..a02cbacf1d 100644
> --- i/builtin/checkout.c
> +++ w/builtin/checkout.c
> @@ -310,9 +310,27 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
>   		return error(_("path '%s' does not have their version"), ce->name);
>   }
>   
> +struct checkout_merged_data {
> +	int conflict_style;
> +	int renormalize;
> +	/* we will add more later */
> +};
> +
> +static void checkout_merged_release(struct checkout_merged_data *data)
> +{
> +	; /* nothing to free (yet) */
> +}
> +
> +static void checkout_merged_prepare(struct checkout_merged_data *data)
> +{
> +	int renormalize = 0;
> +	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
> +	data->renormalize = renormalize;
> +}
> +
>   static int checkout_merged(int pos, const struct checkout *state,
>   			   int *nr_checkouts, struct mem_pool *ce_mem_pool,
> -			   int conflict_style)
> +			   struct checkout_merged_data *data)
>   {
>   	struct cache_entry *ce = the_repository->index->cache[pos];
>   	const char *path = ce->name;
> @@ -324,7 +342,6 @@ static int checkout_merged(int pos, const struct checkout *state,
>   	struct object_id threeway[3];
>   	unsigned mode = 0;
>   	struct ll_merge_options ll_opts = LL_MERGE_OPTIONS_INIT;
> -	int renormalize = 0;
>   
>   	memset(threeway, 0, sizeof(threeway));
>   	while (pos < the_repository->index->cache_nr) {
> @@ -345,9 +362,8 @@ static int checkout_merged(int pos, const struct checkout *state,
>   	read_mmblob(&ours, the_repository->objects, &threeway[1]);
>   	read_mmblob(&theirs, the_repository->objects, &threeway[2]);
>   
> -	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
> -	ll_opts.renormalize = renormalize;
> -	ll_opts.conflict_style = conflict_style;
> +	ll_opts.renormalize = data->renormalize;
> +	ll_opts.conflict_style = data->conflict_style;
>   	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
>   				&ours, "ours", &theirs, "theirs",
>   				state->istate, &ll_opts);
> @@ -446,6 +462,7 @@ static int checkout_worktree(const struct checkout_opts *opts,
>   	int pos;
>   	int pc_workers, pc_threshold;
>   	struct mem_pool ce_mem_pool;
> +	struct checkout_merged_data checkout_merged_data = {0};
>   
>   	state.force = 1;
>   	state.refresh_cache = 1;
> @@ -462,6 +479,10 @@ static int checkout_worktree(const struct checkout_opts *opts,
>   	if (pc_workers > 1)
>   		init_parallel_checkout();
>   
> +	if (opts->merge) {
> +		checkout_merged_prepare(&checkout_merged_data);
> +		checkout_merged_data.conflict_style = opts->conflict_style;
> +	}
>   	for (pos = 0; pos < the_repository->index->cache_nr; pos++) {
>   		struct cache_entry *ce = the_repository->index->cache[pos];
>   		if (ce->ce_flags & CE_MATCHED) {
> @@ -479,10 +500,14 @@ static int checkout_worktree(const struct checkout_opts *opts,
>   				errs |= checkout_merged(pos, &state,
>   							&nr_unmerged,
>   							&ce_mem_pool,
> -							opts->conflict_style);
> +							&checkout_merged_data);
>   			pos = skip_same_name(ce, pos) - 1;
>   		}
>   	}
> +
> +	if (opts->merge)
> +		checkout_merged_release(&checkout_merged_data);
> +
>   	if (pc_workers > 1)
>   		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
>   					      NULL, NULL);

