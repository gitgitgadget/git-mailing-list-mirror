Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452F456290
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792317608; cv=none; b=YEHXiTLuuFF2mgVyL9DeTSlBFeoagEGlCxjrs5L3Lr+9DWsFma4iCVXZlx+uQC4wP0F/Tjc/JtOI0xe8iabaCE+fgSLa8ea3sB8qfGx6JPj5gFa3l901SsPNuT7Yb9fJxQ/baxdpAccJK2Pgjuc8hRUgKoPYGxgh8NFUoMVLT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792317608; c=relaxed/simple;
	bh=oZX2QzNMXl2gY/MpOKFsWRj9HfeHbVr+znH89CONLfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBUUHp+17ATWy0z9YICZg0dtAYzgQOhmQBZWwNbwUQ64NyW004pWGLHMXTfqbFVehbfNRHXWrM4dYawDu4bJh9mWGRgMIOjLVP2Gmn4zFwh050wq+3vCL5fCPQxN6ROzxO+s6rOiRyT6rXfeOYTu1+IRpIjeQeK3PXp4dYZBfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy4wNlIj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy4wNlIj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so15194945e9.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792317604; x=1792922404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQYri8h2ICF3/oSk3p+FQM7pnXCqGk+poDsoZj5znk0=;
        b=dy4wNlIjZVJQN+8CTPHoW06OcFo3DD+Zt4PkijtUMKaFjTgdzHxQdJ6BDcEQ/o718k
         ADn/72BDZcInWBKP/ccQ55xjUO4HfCUqMpP9hV+lNAt+bEZtRWpXxOYfh9lJzXyS68mf
         eIaldzMLlFyDU+oOuJW74uoJH2nqcmRemF3k4jSnKU3bUcW1dq3HZzHtwchqdtmAHyUJ
         ynjQAP857K0LbC3xF3l0im2Tf9fAG/sSh0z8CQBcDVvEa6yVNKqcTjI++LQ//q+KgVmE
         crL0d99/5rj5UUJlKY2F6ktQ7v4UEmrje9CLWOK9f0aEjCySYPoT9UGksU20ksOVlBuW
         0CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792317604; x=1792922404;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQYri8h2ICF3/oSk3p+FQM7pnXCqGk+poDsoZj5znk0=;
        b=RYFeVfqD00WYTSYvrySxZ53Vdvh3b7CI0diSfPN8GDjm4KCHPhjKAa8vynyQaJ+DNO
         F9ToZm+7a4NNPZQi4eqUA4uFv1T4CZeepxDW7H0e7iJeY9ricLoTGJYVcSTM2PlUv1Gb
         3VTfxIM7qJSYLZ66vA42sjGq3qVZqCApcurKOgf4osMqlyvP1trnXU7Cike3j6QQ9VtM
         uRqk1BzS1MpXOa7bzvqAS3mJO8KfH1pUfU/pgEpsyvOyrz/MVM3xXH7VaBXYVdKE4rDK
         mLx4wkI/u0IIB1sQgAHJ4aIn21uFCtqjaHOCeDbgGdeVv8Uh5PAe5OY+/dDdQ9PCPnaC
         PYFQ==
X-Gm-Message-State: AFq9FYKxOQjGYpbRf5FABg1eQ0UDoOVaum6yIh7pJlGBcwjowT41mUWO
	QUOC2lkUlIq99xGZtnN6cIbc3O1bGABbM049N/cKXzF6cqwqoLdIrGCj
X-Gm-Gg: AYBFou3rZ7nC731c8pzHsbm8KE+GvPuiNFrN8An172bYjSgv/oy1kI0hDmyZY3n2UZo
	iBr/TD4664j0NhOy4fKoPYrO6yoa54TbA805YfMsm88iTl9DKX0KL1NoPqRb/VJq4uMLHoBLZrT
	n7DXAZJJwRhraHWs4N82/O/sYT4tZcX8mQFWVuyRMmCxQ0WgbL0a74PNUQQ8XbYFXW4jAz/2kQ2
	WqNK4aOP1/UvAEF1qDT+2ChZYcmFHDOaoDL3Bzgtl0mHbXz8pDUgPXoh567taQI2qKK9u9y2qme
	jNJv3RfVxS4A0/QE6fX57hHIJaReTL2lJN3sSBPrA1FWkxVy8Iz7Lr5kWbRJ1HygKtFnhive0Ga
	sDYSfyBk6OpPa6DKHCjY/RV+u1+DITkHv3KBdNxJp/SwbErN0LPsBGbwKuZOFzybD2IqBodOOwG
	PZCP4H9qLsY2/oJwSFa5VM6fP3ODypE4GcCid4m35a8xH+WcHIcx/MzKV+6tZvPLNAAyoQvxm3g
	5Kxq2Aye9USD5Q4bpjl7gBjp3tw+hxkcYLedfctc2QUcx8pgqjJFpw0YqY3nC9jcUCpya39iI6Q
	mzHTwszJnAIGtJLqxH1BmlEH8LLQ/O2L+A==
X-Received: by 2002:a05:600c:8b29:b0:4a1:d456:ddc8 with SMTP id 5b1f17b1804b1-4a1d7bc2dc9mr94179565e9.7.1792317603013;
        Sun, 18 Oct 2026 03:00:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cf983b88sm183509385e9.7.2026.10.18.03.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 03:00:02 -0700 (PDT)
Message-ID: <d2264240-1530-48a2-ac3e-ae46f855872f@gmail.com>
Date: Sun, 18 Oct 2026 10:59:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: let inherit track a remote-tracking start point
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
 Josh Steadmon <steadmon@google.com>
References: <pull.2450.git.git.1792134165785.gitgitgadget@gmail.com>
 <xmqqcxt9h9g6.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcxt9h9g6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2026 17:55, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>   `inherit`;; if the starting point has a tracking configuration, it is copied to the new
>> -	branch
>> +	branch. A remote-tracking starting point is tracked directly, as with `true`.
> 
> That is "A remote-tracking branch given as a starting point", not "A
> remote-tracking starting point".  Don't abbreviate and drop "branch".
> 
> If a starting point is not a remote-tracking branch, shouldn't the
> same thing happen, by the way?  IOW, shouldn't the updated text and
> behaviour be more like
> 
> 	`inherit`;; if the starting point has a tracking
> 	configuration, it is copied to the new branch.  Otherwise,
> 	the new branch is set to track the starting point itself.
> 
> I am not sure if it is the users of `inherit` want that forking a
> new branch from something that they know is *not* tracking anything
> suddenly starts to track the starting point (whether it is a
> remote-tracking branch or something else).

For me it depends on what I'm forking from. If I create a branch on my 
desktop, push it to my server and then create a local branch from that 
on my laptop, I normally want the new branch to track something like 
origin/master rather than the starting point. However, if I create a new 
branch from origin/master then I do want to track the starting point. So 
it is not clear to me that the behavior proposed here is better than the 
current behavior, but equally I don't think it is any worse. Having some 
way of saying "set up tracking when the starting point matches one of 
these patterns" might be useful, but I find the tracking options to "git 
switch -c" so confusing I normally just run "git branch 
--set-upstream-to" afterwards to set the upstream I want.

Thanks

Phillip


> Looking at the originating commit d3115660b4 (branch: add flags and
> config to inherit tracking, 2021-12-20), it only talks about what
> they want to do when the starting point does track something, and
> forgets to say what they want when it does not track anything (the
> author CC'ed in case he retains the memory of the motivation from 5
> years ago), but if you ask me _now_, not doing anything, i.e., the
> behaviour the old commit happened to have implemented without
> explanation does sound like the right thing to do.
> 
> What we should do if this change of behaviour turns out to be
> undesirable?
> 
> Perhaps `inherit` should gain a synonym `inherit-or-ignore` for
> those who prefer the current behaviour, and we want two extra
> behaviours, `inherit-or-fail` that complains and dies if the
> specified starting point does not have anything for the new branch
> to inherit, and `inherit-or-direct` that uses the fallback
> definition, or something?

