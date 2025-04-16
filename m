Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01281E
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810316; cv=none; b=unUvbRssGYdNh2aJ2m3T5KNjjpsmHyYLkfuKe5Gm0PvP2FrbvU4qyP050CMEQzijIT8ZuBkGFAn+VRJSYO9yuzXkslnDUOLePWS612w89O+xM7GCGaqmIcxNDaynmAb78c1chRHW7ylvN0uZFTYSXI1Sdl0TeGVgVSvY12lgFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810316; c=relaxed/simple;
	bh=XOSgGXa08p0XwUGmigMNvYZkTyEJjbg0/V15/qNiUCU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dbhBTAi5fAxxz7oZ0Wrq795z1peYTHCzUWvZwNf+SRYkcDOwWVyXUjK4Qwa/Z6jlw+SyUqFiOHmN5x9PwqKjFEQL3C+19GtYP4HomA7p2QGDUOctfDA7uHJLfdF0sdzZ7BIx7bsK+iDuSkhG4667OG8cffLA3qhI+kcrU7DfdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFGK9zv0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFGK9zv0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39149bccb69so6650449f8f.2
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744810313; x=1745415113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTuFUk97niODm9RVi8yPKRAwXTtkm+jQOTQfYSUn4QY=;
        b=RFGK9zv0U4bCwqTgmckyZOnkgA+nVXQ+skv8zTE7WAvLV+2r5XxnW2vYDeUTs2BOqv
         mkhflWvb1cDtgcYHU9I11DJZuSswrq+beid4VCtrPCJmcXtxriT97I5TZ9Jb8Gd4iKVA
         CyTWLvAtTBueaf+Ed8JiwCGe8qr4Zg/LoHxZmIt1hKPRnY7p3JSRHSAlH5mcr0vF8qIv
         o3gktTM0FavHM2A4aT2TkRwbB/ruO+8AnIFHOCPOFK7Y6wVu7x9SSzXa604/p5+v7V2a
         K9KqEUeDKZ0oCyu6kTmYoztDBik4OlmFqj7tl+A6JvGRkBkR+AesZVmDtxuf6UPd6LP/
         4U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744810313; x=1745415113;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTuFUk97niODm9RVi8yPKRAwXTtkm+jQOTQfYSUn4QY=;
        b=e3SXNyvyGNu0q/2Be8cwIcsGvAhCabaIJLS/saBUwHCx6+fohVdoQsqOVfgJpw3RtQ
         SKRDprR+BGabQPsDjeV7H0HKDJ43CKomd9Y6WpwQbLvy/M8Gc56grYvdgyHZ7s0c6nJA
         WqkkHqW+CpbTdoUt0P86772DCpiZrQKkKA2pBBmV+c0tjCK8ONpGb75FaJOZovap70xF
         z6q65HHaFEDbQFQ37F6LUmsJ8k4gbKtOnMRpgLyxP6ill84XyqMDu2IygWidlAMPP0pg
         o6A/m/AAXA6EBe5+6sab7PQK40xgJnOPBrctq9fX1erLKIpEzk+IdGUBbOXKjc0UNthU
         WPzA==
X-Gm-Message-State: AOJu0YzqSx/+YEfhRpQoAdq37VzjCqNrT/0+wA0mUmhwbo7D5Kt9gDl0
	MYSF2Z7Pq3Cf99xjqTUByz7noWiyxwvSljVsUBSG5CWMaTqFopZ0
X-Gm-Gg: ASbGncsbEwmfo2geM672MQj53yOog9QZON1skCEdgqSYuPzMBu1B60p5IWG0ZwIevIc
	UDB+4QjfULOKwEROcAiS+U+FaUdksYhck0qChL0883/Ib4PxoYYQHhJ6UazevzGL3qTOWRe7pU7
	j8T78+EsGj5v4hxHqpjRfzN9S+IENSkjbpLQd0oEP63Mr39LKPdS3u48NcSXbdlRdz69RzhVP1J
	fFsK+WCwyvclR/5VpBrhEY05SBHxAxhpBQDwx5Mvvf9vAdg8knJhQtJmfpIu+/kMynzp+lqlTCa
	a35TS0FxU4cADbUbsR66rXjfC3JoEpCMR2tX/8M7qLtl2X2kc5MMCjbuq8p2R79CbQLC2/O6LQc
	px3JvibXBix5df9Ti
X-Google-Smtp-Source: AGHT+IE+RSWnSY0uP+sR8xGNrfc+1f5bvma8lu0sNj2g8wQOYgFZOg8r/vOXYb5pxY3Xpx8B9HoDjQ==
X-Received: by 2002:a5d:64ae:0:b0:39a:c9fe:9710 with SMTP id ffacd0b85a97d-39ee5b0fe70mr1928545f8f.11.1744810312846;
        Wed, 16 Apr 2025 06:31:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce3bsm17497117f8f.66.2025.04.16.06.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:31:52 -0700 (PDT)
Message-ID: <7c684f2b-ca56-4e8b-b141-0c2f6b64a44a@gmail.com>
Date: Wed, 16 Apr 2025 14:31:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/5] parse-options: introduce `OPTION_UNSIGNED`
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Todd Zullinger <tmz@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
 <20250415-b4-pks-parse-options-integers-v2-4-ce07441a1f01@pks.im>
 <35300426-32cc-4c0e-b0c3-edb2b2ed312f@gmail.com> <Z_-GKX8uFSNib5rW@pks.im>
Content-Language: en-US
In-Reply-To: <Z_-GKX8uFSNib5rW@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2025 11:27, Patrick Steinhardt wrote:
> On Tue, Apr 15, 2025 at 04:52:02PM +0100, Phillip Wood wrote:
> 
> Wait, does it? Why would `strtoul()` or any of its variants ever accept
> a string prefixed with a "-"?
> 
>      If the minus sign was part of the input sequence, the numeric value
>      calculated from the sequence of digits is negated as if by unary
>      minus in the result type, which applies unsigned integer wraparound
>      rules.
> 
> Oh dear... all these integer conversion functions are really a gift that
> keeps on giving. Gross.

Yes it's horrible behavior for a function that parses an unsigned 
integer. We should perhaps think about adding 64 bit versions of 
strtoui_i() and strtoul_ui() so we have a safer option for parsing large 
integers but I don't think we need to do that as part of this series.

I'll try and take a look at V3 tomorrow

Phillip

>> This patch also needs the fix from patch 2 to detect overflows for
>> uintmax_t.
> 
> Yup, will add.
> 
> Patrick

