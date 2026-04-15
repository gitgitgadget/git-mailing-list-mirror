Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCDD30F548
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277742; cv=none; b=KKEgds419dYMKKAB4EXoiuAIH00W+BjZ5YEF3DgJf4938PHseA0xydVPWRD35kzSMOyRMXZMz5Vu8u86i5nxBevAzDaky9mdMg+4Vh+2xGiwBiO6FNBf4/xW6KIaPJAXBZ4fHZaUmvjx8uowm99xcSai9cE+DyMQLzk9+b54D2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277742; c=relaxed/simple;
	bh=7j8dceyv4Ns9afiZ3n/Qaefigg5gfsB5gLFwgxL1Keg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAFGWOxJTkim4wdbHo/MKcTOJzNo+yoQhpKhHao2ig597ngnpbUXD0YxWwuHwqV6AEaBXs99tFBBcyVuK2FWCyzFAhbpfFQcAfVBq8ZSGQQwXCBejIYZXIujfMifvaArOOlvqLbd3kbUOEdpYb+LaZ7zBXIpUjjslEGTsxqIQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOwVZMZ8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOwVZMZ8"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a58057d7baso76511696d6.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776277740; x=1776882540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEChdsP95nWVyj0b8cX8xyxTzA2UlktAXKxcrUerRBE=;
        b=MOwVZMZ8kJcD9YP+IU0Veg/Jb0t+LxkR5xM7VWpI1ibv60nlStaADrFvKeUdOu74qZ
         NLn7n8yjfvjdvWgyMLfK3ZCimg2U4oTabKzoW5iniGYXuiUSZlDMgNH9xNBJTH/pGUxG
         8RbSvUo9wFjpgDGc1lneVRihRyl4Nwp1Fn6/4Q7V4riZMy87blXbYP2Tr4IM7ma11Q0Y
         R7vBHW9ZFqnmTRd9EgHDV8G3EYCwa5/MKDOctvpiPgBlHZVGABOEi4+d7r0Yq6MKNIW+
         PSVt4hmnkSar5vxAiBtmCwWlWB47Yi1Fg8q8wpntlkuyXgfiewDjrLAVXOSShAUCBxdQ
         m8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776277740; x=1776882540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEChdsP95nWVyj0b8cX8xyxTzA2UlktAXKxcrUerRBE=;
        b=sKd4iwwoi7mIC+jp0OHl7CH6oia0osE5f6oudlOjhWlm/1qAiOCtBR6zDdTb24pbsu
         umEYAa3XyEJe7qIMQF5KAqHbVFjCTaHpC7cg5DX/j+4nB8BGJdgagBH6gW+XAT7S9n14
         FhvzrJbC3DSISxqDXCg9bg5nNcgQvtZKpu+ipoQZk1G8Og2vw4IMunuqct0HKu3ebZGu
         EbjFpY9UHM8jTU7vw5DzWO2UCd+n8v5NsruPO8bDaishhVvcEP8LSNxzpy35IY9SAZWK
         mWCdoM+WmFyz0Eg4w+9mz/XLhoOsDjh9wsZlN38MuetC7i4NH+sY6efPfwgldSEsFTNH
         nblw==
X-Forwarded-Encrypted: i=1; AFNElJ+rf0/2s2Ck0CCLpGz6S5v6nrEWp3YZVvOhI/sBtN85mg8yc1sJnP6YL3QyCwq1AFbGa1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsXGteo/G52Gr0XyX+pn+AalABYFlw+hjuJD50r7YduIzNjTt
	QqA2zY2eO7bcCuVu3CHBebRpL9ENsagcQ31esySKVFHfffGBQ/OTVnty
X-Gm-Gg: AeBDieupbne2f1gtLniC8c0ck5FD69STA2vng6R+7eFGsXc6STyHmuaCkH5aSjREoJV
	+a5YZDECkrDa782/AEEtUmuKMypjYnP3FkLZBLdm6bPO/liVk6V3l3owuxpO54Ig6U1w06HVPtB
	OGwLw91UgJPTQ7CX/8/mcFL2U4ZnHSXTNK6HbffUCogwUTOVoHnaX84h+irj3OV+8Et76/B3NIB
	uzsNxLwWevH2m3DU10N1Oi0pvrVrpDg6EPUqeM0AS8f3zr7IaLXW2BughAM0cjiFdB6JJK5Bozi
	EWCIlXISLNWCNTXL6KIYF4yAyXpeRhDwqLofjJdtg19edaaAGjCafhc5eR2pz/DddcVXLupcKzT
	s1XxUIpeuo1jj67Rh7VdNwBNPKYFNQCMip2IpzTYqkmujBoFVTe4cGyjPdCQB8SHjn0XfldEkqf
	F349N9MubnK4EYCi5Sgk6a/lAYZw/sQ7bOR3KEfSCEKeV07Lx5xJcvu7S4ksW5nE79XigPHQ==
X-Received: by 2002:ad4:5f8e:0:b0:8ae:61bb:95e3 with SMTP id 6a1803df08f44-8ae61bb9793mr110289716d6.36.1776277740420;
        Wed, 15 Apr 2026 11:29:00 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c7a03b7sm23787966d6.0.2026.04.15.11.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 11:28:59 -0700 (PDT)
Message-ID: <1988d824-0ff4-41a4-bc10-1b4e030878ef@gmail.com>
Date: Wed, 15 Apr 2026 14:28:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2] backfill: add --[no-]progress option
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
References: <20260412193659.26288-1-viking4@gmail.com>
 <d2cf741c-a381-42a6-9d26-e38481696adb@gmail.com>
 <wsbnw3am5fq6hpjwmmbguo2c3mnv4qkr3hh7apawch7smns6zx@rxegeuugbnhg>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <wsbnw3am5fq6hpjwmmbguo2c3mnv4qkr3hh7apawch7smns6zx@rxegeuugbnhg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/2026 3:02 PM, Trieu Huynh wrote:
> On Sun, Apr 12, 2026 at 03:46:17PM -0400, Derrick Stolee wrote:
>> On 4/12/26 3:36 PM, Trieu Huynh wrote:
>>> From: Trieu Huynh <vikingtc4@gmail.com>
>>>
>>> 'git backfill' does not show an overall progress bar across
>>> batches, giving no cross-batch feedback during potentially
>>> long-running operations on large repositories.  By contrast,
>>> 'git fetch', 'git gc', and 'git index-pack' all support
>>> --[no-]progress.
>>>
>>> Add a --[no-]progress option that tracks the total number of
>>> missing blobs downloaded across all batches, defaulting to
>>> showing progress when stderr is a terminal (matching the
>>> behaviour of 'git fetch').
>>>
>>> Add tests to verify that:
>>>   - progress is shown by default on a TTY
>>>   - --progress forces output regardless of TTY
>>>   - --no-progress suppresses output
>>
>> I think the tests do show an improvement, but we're missing
>> the interaction with the underlying fetch's progress
>> indicators. I don't see any mention of how your backfill
>> progress indicators will work with or against the fetch's
>> progress from the remote and index-pack steps.
> Actually, I was missing adding it in the changelog, see below:
> As-is:
> remote: Enumerating objects: 7391, done.
> remote: Counting objects: 100% (293/293), done.
> remote: Compressing objects: 100% (162/162), done.
> remote: Total 7391 (delta 249), reused 131 (delta 131), pack-reused 7098 (from 1)
> Receiving objects: 100% (7391/7391), 4.09 MiB | 10.20 MiB/s, done.
> Resolving deltas: 100% (5617/5617), done.
> 
> To-be:
> remote: Enumerating objects: 7391, done.
> remote: Counting objects: 100% (293/293), done.
> remote: Compressing objects: 100% (162/162), done.
> remote: Total 7391 (delta 249), reused 131 (delta 131), pack-reused 7098 (from 1)
> Receiving objects: 100% (7391/7391), 4.09 MiB | 6.46 MiB/s, done.
> Resolving deltas: 100% (5618/5618), done.
> Downloading missing blobs: 157594, done.

These examples are nice, but only for one batch of objects.
You'll need to test with a smaller batch size or a larger
repo to get the output I'm looking for.

>> The complexity at the end is about what happens when the
>> user provides both --verbose and --progress, which is the
>> situation that this patch is currently in. How do the
>> progress indicators mingle with the verbose fetch output?
> IIUC, the fetch output for each batch completes before the progress
> bar updates, so they do not actually interleave. The
> "Downloading missing blobs" counter updates in place via carriage return
> during the run, display until it's done partially, and only prints the
> final "done." line at the end, for example:
> 
>   remote: Enumerating objects: 50106, done.
>   remote: Counting objects: 100% (780/780), done.
>   ...
>   Receiving objects: 100% (50106/50106), done.
>   remote: Enumerating objects: 50096, done.
>   ...
>   Receiving objects: 100% (50096/50096), done.
>   Downloading missing blobs: 157594, done.
> 
> So --verbose and --progress together produce readable output without
> any special handling needed.
> Does that direction sound reasonable to you?

I think I'd like to see the full output for multiple batches,
and then I can decide if the progress indicators make sense
together or if they look confusing.

Thanks,
-Stolee

