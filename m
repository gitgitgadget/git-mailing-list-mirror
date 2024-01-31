Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748412F5B6
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723840; cv=none; b=RW1Cw0XHqDuzfyZCYycTh0dmJhqY/z8t9jbEydXM2nWoqXRSQd6GLx5OWTTTMKZ3ygSAKwEMd7fsHx0fFbiR2Ym6dHOxn13pjsxOBRLQ/i9qwzE7uA2otmrJYg60rk8RfpC+/0MUwjUC/MkFo3ULKs3qYMYUK2G9wYzccDOzCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723840; c=relaxed/simple;
	bh=I0r6SRmYqJM7U4vF7eYBR5zFYobHLGwMEu2rPLMqd3E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DfGkKKGBuIm37SORsNhhNP7AtiLWix0FYsdsbLl+ey+ZO5cOjYKyC2NREP4D8102VJWXo9h4Csg90WsN5ypo0oZrAmHm3PEX8iPDk4MugP9bx8adLNX+AY7ozDgY4Fn1IRMIMF2+6Z7wQYSbVIUW6kBbbWdwtfe+FDNeNkra8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4jGoppA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4jGoppA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d932f6ccfaso216885ad.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 09:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706723838; x=1707328638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s/csYaAOh7HbD2eIDsg3AzhkPa5ODVWtYd7GDWKZw2k=;
        b=e4jGoppAyzIXj6UwX61HWudEbWSqQM43bfhTT5PxxT0jOQSb9M66Ro2ZUWbajSS6JF
         PtDKEQltaYfTe1ZG0KX7V/2VzolC2vrntDCAYsuV7zVUvhkgShZ0KwiYEszBmigT/CoB
         +W0EjFtjdbVXXzIJGBaWhUDdY8SJkshHRyclpEX60TbJlp3aYPxnXtFcarKmWiOazzfM
         3Xrs7M2Uk4i0nqkLTXN0lz1SZSEc27wgfz7uJKuNSx8JVnaVcalCU9EzxPsY4akvb5uZ
         e/KB8bC9cEu+0TFP101IeQ8cGSIX1rhpzCo5UVe3TcDQ6z6O74G//rZD3G5hyHdzl7mw
         Rm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723838; x=1707328638;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/csYaAOh7HbD2eIDsg3AzhkPa5ODVWtYd7GDWKZw2k=;
        b=a0eRCfpTjRWzkyjNM0YMJp6yKMv1c+/w/DJj5KA1HXnzRvkC2o+jSPhIW83xVjGEYd
         YFWq1STRB7xAKxIVQTGvEhWE+BxnEFDxzppVGJgrlt6hg+gVudO0ZFLdBmOdhs5ZcSx4
         wo4YWX0nv++/O0/5Lv1zaByNFkHuxjUo0qBThxixKhlzgr1YSPzP6wwweHNJ+Fm5+D6K
         0ZiCjil6+TTjgowRLET+Rv1IHbiEmc/4tY1c7HYDyOn03lEuL6+0L3wQZsRy4/qwvYXi
         fY1IQsuhCrb8LNcLBL2ZS9gyn1YdIwaoOcC4dWrPU+5aOyCYqqQ6mejeqdoLMO61PqEf
         tmMA==
X-Gm-Message-State: AOJu0YysEAZrg8sZUxJn7PpvYz0C7k8CWHydftOwZVLdSo2J+vcaC5NU
	uIUTVMocEkUMvc93JHpbvsZRW1dMG2Q+eMXp9v2rD62W5LPfwR+CpV9gCc0L
X-Google-Smtp-Source: AGHT+IH0okeRqtQkZD78K5rZwENfT0G9EED9P52BomZxp9dCtiMAOxPiRc5+khdLBrAghD/js2cXpw==
X-Received: by 2002:a17:903:41c8:b0:1d8:f528:1dad with SMTP id u8-20020a17090341c800b001d8f5281dadmr2627939ple.55.1706723837798;
        Wed, 31 Jan 2024 09:57:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcAc/0yaRdnPNsttp4l6IZnNsav8mAB6/2KPt4nvP47oFbFYWyrcmD2pV40tTF5KBUoaKGC/Z4rQKRmE1zaXuqBzBywl+r5XNq2eeFmk7KilbIAJga269ielQ8PREMYjcaTS/Lz6itp+d5JrBH81DUE4LUyFULDFjuaJhPzWiH
Received: from [192.168.208.87] ([106.51.151.68])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902e34b00b001d8e771cee0sm5617667plc.34.2024.01.31.09.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:57:17 -0800 (PST)
Message-ID: <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
Date: Wed, 31 Jan 2024 23:27:13 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: Git in GSoC 2024
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki>
Content-Language: en-US
In-Reply-To: <ZbpGzAd6FGEeTdrh@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick,

On 31 January 2024 6:40:36 pm IST, Patrick Steinhardt <ps@pks.im> wrote:
>On Tue, Jan 30, 2024 at 10:08:53AM +0100, Patrick Steinhardt wrote:
>> On Tue, Jan 30, 2024 at 09:38:48AM +0100, Christian Couder wrote:
>>
>> Yes, the tests in t0032-reftable-unittest.sh should be ported over to
>> the new unit test framework eventually, and I think that this might be a
>> good GSoC project indeed.
>> 

Nice. Good to hear that.

>> If there is interest I'd also be happy to draft up some more topics in
>> the context of refs and the reftable backend. I'm sure there should be
>> some topics here that would be a good fit for the GSoC project, and I'd
>> be happy to mentor any such project in this context.
>

Great. Thanks for your interest in willing to mentor!

I created a fairly rough SoC ideas page for now including a barebones 
information about the unit test migration idea:

https://git.github.io/SoC-2024-Ideas/

Note well that the existing idea's description is far from complete and 
I mostly just cooked it up to serve as a template for how the idea entry 
could look like. Kindly contribute towards elaborating the same :-)

Also, feel free to suggest ideas you have around refs and reftable 
backed, Patrick. Those would be helpful.

>I noticed that the starting period falls right into my honeymoon from
>June 17th until July 19th. This unfortunately makes it quite a lot
>harder for me to mentor projects alone. Still, I'd be happy to co-mentor
>or help out in other ways.
>

I too don't believe your vacation is going to be a deal breaker for you 
being a mentor. It should be totally fine given that we get a backup 
mentor who is also willing to mentor the candidate. (side note: I myself 
have no knowledge about refs backends. So, I suppose I might not be able 
to help co-mentor this one).

Reg. the timline [1] Jun 17th won't be much of the start. The community 
bonding period starts May 1. Many contributors typically start dipping 
their toes into their project right away. So, you would have ample time 
before the start of the vacation to set the contributor up and going 
with the project.

[1]: https://developers.google.com/open-source/gsoc/timeline

--
Sivaraam
