Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD635AC16
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348995; cv=none; b=d6mFa8khzmXjDff9R5cqC3EAEUAk/6IHDuQdrz4xDoIZbjzH3W1K+AOTCwuYLa0+cHCMnDdyB3uU3O+n3XZkSmJqKCxPT5LmkicY8X5e1zk1Dgb+iNZH2M6Tt9LyTJ/NBEW5uky4URM6WiWG8kHqKECdwuJF6nN3t49Ef7mNS1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348995; c=relaxed/simple;
	bh=2RVzj6hWMOYdMw0z+xRymrYhv1CuXDY+Qqdaa+TYXp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCi7oDFQTECwBrJ94C2jZ4gs+1a/WaOL0YhkHiDh5dQxzbyZAo0+e3psxfkunNlFvW9sUAI1h4H97mnTtOBZp5ed4g3YXKvIXRwRKPjg3CluvNEAfVelF7ZiVKbrSLfAEU9nljXqU+tmY9OzJRQ1KqgYOPuUlt4yYd9I0JWD5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enwAixo8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enwAixo8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-487012ce896so5755145e9.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774348992; x=1774953792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OCAUzfBKP0RF5Sbri7UYtlBkXsBx918dIjvsYUlHS1I=;
        b=enwAixo8BXr1nxYGMwynuavl9wA42q4yRVfcBSMA8QGNw9dFeqSKetrc8UbFCmbQrm
         na7qBN/ZZiOIPp35nlMgvloxs0WeMlIpVi3RVS2OmmxUv++JAQCLoYRPiVfYrEontZMA
         93ySlK63V1VMxNvjyCzdOXjInOdXLR1lvuU82mZEDqlV4LheBNUh4ep5GfSSE0PyKCoy
         a8sgJ8BioCGN9ErXHRKyZeGMwTZ7THdvaFsRFWctarA2ZHMU+VR/isCAPrdNmwghfa1/
         /5/Xhb5NTY8yn4g54KtREcsus+ZkJAopwM+ntc+AoDEiQ2bZDZmCfxCyYSQfJhg5sEpW
         cliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774348992; x=1774953792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCAUzfBKP0RF5Sbri7UYtlBkXsBx918dIjvsYUlHS1I=;
        b=ClevT66e2REaaSIQBM0MC+rq7KtLQwNnhEk6j943Nn8VnATpdbsEdXfAc2UZbmlw/j
         PKG0cIkFAGdUqhhWbCTIK0HEJ9kc7KAB9JhR30Byr0ByQeX/rzoF4NNFk3NO5cty9Icn
         1/MXrh57KfjHrOH1ti8oUModXdNa01Q+j2VWfPzVGK7cOkwlUWog9nKlqcBlG+wI0j2a
         0HThOIJUpuaA+KPtdaH+bmmCLRdmLQBCJgyAGaAzj1KPIqvyUvWhuPbqTUQbwYbfjdlO
         uNfPN+XhyJtEXaHJhyITGvuD82cg4A6kVvKgic4Rtw01bKBljHAqVG6Jbx9ya1VIrIJn
         Dysw==
X-Forwarded-Encrypted: i=1; AJvYcCXj1YbYjf8HzDYBUCjbg2oUM6uJ5oHnOaM7vqnmCKPWpGB9dcXz+LbrqWz1NdLdVOCaPz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8lCqssnorwek8VGTuifMN6B3MyINmlGFj4TJdDAJZhLl/aAj
	DvtL7Y69LDh01M+zbShHs3c/G9VngIoqS7ZFlPmO8uEeZRRCLo0Toz0P
X-Gm-Gg: ATEYQzzuaC60oC0X+Eo7+MJ7BOT+9o80tcBlLu+6N0eAKwoSOSwSw9mKiBn8LUoN4ln
	jdEZXZoG1z2oIrST1uGiXGsRxxsWyzbAsKRp2CxeC9ZS1cfUPvJKgTLRD46QNipqCddQ6PZ4VLj
	bBAJ84J6YFZIqAyUTkV2/p66mV/gnY7VySBvV3F/KKxMZx7bmWf+TbgNE7LGsXxcnfndDq8Lq2B
	i02TYI4mr9V+ZeT3EIxsBn3GPVY9AQXw9xC/bbrAItY2kBaiI8OiPGvDqDXSG4exR/6dUp3T6F7
	xyAwrt0PRVvGAlgQnbRjjmYV1v1Cv75uK9ZR1SNUjT2qyvkC5SmcWG4s3vjR5enMLUpWaTyEyqz
	1LJMMR4Ep428gnSe/SMU1/nFPCqmaBmEpy1dY+8S6JCDlv0UYtk5SWmrtgq9o3k+UpnbRSjaJY1
	iWINnGsEjSfJsK3h3hCKQ+aiLxmi1tqSelzjUh/kAUDdvEhBpCxmUVFLr3exWwZo/aCjfFUeLRq
	PXuQ0+/xYPmnybu
X-Received: by 2002:a05:600c:c083:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-486fedf9be6mr168275135e9.10.1774348991013;
        Tue, 24 Mar 2026 03:43:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ac0a8sm77456195e9.6.2026.03.24.03.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 03:43:10 -0700 (PDT)
Message-ID: <f8f7a220-c40a-480d-b0d0-abfcf5c83157@gmail.com>
Date: Tue, 24 Mar 2026 10:43:06 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] bisect: use selected alternate terms in status
 output
To: Jonas Rebmann <kernel@schlaraffenlan.de>, git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>
References: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
 <20260323-bisect-terms-v2-1-8d6bdb2c9c7e@schlaraffenlan.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260323-bisect-terms-v2-1-8d6bdb2c9c7e@schlaraffenlan.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonas

On 23/03/2026 22:48, Jonas Rebmann wrote:
> 
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 4520e585d0..ee6a2c83b8 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -465,13 +465,16 @@ static void bisect_print_status(const struct bisect_terms *terms)
>   		return;
>   
>   	if (!state.nr_good && !state.nr_bad)
> -		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
> +		bisect_log_printf(_("status: waiting for both %s and %s commits\n"),
> +				  terms->term_good, terms->term_bad);

If we're going to start using alternative terms it might be better to 
enclose them in single quotes to make it clearer that we're referencing 
the term names. Looking at the test below

	"status: waiting for both 'term1' and 'term2' commits"

is clearer to me than

	"status: waiting for both term1 and term2 commits"

>   test_expect_success 'bisect start with one term1 and term2' '
>   	git bisect reset &&
> -	git bisect start --term-old term2 --term-new term1 &&
> -	git bisect term2 $HASH1 &&
> +	git bisect start --term-old term2 --term-new term1 >bisect_result &&
> +	grep "status: waiting for both term2 and term1 commits" bisect_result &&

Using test_grep would make debugging test failures easier as, if it 
fails, it prints a helpful diagnostic message.

Thanks

Phillip

> +	git bisect term2 $HASH1 >bisect_result &&
> +	grep "status: waiting for term1 commit, 1 term2 commit known" bisect_result &&
>   	git bisect term1 $HASH4 &&
>   	git bisect term1 &&
>   	git bisect term1 >bisect_result &&
> @@ -1103,6 +1105,16 @@ test_expect_success 'bisect replay with term1 and term2' '
>   	git bisect reset
>   '
>   
> +test_expect_success 'bisect run term1 term2' '
> +	git bisect reset &&
> +	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
> +	git bisect term1 &&
> +	git bisect run false >bisect_result &&
> +	grep "bisect found first term1 commit" bisect_result &&
> +	git bisect log >log_to_replay.txt &&
> +	git bisect reset
> +'
> +
>   test_expect_success 'bisect start term1 term2' '
>   	git bisect reset &&
>   	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
> 

