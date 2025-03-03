Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59733F6
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027617; cv=none; b=b9ngY4IHoWpNfkoaZmtMHvqh1n4uIFsGjFM0gp0OXI6pWiWMUPmayMEmkMdX881sdPoXu1+v1iVBI3j+xjHn+VfIrr1ek97htywnNAvLIhY3NtRz2u5Yj78vpitPcFlvSoew0iqwD/ZGWCVwW7pnv9SSM2yYLE9bBCjrwS9wL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027617; c=relaxed/simple;
	bh=FLWfRGDlxKTnht06vK4WsSj+uRpJcAAeYrApnjYKXKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKDqnoMRsN/Qfj6cNgX3pRaYBcRpW+cBWPnaglqxpHhfF/N9jU8+ivQYhI+UQBv7xo2MrPUj3xyTnEJKQXsa8JTDNcGlFL7KuxjYBdDCcHR0iq4wx12xfrLER4mQ3vwTXhCnHPcSVNX668sW43d19epa4zuBloP1Qgwzc4yHokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZ5TkYM6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ5TkYM6"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fcf90d09c6so39712227b3.0
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 10:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741027615; x=1741632415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujEEUceolzUw2rxJ8ul9o3aiR6fiWjVx4lkK/iV/jO8=;
        b=nZ5TkYM6bygJmwA6+7+YEwYhGQlLiQb5cGke4cVm0DdCbcBckyIpABASVnu6j5J6V7
         /h5yNyq/ScFoUMZ27l9IT/6XzJRhlBfoz52kqbhFSoPMbk81zyhzHIqfr8frzSaGlCfB
         g3n1MFavzd6uDFXPa2sVyNcR25c9sZ9FnOxVwGJeot9KT2tXDwiqK3g47y8iQUCdukj0
         fPv/PLV7vDUn2wlVyp0mHIvsbbY/G0SG9gNSbEK6W6LuNwcxmv9+orMLDF/SkD0SJqjp
         KYuoU6ykcLxDdtxoN2qbupuozkEX/f43BHWZn+ED6C9wd9y6HeeVSiTfln81IzCd3KG4
         lq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027615; x=1741632415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujEEUceolzUw2rxJ8ul9o3aiR6fiWjVx4lkK/iV/jO8=;
        b=jLunlvz+cJDvDYKt/CTgt8dta/x8lgv8Esv68Z2rCIFXYszYegB7NjSPG4cNT/KnRy
         8TsvSkI4kwWCCgcok0NS0ZBjQOyXKiMFPd1QdPxuTkIdElqGFCw+KVzN/wV4yymAI9xM
         jx7VxSI+x6JYgLXYo7w78Q7hOfzbgtiUfAsBEBGPNr96G7Z64ir493Crvz4dZip5oFDd
         5WepLsPRMP5c14fKgkOwhYP4fJWmfHbBGR5wyDAMS1g+RGgKp5kT0B+9GC5AQfWWjFvl
         HNyjeK3r7y5bNCedM3t/v1tLSyUE6UF17wOEUzGC50+Ck6mTdaHcFpEQ75MvXL/Jz7dR
         rV4A==
X-Forwarded-Encrypted: i=1; AJvYcCUhH3z0Mwa0SWQgez2LRypz9hG9mI9PwjthcWsHFz0qzeo0YgYHdMMU5oiO42ca+K/eaY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89An4ppGYWdaoe0t0hAxcDFU+B7uxIL08Yqb/xiJWbtz0YggS
	ZbdvPsE6IO03QlAVYLJWKivqzm2TdJr0Beb590Q3CBzuBoEbjr71
X-Gm-Gg: ASbGncscczbsFBIMEtJy/dmYS6N0InP1XjUHgLGajYj6oQIGqACErpJTorvzoSuCsvq
	2IBlCU61vxWHUoB1Vo0XDOgqhQ/dYiBPX6dzUChnfbKgGxlAaVDOg0hRxmSZ7RSTQxcR8Va2iUv
	27UU2lON6JcwncaLQ7K93Es+3aQgUCW8Dn327ljFXy5/uz4dQUYssvOj2O/LZyWN9DVDliRalQq
	y470zBV6zUCNOjQUJHWNHv7dOHPrPLDcIplVcdq8e6MWOt2m+2mYu2s5Wr+R0hexveqSRxUtvjo
	4kXK5mFK8e5neoGqBw9YEYBtVqbUfBIsCW6Ph4LbpxN9YeKTiaRU7qmliIEL2TNrGvv2rIPO/GX
	EpnFPlCtqcm9TLpht6OhnnP8nvVkpfh+Q
X-Google-Smtp-Source: AGHT+IHsFe/KebiERCOADT9RttC6wSl2zSz3wc+z7GszKVLLeqerztiG1lh8Xj1/VguEscRUgmgz4g==
X-Received: by 2002:a05:690c:380c:b0:6e2:fcb5:52fa with SMTP id 00721157ae682-6fd94179423mr4986417b3.9.1741027614722;
        Mon, 03 Mar 2025 10:46:54 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2827:b04f:966b:a6d1? ([2600:1700:60ba:9810:2827:b04f:966b:a6d1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca6a886sm21192187b3.64.2025.03.03.10.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:46:54 -0800 (PST)
Message-ID: <1d946797-e4d9-4c53-a728-ef80657e1431@gmail.com>
Date: Mon, 3 Mar 2025 13:46:52 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bundle-uri: copy all bundle references ino the
 refs/bundle space
To: Junio C Hamano <gitster@pobox.com>, Scott Chacon <schacon@gmail.com>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, vdye@github.com
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
 <xmqqv7sxki36.fsf@gitster.g> <3a180cca-0573-474a-8835-8015dbe09541@gmail.com>
 <CAP2yMa+YoxRaf48mS7mUbNnsfCm2Z=FT5Gohq_oWz0Q8XnH_eQ@mail.gmail.com>
 <xmqqfrjuvy18.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqfrjuvy18.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 12:12 PM, Junio C Hamano wrote:
> Scott Chacon <schacon@gmail.com> writes:
> 
>> Hey,
>>
>> On Wed, Feb 26, 2025 at 12:36 AM Derrick Stolee <stolee@gmail.com> wrote:
>>>
>>> The intention of the design is to avoid having the bundle URI fetch
>>> changing tag refs, especially annotated tags. Those tag updates are
>>> expected to be advertised in the "git fetch" output. It would probably
>>> be best to peel the tag refs to a commit and then create a fake branch
>>> for the bundle.
> 
> I am not sure where that need to avoid including tags comes from.
> 
>>> The biggest question I had (and tried to get ahead of on the PR) is
>>> the use of a test to demonstrate what kind of bundle files cause this
>>> issue. It would be important to demosntrate that the repo is still
>>> usable if "refs/bundles/tags/v1.0" exists and points to a tag object.
>>
>> I have written a test and I'll submit the new series in a minute, but
>> I'm not sure what you mean by 'usable' in this context. Is there a
>> situation where Git gets mad if there are annotated tags that aren't
>> under refs/tags?
> 
> I do not know of any at least for a local consumption of these tags.

These ideas about avoiding annotated tags outside of refs/tags/ is
likely an invention of my own, and must not be a firm expectation of
the Git tool.

>> I have done these test clones and nothing bad seems to happen having
>> them in refs/bundle/tags/v1.0 that I notice, but I don't know how to
>> write a test that specifically verifies that.
> 
> Can it be some brittleness Derrick is worried about auto-following
> of tags during future "git fetch"?  You store a tag that a regular
> fetch may want to store at refs/tags/v1.0 in refs/bundles/tags/v1.0
> taken from the bundle, and then a later fetch may advance the
> history based on you extracted from the bundle---without having to
> run an explicit "git fetch --tags" or "git fetch origin v1.0", would
> we ever obtain "refs/tags/v1.0" with only the usual auto-following
> when we have the same tag elsewhere?
> 
> In any case, instead of me speculating, I'd prefer to hear from
> Derrick, who is a lot more familiar with the mechanism under
> discussion, what the issues are that we want to limit ourselves to
> local branches.
My thinking here is similar to the prefetch maintenance task: we want
users who run "git fetch [origin]" to see the refs that are being
updated by that action in the normal foreground messages. This includes
new tag messages, such as in my local copy of the Git repository:

$ git fetch origin
remote: Enumerating objects: 186, done.
remote: Counting objects: 100% (168/168), done.
remote: Compressing objects: 100% (51/51), done.
remote: Total 186 (delta 120), reused 162 (delta 117), pack-reused 18 (from 2)
Receiving objects: 100% (186/186), 118.04 KiB | 10.73 MiB/s, done.
Resolving deltas: 100% (122/122), completed with 24 local objects.
 From github.com:git/git
    b838bf19389..db91954e186  master      -> origin/master
    2feabab25ac..627208d89de  next        -> origin/next
  + 9b2be6f7989...39dfbbf0521 seen        -> origin/seen  (forced update)
    5fa232d8520..fb8899337a8  todo        -> origin/todo
  * [new tag]                 v2.49.0-rc0 -> v2.49.0-rc0

As long as these messages are still appearing, then I'm fine with
these annotated tags being added to the object database earlier by
the bundle URI mechanism.

Scott: You also asked about the intended design for bundle URIs and
things, and the best places to look are Git's technical docs [1] and
the bundle server reference implementation docs [2]. CC Victoria who
implemented the reference implementation and wrote those docs.

[1] https://github.com/git/git/blob/master/Documentation/technical/bundle-uri.adoc

[2] 
https://github.com/git-ecosystem/git-bundle-server/blob/main/docs/technical/architecture.md

Thanks,
-Stolee
