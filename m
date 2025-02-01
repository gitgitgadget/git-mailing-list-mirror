Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5158117BA5
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738405999; cv=none; b=Pf81PnPHLq9gQfxHxfKdLg3h3BgxGQQKRM+wx38KisyKKY5DDuTCTQqt1fHnv51a9bIQGF0aJRVFAxEAfPMoYJuXxV8oX+1Z4a5/HYxFkQzxyLNK3jdqTEOk1tqJw+rrWGhJPK6YnHmv0YM7/qQJ+iwWh+WwLPhiXZfuGUU+40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738405999; c=relaxed/simple;
	bh=jfhaoti0uBD8yVGvoAHOwT3Vvvwr/dL8Iu5H9RFyDjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hURxqhPnHw+TueGt1GfSDAPnBP4+Gol+V6myKPonrRKJfGdAmMJQ+CxsVCEIXHnPrUgNfW/ACN1ZJD/zDfWm5FZE1DGKrcl2Kb2Q713pqB3QsZ2mal9BBxbgyyfdemuYZs8YYjubph6mjAtzmg2ef0hbnVtYdruzk0Opu6AbTCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtlIsxUe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtlIsxUe"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43618283dedso28759085e9.3
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 02:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738405995; x=1739010795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WE7EnHaXtom5oTSMjrr3Or8gjjEiY0bAszr59IBBCM0=;
        b=HtlIsxUeGIfEXcs+SzbS1DW4rI1WQU0UWsboqRaHAWs0vcksUVVPqe5mtrHJA7ihjD
         V5Rpji8on/Czo3kpi5qViTMYbXxQGhPreQxlN8xTdyjR5qqO46+mVhjdyDzsbC2t83uX
         uKFSPrsGfyGZ2K5O2N1VWA0h9UMAe5Y9KB4T8gQdMPigZEs/m+3wcf8oJveEFC2QlW9N
         vuSMa6oeVzue3U5S1Z2vpXWLvRMTd0F1tYx0Tvly/whnfK1EHwEPyrOau+WWV2BXi5bb
         upLyU6TKus9nEmtmxS5Agb3eePf9J+MHZctbGRJ7gxDLNNRCM4SGYXKJ9Yqq8tCJ2Qpa
         6XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738405995; x=1739010795;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WE7EnHaXtom5oTSMjrr3Or8gjjEiY0bAszr59IBBCM0=;
        b=epelWYv0wys97UX1JVhzuptWe9XRTxJaHQbd2NukB42oDci876eco6O5ndzqN33pua
         /Q2+q2FADXNEfI6gyvCFzMsIhBfhNkclZWpDmtp1+oxHz2Gxyj1uYeP0M0SnAwDpT63D
         9XNfR5dKUxkgxu6xvx4kdakdm+QVfn31PmaTacEYAy+Glu/JrzbYpdoEMMaw8zOwXjie
         CZB9cztL9jT7q5NuuUgCnfgCcuonteACiYTBfo0CxS+8iXJtArue/Io0DSfCICN1KQFI
         8XzQ5OsNe0GzA7GPIGCCl7EliNIIiUXbzLG4LEHuFFiLmjOkdkKkp7y08XOBXVuw3H3m
         5/4g==
X-Gm-Message-State: AOJu0Yx7SmmLtwWyTBh1gUR7eE6b8SVGwzDIMVhtbfcUv/6fTe+pqeNx
	8gfX//e+mMPiX48+zDCs8sT3iznRCUZSWQpYRupYE+W3P74sfeOt
X-Gm-Gg: ASbGncuhFIk4ig+ZPbDaW3uiezMLfphiCVIxdHcoIA/+bA4czdOj6C9cBFYniMTrghg
	Gc//Yk5p9q9fJlxHu1lWhjYwTSPgxotJBsrkxLl5dIRhRIZlud48BWF8TGRfFo4g/VZp1Mr9Hq4
	9zX6XL/DPrgxFiJ5bTPabmF2TE5leYNvANx/yb4Mxbqf7RFklOizsCt/m686FIzC8gCzrYAA33p
	WoDKUvrQq0IoBse86PQlHnuacuitBY2qxj3+w1pVvytOxWTbtx/m/ygcZATwbaPabgV3etnFxRk
	fqLb3UxtuN7KHiUKzFuFFzorSFY2m09BxembfXIygTlnLd7YFEP9CN2S+5XYjUbd1XAGSA==
X-Google-Smtp-Source: AGHT+IGZ1Or6k6EJJsLp4yRnGFuiaBd5HQQVfPlDEHXynzAfjFGz0fP43VbB7QoZ4ceGNds9Azcb0A==
X-Received: by 2002:a05:6000:2a3:b0:385:ed16:c97 with SMTP id ffacd0b85a97d-38c520af4f4mr13059003f8f.49.1738405995177;
        Sat, 01 Feb 2025 02:33:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cee41sm6845505f8f.81.2025.02.01.02.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 02:33:14 -0800 (PST)
Message-ID: <425859d1-d42e-42ee-b59c-723a519f0ad8@gmail.com>
Date: Sat, 1 Feb 2025 10:33:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: undefined behavior in unit tests, was Re: [PATCH v3 3/3]
 reftable: prevent 'update_index' changes after adding records
To: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
 <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
 <20250201022409.GA4082344@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250201022409.GA4082344@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 01/02/2025 02:24, Jeff King wrote:
> On Wed, Jan 22, 2025 at 06:35:49AM +0100, Karthik Nayak wrote:
> 
> Coverity complains that this function may have undefined behavior. It's
> an issue we have in a lot of other tests that have moved to the
> unit-test framework. I've mostly been ignoring it, but this is a pretty
> straight-forward example, so I thought I'd write a note.
> 
> The issue is that reftable_new_stack() might fail, leaving "st" as NULL.
> And then we feed it to reftable_stack_new_addition(), which dereferences
> it.
> 
> In normal production code, we'd expect something like:
> 
>    if (err)
> 	return -1;
> 
> to avoid running the rest of the function after the first error. But the
> test harness check() function doesn't return. It just complains to
> stdout and keeps running! 

That is to allow the test to add more context with test_msg() or do 
things like check all the members of a struct before returning. It is a 
bug in the test if it does not return after finding a NULL pointer, the 
correct usage is

	if (!check(ptr))
		return;

As we're in the process of switching to using clar which does exit the 
text function if a check fails (that means there may be leaks on failure 
but if the test is failing then I don't think we should be worrying 
about leaks) I don't know if it is worth fixing these or not. I guess it 
depends if there are the list of targets for Seyi's Outreachy project.

Best Wishes

Phillip

  So you'll get something like[1]:
> 
>    $ t/unit-tests/bin/t-reftable-stack
>    ok 1 - empty addition to stack
>    ok 2 - read_lines works
>    ok 3 - expire reflog entries
>    # check "!err" failed at t/unit-tests/t-reftable-stack.c:1404
>    Segmentation fault
> 
> So...yes, we will probably notice that the test failed from the exit
> code. But it's not great when the harness itself barfs so had. Plus a
> compiler may be free to reorder things in a confusing way if it can see
> that "st" must never be NULL.
> 
> It feels like we probably ought to return as soon as a check() fails.
> That does create other headaches, though. E.g., we'd potentially leak
> from an early return (which our LSan builds will complain about),
> meaning that test code needs to start doing the usual "goto out" type of
> cleanup.
> 
> So I dunno. Maybe we just live with it. But it feels pretty ugly.
> 
> -Peff
> 
> [1] This would happen in practice if malloc() failed, but you can
>      simulate it yourself like this, which is what I used to create the
>      output above:
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 026a9f9742..fe77132102 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -861,6 +861,11 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
>   	int err = 0;
>   	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
>   
> +	if (flags & (1 << 16)) {
> +		*dest = NULL;
> +		return REFTABLE_OUT_OF_MEMORY_ERROR;
> +	}
> +
>   	REFTABLE_CALLOC_ARRAY(*dest, 1);
>   	if (!*dest)
>   		return REFTABLE_OUT_OF_MEMORY_ERROR;
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> index c3f0059c34..73ed9792a5 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -1400,7 +1400,7 @@ static void t_reftable_invalid_limit_updates(void)
>   
>   	reftable_addition_destroy(add);
>   
> -	err = reftable_stack_new_addition(&add, st, 0);
> +	err = reftable_stack_new_addition(&add, st, (1 << 16));
>   	check(!err);
>   
>   	/*
> 

