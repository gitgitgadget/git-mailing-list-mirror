Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D919E968
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911219; cv=none; b=eLYFdeyqaYYCOeqo2aJaIgOCXgc5oT3M5ukdJhyXfdOb8cn9ppmLIkE59OJlQCKa9zbTSFCg1J2qgMiwqYxnNHLrbIdkCx/Kbmo3ZzXBGojG0M06plOYyBDQ9rGWsZwqNEoEqu7uD0z8+GfkShuCIq+VeO3OTg3IcKLN4yHmySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911219; c=relaxed/simple;
	bh=WNnYdajx/oIP3/K8kdFNBfbq+xfeEHgDbO0EQ7A9UFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzr1hTSOCo8W7tlaudPbeV4tj7KuMYUg9rmH4M8ytbaeLYlvwFxa6SfTKRissk4kWwOMZ+myIxyW5uOanctHWZc9hmF1ANkhUY9tzm+jG6SzPZmNtfMjsOxqtK+01+R1WjDh7KCEls1Q1KRWm63djbzIp3F1HCeyAYwVo+R/48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XDPisy46; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XDPisy46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765911206; x=1766516006; i=l.s.r@web.de;
	bh=QJ3cb141bz/K5mNEsqVj5vtIyT2OmC2qm1+/Dpd9Vpc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XDPisy464cLphp8/I7WDWkJnFseOoKJp415lHe/fAe/CYMQNdbPhfD9fQpiOQtnt
	 366o4kuRN+BH53VeTMjp9k1UpvNm2+u49SSx8C5snxbZ+1ULnVS9QlWW28AXlf3cp
	 WKwW/6Vsq/93WsMmM0BiUkEKf0KvWnrbun9Jv9a5XEAWWbPkbmSJr7SwQ8O5cZv/u
	 b9SFu6TRyTwxGlAcHTT6aZrQs/ZZlKKLs5oTWLifkv6z+difDUFkgcMeLmQSQnGDA
	 eS838BhN5AhfVdT9jPNLYLggkskJQ9bRZXtvKvWbU4S2DVkgU6CRRqfh0afNy0ZMU
	 GdkAIgB72t5cUiiS2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6bD0-1w48aZ3il4-00wN0R; Tue, 16
 Dec 2025 19:53:25 +0100
Message-ID: <ac1d3f6f-d95d-477e-9536-7d7903c10553@web.de>
Date: Tue, 16 Dec 2025 19:53:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Makefile: add NO_HOMEBREW
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Git List <git@vger.kernel.org>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>,
 Yee Cheng Chin <ychin.macvim@gmail.com>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <fe00aa37-e929-4ca6-ac23-84a693a48bc6@web.de>
 <20251214064544.GA26358@tb-raspi4> <xmqqecoxa645.fsf@gitster.g>
 <435e4190-6c46-4404-b769-234f704f608a@web.de> <xmqq1pkwabxe.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq1pkwabxe.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xEo6j2XsQ2pMwvOq6lkHvH8Uo3gHouN2wEYtOKU64kYucXsBX4f
 4z9mTwuOwut/HtTWVHVOGTQ6SDE2sjp0FMYUs+vePIxQviDPO11KTQG5+kPXpGNXtDPDNFR
 5XhNH2mcHvB0v49ku1JMY5fam6oLG/mSkaQrGoXH4+EUpG3XKu4Rq4UdJ+xnw4uw2yUIKNY
 hDD8ejOJkwPUWjjS59V2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xzhbt1PS2Z0=;dEH32yLBPiBmoLpgDXVqcBiKvGb
 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
 x+o8h0QX8jkfOj2p0=

On 12/15/25 12:19 AM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Sounds useful, but before this can become a documented feature it
>> deserves more research and refinement.  The current code uses what it
>> can find in an ad-hoc manner, and the patches just extend this behavior
>> to libiconv.  A user-settable HOMEBREW_PREFIX would require a more
>> principled approach, so that overriding it affects the search for
>> gettext and libiconv.
>=20
> Oh, that is so true (but the specifics in macOS details is a bit
> beyond my depth :/).
Similar for me, but how hard can it be? :-P.  v3 coming, but needs
thorough review and testing.

Ren=C3=A9

