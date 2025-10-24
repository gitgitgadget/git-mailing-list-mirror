Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429862DC79F
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312524; cv=none; b=qhnWZ2MbnAeSpyRCDJZ9o+GgRjGBPQnegvzR9j8ZJ2fDZiqBIFtXQoT1xhvYFjuDLcVrI5cg6McccuG8KYbEGRQRyTdxm3xwSgDFZYvrqeVHbhrm9/YiILZl3wiGnMOk8nipMitnPEBCOABZyAUjxBOT4Vb4hK4TCEe4bAmS+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312524; c=relaxed/simple;
	bh=RknXK//wQP0xsKr+oPR0+gLbEJePPhk8IdHp0raGqdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCiOu2Zrk9li+rMB6QGlC7ZFBw8D+NGgkU/EXxg2o75dQe5NLxs6FNIgyxrP6zRda05JLYpR2KfIH//UeeQqBoCAF8zUYOnkqiGOznB6JuEJYgkiNM1SCeWuLLt8O1yBcddL8Q5Nm652sRyOpfUGMwKPGxeN3IjYcUwtS/oCqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBbb9Boj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBbb9Boj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4711825a02bso16985415e9.2
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761312520; x=1761917320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSbbuY6IxM2D8D8ln7ohQRddqzgNACGPcX0e24651Pc=;
        b=kBbb9BojiddF8+sXFwsvX3I7wnMxRKdIDa65bDvEUD11/oXwSemC4+vpDBIbr93x/f
         S2AaJ6sC1R8zBgtCdT8YsO9UOMRxQHXN0CtUY2T5nXJgT0gWAyHMZwL1xEIFh51SPnX7
         f0mhOVjP6czGzYn/di0lVFCPexO1jt6kHV4BlkTRiA+BzeUf6lD6ms2x4EV0dpSDoISb
         MPGEvvtt121Q1v8eJH1QJL9CuZmMqcGbel5mvb+4Dtkex4rUaWA1leMAtVnTVz/vFMAw
         vR4Bb+V9h2wYBzMf5Vczeqq1j0KRJ/2kDgXgB65Skr8D++BeK+YW/TJufrsbhvOiRKm5
         LOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312520; x=1761917320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSbbuY6IxM2D8D8ln7ohQRddqzgNACGPcX0e24651Pc=;
        b=nccVPZVwCKTKegbLUJ5FrJNQhg2UAx8AlZ5IwKEZUNY4NgQt36dRevzgSx/XGc1cgJ
         Ij+MksA6E/ebqHtQFifcY8Or45qHM4P7bf9Lkl7YW1iyQb/G+m37FaH1reQSzUYPJsSC
         CG70eyttZN2t3iNeoMqiGpGg0iyH7SKsNPPxcmr5XquPC4Cun6wqGBH/A39gd2WZrLHx
         2ttL6q1U/MiS/xeMKcM4bo8Pz8a2Tf5sockiCQrPMyQ18r1Ser4GjF1rjiHNX3Apiojv
         UIHOWRCEmCzNZ08768+n9KVCR5F5QxfUo6verE3pVfcjqkQ0p5YD3u0Itc8KFldM2HQp
         eatw==
X-Forwarded-Encrypted: i=1; AJvYcCV2N52qz4xWVplR8VVUFRyDm0WcyKT+zqXlFBc33QEA1xnI7megq+szWV+oYWBboeiGWmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTHEiv6gxg8Ja5g82Lob+BY1394esS9dxLOEV5E/xbRXbe8sw
	1lP/dwxDIUMP1UAcRulR+wn7I7DuVVmjKi3QilzbummCoAbx0vB20FG9
X-Gm-Gg: ASbGncu8+15cumr2BLhrSeCkc2orKmpvncTNubXsXdlJ3KvHikc5fQZfHfRQv4cM+Ki
	19ZnYhzPHT7hpbgP2EzrMC4vcSL29ZTs6ffcbmLC09dcMIYtzA1CZprAFkHLKts76g3oaRWIvZg
	4uHSvz+bJl2zYyq5ahibDw+3yq9FcbUQHQbcsZoZGppOObufYPVL5mcXXTV2nQPJYBaAwbFfeiE
	b/I3krma5qI/1ox1ogSS0grpe7ZGfPo7BwET100B+r+eBLiJdNZ8+1qlmuwSmAXKh6gcCXxOB5j
	OTBToNTzjcmPFEifWRoV2FSsvHipMFnDEK/Vlkf8oo8P9h6EbULy8WBMhk4lEOtWViV+kvQUKBO
	xBeCI7ygika9Fujpt0JYwkQRcqWgLMPEfTeoq8UC0Q7NY7dy6DYDg9qIfHuVjv2ZEvS7HFGHqHg
	L/zxE4xONHBujUn9BwdsfVy4gBd26w2Sbuh12LtwgVeRuELA==
X-Google-Smtp-Source: AGHT+IEg8ubg5k/cs3OwyRKBUuOrz8O5N1BgpCAZsk9ti2yPMI9rs20FuWcqshLGWGtrQMaJHOG0jQ==
X-Received: by 2002:a05:600c:5029:b0:46e:3686:a2dd with SMTP id 5b1f17b1804b1-47117879c4dmr204638945e9.11.1761312520192;
        Fri, 24 Oct 2025 06:28:40 -0700 (PDT)
Received: from [192.168.1.194] ([84.64.105.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf15498sm107627235e9.12.2025.10.24.06.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 06:28:39 -0700 (PDT)
Message-ID: <a4cd31ad-7086-4d05-ba00-db65ec24b45a@gmail.com>
Date: Fri, 24 Oct 2025 14:28:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] replay: add replay.refAction config option
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-4-siddharthasthana31@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20251022185045.29256-4-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2025 19:50, Siddharth Asthana wrote:

This is looking pretty nice now, I've left some on he tests comments below

> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 54c86b87d8..307beb667e 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -217,4 +217,46 @@ test_expect_success 'merge.directoryRenames=false' '
>   		--onto rename-onto rename-onto..rename-from
>   '
>   
> +test_expect_success 'replay.refAction config option' '
> +	# Store original state
> +	START=$(git rev-parse topic2) &&

Isn't there a tag we can use here from the initial setup?

> +	test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
> +
> +	# Set config to print
> +	git config replay.refAction print &&
I think it would be better to use test_config here rather than having to 
clear the config manually with test_when_finished() above.

> +	git replay --onto main topic1..topic2 >output &&
> +	test_line_count = 1 output &&
> +	grep "^update refs/heads/topic2 " output &&

Rather than test_line_count and grep it would be better to use test_cmp 
here.

The same comments apply to the rest of the tests

Thanks

Phillip

> +
> +	# Reset and test update mode
> +	git branch -f topic2 $START &&
> +	git config replay.refAction update &&
> +	git replay --onto main topic1..topic2 >output &&
> +	test_must_be_empty output &&
> +
> +	# Verify ref was updated
> +	git log --format=%s topic2 >actual &&
> +	test_write_lines E D M L B A >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'command-line --ref-action overrides config' '
> +	# Store original state
> +	START=$(git rev-parse topic2) &&
> +	test_when_finished "git branch -f topic2 $START && git config --unset replay.refAction" &&
> +
> +	# Set config to update but use --ref-action=print
> +	git config replay.refAction update &&
> +	git replay --ref-action=print --onto main topic1..topic2 >output &&
> +	test_line_count = 1 output &&
> +	grep "^update refs/heads/topic2 " output
> +'
> +
> +test_expect_success 'invalid replay.refAction value' '
> +	test_when_finished "git config --unset replay.refAction" &&
> +	git config replay.refAction invalid &&
> +	test_must_fail git replay --onto main topic1..topic2 2>error &&
> +	grep "invalid value for replay.refAction" error
> +'
> +
>   test_done


