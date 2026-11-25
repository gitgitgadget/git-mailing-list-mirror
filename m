Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638473;
	b=UIDSCg+9igGC0g4WCEbg2TrXj66X8xagya4IK43jUC5q5GKFM7oV2e07KeyYhqfUVR3e
	 mcBzYXMa0javBYinnXwTNxHr7/AO0ODw9uoBGKVmG3mTxhXpvMQSM09G8mxojnzqjtDrT
	 vgfxd0nwwkHAufenQf+6nL8BF70RyY6VCZBjiiRl4UYDwmHY9vGiNHmGUjQ5cfIED/E98
	 PRtvHdeaRZuiZrY0rJmj6khwJlmYUvUkJxelkHnYcsmDnKF5w5eL8r+5tyEKmqOwjI93F
	 8OiIyCBTcRN8tShJl55mXNO8Y7RavkPh2BqfLRAVGUkcmkzJ3r2mRdRpQCF5tOxQvyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638473;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5bsETaS77pFgjBm2FiMz2SUk4y52T2ZW9D6GXA+YOxQ=;
	b=AKceZX713feKJWzfMf0BRu6mxq6MydyIrshs5/h+GEIjSQ0eZp0XWcRBolUIpg8QHcAp
	 RAc2jbwykEj/CExeMgLBRqNtfr4DP13Pc/yUjbEHoCjo6b66v4lBmDXVozqElMerq1jcr
	 8G/mLx5P5CZ2ccY4kD/USaZWxWXfYiGochve5ZG5TIRvZNZbsR21Dz+nfi0Wc/mM5kl7a
	 B3lQYbct/vSRsn48EzR0wAIr7z//ImS2v0xZIven7j+bTd0eLJOMkvgWAZEtQmUUUbXkl
	 pp1crDQp2OrLbYz9YUuwlT1NLxRNQwIweoLx17oyUGKbY2roLVj+LCMP91aWBtjY86w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XNkvP0vR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tSqAm0+R;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBCB606A327
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CBCB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XNkvP0vR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tSqAm0+R
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0430E14003FA
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:27:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 25 Nov 2026 15:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795638471;
	 x=1795724871; bh=5bsETaS77pFgjBm2FiMz2SUk4y52T2ZW9D6GXA+YOxQ=; b=
	XNkvP0vRe42DHe7pP/ZeqYZL+q8ZkfwwLB1CHTi+PSztKKcS6sTw4vQWmVYvCDMu
	2ksZ9NvfqYtbrZxyF2JAyuKeZjRJ1fdy4uDHDk0uIv9HxpxorIb4ISr6Fjn3mplE
	EU01eHEHhKfw4DoqXG4SQWGO0xs/dhUHxDCwOLwnoedBubLyOn9j+cmMab3Bm06d
	pmXT3kJ2uPnNB/pZzm6e0YyGqVzkLPb1Cy5dcYi6jDr6/PLLlWVhac/L8wnxtS4o
	QCXtlw5XG+ZiVhUJKS8SQcEhIc8MMoLUPlibjMsrEjFVFTqLAEKhSlGU/BvOuHFh
	249qjtweog79ySUSI++shw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795638471; x=
	1795724871; bh=5bsETaS77pFgjBm2FiMz2SUk4y52T2ZW9D6GXA+YOxQ=; b=t
	SqAm0+RrOlst9q03IXl/6qZnBFnTSc2qt/RM021PYWCrf5Xyt89o+3kn83PcHLWC
	389NAnJ9MIyK7NKy1tbkBjTpE9oAGNIkO8XfElr25YDOEy74c7x5o5fDtKWkDicZ
	xItSVNZ0gC5v62HsqcKuzjtlWM9bySLUy7HQ3ssC0RfC2WxNBk6p1+f4jQoEBnGR
	GmxbctuUBEIVy38W1yvhhPVfGzoyY6zvEJHF9LQ1zpJ6LlE93NXTCbAc+3al7NMr
	X3jATqtJ03sIM7VtWtQlAKCNKx89pFI3KmUIaDJT8we837zspQfi6N9VHNOzKCXE
	3Kuc1Q3VzniPU/0KDXB4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795638471; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:h0l5v1xETNmlMFUecXvWy4omVl9f2P+6TL4iIUzdjbCmip/
	lq+VS7qjgDNK6tjARFLFLT1OuNlqkJrAqdNRDRUNvoZFg52REInI9F4tItFJ6MmK
	CZXrEnjTcxXqUSylFGpsJoKJdv2jBNxBplgGx2SAqqUv6C0nLT6xA3TELlsF77vu
	pxZdr05dP66CnGGwRGxfWZ5y+zCZAwMWCy0b8CcrA2Z5WQ4XVyYWp7wIs4hAutMW
	WI0E6aRv2or5ZayVBmmpXM/cjnmkn3NfptACiknvB6LrDfgF6N1ALE7MmqzdugO7
	2uBYNQND5Op4cOWJzJooKaBNsh7idYk2izQRBJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:lossHPdxmu9IZ59OUu6MqgppaIyEcy09OkpTT0f2qiA=:2xBh/JbG6Q1CojQE9OxZ4Ea/Zjwo1QOE4w3x7xicP40=;
X-ME-Sender: <xms:x0QHa3jSO6py_3g8AEM9o5TUG4W7LnAzVU2wVyT0Z_WsLJ3-ypnkww>
    <xme:x0QHa7dkAgNwmPU8eQrWz2HwXXOT7QtovKwYZ9XqoANm42_kpXJDmm6JIWHsSE1ka
    r1aoRQkpQMxK-1gyVV6cXFLb8kgMy5KP9l2jFgCiIa3Nx2xVBfxUzA>
X-ME-Received: <xmr:x0QHa0dUsy1OzDOQgYNEkvkn825n9e4Rw6fHViSuqpDBdfV49eRyNHKE3_XzM0yNrLBOMiKMKOqtyEnuTIAWp_PEHBpIj1b_exobBGc>
X-ME-Proxy-Cause: dmFkZTFdocY2Ijf6dAQFJ7kGp4z60CT9pPtpRU3BNOmwBLH+/uoCc7GVzVi/FNdGm/GrEc
    mcAnoNPEqpIn8XEqWZC8PsnIOGLWdF3VU6sD/vYggLosjqZaf3kZQ6cANKHqbdDYMCSfZk
    PkQVjStH395bLvxAg2UapPEETD/wxharpRW1bR1MHrwe9TVUZ30bQr622km8YEjfLxogIB
    CUsqI5zOrZhs77M6vjyy8wMU5LECH5aGZaS1IFmfNiQJrbn3bnDccw+hZMXUX3gNKKJHQO
    fAksyrlaKvPzBkRDcoRTBq3isfadsB0jgh5WFt6QDnuNNbSx/R7orXB0ZL0Fs5AhSMItD3
    czuse5nUBiSLwOLPCOLIRWUc8ZWmeF77I4gmKzvJb23WxZF+TIhfgmjC5wbPddzMeBzusu
    gQfdOSSZCzaDcnzOwzxvfc8zs6vEJpP8tZPiYqZJyJEYecrFXlnRF4LZE0WohMgGc7fxeK
    NlfLZioBS9f0Fe5JX7qpBgdanQ72W/FOoqQ5r8kfGxP/M2Z4NoddoEMHYhpWgB5jqFvnr4
    tXoSNmJyhNGBXsUsUWJ5SfF0Je9JhGaeEoMqZXsNppGXe5lAPimvp7XOwHUmG5rqrN02qW
    a4lfZWeV1OXkg/X8aK5e1SO4LjhBDCS0LKVqIFqhtXBlP+2O0ogEYEyCuTbA
X-ME-Proxy: <xmx:x0QHa98vUb838RBFah3aw3lrPNVAt3N85o1MghmWZewLu3ukspbgeQ>
    <xmx:x0QHa4k3iVQm3KLqLNgawONGdWQSiBGmeiVY_tqSG_skIEKQKg_FVQ>
    <xmx:x0QHa388L1FXZfWkXXXrb93iqsMi-ysGS3o_Nnk_ZV6b7t3KJ8f5gA>
    <xmx:x0QHa-nlXVYGjEUEABlYWQoO5ZPeYMvChmgIQNGmiI7jQFWrtoamNw>
    <xmx:x0QHa2FsIrryWRsfnfQK78fGI_IOBjQ4W4T-wV8V6NwJZQfvKlprtPyu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 15:27:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #08)
In-Reply-To: <20261125194903.GA27126@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Wed, 25 Nov 2026 20:49:03 +0100")
References: <xmqqqzgb5qx8.fsf@gitster.g> <20261125194903.GA27126@tb-raspi4>
Date: Wed, 25 Nov 2026 12:27:50 -0800
Message-ID: <xmqq4id41ws9.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

>> --------------------------------------------------
>> * cs/read-cache-conversion-size (2026-10-13) 1 commit
>>  - read-cache: do not trust a size change when conversion is active
>> 
>>  The index refresh logic has been updated to no longer trust a file
>>  size change as conclusive proof of modification when the path is
>>  subject to conversion, preventing false dirty statuses for files
>>  with only line-ending changes.
>> 
>>  Waiting for response for too long, stalled.
>>  cf. <xmqq1p9twdhh.fsf@gitster.g>
>>  cf. <20261020205644.GB6367@tb-raspi4>
>>  cf. <20261026192514.15844-1-tboegi@web.de>
>>  source: <20261013180206.610-1-curtis.allen.smith@gmail.com>
>
> Please allow a short question:
> What can be done to move the one forward?
>
> The patch as such looks good (*) to me:
>   it fixes a long term problem and adds test cases

This has been entirely paged out of my mind.  I know it "attempted to
fix" a long term problem, but without the author reponding to comments
raised in subsequent discussion, it is hard to say "it fixes".

> (*) There is an optimization possible.
>   I think I did send it out as a patch some time ago,
>   happy to re-send, if wanted.

Again, this has been entirely paged out of my mind.  I know how to use
the list archive and find it, but I do not recall if the patch got
sufficiently serious reviews.

As the original author seems to have gone silent, would you want to take
the topic over and make a two-patch series, or something, to move it
forward?

Thanks.


