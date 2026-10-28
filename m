Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793147226;
	b=X0tIX+8WNylbcVyBFHd5LC8Aj6hTdP87iGPoUPhpVIntzvtcIlqUu84eSYnrOa2ESJad
	 /VAw9d9isxBQmv4iZQCQ5LBGokenetqnIHCnKidK9mPY+jnz3r8uk5TA+bJdmzrvNWbVx
	 niYSneDNGhJ6IlBG3zPyAIpDGVH65lbsqC9rL2vob408KmZXwmw0xAg/HQY3d2zhAGc+V
	 bEASofvgUV6/FxcOEq3tUGmSRwRHCHT/dD6HUfCSL82g+XMh+1Cm5sI9iwzVqdB+6GTRR
	 BDNEk2P/icI6ug1dBuEhYtqsIVV4wDWNgZYX9V3CYprR6k1xjeu6TJqyR2Fx/15xEGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147226;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=EBTA73nZ0064pflAfeljt+RNd2xXuHTq2M4DpMoGryI=;
	b=AHo/kSlaDTNs7nRZd0incIRWi6ZecE2ChKf2Uw0WcGs5/1d8cpqh1KOahO4uIMEW9acH
	 lpozlYGok4k2Ss1L4HXG4ZQDvFxVdJsH53ZsHoiSMP0RkOR5tjxtnwOJra54ZXq9323xw
	 wbIZeN1bGdb6lbl9IK6Cp/7hYLQ0Y62+RwArw/fanzfGy1qP+Dz0uUDeQQZC095+a0lsZ
	 JLdDTUpa26DbW//AaN/Pobco24jPuceOqJGhFHUloBlOSsC6Ihyg6UtLCHAMSrfpGXncA
	 4niZJH1FBAS8W1Z9i0HsHalj+twQL+IyzL2SEY4IMSG6Q2suLLosdvjJG3nVde4lf/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hffNigPS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Skrcn5wg;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56208606A320
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 00:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56208606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hffNigPS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Skrcn5wg
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77DFB7A0179
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 20:27:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 20:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793147224; x=1793233624; bh=EBTA73nZ00
	64pflAfeljt+RNd2xXuHTq2M4DpMoGryI=; b=hffNigPSgMQQPOyIUUymkBap2L
	IzwGizZtm6eQydxoO2AV9wb5Y33AnIlm26t3KHGWN+6zlJRqkzaTGu78TgAUSKi/
	7gOjOCg2vsXNGLdr+RG+WuHO1HmkPmzdvfbApGPab3FjAM7c+M3kEFf/T+FvxlMv
	6wU8usUQyMhNNoCaE0KPZ6a+e7Au7Eepenp8q9jv7okaC0tHHQD0e2wGJWIWFxOh
	MBWN0wAtXH+UzVOBKfaysn7zoQQs4+w5O+y/B6bC0Sxl4ezw7ZOqjZERBiLam7wG
	6XM/0grAuRosVM6+jd/KKOBs5kS0u3Wa6f1/ohiDJCllI2aUa/a6eLGPKP0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793147224; x=1793233624; bh=EBTA73nZ0064pflAfeljt+RNd2xXuHTq2M4
	DpMoGryI=; b=Skrcn5wgo/Wixv5YY//etGStSL/6n5Blwfgkn0NXOCT96rmnM5x
	yokPfBzmqE9xBIrt19IUygjFm98O4XeGcTvfcjuji+RFwLDaXud+tYC2U8KqFI9+
	nz2f1NgIGn1wl2q3T8Nx8ZEJBnVdNqZY05lUobYruqzQP8+MvPmOyntuIohLpkkG
	oevFd33gpKJcj7b0WJODmDhBflQ1dEMxSmebQu7Lh7L5LPloFIdVf8RyGcE2qlrf
	7BHPgTephvJPWdkPBOniBnsOXXxikxayb9PDpRpGniYkYmEzsY1D25F32J24Z6SX
	EkZIsL8kNOCzf46HBs60Utdd3/pC/ZHpiCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793147224; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:c9C07VZg60Kwsf/dsFuHqD/zcvjqLPA+zMWtaBt6E7PRNqq
	0EpynTDOGD8kzm1QJSWmoS6wIr433vMB0kSP7JKE0Qf9iHiFLSw3JCvCTJa9t/tk
	ywsuMr1PMN8Nrou1CjrgJd48O8mrTnwqWqHddEq3ur6Qejua1RPM/Ls9XDiCY0NL
	9bEIlPk8P117i8q7A2g3zRun3F3Lm/n2gxTF7UJ9JFqy4yfv6aurbT+Pw51jnZMl
	ZO22iCtzRYpsIB5ti97Vfi2KX/QhZAvpiE5atpv3AJ8D38I/hbwZD/beQR2HEeC7
	4wXAzWhqJlisDLbc7KYjTUJqPVChsNfOST/YsVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BNn5sacPymS/IAxQ/IU1YOy5fYRsIuNBceG2YxdG4bc=:WFn8OFgsFbgMLXjv0fFQjZD87SojO8k5X7o1mbB/hPE=;
X-ME-Sender: <xms:WEHhatpi2odde7cgu2B9NVsC-Av4hL_oRjbD9cmIJnh1Fx4hRnORsw>
    <xme:WEHhajU0NTGwqOtdDwj4iihZoEbhKbvVJVIy5l4Mus36CepySG3MhyeZZglTfTq3C
    bwGmp1k5KTLNqFVTYZvW2N-0Qvi3e2UEabt7LKLTYduwb-G1GltKwc>
X-ME-Received: <xmr:WEHhakAzLiDbG0faWEyJOkgEx4F4HsnjXXmIGRI-BlYjF3pzEW6kUPtc48jHRaCO80BlIlNUVu1PKp9xX1j6AlIZ_OnHPL136FWT>
X-ME-Proxy-Cause: dmFkZTGWlYl9fim2ds6iNeoKu4wYr9ls0LKlZzSUlwgChEzw5Brh/dFHmM5cQflJDughtd
    sEdn6nOleWh2MPhBTA1tpf+sV5DPcasD0EkjhBfxCeZ9G+t1Xx8fvWzFQjAqZhyD2/K32g
    t53y4osNZcl8eKtJIFw9tL8dJfk5yDRxg+w+u/NCkTAaH2V+dTyVCAJHu8SpNgywlkQ9Vt
    3rwOWk0Q8j6rHaV4oE6FvHXQ5nh2rI3+FDX5bcjxVoh+dsMzKPW45cSgl95eXy4vcrQ850
    j1nZ4BGorAjaHhtuSh4XhVpBm6nlVYomG8Oo5SKFzPMQ6Byz6ibWCxsj7NZdtiP013NcQo
    lwTERECaEWdosECa+/7rJIgS6Y/NDRCt9IgWxFWMd0DQhYlDdWq2UK5g2f192ewGxfhWEv
    mmNY0ApR6ylOCWbOCnxtCg0M5B87qnjYISwDYbw2tqppIxHASoKjqCVDYsgWQDnczzgGUV
    kIRJqpP85LhOM8RPpDd2mIYp/cXv0W3eUqoHD6Ont5spMx78BZqBLDEV16f6baKPI+ihDR
    Z8BCtEYU2zJu8ybX2Y5K5uRbl6D6KsUuacfTqRlI/gGW9zCJdVZtsjRTg5OaplQyten7qc
    8VlDdehLJQ5Z+PHWm9D8SZEdhegOexyKR++ZnRF9azFIgCtZyTru+1pDbIqQ
X-ME-Proxy: <xmx:WEHhav3BpNj89nrtEIpCHU_UCIeEMBAKUmimztNMuV4HhAzluKwE7g>
    <xmx:WEHhau21IeYT_a32Z96msa6gI-8QPYMQLvPOTXyxNl2dutCRz2L63A>
    <xmx:WEHhasCCeRFgzHhvn_kLEG72trBqplTpM9Va5VU_cc7CK3VjqCdfDQ>
    <xmx:WEHhal6iPbMM6f7bu6-4tU0RtK-rWQZHAttYuy4YVxMJaAeP-q1vHg>
    <xmx:WEHhatGaS99wdm8mQdHPcU-bd_T9tKrw9fADTh97Z9545BrD3XujEQAx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 20:27:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,
  Jeff King <peff@peff.net>,
  Ted Nyman <tnyman@openai.com>,
  Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 0/8] repack: various corner cases for cruft-less MIDXs
In-Reply-To: <cover.1790827875.git.me@ttaylorr.com> (Taylor Blau's message of
	"Wed, 30 Sep 2026 23:11:29 -0500")
References: <cover.1790731662.git.me@ttaylorr.com>
	<cover.1790827875.git.me@ttaylorr.com>
Date: Tue, 27 Oct 2026 17:27:02 -0700
Message-ID: <xmqqcxsufz55.fsf@gitster.g>
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

Taylor Blau <ttaylorr@openai.com> writes:

> This is a reroll of [1]. Thanks to Stolee, Junio, and Peff for
> reviewing.
> ...
> Thanks in advance for your review!

I am trying to eject stale topics out of my tree, and the discussion
on this topic is about to pass the 1-month mark.  It seems that
comments on half of them are "looks good" and the rest are "just as
confusing as the original without improvement".  How viable is this
topic?  Are we still improving on it, or has it long passed the
point of diminishing returns that nobody is interested in polishing
it any longer?

Thanks.
