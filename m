Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597F3ECBC3
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950315; cv=none; b=YBWPC0PpPat3+Bhzz5RFcw4t1mR+ETwUUjFf6vMRm77w7dDAxOZqqRjZzLkYLqsvsyAQMVTP3OroqAI4lCZkN19HxXIi3xirTl3WkE8OpIJa8Hk+tUukuoKQ6p11cS9pSXkWQGk5lJVF+yrMIv01EqoCS89/tf/aF1Tllcpuq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950315; c=relaxed/simple;
	bh=dOOHw+e0QE/QEzytSz4pGwBl8HJoo7P5SO3QqS4rqIE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ljc/LRPGvFLwq9CKYSHOXk8FwNivnWSR0xrERqIccAo0x0y/C8qVI/HDq2b/G6fFNeebyW+SYhYkkponZDXLNegytJah/coP0HxEQSE4qSbWSmDEqR9M5h95vN7j496IVQ5mKc9MRO7uWF53kdP2z3SX/KnBj4QtgkaJa5HLCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7DDzdeh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7DDzdeh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-487035181a7so36671895e9.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774950312; x=1775555112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtcWtXokzbjyxbzhx7ZiO8lUkZGE2KxXJFOTSk2gjYQ=;
        b=A7DDzdeh625e3bgydM+D0eB6i0kwOD8j0+Ci0TOOxNlEEXoDxrHV92sy1zXTJa2WkJ
         FTnpcLbkCuTSk0CJ0Bs2xXaAnQLskF5/2qlyaP4n3ssf9nde/X+OoFN7KWMs/8y19HZx
         kgCqWsG6r/tIlX2ZYC4B/0aTZYKZEA0KP+OKxzN2eeWpI1qBltzSg0mFOILrfYZ1gdLt
         pLxLa15E8NuR2pZjab0c+Ie5sKEXSZ9BOq3hGMAC4yZyrAKo1uNVSRS8zHkQkrdly9Kk
         NRhkUXGTCgrHZd2Lj7fGU87+nmsBHFkx+RusVuIUAUxiXg3WR7Y3hX/ViPUvzwhPNbwg
         55EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950312; x=1775555112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtcWtXokzbjyxbzhx7ZiO8lUkZGE2KxXJFOTSk2gjYQ=;
        b=LSWGFXjAOLQ6VJrgXEjrGfH9U7QN8J3b0JODmZWkGtPfGi+peIAAJW5XAY0Ie9ObFu
         sZvs8paKQ5l0DJ9MCSnOXgtV+tXxpZLREuzTJJg0CsPfWylnkI+AVmz/bPPm/+EQLPJ0
         uxcKnKd0MFN8YT2tp8xAxhfVUQtX4H/TwFCN63be1okA3LA+ltVFfYVKIkr31OfLuXKL
         n9TpWvYHvgKEWFkQ1Rn37jNeEvo9YnyGe6HVd1P1j1xWg/FklulFGmJf2jWVycGv9EZx
         znrpW5hYcGXM6BQev2cF7PJfqd8wk8aF5WK0jhB5Hw8VuIVaoECd1G/f2vQIEgwpPCfV
         2hZQ==
X-Gm-Message-State: AOJu0Yzkf5tRQ+yXLuscONZP3gE6XSLJv+JJuEN7hNHR/+54aalNUaUg
	lTmye7Pt/YjGweAvA/TPkYOFfMiwhtpcnSYXs+qFUjxG5fsXhEEmQNzc
X-Gm-Gg: ATEYQzxw5QmzeFMSWCHVclcupvZO2PsxsY/F7D+CbiJ2n4Nupi4LmfB8gv75T9RthiP
	BsrEeP/dULGYDCy2vPuJFmZfTkqVje2MsvsVe9CyP3yqS0t9F3DlrIcmnJTIKmbSQUBPqgFOovA
	ltm9cjaRAyqmN8yWgtFf42FHGRRxMyhE+PM2F3Gx4LXGudI8Kk0+kMdsKaVoyUf9ofsAAzwFkr5
	nOpwjOoglP6DD662V/U11902wGin1bKo4n18IFaRjORj134x0/hq/OaurKdUr1n5ZQqOAyZyuWX
	ZgFOE/Ex9wGLSRH/UfLgUQibHy1/Q/Hr6M49l0KLXZEmYwYw6W8yFYly2IJgUW7cVWakonNkDEz
	PkCA518apt2lpouqDKiRqSuE3qQhweqAeQFe46bJULp2+NdaR0afEJhV1sq/XbfJ8rMNoVUluy5
	MIy+UqhwgtOC71+enLJwFJHnt/Qu71BtHcZ6GLmufExem6zgBBQV+ICq82gKj6+rG0O6KGyBvz1
	KM=
X-Received: by 2002:a05:600c:c87:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-48727edde70mr264953935e9.20.1774950311908;
        Tue, 31 Mar 2026 02:45:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e9630ddsm21856285e9.13.2026.03.31.02.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:45:11 -0700 (PDT)
Message-ID: <d4b72cd3-9429-458f-970c-8aa83dbf7286@gmail.com>
Date: Tue, 31 Mar 2026 10:45:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/6] Xdiff cleanup part 3
To: Junio C Hamano <gitster@pobox.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yee Cheng Chin <ychin.git@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
 <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
 <xmqqtstw6hs2.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqtstw6hs2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2026 00:04, Junio C Hamano wrote:
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Changes in v3:
>>
>>   * run make DEVELOPER=1 on each commit and fix all compiler issues
> 
> This round looks very good to me.  Let me mark it for 'next' unless
> others bring up problems I failed to see in a few days.

I've left a couple of comments, they're pretty minor though

Thanks

Phillip

