Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3911713
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680863; cv=none; b=J13+yoos2yd60MkKOsINkbhiFvMEN7ZXHVglBuHiPvXe7x9g1ulPdKAqFybqUl+2Walm8hMOjj5s6RaRI+Q/QRk/NE5LxvRIdVaXyGBySNfZs+gwt2Rw0SynOtAoRVZSWeikgYfdwG421WIqU2hfBKCgKpyy0gR9Z8DhAT7VuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680863; c=relaxed/simple;
	bh=TbMOuwEcNWRd11yXQmhT0EioqXoyd4GZskn8Vt06ypo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZj+e/DZ6Yo9wyUj6yzJY3XrgSR63NXSNNfOwLcbHbdGz63Urt7JQyo/hH641kP2ynS0DWYGtB27vet5SXM/crJNk2+RKkOFlKqnVT3bDhThzXvjudrC4D7h2g84ZEkuEQ0r4bjstpFTgHIehsvQIN7Cv0MDjh267d4Ax/YRp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lshy6Xs8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lshy6Xs8"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so6310742a91.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761680861; x=1762285661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfEsRdLUTUNQl9P7UigtSQngDIMEM5wNoxBdeOjomSc=;
        b=lshy6Xs841TL5b3Emsbkbpe9rWV7Y6A+BrUJLNP6byVJLMyACHikgf8k4zoDJGicZm
         Z2yBNRtpRhx9uhrxwK6hVZkciYv4f73kIrsQHco1ZUQteKAbhfJ/pCxJlt2hRpGwHHLu
         s4nFPNEWTjHfhoHt/88q90lhStHdRKmvCYe4lbJCYDZ89lEg8guwVG1Wip1165xkALg+
         fn/wK6EfIa/5OGyB/K41Wy4Jpadl+XfvJxj/le7Ho0VVk/Gi9EY+yXLOP5zGAH61HL5M
         sMpNR4QkxsXuwVnV5kQMI/G62keYWnGb04vTnMAzhE2w1l77FKY7EupAFulA9FJ72M9w
         o3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680861; x=1762285661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfEsRdLUTUNQl9P7UigtSQngDIMEM5wNoxBdeOjomSc=;
        b=MEMqx1bantPHhF4gCWKu+loh5c+GsFsg7B3lCLgcK1w58XwqW7e/JSln/bXZpvZkzb
         2ddGajDvRbMGTvg7FGoHKrRgwk8wVkP9XFjJhCnfRqSS9+j67EIX6c9aso31QgHR8gjw
         YfE2mHj2g1gPyP1XUtdfZhZnpyNzEUCePFBDFLeSC/Hxvkahcu2Ai9RCTjNpmYSS+1mF
         aCrpA1lwd3f8QecMKrI59cmT5WMI+3aZGi4d95bdBpaCINb3o1DhpMYTJwDT7Zu0jZKw
         uToFdp07n5NkOhiJY6Kk9dQ5BitzrHK5c9GFRlsYIrhxQlrn4xbDGEhMCLWSrmvYUgU4
         IecA==
X-Forwarded-Encrypted: i=1; AJvYcCWnniqsRJZ+YhbLlQMM4b7wqKEiD5lVitRN6Aw9KqdWyGy9XT+6AkITiZ0ZCKA33WJAGTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEQ7wfSDTP9hXSYm+oUV1MhxA056BFzATmCpm5lOaUsP9Y5SA
	C7SRwSNyr4zu3dQ+zduJb7ZOX6zcVPvTsb/AdO6WocRbS8MOXtEyTEM4
X-Gm-Gg: ASbGncu0I7xKaJM/h55U91RKIc88nStWsSu2XHooVozSBJl+mNPKNTrLv+sPuQ5xNDf
	QsRfVpvUXFaJH3+dA0ydS7v+wjlhCZY9oJRze4UL8XgA8CxOtldM2q2WQGvngEBS8M/bF2hs8eF
	ij1VdO08D9VtVzGDNl7LW7YMVFoVbLCnZcXwb3pMxX0RtB0On2giuALuT5Dcpcy1AVcdXqHMj+t
	dpRqQpg5UY7puMoh/WQTthNu6u5R4oeHhOy9v1CTludYg5TzPDOah1dJSbQ55nOqvkJXbzKROHH
	9U6zS856zntBw89LQhcoFdEDn1Ih36WTuoI1kfRK2g3CzUh8OoF8etLDXWA78R9596WBS1oK6rc
	5P75BISELgvLquun0lQKNvH5MsKTtKvyLp/J0C83IRFJLeSbuv/e9Z9DVNpUaJF9w5VHjdVMoIW
	PuNkoZtVWqn00ORBaegMhz6wleyPoce/VActm2SGLB9ploI2gqCgZWx+joIuWbwEa10ERGg2Af9
	f4f3RHRg2oGynRE4PBtbMsrxfzW9hYjP0nCtUnRzSWb1NDI+r64qSDtfe1ff1g=
X-Google-Smtp-Source: AGHT+IFsP+D2HgE8fIf6SYeOlb1+FMCpKz4WDoFOhtQxmmTLlYzpfebks9py7kh1STFB4lKtfqsANA==
X-Received: by 2002:a17:90b:4986:b0:33e:28ea:9bdb with SMTP id 98e67ed59e1d1-3403a2aaac2mr181129a91.31.1761680860791;
        Tue, 28 Oct 2025 12:47:40 -0700 (PDT)
Received: from ?IPV6:2409:40e3:177:42ef:798a:642a:892e:b13? ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a86fsm13104952a91.1.2025.10.28.12.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:47:40 -0700 (PDT)
Message-ID: <84729f5b-87a5-4a5e-a875-c28ddcea3b5b@gmail.com>
Date: Wed, 29 Oct 2025 01:17:34 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] replay: add replay.refAction config option
Content-Language: en-GB
To: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-4-siddharthasthana31@gmail.com>
 <a4cd31ad-7086-4d05-ba00-db65ec24b45a@gmail.com>
 <7a3161d1-4e30-4156-876d-7eede4b06705@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <7a3161d1-4e30-4156-876d-7eede4b06705@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/10/25 19:06, Phillip Wood wrote:
> On 24/10/2025 14:28, Phillip Wood wrote:
>> On 22/10/2025 19:50, Siddharth Asthana wrote:
>>
>>> +    git replay --onto main topic1..topic2 >output &&
>>> +    test_line_count = 1 output &&
>>> +    grep "^update refs/heads/topic2 " output &&
>>
>> Rather than test_line_count and grep it would be better to use 
>> test_cmp here.
>
> Oh, I've just realized we don't know the value of the ref so 
> test_line_count() plus test_grep() (not grep) makes sense.


Exactly, since we can't predict the exact hash values, `test_line_count` +
`test_grep` is the right approach. I will definitely switch from `grep` to
`test_grep` as you and Christian both suggested.

Thanks,
Siddharth


>
> Thanks
>
> Phillip
>
