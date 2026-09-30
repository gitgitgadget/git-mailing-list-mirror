Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700202F8E91
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783384; cv=none; b=jaiGej05NSLNM8ESwAB46/aFXGVntMo9gdnT0pYvfQgmcPLQLIXLCnZ5AtGboNh3S0TLoi3lUs+Lb35Ix9ZykwwppwruYXtZW0K9uZjVef+f0+Q58IT7A0qYuF6xPiPBGrwgV7lIZyThx+WpD33pv6fUPEYuChnLXU5aPeyLDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783384; c=relaxed/simple;
	bh=zdpNQNRc9doskpNYXgamgNvM2z1MKUv5LyT+DpfX+ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THNG/HJTogKvEkA/c4ktTtwAHxXcTtny/uRhxDuIva7W0aMSTFSMW/yBpqpSTKm+DroAJUA8g5yoDRR3xDGc0DhJzHC5WwFJB6fkupmVVYXUEmtWp2MocetVet8O8exgyJdQ8WzQjBtf+JsFz6JoOu2CB5lPcgBra4s6LCrPo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8DHh6ep; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8DHh6ep"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a8b9acbc6so852781466b.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783373; x=1791388173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rLv1u5U9w7sLuGp3UWxtX8w2wpl1wPZzW4nou6DSs9o=;
        b=D8DHh6epYiSXRRPcELbF+7P1ImCZLgRIhZtLk1zycV5+kuhe1GeT/xwHVPxO/XZBVA
         wa08R5LdzEvpDD54kZLMGk7Hw4r1/ceiUm8O0kLh8P+6fSTX6UIa1EpOEk6dOXOAnQKa
         BM6qPMIqnuxIEizSOoDPGookTF13x+Cm0qLwz629uxRL3jLhXvHA0BcWzOcOtMyMT3A1
         DFSsUxSXPvSWxa48dfRm5NnLyScpWDivzeZKUd7kXRag7qDzy7iqB1YqroyCfGZitHuG
         ZN8uow2bnc34bsGU7zLYtbk9plrdIIjZ3fxgBXwj3xtKN9R31vh5agSmvZrS3ZynC1Dl
         jzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783373; x=1791388173;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rLv1u5U9w7sLuGp3UWxtX8w2wpl1wPZzW4nou6DSs9o=;
        b=wzBgDcYpsXc3N+6Rw2RnNnpraDFeeWsviy65+ueCoquc//BAK4MaYrjxl92TQVUGR4
         hezvXjmr1le9yTOigT2JcXSrMdnH1xapBVnQtLdH1kl6Nz3YOcGQ+m8lMN82DYZtTC1c
         ZjljD63mrCpdke532X/HiEZh+HOiPmm59Vgit+X1OGTMcSvk6p1Ihak18K8Nku0Fp0yw
         JZLlQEsRgF3gXgMAM+JnZQ4qWY1RTd50WkLEbtH5FnPzQk67tNuleZrW+6NOOYI1MSZa
         Yn6WHjxBuutpmYcqjQmMXkyvO4M5wpcDpkkRZbDGvE5dP1D2rIca2CkRl5MbjqbMMBok
         E4iA==
X-Forwarded-Encrypted: i=1; AKwUvBzFfvq8UxuwsY7GJ42CT7eap5cO6XasBcZNR5Sy4dpQgF4aSfyEboFF/nwbLK+6EYjeF44=@vger.kernel.org
X-Gm-Message-State: AFuF++kutykBAb20NV2TaLhWH8Wh7KE/j6bjQz2jWEokmlNyY7UGTd/V
	vVeraT9EpYfpbdemfcFrrE0VrBy+DrUjCICwZxll3brgq68BEHhnNvK1
X-Gm-Gg: AYBFou1hNp7ZKm6VXObDCHN2DIhih8ninq3S9/nXTrZQPUwlmWbU7hghNdGXPi18b9z
	iRUg7gDVpJ75w/3UIsNBku0DJosgslrv7cwUhewxOsZSoONXy6WXaoQu0qGBS4UzkamQ3tr0mlS
	GdnhWQuB6hY/RIicOGQB5iQFVcmskQUyjqxoZZWtTMh5VU8hw6EhZvdgBbmk0ryS4yV1qqlSWxy
	RJUr8B9f+/hdq1Gz4DQrBOEQinC0zcN7RXb4C7d3UUkQWo3D67a4nQeGxwNlJJ8BhSA2vOoGngH
	FCKmoAEnEL6c+bGh13VS2LLhjHrKXo6UzO5i0n2CH9hCH43CS/kenWkSYVC4Dy0NLNVb+6nCKjw
	yAOYpezuoRswOJJkEVg1rNnjgc/IwOMum8zE09Uj7/tGZhUcuxWJJlqC3L6tL/RekgkKuBy/GdC
	QI3PC7KCfUD7HcRHxnUusy28ZZyqdaXdvJPjJ0oOu92FA5DH1EIumwrpXSMD0QLq3vA5jGVLJP1
	Oomvq5foV0E8WiPrFogZMx1fQPhxhCERm8TgnDEpmACTr7xZNI48w==
X-Received: by 2002:a17:907:7215:b0:c2e:c8c:e123 with SMTP id a640c23a62f3a-c2e23cac5d3mr147766366b.10.1790783373152;
        Wed, 30 Sep 2026 08:49:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31ce362esm28776766b.30.2026.09.30.08.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 08:49:32 -0700 (PDT)
Message-ID: <8b81c508-ac67-498d-b78f-a4b5dab8c198@gmail.com>
Date: Wed, 30 Sep 2026 16:49:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] t5520: don't expire reflogs where it matters
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano
 <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
 <pull.2243.v2.git.1790701691022.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2243.v2.git.1790701691022.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

Thanks for rewording this, it is much better now, but the comment about 
autostash at the end of the first paragraph is incorrect I think. As I 
think we need to fix that I've left a couple of other suggestions as well.

On 29/09/2026 18:08, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> "git merge" saves any uncommitted changes with "git stash" before it
> tries a merge strategy. When the strategy does not handle the merge,
> it restores them with "git stash apply --index". If some of the
> changes are staged, that runs "git reset", which writes an entry to
> the reflog of HEAD. 

Up to here it all makes sense
The autostash tests in this script run eight such merges.

This doesn't make sense to me. The tests that use "--autostash" will 
clear any changes from the index and worktree and so will never need to 
stash anything while trying different merge strategies which means those 
tests do not run "git stash apply --index".
> 
> An upcoming change makes "git stash apply --index" merge the index
> in-core, so it no longer runs "git reset" and those entries go away.
> Another makes the default "merge" backend of "git rebase" run auto
> maintenance when it finishes. Together, they change when auto
> maintenance expires all reflogs, which it does once a hundred entries
> in the reflog of HEAD are due to expire.

The second half of this sentence is true, but I'm not sure it is very 
relevant, all that really matters is that we're triggering "git reflog 
expire" at a different point in the test run which is already explained 
by the first half.

> With both, the expiry comes at the end of the "git pull --rebase" in

"With both" sounds a bit strange to me. Maybe

This means that unfortunately the reflogs are expired at the end of "git 
pull --rebase" in ...

> the "--rebase with rebased upstream" test. The "git pull --rebase -f"
> in the next test looks for the fork point in the reflog of
> refs/remotes/me/copy, but as the test suite dates every reflog entry
> to 2005, the expiry has emptied that reflog. Pull then finds no fork
> point, so the rebase also replays copy-orig, the commit "copy" was
> rewound from, and it conflicts.

Good explanation

> Disable reflog expiration in this script, as ea7d894f44 (t34xx: don't
> expire reflogs where it matters, 2026-02-24) did for the rebase tests,
> so that the test no longer depends on where the expiry falls.

Also good

Thanks

Phillip

> Reported-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Assisted-by: Claude Fable 5.1
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> ---
>      t5520: don't expire reflogs where it matters
>      
>      The t5520 failure Junio saw in 'seen' with Ben Knoble's stash series,
>      bisected by Ben to tb/rerere-lock-grace and taken apart in the thread:
>      https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gmail.com/
>      
>      Changes since v1: only the commit message, rewritten along the points
>      Phillip raised on Ben's copy of this patch:
>      https://lore.kernel.org/git/3547f4aa-649a-4f46-868c-0e50dfa69466@gmail.com/
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2243%2Fthomasbachem%2Ft5520-reflog-expire-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2243/thomasbachem/t5520-reflog-expire-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2243
> 
> Range-diff vs v1:
> 
>   1:  1d8d6ed7f1 ! 1:  6699f3782e t5520: don't expire reflogs where it matters
>       @@ Metadata
>         ## Commit message ##
>            t5520: don't expire reflogs where it matters
>        
>       -    The "--rebase -f with rebased upstream" test computes its fork point
>       -    from the reflog of refs/remotes/me/copy, and the entry it needs is
>       -    the one that the fetch of the test before it wrote. Like every reflog
>       -    entry the suite writes after test_tick, it is dated 2005, so the
>       -    first "git reflog expire --all" after that fetch removes it. Pull
>       -    then finds no fork point and rebases onto the merge head with the
>       -    merge head as the upstream, and the rewound commits come back as a
>       -    conflict.
>       +    "git merge" saves any uncommitted changes with "git stash" before it
>       +    tries a merge strategy. When the strategy does not handle the merge,
>       +    it restores them with "git stash apply --index". If some of the
>       +    changes are staged, that runs "git reset", which writes an entry to
>       +    the reflog of HEAD. The autostash tests in this script run eight such
>       +    merges.
>        
>       -    Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
>       -    default, 2026-02-24) auto maintenance runs that expiry once the reflog
>       -    of HEAD holds a hundred entries it would remove, the default of
>       -    maintenance.reflog-expire.auto. Which run crosses the threshold
>       -    depends on the entries and maintenance runs before it, so the script
>       -    passed by chance: a stash topic that no longer runs "git reset" from
>       -    "stash apply --index" and a rebase topic that runs auto maintenance
>       -    at the end of "git rebase" together move the expiry between the two
>       -    tests.
>       +    An upcoming change makes "git stash apply --index" merge the index
>       +    in-core, so it no longer runs "git reset" and those entries go away.
>       +    Another makes the default "merge" backend of "git rebase" run auto
>       +    maintenance when it finishes. Together, they change when auto
>       +    maintenance expires all reflogs, which it does once a hundred entries
>       +    in the reflog of HEAD are due to expire.
>        
>       -    Pin the expiry as ea7d894f44 (t34xx: don't expire reflogs where it
>       -    matters, 2026-02-24) did for the rebase tests. That covers a "git gc"
>       -    as well, which expires reflogs on its own, where turning off the auto
>       -    trigger of the reflog-expire task alone would not.
>       +    With both, the expiry comes at the end of the "git pull --rebase" in
>       +    the "--rebase with rebased upstream" test. The "git pull --rebase -f"
>       +    in the next test looks for the fork point in the reflog of
>       +    refs/remotes/me/copy, but as the test suite dates every reflog entry
>       +    to 2005, the expiry has emptied that reflog. Pull then finds no fork
>       +    point, so the rebase also replays copy-orig, the commit "copy" was
>       +    rewound from, and it conflicts.
>       +
>       +    Disable reflog expiration in this script, as ea7d894f44 (t34xx: don't
>       +    expire reflogs where it matters, 2026-02-24) did for the rebase tests,
>       +    so that the test no longer depends on where the expiry falls.
>        
>            Reported-by: Junio C Hamano <gitster@pobox.com>
>            Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> 
> 
>   t/t5520-pull.sh | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 27f38ab3c8..bc818605a5 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -35,6 +35,12 @@ test_pull_autostash_fail () {
>   }
>   
>   test_expect_success setup '
> +	# Commit dates are hardcoded to 2005, and the reflog entries will have
> +	# a matching timestamp. Maintenance may thus immediately expire
> +	# reflogs if it was running.
> +	git config set gc.reflogExpire never &&
> +	git config set gc.reflogExpireUnreachable never &&
> +
>   	echo file >file &&
>   	git add file &&
>   	git commit -a -m original
> 
> base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3

