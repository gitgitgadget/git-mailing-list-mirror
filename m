Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493550;
	b=C0U9AVe8qJaTR5r17YTVkJMmwbwWzzI/u5i5PrVFEKiQgfEJR20AR4iUk4tuiBWutc/y
	 ydjTvHH022amUFZMc+dl68ixnAPbighRjXXT0v2NQbkv096Yh2NiW4DiJcSZOIcFgAePq
	 TdpxuhsuMYb86qkaXbVuVhUfqMVkIu4ytb4Qq5xrwI9lUiC594xxzLtxEIUvpkWM+RSHR
	 TVEX4msO8/IEgp1AMLePJXsLFgyVVrhh/kWMPVd0ORDkPpWt+0843KuG1zHLU1RAgM6+P
	 jlIsKfVMi8Og3xtYc1clXjLoXze1JwWWqWpo6709Z3ZNZZGwS3Ky76CoXMm1+5lkSWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=a3xcjy23urZBDdH/kvoFMKnixZH15Kf+6t/V2OJ/DN8=;
	b=0pDkMjjnY/zC2BY7yHk4ZQoci08IRZrDizqkYyovtv/WXQJ1lAkVI/CEmIQXHG/1p9yZ
	 7xnTpdDRrwHkq6O0qXGAtocoaoyb2NCt1yIETyVrAdPYN3oWbAxk5NwBv9nWmrV49/FUp
	 gMSP146mwt9JtPrAb5v1BKYoJPdkh1e9Myu19K5J9CMOgwCq4qgvyfH9NsdGpwbAazNU7
	 4TIqocpLu75/D/IYikjIBxgv2GQF6DDQ74P9sAqqfp5yqcOqxZBEYO27FGaCDimlh5uBk
	 kUK4SJcN+osgXNnBBFV2ftVOh+j1AENRes+ZgRUhRI37V8Co1uXrNP222Qj3WfCG/hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EuQjAumA;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387916070380
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 387916070380
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EuQjAumA
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b3541bb1a2so26370277b3.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 06:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493549; x=1795098349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a3xcjy23urZBDdH/kvoFMKnixZH15Kf+6t/V2OJ/DN8=;
        b=EuQjAumAGxbvmQXFgRZYFQkNgVDzveXdehg9K1GOM26MJjMShBTmRV1JFObn8IGkCz
         OD0gkLGcZIAxp6fh2E7FbkX7Taxz1zIz4PYK+WIeBDKiImvY4I40utWPPsdLN3qJHosR
         tkdTkb9AALMmeBlPKswPFgZOVFLEgW4MC1VJuGdNJe+NHg60B/jXulxD+Qr2DMgP5Un1
         lP4bgr2VwA3ej91TlfJ5WLBL1zzz5b+zJ7sLZsr5vDUN8jYXSAjT+eBeyIyK2TNIN97P
         9NA8DVbA47dr5CZGDNKnutbo3/jRw+g3jy1b8N0KTngm1MMK/LYJ5/Eer81Q/yJitlm/
         Ts0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493549; x=1795098349;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a3xcjy23urZBDdH/kvoFMKnixZH15Kf+6t/V2OJ/DN8=;
        b=qHj4Qwr+XtaIlPOAQf1pRTQLjFzragSQR+NpdB0OvVonJ2MRu6nToitkLC0LbTe/PN
         D5zyRSKShezQWGce6KPq90pVL7Z5a8kjzJmq8mzVFfoI2TH2D9YXeQxFjKnzZqvzTzJH
         WOA3gl362FMC7PtiP0teMS4jPZogk5BTbKu9Mp04JE5niAW6rqFHQjZYtVt1qt9/lQWc
         pHdhYT62FvGMqCFJnwI4htVYj9zrffVffWnjPyGZhj1yfCufZr18xf5rhkaXQ5W59OkT
         aujTwhNH2lRW5s+BW1nDVOacEpPY5K/A1G+q4xhynj4XR0gcX1snd/uixSpWdWELcxfc
         hCbg==
X-Forwarded-Encrypted: i=1; AL+hErGAjbI/ssnLOXBW2wiG3YLifdLCI3m7zrfBxEEfCROZC1i2BAITpuPSwtjrAIw0BPCGaXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WUNi+ASBAgzyar/OpkmsD9r2w6D/gbHKPAVrp+igHQ61JV3Bc
	b8pujVoeepHtyrkeSf1wuNG86DFDerAkca2a52I4GC0SqTFScyN25cq4
X-Gm-Gg: AYBFou3lgRBjuNDc10tDM0clzdB2cGK76JxG8+IrX+F69tyBfhB7pAL+z9MTd7wjlVC
	rOUesP7j4fN3cWk9Ek+IODBD3/7qKotrXyzYeSFDMG394CC+UDHatNug4ymrDER0z1MT2pn+CBh
	DZQYcmk4ikO8cvWg/hxmcY4jmg9C3et7HBX6Rs/yQ5JbfqSgvaOVXbuSNJfwoTq79JF0rgffdjc
	XX5a6Z29q4vO1zdAvEYrqcE8l5pc84f5bCq+YF6VSv5OmMe2B6MdiwfX+AcBHtHZHlroSct7clF
	VwXGEOVQs1BNSLIjWbwhsZx7B+d2UCF6gju1S4gfu4SSIO0bkZOoIqXvkENdNUPeeo1Pclk6lt8
	MM1IUgpuTkp7jK1p48VLXkxAOMpbESIEbNyz01URib4tF0zw8e41ZBD6Tu3nHra1B6jFKb3IFc0
	A9BAtmt48DNIeI+rpDI3Jt3kSR+3bd89QWNzDAC5IO0UF9TUWvr/fMZ1KnEjEMNoKRl0uSh0pzm
	yasiyIcG2rDPc4bY27u0OMAfweCzmyZ+pxhpp+noyVGETjyeViZXwFYmI+xHqsTXms9AM3UfHtq
	eBnvwVx28BOGCJ2vUVoaUlbN4ft5lCSD3Mp/wQnQXxu5Cdy97u0m2dnH5cSg9Jde+pyf4YTRP7F
	chAqOrPHn0miupJq2a9OA1HGXrNTwP8Cya1JjDTPShw3zCUcVEE52RwphFlbIOgIQHzZEsX53BT
	5yxARxf+Dvu9pbZ4GQ73XLcsCFtoYhn1xrLFReEUe7BaBniijCPlkX/Po=
X-Received: by 2002:a05:690c:45c9:b0:8a9:d5f2:f5a6 with SMTP id 00721157ae682-8b3a814ca04mr34671157b3.67.1794493549077;
        Thu, 12 Nov 2026 06:25:49 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3934592e9sm69600597b3.40.2026.11.12.06.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:25:48 -0800 (PST)
Message-ID: <e8f6cbb1-8324-44e8-b703-d7a29ae7fa09@gmail.com>
Date: Thu, 12 Nov 2026 09:25:47 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Fix segfaults on settings given without a value
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
 Colin Hinton <colinlewishinton@gmail.com>, Matt Hunter <m@lfurio.us>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2026 5:49 PM, Thomas Bachem via GitGitGadget wrote:
> A setting given without a value, as in "git -c foo.bar" or a bare "bar"
> under "[foo]", is passed as NULL to the code that reads it. In these places
> git does not check for that and segfaults:

...
> Changes since v2:
> 
>  * Where an invalid value is ignored, a missing one now is too, with a
>    warning: remote.*.tagOpt (patch 6) and color.blame.repeatedLines (patch
>    7). v2 rejected them (Phillip).
> 
>  * The test in patch 1 rebases onto HEAD~3 and checks the result with
>    test_commit_message (Phillip).

I reviewed the range-diff and found it reasonable.

But I was also happy with v2, so I look forward to
Phillip chiming in on v3.

Thanks,
-Stolee


