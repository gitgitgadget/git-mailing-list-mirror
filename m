Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37377A132
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236942; cv=none; b=afk7A1MMVcIzQU59AW9KtVje1ky5MEe8IfHEk77EONvnEhoCZ7pRX0RX6BJR2qBN7V3M6CWRGXjiqVgY9MSB5pzhPGGhHi7qjOS5zFWX+Wd6p+22mLF+69A85mkRx7usFe752vDlxm1kD2/nDvuwpd0XWMbZPyg8/pZ9Q2oChQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236942; c=relaxed/simple;
	bh=CYpKAwg4haPvnmhtgK1rF+84+8UwwT/RqdH+eifnz3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h88XKMh7jz9AgaID4+hVK1dqZagCDh+vKIFLhT7f99BkNV06PsLkCYaCF8jmaWmThNyBBPLHmp8+ybrGjafEeoPV27w6EO3n4wgQ5RuzEZXKyVcLoDW3673YMlhJlrgHw6/zvJKhYkCIA3ZkWHVFckAm6JDkUJPkuXXRKla2VUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjHWi+no; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjHWi+no"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412bc3350d0so8129405e9.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709236939; x=1709841739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQ6mktnxdOdYVZrYpVbF0UtteoqyEHyWHi8TZamLQgY=;
        b=LjHWi+noyW2+MtSMCjzJuW8+nzR8aOVi+Hhvtd4vk0C12aXlfRCzAQ55wQxWWXmR8t
         BYV1P5mayHqZssTYug4Y+MobsXDiV63YRKh78/PoCZCufDhYRfQIz5Eziaf6wpel4NV5
         fu3x/r3pWxthOuDknR6LjvltiNG7Evoh0FhA2k7pBVtj3z351Sai3QqCkviC68bBeSMV
         dOmiv2YZOVqgqvr6neO+bIWPqAG1xwOLRm4k4JcCBoZGQjm0xG9t6I3DHr/g+nOkwjW7
         gCpbh5kSM0XpqienulG1oJZUxT2A1wjY+Bd/bWsR+iOHGfGmIvfzkDfKjH+9UTl50EXK
         noQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709236939; x=1709841739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ6mktnxdOdYVZrYpVbF0UtteoqyEHyWHi8TZamLQgY=;
        b=qe0JZnmWbkVgV3IEqgCvi07lg6CGOxeHWtYjO0mqdU8K6MjgLMx5ttzm7MoFdqfHeI
         liHACj51bSv4W9kzld3X3SGFfUjXQNwwCHrVwRP29N4Wvwbc0ZRQfP/AFUgYzf9SZjyN
         GlAStkwRX3QlZe4ppGENO5xZCaFGfMw7+bkIXL+0OS6dvNaqHfksO04qEsVH/FEddtir
         8kaf5j/1PAwfkZAhgaDmt5UG+xqmoxO5GA7gFzkVSaM+18DBZWE25PO+xjFgd+Vr8Y54
         6FVBVaUtFUP7uS9OOg66GNsT+WrwkSh2q/mVDs1iHg5kVFjmCARU4VE046O1rFpW9S4T
         YhCA==
X-Forwarded-Encrypted: i=1; AJvYcCXYa5y1YyLayar89NsXdMpODo6A/fmMNjUnsPAeEr9HuJF8DXDoxNv8mZOb6uWJvnn8eSbubCNm/oghlBrD8RRUuynG
X-Gm-Message-State: AOJu0YwQmCpEIn4M3G/fuROCWMLqLleQNoW2IuuVkBKNKFMdUbfA4AfM
	atoRB9jXnhncKe/i9CZoABRsVNNp/xaAUCxpzajz0UjHAn7VjxLt
X-Google-Smtp-Source: AGHT+IExrD2gW79QQj+n7rSC8TwY6CT3B4YbVbUpl9jBkHBIbsUST8TmVjNJ+88LVBGhhJoxWfb06w==
X-Received: by 2002:adf:e703:0:b0:33d:2775:1e63 with SMTP id c3-20020adfe703000000b0033d27751e63mr50715wrm.41.1709236939142;
        Thu, 29 Feb 2024 12:02:19 -0800 (PST)
Received: from gmail.com (13.red-88-14-204.dynamicip.rima-tde.net. [88.14.204.13])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b0033d9ee09b7asm2564803wrt.107.2024.02.29.12.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:02:18 -0800 (PST)
Message-ID: <d456a80d-5c2b-421b-a849-3c7cce288c6c@gmail.com>
Date: Thu, 29 Feb 2024 21:02:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: adjust documentation
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com> <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
 <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> <xmqqttm3ouxy.fsf@gitster.g>
 <16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
 <96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
 <b6d22f5a66de49efc623eceddbdc6faf@manjaro.org>
 <d1f928b98238a60a96bee0d3f410deef@manjaro.org> <xmqqttlsld4t.fsf@gitster.g>
 <cbaf17e7-37a6-4c2e-82ba-65fe41dd86b1@gmail.com> <xmqqcysff4l7.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqcysff4l7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Feb 29, 2024 at 11:33:24AM -0800, Junio C Hamano wrote:

> Do not forget that the objective of the larger-picture-revamping of
> this page is to make the description of each option self-contained.
> Similarity between -m's description and -c's description does not
> count as being uselessly repetitive.

OK.  I was not considering this.

Thanks.
