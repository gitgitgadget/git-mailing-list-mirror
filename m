Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434AF16F288
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597966; cv=none; b=louVhQ6ko5iz/rFiM0XRHYUxV0kM1SDp/9HKf2Hcr52O5RQ5yXOb0bgGabsefPjcXCMubxzuyj6P4JztkIpTI1IfZH37bOVNZ/rBwQn9LNcAyUeUgKi3QjypCO9TEL/2vGKeE/9SOZpCEBrtCj20p3mnMhbYJIbCarD22sl7XbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597966; c=relaxed/simple;
	bh=C/psWEQQ1iWOIpFLGjNvSDc7+ozM1O3f/b+CKq1mqWI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O1Tt1JuBblRomf+sgE9k7kICVvqkZV7Da8pPG01Wqy9afhc52aDbSdx+mnvndqj9G7AT24HD6X4TYtlICmXaV/4v+s23wCjFN73rixAGT+dL/oAyiHH6Ej97NoTBlDpdKaNc0u/ZhZ6ejUGR8ITLG/ena4lEgxV89XBdzaoWAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTGtDuYr; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTGtDuYr"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8633a38df87so1164563b3a.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 05:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790597964; x=1791202764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=va0g07TQn5q0V6yDarBlvcrOyXtccIjxROvFNIIznyU=;
        b=UTGtDuYrDXkoM7zvhtwqfOJs6UHlA+anNoGN5XjG7CjeR6ZdH9UPwfp+2H2yED/3LJ
         6xrLDLi6riVOpS6u0515MdncEWwsvFpEiYPBoIJIeM8Uj6AR8+Fa5Pp3UZxfM3PjuZt3
         3bcMePtsTyrl8HAYhfZWg9MwGa5h02Ln+rQFEZrRdpNBh/8dt4qNWJmbSPrtGTeE45QW
         gx7BroIhHJG9y15TuPJu/AhHCMdHaOYBrP00wkf99sngNIVv+0chg6jqDANeSXpWxPQc
         T20BK4F0grE5y0V7Wrx5VXY+BkDhkcIip2eWIR+HQlEzX7ihPWfxbqYhgY1+0OfHEMob
         xgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597964; x=1791202764;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=va0g07TQn5q0V6yDarBlvcrOyXtccIjxROvFNIIznyU=;
        b=pxjZgl0B+KcwezIJ9mHOMIPRdMkMhnxiJiv6NJnr+EQwB/+L1nAPppCsKJB/C8lOK/
         oEt8Dkn44bzhYJjpVpe+obS+KySwAwOo3I74sVWTpviT1VpWF1eJ5io4YonXXEqUwrW1
         B7fVDnEDgvcM4TxTs/qCso3hCXKd/ST6mjuzl0tqUz0fyo3U3pEueBgmJQOsC3cP2vcc
         6bI5hXDu0V6fyFZ7uZBmqtkCLZHpG9docAPEyv3ICc0SVUl8S2EycfmEbuf8FW4Y0sCp
         AWpz/5tC7eDexXeDQ3z8kbiGByHMYG0EfaA6OgkAPETjMlfie2FwsvS7zywGVRzl2ne8
         7Mdg==
X-Forwarded-Encrypted: i=1; AKwUvBx7pHYvdO7TFH2aTdI8PYAOCspNMHS3eFedM+0VdTBN5sy/H2v8F2ruRjmtKYTyWPMHJVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxQr4B6q2RxjGOpEGmnfx4q/InaP6GmbYEszyi/lNSVooDrbPk
	IyvBE0OYYGBRfqtXvxCPj6whYb6bcJ9dlD0LYVFvdUUgDXlbv030uI8P
X-Gm-Gg: AYBFou1t/purNs1iTploYlX96HZMGdwhjeWJyb30+QV65Q/8HhrlB+ubDGnVbQ2Syhi
	ggbYPLzJlvdq2WtLrjMBvFXlNYpM6ZWkMD7scyevm6ojjnT7NnLAQlkAZYM7dCONPwX8alXWdQv
	wK7AR/J5csbJY1wcTsMoqP8cLcUwYuKvqTFhyShMOxx+HoEQAdxLynDCbWduSUMiN3BaKtJ/pG7
	rz0avoxPE2nAJekeXiyfl18qtnn03MeM0ipT9PmCdoAzlBWpHmOSmJNyLdu9JGTpx0kgwk2LAb9
	vfbEDMoWLvh+aopIes/rKVFKMFHl5W9qhSmzglZv00mZleOOrQwCh2qxJT+vbouObs5mI0AlHQg
	mA/VOXiPMc7SobPZrIu1lTaVNdX7n4T49B7RyX9i/LdrLmrwDFTOVbfQeO1xFMxxu0Gcfa3s+/w
	9V2MqUjFgpcJgsD7QRt41Wip2dk9wW8ZhN4FIqMZ8onUZyVEPnbuqqw6btpEfhCTnY3a0AWi67F
	GdR38D8kp8xsGHr+VkzZibI+MB8TvYa7zpoMYFbdKCi0/AFh3DDbW9HIT+0XMc5DN0t
X-Received: by 2002:a05:6a00:408e:b0:87d:430:1437 with SMTP id d2e1a72fcca58-87e9d8da674mr10716850b3a.38.1790597964398;
        Mon, 28 Sep 2026 05:19:24 -0700 (PDT)
Received: from ?IPV6:2401:4900:7b76:dc42:a0ca:6d18:81af:86ab? ([2401:4900:7b76:dc42:a0ca:6d18:81af:86ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fe81f2290sm4012595b3a.5.2026.09.28.05.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 05:19:23 -0700 (PDT)
Message-ID: <886d145f-ac38-4079-8a96-f09904fc3b10@gmail.com>
Date: Mon, 28 Sep 2026 17:49:20 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] setup: enforce repo passed to
 `create_repository()` has no state
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
 <b0ec2ef9-7aef-4f7d-b31b-7141b39c2d24@gmail.com>
Content-Language: en-US
In-Reply-To: <b0ec2ef9-7aef-4f7d-b31b-7141b39c2d24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/28/26 17:45, Kaartic Sivaraam wrote:
> On 9/28/26 15:21, Patrick Steinhardt wrote:
>>
>> [... snip ...]
>  >
>> 3:  3a7c197f1b = 3:  8dd89f144a builtin/init: refactor messy creation 
>> of leading directories
>> 4:  c3ced666bd = 4:  f37db1b17d builtin/init: move handling of 
>> "core.sharedRepository" into "setup.c"
>> 5:  25918a4ff6 = 5:  db76d32f2c builtin/clone: don't apply 
>> "core.sharedRepository" to leading dirs
>> 6:  a742852675 ! 6:  19388a188c repository: adapt `repo_clear()` to 
>> fully reset the repository
>>      @@ Commit message
>>           some state because we don't make sure to clear the whole 
>> structure.
>>           Refactor the function to set the whole repository to all- 
>> zeroes to avoid
>>      -    any kind of leaking state. While at it, make it a bit more 
>> robust when
>>      -    called on an already-blank repository.
>>      +    any kind of leaking state. Replace calls of 
>> `FREE_AND_NULL()` to instead
>>      +    use free(3p) to avoid zeroing out the data twice.
>>
> 
> s/free(3p)/free/

Oops. I meant s/free(3p)/free(3)/

 >
> Rest of the inter-diff looks neat.
> 

-- 
Sivaraam
