Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD03B05A7
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338548; cv=none; b=pOjQYN+fiiFRkl6u/gpm/UexO1zAkql6M8E7zDh4T+1413d2fGukvpHRq1eUcqwjiwCx2XHQ4fqOs0AM664M6vY4Yrd/gMd7Ap6OLkM4IVnuhF4WZJM2MXmZB1ANCZL4s0gCmuqmPFUz8ORLlGK3QDap8lYaBzBLsCctKXTMRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338548; c=relaxed/simple;
	bh=RYHd0Ln6dGJ2FzSWeJXS7K0hk337XBS7UGf8m8VUFuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oijFVHEIXER8PMkDvCYkFV55HLt09IFkgxMjd3BptDZSnjOTkocbfFqRsYWUw1UEuDs5J6mzbJWw0S8s01i59QtdPbpY+KfHcVZxZzAA6UfstrXyVGBFYoR5zNUdcD4ruddcGV5sBehENslnuyzTOpksP6JCwuLD33O3yK7TV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSa93SXW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSa93SXW"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15f020a223so173803566b.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785338545; x=1785943345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yPMuT6LOAs2g+KZKMwz13bZ0POHwaLyCVh/Dbs70GMk=;
        b=nSa93SXWwQaJlNBXZGbTv9AOpZSCkfAXW32GjSp/HnlOmhTqs4SY7MBDLiz+tjNXrv
         8UeB/gbeZ+wLgNw5+yNjz85uEn8clehWzyglHTeUl9e6YA0jKByR9B7SsGC157zOqFtG
         YB7KequueMsod22fzmSGm2Fz9icdBhH1dEnPY7lRh/Z/fvM1ddbpvq6SnuGFREIOw8l+
         6D9Td1cEMECkhM/VIE2a6m1lBn991QMbsTWGRv8ruo6bVpooTqdJU7/Z6ICtry142QQ/
         apB7NRhSGNMJlCE+h02SG4ZnRH1HIVIfWt3sSHI8pn7kFpKYN7bKF1WwqR/3Gx1EXJec
         ZniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338545; x=1785943345;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yPMuT6LOAs2g+KZKMwz13bZ0POHwaLyCVh/Dbs70GMk=;
        b=MwMC093Qgw6Rt/IK6G6dlcs7DVh/VOoPxyhkZCMp2aUoECJcGI8dsbMrLqW0Qafsdx
         E1+X06h/2nyuctQa2KdEGdMIHz3RiLexqgYoO+b/9S0A6AHOBIbrBijXAryEoJlRSR6S
         GLL9uctP90/rVUQLEd4DDMYpaxsIC06UOZ+2fi32De+ew0Mrx6g9EHNeViFVRguGFzly
         zWx6i1Eol4OKys0Y+SmOmzVIvcyQFZceeQBwGTbw5U/32ih4drGoCg1E4z0ng0DUjAdu
         1uB/5Mfj/ntQRH8qIunW+TMT8QHRiBGyLuaQF6nLEuwS/T2LwLTC5rwq/47OVLshBDar
         MFUg==
X-Gm-Message-State: AOJu0YxOeGgSJ76rfn8bIb4DSueW8QaqnwTFhIqjagm4fGexNZbPPoev
	TAY2228dzhjyI/rVTqDoCA4aCAlw4qszy2Y/lPvJAqDCOtziY7J4dUs5
X-Gm-Gg: AR+sD13L4VQ/jIgfeRPJKb62Xabj50OdaWDRZ+SR+/pCU0qbJ460pIoqLC32oVadW3G
	dH2vXSGKycPIwUPjCiT5iL55Dyg0i8uxxDdzkE50M8tVXBaD0vgiXsvu9lygvf4SyM2CrQL+jnH
	yUyTpKdrnatJYsAGf01urp/WV+Gj2uyCgA6dmeIPfb3MTYGzMF6EnG/hY4D2Ig1UPLjRpzVu7Np
	s5vH+52NHpwPdj0UM8XRnBLS563599ic6YEzbbSvsQH2wvkB9edtjv/hR6v/MG/KZ/xaOhyC3Fm
	SA1Kgw4sQckgHpR+Q5Ou8KMNsbCxdDHmra40ayq6ukrpKVn2xyskAoDbLerljklFV+1LphXiszz
	Tf9F2EWnGatHHiT3wKX//ypXmatGt3y33sgflrkD6FTk+0n8HdBTUZUBiZEDPuD8Lqqw/U+mnV+
	szQGfMlU/l1jFTa6L8rffk2NDUbqDxXT6uNQ92DT9WFKGSw1GQKZbSFrrVT1924SMWZ9Ost9fZB
	4mMhNFiJFS0hc5P8bpnP+ou3iynjAp40Zky/rfa0qA=
X-Received: by 2002:a17:907:3c95:b0:c16:46b1:e0c2 with SMTP id a640c23a62f3a-c1f72226e5fmr428163466b.62.1785338544680;
        Wed, 29 Jul 2026 08:22:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4de45sm129786666b.35.2026.07.29.08.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:22:23 -0700 (PDT)
Message-ID: <3bdca3f4-affa-4443-afb6-fd7ca20cf012@gmail.com>
Date: Wed, 29 Jul 2026 16:22:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] branch: report active bisect run when rejecting delete
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, stsp <stsp2@yandex.ru>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
 <590382fb-731b-4e14-911e-ff68356d1082@web.de> <xmqqbjbtyd80.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqbjbtyd80.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/07/2026 16:36, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
>> git branch refuses to delete branches that are currently checked out
>> with a message like this: "error: cannot delete branch 'foo' used by
>> worktree at '/path/of/worktree'".  This can be confusing if it's an
>> internal checkout for git bisect.  Report a more specific error in
>> that case to help users that might have forgotten their bisect run.
>>
>> Suggested-by: stsp <stsp2@yandex.ru>
>> Signed-off-by: René Scharfe <l.s.r@web.de>
>> ---
>> Changes since v2:
>> - Only report bisect runs as specific rejection reason for now.
>> - Leave rebasing unaddressed because I don't see how to formulate
>>    clear and readable messages for those scenarios, yet.
>> - Collect all checkout reasons of all branches in a simple array for
>>    easy use, e.g. to eventually address rebases or for git status.
>> - Rebased onto the landed test_grep conversion.
> 
> The scope of this patch has shrunk a bit.  While the 'in use by a
> rebase' state is still recognized internally, unlike in the previous
> round, we guard users only against the 'in use by a bisect' state and
> the 'in use by being checked out' state.
> 
> This is probably a good single step, so unless there are objections,
> let's mark the topic for 'next'.

I agree this is a useful improvement as it is.

Thanks

Phillip

> My understanding of what is stopping us from taking the next step is
> that we do not know the exact phrasing to express the 'in use by a
> rebase' state concisely.
> 
> Thanks.
> 

