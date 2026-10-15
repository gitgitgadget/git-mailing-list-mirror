Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605CF4E8E0D
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056468; cv=none; b=Mo/ZDIBZLhXOK4j3yOsz8knZdMwRYKh5nWn0VXFlNN1ui1YjK3Xc2H8uQD0rDJCcyzsA1qQFys7jHEcvCfLaKsRGTUQTJiBhTsHhn+ECaeKHEvyW2TWBeZYgOh5D7mG81OaY0un0m9YAXJOo/mHAcULbeUzf2rasJeDrcHasYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056468; c=relaxed/simple;
	bh=psCsGRYOz69JjRVoc4WCFAGBIBW0QIon/qnOSW6Wahk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLMtvqVHTsqAoWsEs1l2lCxzbQII6uAxw0rYqKou3+AMjtC+ix37Ba/DR6ks1EuQ38LL6jWS+7kPTHNE7cwoSz64+8fXa8AWp/58wa1muGg2sjeJSZ045Z3ocB+ki1/Mxnle2Xuyh7K255vn9OWcfq/k2AQK7ypm0RVZzvKwDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyYF9ACW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyYF9ACW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1af482519so22125845e9.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792056464; x=1792661264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sb8nw4qEXuffKiMUILDbcerCNsHuMwBkSEWEqNV613U=;
        b=gyYF9ACWjVGNLTSc7XtpEGjqv2JaK9CuXp9bIIgxiJ1liqPa/q0Bh8ralvYBn4lIJF
         /ChhQkNSaZ+tmhEHkM/HUCDvuSleZTPr36n0OQJdl4Rs2IOzyGGUZqC/58XeaJGQk9Rb
         6yHC0IjZ8/1sahkHwxUAgzymP2OFq3XB27W8Qwk8ferjeRt0DVzCRvWA0tFBBfBmNyHL
         tE2sMVeYOBuo0pLGIRlW+90kwCbgie1z+yAKg2kgd08oZCNKXBmhRaDFRPY+DieYHtMF
         N1Epgi66p1EahwqjjbH8yBfxFiNgPpN9YH2MgUfwdxdi3fdPtLl1E2Qk1V7Wz48x1pE7
         L/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792056464; x=1792661264;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sb8nw4qEXuffKiMUILDbcerCNsHuMwBkSEWEqNV613U=;
        b=azBGpQ5XYiwoWs7TWFc7wGSD5BJ31RvX3/ohmNijq/yT9n0nYbPT4xn0fMqIC4qYNx
         d1LBOo3N7Bckpjrc7Rb4BkIYnSnUEJA3VR266QUDmF8nkr5AGsEDjYlv3b0HfJ4YTPx+
         cGOri3wwRF8MRptGqvoN2xoYDjtIO1ZlBqV6NQX/R4iz+7k0vIQFpwNoZ8DthwrD+VRT
         nJYRWxF3xZPDKuJuZiNclsyQ91Y6wPSzNdPJ3I5NjwhsvVmZkxOjywzxO105vx+h4B6L
         sd7741L7AH9RVUf4ovWgi5OG9yrNex4zZ8S6v8/XacTIdbcPmIoG3VdXiA56bUaOSGRH
         F04Q==
X-Forwarded-Encrypted: i=1; AKwUvByxtfvh6BXspqN9x83BM0o2FnhHQecXwye4MQw5DXnytU2DjysW4Ef/MyFgZvoeW1gqyho=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFci0qtvHrXmD1emWbvepON/Kum4ckXuLtG9w7rAjTcoPuVCGh
	ODKA05UYrI1cJXOaY4TpNj1/9l4yTgw8YVfu00C0/oGHPz0EAqF8x3ka
X-Gm-Gg: AYBFou2czEgu1pjyExOLB3V6uCunmVGgZas/dBX7ToZ8wlKBNcRhS0CaZ+FnjZrO7qG
	iKvBsedZhGXrzgUsTFb17fgSGlNbhHUV90uiquDX/VmI3x2ll2Ys0unzgHj3mq4kYgDhw5jq794
	LEBRyZhXtDgYySEdc3gcGOz/rLarbNqmSN6DsjVzT5aMM5BHh4vrlbFN2LyprDX1eQ2FK5VYvHR
	txVh3FvPdTegt4HaaEAdWqZkkMUM3usRgDsdxWDndEquQEcNWv0dhbPbiWy/1uEh4dhGuu0++QW
	R8dQ321VRMfak69eLqlaQwLtb7dJ1fQ18k9B+MBOS/qUD2BdgyIuRfCBEUSdENzoZTO7xMSZB1W
	/n0nEYZGnCKzXdobXk0Cl0E0i3vYj7CFbuiXbM7AnF6uO5X4ZjGcHaz7HTPnTjWyZBFyscKpOWR
	H4zJCDKQmmxl+2HXGendkvBNM5uN7Jg8jSj/3WCYUSn7dGuoL4F3ca5dzmaQFWe255tMTJ+RX55
	1RxDH3I2q3ROCX1YVzaJt9lYYnmUYbxv8Mv5bRp+liEjNaRYAIWtpQmm0IlI4s=
X-Received: by 2002:a05:600c:8b78:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a18e4837f2mr358342055e9.5.1792056464260;
        Thu, 15 Oct 2026 02:27:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd993caesm115243535e9.12.2026.10.15.02.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:27:43 -0700 (PDT)
Message-ID: <373f7186-3da6-4715-a4ce-cd5f56895176@gmail.com>
Date: Thu, 15 Oct 2026 10:27:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] git-compat-util: add `signed_mult_overflows` and
 `mult_overflows` macros
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
 <3dcc3d97570ea7f96628d02941d7424f84f7bf39.1791958171.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <3dcc3d97570ea7f96628d02941d7424f84f7bf39.1791958171.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 14/10/2026 07:09, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> `unsigned_mult_overflows()` does not cover signed arithmetic, but types
> such as `time_t` can be signed or unsigned. Add signed and type-generic
> guards so callers can check multiplication overflow in either case.

It would have been nice to mention that the type-generic macro is gcc 
only so we cannot rely on this for safety checks.

>   #define maximum_signed_value_of_type(a) \
>       (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
>   
> +/* Account for the extra negative value on two's-complement targets. */
> +#define minimum_signed_value_of_type(a) \
> +    (-maximum_signed_value_of_type(a) - (INTMAX_MIN < -INTMAX_MAX))

Do we support any platforms that do not use two's complement arithmetic? 
C23 makes it mandatory so presumably there are not may contemporary 
platforms out there that do not use it.

> +/*
> + * Returns true if the multiplication of "a" and "b" will
> + * overflow or underflow a signed type. The types of "a" and "b"
> + * must match and must be signed. Note that this macro evaluates
> + * both "a" and "b" twice!

At least twice I think

> + */
> +#define signed_mult_overflows(a, b) \

As the macro relies on both operands being the same width, can we use 
BUILD_ASSERT_OR_ZERO() to ensure sizeof(a) == sizeof(b) here?

> +    (((a) > 0 && (b) > 0 && (a) > maximum_signed_value_of_type(a) / (b)) || \
> +     ((a) < 0 && (b) < 0 && (a) < maximum_signed_value_of_type(a) / (b)) || \
> +     ((a) > 0 && (b) < 0 && (b) < minimum_signed_value_of_type(a) / (a)) || \
> +     ((a) < 0 && (b) > 0 && (a) < minimum_signed_value_of_type(b) / (b)))

Thanks

Phillip

> +
> +/*
> + * Returns true if the product of "a" and "b", after the usual arithmetic
> + * conversions, cannot be represented in the multiplication expression's
> + * type. The operands must be integers and may be evaluated more than once.
> + */
> +#if GIT_GNUC_PREREQ(3, 1)
> +#define mult_overflows(a, b) \
> +    (is_unsigned_type((a) * (b)) \
> +     ? unsigned_mult_overflows((__typeof__((a) * (b)))(a), \
> +			       (__typeof__((a) * (b)))(b)) \
> +     : signed_mult_overflows((__typeof__((a) * (b)))(a), \
> +			     (__typeof__((a) * (b)))(b)))
> +#else
> +/*
> + * This implementation needs GNU `typeof` to convert both operands to the
> + * multiplication's type. Skip the check without that extension.
> + */
> +#define mult_overflows(a, b) 0
> +#endif
> +
>   /*
>    * Returns true if the left shift of "a" by "shift" bits will
>    * overflow. The type of "a" must be unsigned.

