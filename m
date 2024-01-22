Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B366FC10
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963304; cv=none; b=UuXiJul/JNvQEO2VYjWzvPXybeSCxrV1mGcGQKxFt8l3Eo1eAhWZN+9ZFa1wAV6uDtEhgq4kEnqHWanT9eFb4SbWydHyoNAuAxz4ZYWRnEoxDyvZ8MFUuq6BWI26pRDG7ZxPwaNb8z7/FMhbwy+OBtVGNRtazRa2Kd4R6h45erw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963304; c=relaxed/simple;
	bh=v8xIxyt8nwxMjRvj1DlV0XUEFexFwp3aKeKHuU37zUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOU3H8pMt95Ma2Tuf7UOYQeIcIx9OHIFMb0rZvOzseqype5wG1E8STk5AATb0lWeCktqs1GLcO5RkL8/SXR9XnBpIImpZHVRS2IIZKe96zS/s4elekx/qNd+wYlr6oWPKyg4s8EUylJJGGj0xpMnZZKbRjWa9+zRMQGG3Oi26g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=h981KwYi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="h981KwYi"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6db599d5cb8so2771847b3a.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 14:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1705963303; x=1706568103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMXjR0CD8itiNn5n6NRosY61WhCtg4VR5oKQRpRu8z8=;
        b=h981KwYilpzYYIftheHJX/On3DldCOAJbrVNneyOsb+UtHZE3qKs3sGddJorIf5/hA
         rJSAyjeWh9JzmVKwFMUPLw7bROXepg/N+4GHVjuk3SsfhSwO+DWaFS5gfV4nMifIcYw4
         cqo2oWMWhRxD0kl8hNvM34MGKFS/sKYwme8l9AzrEjNR+Op2A1k5nEajbaRpz7ScAmjj
         cM5QBHoaSKImTJhNw4sUV0f6Sm72UsxIfTJVzl0Fmm1xq/FhMYjRw1i9XDUznCQ4+XPm
         P+gzDjhVARZv/kKR1xotT7Pb/07TRv8j3/hLAKDFTSv+baAyPqzbtn1qiC8QYjUKQg3v
         Ithw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705963303; x=1706568103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMXjR0CD8itiNn5n6NRosY61WhCtg4VR5oKQRpRu8z8=;
        b=Jg1KQD+RCvYHJCAWuR4PNRuqvLXU20AuzSa1Xr9bOTJ77C+t03O4ZP2uBpABtNQOG3
         +tRjihFi1lFuKKi5IfCubMapxotkq4+EVOqCjVYfk9w2ABkIecr8wpakY75Dg8G53Q7b
         8rknMEB40joBWsvQHCmezkQl7MxUf3XGHP6ZkAPh6eMh2bjNSVOnlWbI6E81Y4ZncFU1
         pVGBaIFUg9/rpnqF52YZZw8ii8HKyB45srl7DGTBuFxbTMt/T1+yE2LnAEKFDQ8z1wEC
         DGqqFfWKmBH4KHu5+wnMBwUgZe997DlI29Z2CQI2nQZ4iiFyBaHDudjTiEVDc9HqYy+5
         bS0A==
X-Gm-Message-State: AOJu0YxbLWtc3Q0KtP6d9OHf5YlIoqO7YlCzOws9/2X4ZWpu3ms2grRK
	hZ8IZXkd9J4Qi/SbJ0oQWJJkxxb9WaRSBycaSoy9KAYVh210aNrq5rEgeBW8
X-Google-Smtp-Source: AGHT+IGSXjz72VetCFeYEUBEXzA8NZ6w8l49hJLkb8pTs/HPWg6TdoEo9ObhzS50HDNBrgim9nnz/w==
X-Received: by 2002:a05:6a00:22cb:b0:6db:db99:565e with SMTP id f11-20020a056a0022cb00b006dbdb99565emr1975000pfj.52.1705963302932;
        Mon, 22 Jan 2024 14:41:42 -0800 (PST)
Received: from [192.168.50.41] (172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm8889821pgc.29.2024.01.22.14.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:41:42 -0800 (PST)
Message-ID: <dbe25fff-e1d4-41f2-8f8f-c538e8c2a77e@github.com>
Date: Mon, 22 Jan 2024 14:41:41 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci(github): also skip logs of broken test cases
Content-Language: en-US
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1649.git.git.1705808313306.gitgitgadget@gmail.com>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1649.git.git.1705808313306.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> When a test fails in the GitHub Actions CI pipeline, we mark it up using
> special GitHub syntax so it stands out when looking at the run log. We
> also mark up "fixed" test cases, and skip passing tests since we want to
> concentrate on the failures.
> 
> The finalize_test_case_output function in
> test-lib-github-workflow-markup.sh which performs this markup is however
> missing a fourth case: "broken" tests, i.e. tests using
> 'test_expect_failure' to document a known bug. This leads to these
> "broken" tests appearing along with any failed tests, potentially
> confusing the reader who might not be aware that "broken" is the status
> for 'test_expect_failure' tests that indeed failed, and wondering what
> their commits "broke".
> 
> Also skip these "broken" tests so that only failures and fixed tests
> stand out.
> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     ci(github): also skip logs of broken test cases
>     
>      * An example of a run with failed tests appearing along with several
>        "broken" tests:
>        https://github.com/phil-blain/git/actions/runs/7589303055/job/20673657755
>      * An example of a run with the same failures, but with this patch on
>        top (no "broken" tests listed):
>      * https://github.com/phil-blain/git/actions/runs/7598605434/job/20694762480

Thanks for making this change, the more focused logs are much nicer to read
(and ostensibly a bit more performant as well).

> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1649%2Fphil-blain%2Fgithub-ci-skip-broken-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1649/phil-blain/github-ci-skip-broken-v1
> Pull-Request: https://github.com/git/git/pull/1649
> 
>  t/test-lib-github-workflow-markup.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
> index 970c6538cba..33405c90d74 100644
> --- a/t/test-lib-github-workflow-markup.sh
> +++ b/t/test-lib-github-workflow-markup.sh
> @@ -42,8 +42,8 @@ finalize_test_case_output () {
>  	fixed)
>  		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
>  		;;
> -	ok)
> -		# Exit without printing the "ok" tests
> +	ok|broken)
> +		# Exit without printing the "ok" or ""broken" tests

And the implementation itself is nice and simple. Looks good to me!

>  		return
>  		;;
>  	esac
> 
> base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c

