Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645710;
	b=YHVYgo1KMqpbzqDM5bAjQ7Q7idpUxLbGBtO4tQ/TQstFhigLb1Fs0TfT8uOLzq2I2LfE
	 R4Tkt+Dc/9rNozjQsE90O3llmcfuRJmSM1dv9FDbpYFcv07RV9+z/qWlv3WR5wGHKLoYB
	 W8XqWQ2DLefbI9Kz/i5Sjn8fM2gJuuxxouF4DoGfjm3FwJjGbVCoSuYVk8l/Ijgd/k3NK
	 v563ZskyBaXmjzBQ3Pq0GXWtghA6BZ0AOV4vy3BHr0gEFOMg5oBTHi2XdnKXUdC69aWse
	 9dv6avlCdTS66OUzoQE7fSWdRPS8lfMVCf6B5zNwmdHPKnCHn4fb6Z4TrY5ZdVlV5jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645710;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4kQf6RJjfWW2hCtkwjr320pHM1afRMNwM22QljIFZq4=;
	b=XEzTodehfYx/Pu2UeIqvVGjE1pRqLTPuRJE/fXmg40CQ8zCBRGKHUjWvJKmnd3y6ITOI
	 +niQzQAjjVvXTfAoBNzalGjZLabsn2/W/fEpBEBjomKKG86mxHklAvrnr/f52aVdFSxFc
	 E5Y2G7OykHCgmJFriB96boyKdOBFUmDhLjjD/gSwrTPtMFOl5MjiDLKDgoo799/iP0ibK
	 XRCOocQGCouOp3+3B5cW/nhWLCivvRwYyTlMbMio6gpf8xFMdo8zcvtRuKvF8nFUuUi71
	 9yh3Z+Qs/A6C5wJ7Nz1Z3dxPz9S1sRq0Jl3cBExgt2/texNJS84xKW9KPNHoqfObLcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=P5Z4xotp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qZFwSkhK;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF2606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49EF2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=P5Z4xotp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qZFwSkhK
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 861C07A0104
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 13:55:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 02 Nov 2026 13:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793645708; x=1793732108; bh=4kQf6RJjfW
	W2hCtkwjr320pHM1afRMNwM22QljIFZq4=; b=P5Z4xotp0Vr7O7rx2vZ7iBbrep
	cCgEtYQWR+p+dscHbe3Hwl6ZoiCN5X/kL2w5+cQKOTcFAJ1Z5zfCGGzmp/67PDT0
	4bLtmHeKKEUfP9hPgmTiw4/Fl3wOXxqocpc3XPGzFmN6tGjJN2YGfDM8nNus8661
	Tnv20vvtctWqr8CXH096ctotX4UJ+hHfAxuEJWChjK+qPYVpvprcsAbwXegSbcm8
	99OjyHFrd1tRR42EGLx7+HCeLCXmKA6wRuCkiyam4X0rfOpgztP4qAT2TjJcvRt6
	SLX2+Ct7m19ZrE4VnmdXlJMwUIcg2C5iG8rx6fxSHqUlBhVV/e6Z+akaNgfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793645708; x=1793732108; bh=4kQf6RJjfWW2hCtkwjr320pHM1afRMNwM22
	QljIFZq4=; b=qZFwSkhKa3O6xP0bvVGle3S4RmOVa9GTXOgbNzcCKVuNUkUQ21F
	Sz+9qAnZpaJR5uC+LUFoB+jw3aHhPztAW94Cu0Mf/TyCKKYLsSpdcenurzRGRpHv
	c7XCO7xmAd25bl6vipATRScdz0OOC6p6liqkvDMiPwPFev16Q9oF3wnQsoPbJbN0
	L8u+8QWYhJPBCudmmQ30LNliobEBLTUT9BE0ijPx6K98Uk0qGFBqUl2FORI1Oac1
	HixdLIfr0w81qwyGgK5S4Rqd73RRxo9OfxPnHfEhIbRhMyvpdTysVrMJU0LgYuwV
	Rah/2BsAqB5VbgkPTckhCOJkujbbziZ5q1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793645708; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:L6FeFaYxCmr6EQAvPQzRuFUJjj7WkVVuucpGeiXZBe2+ih0
	QsW8NgxZGXQQzDleW8kfSHzOL41CGyhpwCY4q4N16/YIfNqejgPocxgrtY2NsVz1
	y+fd3mvaa9wQo1ORLZfdKsnxqSLPjmcuZv3BpFHk2wcq5e4ButfIlHo5G8undzKY
	kH6bxgiXn8V+YXVDTNOH7LJFsMdHEuxzpxKgtgikvr9pwD/ayVMFl8QaxvssKmam
	/T4L38vPF3EG8rUQDqdp+TO5WZZQaMEsDHW+Cf39ONTbiWHmg/nqOfPJlUfEaLvk
	7Y7DoRifM9zINMgbuRt/SX9+q24o9iThnXu3paA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gYUUc7JAXt6FSY0sWUqsWY1dE7QeCH2ita6ulBJuiDY=:J0sCCVhQk5FHkVu2C8F+eFoIx24bwAMVTUcchyQqWKE=;
X-ME-Sender: <xms:jNzoasqNA5w7xs2ls3iyHATAD29aKz6Pw7YSJFIhf2tk-3fXRBhyVg>
    <xme:jNzoahvWhw8OGIQ4TIPBETYyq1xA_qFM8L0FDyfIgrhIq6_J-xDTzn0VmxOWPaouY
    gv6byWt97z6TN-DExR1RSf5nei-6dlZfXQ0QPNt7iDOJaHQDke2nJ0>
X-ME-Received: <xmr:jNzoanYpowW15mQnbN2Vw6jCgUoyazpqnW6T7J_blDH4wdx7Cb88u2jQxNq3yLedrQIo34cytA81qI3MhqbNJbNS2SApcnqvneTn>
X-ME-Proxy-Cause: dmFkZTEjd7pAZ4BcPm0c/xGk9aVLYMfbauvLmb0hFI48pZzq9zMj9XRp6lL5dAJwsET5be
    tpCuBwiU2WEqgPKy9Q1nvEt8NjNXwgFrwvZ5XclWrPh0DJSkP1Je57rlvFlxu6qDWAr1KT
    +bKubyBcYyjuFOXN9eqLT627m3U38yh9xfO4QlgW73OhIIZwWdW/EXqo+ZnOHH/byXh9zL
    cLLYSfYenU7ckorG29UmOncAaQrTlKw/pyJY3stLEo/UqZbkEqtdXLXxaKWQQoXkLjABBx
    tQkNSBmyBxrmMQv1QWSRHL8mTPZwbmBHg7SGK2+9mZQUr2EQ3h/lG0xFENJq7qfbkHMCQT
    ai/F4l4Yv71txbtDicx1Fujy1WaUVojkl+gckz3WtMqUCIgPPqJ56nSLNKWj4XTQ0BqTmv
    xvjphcnPaoukMfM7ij3H10n4z37Ki3WuvwPkaHUhitVoJh7n9cmwp+OfLJQjKdJDofHfoL
    r5a9P/KiZYiNYwIEuZboVLdM559xSQiu1xMRgVXjVIj6W4YOfyd0JKGiv8UIGM5bfyqF1k
    /qCXAuOk8Be10g8aDxAr6UUHJW0dI+E9OjANt+fhQ41CsnGWXFsM9Dllr+VjfZqDWHkHEF
    obK/ie8a3dKRxMl4zgt/dPfB/NQueMqz8OUVU+v1/HbJBepF/3PTb/rRqeBQ
X-ME-Proxy: <xmx:jNzoagbJaf8jztw0KzY0nzWoBquhbelUA74ipwJpeV08k5scN8RwMA>
    <xmx:jNzoagmKbHiFd5TfB9AM7ochc-Mmqj2nyVX7Wl8ZgHnSx3wIZ_uQMA>
    <xmx:jNzoar3ZPrkuoRX8k2jGbV9aKGR2mrRV2YhfwzVqEyvbW54nzofslQ>
    <xmx:jNzoag3UYXpckyra0k0ZH5zsxHpPiS_-IGDryofC-JG73stkteVQGQ>
    <xmx:jNzoaj9_-hvtVCmzyFwkCKoDqFgeFFjhiV3aqWDuteNEo7ktA-iwWwjy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 13:55:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Harald Nordgren
 <haraldnordgren@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  GGG <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow
 clone
In-Reply-To: <50c6229a-336e-4488-9289-183f5ffc47cd@gmail.com> (Phillip Wood's
	message of "Mon, 2 Nov 2026 14:36:39 +0000")
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
	<pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
	<xmqqtslzlhbm.fsf@gitster.g>
	<CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
	<4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
	<CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
	<auiBFhXI_xiBTPbg@pks.im>
	<50c6229a-336e-4488-9289-183f5ffc47cd@gmail.com>
Date: Mon, 02 Nov 2026 10:55:06 -0800
Message-ID: <xmqqpkwnhxmd.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> something like "for every three patch series you submit you should 
> provide an in-depth review of one series from another contributor". I'm 
> not sure how well that would work (I seem to remember reading PostgreSQL 
> tried something similar and ended up abandoning it) but it might be 
> worth a try.

Hmph, I do not know if you want a "contributor" who throws too many
AI slop at us to contaminate discussion threads on others' patches
with their AI generated "reviews" in the first place, though.
