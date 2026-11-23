Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453447;
	b=LngkQ5AoMwCm1eoRoegops+4JBX1eZkVzi1s9FCVbXxpo6hc8YjR6NK/nhOGuPaEDr7k
	 o35uAbYcB7qt91Nah4ST+BLuDEgvu33yG9/++fxkN6PlGwmTNJDP25abh703bVzj+GeWp
	 KgYQb9g6hGoQq2U23edUM7OJt2ug1S/CIrPHMRprSWVOY75AISKVDR3kIIaMpBVe3G0Um
	 ugdS2WEGvWB4QQgKWym06y54oa+EETW/Vqtin9UiYSRyJ6UV8J4I86Xte4GfezVbYuvIB
	 4xbnCUWxIx4HUQuRAKiDj5dxKymEXei2crvtkRF5/cUKit1HyvIl/qoxJ8CoHAg6CnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453447;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZciJunUvVjFfomIHmGOWJ1PHXIdiKPsAqm5XbxaZJlI=;
	b=TfV5YK6+wY7DkCCgIvrsoYlHhatzfSUAs8Ur5MYtuz5n0Ld5duiGBeBmZCyD/RqSLgVN
	 vMyZIyCaMMVPlw93vYwienp7j5ey7epaBh9/1cbMi6dV60c4Jalj1fgYKOWGmiKBxH1Dj
	 WgFpCxvLxB2NaALkDRsfoYMUsUXYFpqo4b/1ucSiMBiWi8F8N/N9oYI8N9r1pSM5WsLLJ
	 1vdZRCdy42eDCC+f66P5gn/atL+navGkVSFAs5WWfVWtO4OzwT4N53+/4UI+ziYu+kNJL
	 +xPHz0S2K+JAs4+mUzW8jj7lCdNP39H1HVFzZIzRoit3YxCB3blB3bsxV5/Nd5Ow75g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gsseH096;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ISDhw4dM;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67158606A32E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 17:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67158606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gsseH096;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ISDhw4dM
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 989A014001E8
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 12:04:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 23 Nov 2026 12:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795453446; x=1795539846; bh=ZciJunUvVj
	FfomIHmGOWJ1PHXIdiKPsAqm5XbxaZJlI=; b=gsseH096hFO6mfif/o5Cvp2iZK
	E/GHvttKCZMlRuP5gDqerajFFy+/W3hyBsN6exw7SS/m/kI9Kim5N/67xCyriP9B
	jKhFElHW32koElYtACT3ZrcFTQsSVhbfD5udtiZeVQA1XBWMQ3gprKr1HsAzpn82
	QBg2+hTpNBjMFB6HbZIdpSQKPpL7hPOO5gQcvYlIhBHQLcz/UBgJNBd7OcAXT163
	e1cvAJjldoZ+nAmBhXaxPiKicu4m5EAVVPcqCMyNlRNz+WY62nnvlwgZrP7Jdf+I
	MnlRmh1cquUtVSyElBtVCnS43cm9FmLGmO3kSa4B0SavADSY3nFcg+2xnBXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795453446; x=1795539846; bh=ZciJunUvVjFfomIHmGOWJ1PHXIdiKPsAqm5
	XbxaZJlI=; b=ISDhw4dM6tYPwZcaUj0Vv2LDfQKrwBGavSVNdDwXKAh8uMmP1Yr
	KCgKL6D6b6KPHQiA6Lr2JWPQ9FWD6zP1b5c1yiXa4HhwPBzKothDckPkugkdc9W6
	l/NAsWGWrQUGEAaO6PVhY1yEVuJGxiVBEpmga7pgd7h8KwManLEMOWkvz+NfIfG+
	e6qU1bRSRWfTyXnQV9/6NNKA5YbC5KdUhB2MMqhwA/+MG5ePwR1xN+xH+21vo4lB
	6bBGW+8kqelCfUjyuiFfljwY1FFjpGqyna9Y/bR9n+g3erjZO+hq4LwrCqvb5CzL
	vt3cevcxDvwgacQ7EJBzMedUutOlCuEt22Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795453446; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bBP9NyIJAZ/zUQPvia2h+5NMHm6IPw5Pfp8Q1qviKqcytin
	44e20+PePSpFlAgnNLEfTjdt8cUJ7jTueg2zhb2+VD2o2h+6y9c5Tdmuz1DCaZlj
	ApyT+DcRIY+24tbA0h+yWWF/RBvl372ZbZgYz6YO5OdalOHtNDM6c/oN/YhEliT+
	YaMt/IARDM+pLf42cA+jx76qgyoCK2JE+IKfPGCpY3AECJUHsMWlIIaLs9fp47xE
	5EhmautDY9bpOhBBQo2xmiGTVgxaVnI2CkC77X8e0/9q2hBiOhAkygqWsdr7LI6z
	M9ok3QZBgUgVkybCHuKry7yNbSude2Mk5UV0rog==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZXSCe3v4MH0XWB+953fTHtJJhslVLmA+W4p+pL9g1Qs=:FdhuqWSaZ7p59m7JNCdSm+hZNp/gcdnh5gY7o7Gp20c=;
X-ME-Sender: <xms:BnIEa2W9macjy8JlQq3drfZfbQjG0oLIyoZTrV31E0cvPIrdqbekPA>
    <xme:BnIEa5ki6Q5e0z7qyqJf9tlZOg1pIU05m1ibetAjXHBT5aTlcmZD44qDW9-AonamU
    LmYUryxTJ34k-AVSlwFOdS5YV_BRIZ2Hj1mJLbCto5SuCoTvciIeMo>
X-ME-Received: <xmr:BnIEa_Y-T8_u0tgLPg6Ebqg1amaEAoECKvPAHJeUgpI_7SE4zXKZ1XhFCsvz9Xn7FOA3V1N2uDXhA55yLcILH8dHORSkiF2Ls4_-XMk>
X-ME-Proxy-Cause: dmFkZTGqVX4nHox3mtCp+tien1r3yUqxBayPHOuhuRmYDIq+bp11J8ee+XY+Y/maYLv6hK
    HjOqSg7mERPXZu7R5zfmC8eDl7OdNjzfIFBadJjCVeKSReMMZ1W0n06i1bi5FIA50epItl
    llgWw6KllsTfBQMsF0ZT6/h/bi+Cj1V5Wm3TwtrG5bWB0mzLDUJQfZGxliFkWe6h9ZxVML
    sQrTlAoVuiCIAeWRCAIPJVq/oMZxXRhWqcthxNFNZPX0PdYQsDxgtRLNpsxFh6fqGLLslN
    1giIXCt7K43i7hG/1u5cIpc41Zjs7xdwhzk1wJdNYsF6pZEU0JkKEeokRXnknMuzatJrg6
    xeQa2JHSlZAsPdN1fACo2rtKAcMlRURjg5XnOGPOlFdadiPb20cBCu4mFJY97Hq8PVvp4k
    Y6MTa0tr0R95slVHK3dkphARCH0YMhKptIpao2hLmfVIdJF255vDGA/1HCa0EJ75OvZl73
    gWdnnprkr8yPoUHZ2u5sw/oJmGsgK9/LADmGRFaUBpHKjFg/+A+3Da3e1/kt0uIcOdt4qL
    +o5cQPcxyilhjL66GXc4DzKDp6t79KGQO31VCr4oZweYzUHJVqEABv8ASMFQzQtwNKvTB1
    U1OyjHZPCj/TwojrdII9G5MSc7jl37TQzB/kuV9ldmWWFXPs1NpZ2zQbQJSw
X-ME-Proxy: <xmx:BnIEa8PgNq8OnbPYbuW7Wy4xgx0_U8BUn95MDl0KrNNAAw1_4QL50w>
    <xmx:BnIEa8YaUuP5eteYTIG-XRpPGSyTyQGnUYK2n-uqhJHVGJn5-aguhA>
    <xmx:BnIEay2YIT-0V5XuOCHiLXiY690Qc0npRM0nBQ1yYJ6g1gM-r2RBFQ>
    <xmx:BnIEa6dMbeeU6p7n3Upre7iqBkXhMAOv5GCUqar-6mat8ynGG0_slQ>
    <xmx:BnIEa1aLJx0i5hvDhLN57MLgM4QYhYNCVHUWHQpCWRfmLKoIzRwhkc0S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 12:04:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v5 2/4] utf8: fix comment for utf8_strnwidth()
In-Reply-To: <20261122-master-v5-2-313bd1bb3c45@gouders.net> (Dirk Gouders's
	message of "Sun, 22 Nov 2026 15:51:25 +0100")
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
	<20261122-master-v5-2-313bd1bb3c45@gouders.net>
Date: Mon, 23 Nov 2026 09:04:05 -0800
Message-ID: <xmqq5wxna396.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Dirk Gouders <dirk@gouders.net> writes:

> The comment for utf8_strnwidth() states it works on a NUL-terminated
> string whereas the string is bounded by len.
> It also states it returns strlen() for cases when the given string
> doesn't look like valid utf8, but it returns its argument len in such
> cases.
> ...
> - * Returns the total number of columns required by a null-terminated
> - * string, assuming that the string is utf8.  Returns strlen() instead
> + * Returns the total number of columns required by a string terminated by len,
> + * assuming that the string is utf8.  Returns len instead

"terminated" -> "bounded" (the proposed log message above uses the
verb, and it sounds much less awkward), perhaps?

Other than that, looking good.
