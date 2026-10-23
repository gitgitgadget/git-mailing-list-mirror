Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780395;
	b=s3/vNQgc3oyPPvRlrHmYMtAKN1a4oarRWrRqrtjdC8ehHF8kd0b1K1vkW00X66QcgSjO
	 jHa+pefSMqCrARKSs7IFeuVofEQOc3O+52m3m3IBFN82GOxdQLur2ssMGUdSnzm0GIrTS
	 rWEhNSWB4dFmGIZe0XsEUbSevswdueyeqkBPsGb+EulL62Rdsj4zG8iynhz8jF6PPPfjB
	 ncN9+qD0E+VQ4G//nACPygBwdDWJwVNn3lxZfDD6uv/2ZH0H0DKtEk+EJ5Hw8x4H+mRsR
	 oBgzcDjh0I8u3hZFhbsC3G5V9chj8R06LpWqnrRA7JPb5GxPgT2/snM52qhfHkj2pvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780395;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NtwsDJDPVhC0IYbs2gY/V0iuE1lMcYzW+buAQ5MrG0I=;
	b=EVH3e8xmmjOidhZDS8tq2OfIxbUSA0jIidWCGjBGO+V+WrMdBgrPWtiwb+1zkLuexQh0
	 eLeK+w14NMF6vveAlvzkkaQeua3le+xljTEuzmPsD51c6abRVycnQWOyaH0c8+8WWSViI
	 +6J5pIFjQIPXnZLVYAzM4yoM1v8PpvAdgZUev9++2DZeEaT+7eH1ydCv9uTJUXA3DpaPZ
	 l6CdefGeGDWnh+5UsmmHo1lrSGdpS94xPVYIcHS7dlAyeTdN8iyhpgwRW+PIwclasd67h
	 YSkg3orzq/e579VVnSfUFxBUUGDAVltJ8uhIGE+tjKle22aJjI7xIID94LjkpRZBShg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=maq5eGLg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cczPX8tv;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF91606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=maq5eGLg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cczPX8tv
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A3BD61D000AF
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:33:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 14:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792780394; x=1792866794; bh=NtwsDJDPVh
	C0IYbs2gY/V0iuE1lMcYzW+buAQ5MrG0I=; b=maq5eGLgLu62xau5184E+uffox
	FjFW4MRO4SZ+qaXc+lj7DVMrd6l0x0fBwOQruUqCreGcShKa0un5N+IytPweM/IZ
	0TJKjI27WSbgnZa9tONHrVWx9UrRTyoAcQaYj7q4HMz5E5rMEgpTYV4ki4wEaCjj
	XPlfUrlijpNnAV4Za/D5w/MG12rC2g5+sjKwo5p+yE26UK+Q0v8o5U6Mqtlq1RLc
	nScYo1x52mB6rKUQonMkgY3BnKX9fExwX37RSrcCTSMMThB95L5aUDSH1A4ZllfC
	mMM1J/mkMesFZUJHpakkmJFUGVJoo8MqZcl9YxV/OL6lsCVSy4MynwRQPrBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792780394; x=1792866794; bh=NtwsDJDPVhC0IYbs2gY/V0iuE1lMcYzW+bu
	AQ5MrG0I=; b=cczPX8tv9ta+tFhNeQF75MXc0myyYFFcDwBVy+RZUfecZADHhNU
	I+nfn2rHt34Rig8qNuLegLksOk3gEU0lGd1jeKz8aiKl5o/cM70z7X7gMH15EQvQ
	n5X/Y70BmRQcG7asCu/Q8Vejcm9Bx+ScQA673zdO3JZJxxG+Zakk2alu/PrTjObE
	84V447qv9FmciDWh3Zg8m5T0Hk6yfDLz6HRcT9KhGiyzSD1s5e8Rk12MCdJHMx+l
	9fQpBq4yUVMjJ16jCma2NvLFagNWlxEoJCc4DpalmmhD+nBwV7CtlhZ39pKNq9OQ
	aQbiHxkbayFuhlEFIq9qj3mqcW/WUtmu9pg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792780394; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:BZtGkqUraMlKObmmbJKiXNmJPxpsB/n5eH/5MA/ZEuomofU
	pVd9zJTH3L2nxXfVsGYMbBOyvq0FwKVV4F9fuCEzoNLk7EXXdwOrldIT6Su8krSa
	cPj7+3J9AZlMEg7+nqpxYO119AJ/yZwzB0gs2jzzYd0l+/ZB44ZWI7qGbFpDDMKr
	eLNztNRxj2zAqcsej7QMgKaWezSdGprnpEfhyTHzFPTNYKYChndO3nVvRgcJdFvI
	JiEXSC2ORi3/pShd+q82w5w2CCRFAOCW/S91ovV29hCJ15xczYqu1hdd7mUppqJ8
	/lR4P1n+Waw/rl/GhkEtQG3S2N37qyQnZXa9esg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BbBJR0hfPAeZWNn4COKXkDehOInmJGE3KpPYCgbxg1s=:NtwsDJDPVhC0IYbs2gY/V0iuE1lMcYzW+buAQ5MrG0I=;
X-ME-Sender: <xms:aqjbaqvR6SCBEq4nEbFi53us4ZSl8J_VhFpUZbCvw3yH3PMkRZRKaw>
    <xme:aqjbajIpA6HxIFF-Hm5EwDhPY_w6rhrLNMV4u5Q7YwV5lKXc_LYZ8-HuiZgYep7DN
    Vl4mohAlWTfk9pwVBlid3luKXkQIqxrdvsro91sb7w3od4RTsvjBQ>
X-ME-Received: <xmr:aqjbavnQNgQ0Ob9qavs1SPViiOuuRLlqd66yfZuLo3EKlYugM-Ep0W-YeUzJMmmsY0mARuNma0fXujt79FwJE2aKk4XEKHBXrR2m>
X-ME-Proxy-Cause: dmFkZTFSZpfA6Aoefh7OXpu3/Oc8TGf1xAPfkrU+aXC6eIFAPJi+rjEvFMZqniCcUmj1LT
    flDkwkZXaC0/gkyeeL6SOSOzpve4HiCKsTRGAcdyBqfPf3O0CMNFXIEVIQfjRMkgs1Ic2K
    Y78p9fdN5/y6nIf/gn/62mr2HOWMS7WCYzb/XJFSsAj93AXP9hFpZGc0hdxSpeSFEDZMZ1
    6T0PBK9ehWa6nCfN6Oc74j2C/Ev7pROl1zrXVlQ7o3G2M2R2vDaOyp1yZ9BMlHDMcCBC4J
    uQlce31AcgwuykMKjoggifx0MUHFc1anVyFA0uxiybbobIWfys3gKLrqfw2rVjLmaa3meM
    7aGJlgbyCSIxzIkFLnsCOFeV0vsGFzewtwLlMvOLoImOToaRlt9gDOGNiW7QRe7mLaMm4p
    xugfXs9gG0IXwmoINfyPcCMmTQgSxUwnyVKPWeeSY2fu9slUa7HMVr5RxfDAsALZlcOfwe
    41QwXLqOpVyOY4vYzaqURmzF+f6ltJqqQRc86t0QJqVz1aGUUTyEy2qDeH9fiqGuxUCbGQ
    uiQ5eErSjNzFfqhK9SZKWrTduTQl/mhjQuTsGVzw3s0mes/l3nQnFlfMGrTGCnRGcw425P
    i3dNby1XPICk6rS2md7S0zYadmORJQ1K3qnuoWuyqVsnvHdOOcZk3H1IespA
X-ME-Proxy: <xmx:aqjbasIfkIICtyx8YpJfUfROXbRV0shtEmN-GhLRHZyC7iw10zAFAg>
    <xmx:aqjbas6gM_1qwS7G4rfJUJjeIGaK-vH4UumxhUMXHFeJc2v1jQnfcw>
    <xmx:aqjbao2qjKIolTrs0bRERbulSFXZ3Nj5RwWBcPoaPQ9RJoauA5Nb9A>
    <xmx:aqjbaqfCIyXILA-js_2-6y-p-LnBnd7OFld7pL8hbkBivlOSONRbXQ>
    <xmx:aqjbane-htt_dNMq-MTQo2IfI0MrF5ea9IyBLxblT-tCUzDpEPi0KQYc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 14:33:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mihai Cosma <mcosma@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  stolee@gmail.com,
  quark.zju@gmail.com
Subject: Re: [PATCH 0/2] status: stop holding index.lock while collecting
In-Reply-To: <20261022184420.3648771-1-mcosma@gmail.com> (Mihai Cosma's
	message of "Thu, 22 Oct 2026 14:44:18 -0400")
References: <20261022184420.3648771-1-mcosma@gmail.com>
Date: Fri, 23 Oct 2026 11:33:12 -0700
Message-ID: <xmqqik2s5kt3.fsf@gitster.g>
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

Mihai Cosma <mcosma@gmail.com> writes:

> This overlaps with Jun Wu's "Wait for the index lock instead of
> failing" series, and the two fit together: his makes writers wait for
> the lock, this makes status hold it rarely and briefly. They only
> conflict on the one lock call in cmd_status(), which his series renames
> to repo_try_hold_locked_index(). I'm happy to rebase onto it. On top of
> his v2, the slowest "git add" in the clean case below went from 1020 ms
> (one failure at his 1s timeout) to 160 ms.

Perhaps you two can work together and send a single consolidated series?

Thanks.
