Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3508234964
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453138; cv=none; b=WzT0AC3PB5zGGIcRLkgwS6VgzSo28910fUqk0Ac5Wq9zCguUowyBWSr9m6N1vKP7RSp5NG2yzPuX5aLqkx5n1pU1quAEMTnAOoqdu6I3CtgBhCILld7WnmcLhTIvOrDK8hyDj1IW5M6iKaQnyPLdSnF0ytc1sb7n7Ssag59098A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453138; c=relaxed/simple;
	bh=obve02l8RjNurJAmAD+2+KyHHEou5YXw5XhIQ2mqDCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrgemoJMy47qsVCjO3u5/u1kaXNBqnfe3CZzuOak2EcmerRNss1Xbrr/zj2WLX/UHRmarY6JbtktlJhl/X/WZtyUPT7mwAG5mC0pg4+xwlTugBlDaVh1ztePDJiIZSyh1I/4+EDsrHRwKOd6De3kRYRWSoXoMwtngeEm751UFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxsx3fb7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxsx3fb7"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9f316d68so15013655ad.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774453136; x=1775057936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4N8r3jZB0PFzO/nutBx2zWeXmhZJ1eamroYAKAiHDPI=;
        b=rxsx3fb7iQWafXJquYl1p2kDuKn7gCV9tc2hdgwYAXAlFmtiYDi3lxdP65PbN1hCkV
         mTjXOxyKst1hyWJgjYal1VLT3uooXTJ9CL/mdxrDXSEJlpgyGbQ9/Rg/WuTAcbeyl8yI
         swn0SN4ZNBbVaAeNK179K9qlJQVooqSf2Te2wTb5jVuWCRWClzOG+b8h/JWtxWqp8BAG
         yCGqhH05Dq91RY3ZB8ygrVn4GI18bb9UrkuW2rfQ8SOSepnkcTLb8DsbSVCm/p5fI0rk
         LKy51MG9XM0XmRsdQuDHsMAt8I+MxreD8tkH/+J/6LqplZ272MHYVQiRinYp1Qm53K+E
         ag3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453136; x=1775057936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N8r3jZB0PFzO/nutBx2zWeXmhZJ1eamroYAKAiHDPI=;
        b=hgnfUHD/tmkSGlGXz+eNFkvhM/JwJdo3kB2lnp/HRY2WDHN2KW6Ho0An5kqWSI2uFt
         JILO9tLE8Bsue/tnB5htgveGSyLzGPwiM0V9PXZuRaxjkdhEDxXMswX1kori3p2g0G+z
         XdEOkZeVa3FFR2FE7c1WiwTffSerhKmItFmzM1/IQ5RW0KFmU3C00TAlO16qh+QH+hgu
         J9rH7bBUTogOY8MUZK2wdjr0CFpmJZ5LQkVK1Q9i3tai0rM51zhrdHxGyWIIUg9g32CR
         0HDG8Gkz0HAmiDLug8xkWUYjgKN7GKJE1QZFLKxI+oWKPKIIr8+2K/LLu3oq+Om4WoCx
         pjoQ==
X-Gm-Message-State: AOJu0YwKRqpgr45qqJOY5mAMU42XL7iEPapKpWkYpIEYUp23/u/mMz7v
	awBMX6yYd1UdzpP7IZAjVxD3brUedmjsJNg3/nJMmMkM38RUWDfiFazI
X-Gm-Gg: ATEYQzya8mjoUoN1kT/QNPCogDzWypNi8GTqyf5riGl5Q6FGS4eZag1jdqjyTcBX4Ws
	grfXIFkEYE6iOjXEM1SAebjvPzthO0kPj8Tlg7sJn5wIewDUhKKah1sLiSzmWYT8R+e3p1Jto49
	ZS196bvetoTHfCjmR6DlE98iZ2lo4M2CGQMMmDt2iYfV0g3KuMWonYqeuUwenBTKgOjCpxfUgUP
	U26DYLNPprhs8CPAvAU378tHejVtrae9hH/hycuZ4febtLVhrMWnOUenxl0oSm1sF5eZK9PW0mm
	mEja6O6NEq27pP85quAynlJtOxzoZsr8X5XkohdHRi5d1BLA700p1Rf+CWcWYUXuKxCu7RY5l5e
	fX0edEOUdeh85kAbYGxtfqdGnTVkF3G9vjqrljey+DO5tvo/KTn0puCneBHWhU6HP5cj/tgBw9W
	L8tUrmpgqMm7wxfjYC8Y+j4mJWMhTNjLuL+S5cUAqB4b1+A9c2hwTBADVMexD/6kxsxLdfTLNjK
	Lhegy+Rt1OjNFWWOYy4DBWbJjqj3gtzXYY=
X-Received: by 2002:a17:903:298f:b0:2b0:4f82:74b1 with SMTP id d9443c01a7336-2b0b0ad8375mr46022045ad.44.1774453136005;
        Wed, 25 Mar 2026 08:38:56 -0700 (PDT)
Received: from ?IPV6:2409:40e3:30ab:6862:7ceb:99d5:377f:7f66? ([2409:40e3:30ab:6862:7ceb:99d5:377f:7f66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8a89basm2068305ad.56.2026.03.25.08.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 08:38:55 -0700 (PDT)
Message-ID: <bbfd7781-c5ae-48ab-9ac4-8ea752097cb0@gmail.com>
Date: Wed, 25 Mar 2026 21:08:50 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] replay: add --revert mode to reverse commit
 changes
Content-Language: en-GB
To: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de
References: <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-3-siddharthasthana31@gmail.com>
 <xmqqh5q4xvyw.fsf@gitster.g> <87cy0s0wt5.fsf@iotcl.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <87cy0s0wt5.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/26 20:40, Toon Claes wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>>
>>> diff --git a/builtin/replay.c b/builtin/replay.c
>>> index 2cdde830a8..d3c1d920f0 100644
>>> --- a/builtin/replay.c
>>> +++ b/builtin/replay.c
>>> @@ -83,7 +83,7 @@ int cmd_replay(int argc,
>>> ...
>>>   	/* Parse ref action mode from command line or config */
>>>   	ref_mode = get_ref_action_mode(repo, ref_action);
>>>   
>>> +	/*
>>> +	 * Cherry-pick/rebase need oldest-first ordering so that each
>>> +	 * replayed commit can build on its already-replayed parent.
>>> +	 * Revert needs newest-first ordering (like git revert) to
>>> +	 * reduce conflicts by peeling off changes from the top.
>>> +	 */
>>> +	int desired_reverse = !opts.revert;
>>> +
>>
>> Compiler notices -Werror=declaration-after-statement error here.
> 
> That's basically the only comment I have on this series.
> 
> Except for one micro-hit on the existing docs about <revision-range>:
> 
>      <revision-range>::
>      	Range of commits to replay; see "Specifying Ranges" in
>      	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
>      	range should have a single tip, so that it's clear to which tip the
>      	advanced <branch> should point. Any commits in the range whose
>      	changes are already present in the branch the commits are being
>      	replayed onto will be dropped.
> 
> Next to --advance, we should also mention --revert. But that's totally
> not worth a reroll and can be addressed in any other later series.


Yeah thanks for catching this, I will include that in v6 since I am 
rerolling anyway for the declaration fix.

Thanks,
Siddharth
