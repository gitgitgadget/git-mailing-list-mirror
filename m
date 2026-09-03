Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB794B147A
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443456; cv=none; b=jiuyWtASY7ZbK2g4HtWgk/M9FCgq/vsuv3IAOJ7XNRTMBcMpoSe/pAq8IM30ko9CQ7C18ivZwnsO5lMiLuYhlpfwABHyAbTYgPGMmC1KpuQn9wJ1jQ63xFfyRWMgTACPv+huxPEarYBfRvi366+bT9MD0yVqTPs8E1ajnHdtiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443456; c=relaxed/simple;
	bh=QhVZAxNbea6shRSMLLVRV5l/McanDgltXPUG9v6OhOM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ofeNstW3m3AT0PERx08UoY8spqtuNZUfX/9nz7oiim3Dp3Shul8wIUnoltfmujpw2RaSS79+Ab3cniA83PJf48PIZp4IJNBM6GfEt5351c1cPjAQf68qGkkMoDj/0e0UsNnHyWFUH2kuVWpcqHXv4ftPaypxEZbhZlgkfvfO00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpQ6FZd7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpQ6FZd7"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-485852d03a4so340621f8f.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788443441; x=1789048241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DV+AMu5biXiRi5TKZ0loBHe6Ze1TZWkhoCPY/csvI9g=;
        b=GpQ6FZd7eHuieLH5g5rFYmKsRtGZJ3LPnk7pMfCpueROiigcXcx4ko7Sj/kgdi5Te4
         2+GT+dgTIzW2YIWW9whlvEK98N40PHwfG7uao56Hyfr+/hAfbtdnziTHcG6nf57/4f1t
         CMDIK6r8qyjT0ODi0Y11dfkH83Aa47qItbCexjy+NsusB5+Z+2dMEXjdvgwgimq17Pvo
         D+yb1s0TZuBadERut5oKG0LusWEcVh72fObfL7jb5T5CwiHmJYGmSV1DRinPR3DfydeE
         AVbO9+fbXv2jaPMQDNpnm5ZGKmmSHEH5331saIJvYNek0XKckLgEbVRaczvmAkHwib66
         gaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443441; x=1789048241;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DV+AMu5biXiRi5TKZ0loBHe6Ze1TZWkhoCPY/csvI9g=;
        b=eIHILeh0xY20bByIxb9e4FBhKqr/lehLb8BlFv7TJppmJI6Yl037r639CgXbt71jD8
         dbawLCFL6j0lPgk8QD+akRGfv/FN361r66UAR0AmjRXGWmzcKcFoNqvC7aEjeDitTzXE
         pfgBLIPqHDWHd1EA69uLXhit5YwZPpPGAWmTyZbZqcy0KoKBP/6vDSt27lTfrL2IPctf
         6r+UDLIeZW1W+uaW7sLQncXhF3Xc/WT93ER0WLxLMcdnE58INTeXUYtQt4JXQQYLJ4Hd
         feG8L38TFpa7xi1GFLgejjEEG6we5QO/63yq7GGXhzXjYd1rq2HolG2ude//HlprAQwT
         jmlQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/BRvVm3251oM14sKUYWETH6/tZPGzd6bzY/RsiZzqvWG7AVEUI740hEl2k7UuWjnAZiI=@vger.kernel.org
X-Gm-Message-State: AFuF++lO/8rvHpmHRi6jyzur3CTyElxmLkxKer6XCeBq0R6cjepV5uO3
	i7oA8/KJk5HEiZBeopueUJpdlN5UM9fcXS//MAtLa5CmiSAirj59ogvNlabalA==
X-Gm-Gg: AYBFou2wLadCcHvH8feAYqfPA4Tf0JrTiveLPJxohi3XfZLL+6eVF115dEcekQxxABx
	jVh0l9u8d3+vonzCrGTgh7K/FA4Bx/mjYTSii7ios82kS0ZLrK7N7DOSuyvIA1GG0wWQZLkVzR1
	DhNcWwyYyUNZQq2C8OzGKPT4dzMvssGILHsthfsyms47gFp6DgU9KHT5+BjNPFA34JgtnBuT1cI
	5EFkeSG5aqLVofbOKZ+fgziJQY9gchaz+NwugylXvdaVdKO7O5lq2MO+uRzHUugVIsfZOoEPr4+
	gquWQB5lvk5UA4UMvgT9YVC1LqtZfPdK5bpV0+i1UPMsUT969MFx0m5rl1HxV+TU/mz3PtK1/+G
	5a1Ky6WG7UL1WZugdxIlofLi6grYIUGNoyPCSYZUa1RuutGTYvHxTCzG/RbHPD392hrE0LlZ4T3
	1PkkYPP1PXZOLTKrMailxnbisxV4oZ7RGuuoo+fxroklgWpUPHp6WcBim4stBsnjHICscXz3N18
	atYr329RXS9KXMKcDqLI/boHFloa9IXaXW4Ag6wtFI=
X-Received: by 2002:a5d:59c7:0:b0:484:4880:449d with SMTP id ffacd0b85a97d-48586028d0fmr976156f8f.3.1788443440628;
        Thu, 03 Sep 2026 06:50:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7315bsm14224102f8f.7.2026.09.03.06.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 06:50:39 -0700 (PDT)
Message-ID: <ca3b91b6-254c-4b86-adb8-da3217e9f6e7@gmail.com>
Date: Thu, 3 Sep 2026 14:50:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rerere: keep a background gc from killing a rebase
To: Patrick Steinhardt <ps@pks.im>, Thomas Bachem <mail@thomasbachem.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <apkkVAYOqjfAsp9-@pks.im>
 <CAA0xjtp+Og_k7BYZfwX-LRW_8TAiCyp846+Mhk+hERM_GmRYkA@mail.gmail.com>
 <apkwpKTGaMwTf0Hz@pks.im>
Content-Language: en-US
In-Reply-To: <apkwpKTGaMwTf0Hz@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick and Thomas

On 03/09/2026 09:32, Patrick Steinhardt wrote:
> On Thu, Sep 03, 2026 at 10:11:05AM +0200, Thomas Bachem wrote:
>> Hi Patrick,
>>
>> On Thu, Sep 03, 2026 at 09:40:04AM +0200, Patrick Steinhardt wrote:
>>> I think this hints that we should tweak the default value of
>>> "maintenance.rerere-gc.auto". The way it's currently written we indeed
>>> are quite aggressive with spawning `git rerere gc`, and I agree that we
>>> should tweak it. And in the best case we'd not only respect whether we
>>> have a specific number of entries, but we should also respect whether
>>> those would be garbage collected in the first place.
>>>
>>> I'll send a patch series later today to do this.
>>
>> Thanks. Checking whether anything would actually be pruned sounds
>> right to me. It takes the frequency away, not the race, so I'd still
>> do the sequencer part Phillip asked for.
> 
> Yes. Ideally, I'd think that we should both introduce the grace period
> for locking the file and adapting the heuristic used by the maintenance
> strategy. 

I agree

> Whether we should completely disable auto-maintenance when in
> the sequencer... I dunno. In any case, that feels like another separate
> topic that should probably be discussed in its own series.

We've seen other bugs reported related to auto-maintenance triggered 
during a rebase such as the one dscho fixed recently. While I can see 
repacking might be helpful during a very large rebase, I do not think 
garbage collection is useful - all the objects and rerere entries that 
are created during the rebase are going to be too fresh to be collected. 
So I think it would be a good idea to disable auto maintenance in a 
rebase and see if anyone complains. If it turns out to be a problem we 
can figure out how to make it repack incrementally.

>>> Having a locking timeout is sensible anyway, I think. It does not only
>>> solve races with a concurrent maintenance run, but also with concurrent
>>> writers.
>>
>> Phillip found the wait unfortunate and I offered to drop it. You would
>> keep it. I think the two fit together: wait up to rerere.lockTimeout,
>> then warn and return -1 instead of dying, so the caller goes on
>> without rerere this once. The gc passes 0 and does not wait. That
>> takes the die out, which is what broke the rebase. The wait stays,
>> bounded to a second, but skipping rerere is not free either: it can
>> mean resolving a conflict again that rerere had already recorded, and
>> a second is cheap next to that. With the sequencer no longer spawning
>> the gc and your heuristic change, it should rarely come to either.
>> Phillip, would that work for you?
> 
> I think that having the wait is a sensible thing to do, as the race was
> a preexisting one that was only uncovered by the change to the default
> maintenance strategy. It can also happen with two concurrent processes
> that both happen to write rerere entries. You wouldn't normally see the
> wait anyway, so in the happy path nobody will really care. And in the
> cases where you would see it the user is probably more happy to wait a
> bit than having Git die (or just not write a rerere entry at all).

I don't object to the timeout as part of the solution. My objection was 
based on it being the only solution as it is inconvenient to the user if 
they have to wait for background maintenance jobs and it does not stop 
the rebase from failing if the timeout is too short.

Thanks

Phillip
