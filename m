Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808795;
	b=UBxlgo+oSO3cIAOpHcu9o23PnWLb7h73KUzpwEwlqLSUCCFZoDDcN1+wffmU6MaLXCjT
	 c/tPm8nvRlrltSNrMA8XubD9va/jhjsc+UmEYkbFbSBWD8jDreShsA2iDGWPNa+TYf4rz
	 RaspoxosH1n5HnueI2mnfhgVpx0wfEp93q2u3oBrFqieoNsOnQ47KeSrOzy1rzHgeJnY8
	 WEOTh58jhD0dHYJWiteq3kq4hdIhaFNEvB6zaldwXJfBUTSFj7yRgfnC+V4oEgnb6ovyS
	 poHhrlnZZQ+dDh75pBxw4VgxN26NchUCBIpd6/I1N/8s53CZQK7StqsksCr0jdDWZ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BAU7P9jVZyJJebTJ7suoJ6RtffvtpwKQYNh79iJsCC4=;
	b=Pc2meZB4cR9jinwWNbqPAGmip+Nmlhy7Vfdk5hsb0KRO1zpOhQRHochS8ZM7TKzh6Iq0
	 xAiudKfvLlgQvpJ4dWpbk5x6+coAFMPJq1q47iYYCiA7Kv4hF0OK9F3JzbE5vWB0E9ABg
	 JEWjY4ZPghTvqRI0gEYAhDNdN6TJGFKiUlLCLQ3QMp3dZwqLCs/i/oAes8BCUYcKoDG5s
	 XU0jFutWU0RwbecBx+4Vnv88e3HwiLEDwB3R8GePjbTkM58GWokPa4qnNWb1arV4jYhoM
	 bJFNP6aH7JyzNlUWxDHhb9WMg6fxkEnZ4GE2bZz+BguvTbkVgDzDQ7S8lR6yl6zLnkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teupVV5G;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD3606A335
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 16:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38FD3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teupVV5G
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5351d76e1baso8288641cf.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793808794; x=1794413594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BAU7P9jVZyJJebTJ7suoJ6RtffvtpwKQYNh79iJsCC4=;
        b=teupVV5GWKDSxElUeIbcUG1vrTiJb8b+VJkMOcIiba7rim9kv68u74ccvJcWsxZld6
         iF+m23WCy5mVUqIuaJ8+vnCV3k7EKZioXtuakHX+WBDTpYopK2Rmvh3Fhn6AD3zHtjCL
         BPh9cKCAZWx9XAkO6cTEnjF/SaBaX91T67rqar9y8ruh64kyIDSG/xjQPY1QojiDSi6b
         S624jFIPFQOTV6UfmKUipzKHeVRoW+YlsRWabgZczvpDSXaVpChJCoUAM/5OhwocVKE2
         AV+m3Ax+liY+aauTh7MS1ar9SivN8LXBz7y9MxVTykuB8cN/PRfhTBoT2TUUYLdPh9fU
         KTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793808794; x=1794413594;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BAU7P9jVZyJJebTJ7suoJ6RtffvtpwKQYNh79iJsCC4=;
        b=xslcV0bsfIY2RCvQkgu3M6JcUHeaI0lhMkR6GrCBVeR/NaCGdZJdRUQNK/KXtizMd7
         QBTjaP5c4SZ2SXpd9nkaMlg51vOmDTka/HeroTipzdDF0MNpEsywil34kidx/ddz8cD/
         Dc9NjPinEhbidHX8nNGuJrnjNkaL2bu80V17hI0y5nYshUwztIs26Eq3Na08Uae1N2Yk
         R3bAqkpoNfRhe2C68YacrfS2vc0mb8Gm28IWyTie/FjT9sDqvmmWHmuc9DyNo+V/FGei
         NP/FyZDMLHmQ4x+onj6TsYiKBQXLUI80S8wsNsH28ZNr8Zp2D6IPXxVrGPaJux87Ag80
         hMZw==
X-Gm-Message-State: APuU4Z8g1+hwQRwTPjlrYOp6G5LkB26oN9AXDOGy2NdBFOmkKTXglQjk
	3M4nd4tnVTvGoicxjI3aH5HJJ5hWmykYhRCNd2T2dZpMV8JLPTvqu8WR7iJt2w==
X-Gm-Gg: AYBFou3lA3Dl19BVDbnvSVNpPS2McwwJ9Lo1CLTnvtaIvkLWp28xTn6g5ZpR8NYpinW
	tZ9OLTCFUPB6I3sFIndsRZPPUxrXmQ6pKPhDYONUKAbdJdZgiaUNBN+7KaXaWSLP/++6hgLV+/R
	7t+L6G7oFY2ozsZSbAYPD6BxVJTuh+omLp17LtmoOZg3s3aUiL4l6Qt/cwWVIappMmE7oBKoZ3n
	CFn45EIAVGP8NoxVoGmq5zUu2FMDRM+mGSI7SFyBm+zdpu3Xsp2SObJ0mKK9J8EItBZEL9xxSwX
	6WZ+0L9X3dnNOMq+2TgNHFDMPmvgTTeDJ8h7lzT1NiFdnJmB9bdjmzdHRq2VGdOp+l8cXUvfwCU
	ZM/TG3J1V3ro1ADzCJw5xkHx+c1yacpK0M37nEEUcLRivauYoiM0z9U373p6IYyEYRhqKwIsX8q
	m9EIis00nGOys3BihGq0DJ0oH70TJiv48/sES9GMzz6RYMM/wBsnxRdKS3BXZeZvRWaytL7poJN
	aAonnShjbKZNmzuYcu2R6fKhlZvzbRi5SyXb196+Xw9QogThMbNGSBWqJlCzvZDfogRn7SsWomM
	Sx9WuLEP6QaTp8pcVFKs2X3LOGgciqHg+dTSKHSw/acoR+tp7m0uljOJwvESeq58gt8Qcs2IUqd
	KlPkR2yOrfa5gQbQoC9iluMU33Cl7xCGfZtafGEy0mt9NKn5rDAfO2W4erwd/zZFxMZBkWyORAo
	0x/fABH/Jz4gkdD74IRy9oFiFLJjggCvCfu4dquVAfuPVFPdcmFU3rgA==
X-Received: by 2002:a05:622a:514d:b0:536:68ca:af40 with SMTP id d75a77b69052e-54121738e1dmr302585241cf.36.1793808794061;
        Wed, 04 Nov 2026 08:13:14 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfdfb5fsm22507426d6.16.2026.11.04.08.13.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:13:13 -0800 (PST)
Message-ID: <cfa38152-2fca-4734-94df-bcac44fb499d@gmail.com>
Date: Wed, 4 Nov 2026 11:13:12 -0500
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
Subject: Re: [PATCH] repo_config_values: freeze the structure for now
To: git@vger.kernel.org
References: <xmqq1p917kwl.fsf@gitster.g> <aurSZcNENBrgxowu@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aurSZcNENBrgxowu@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 1:36 AM, Patrick Steinhardt wrote:
> On Tue, Nov 03, 2026 at 11:52:10AM -0800, Junio C Hamano wrote:
>> The configuration and settings per repository is currently in an
>> unfortunate mess.  Especially given that repo_config_values() cannot
>> work on any repository instance other than the_repository, moving
>> more members into this structure is unwelcome.
>>
>> Acked-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> You already got my Acked-by, but let me state explicitly that I'm happy
> with this change. Thanks!
I will also contribute my +1 to this. This has grown organically, but
clearly needs a redesign from first principles to avoid making the
situation worse.

Thanks,
-Stolee

