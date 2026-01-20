Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC63F0769
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905095; cv=none; b=MHSbnzNybgcq+Z//Qo3v1oASfi1xv8knqVsdwrKlaMQyrZVHQnazpiPayijHuIcuxSJzYk1c0/JQA6v7TqRPTkamLkt314ZNeL4OFY7atJLWrsSVGhPz3Kg8xzbHsIsK5nhuZWZvN4lxYSOXGzNFS/3cPJu6mRUyjzt2QIW3tzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905095; c=relaxed/simple;
	bh=lCq6bTkJSCZwnpt6NpD45LcmyRgy9MyDezJBuFMjxTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTjHzvwYaTCPoEZQR40JkcEtzqBq9sP+KHetGyDo7710XT96IEIKszXDYkdzYJuju9eCFhmKjBj9uN2ZbLq7YEM/8fY2T5YPcmJrC08BQtfnI24TK7pw0R6Z19GUXwzA9vUWBi4A9+x9FoZFI8rkhvIwmjiEsMXn8PNVujjG0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3ToglMi; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3ToglMi"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-432dc56951eso3504046f8f.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 02:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768905091; x=1769509891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6mEiL2RGS8i6o0qWPjT/DK78AZeZcNhZ/hsk3qPDNS8=;
        b=J3ToglMimADxITJC9eoendq4UqnKAyK2qfBARs43nPCuNByyZrnls1qn1Nr0xdkHHY
         O3RsQ0vOLF1dP4NOQf4eK4vbHnutWQQ8eOxZ51+5WaWxgVire27rkggHKHu5tfJ3Lul3
         63QT3o1U18AUAY/UsQNshvCjhhxS0Llw2Smc3aOW/trVJ3g46H//K4HOGrmzs2oHZhYE
         B4a8YNEqXRokGgb9FKQDsKnnJEA76rFVRV/JDmqVRE2VNtapfjA5LARSDWJ98pZFT0Rk
         a/4FMh9TyBrbDyWxF+S63oQjfCcfUJ1QY18dG2i6KGUrKQF4QS9PJinBAy3KsA6/NGMU
         K4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768905091; x=1769509891;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mEiL2RGS8i6o0qWPjT/DK78AZeZcNhZ/hsk3qPDNS8=;
        b=WZCT7hUnp+2XbzbGXJZpjjoPYJqYVDoyuskyPpKMEDM2SIZOKuD2FMuYImXMljqxNR
         0VxlBLQUVDYwk0gbL82bErRcbRQJdTnpqcPjvhPNFDB0l4WCCUcZ55aeWeIjb/57DqkS
         cOfTOCe1jqxmcPNg3PM7KHCZ1s6VGTxGN8ewTaUQVkV2TE5ab7Y86S8wE4RII9PBQDvP
         jVKXPhZJ2brxJqq6DXy/J1k6TziYVqN74Ubrox759MVj/k4bKZt0w8M+z4Vd2S3wUiXA
         VqDhEM5hthSoWekpRuWDAFPYX9rvVBzAA8UrV14Ek/S+5D1z5oWOx+M0lpUUAlY+TAVw
         tcXA==
X-Forwarded-Encrypted: i=1; AJvYcCUbeKyiscJrvYta5Bt+Khv/b1osRq9m8XCNbteii6Hn0d+DxptkGbJ7dFhtYohHdyp7Og4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgTPq+ZMf/L8hZoK+6LkYBZJ4c5aOsBARtgqRsvEBNfLCO/VG
	OOAm4LwzgZeERYE0ORYkWao+IuD11w/tSXfKElIFODFc18E/jA0aCaTB
X-Gm-Gg: AZuq6aKRJf8L5BBklQm9N8tX7nXUxjBL+tP5L2rpard5pmbC2j4C/7zfnbUQ5oqNGwc
	y1HTvEEBtHiZWuok8uFeZ8ZocbVZSzQZvVn7gFLRCyi1cP5ljIRcjhgSPG4QFbBsnCgrp+kRxU5
	vKwQZwYNt4DMVYo4pDc1BEoqu6eBrDtBORWreYjqOQjETwYwhO5Ix953/MX3pV1z/e8E8XrvHJE
	vIm8DZPfrAL9aW/bqskGYm2CPQDhHImaJ0oe5J9m63aSdfJVG4qZNL6IXK2xl6gkZ8tvpqV0L0h
	c/2EdIqbbeF2UQIFJYN748DwiNuLHraxFmnrL64yI9b/TLnqd9W2VYb6O7MGjn7xhOcYwKedn/8
	6rjNjHElQrGemP7PhKmwbGKaspJ+4vzIJ2S+O77dyU/njo1uYyLVPg56wKClLuZrgLxMQ2Y7Lsc
	WNgsg4F+lgXQM2wAQUBpe7b0XYBKSHnsCs5b90tVqRTm8TLzF98wkNrz7zRccDm3rfxg==
X-Received: by 2002:a05:6000:186f:b0:42b:38b1:e32e with SMTP id ffacd0b85a97d-4358ff6265dmr1960825f8f.46.1768905090898;
        Tue, 20 Jan 2026 02:31:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992c6f2sm27958946f8f.19.2026.01.20.02.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 02:31:30 -0800 (PST)
Message-ID: <b1ea2c89-890d-492d-9bb0-2f0f67599b2c@gmail.com>
Date: Tue, 20 Jan 2026 10:31:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
To: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
 <b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com> <xmqqa4yc5brq.fsf@gitster.g>
 <de592bff-d7ac-41b5-bb24-4ced285a52e0@app.fastmail.com>
 <xmqq5x8z69mq.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5x8z69mq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/01/2026 00:35, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> 
>> On Sat, Jan 17, 2026, at 19:34, Junio C Hamano wrote:
>>>> [snip]
>>> Yup, I generally like this direction, and introducing NO_P4_TESTS
>>> and NO_CVS_TESTS would not be so bad.  Here is how it looks on top
>>> of Dscho's patch.
>>>
>>> --- >8 ---
>>> Subject: [PATCH] ci: skip CVS and P4 tests in leaks job, too
>>>
>>> Looking at the CI logs, the p4 and cvs tests account for another 24
>>> minutes of test time and they offer minimal value for quite a
>>> similar reason as the previous step.
>>>
>>> Let's introduce and use a mechanism to skip these tests to save
>>> some resources.
>>>
>>> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>>
>> Nitpick: Using the commit ident
>>
>>      Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> might be slightly better?
> 
> I didn't even realize there are multiple addresses in play,
> actually.  I just took it from the e-mail header's Cc: field,
> which my MUA copied from From: field of the message I was responding
> to, which was the identity of the person who suggested the change
> after all ;-).

The dunelm address is a forwarding address that should keep working if I 
change my email provider. I keep meaning send a patch with a mailmap 
entry but never get round to actually doing it.

Thanks

Phillip
