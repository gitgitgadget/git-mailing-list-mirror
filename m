Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91B36C091
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082167; cv=none; b=XymXOpLMIaN4HvpyIaTq0RMLf/Nh6XLM+veb/ujBCAZmX0kgCl0inFqb63RBa58HjDAnic8xu5XpDxFZ/TJI/iTZ85CXvcjFko0N6MIplYI9jx/LtLQ5wVWCzu6Rbt85MaAqyx42KFhIQECudbVFwlH4qkDetD6SbSBl6ZT1MCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082167; c=relaxed/simple;
	bh=x1mG9QHx0sWHC65usjeTZlXuNDowu5ZNzhwM7B//x/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vex11C2WuQXC/6cIY+o6ICjBYLltmwfWqEPQDwcBJUjVdLtG8aOvq2AmQqTtQw2y9VCaU33qUrcl0E85dHpPgvSa8lZPPZ5DG+UhzWYFgFEzJYurvBNZF3GyiKY/9/73VLPiwqOTLFcu5Ng8WwoKT9y9VfM+dRkyOirLqiuRrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0CPorQV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0CPorQV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dae49b1293so1256116f8f.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757082164; x=1757686964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6SyOfhGFvRO5n6V9VDQDhua68t+HKYdxh1gVbo+W4fM=;
        b=W0CPorQVvaTbPuaGeqvM1dcK+UPlvfb35HV5EyPP/T0dFFW9vXEnHxXfVqHzmRZ8OC
         YezYHdhd4uMSOM9fjCpA2hShAEUzLK1UGNg8UEYumchI08U0PcEgWNHCDauKBorHRbcS
         EYR+2xmtMxrCISU9CjHzA8PfPwD9XF1Hvog3rbz87tiNDlBlCwDmmNTg/yZPqZrgG/rV
         JVraa3O/ciS2ZnsLdGyLT1ZexX/whvNCnTdd12myzWEBRwaa+UtVDGAvFb20lklxD5tw
         Bklk8qFva7r8c9rvEep+9sU3/ZuYNx1ZeGFFqrdvo6fz24Ugj89odQiIQBFgVnckaIqf
         PkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082164; x=1757686964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SyOfhGFvRO5n6V9VDQDhua68t+HKYdxh1gVbo+W4fM=;
        b=GjNpVbLBPiMwNxph2Q0TAIvTV1hOGyYfrg1Jk93LKZw4xZAUrSqbu/AJdgYG0Uj4VF
         1Xc3DsVJi1P38VeswF+W5G9EWd4UNdbIVOLyrD6hwFyZ4vFHEWxeJFc7HqnaSXoGs4jE
         pNnLbNP6SUKsyQ/74C89m4BDpoGP0SGQRnT9z0linHSLozkXmYoEaLCZ2fhnK1X47Wry
         pU8gHILcbfjgP6905OQTWbhE2JVajkBEUAzAo2VplL0kS/YS0PLCJsR0K5qhPhsHMP+h
         kIz7tWJN9Pq1of6Vq0xjyRxOEjh2AimBWdG5FWoDtvKGugAkoK2nCzajynBrZBXfDF1K
         LRcw==
X-Gm-Message-State: AOJu0YzyJy2STU3l4qJ7zyW8Y/1cG+sDzadJUFq8l5YRCU+ZKcBymk+k
	f2IxRnVBPH1oTsDvfbKGqW0Iw4glp74yAv/BICQzofI1zZ9qlBKZwYn4
X-Gm-Gg: ASbGncto7dZ6UWq6fbgICQGxDmcJZyCJgTN2ytdCIr0LyqPchLuut8JG6lr64FSO7Zj
	bOt88hgnvOrod15E/wvk9mD2wa6gO3Z42Xf257PB3Kmsf37YC4t4EazoHM4kc1RaM0m63IGs+13
	8nEwYdTqY1KuDTm6b2w+sp3RtcWDaOCL0oHhpIoe2tOEJ6ZSQTyXUPjPoorIHnXydTOj6K9EQkp
	BpWni03icUIOLzanF6EejRutrC0Led/JDfLX1fp9xdSiTJD5eqjge/JEBzZp0Y5W8ZtvpGQmRTM
	//pXqKNVg45yvbvpqwkmhnv7wsDAg6tUoRlOntuH6vkYD+nOiyaadyx9ZPUu4Tx+BxCw3azylLD
	xT0Wiu8qrNcdp0LvfQvTkzFuLCtGL8Jdpv1xGalGbV7XvpReX/AU6e9Ei8/yB9vVpK9/HlMjY22
	FAiaIA3UM0ECatpEQ=
X-Google-Smtp-Source: AGHT+IGigAMIX+cOQ8OWtcNB2xxQCQMh3FdrRMiKbS49y92kHYRwQRGZZAZeCZQzfMl2AUlst4MUxQ==
X-Received: by 2002:a05:6000:24c7:b0:3dc:2930:c7e3 with SMTP id ffacd0b85a97d-3dc2930cb03mr8888654f8f.35.1757082164456;
        Fri, 05 Sep 2025 07:22:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9d37sm31952928f8f.49.2025.09.05.07.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:22:44 -0700 (PDT)
Message-ID: <c9397330-0cc5-488a-9027-c0e869bb4b5d@gmail.com>
Date: Fri, 5 Sep 2025 15:22:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2025 13:45, Matthias Aßhauer wrote:
> On Fri, 5 Sep 2025, Patrick Steinhardt wrote:
> 
>> ++
>> +The Git project will declare the last version before Git 3.0 to be a 
>> long-term
>> +support release that is maintained until alternate Rust backends like 
>> gcc-rs are
>> +able to build Git. The Git project may need to rely on distributions 
>> to help
> 
> Do we want to commit to promising support until gccrs is ready? What if 
> gccrs ends up abandoned? Or takes an unexpectedly long time to reach a 
> stage where it can build Git? It might make sense to give this LTS 
> release a time limit instead, or in addidtion.

Yes, this feels way too open ended. I think we need to be realistic 
about how long we can offer security updates for an LTS version. A lot 
of the security updates are written by developers at companies that have 
very little or no commercial interest in platforms that don't support 
rust. While those companies do have an interest in helping to keep the 
wider ecosystem secure it is hard to see them funding security work on 
niche systems indefinitely. Giving platforms without a rust compiler two 
or three years to either port rust or prepare to take on the work of 
security updates for their platform themselves seems like a more 
realistic balance to me.

Thanks

Phillip

