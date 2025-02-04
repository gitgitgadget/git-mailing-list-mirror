Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51D217707
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694223; cv=none; b=JkLsYXoWo/WXFqIBqodluYeo9HdMpwff1Ucgc5N9lLZqAmKrqS5d+HnDZAFtBanQOXI6kj0GMs+6+EIZ33DwWOJgLZ+DmXBpw/BUcftRMCYGLWiAK975yW+7F//GbGMuXYOYhScv4DBdvJpavvwlIccuKliM0kzwlTWciiibqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694223; c=relaxed/simple;
	bh=5drYGDCpy1HdX7brNmT9cFmZq3DYDCU+RdfIlJEpCUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ5u8U6MPOtzMJxQidtN9wJjVGEGGcUkvmeWZnoJctXp7ZHNQua4vWNUwtVcNEFZX4T+pIXXkO4RPAKKXWREu5l0LshwFkv7ZXWRPz1lIcCSuwxLtatWEEoLg3mbkf6crGFuI/nwMfqjN1krj+UfLKJgYsTlAKX3FBuI4YlYXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By/6JFgx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By/6JFgx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216426b0865so104098005ad.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 10:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694216; x=1739299016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8G9+p/niippjYjfW6ca8hp3EViD7vLgHSjRB3rIMZBs=;
        b=By/6JFgxunCjeu2wvQwwLoOCMVA416yrks+JKiiTkmJV5eCcXiUdQ4a0M7M64p+gKA
         som06KmahOuzEsEVvSR2Lzxc35wcfcoQn9DLVkWrQkDn6Wo2G0MiwpbZQmU+63HAtcsD
         4NR1GvAjgqtYEotNB5j2xOfEfwV9bOgpw76cf1ujzCZlT8LBajH8XB38eVzfGl85vqib
         vcSn02/TiE6hGxA95kDy3A9XMZFQDLBdUVv0ZB5tn0JvWgbtk+xwg1N7zYKGJdf+gaDG
         taZfsrvwcq0IH4ciX4D60x3XMJ3LOj+WU0X5JFUdwAhuce7h/7e8/opChRSJoO65792b
         jENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694216; x=1739299016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8G9+p/niippjYjfW6ca8hp3EViD7vLgHSjRB3rIMZBs=;
        b=gH3IPHrWoIYM5ovbofJu9rir6+8CF5KOVdI7+hkUW4NbY1Ppl0oQ1HU0HSKrx0EmJ0
         y3W+HB8vVspiIErcAv2SJU6ovaqxZYNllBhmdf/2U6bcOJ1kwGnpVqjkKwxfWX5uo7G1
         N6VnwuKhBu+ru2SXjS6Pr5a9FDSgS0IEzIj/KTjig1fFe0nOcYLM0ulZYqxo3OBBrmmj
         vB/9iKgkpT0A+peiDPWkMB6Q2An1lsoN2fA4M7Fhcufd8w0OB3FA2/0eWXIdXtlhb3Gq
         PoFYjLCSRfy0cpAW1xgODEfHBIULlikIQDkPwhJYpsuDIg3MYgpws+EuKebW9ALvRsLC
         Jr4A==
X-Forwarded-Encrypted: i=1; AJvYcCXN8ClmopilK5a01YeZEyl7LJBDJ5+slQRLcdKBFqsm3GZj3fVQFloX7pnt+8Ibjn/KqGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8LoZ5xEOX9pOgC3Ln/yBRTrqwAivFEXbJuEoXxiQ27SC0tlT
	BDwDoJtdSKVEnFbiQ5THR3Sj97UiDsHBqOSt2gJhZd34NF3tVh03
X-Gm-Gg: ASbGncsz5VCKgodB3mPccC64mFs23hh1sLs+ruTGJfLNlYCFx0lEAEaMK9ds7LTRZY0
	0YPuzHzScJgMU5ar2IXjxjPOC3ZTAm5ZY+sE4DNImQ8WukZsg3wsCBOeRWRLDZFUsOSZwXZ/OBF
	T5bq4Ka+2KkEUD+xky7pfsSxeDr3vN4jbJlX02NjzmE6PAHLeg+Me4lknEuOQqlIuEaLpfJJFUf
	/5gScTULwmLKLXHxCoyEBCLF1GmNhq7zVOlAXuLzKElBUmTUnskx7+vinL+63tiWktj86IzeLii
	ap8v76ymMAs4eNvSWyl1KEcQ
X-Google-Smtp-Source: AGHT+IEP3DBRbsLOl6383aiGRWZaBQyD+uQm7GDhxOgnXwyt4VdCXIozfG+mqNTrbJvDjXX1382EEQ==
X-Received: by 2002:a05:6a21:3406:b0:1e1:a576:aec with SMTP id adf61e73a8af0-1ed7a462f1dmr46023127637.8.1738694215939;
        Tue, 04 Feb 2025 10:36:55 -0800 (PST)
Received: from [192.168.0.7] ([106.51.24.86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0a666ddsm8674390a12.73.2025.02.04.10.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:36:55 -0800 (PST)
Message-ID: <cde4132d-fd6f-4f83-adb4-7ea124b6f09f@gmail.com>
Date: Wed, 5 Feb 2025 00:06:32 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
 <Z44u7od-mDiKcKVZ@pks.im> <xmqqtt9byxia.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqtt9byxia.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/25 18:51, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> I was wondering whether it might make sense to also move the list of
>> microprojects into the Git project itself, e.g. as something like
>> "Documentation/Projects.txt". This would make it easier for us to update
>> the list of long-running projects whenever a new project is added and
>> makes it easier for people to discover it.
> 
> I wonder if this is better managed as either a separate tree (like
> the 'todo' branch that houses "What's cooking" reports among other
> things) with history disjoint from the main project, or even a
> separate Wiki?
>

Just to cross-check this, isn't the current home for this file,
http://git.github.io, already a separate wiki of sorts? The site's
description literally says something along the same lines:

 > These pages are intended to be edited collaboratively (i.e., it is an
 > alternative to us having a wiki, but one that is edited entirely via
 > Git pushes. The repository could be found on GitHub.

So, do you think if it would be fine to leave it where it currently is?


[[ References ]]

[1]: https://git.github.io/

--
Sivaraam

