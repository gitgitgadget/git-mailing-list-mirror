Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA361DB95E
	for <git@vger.kernel.org>; Tue,  5 May 2026 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941899; cv=none; b=ajaFbw+WNq/dMe3XD3P9SGq78Kx2LwxdwjDzHVMu6qAIJZz5taN8Dneu25/AeJn3a3jMXtLZzLXVR2kbqNw8KhkX4wMKNC/kkqKWePC7cKjSNuDgfuuY4uPO2k93eLNdQ+yw8m27cJHvh7u6YngzeW1TU3mL73VYWDE2YN2eU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941899; c=relaxed/simple;
	bh=PXkx9Ogzi5poBYWzEVe2J1bhWA6kc+iiZQ9TYHXArAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYPuCQxLSqePnpFwRlIhTNoWRwbOEKjH06hBjOScligvvxKCPfK9oZqPWskPB/1V71bgutXuLs488kye0K/mVMq2ZCBassOoNxJwpa7kqiTJWzk3T7FjhP1O9w1QnH0Y7dCDahdZjknknHr+20ZS7o9XaMH8In/Z5GgYdPO9YlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=iwrydUMc; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="iwrydUMc"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id K3r7winfZe3PcK3r9ws5wg; Tue, 05 May 2026 01:41:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1777941707; bh=9xFrrajV5ARQ248DR3lh1w1Feh2qVTfOjBFCrQQVKKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iwrydUMcMmBwCdN/Ltzg9Ss+IAu8eFW2952UgiSUabkeYG3zsz2ZZeJylX4+EgbiH
	 fdkULI/NWHvPV9cmMeyd7G3uqMTPGS8VTcTmKQNBbP8N9/eqJ5COGgWM2YgkCvqDUW
	 x+32PnvX6FWyUttbWQ4Mffqjbc3/qUOfkTqMZM7lECD5dPz4VyY2Z9TGrZ7J87TPHu
	 64t1AK7ZRd01oWoWclH04FUwe44K1Hx7ci6MbDHRbAv37nwIdYxr1FOINSNPJ8uEg+
	 Ld/u8ikBdDVWFFlH1SH3sdd6aj4X8fnySyMhdMn1ZOXekRN4VHDfyMqxZNZoFaTHfD
	 rKma4xHf8UJYA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FMy4xPos c=1 sm=1 tr=0 ts=69f93ccb
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Vputb3L6hs-xPR1ESMEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <aad833e9-d34e-4e57-a1e7-99dc0c6c7d24@ramsayjones.plus.com>
Date: Tue, 5 May 2026 01:41:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] name-rev: fix an 'may be used uninitialized' error
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
References: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
 <xmqqv7d4ou3m.fsf@gitster.g>
 <b04e98e3-0840-456d-a627-351f2378c037@ramsayjones.plus.com>
 <cccf9618-31de-447b-ab17-4fb8cee23363@app.fastmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <cccf9618-31de-447b-ab17-4fb8cee23363@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJXsZbbh9gl3HXIFLr/kgpxhaznQW1R3ezf14P5MnAdn3bmSVe+WTPrnYgjZR0oQaKvK3kd4B7W6VCdKXme5PdGrWtUR5GuFPP4xbPTT9nerufTitWiE
 5WYwo8A2ErUg2OFzzxY/LdYFD/r2SdRVJ7iIdaB9OMQQCG5e/tbEFBuINtzp4XVCR6Wo0L5RQq7V2g6SAf3+cIpLNCvIAHnXfQU=



On 04/05/2026 10:56 pm, Kristoffer Haugsbakk wrote:
> On Mon, May 4, 2026, at 22:26, Ramsay Jones wrote:
>> On 04/05/2026 2:13 am, Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>>> [snip]
>>
>> Having now spent some time (well at least 30 seconds :) ) looking at the
>> surrounding code, then your final suggestion looks really good to me! ;)
>>
>> However, these 'maybe-uninitialized' errors (historically have been) somewhat
>> sensitive to the level of optimization used in the compilation and even algo
>> used by the compiler changing frequently from one version to the next ...
>> So, I wasn't sure if Kristoffer was actually seeing the error or had the
>> DEVELOPER variable set (which is why I mentioned it in passing!).
> 
> This is what I had when maybe-uninit. didn’t fail for me.
> 
>     $ cat config.mak
>     DEVELOPER=1
>     DEBUG=1
>     CC = ccache gcc
>     CFLAGS+=-O0

Ah, yes -O0 will disable the warning/error. Normally CFLAGS would be set to
something like 'CFLAGS = -g -O2 -Wall'. (which still produces a binary you
can reasonably use with gdb).

>     CFLAGS+=-ggdb3
>     USE_ASCIIDOCTOR=true
> 
> I switched to the whole config.mak.dev enchilada and now it fails
> as it should.
> 

