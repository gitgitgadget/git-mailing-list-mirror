Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94B47DD76
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065272; cv=none; b=Bbl1CSyYtXwDWu4qwcIGL6Cl8PM50QgvwF8gmNSbqJ+PUIyrLhwel3NoFUmZIwe33aPM7Hlvi2Fdig5Ch0iA+Nipcr3J0Jf5bLZr1kG3f0zwMPms6jXv6GxCBmelTqU7uD5OdlncBKt3h5Z5WyHE5Wwldm4g1lgaQkhvB5f/5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065272; c=relaxed/simple;
	bh=Ibd3rBK7Ieh2qhTJ5fyRNoJuhojYqiW1YZPuPKO4DAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bZXV2vtpTbEhf1D7qgmyYtmScJf8laVSPJJLPLU4Lm7F3jDL1gy4Q0pPiIH/MOa0ZCcRitwX2nz4GoNJ5g+Gj+kpAlYcrwxuS4QoLbLsP+veiKIpxOFClzBIxxjx/zbbnIMWVJTzxRCrwwGpXurHi/Uxcy32pwTkM6TBgqLNXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdpNyaLA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdpNyaLA"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b249d6ba0bso2171385ad.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775065269; x=1775670069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NgL3YKUk3B+rTb2ZOFDVY5YnsLYi7JvZKFAZ5dyzYag=;
        b=OdpNyaLAoW6jUI+ZXmgjNe4KznKIOhv1aremUmXL9ExroMrc/neA5KRxt97915ZJKA
         uemaudQuESRlRrHZpS/xd07B58+vC5X+y4HiL3ujpmI9SF54Ua58n8wziAVZ1uj0RE0n
         CY0IP1jqdZZ64r9KKOPQqByCmd8SwmCSp4DZFnWlIDWJeWciJPY3ihrsKZ6zaH2b2bLQ
         QnO3ICCPffmQFe9dXvThT3r5BgdQJBzs6RUU91OldnGIQH39pSm6UmYjvLEKXIvWE4Xw
         zL2ZgbIBP7eJHUXlu+NlqSnYFvPtYg0CD7rCzzJzgvtAlSwt1jMhnsKv/AHxlMQ3FaQY
         +LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775065269; x=1775670069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgL3YKUk3B+rTb2ZOFDVY5YnsLYi7JvZKFAZ5dyzYag=;
        b=MvVcCftttfoDzr+OaAUiw4LomZaKgRsPP+QhWe/CtI3djOZzC+rkn2cZlhgEBKvXG9
         fl/yDoe5+4nxMGKFi752FepIvde3NeVAmjKs8aJn118Dw1vVlVSkJGuFHKnOgu6yyxsF
         3wVXlmKzO4jwul6wD8WJlUogf0iM04ORbda/NDxKMAnr9IjcNT7mrtHC41Wd+le2GPau
         HbQX8H/1jKDWBAeM52HqGFKMbtyZn/T2nBuxCp/IWlr8p/Omo6swdaLGIgG4wcgKKRA1
         IU2+qVnbNQfktMYPUxYFLHVGDHpCEgEF5CtM0o+wXwT9XJLtiktY2PmMCMRHndhRwunq
         sRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEB1PYvM5vsswMWf6fPNmV6SO47OgU5/EcYsJIUG4DF2brImLq0pvYt9Mx4rQa3sarmrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjL+8F5X1bsKs5frTzZ8y18+xvQ+fJqWHqcJo7MxeSfIga3III
	dVS3LgxmfNe0NLFN8u5e2kzcHS/Bddj8iGjxhQE3TMNeP/ocEDB/IrPHnYrLehFX
X-Gm-Gg: ATEYQzxk+hUZNOxHOngUoUYHwBCCtu5W1Rcld91rrFE+W/8dEqE2rFUwa3xYhPrFVdY
	KQAnN8Nro4QCN18tnkFy3esRG0D6CmERbQAoP4Rg6QqGHrRskx8760XxIC1EFDCdi6qCK4+nnIb
	wEpK1NlIREa7xB01Zs/m4AbN5ehGOfXRK3HdyahY0nEsHwEHEeGhwwBYHB5Nj2pECACFMfW1Yj1
	VEeLHiiTJXlYv2lROqg4QRxIO2zBB96StODxw/9vnCdSbO3XhvqeAAGKwC99MiY+xzcLFQDoM0/
	XNOwl+4dsFY9FclZ2dfNAGK5YNBnXh7+1R1fOs6hie5iDAWk35XaHfJidDNFzd0tmUt5sIo9G1L
	iI3q0i2LJN7XzYx83WFWyca7K9sZ7wYw3hmLKERWMXzcwI5vrF3v5UoSOGS5S2VxZluF942J3i0
	eXVmbkuC+bsGsitaXXZEwn9hSjuiQCcp9YS+NCi3i/AKNTpdH4LUliPRiQeI7xnOuAeRET/359Z
	EAMjUsy6Ho=
X-Received: by 2002:a17:902:fc85:b0:2b2:61c7:165b with SMTP id d9443c01a7336-2b269d14994mr25034785ad.7.1775065268680;
        Wed, 01 Apr 2026 10:41:08 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274757fa7sm3710635ad.21.2026.04.01.10.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 10:41:07 -0700 (PDT)
Message-ID: <12070180-b0a1-4dcd-b333-3c42505aeecb@gmail.com>
Date: Thu, 2 Apr 2026 01:41:03 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hash: introduce support for the MD5 hash algorithm
To: Toon Claes <toon@iotcl.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260401-pks-object-format-md5-v1-1-1b8f0be23713@pks.im>
 <67f10f21-121b-426d-abee-32d034f84fe7@app.fastmail.com>
 <875x6aeqsa.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <875x6aeqsa.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/26 21:47, Toon Claes wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
> 
>> On Wed, Apr 1, 2026, at 12:42, Patrick Steinhardt wrote:
>>> We are currently in the process of migrating to SHA256 as the
>>> alternative to SHA1. But we believe that proposal is misguided.
>>>
>>> When Linus first announced Git in April 2005, he was explicit about the
>>> role of SHA1 in the design: the hash is used for content integrity, not
>>> for cryptographic security [1]. Given this foundational principle, the
>>> collision resistance of the underlying hash algorithm is essentially
>>> irrelevant. What matters is that identical content always produces the
>>> same name, and that any corruption of stored data is detectable.
>>>
>>> While SHA256 technically provides stronger collision resistance than
>>> SHA1, it does so at the cost of 64-byte object names instead of 40, a
>>> 60% increase in verbosity for no practical benefit.
>>>
>>> As an alternative, MD5 satisfies the requirements of collision
>>> resistance and deterministic checksums perfectly well. At a length of 32
>>> hex characters they are shorter than SHA1, roll off the tongue more
>>> easily, and have been a beloved companion to the software engineer for
>>> decades. Furthermore, it remains in active use throughout the ecosystem,
>>> in checksums on download pages, filesystem integrity tools, and
>>> countless systems out there, which overall proves the point that they
>>> aren't inherently broken.
>>>
>>> Quoting Linus in [1]:
>>>
>>>    In other words, I think we could have used md5's as the hash, if we
>>>    just make sure we have good practices. And it wouldn't have been
>>>    "insecure".
>>>
>>> Let's do so and wire up MD5 as a new alternatitve hash algorithm next to
>>> SHA1 and SHA256. Repositories can easily be initialized with MD5 by
>>> saying `git init --object-format=md5`, and tests can be executed with
>>> the new hash by setting the `GIT_TEST_DEFAULT_HASH_ALGO=md5` environment
>>> variable.
>>>
>>> [1]:
>>> https://lore.kernel.org/git/Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org/
>>>
>>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>>> ---
>>> Hi,
>>>
>>> I guess the title says it all. Let's correct course!
>>>
>>> Patrick
>>
>> I’ve been waiting years for this! Thank you so much!!!

MD5 sounds good... but Caesar cipher is clearly much better. This 
approach offers O(N) performance, zero memory overhead, and — most 
importantly — I want to be able to remember the key by heart.

To prevent unscrupulous individuals from directly deciphering the text 
by aligning the letter 'e', I strongly recommend replacing all natural 
language in the files and code with Japanese or Classical Chinese that 
does not use particles.

By the way, it’d be better to switch the transport protocol to carrier 
pigeons. Don't any of yall keep pigeons these days??

 >
 > I can't believe we'd have MD5 before GTA6.
 >

Half-Life 3.

Regards, Yuchen
