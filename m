Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085620;
	b=1KIi8XFP/CSCEyJ/JF3F919qEKjEjyNNiDyjieCZxzk6J4tKEsC42ZpLIDLGzDGrcASs
	 dTUWivbx/jzN/onKo9pl81IVTk1Du89BhWrcW+E+c7RiXw4hL4SwKmecvoTzsN44WGPCP
	 6BCCC9BuUJV0vit8CeZ2sJbie5D4RkPtnbUIGcg4Okw0LZg1kpxuoipoyqHCSgvlcSCe7
	 gMe4mhToTod4K7rBNzkQTDV+aBWgt0b/Xdrw9YQn0lx4MtQpNWyld0JORd9ESogRrSMcM
	 jYa7EUySsnL8338BBHHbSyE+LHz3RwRVwa4DQanbgDFYRrPVlOdgtsByJ/Tma/SpiZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RLXg1m0A8FEwfKOwMc0VkKK52RFkksA0rgidhh95lgA=;
	b=Up0VsoiwVEwPvYJto6CA5fpZiOp8yweytUJGZipUbX3+RePZZ/KixaGYUhGz1GLzl6Kw
	 D4i5+l5qzlzcUwS16qqCc+KEPxd+k6kuSuv/lWu+VUbPvdaSyPpLgcZzFOsaVv4PQ4kTX
	 e0bmCtm9GGqDztQMzHwYBCtC0QQk0ZKBa+mH9+MyggE3GBCmlL/EUtw5iqtrS8ROE7Dw/
	 rPCRzcQZm2CinGjpGorUEsZWWysCIS/WsVGHTEPEZYyut3jrWMUBHVjar00x+H46m2QH4
	 iDl1Y545845nnep9vbOlh3ZnjLvzCw4vEJuu17y+XSOQIyPrYIFWu2FTzWAbg+11y9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHjUkbvg;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4063606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 10:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4063606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHjUkbvg
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492f563d1c6so777048f8f.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 02:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795085618; x=1795690418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLXg1m0A8FEwfKOwMc0VkKK52RFkksA0rgidhh95lgA=;
        b=vHjUkbvgz5FbDe7QIoRAh29eRO9aIoDoprjkR5zBpDQlc9r41QGlbuAe+BzEMhILcu
         Eno7UCoN9B1GYMHh/0OihN/LHQLU4d2bmoNxruBPdfCb4R9NSTLJgHOQO/5cnciXmcWL
         C/vW64UAh3ZKR6cBiSFZtELQ3nThmyN+QQd9DVy6At+XWVzIdKL/7TP3CxWZLLHqYvoc
         n34CxFqCp9+6N0zqEsNfKjeLLRtVHAdL/yf+zJAICg6aUtmFSqG7Q6HpuTBJGb9VD34/
         meYstMFIzNgSX5ye7xsW6nhhAAfW3Ul3phhHKJs0FcLAYuLVXE9FRKbEu7FzU/jkhwMI
         fvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795085618; x=1795690418;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLXg1m0A8FEwfKOwMc0VkKK52RFkksA0rgidhh95lgA=;
        b=bicA4feFW6q2tpsthPeedYyj79NVYaGQQGiSYnljRQV/Ji7RYL8G0KMnaYsafp/QjP
         axA6kolPYO9N18rmasT9rEFWBX2HPbUJ/fPFMxemoJOsH+LOHPzFOFDOFu0LWA5H1TYj
         ilE9m3THfaL/1qCpkCBWgHZTgQC0k6JMJ3IEclOZFi44T9fxppmqr9gJ0YloR/udYFwl
         8Jxa5/LHqv1hdUbIpTM78M5jX+P6T7PT5GKLEzjf8KM3GZQW1gKhv7Ny+nAPjQ50/lHW
         ZGMIu0zEXHjvA3h6/22Hhy2kzECqoYY+CCjS2pS+lOVgqJ5+OaSHs4s9TcZSR+TFb+35
         QdzA==
X-Forwarded-Encrypted: i=1; AL+hErHMwnarCVA0xqiCf5flNG6x+JxK0ihJca6+2OxIf0uH/YBG9UvhEhKpT/+IM4qwSzQyQP0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ff9Q8cb1n5uI7Vdi0pyVMFYVO60EapJ3TnzMMBqcOvuAFWijA
	CLOLly+mK83YJlQV3Nkv5M4QaMweQolC9xHOgyAWg4z2YgSHCniBDK4E
X-Gm-Gg: AZFdTZcBhSUy7G+g328a09gRSjFXsYkHNs2ghyO/8jQcvlFTYSYhEgeqC8SbekV4MUW
	xsHf9MJ9V9sXMTy7HCBK6+SbfyvCG5TIqjZpYr55lUtxxNNOKYHTAsa720CTpPKSCt+lw9SwZ3Z
	gSPU7gfbgvaaKvqh1sxm0lpL0Og2uFEznGGIBvg5yi6MeJdTm9OiUmuWJmUX1IkT7t5iGbrK+Jx
	ymR7w27ZA1sSI+L7Km6FXRxD2VRgyAlFpRh4xFydeeXUA9YsLaefs3rvSfWCvwd2CW8WGcQbdqb
	RMaaeFGe9SR2FcbihFhcGOrqJr5EOkTSNb7nEwUV5xaVrx7vTKiQnm9n2h8uNR1wYCG60H+/qlh
	yAgpuCUCr0V4nbO/Kh1nFlD9fGRy6sBkG+xTKuMGuJyAO57YwS5ZxdaTFypWwpmmoysd5MEu9wj
	u1CeJOG8rLCCKw7ZJYCq0qVE6FYxpYM7gHNGHZN6XpuxIT9vieTphn05OA54LCPfp5B4Mz9cgel
	Jsv7m/DF0rMui9+v0JCxCyWGR1y31tsJ6Zk4pqa1NuMpF2hOKTlvJKooWmhN0oYLFj9K90mGfzm
	n/QjcJz2x3l6TAKf3u6sKpqm27aTDLlVNdKw4HXrcSUtNOEAY4iW+jyJNtsPmrmglXpLoqh+1x9
	d4wNQ+Zs=
X-Received: by 2002:a5d:5888:0:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-4a63a1e0211mr10555944f8f.18.1795085618270;
        Thu, 19 Nov 2026 02:53:38 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65100c6bfsm9669304f8f.2.2026.11.19.02.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 02:53:37 -0800 (PST)
Message-ID: <2111d174-9571-4eb5-82cb-92f5330ae24c@gmail.com>
Date: Thu, 19 Nov 2026 10:53:36 +0000
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
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v14 1/5] fetch: add remote.<name>.fetchRefmap
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Matt Hunter <m@lfurio.us>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
 <c63699b40228b1d47368778d7397b1ddc6ba2a36.1794681496.git.gitgitgadget@gmail.com>
 <5a1a9f6b-48c8-4daa-9059-bf9459587a17@gmail.com> <xmqq7bibh3f5.fsf@gitster.g>
 <c40477c7-e1d8-4af1-859b-b739dac4bc86@gmail.com> <xmqqfqwzcgmu.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfqwzcgmu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2026 21:06, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> I can buy it if the suggestion was to allow passing --no-refmap from
>>> the command line (or would --refmap="" work?) to ignore .fetchRefmap
>>> configuration, though.
>>
>> I think --refmap="" might work as --refmap overrides the config and
>> --refmap="" is the documented way to ignore the ".fetch" config.
> 
> Do you mean ... ignore the .fetchRefmap config (not ".fetch", which
> is used as the default for refspecs and not value to a dashed
> option)?

Yes I meant --refmap overrides .fetchRefmap

> All that said, it feels much more flexible if a refspec with a
> destination (whether on the command line or in the configuration)
> simply ignores the refmap.  In other words, the refmap would only
> apply to refspec entries that lack a destination, leaving elements
> with their own destination untouched.

I agree

> This way, we won't have to worry about what --refmap="" means.
> 
> So I'm completely fine with going in that direction.  The only thing
> I care about is keeping a clear one-to-one relationship between the
> configuration and the command-line option: the configuration sets the
> default, and the command-line option overrides it.

Great. So I think we'd want a preliminary patch to ignore --refmap when 
there is a destination on the commandline and this patch to be tweaked 
so that

     git config remote.cabal.fetch master
     git fetch --refmap=refs/heads/*:refs/test/* cabal

and

     git config remote.cabal.fetch master
     git config remote.cabal.fetchRefmap refs/heads/*:refs/test/*
     git fetch

both fetch "master" and store it under "refs/test/master"

Thanks

Phillip

