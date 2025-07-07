Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29616EED8
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751888603; cv=none; b=Xou7vcT47HwOKL1xqBHzX3uwa/xVlJnNtV1v4k99jgY6tKNlzITTmvKns6/wzKI20lLHN5/Ot4DQ2bE/B5s+gyKwV45MBS1sul1WAubkZBM7JV+39rOa5ehAVjYkQ38HLgW4m+fj4oaBBlG0KBD097YcUfHgBprqClfdOIUaQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751888603; c=relaxed/simple;
	bh=c6ftFEkdjyz9Pu7zJhECAVttIkJI2PmeXioD6iKnkt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4hBwqhaUk5rzzZT/Zet6YxIqi0vL9BwNUBgx14siOPtS/9CrtdY5ExuSyNvLU23hA8HetDccDevOXGdwg/PcF+ANL2NW2Pxhb1V4c2ycIBbo+91W6B37nS6Rw+Bl2nTI2k3Nc0j9gsJsFypp33fSO09fA6On/s48Ls0ywPLrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akz7fdbD; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akz7fdbD"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7176c66e99cso15574637b3.3
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751888601; x=1752493401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUCYVCzRKvKlFr71fm8EJ+Fd8d+Ry+ffnKZ+VaM+2mc=;
        b=akz7fdbDW3n+8QaT/dSyy0Y0eJql16JF4n5MUBQMvrXT+fr9HsMnV6lM1DmWk0qGqF
         wCtKeN0X9P6+tJSfVRwoQRlz6yR9ts4gdLZIz7IXOvD9ukKhqlxXnK42GFntoWGNGMP2
         YYCysn/Y05CMPDTLiezczpncbGXF/X8uGWYQbiuEQoLKcUFvuWaB7furnF3uTl4UUPoN
         51DggxSO4PeJZwShETwzaXZeFmpT7H4o+PwSUZyegM3Noc8G6ZzZ+dOGp3YHP6Y1lYfm
         LADcHh72wCLF4VDnQIhbKQbHpG+4jC+6PJk5tQMFA0Bnmiw7yIQQyeOmNbBuao1Y2stA
         49gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751888601; x=1752493401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUCYVCzRKvKlFr71fm8EJ+Fd8d+Ry+ffnKZ+VaM+2mc=;
        b=vZAja/yiD+ktFHKxbJgDpSclIcvYVMn31bBA2nBqa/udZXPgjbLGJSy/3p52JyBlb6
         cj7YDeav+V+blbh4QWUmz5iUoChLDUFzDPATt/mblXzeIMwcUJUPT7INK7iUAp8IvW35
         QPBfq94W02S/DgorjDytYDtoPE+HCiZ1KwAM5jrGyFCfRLt5hGTzMb85zI4vI0AOd5Wq
         zDeqXNSVljjYTGP4O0P+MhvmpLyyGStF5IYxNdoixOSuJ7Fhz+VkXTbZR+z0Ub+4kqlC
         Su7V1AM+5rNCMv52m9FDbwzLIu27uwW/41Md/xbxmC/IVF2V5V9vlbL/+eWwJyXu0iOB
         x8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUO2O0w2sxl2GfSdz/ZB8DgKT8k/h9WXjqiUaz1rjnf43h9cL/g8kc1L8b/75vj3i2JUZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMu4lIofVyS8lbE67ffMNqIYpPxeFEJH1VyM53twrmLT+A9sar
	JpF395KK/PQNM6D7FeuUTStr1KnldSq/EAC4w3Ypq11ea1wSgheWa27x
X-Gm-Gg: ASbGncvvMuGa+h2ep+GIRAy9cHs6Hkdq3kCWE0BDdO1naBwwrTHigQM4FZLQzcSFMCQ
	wCGESEjShds3Af7cfITFwpaRKtJQwF5pIQ5+xOUuWa2BJGuTQvb+nWvnw6BssDG4JOW7LajyEu/
	Bd/KAD8cyfIqgpHpyDNL2nBobLPi1J1j4pnaIOSCKNEtvwoCEI1qDimxH9OkKWphlAkzA4NkqgF
	a/WF1fbDSqs6nNTiQ1u24iHuEyWJmtQPXYUSkiVMI1Hb9J+/xs89MShgVDOtwKEVZ4VhcL37Vkx
	WrDDmwz/FhsAHoFMDP9RBXDZ5o6fYmDnxExTPaH1MeBhYp9K08eNsupnRMS8geJ47VBCBTe5OqN
	ijk8LK0HN2wenrRAXvtCxX8oBrO4MfCL097QNt7O5Dcq9jxiM
X-Google-Smtp-Source: AGHT+IHWPiFhJ7J3KVW3hMUQr+bHDU2qyjK9wNsKHMNaCfBezljVg9ymNX4az6S6FuB6DLOav6athg==
X-Received: by 2002:a05:690c:338d:b0:708:21e9:a20d with SMTP id 00721157ae682-71668d46c86mr162120217b3.16.1751888600684;
        Mon, 07 Jul 2025 04:43:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cccd:72a3:daa2:c18a? ([2600:1700:60ba:9810:cccd:72a3:daa2:c18a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665b12c88sm15931687b3.94.2025.07.07.04.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 04:43:20 -0700 (PDT)
Message-ID: <ea144a72-0975-4ac9-b2e4-ae0f7fcb6837@gmail.com>
Date: Mon, 7 Jul 2025 07:43:19 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] bloom: optimize multiple pathspec items in
 revision traversal
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: 502024330056@smail.nju.edu.cn, git@vger.kernel.org, gitster@pobox.com
References: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-5-502024330056@smail.nju.edu.cn>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250704111437.2660251-5-502024330056@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/2025 7:14 AM, Lidong Yan wrote:
> To enable optimize multiple pathspec items in revision traversal,
> return 0 if all pathspec item is literal in forbid_bloom_filters().
> Add code to initialize and check each pathspec item's bloom_keyvec.
> 
> Add new function release_revisions_bloom_keyvecs() to free all bloom
> keyvec owned by rev_info.
> 
> Add new test cases in t/t4216-log-bloom.sh to ensure
>   - consistent results between the optimization for multiple pathspec
>     items using bloom filter and the case without bloom filter
>     optimization.
>   - does not use bloom filter if any pathspec item is not literal.

This would be a great time to add some performance statistics when
using this feature with multiple pathspecs on some standard repos (git
and the Linux kernel repo are two good examples).

We don't have a great performance script for this, since each test
repo will have different paths to use for comparisons, but you can
use 'hyperfine' to assemble your own comparisons before and after
this change and report them here (and in your cover letter). 
> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>  revision.c           | 118 ++++++++++++++++++++++++-------------------
>  t/t4216-log-bloom.sh |  23 +++++----
>  2 files changed, 79 insertions(+), 62 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index 7cbb49617d..9a77c0d0bc 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -675,16 +675,17 @@ static int forbid_bloom_filters(struct pathspec *spec)
>  {
>  	if (spec->has_wildcard)
>  		return 1;
> -	if (spec->nr > 1)
> -		return 1;
>  	if (spec->magic & ~PATHSPEC_LITERAL)
>  		return 1;
> -	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
> -		return 1;
> +	for (size_t nr = 0; nr < spec->nr; nr++)
> +		if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
> +			return 1;

This is a good check: if any is non-literal, then we can't use bloom
filters.

> +static void release_revisions_bloom_keyvecs(struct rev_info *revs);
> +
>  static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  {
>  	struct pathspec_item *pi;
> @@ -692,7 +693,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	char *path_alloc = NULL;
>  	const char *path, *p;
>  	size_t len;
> -	int path_component_nr = 1;
> +	int path_component_nr;

We can move this into the interior of the loop, right?

>  	if (!revs->commits)
>  		return;
> @@ -709,50 +710,52 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	if (!revs->pruning.pathspec.nr)
>  		return;
>  
> -	pi = &revs->pruning.pathspec.items[0];
> -
> -	/* remove single trailing slash from path, if needed */
> -	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> -		path_alloc = xmemdupz(pi->match, pi->len - 1);
> -		path = path_alloc;
> -	} else
> -		path = pi->match;
> -
> -	len = strlen(path);
> -	if (!len) {
> -		revs->bloom_filter_settings = NULL;
> -		free(path_alloc);
> -		return;
> -	}
> -
> -	p = path;
> -	while (*p) {
> -		/*
> -		 * At this point, the path is normalized to use Unix-style
> -		 * path separators. This is required due to how the
> -		 * changed-path Bloom filters store the paths.
> -		 */
> -		if (*p == '/')
> -			path_component_nr++;
> -		p++;
> -	}
> -
> -	revs->bloom_keyvecs_nr = 1;
> -	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
> -	bloom_keyvec = bloom_keyvec_new(path_component_nr);
> -	revs->bloom_keyvecs[0] = bloom_keyvec;
> -
> -	bloom_keyvec_fill_key(path, len, bloom_keyvec, 0,
> -			      revs->bloom_filter_settings);
> -	path_component_nr = 1;

The size of this diff is unfortunate. I wonder if there could first
be an extraction of this logic to operate on a single pathspec and
bloom_keyvec in a way that would be an obvious code move, then this
patch could call that method in a loop now that we have an array of
bloom_keyvecs.

I think it would make a cleaner patch and a cleaner final result.

> +	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
> +	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
> +	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
> +		pi = &revs->pruning.pathspec.items[i];
> +		path_component_nr = 1;
> +
> +		/* remove single trailing slash from path, if needed */
> +		if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> +			path_alloc = xmemdupz(pi->match, pi->len - 1);
> +			path = path_alloc;
> +		} else
> +			path = pi->match;
> +
> +		len = strlen(path);
> +		if (!len)
> +			goto fail;
> +
> +		p = path;
> +		while (*p) {
> +			/*
> +			 * At this point, the path is normalized to use
> +			 * Unix-style path separators. This is required due to
> +			 * how the changed-path Bloom filters store the paths.
> +			 */
> +			if (*p == '/')
> +				path_component_nr++;
> +			p++;
> +		}
>  
> -	p = path + len - 1;
> -	while (p > path) {
> -		if (*p == '/')
> -			bloom_keyvec_fill_key(path, p - path, bloom_keyvec,
> -					      path_component_nr++,
> -					      revs->bloom_filter_settings);
> -		p--;
> +		bloom_keyvec = bloom_keyvec_new(path_component_nr);
> +		revs->bloom_keyvecs[i] = bloom_keyvec;
> +
> +		bloom_keyvec_fill_key(path, len, bloom_keyvec, 0,
> +				      revs->bloom_filter_settings);
> +		path_component_nr = 1;
> +
> +		p = path + len - 1;
> +		while (p > path) {
> +			if (*p == '/')
> +				bloom_keyvec_fill_key(path, p - path,
> +						      bloom_keyvec,
> +						      path_component_nr++,
> +						      revs->bloom_filter_settings);
> +			p--;
> +		}
> +		FREE_AND_NULL(path_alloc);

...

> -test_expect_success 'git log -- multiple path specs does not use Bloom filters' '
> -	test_bloom_filters_not_used "-- file4 A/file1"
> -'
> -

Love to see this.

>  test_expect_success 'git log -- "." pathspec at root does not use Bloom filters' '
>  	test_bloom_filters_not_used "-- ."
>  '
> @@ -151,9 +148,17 @@ test_expect_success 'git log with wildcard that resolves to a single path uses B
>  	test_bloom_filters_used "-- *renamed"
>  '
>  
> -test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses Bloom filters' '
> -	test_bloom_filters_not_used "-- *" &&
> -	test_bloom_filters_not_used "-- file*"
> +test_expect_success 'git log with multiple literal paths uses Bloom filter' '
> +	test_bloom_filters_used "-- file4 A/file1" &&
> +	test_bloom_filters_used "-- *" &&
> +	test_bloom_filters_used "-- file*"
> +'
> +
> +test_expect_success 'git log with path contains a wildcard does not use Bloom filter' '
> +	test_bloom_filters_not_used "-- file\*" &&
> +	test_bloom_filters_not_used "-- A/\* file4" &&
> +	test_bloom_filters_not_used "-- file4 A/\*" &&
> +	test_bloom_filters_not_used "-- * A/\*"
>  '

And these new test cases are great.

Thanks for this work. I'm happy to see the feature be added and my suggestions
are purely cosmetic as the proof is in your tests.

Thanks,
-Stolee 
