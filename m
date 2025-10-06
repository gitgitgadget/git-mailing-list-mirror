Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62E1A0BF1
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781134; cv=none; b=HHHqAshtcCgKVsW/CmM8V+aTenX2QeMpJKl7sjbhcZmdonQ8k9k1aRmXoD/L89JK5PWtbFODAMK05ANVJx0gaWQB1e2awneW/HEIjeoXEi0uCW9cUU2OIpv50qn+AclfMrjt3AXiBIBhU2m+lOkDuyHDtPBknbW0HUW6FIlRgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781134; c=relaxed/simple;
	bh=EiONWJAtwPXjIYkwf7Dd5USZ8lKZKLNsjTQvlp6F62I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOMlxsc9l/PtLjT93WIcD49VQ1vsR9K/ZghN6fimgPMJxC1J9j9Dtfw9GKgW1qiMCjdoiZTnmcmQL4y076S0J29G8FslnPzdbmpmZx5S5KtG/x66EmgEiLUDG29B0EKnrEBhjCFtD5l6neTf6DSOS+7hClLWAcIczc2Ykxconxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HvYYF5if; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HvYYF5if"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759781126; x=1760385926; i=l.s.r@web.de;
	bh=FNtGGzsOjzl9yJE2wOGvjwwsMkF9FdVmwb2xQpC4T8g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HvYYF5ifK3egBcjbkadukxsp0+JGEmLBvnutb3llH7Q8t3bxz0De71EpYTFJaC8s
	 exDD36pSyjfgyuOxr9k83PNUnIjptVkTsHPRrZcNQulDcxsRqJlcjqObqFO4Hc6jP
	 qSiBVunpuvo9w3fV/mB/lXytPrOGqcG2ULq6iOhZ3Hozb8WbKnrBivHwyyBIAVoPI
	 +1moYfeZDmU09Dh4bxggfIR1RpfvKb5QSQn1itrIURUbh6FE5vxRHPjfp9wwRwMyS
	 P4JWBZdu7d68FObuM4yrV9Bez9n+/vQCiQ+7mAz4IJ/ULZmVrKj6xIu5szg+hJ3o2
	 fPJW5Eym+KOG33rylw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9IOj-1vA0av1gAB-008ryu; Mon, 06
 Oct 2025 22:05:26 +0200
Message-ID: <4f4e5627-0804-4194-98ae-3345c992862d@web.de>
Date: Mon, 6 Oct 2025 22:05:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add-patch: roll over to next undecided hunk
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 "Windl, Ulrich" <u.windl@ukr.de>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de> <xmqq4isbq59z.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq4isbq59z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vYP3iMJPGmrrMasOhP0Pq/LXs/06BS1YFVBHUp6h6GmmBI0eQbe
 dlwpTggHN1AHG/qNHHSc9zz2PSZgZq2FF5p0MCWPEzsFjYqPZH2aG2In5gd/tCRJUrbJh2b
 FmwGIV74nprQCqVQKuHsFOrPZA1bpCcbWZOv/QbBoNglDXzASWPKm92oN2btQ3hAExywmuu
 TH4rhbBXZqj9VfyAX3FQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2OrfTxrvePk=;aXUKIdXybAWI5Q4rI22RnhM1U1b
 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

On 10/6/25 8:00 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Changes since v1:
>> - added patch 5 for a and d
>> - made error messages direction-neutral
>> - removed stray "only" from commit message of patch 2
>>
>>   add-patch: improve help for options j, J, k, and K
>>   add-patch: document that option J rolls over
>>   add-patch: let options y, n, j, and e roll over to next undecided
>>   add-patch: let options k and K roll over like j and J
>>   add-patch: let options a and d roll over like y and n
>>   add-patch: reset "permitted" at loop start
>=20
> Will queue.  Should we mark it for 'next'?

Oh, already?  Fine with me.

Ren=C3=A9

