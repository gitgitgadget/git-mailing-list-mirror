Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965613;
	b=UBCPPTEMmNnLt//egy7pViHvY20/K5DFjJfcA4JlA2zX9tLJzXHq86+9h+3Tri27Q45Y
	 Ettx6++4CXRYgsk197ILMzIxLTGOx43/N7JQY8ZxTxNSlQyn43IG9HAChMTcRcOAG/V9p
	 X5irreo0Zr+LkYSE+fmcnqbA/YiRU7e7sKrdIUp/SN4ZPfqeiFKn4/LcgM4DBwdU3Eh0n
	 eTNM3NSRKBg4JPsiKDygaizSR0TOB5SBTFVi4hgbdS6xz5cFOtODTbEium2paP/vfx/oc
	 jnvytv1xh6pC8/ywg/ZU1apnZbgKKW/qM1cLbx6MlfN23g8kRIg75i8Xsyg3RICa2Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965613;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Tl8F+eD4htHqFnagcCZ2gp3aisInQZfJp4rTlwIUkf8=;
	b=czkGIJCzw90+a7vwemi1qMCJvb1SaXZFT9wUydAwUCW5R04fTsvfPJXUIQXUGI0N5Ewn
	 gizwaxhVDyHDjTSKIIj+49GVB+crLPBTr7wzQavyDEFYMOik2I1fb2lFIgHvjD1XUb4Hj
	 O26n+ZKNDV8o6erkMeGHyIQX6Nqu7Yey+baK0E6W3mvgvPYyT+ySK0nwPHo3eqPtUrH8O
	 LHfyZyJ8eKj8ehcqSy6TKmDDCpM0i5snYxXdDpUfay/xqH4bjQhKRZ446qdtK8A/2cLlt
	 7kDOO5gNoNIMs0AINX7sabIGDdsy5M+e+U6Zg8syZPVtm7dc8Da4vvtsa3zFh/oIl0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ioFRB1ct;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5fo6HK8U;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5D606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 01:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E5D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ioFRB1ct;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5fo6HK8U
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B17A57A0223
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 20:33:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 17 Nov 2026 20:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794965611; x=1795052011; bh=Tl8F+eD4ht
	HqFnagcCZ2gp3aisInQZfJp4rTlwIUkf8=; b=ioFRB1ctp2lLU+yHS0p88r/JKt
	ARPDAQN/A6tJ4GIg9pt874pecnKzMfHCILG5STzR3N82zlubfwJjtmdOA576/R7U
	IoIJ/PLfQg/uxiUP1/aMLacfmisnrjPkFeEZfj6ABww6Irtjj3F08YIqbIj8MVt9
	odabM1H2oxof0skBhVg30kMxQnIsuSyRVqvB7wiPN1AtG6pHNYDeaUcbGf7fjzGs
	l3HoSneE2VhHyxwVpAwi8kGQn0KgXyX5sqeZVMXulPY9mPjMyf6s5+nmqsprlyAs
	FtyjaVjiQf1YF/vlhU9pm5Cr+SdMQrYtuRmXTS9I0XxLOlbY0NsgfTAPcUZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794965611; x=1795052011; bh=Tl8F+eD4htHqFnagcCZ2gp3aisInQZfJp4r
	TlwIUkf8=; b=5fo6HK8UPp3vSgnZSp6jc0093Bjg5EmLPJWOKViP3JaAnYgYgPY
	ulNP+MnXnkrfEZN4gmwc8ICAmfcCg2kOohVRHz4njc4sdIsjiwd6eXkxC2YHIyIn
	FdROMhb4dOR606cKiD6yfSczmOVdiNOSpRuNwB0PkfhsraSJwhxxKcFjSCEhYyK6
	AZBpGsdH0LIOIFZhSw2HMH97tdjJLl6Ut2qGtuHu5W39UDj5T13x/k/ZwzD7n+Hg
	Jadx5dN3arbh1KMwQkMBsTkL1PPX4MZJcnYG+Y+0aJdp+mz2C8Msb603PPslwu4c
	UcSHHBDLW6eAlRik2RkspJPGxNHGdf8RNRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794965611; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Gr5b5Cj+PlmGZak8NkwZegfMCe74wCG6UmV2VENhNC+8O68
	hhOWe7WHXM6NzDyR2+9g5ik3R2/BQMm4rIV0vzvj41S/4wkrLdMRAQ/FV2joLqq1
	cHB1lb1T/WmchmV3wCQTqiiuPUex+yNqFbuhQTH0XYSLysoamBFsl6C0El86rWD8
	zbMDo4r7go1uJQD/01F72puYSJSs/1VI6jf54srNauZnu/5IbhGTY2AW6VfqvpAY
	VGHN/IYqCDNr9JsgqRjGIQI44K52ozHeTG22cIXf4IfPC2HJlKJUZaWiXOlM7j99
	uN35TGcYsx4Oq9zn6aeSNF3XxQ7oBSn89EkkVqQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:X0QaJfIJMXPLAZnf8Ng+Ofk04M/eu94FBlWiyrgmUUQ=:qK8m2VuAA1p8l8NRk/m8PsVKI9b3j+uSNzezYUmK4tg=;
X-ME-Sender: <xms:awD9ajNTpLVxJS466EX9lZMwt2Vgjf4N0v_Kv1p9o3rqzLszMe3f5g>
    <xme:awD9alY2jZjwVtuSG1RdKdOCtSatPFykNDpqtIutqJRZw2RKj968RF4BEqwY7bl8c
    FYwha0Ml4XHVjd9v3K85kBBF14-e1YXsbT_mZ9Nw_A58lbPvKWNj8o>
X-ME-Received: <xmr:awD9avput7JWmpXhS-nZdIEflinpenKctnbeNRu_u-teQCb2DeCFMXgrSKc3Tts38vEhSTSw5CccMuTB8YkFiDiAbC87fChV53gk>
X-ME-Proxy-Cause: dmFkZTFIajYmukJ7w8VxyAJt4hVoCIIkZnhlRHcIBySxaOuCQ6uic79sgC4wl6HrfnbHtB
    WsiP8+b0PJk8jhvJauMxnfuJOjCEmzFRmCmdrNoNNzFtbCK8dcgSn9+tF48lTWxxTKE3Pz
    0mkxh05XShw7BJZ5ynrc3ymySenNp0+LtC35lVNq+uS6VDUo4gAd51NpEru2T8WiRcv4b5
    VF1j+yW+iJCmR2aULxh+3wSbVKydPmiQ4UwccL3PClqCF1ANKCraRraVj0vhY+CYrH/sT8
    FTnF8WE8BNtc0FtAK7RTEpuY277vdwwjQyN3LBloD3jbnkenYI9nuT8XFi40pmvW7mk5fO
    0blZjOZFhWh3Otov47bRqZAM7bz4nbSblAR1Wqd5W4/FLl85zwskFLmKe5SU/2hz30KjcV
    7mCNfORtBbkdUS6wHAmReoDnBu3gdyP8gzthx1BiFu7CdEpF47twIKZENuVGbyVdtQe68K
    Xr3aS8LqEHijTk0sZ0yAFai/EIvVfFvf++PBNReql1K4eCjDGk5uhcY3hfkxLFeneOEKAe
    w4PGl3XEYwcmKcayvqz/P6KJ8C6WcRpDLF6DgdUP9nG4g2LyKRS2swT1IyRxvcr6AtViDj
    aOOut4yIM3lIvf4GDtBa1RNC7j+YJIJjdWEVJLlFXsncjXCiWFiy/QPqsljw
X-ME-Proxy: <xmx:awD9ahZgEenMXeSjPRWWYY414ZvxgwRSIb1xCE0kJVC3nld_1ytIKQ>
    <xmx:awD9avQoY-uVaI5glfmL8wvUfV06WSEZOLiYx6BHVW6colCC7h_yRQ>
    <xmx:awD9ag4phbNn1MV-eLxFke_m871rkEQ-X2ZwrhPslgmtw7AhWDC0Nw>
    <xmx:awD9aswYUH0LJ1BIwzTiemifOgVZMuQDNDUf91WNYVRLvQ14DS056w>
    <xmx:awD9alAfbZ5o_ChXWbLKG_owt-v3lcbctj7P9u9VjKgIABrtMmNQTX_b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 20:33:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <ghtslfkte4.fsf@gouders.net> (Dirk Gouders's message of "Tue, 17
	Nov 2026 23:03:31 +0100")
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
	<ghy0arkv39.fsf@gouders.net> <xmqqbj7ncexk.fsf@gitster.g>
	<ghtslfkte4.fsf@gouders.net>
Date: Tue, 17 Nov 2026 17:33:29 -0800
Message-ID: <xmqqqzgiapp2.fsf@gitster.g>
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

> Meanwhile, I thought: even if the test would be a good idea, the
> "\033"-test probably is the one that handles most cases.
>
> Maybe I will look closer, but not now.  Correctness is more important
> and I need to work on v2.

It would be nice if you can take this patch over and make it your
[PATCH v2 1/2].

Thanks.

