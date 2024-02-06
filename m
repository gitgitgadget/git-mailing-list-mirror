Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909113172E
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227707; cv=none; b=JryuhsezREZ6aNoquSCgpWEtnri4hTIQ3udnLB4fz3wh3sVablwOWkkfg1UO88egePvq63vmTUfPtXQmJlq2GyYWpeWjJVXp9luL94Qiroi1XzWep5SVY+twJZeNrQhYJjPSf6yTIlo1bfwmXERueQAYqgXklPhlZx+9T/u9XaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227707; c=relaxed/simple;
	bh=3G3nOOPY4d9v5rErAHBGEDYzBQpna/akfDBiZd6ByqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StY2j15r17vNB/tBufQT/+ZR6MDsbim4zqhFFE9DaGl9pO88jL8XUWJ2/hogonNucGLECPytQgQAN4Yz+odrAIvInBA3s+VDg2Q1FTZ9ex4Diqp6J5QYzp8HxnY9dPAYrRlZvxq56Oqpym8V6syEj6hUQEwsYH3Vuk8oQnimVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUqmTcvh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUqmTcvh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a380c98e824so117544966b.2
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 05:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707227704; x=1707832504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dUNhGdftGPCXkKZvmPUbJq6+fdU4P/LHrzb07EEcfcI=;
        b=KUqmTcvhzafo/CmwWEwJ4n4xt88qHLGWrGXli9UKehznBvJnecaqaE77ti/KIbSl3o
         NxiW9MNdZKysZOCXWRwqqG+GtBSUJQoLPowg1/uXKl+emgwjXj80oliw3WIFj9xS78rB
         /SQ7f34q7A8EWehlC8oOtUOkgAMPo1VoQwdeIczE0ob2j/wHIITMBeMaL5wRWHM9YSGt
         n6Rxc0+2LEe0wwz9YLQDJjt0xkRzqHGQJi6zDOjRa1zha40b76/C9yKGDQpKvM2aNkhl
         lFWN3L7RmSPNWvxHyRaZOG3O/MMckqnvb3Fy5w+Pzfclxz8UVGpa1Gu6WgpWwo0JRr3n
         ieIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707227704; x=1707832504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUNhGdftGPCXkKZvmPUbJq6+fdU4P/LHrzb07EEcfcI=;
        b=Kk/M1vttEMILoAnzOg82GXDmJm0HNe60dHvoiEDCenSJhUn51OpjkH84M9ej1NwkhC
         FbSmEu4FZVNrLum5OMCRJyctVISn/f8dktPWXBE+qDC0bI1qaUVGBA2c5UdzcPyz+qqY
         Rlj1ldP7Y2PR1gjT2Umlk/Icfwr3Ff8rkP5N4fMihv6grckeXIj2/HN8NVOzyyecCeeS
         n2j53vxXejlvEzA+1GsPTl9X13T/fCazb3LwcuHPu1asuHKCAtsGAZ416uHOoqVp0vl+
         aWiVjw6y/sPjTvksz/1mGLHleF3aB94cn5ffCHGygq4tMvvMSq35N9cBAPFUdYr/Isg/
         n6Gg==
X-Gm-Message-State: AOJu0YxSMjUfkNC/G3IirSPFmM5YYxBhw9hlr0X4X9li1DCGh9a7Dt65
	ys7GdboilrlERQDSktSUeD/jbDacA6d9L7baO0jPs77XlPeuZoTi
X-Google-Smtp-Source: AGHT+IHEcU7vTq4brIB0CQxWu6AcK8w73ty+j17wF/pe053ho50lFH7qNeGH3c84Z7KGMehOeNq8/Q==
X-Received: by 2002:a17:906:23e9:b0:a31:4e96:f40a with SMTP id j9-20020a17090623e900b00a314e96f40amr1723966ejg.26.1707227703644;
        Tue, 06 Feb 2024 05:55:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVc5B4lF+R1v0jPtMhuyHj8TLf9DBDr0E5gLKOznvUa1WFu5WKrWh39iKtD38sYNPjGeA9jgSM60PW4cs4pnl+/N1hmL7WzlHoJ7rJ3TNPlf2wXyRXSPQ+8LMQhGG8nCSUYpiL63iPJGA==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id gt26-20020a170906f21a00b00a37b795348fsm1154280ejb.127.2024.02.06.05.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:55:03 -0800 (PST)
Message-ID: <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
Date: Tue, 6 Feb 2024 13:55:02 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Content-Language: en-US
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
 <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
 <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Karthik

On 06/02/2024 08:52, Karthik Nayak wrote:
> On Mon, Feb 5, 2024 at 7:48 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 29/01/2024 11:35, Karthik Nayak wrote:
>>> When the user uses an empty string pattern (""), we don't match any refs
>>> in git-for-each-ref(1). This is because in git-for-each-ref(1), we use
>>> path based matching and an empty string doesn't match any path.
>>>
>>> In this commit we change this behavior by making empty string pattern
>>> match all references. This is done by introducing a new flag
>>> `FILTER_REFS_NO_FILTER` in `ref-filter.c`, which uses the newly
>>> introduced `refs_for_each_all_refs()` function to iterate over all the
>>> refs in the repository.
>>
>> It actually iterates over all the refs in the current worktree, not all
>> the refs in the repository. I have to say that I find it extremely
>> unintuitive that "" behaves differently to not giving a pattern. I
>> wonder if we can find a better UI here - perhaps a command line option
>> to include pseudorefs?
>>
> 
> As Patrick mentioned, this was discussed a while ago and we decided to
> move forward with the `git for-each-ref ""` syntax.

Thanks I'd missed that discussion. I see that at the end of that 
discussion Junio was concerned that the proposed "" did not account for 
"refs/worktrees/$worktree/*" [1] - how has that been resolved?

Best Wishes

Phillip


[1] https://lore.kernel.org/git/xmqq1qawr6p4.fsf@gitster.g/

>>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>> ---
>>>    Documentation/git-for-each-ref.txt |  3 ++-
>>>    builtin/for-each-ref.c             | 21 +++++++++++++++++-
>>>    ref-filter.c                       | 13 ++++++++++--
>>>    ref-filter.h                       |  4 +++-
>>>    t/t6302-for-each-ref-filter.sh     | 34 ++++++++++++++++++++++++++++++
>>>    5 files changed, 70 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>>> index be9543f684..b1cb482bf5 100644
>>> --- a/Documentation/git-for-each-ref.txt
>>> +++ b/Documentation/git-for-each-ref.txt
>>> @@ -32,7 +32,8 @@ OPTIONS
>>>        If one or more patterns are given, only refs are shown that
>>>        match against at least one pattern, either using fnmatch(3) or
>>>        literally, in the latter case matching completely or from the
>>> -     beginning up to a slash.
>>> +     beginning up to a slash. If an empty string is provided all refs
>>> +     are printed, including HEAD and pseudorefs.
>>
>> I think it would be helpful to clarify that it is all the refs for the
>> current worktree that are printed, not all the refs in the repository -
>> we still don't have a way to iterate over the per-worktree refs from
>> other worktrees
>>
> 
> I agree, based on if we keep the current commits or remove them, I'll
> send in a new patch or amend the current series.
> 
> Thanks!

