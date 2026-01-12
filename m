Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496B1DEFF5
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229121; cv=none; b=rxQ6k67THcY0zT8DQSh6kuvLmuEvzP5l5Y07cpsTMHV12xPhk9AMh7bKnmG3vDp6vUYMbrRJfcILGdgQSmGJTCw6NHCba/IxkUhtL4q73AfOdJcMDFym9OLInvEa+Z7NMvOTNpqLX86UBTnucVSXXhWucURR69BkiDKSZ7wisrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229121; c=relaxed/simple;
	bh=bxjwGDA6JYc0pSoeP7nY/iGyRSeGR3qfp76dfz6UsB4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p3GH/cg8uV9LDnqMeNPxomwj7sk8V7MrMQY2fNBZWdTx25t++vBSTpp1sO9ZyaPaRvWn7fPxIxn2EwRmDk8Rqqo6/93AEbSl+AoWaWBVzfsgruZcxlEmfdD8rsjbgfBLnNiJX4jlDg5J74dK4sUx4UVXL2w9Cbcu+/uRpQI4n5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjFigoP/; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjFigoP/"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b87003e998bso263449066b.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 06:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768229118; x=1768833918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94Q9ep5pGQsTOLK/f/bG9YdHppf19EmNpj0wi1s/mTw=;
        b=CjFigoP/sY6FUbr84g8xjkv7qn6d9xbOaySWWeO2Y/S7fO91C8L2bMGId0DNs3PCME
         L7utNs0cGhHba4dgDqDkE5BfX0rnDjNLbZmsTrUjm5IjJUrGtaTNxspRjZP10Y5U3i/j
         c4QvLQ27RYoUgego9mbX0RY0s9Pscb1FBP6wUzA5rHTxRhM5Gsu4pbVYeu+s27M2SsIc
         1YvU9hRyMTLymK4gUAoXK9ZPCXkbgRzwl3ud534bweehjMrB6ANOdKTS3CW2N58lZ9YF
         HZGTnVlPZxHMRT2bsgFglH9B+mCHCXKtrhsH2sEQe2SooZlq1l7fyPAmRYrIGZ8g2+St
         pQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229118; x=1768833918;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94Q9ep5pGQsTOLK/f/bG9YdHppf19EmNpj0wi1s/mTw=;
        b=ac3yIRzMbpTOge1W+PMmg4lbOwFhrq7aWcfXKhyAldTMuF+Jb1Yfyjb/mZQZ3jhnJN
         tk94oy51O6zIHp4YcNyzyTqfA3eFwXr42gCbjV4IPyfp3dMcaB5VsBAACsf4MRok8ArS
         KMsgHD1EDW3Ucr+9FLYc0J3YNIP1ZGejvd2RqwxqkOF+czO3rSoXFvh0NZVgryk8a8SZ
         x+pDR2ikjR4GrsnopZSnE0zXYMPz9nqVc9d9yu1HqtXK2IXpExyT8eWs/eMBBwoNygZx
         34cP+M55pUr52u4mxf94t8wB2CpLyNotrtP79+Wyfb7g1Drlqxe5tKNFmB+tGvVCqfxG
         oK1A==
X-Gm-Message-State: AOJu0YyZeygk/xHGRFY6jD8AYGEeKpLzzmJmP3XDKdA/ZzTqlNopPhc4
	aTxV5iDMWo5k8tEhlZ3xNsAiS5qpAL8d1o445exnKRsKiGwXyvPsKJgU
X-Gm-Gg: AY/fxX5cvy0aVR9c9WryRPFtFYOhEzsn2CuD2r87YJPbtlL5mTz55gjGZ5bBlUDDI7R
	1vV+JF43gZgXbF/2zTJJO7Fu877rfeh0yiiR5ZoR1il8ypcr8C0nyJzeIH/IvpsZ1FHphYieRuv
	3JQg3y1UYsa54cXzpsJzqrXY9vEaoMjwMIyMpIKko3giZQ6IcynH2+ysdRlmf2O5GpcbSvR1wCQ
	ifODjuHVm5ZWwQX1+d1EF2dASzjOlD6eYN3BcvC1LifVZuqjV6bRH5P2XuKJnJIGU4pn4rsJVb5
	RYZlkAUI3e/+YigQeWoHvAsppmzDMrTPCJQoRH+camaiJ8COT797ayq/q62UQQpNDdlzBrXQ1LF
	+MrrbvH2GlEeTLcCsJG2Mqzz4g7zmEJlMQqk9ek0On/NmXYK8M+zbXTvwR5n9kpesCgeGUY5lZs
	CwUTDA9JA5rnoTKq1dT8ATEFUjGF5AC9BFHDXuV9Pxl0dBRRYGNxvTjiEl1V1wt0teiw==
X-Google-Smtp-Source: AGHT+IGfVrhH6RPWMVhtB96VgrHoreWcaoXof5DbLfHOrfVFsOvTr5nx+D0C/U5xURqbK0exl85PbQ==
X-Received: by 2002:a17:907:3d11:b0:b80:3fb7:8e68 with SMTP id a640c23a62f3a-b84299be630mr2292818066b.21.1768229117794;
        Mon, 12 Jan 2026 06:45:17 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4c15sm17803102a12.4.2026.01.12.06.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 06:45:17 -0800 (PST)
Message-ID: <d2ea8560-1473-43c0-96c1-e1869e22c721@gmail.com>
Date: Mon, 12 Jan 2026 14:45:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
References: <ba2b65a5-0e2c-41a5-a480-ec3f5ec2178a@gmail.com>
 <20260109160037.2067-1-haraldnordgren@gmail.com>
Content-Language: en-US
In-Reply-To: <20260109160037.2067-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/01/2026 16:00, Harald Nordgren wrote:
>> Using an enum for a set of flags is a bit confusing.
> 
>> On reflection I wonder if we should be calling branch_get_push() instead
>> of remote_ref_for_branch() and tracking_for_push_dest() as it respects
>> 'push.default' and so the branch it returns is the one that "git push"
>> without any arguments would push to.
> 
> I'm not getting that to work without tests breaking.

It is hard to discuss this without knowing what actually breaks. Are you 
talking about the tests added in this series? If so that means we're 
expecting a different behavior to what "git push" actually does. As Ben 
has pointed out elsewhere in this thread, if you're pushing back to a 
different branch on the same remote as the upstream branch you need to 
set `push.default=current`.

The advantage would be that it simplifies the code and it means we 
respect `push.default=upstream`.

The current implementation returns NULL if there is a push refspec 
exists but it does not match the current branch - in that case we should 
return a copy of the branch name instead.

>> I think it would be simpler to just return the full refname and let the
>> caller shorten it.
> 
> We could to that but what's the benefit? Shouldn't a helper function reduce
> the work for the caller, not the other way around? 🤗

The benefit is that you get a sane interface rather that returning two 
different versions of the same string in two different ways (one from 
the function's return value and the other from a function parameter). It 
also matches what we do for the upstream branch.

>> Why are we checking for BRANCH_MODE_PUSH here? Don't we want to show
>> this advice regardless of the mode?
> 
> Yeah, that's a good point. However, this will often lead to the advice
> being shown twice, see this test:
> 
> ```
> status --no-ahead-behind shows diverged from origin/main and ahead of feature branch
> ```

I can't seem to see that test. If we're printing the advice once for the 
upstream branch and once for the default push remote I think that would 
be ok.

>> If we don't want to show this can't we set show_divergance_adivce to
>> false when we call this function - why is it guarded by BRANCH_MODE_PULL
>> as well?
> 
> This will already have been shown the the pull branch (the upstream
> branch).
> 
> And in the cases when it's NOT shown for the pull branch but only the push
> branch has diverged, then pulling won't solve the problem anyway. (Unless
> you would try to pull from your push branch.)

But we set show_divergance_advice to false for the push branch so there 
is no need to check the flag.

Thanks

Phillip

