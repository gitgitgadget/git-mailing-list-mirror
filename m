Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D090218585
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753732374; cv=none; b=BOCrwchAbUjT4tg/t2vRYvgQdo1eV6/X1NxdNFteVNp7q3D2XQ00zNAuhRt1emqHbiDQuIo2B4K3o+5vJI3yuvga5h0WooR4RE5xhcRGd8zRh9JFV0Zg8CsYiZwhX0I6v4AxBgoFkgQbuSPMbO2+oeKw+huy0FwpUzyAiR+MXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753732374; c=relaxed/simple;
	bh=PN9Ho6ek/vCm7W2cNjFvTuyt6jiXAEe3I/P4+BgocTc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TOZIBiny3G7d1SvOFN6AR9qG9SO81ssY6A0StLxeKXUHuDRY3q/dyep83dsYUbdgdHiKqAYGBBIyziNBT3dL96hWnR6w8GlCWYIFZIMpnBxMUrtnhmsAY67YYK5VFGtPkD8kd8mr2PxrnZ+2ri6KbcYGOPuYa9o6hDO8wBYVx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNx82293; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNx82293"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so1421537f8f.3
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753732371; x=1754337171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsnanya5fYN2lRnRtihLPbt4asQUYHm/WKnwnE+JRpM=;
        b=kNx822933n+C5VBsYDY6IXs3t3LNcAhH5pfbs/2DCCsEqKdh7NpCIOwhzgc66DVJqd
         EdvwDO3I/MsPz9MtJMW7LDeMrlhYg5yo2eN6RxJDNGfOWrlf5Iy+dYZINAcx1ywpTrB8
         Lp40eGC/ykZKJHDNy8ozrvDlyOXUbi9pcxV4syiEgycdBvsFFwTykgrV2GmmSyh52TcF
         a8/xu6wI+VY70xkQL7uRCTeksufMEQONDh1k7INm1r5wBzdwQw4ZeGyNZy1U38j2zdbm
         xBo6I3SHNtBpSbW4uHVkO+0FBYPQ7hWpRBYPzSJqK7kZzqg82fqJp7x6ACMY7Ea8o1dB
         KqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753732371; x=1754337171;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsnanya5fYN2lRnRtihLPbt4asQUYHm/WKnwnE+JRpM=;
        b=gNf7gL7KsH0y8oKbaWH5GrkVd9Vn+beRAhVJ7LZyeI1XyPTojKMxhpiJK9XU9oc7DK
         hEHGnoEz7JavJwqfo8WABCw1vAFywKqtCqLD5QHv8IfdwLKu/Kk/ya1pji4KyxA39Pjm
         +7+BvAYiwljK7WUNfvwjp3Vc3vWsCcZoK6Tm3FmLwIGCjAmAviz0swHdKV9WrfbwPTcS
         oskq9fvdRNjCViIx4jbGVZv7HGTPUJCUWn0fBj3VlFDWYuxtR8cFzotyTRI3yBA1wHE/
         yGse6Xu7m+CSu9YrSKlXbMOgZUg9oxuts1KCakk2HfBS3XoZnBvmlz/EXPfxovRl/gh4
         M2aw==
X-Forwarded-Encrypted: i=1; AJvYcCX0bRyrY74LHaSXUQZc+e9dx1Rbeq4odOkCNPQodE9sGlSdSMydTAu+ygWV5ReHKFhKaVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+85EYmVJdcVyXi/Xa+gnf8p782oKbPRTVQRArUsN045XSzIA
	hOTvolwaRsUahKfRcp6IYfnjrhJQ8KN4cRktcEYxHGz7XN5E0Fivn5Fa
X-Gm-Gg: ASbGnctj8AOLcMZ0qJDva+T7db4PJc18nlyxhtF6zcXpT/JR88gccJBuNU1lEQ1k1X5
	mUNJeZTgt1RLKte8Od7GaO9J5ZRtNXna1k40ewVN3S3661FfSLcqItTWjhnIJA7GcrzGMLJieMn
	ekq3weYTEUgclDEMFUASu9FSF6N4W2GgU2cTSgEXTdCpWRP2cVhJxWMRlfYrJZyKSOHLpdKIKNw
	BwcaLwKlOtKhvDBPqmRt88DuiKX0CTCeu5cgBaDqpRNqo/JnJFnULbGgtgaaEWeJPnhOtSAi7JH
	OZCTRWWkGgD1p3LjvmiCZ0zRnEY4cR0MLRE7iJO3MEEYnBoSIKmG4XaBxbHN2X0xxHXOj+YFb+y
	29Xdg4n1TwEWUCkqg4OHxo8oua1hHJdft3lH1PnV2qITc1lGztZ8WTM80+4ssxZ85QTxD1FEnDa
	2E
X-Google-Smtp-Source: AGHT+IH3AcFyYHkM7Pw6QlvUDK8RrSzSyScUwqVPQk8DndKbJVB6S/zc0+ND+AmEooh4SSqB0G4xeQ==
X-Received: by 2002:a05:6000:2585:b0:3b6:1a5a:a64f with SMTP id ffacd0b85a97d-3b7765ede34mr10420083f8f.17.1753732371335;
        Mon, 28 Jul 2025 12:52:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b78cf1f571sm1278687f8f.22.2025.07.28.12.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 12:52:50 -0700 (PDT)
Message-ID: <a765cde9-0fad-414a-996f-2ec162d1e4f3@gmail.com>
Date: Mon, 28 Jul 2025 20:52:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com>
 <CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/07/2025 20:34, Ezekiel Newren wrote:
> On Fri, Jul 18, 2025 at 7:35 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
>>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>>
>>> A few commits ago, we added definitions for Rust primitive types,
>>> to facilitate interoperability between C and Rust. Switch a
>>> few variables to use these types. Which, for now, will
>>> require adding some casts.
>>
>> How necessary is it to change char' to 'u8' so long as the rust and C
>> sides both use a type that is the same size? Also what's the advantage
>> of using these typedefs rather than the normal C types like unit8_t ?
> 
> Rust defines char as 32 bits. C treats char as signed 8 bits. What git
> really means by char* is treat everything like a byte string, and u8
> is how raw bytes are handled in Rust.

Right - we need to use u8 on the rust side but I'm trying to understand 
why we need to change the type on the C side and why do we need typedefs 
like usize and u32 on the C side when we already have size_t and uint32_t?

Thanks

Phillip

>>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>>> index 5a96e36dfbea..3b364c61f671 100644
>>> --- a/xdiff/xdiffi.c
>>> +++ b/xdiff/xdiffi.c
>>> @@ -418,7 +418,7 @@ static int get_indent(xrecord_t *rec)
>>>        long i;
>>>        int ret = 0;
>>>
>>> -     for (i = 0; i < rec->size; i++) {
>>> +     for (i = 0; i < (long) rec->size; i++) {
>>
>> i is a loop counter and array index so we can lose this cast by
>> changeing i to size_t
> 
> Ok, but I'm going to change the type of i to usize and stuff it inside
> the loop i.e. for (usize i = 0; ...
> 
>> Thanks
>>
>> Phillip

