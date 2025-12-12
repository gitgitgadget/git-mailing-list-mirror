Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED433E7
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765544558; cv=none; b=G/MlwgfWgUQXAjiEWJh48SvFQgOqm6jBooykEMCXWuXGfYui2DLcCcVGjlkPsVuUnt5M1HknOLiQN8TWetpYnsjNfEEzLnw/U4Qyb8OCSUgRZ34TDO3nQpocXz9fHBA2J6fGTkWWbc0bApekvzBgDhyJPGbNMSCd+TzzkhFkSp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765544558; c=relaxed/simple;
	bh=nbTato+U8SIGtev3pk/rIYnxNZqi6T9YisggPmp2f7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6MHRJP/VTnLfa5dMCFzJUHtyL1FKy5W7eoG/2wpZuRJb7tBTn5nuqiVaLRnn0O1qcBBCtMG35IxFzNncXBmbjQYlNS6vbH/KTBiPoFUz+nFmYRTiil89nu4BSVXuDf0x/BjmXTG2iW6elRX+vMlCyCbafTyUQqUhm2td4Ei5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=D3jTHLZP; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="D3jTHLZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765544538; x=1766149338; i=l.s.r@web.de;
	bh=22FSkggxylwtp6WcXBUdYH9WyLr6wpuA+fpWcTGS9tI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D3jTHLZP5+pvtsO5Cgxk0Q16dCcgSMx3bBitYpj0C1Owv7VNk9EWhqGHrRNEm6UV
	 3e4mNmaHnJ6nN6Chw2Lh1aoEAeO17BD3elxlaOVth2GYfmuawQxbT3XSj8SvQtoWY
	 oH56m/DjYH9NRXylqzDfYPf2/bNrFrVTHojBGsUvA1IsA5nPThlQKqJztMgUng4d1
	 AoemqSE1TOkaUx7M/CDZ4ZCG0Z79cf5sPzTbENeXmgJ0T7sTM+qrB8rkXwM7P5oxK
	 BaHbM5WDjxWq+eWMe8fZ+cxmDObvodt3jnnZE5SH89GzPNWzsod6AA8RX+5r+NFtU
	 HlsMXJtMjD5vdsVlsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMpCg-1vkcEY0uI8-00QFV1; Fri, 12
 Dec 2025 14:02:18 +0100
Message-ID: <f02b628f-b9d7-4436-88ee-3255e02cb0f3@web.de>
Date: Fri, 12 Dec 2025 14:02:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] git-compat-util: introduce MEMZERO_ARRAY() macro
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
 <20251210-toon-cocci-memzero-v1-1-ae916a79065b@iotcl.com>
 <xmqqtsxxg0z4.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqtsxxg0z4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:84JgaYfPHAr81/zXVQKlpe8azL3GhJXAL3Te6UroiEiWahx/mEd
 rvPFlLHAzV4H7GOaxQOsQ4cZMHIYUhPxJi3LgUNUMNjdIVlpA5NMHnk34vwSXUxHWcrxZPK
 JG63kkT6Pu18PZF0NH0XQ4f4FUesJUEqypbFyYleI3RUVM5JTOyPtBIctS/oQOAaXwSYbds
 A0/tMl95A2C6u+ejDaglw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vbZatpW7vYo=;4UlKwqWuAMKS5Oy9bSBEizx7NU3
 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

On 12/11/25 4:18 AM, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
>=20
>> +@@
>> +- memset(ptr, \( 0x0 \| 0 \), n * \( sizeof(T)
>> +-                                 \| sizeof(*ptr)
>> +-                                 \) )
>> ++ MEMZERO_ARRAY(ptr, n)
>=20
> Shouldn't we be also catching
>=20
> 	memset(array, '\0', sizeof(array[0]) * ARRAY_SIZE(array));
>=20
> in addition to "0" and "0x0"?

Good idea to match "sizeof(ptr[...])", even though we currently don't have
matching code.

Good idea also to match "'\0'".  There's code with that pattern in
compat/regex/.

You can drop "0x0", though, "0" matches it already (at least for me, I hav=
e
"spatch version 1.3-dirty compiled with OCaml version 5.1.1" from Homebrew=
).

If you put parentheses around "n" in the pre-image then Coccinelle will
remove them if present and still match code without them.  They are no
longer needed without the multiplication.  Their removal would improve the
result for ewah/bitmap.c.

Ren=C3=A9

