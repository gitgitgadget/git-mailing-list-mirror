Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBC3A1D2
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348693; cv=none; b=YpzHC1d9nwZvEsmIrUdKG4woom+CW7N5Krh0HKvYn+bvdjYka0cgkT0SSXViaowLyiEXrLN7CV7D7rg27nORVpxgkCUyCcBoNwB79EfrGlOPvLa+htCxVG50ozBXdyUHMngo0Bw6x0kkmIBt0fLzkoBieRuha2Tb3JPseMKGMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348693; c=relaxed/simple;
	bh=1jgSuV/P4stlm57DR854+Jk1swEyTrgUF0AJyzfQM1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqihMCbfwc6AqYV7r98x+5oOEQj6P6ypuvkqzBR18HZms4WrgLUNTeJ8IFq3LoIttXMB7lOZVi9LLn+bPTpVw6/J8id+CCNFRfIFTv4Ms9+ja9BQc3Jj6RIaR8nlhInJCm1MM33Uz456KKOg7R76k+3HOIwfcDc04oPYfzgmSOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nxrb35ix; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxrb35ix"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-671a2f4fd28so6492252a12.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776348690; x=1776953490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yz90/ZOulhjZinA9QmyQYGxseycGOO5HmtX4V/wD46U=;
        b=Nxrb35ix7Sm/6OmxEBDz05qlCnPTSA8Iz1DxEt17qW9ERKJXjbSzfCNUuKM1BtMHls
         ofoDaptoo3GcIywKOHGq4VOIJEp1ra7lx9NHUQen3cafcYvaLCTM2ru9PRELrs8U1OYA
         k1rJgrx/fpRqz0wT91a0Mfc4ZcYG59/OJyUzdKH0EUtcsS7DT3IgBobRDloixOvueN+/
         ZRGs1d/uBDD/jcJYim2jSGZ0CIo816bEAeRYPX5MzzHEDUn4YNhsUGLt5DG7ggYhgwKw
         eLAStoslaI8G4xZVqGtx5L2VXDpEV1NIecVMjsrHC1x1Qj0U74zdFeRqRK3QUh/h5+WW
         X4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776348690; x=1776953490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz90/ZOulhjZinA9QmyQYGxseycGOO5HmtX4V/wD46U=;
        b=RM/BXIUEJ0rwvY0vna8yZ9bMxa9sPWKSm4C3VZy6cGaq4HYDmH20vMhQPbnLfetfHU
         oBjoSJt3mIT7BleZ305/X9hn6wa/VFZKLlOnx/T48Yon1G37v9UO9lvPJp/bIemPMgV+
         wbPgTQCreAplnDbHjGZvfGnpYfxvnLSlmN5pP0TDwlFPkM8P91WOGCZCkwWT6v0MEmvl
         vx4iBhm+du/osJCAYuqVdORHk/PCg6tf/olxsE8LsO/B+eYCr+/d3doyC15ij95mZjPJ
         Q9c8BTb3ZLwHSMDT3eQ9KR4736uLQ5l7Gu1ECFOCfwBOedfWLLuc3zWqw2aDt0NRz3f4
         JhSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CkqZM3tSKf/0nSM7Geu2JPIvtw/AiyUGNQdmeU02MNzuWXrmHBMeNCHbWgge/DOT9kk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2c7J59gNoftmyZnCbjyEsZDCFLmKwQDYge6iqzHBg6U1i7X/
	LG0Fb0yjumhHdhT2vwdF/xaodTwsohf7/YseWv9e3rc4tS/mjeRLMpPnrSW1BnkX
X-Gm-Gg: AeBDies7r9xs0H5GeHCmgVn302qHtpA2P/zw2AIRqn8FIGn7hzlNIfMq6HpsRA2c/Z3
	jwq9JsCbmbuSwf7YGfkyv82WHhE9559H/v75cx0yMHonPjKiah2iIyz522Wq7Uo0Gh6Y/OhvoVh
	tj/c5GbMaQA12fe59zbCGeSStY0qROJQaxtGKOmnaOPtpqXcG8kQF6AqYps9nvUVpPArX8RrfLI
	KacRj/CrV7pm9nkLVFYvD7H6tv95SwuFWKqI1ZH24Xt5/ocNlYuNPFPUs2TNto10wKUAAKqsa5I
	adN/sXpdWb7goGnOgArr7zuzc+lL7NZomqGYSiWRk9PrUKFo1vmVDAIy8uqEr0+5cnoMtiqktnX
	1yUzlDM7m0fxy5ItTZzFJat8axLeNIKEB0CTuwJwZMbWMnbX8CY0OySpuB2nTj7pQ6vXrpKBUGt
	4p3GESXj3QaX5FsfaVvxxyVMxCB9wvRwuYUuGzVvJF4YpEW3cGVv8dUigNRu3vqEBTNtA0zw==
X-Received: by 2002:a05:6402:5188:b0:670:a3f1:a56b with SMTP id 4fb4d7f45d1cf-670a3f1a87emr12985082a12.5.1776348690085;
        Thu, 16 Apr 2026 07:11:30 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237d8b055sm1243170a12.10.2026.04.16.07.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:11:29 -0700 (PDT)
Message-ID: <9885d0e1-2d0f-4cde-b4ed-671a3ba173e5@gmail.com>
Date: Thu, 16 Apr 2026 10:11:26 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] backfill: reject rev-list arguments that do not make
 sense
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2088.git.1776297482.gitgitgadget@gmail.com>
 <6c76f1e862790858297ff9b1debc1a38756b1913.1776297482.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <6c76f1e862790858297ff9b1debc1a38756b1913.1776297482.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/2026 7:58 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Some rev-list options accepted by setup_revisions() are silently
> ignored or actively counterproductive when used with 'git backfill',
> because the path-walk API has its own tree-walking logic that bypasses
> the mechanisms these options rely on:
> 
>   * -S/-G (pickaxe) and --diff-filter work by computing per-commit
>     diffs in get_revision_1() and filtering commits whose diffs don't
>     match.  Since backfill's goal is to download all blobs reachable
>     from commits in the range, filtering out commits based on diff
>     content would silently skip blobs -- the opposite of what users
>     want.
> 
>   * --follow disables path pruning (revs->prune) and only makes
>     sense for tracking a single file through renames in log output.
>     It has no useful interaction with backfill.
> 
>   * -L (line-log) computes line-level diffs to track the evolution
>     of a function or line range.  Like pickaxe, it filters commits
>     based on diff content, which would cause blobs to be silently
>     skipped.

I think these make a lot of sense, especially because these
computations require downloading missing blobs in order to find
the diffs that justify some of the choices of commit filtering.
 
>   * --diff-merges controls how merge commit diffs are displayed.
>     The path-walk API walks trees directly and never computes
>     per-commit diffs, so this option would be silently ignored.

I think there are a few other "format" based options that were
silently ignored on purpose, because there's no output. Perhaps
we should change the use of options like this to a warning instead
of a failure?

>   * --filter (object filtering, e.g. --filter=blob:none) is used by
>     the list-objects traversal but is completely ignored by the
>     path-walk API, so it would silently do nothing.

This is correct to remove because while it doesn't work with
path-walk right now, it might in the future. We don't want the
filter to mess with the functionality of 'git backfill' that sets
its own scope for which blobs to download.

> Rather than letting users think these options are being honored,
> reject them with a clear error message.

I agree that the majority of these should be hard failures. As
mentioned, some could be soft warnings. That could be an
adjustment to make in the future, so is not blocking for this
patch.

> +static void reject_unsupported_rev_list_options(struct rev_info *revs)
> +{
> +	if (revs->diffopt.pickaxe)
> +		die(_("'%s' cannot be used with 'git backfill'"),
> +		    (revs->diffopt.pickaxe_opts & DIFF_PICKAXE_REGEX) ? "-G" : "-S");
> +	if (revs->diffopt.filter || revs->diffopt.filter_not)
> +		die(_("'%s' cannot be used with 'git backfill'"),
> +		    "--diff-filter");
> +	if (revs->diffopt.flags.follow_renames)
> +		die(_("'%s' cannot be used with 'git backfill'"),
> +		    "--follow");
> +	if (revs->line_level_traverse)
> +		die(_("'%s' cannot be used with 'git backfill'"),
> +		    "-L");
> +	if (revs->explicit_diff_merges)
> +		die(_("'%s' cannot be used with 'git backfill'"),
> +		    "--diff-merges");
> +	if (revs->filter.choice)
> +		die(_("'%s' cannot be used with 'git backfill'"),
> +		    "--filter");
> +}
> +

My only nit-pick suggestion is to make the translated string a
macro so it can be more obvious that it is repeated exactly.

Thanks,
-Stolee

