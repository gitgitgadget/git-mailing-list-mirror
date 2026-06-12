Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948825228C
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279314; cv=none; b=U0GTE+q8LV12hL9pkpLo9UMKZHAtZWXEPUOIqr/EX3m7Fl6lEGYTBNSRLFuVPXYYa93iajI99Ye5dWLDU1wDUsiCRIOu80+agXVa5ose/szQXNsQ3XjRPHAfkVio7T8oWgEVrUBkXw+nEitrn9ig1D6l2O3eyoHj6+8ueGBoHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279314; c=relaxed/simple;
	bh=gqMWOw9nwBiKEuoS/2d+scFmfZmyEev6ipTdB3AoNoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqG6n0Q/2S0CKoysCsw1sV/UyeDaNEHsDpRD/oQtH13xnGC4pbEy3u5s+5MWNpAaIzr9dC+kL0WNhER2lbJvu3id+Q31fSwchqzt5Nvlm+A9LWFDBO15XqDrcmWUFbKQ9DJf0ptbpKAfjqga6VtpglUtoqTJ1FGbY1F9Lu0XgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKp0ftvy; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKp0ftvy"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-915671abde5so127439885a.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781279312; x=1781884112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LLcC+JWYrpeK2q+Je0rj0DQVwWbVehIleU73UG2cT8=;
        b=lKp0ftvyEz5BDqbAsFEg5AWwAahX4+9TTHJ+VOmc81ZL51ZRSn+hqIEoaX4nyTRsgb
         tQHeh2PqBkKm1YOZHKkBikOlD5XriYk9zejbAEOsn+KLRza9gZuShuqTMejJCp7Ap8Zt
         /EsM7vNSA7sPjwmhM6G8WK5mnu2KxncpID4bgKwUDhqAyHIDfzTS7RzB82tETA9CGQAb
         /q4R33yft/KKzY+GD2gYWs6m1CY3V3yQ9lxCVjigVDyXz0/cCVnKODL3XoAlpbVdZWke
         j/NwTNNcGam5HNGq3HS7wwWI5CaS0HtUPLGmLsuC46X14gHQWYL8pSyvvICyUaRq+e2K
         Po4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781279312; x=1781884112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LLcC+JWYrpeK2q+Je0rj0DQVwWbVehIleU73UG2cT8=;
        b=KZkyZ/HofxdE3mKX1rlP8p7SbgKYLL606UZ6hC86opYgFP8lpOYsBeaLLWGIo5Bm3L
         uotO1fRrnK1gfEQ4v6ZRUrI5FHY6Z8QW+Ecd1ELU0Wzh3r6g0XLuY4udec6IFjQbvkW1
         tmhlnzuiUuB+UlZaeg6p+pSUGl6f6jioqHiRAcUttDejHu2prs5IR10Jz/f3g4C3RIEs
         bf/gKX22Cx/QyPCnnrH38IWwlumFVplV6JK2oPiHn6rlDQ6OZJ7Ow3mPiLtUlIUawT9G
         uc9ewkveTG+MTi64yfVXg5JrfaNBObbv/yEJUiB8GPqOGLRGbcxgIqmEl1ekpfPL8FPS
         7NTA==
X-Gm-Message-State: AOJu0Yzl5FIbbiMejw0ibJWdQiKLU6ozhTC/mcWdkwa5ZjyEYDvtY9JZ
	YwqU+GrgEwepEo8tyXhHX49CabHWTqKbg0SAoD7TNxD7cUoWFq+NYwDR
X-Gm-Gg: Acq92OHftwkkpuif2wqPFlG7WNtElXx0WrWPP90pflcwCZIvV0t8bPN0qMkUZe7SNKB
	2cafxEq7bozHQsjkReQYWiX7cOXc36PqMsoT53+3qel+g9k1MFrC5Gfj7DrT3AogLIbGz28IHAZ
	M3hGHMln8johx7TJgq8vExo4xXhgU0PXjD9XY9fKEk7gL+dyrVuMXhlSZPvTX4jSWeVhR05O3xI
	7CL5TG/0oycLgJp8migP9+DBer84CCQE+bM5Ppd4WhSV7eAqMp1GA3Y6IgrQ8vpe2kIyRqU/+Mu
	HnAInalvGqrXh/UAEoLC3wThKAeD/mrpVrUPg/1J3LghX+DNRhpNNZTZ3lkejaMP7FQVBuL+LDd
	x2k/r5/24Ve7/uIoRyCrRhayQFw8SVcL+pevhH+BmE0jo9WUoM1emW5/wkXN4RG21t05+VMEuq4
	561L7qL4I45XIoKuyfFM9NF3GtRzixxIOR0Om5rsw+I91nISS7cvskoqp+pEF2xW4UuiEN
X-Received: by 2002:a05:620a:708e:b0:915:9aa5:b5c6 with SMTP id af79cd13be357-917f15716a2mr22545985a.36.1781279311973;
        Fri, 12 Jun 2026 08:48:31 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a00af50sm259794885a.30.2026.06.12.08.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 08:48:31 -0700 (PDT)
Message-ID: <8c06cc48-d036-4d01-98d3-e94b5edb389c@gmail.com>
Date: Fri, 12 Jun 2026 11:48:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] commit-reach: terminate merge-base walk when one paint side
 is exhausted
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org
References: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
 <0b3f7429-a4fb-4f7a-bf7b-5a0edeb1db52@gmail.com>
 <CAL71e4OmPzpCXh-zZ8NsT6L4zVKnXV1gqiFZ2w0XgMJhD=LArQ@mail.gmail.com>
 <8d0902ca-98b7-44a4-a23b-51de44ab6daa@gmail.com>
 <CAL71e4MFb3UUKBr1P4ZwtK3o1gvUHMs+siCpLTXKkW6Vx=BxRg@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4MFb3UUKBr1P4ZwtK3o1gvUHMs+siCpLTXKkW6Vx=BxRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/2026 11:21 AM, Kristofer Karlsson wrote:
> On Fri, 12 Jun 2026 at 17:04, Derrick Stolee <stolee@gmail.com> wrote:
>>> So the actual halt condition would be:
>>>
>>>     no non-stale P1|P2 candidates in the queue
>>>     AND (no pure-P1 OR no pure-P2)
>>
>> And since STALE is added only after both P1 and P2 bits, the two
>> conditions are identical to how queue_has_nonstale() terminates the
>> loop.
> 
> No, I think this part is different. I can demonstrate with an example queue
> state: [P1, stale, P1, stale, stale]
> With the old code, the non-stale tracker would consider this to be non-stale
> since it still has two P1 commits to process.
> My new approach would instead consider that a valid halt state - we
> can't find any new merge-bases at that point.

Ah. this is indeed the detail I missed. For any i in {1, 2}, if Pi
only appears alongside the STALE bit, then we can stop the walk. This
tracks because the other bit can't contribute any new information.

A data shape that makes this particularly helpful is the "release
branch" data shape that I used to justify the --negotiation-include
option [1].

[1] https://lore.kernel.org/git/62e5ef1a4b800cb18b2e934f45303095d545613b.1779207896.git.gitgitgadget@gmail.com/

Suppose developers are merging into 'main' frequently. On occasion,
the tip of 'main' is merged into a new 'release' branch. Thus, the
first-parent history of 'release' is long and completely separate
from the commit history of 'main'. To reach the queue_has_nonstale()
exit condition, we'd need to walk the entire history.

However, if we focus on the single-side condition you are proposing,
we can stop walking once everything in the queue that is reachable
form 'main' is also reachable from that top merge-base.
>>> If this reasoning is correct, then the walk only terminates after
>>> merge-base candidates have either been processed or marked STALE,
>>> and the counterexample should produce [B] rather than [B, C].
>> That's the correct distinction: we need the set [B] and not [B,C]
>> but we need to discover that B can reach C to remove it from the
>> result set.
> 
> Yes, and I think that part works since we visit them in generational order,
> so B can invalidate C before C is reached.
> 
>> I think there is potential merit in "switching walk modes" to DFS
>> when all queued commits have both P1 and P2, but it comes with a
>> lot of complications. So tread carefully if you go down this road.
>>
> 
> On the DFS point: I may be misunderstanding the suggestion, but my current
> approach depends quite heavily on generation ordering. The reason the
> STALE propagation is safe is that, in the finite-generation region,
> descendants are processed before ancestors. If we switch to DFS, I think we
> would lose that ordering property unless the DFS is constrained in some
> additional way.
My thought was focused on the case of "all queued commits have P1 and P2"
and then we could determine which should be non-stale using DFS focused
only on the current queued set.

But I think your single-sided approach is a better way to get the gains
that you want. I think that case is much more likely to occur.

Thanks for your persistence in working on this through my
misunderstanding.

Thanks,
-Stolee

