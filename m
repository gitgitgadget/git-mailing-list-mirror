Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187747;
	b=poGyDDVaWrzUg8WsiCVh5XkF1wiwnnFNOxX6HYim0Pu+5Fwe68qdquHwBv92D+PsD1kl
	 pufLTMCTHZWVC+8uSlFM4aYNlqZY6CCKQVKJRg0RykCh40VD7ncHC0n4inLRTib4aPO8k
	 NBiF/HdbpKCXm984BlNGlm1f/3QSrtLN630/T5yceWjJWgvUiwk4RkLdCYGlhQDn19ytC
	 YEhXoMmHkqDpBguzuX9v1EsjWZLx8GYQbLjTQCeIvthxUxECnOlM4cmwktZJZeWCOozoQ
	 5li+HZsRUViWY9ErHCL3wTDcwkwOjKLQQ/wsBCBa06+wUaQEjK9vhwEGEhoTJbNw2HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187747;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BgO2q4Y/nHW7/MRewFdSEtZWHQ1JK8hDpjAF/rg/BaM=;
	b=ywRieApd6lkVxugKjFnDQObeg0rGh2iyBZZYuxj8jjpZds+hByCtqPwwMspjf/yzoXn4
	 3m6leCY8KUOMNBfAc1rNuJi4ORBA3sXuVhfA2KM4ugnT4EBiP6IxAfDp94sR4jWnTg0hN
	 pFViX1TiD5DY4tcONudT5CF4ifgyeLNBphEn5kc2JZ92SkPKIOyihHCd6iYo8JfMbnWGt
	 tCqfSfuRZOSpUrmlFRkJpb1YA4EXgaHtcKe72YJMcvdo0GQOIAv6ez0Lf0oEVNVrtPi5y
	 5KgQXaqeCXhZZ+LTesK+yNR5MtY3O64MKUmwI+gC6xKFfDy6/6x40ODV8x4uDSM1k0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=cgn8iXw7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=G+S6rcy+;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59FF606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E59FF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=cgn8iXw7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=G+S6rcy+
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 035947A017E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:42:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 07:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793187745; x=1793274145; bh=BgO2q4Y/nH
	W7/MRewFdSEtZWHQ1JK8hDpjAF/rg/BaM=; b=cgn8iXw7Iy7RF9WcGgEczVqHXS
	t7CrmEvzW5lj+GoY+Ys5I/XGBuNgeYaRnne7ETXAS1fFbzipMJT6Nyq0d7l3V9uz
	+CdpsXYv372rOo2qw1Z0cKyvAm8NmFu5TtEpM+S0Yuj3H3K196lGfTN2qdnEWTef
	zzianjneWzPcdmWq+zfDJ2FC021yrKQFK84exQHguL1ltlaOspvj6cxcvsTsJJct
	QBm5wjd7V8Qe1/37cpy8B62ic9CSB7sX9eVelBOl9xuLnSQrls1zJio8khy2nVS4
	kCMAbh/sOHGwaJJ2liuipacaKRjTzXyMITK+CJUeKkL1/EC2jwubivJ8Bm6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793187745; x=1793274145; bh=BgO2q4Y/nHW7/MRewFdSEtZWHQ1JK8hDpjA
	F/rg/BaM=; b=G+S6rcy+K9sczNSY6i3NuM0V2VAHwODWYgrMFMcNWfH5x3Kwl58
	hV4d6fBJP/+GYnoYZ4BW5pvt1XXCgffCR9fUn7oeSNq/RuqZG2kcPVP4ESHS9kLM
	FWOcWDkQOYHxiY6JAziq3wZO4P6DrmcknQUQuHX3RbrT7i9MJzXsHup88mhddLoR
	DdbSLFiO56UJfbK6Hk4W1Bj5r+Ml49OJ5KARRytq/nknNoKY2YlEfGQLt2f10ZNT
	UvHKK8hBHsuqlp//MWwq/A9Asjd8aq8fnEc976bxUgasnc6Z42uQP/C7Y0doiruU
	ZzPBgDMBbQteqKFXM+3OBgrT82yFPmbuAKA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793187745; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ffNGA1xHAady5SNel0LdYkJuSWobKjvHA9DwCIjtWvsadZ8
	006ucY6OxJtpu9yE4ojXipGkUKwjeTGA/gI7G4U4u1FliIctsyjQmVkvXwf7b0VH
	Q/SX+XJ+BteyHV2yYqtgweSz/sgF3gGnIYcn3arkqgiPa30MSukm30SSULI2T47b
	qkgnybCgDMlNbesAU5mLCgpgawCbw4wUnLLjCiP19z9BBYiUdIjTrF6myNXrrBrz
	Bju47ku1nLGvHU7I7esMpvQa+v7f5QjZCJhj4qvtb1dPGu2/Snp+Ng32nZdwc7YT
	4rgPub0l0IaR5rhuqZ7CBEYNhGrp6rpRonJp5tg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ypahQZQ9ZuITqmCh/nkcLDb/IBf8hP8P2gd2WUMcOm4=:jA+1hS1oL5U+q7CQpmmsMmy9ShFYMFTmDBNUHhxD0oE=;
X-ME-Sender: <xms:od_havd3mikqmcUfvTRffgN9J3AfEOlE1X6tM5fZ1ahjdOe5ZTBLZA>
    <xme:od_hasHkbWNZy9gHnSe0STdeAijGnKgLvvjbn0okL9z6bbsL-HkzS-Hk47quiB9F0
    juR94Da2lYcTndg7ccerwUdvm6jFpA9eG_orjYxicRD4k-VjXsBmA>
X-ME-Received: <xmr:od_hag1fTvTG4uv5UTjH9Xci0f1diZT2R7I1Rvl1IlbFydrAc-sFsQ>
X-ME-Proxy-Cause: dmFkZTFesnVGVr51ojlaiIEPE3ZTzlkfCcirdoRvquhcG0xwODX+NhwIV0cj59u95lwBrK
    FLIDVQPBWQASVfaqIWT3j8hC4HTMw9QYn45H/1B5FftCgfTvCYC2X9T9qtH+zlTiOS6kKq
    BGGZ25LVfc3Y0FjEHTmO6gn0LWDHXnQ964M+xjt3UHK1h4Jgrk0V5Fd1M3KRTN0P9mXa0l
    7zcl51GPeXB78rVNfX9btZIVkOFI4DnNMbKBGFNnej3xRWa0cDgRkBh6Dxuj9DevJjFP3v
    JTC+yUXSvdCXoqdJcD70kaFPZ/cC1qRQx3Okr1RoLctziuOVPI0C57X3z6RWrirToBqEGc
    rOeav+N2nKVDD2VHxldld7u11noqpMc8nHrl6emtiWP+NBhxDUdHNa4m3LSxZw9ae+gNBi
    8pnirlWrcpASUjD7cauJ2F48xyD1EVIdZQocVNwteWm0s6lVHJd+ffUPo5jeZzwkj/WQQ6
    f9e+Fzz3td2k31SaU+jE2OzYShNTc5KSKNTA0sP1InQ59l/ZdC45Jypj5CPB2+vt0TswG9
    wWq+Z7oKh7sDbxP5BYYjnR9/P4p7dDVXEnymIFS+BhTxVMqF9+HFe5tqixi5V7OCRsbI6/
    fkBlnaa96yaSXilxMWsAuVOBNESFoahZL/4VMlAUsbExXZkQOHiHx7n9yPPw
X-ME-Proxy: <xmx:od_haslQYdpF68OSq7dkSzt9bBJ8iOKqife9d0AWOO5lnUFY27KKFw>
    <xmx:od_hao-4ZWYEX8vxB_UHSnaWRSKsLyeCkfsvPzemjy2Q3HDzsNWamQ>
    <xmx:od_happo8Cb32l2fhrKMfASR6S9iOJ2CssYoeUeLXr5es69yVDjrKw>
    <xmx:od_hapktiOI2JZ8aQAOYyOWV9HLolpVr6bNDrc8rU9nguVHXcaI7dg>
    <xmx:od_hapGI836V7iVT4EuGX6nYDBDvAKdjs2eL38xUcDY9NO-AoMoSQPPp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 07:42:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9912bf96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 11:42:23 +0000 (UTC)
Date: Wed, 28 Oct 2026 12:42:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>,
	gitster@pobox.com
Subject: Re: [PATCH v5 1/3] transport: add `transport_options_release()`
Message-ID: <auHfmzP3aXyonp3C@pks.im>
References: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
 <20261028-799-shallow-fetch-with-tags-v5-1-7c43cc9ae810@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-799-shallow-fetch-with-tags-v5-1-7c43cc9ae810@gmail.com>

On Wed, Oct 28, 2026 at 10:47:59AM +0100, Karthik Nayak wrote:
> The `git_transport_options` structure is used both in 'transport.c' and
> 'transport-helper.c'. But while the former specifically clears any
> associated data in the structure during the cleanup of the transport,
> the latter misses this.
> 
> This means when using remote-helpers, data allocated for the structure
> leaks. Introduce a new `transport_options_release()`, which acts as a

Nit: "a new transport_options_release" reads a bit weird. I'd either add
"function", or drop "a new".

> common path to release memory allocated with the structure and use it in
> both files.

Why didn't our CI detect this leak? Don't we have tests exercising this?

The patch itself looks obviously good to me, thanks.

Patrick
