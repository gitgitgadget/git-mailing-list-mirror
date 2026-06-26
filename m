Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E43E3140
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485890; cv=none; b=QdBGuumeYLYCHSCXnSfE8NYXkY9Hfw0AM3u2wxDp169V+RSYRDlrzNDvXCVgAGFxqjgsL5TS/2Od28ouZiBP/MoLhqG5Dsv4E3M77UrAXaPU0yA0aiHwaXRaxs0HwzedFw6zWuQmIvlcPZBOB96Ov5EAxd+1Uu0VY+QWJeaF84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485890; c=relaxed/simple;
	bh=LU5yP5A6aOYRLvU143cRirxNdV9Mu65hknhrpMVENI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmG0vqU47bM7YkQKGaNGw9UHmEqWyMkHIGCZXhYVbObI6s4m3uoY01Ow2ThJih0mrxHr1yld7aUY1y+VPmgrqXX/kfqXnP0zZcBzxwSb6b2tK+8d36YLp5IgpA2NdX8tXIX5kehLQOSdPMaRWKBlrxozHX2Irf2Ime1qXBDtfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLHqVCfd; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLHqVCfd"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5bd742ef746so365593e0c.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782485886; x=1783090686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsUlQBm7KijwXnFLN4FwGId4mkVTuWnFhMumzvDhmbc=;
        b=VLHqVCfdjZZZKK3ZWQuSwXguM5vMhhip3MLofV2/+QyloUvFubjPqDwZcaW8gXTYFm
         F4kVRb9QvV9PJz7yST7ry46xKu8NBskU/gDMFCAxLlm8jwIr5MUK//TBo/xg431djngY
         2mXvKPNSQw3wUqOWJZwCnCGozr27XEgy/fY1gMvH4/cvFnefaH+Hu0bpFEn4T7FeDeUU
         qDJhiUmdlkJo8Dn4cg82hX2E3AXultCpqa2fRKtFmOzYEMHZqvDRwnR12xShzaifBFoC
         9n6lm8iX6OZi8Ib0gwocZpYwZOr/m/5Q3RenTWF+K6KJsDP12UYd6AHMXYDhdXBsFxMh
         3E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782485886; x=1783090686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsUlQBm7KijwXnFLN4FwGId4mkVTuWnFhMumzvDhmbc=;
        b=YUPCZDzG7MTYKwNlEqlHyxutfynT1RSlbBmXz9x4GQZYbwLTRxkIv2YK/CJS7LXuga
         X4TXaPQuOB7NfMSOJ8yJmvfGqsImqFRnq5TQ2PXPtd9srIIyuyS6Ht4qZ6P6pelbEPiI
         81a71vi9gYwj1QlmlU0TPPxo3vQBUOzLqyrza8eJEwxpUe0CfMk5LG9RVvA1uYB9SFro
         XM0wFXdpYjv8ni3TKSPufuxCH7u9cnG34HMXiNT3RytAqcpTszzX6GhleCT3EXT2unxy
         XO8txeIpdma3KSgOWhVUMLkLo4RRhXmv3KtlAvzgopfHE9avN2cr35TqwMHOPGEDoKfR
         PQ9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpQLSbIdNb6UvRexN/Ne5cwQocImCEzRTCkq5Ptwf3qMhwKAeJpZo7ag4IlQr4/iu6R0n8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8iqfYJ8oT4grX+rACpi5Rs1dZMiX81wUU38rI4uCtTzjPodu+
	2mQ7IbRJDv667Rre9hYbAXL3SyUAMuppg8ok1pxYDjTuefY1CRnUcukL
X-Gm-Gg: AfdE7ckpuHZ/0BeEb42k3cn7mWcw0aq0nW9xAjT7EcwldKQSwQPz/2OvHBN9vnk/xtx
	LMEJ6goHn6LAtRY+8trgArzAzbvW2KdG3AgsIC3/kUJB0071U5pja7/0ol1OBkREUVFnj2Xu2Qa
	NuVo8AX85+XGsEKnWkuCDadc37vrgqcDn7c3/urf62z3OqtKvaUDFcP1+nDMuR+FRnRbbo4ko9R
	biLu+IVPkRh+Z/mc27tP71Tebv+/YrW75SKAJ4aoOQW7HQ0l25dRQPc8XJFwjp9sXjYjC4Sf+SL
	jDCAT2A6XL94HMQB+2oRmruRwiDrcYH0coThkDcRkVYizWbDMie+1dewUiSL2AOoCopUv5AckmO
	96YB+yc87wV+tJFrRGe169bqQr7ru7kxQNk4OsYY96FJwzCiT1nb+jNgPW32XptaKmvDaZGQ3DT
	8h6hDwxAp4Ed7dCZTotdlY9F3DkbGA9yp+2/DdDM18sYwqoQ9SgmOw9JtHdg==
X-Received: by 2002:a05:6122:551:b0:5a0:370:f12c with SMTP id 71dfb90a1353d-5bd69df49cdmr3132818e0c.11.1782485886183;
        Fri, 26 Jun 2026 07:58:06 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd79083bf2sm1237166e0c.11.2026.06.26.07.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 07:58:05 -0700 (PDT)
Message-ID: <7069f67b-000c-4b23-9278-e52f571ce6ed@gmail.com>
Date: Fri, 26 Jun 2026 10:58:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] commit-reach: move min_generation check into
 paint_queue_get()
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <4b9f192d98b8e8f2d30eed4261a73e766eeafcc2.1782479286.git.gitgitgadget@gmail.com>
 <34ff8be2-1b3c-480f-ae27-9d65875e6e62@gmail.com>
 <CAL71e4PWmVjh5pQATGj1GrwgtWDZOeawKUXbKZ7DZX-DcWuCfw@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4PWmVjh5pQATGj1GrwgtWDZOeawKUXbKZ7DZX-DcWuCfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/2026 10:53 AM, Kristofer Karlsson wrote:
> On Fri, 26 Jun 2026 at 16:42, Derrick Stolee <stolee@gmail.com> wrote:
>>
>>> +  4. Generation cutoff: the dequeued commit's generation is below
>>> +     a caller-supplied `min_generation` threshold.
>>
>> Technically, this was always a termination condition of the walk,
>> but now we are correcting the documentation to match. It was just
>> not part of the termination in the dequeue method until now.
> 
> You're right, I should perhaps fold it into the first patch instead,
> which would be logically more accurate. Would be an easy thing
> to fix for a v4.

And the remaining condition exposed in this diff isn't included,
either:
 
>>>               flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
>>>               if (flags == (PARENT1 | PARENT2)) {
>>>                       if (!(commit->object.flags & RESULT)) {
>>> @@ -219,7 +224,7 @@ static int paint_down_to_common(struct repository *r,
>>>                                * descendant of this one.
>>>                                */
>>>                               if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
>>> -                                 generation < GENERATION_NUMBER_INFINITY)
>>> +                                 state.last_gen < GENERATION_NUMBER_INFINITY)
>>>                                       break;
>>>                       }
>>>                       /* Mark parents of a found merge stale */
>>
>> And here's another termination condition. We are now leaking the
>> abstraction of the 'state.last_gen' which give me some bad feelings.
> 
> Yes, this is one of the minor annoyances I also noticed,
> but it's not too bad. I think a followup could be to either:
> 
> 1. remove this optimization entirely (though I will have to spend
> some time reasoning if there are realistic use cases where this
> would trigger much earlier than side exhaustion.
> 
> 2. tweak the logic to instead halting on exactly this commit,
> instead halt inside paint_queue_get if:
>    generation < INFINITY && !FIND_ALL && num_results >= 1
> This would change the semantics slightly (but for the better?)
> in the the found merge-base could be in the infinite region but
> near the finite region and thus would unlock the optimization
> as soon as we pass that boundary. But I did not want to include
> that change in this series, which is perhaps already getting
> too complex.

I'm happy to keep this one out of the series. Perhaps it would
be good for you to finish this series with the current scope
and then for another contributor (me, probably) to do another
round of cleanup/reaction on top. I only say "another
contributor" because new eyes can help to see new things, outside
of a patch diff.

>> We are getting to the point where I'd leave such a thing for a
>> follow-up, but since you are needing to re-roll, then this is
>> another case where we can move this into the paint_queue_get(). I
>> don't think this is me "raising the bar" from earlier recommendations,
>> because I was asking for all loop termination to be in the get()
>> method, if possible.
>>
>> But also: I'm not looking at the full method right now to see if
>> terminating _at this location in the loop_ is critical. So it may
>> very well be impossible to move this into the get() call, in which
>> case please ignore this suggestion and use state.last_gen.
> 
> I think it's not critical (as I mentioned above) and I think I will
> need to follow up on this later.
Sounds good.
-Stolee

