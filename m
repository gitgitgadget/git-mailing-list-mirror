Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD222F8BEE
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956458; cv=none; b=Ju3rfCgTI3fRo6ktqY/bNahH0cTKaZsYwHcl7KMN1FRaZ31A+t2Gc9BkQVZ01D5/Ebex3CNwY5y+KaHpmw/UWTFwrJ2J6WmGvmQPWjwXX4UFxpZdoST120UmWzilCAzwmd8BwW48krVkg0eTQ5mV8RGDuV3S23HU0v8eA+97OMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956458; c=relaxed/simple;
	bh=poPx52Kj5pBeWN4nvm9qoNTnXXP5R18kescKx9S6Lg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmxFrGwac4X4HHyN2OGvoIQRzzacHEbwT016cUZVwiNREm8cZkR9rne8w/anpQtG+5Pj3KrhqoR/Ion0fMsMDRyiX9/Ok+2tmpYeNFzZ0HO+r5fLJQyGWzODn0Mf+dKiMg0ao0ulz7bgqKr9cZPpf83ZB02Ta9eYSilqBwoDphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el9t7rq5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el9t7rq5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b77b150aso379525e9.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783956455; x=1784561255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhEf1m9sHksKrR0EnJ9+jexRUa/R3RU20x6Wub+nlFo=;
        b=el9t7rq53D8Cf/XvzOxSdQ3YGtpohmBsxopWnHxoVdXNwJHfl1uCQ7inWHkMa2y4GK
         kj6ZW6DSdP9KN7oKUaonrvGMFLHxTLrRlHsqAblqHnEiyfHlraUkz+WBXKEuLQ376iIG
         kf8KV/naKYadZ5FSBQA+grJ4uJ+eJYvU09CNM9O7AbDNCdFUe/t0Tk3h42cQ/txFheCR
         2UkSfS3logkZCuuFmLebT6IW6UJ0tQTKkRiyA81cM7Dyi49234ItsyLKhQbLmx07UgtF
         /oV+fJ7+taiC9zThzOz7J/CVDAnb4zLW13NO9faJps34qfqEIYT6sLftr0djO6EjNvQo
         sdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783956455; x=1784561255;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhEf1m9sHksKrR0EnJ9+jexRUa/R3RU20x6Wub+nlFo=;
        b=EGwo5orP/lL6hcOxVOjeTZV6nq3mmdKKgkuUBrD+tP7/yPss6rjPuJ1VKMCgLfMms5
         L4GzVLhuvKWHR0sUKFr+UjAUIE0s8i9BNRu1bosKgNGDoNR8vXCUXmxvW7WDkIw3fsXv
         hH9Nj6N+d51I0EzZTb9PNCzA3y2s88afuVEMHFsEXhaBHFgjftMiv7q7IQy9zIsbHO/w
         nTodniV1X/+SeGRYIrVkr9UhuEYQHXy2cJsS+79kKgGaAYbA18ZCWINXA4jeL9PIZ6Du
         oiCjcI4W1qTuokq8/9UFDqlsQdCkVyeAfklxwmuAdqPB77NVIsXdWmFAo3WIsJqGnHcB
         mVSw==
X-Forwarded-Encrypted: i=1; AHgh+RohH/73mIEVM37i+JLDAykaD9b1ORPtFLllUUHl5X5HACG7pZFlWEEDlCdwFk4eOQNxsiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2N2H7nKfhEP01DjS6F2LQzxMDfQKyFwP10xpvdU5cFCOvaSGX
	XnoDUYUKTAIanFMiv4LkguR6rhaSrxIUYkuPLsWtren1KHuqsIziM7Y1
X-Gm-Gg: AfdE7ckGtlr3aHo/3dqSRlDETaClnqpTBDS5PWvBzwvyw61T3bRkHJ/boQoYxYF3OC0
	ZQYxys23QznbNfnDyxeTaCLXb1/I7vqZ9890USVzcG15yTDvzew9Hj2K7y2H9qgFsKVSwjeYZ06
	rB41NeWqvSYeyqt/a9rrOopg/CrR76vkgjtVcReWqtNFrakqG+m5NFtTn/076uLG/oiDuu8YZEb
	Da8Fd9fc+l7gTF77cjSMSDeE934IO+ZooYlBy33bitF8F0qwRPMbBTWTiOrcLB4cVLKHEvZF7qE
	mlrYJWKd66G2FF11bbiqmzl39bBA9EiZMDhVFETo3nxDY4YMDDTezvUYSOJ+BaYJsEGCD//N/wH
	zPhy1SPnV6PU6+1Cd3g9CcVCsqhTzLeIgPxEjCkpXWMEkzuT8XPxyQE2pTp7tsDAFkYRlFCp+/j
	lToVpTujS5pOlXQQXyYi2otsr4oHgSBKMS6EAwUHzAEn6ZOt8wMWl04wJsCju+FElIe8Wfo2MwS
	TtxpQ==
X-Received: by 2002:a05:600c:8518:b0:493:d100:b487 with SMTP id 5b1f17b1804b1-493f8780997mr94221625e9.0.1783956454854;
        Mon, 13 Jul 2026 08:27:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm126744355e9.2.2026.07.13.08.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 08:27:34 -0700 (PDT)
Message-ID: <278df7ad-caf1-40fa-b5f9-34d78f435fd0@gmail.com>
Date: Mon, 13 Jul 2026 16:27:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v18 7/7] branch: add --dry-run for --delete-merged
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <8d0323f4b30cdfed134ff2840cc8a9ab32f9db53.1782338106.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <8d0323f4b30cdfed134ff2840cc8a9ab32f9db53.1782338106.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/06/2026 22:55, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> With --dry-run, --delete-merged prints the local branches it would
> delete, one "Would delete branch <name>" line each, and exits
> without touching any ref. The same filtering applies, so the output
> is exactly the set that the real run would delete.

The same filtering as what? I think something like

"git branch --dry-run --delete-merged ..." prints one line per ref that 
would be deleted without modifing any refs.

would be sufficient
> --dry-run is only meaningful together with --delete-merged and is
> rejected otherwise.

Good
> @@ -346,13 +348,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
>   		free(target);
>   	}
>   
> -	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
> +	if (!dry_run &&
> +	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
>   		ret = 1;
>   
>   	for_each_string_list_item(item, &refs_to_delete) {
>   		char *describe_ref = item->util;
>   		char *name = item->string;
> -		if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
> +		if (dry_run) {
> +			if (!quiet)

This matches what we do without '--dry-run' but what use is '--dry-run 
--quiet' if it does not print anything?

> +				printf(remote_branch
> +					? _("Would delete remote-tracking branch %s (was %s).\n")
> +					: _("Would delete branch %s (was %s).\n"),
> +					name + branch_name_pos, describe_ref);
> +		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index b7595610d9..cddcde341d 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1892,8 +1892,12 @@ test_expect_success '--delete-merged deletes merged branches and spares the rest
>   	) &&
>   	sha=$(git -C repo rev-parse --short merged) &&
>   
> -	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
> +	git -C repo branch --dry-run --delete-merged origin/next >actual 2>&1 &&
> +	echo "Would delete branch merged (was $sha)." >expect &&
> +	test_cmp expect actual &&
> +	git -C repo rev-parse --verify refs/heads/merged &&
>   
> +	git -C repo branch --delete-merged origin/next >actual 2>&1 &&

I was wondering why the diff shows the line above being deleted and then 
added, it is because previously there was a blank line after it. The 
test for --dry-run looks good.
>   	echo "Deleted branch merged (was $sha)." >expect &&
>   	test_cmp expect actual &&
>   	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
> @@ -2050,4 +2054,9 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
>   	test_must_fail git -C repo rev-parse --verify refs/heads/kept
>   '
>   
> +test_expect_success '--dry-run without --delete-merged is rejected' '
> +	test_must_fail git -C forked branch --dry-run 2>err &&
> +	test_grep "requires --delete-merged" err

Nice

Thanks

Phillip
