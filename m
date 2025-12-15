Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63B34DB77
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809240; cv=none; b=vGaR5gOQDh66M48V3s/6NvPndWqIYNC3QEQc9iNc9WDr4bVPC9vTA+fMQxq08iJfhoyTzngr4t8o9rub2nZK2LvkqOQEl6VfmgYUZ/eov5fxzGsrJfRiTczulrJoQVWZRH4YB3Y7kZerXwM7+Gn2z03uNCbIvLRM9XEH11X1i2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809240; c=relaxed/simple;
	bh=Y0PQANnMvmye5omo7f7oCedr5b8LCP8uhLQ5kYKNHJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLd+ohFUNIXCFBa6Td4EASXZ0STnm/nH0Vv7jFNyV6gJAKGWBvFVstC5KAYkRbLwTlb2sDma8SVL58yrv9aURH5sL/xGjI8uZGvEHsPNtJ38UPZNc2Du3TwFNdK64Y5LvzNyT8slHvDS9BJzPgNx77BT5lSftE5ZA+7Zb4lpYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krcVC36m; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krcVC36m"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2d56eaaceso389057185a.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765809238; x=1766414038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EN4dTFKsEG2eMs/UU3z8D04Avcr9VRkWa75SBYWKduA=;
        b=krcVC36mEAyyslJ6x+wGFazvvnybZCyVVlK7gZagcPigm8Q1wKnbRUvqlxVQduubwe
         B6X/wmE/jDshHpt2y3KTbMFs91y2fTq7D3b6yfLOgskcnTccaqo7vUCt/a310Mew2Tpv
         6Eu15UtHTzBD948/ecT4HIJzJtoZ7DSYSnDXLuRB9/ziMnlUsXg+E93JnoZ9tuRszcCD
         FXKpRXg71BlmgPEeAopqiPNYBU0MqQxe2p2pbg0yfbmQ9SobRMmtJ7HwnGMAvdIASasq
         4aAFFxU+++ROkfvd2ttTs3M0P1KpFWmOTwT5k+U6H5he59H79sTPOH5Pdzka5KkEiPbR
         uRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809238; x=1766414038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN4dTFKsEG2eMs/UU3z8D04Avcr9VRkWa75SBYWKduA=;
        b=MtKeXBBSyfiztxXELibGxfxlJhlRwtXhLUHaiM5RRKw2h7G12Bd/voAvcNdN52Dgpx
         47zpenxzHB9gu8Ch0fVISv2mbXeE4Kv2emEHY4jotz+1EC8ZTOmzSXIoLulIhvccORFl
         09hDoH1Ws94acXPV4iNLoeaz+RWIhpBWqLp46Ada/Q2smu5tShDtHPA8Y/3Z1TnDv6fD
         iXsulCIpoUF5sdmJtmnwyKx1pDv2/aU8XMSJzcbCr0sIXh/HQlABHsBDraxprMsVbP8b
         DgbEyL7Phi+ilvlCE1Qls1WXDm4lWBOfOXnsUg5gYV4buxgCuSWOY2H+ZBELhlekJjNN
         gtCg==
X-Gm-Message-State: AOJu0YwqORzdJc1X8yhhonSehV7Hyb0PKapTagutEgCkCjC78OuqxWdZ
	P0m7sMHDU81FPpUPBAzI1Z8Jzm+fuql+m4u79N8ONHxK3FzfI+OWMwNn
X-Gm-Gg: AY/fxX4Wn+u/vjg+5UPfJ7y0Ky67J/NCn/ZfAy5WKp5nEmgBuIGRR40qpK7UHDjetnR
	K1guOr8ZML5YZ2EYBw1ri4LtOgHhdTvlNCfRhzRl2eSIJc9r8NKdwUcgPSnaPnqiGskIxVjIrd7
	lnO50czShk0aLa2UwtpjK9qqWM2MQzasatlVX0YdvP2UBNHen/H5xoOO57ljpfLMWIqNXhrb1Dy
	94zabAQCoj8IWFfhHV65Dm/3oeIph9HGs0v5VoM4zqYLHuFIeb+DfJpJPnDT8MoImYet5M0xYIk
	AVhIZiYW0QMeOOEO+bIZTrSh27zZ9ZG9ie7NOpbf6sM1EMFbpdeSCfd1hpU49+BwtV2TM5UbanO
	jU3ue5rf+Jw/BRituwMwO8hd+y5IYpXPdRHzI0zJLR0jxupqS3ZWjkaoblsTbCG02iQAwtKlXZ3
	cuE+RocyqsNx2nE0kNj9cAVxkoTBc1j//LfN5MUJpLy5ztDlvW7kgt+DsCig==
X-Google-Smtp-Source: AGHT+IG0HcUcIrSK+KoM3N0Mb7503NlUtDSpgiZkM+JzXoZQMP1L3kKsHy5/RZ2abiMjVni1s2jtvw==
X-Received: by 2002:a05:620a:4686:b0:8b2:f3f4:2b44 with SMTP id af79cd13be357-8bb3b37019dmr1479761485a.83.1765809236448;
        Mon, 15 Dec 2025 06:33:56 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3bd4bsm1083824385a.32.2025.12.15.06.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 06:33:55 -0800 (PST)
Message-ID: <ee4acbe5-5efb-4bd2-a361-dc7f183b4f41@gmail.com>
Date: Mon, 15 Dec 2025 09:33:55 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Audit and document Scalar config
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, atthewhughes934@gmail.com,
 johannes.schindelin@gmx.de, Matthew Hughes <matthewhughes934@gmail.com>,
 Henrique Ferreiro <hferreiro@igalia.com>
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
 <xmqqecozb6rl.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqecozb6rl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/2025 6:49 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Updates in V3
>> =============
>>
>>  * Updated method names when setting recommended config.
>>  * Updated documentation section title now that nothing is "required".
>>  * Made distinction for index.threads=true as explicit setting.
>>  * Added documentation for log.exludeDecoration.
> 
> Looking good.
> 
>>       +index.threads=true::
>>       +	This tells Git to automatically detect how many threads it should use
>>      -+	when reading the index due to the default value of `core.preloadIndex`,
>>      -+	which enables parallel index reads.
>>      ++	when reading the index due the default value of	`core.preloadIndex`,
>>      ++	which enables parallel index reads. This explicit setting also enables
>>      ++	`index.recordOffsetTable=true` to speed up parallel index reads.
> 
> I understood the previous "due to" version (from the middle school
> English class I took eons ago), but not the updated one.
> 
> Other than that, there weren't anything iffy in the new version.
> Will replace.  Thanks.

Indeed, I don't know how I dropped that "to".

Thanks,
-Stolee

