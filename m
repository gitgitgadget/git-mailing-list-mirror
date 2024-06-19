Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD292125C1
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806802; cv=none; b=RVVyTpMDAehK/WVoaWAMOw+fTjUsTuUSv3tgtARl6VxPN8F0oS+tzwpet6jp8e3/aJJbSc6zjfjp5Lz5AinXc2P3EHRQJu0Q9fxeREScFZk+fxO3gLFl/PxDFN8Ctb856aNNI8Xa0ni+Yj3ztU4kTLlStLr/P+gXkU9yPCV2w9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806802; c=relaxed/simple;
	bh=NlpM2j4rG8S8krk1CRaMo2CxOWChuYhMn2rCM2L4e/M=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=q1J07FE1c/ePYHKLW9uRqBAOPGxoJYAOoKm1r4UwC+iCDtDclF70JjBBjqBY2e3C07lLM4/5lQBu9PKqz/0B5O4Hkr+BBo/cni7ITjnSuqlaBZrD/fkSllfDYHZ979Z8WLcQEe2UVfDGH3ci9i6wKMm9xthG76l9MLOjHNuEvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=lfbkbFYg; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="lfbkbFYg"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718806797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWcY9f/ZCtcpxkXi8X+Nt2X6NhQqCWw+iLnURESnaYA=;
	b=lfbkbFYg5OM9ukZ/SZhdecTp/5lztb2eJ3LtBe484VkWaR/kKpBUFOuz7HPcAwuySqPaXe
	iXH4gEeWalEeGf5c9pePfGCkA8lvssiGVra2FGnW8N8cJDO2eLXvsp/6LRiytZpJMhk/yb
	rkBh7x1S9FV4PBHdn4j27gpc58NMcDlfMrsPpqnlxy08whZMI7wJPtE5HUtjPCdmTu81r+
	mvP6cSvwpS/nadB1u7xTZoIvyllAQjIA8u1uJGGfYrSxBZpq7e2hFnMcSKaZjfSe8hIteJ
	nXNpWw9x9TibC9fpdSy7qRZIPJIm9mFNw380G6kMruK9qEL5wj7+kTH/iAUlwQ==
Date: Wed, 19 Jun 2024 16:19:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christian Couder <christian.couder@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, Junio C Hamano
 <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai
 <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
In-Reply-To: <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
 <0448495385b009f25a66b0712afb28f1@manjaro.org>
 <20240619134533.GA943023@coredump.intra.peff.net>
 <04b714d3e949c30bae0e26231e923fc4@manjaro.org>
 <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com>
Message-ID: <4ba6dececcfb3dcec5c8b7e64657a1ff@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-19 16:01, Christian Couder wrote:
> On Wed, Jun 19, 2024 at 3:50 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
> 
>> > I don't mind if this is present but disabled by default, but then I
>> > guess it is not really serving much of a purpose, as hardly anybody
>> > would enable it. Which makes collecting large-scale statistics by
>> > hosting providers pretty much useless (and I don't think it is all that
>> > useful for debugging individual cases).
>> 
>> I agree that it should actually be disabled by default, for privacy
>> and security reasons, but that would actually defeat its purpose, so
>> I'm not really sure should it be merged.
> 
> One possibility is to send just the `sysname`, described as 'Operating
> system name (e.g., "Linux")', field of the struct utsname filled out
> by uname(2) by default.
> 
> It should be the same as what `uname -s` prints, so "Linux" for a
> Linux machine, and might be acceptable regarding privacy concerns.
> 
> And then there might be a knob to deactivate it completely or to make
> it more verbose (which might be useful for example in a corporate
> context).

I'd be fine with advertising "Linux" (or "Windows") only by default,
because it doesn't reveal much from the privacy and security standpoint,
but allows rather usable statistics to be collected.

A configuration knob that would allow it to be disabled entirely, or
be enabled with more details to be sent would also be fine with me.
