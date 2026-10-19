Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429875;
	b=yvCN/09ow9NdZBBVeMYU3Vhi6gkcklBcmy9m9Ygo7ZWDLbgnda10GjuMGmvcX1OYl8uh
	 yhMQpL9G0GIzu4iSqcgnpF1lMo1IN7ChpaE2z1I0TTPUdBlxji29fgr4UqQC97mQhcBoy
	 hMWvjGwCriT8+pteRHPtTf9GdN2gEgL40ITpK200MZ9C5ECu3DTnIVBQjkk9RZVAAedOq
	 P31eHl1B6Db2gNVmrTvDKk5GxEjDNfTFfcCnFIsn8X0AjnV0NMzU0miegkx17/TWUKrKm
	 jYv3cABl+oMyLvg7n945nvVhWddcxW8H3Svg2k9rEN++RxwdGVqsy83P9Z85aEzV3Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429875;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=pOInXfzhlCP7WdImxseDhjG1S63cos0GLSdtAXec1uM=;
	b=DufIxi0dk4wY6aiq8GGkJItVnR64uD1i+R0FU6IRgFXW3H0XIGVTymB91/sMga+rwTBT
	 R4GPT+DzJaZui5eBwaCJJr+NeN+6NAn9VJrtiPx3KhgiZjP8UzMCeQVUbacA5VM9J6oSJ
	 NJQ0d7ICUYLzCIJj1V4pvQFjCKHHtQu33GNCcMi6bws9tpHMS1VBogBidR468tOgZLmIy
	 nv++0UQc6xZCcFQsfQzrJiSKMua45wNEeLedQShFUZC7pu8HAMFVYQG2346/B4JqA8BGi
	 bePFZDrVwcxcwdG9W4x5iWS6AM+lhXjZBVvbGEvJJ8uWP2DUBLaaMDWKuRSaNQfnoHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=a1v3eeGm;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22C606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 17:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A22C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=a1v3eeGm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792429863; x=1793034663; i=l.s.r@web.de;
	bh=pOInXfzhlCP7WdImxseDhjG1S63cos0GLSdtAXec1uM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a1v3eeGmyUPYRnAZ/KSWePWZi6/TLSa7C8ntIJVCEKD2soWOrthIiQea4hfT4QNj
	 MgBtz0rxhrwXT+AL1sQo+Nx5I+KAJYGCiHxzkni2oKQZDJGqm4CNtbHLCaHIOPB8q
	 5X76SBarNbE2fpMq2cG4awGkDcJryAfD2cDvHrn2rIBrqrbJHAgGNgwrwVUhmdykK
	 WtonOjtW/6MY3pHwTUli67Zti2U5YrOOu2Lz09IkF5I2AmmvEuZ37X1AikjLF6R8y
	 6gYHCbTlZeiHi1KvBAaW0Hmnqu/wDmw8nhvgWFMdw3mnnZtNzUNN2NRk25qkgeb/+
	 UHvdHhSfMPEtPO8uLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0ZsE-1wMddL1iD6-00wVTM; Mon, 19
 Oct 2026 19:11:03 +0200
Message-ID: <c873cb77-10ed-40fa-b1a1-b3e01d341bc3@web.de>
Date: Mon, 19 Oct 2026 19:11:02 +0200
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
Subject: Re: [PATCH] archive-zip: omit UT extra field if mtime is out of range
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: m@sph3r3.com
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
 <595dafac-33c7-4c45-9cac-c868cf1f8bb0@web.de>
 <CA+h9NxRQLP=20kfmSm6B2WtkkmHDCfdRDZEawOpzFF1LoghTEA@mail.gmail.com>
 <0334c031-56e3-4c8d-8adc-52051d2e26aa@web.de>
Content-Language: en-US
In-Reply-To: <0334c031-56e3-4c8d-8adc-52051d2e26aa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:75uqitWEbZWzTHAth7AwT1cjXic2Tw91S97DhgG0/yfmc9p72dK
 peXQ03y258UQLDimm8oj1jGmiAYJjQ0H+YxHRkq/FWhnb+MOp/9qxtBcO/pw9sCLufdrGc8
 Y1WDwLvZcOL8bHP2s/vAltKMqVUOxAe+zXWWvG2vRTtD1fHqPYuHRzJdt0EOlERu9yda6H8
 U7Q3gkjQaHQQXWbhW69TQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XAcyXVyJTNg=;nL5oICHheElIDnLnQovtoYP0+Le
 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

On 10/12/26 4:45 PM, Ren=C3=A9 Scharfe wrote:
> On 10/12/26 2:56 PM, m@sph3r3.com wrote:
>> For the i386 failure Junio reported, the beyond-2038 archive test and
>> its dependent omission check should use TIME_T_IS_64BIT. TIME_IS_64BIT
>> checks Git's timestamp_t, which can be 64-bit while time_t is 32-bit.
>>
>> With that two-line adjustment, all 18 t5004 tests pass on x86-64
>> Linux. Forcing TIME_T_IS_64BIT off skips only those two tests; the
>> other 16 pass, including both INT32_MAX checks. I haven't run a native
>> 32-bit build.
> > That would be an easy way out, nice!  I suspect git archive should not
> even use time_t in this context, though.
Getting rid of time_t in archive-zip.c is possible, but would require
supplying a 64-bit version of localtime_r(3) on 32-bit platforms, which
seems excessive.  The task would be simpler if we picked a time zone,
say UTC, instead of capturing the time zone of the archiver, which is
questionable in the first place.  That would change the output,
breaking caching schemes.  In any case, getting rid of time_t would be
too much work or trouble just to enable two tests.  So right, let's add
that requirement for now.

Ren=C3=A9

