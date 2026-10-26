Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046159;
	b=tMl7+96kP0oWRRLshL9pIHKvPQJqIkP+N4yfxudwyNw8Q9EVQ49Gw4Uisw8gfMx5ro/e
	 xbnCsn/oeL86o58eDwUevbLkfkvldAIQoYA1Bo4cPq8EoQaGMMxZBnbMLGOIrlXtdeW8j
	 j+E70ttrd9jDcO0sOoXhbXwUjjP3cMocT2WufHPymUuSSEbd7bH/0NdyFi5Va05GZQOk6
	 Q9vCZBVWzW/fhjTHvMwsL3PlH7Z3lpC8C85hiB0Ie22dXq1eJEaiuf/98+cn+upGkhB5z
	 SHolKN5UxPpRqzDW3rtYJqTbdET8enY+BJZ1QFEH6w0HbrTp+ZJr/GmNSq1cY5vOA1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046159;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=A3IkwPaSD/3NBI1EOqyN7LjXhN/AwdMqTG4izEOpFlA=;
	b=z+iYGJmMhMLOewU22AdXP3x+LfEXEMrFl5VGa3YK6S9bWZ3KKNuR8r7kWfr00IcjqGcg
	 VoYqjOWNNfhpP727SKatNrTes642s6mHdxF9xNu8IAEtm8cgPBz7363lG0jq4UZ5kbOAO
	 lgWyvhgdbhO1VLvwBFTDX7MkLR0xoi5qPkDG+9YnVhSmiGHgWuqL5Klm5ZEWDbuap6tRc
	 WO3MWLxGapy2dsUvWydgglXWgfxN63SJyVXmJec/7PvENJmrF+SnNeF96ow/TqY8Dvey+
	 7oRj/cIYgUELiy0YdXb0XjklMcK8ImkaaIm2uOOwGHa8PNNF3JaBoaRtJ+rjlTHlLSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=XM325QXr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mm1jWaCi;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB1606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ABB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=XM325QXr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mm1jWaCi
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C38C01D003E3
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:22:37 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 16:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793046157;
	 x=1793132557; bh=A3IkwPaSD/3NBI1EOqyN7LjXhN/AwdMqTG4izEOpFlA=; b=
	XM325QXrwXJn/fJdSDyl8WKrB87nfG7X7hqtonxTmU/DU8zM4J+FZdNLAIFz8D0O
	66p5ATGwuDLIvs5N+XiPSI6k4C8dBPCHfgsEohawIVAIDnJjBfPOGmdeRxmpiJ74
	T+bAySd+W0//jxsFQ+LlPqoT+BIT7jF0TbSyWmu3o79ypLco9uVRDDxECTczWpTj
	IME6we54LsyWht39PYfhAqNZgfhoBAh5CawHDopgxGMAR9sbcZ0dbpNLr03eKERn
	K6hueB9d17kVJPprB8JYhLJjlyP4hQJzNnieqrWm1HSIpC6P3St9Fg+BjSeHhcgB
	Xttc0uLQEj5gvxCGiECBTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793046157; x=
	1793132557; bh=A3IkwPaSD/3NBI1EOqyN7LjXhN/AwdMqTG4izEOpFlA=; b=m
	m1jWaCiIgGpB4QYsGUdZUaQQfh2fgz33qvJQ9uqUSFxd+ZCY0DQCM2TIGKRHuShw
	cTPKkYNOgCuNZrsNYN4P6p0h3cOU3N453TovGzS8EGxCm7LwGfKspTiBGuZjumCS
	MJssU8GuELIMZYkE9NEqMDqwDOqLyTyx72B+Ffpm2k76xXeudBHTvNt6iYCuGFjI
	plSbK6XHZ3ZNFNddEVva9uTvpqAp3c6pOffHaIV8f9vbvnG8UzJvjOR+CE46R+we
	peQYpFuAzrlM+pihk2Bm0MPjgNmu+CdKmP3nnzfmCHc2AtZ6R+L2RSN6NnTe1cp3
	VdbzuZR/htIR+e4h6vX6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793046157; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DsySMHJOP2baj0nSA7qfE49DTxwx41iPKy2DZW4ND0MLmoG
	tbtZb/4lhZAeKi9DOnoiN1lIkahVwyLPkUzAifGZWZnvWLsIbwKoLU/y1XvDpjLl
	F22O3b691y4dqEq/fEMHciaiDmFi3SjpJPUN4qi/lu401RE42xVmR5OI3wZBnTwk
	dhGTmErh1EZK9gak6zFxV+v0qSQaIgNscSVGfY6Mgy/hv9VSwcM3OueapxIoVK1O
	sXg/E0FUscx0bBlSic2znaAjZyGlzoZ5U2a0QMhsqOaYJK7YJqdFqqt2N9+vqaBi
	3fEG3Q/692kUT0xPBLsM4XIefRNRCtO464NrRYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2n20yGO4wxSaZwP08Hhv0n+HQs0dkeRIu3S6BRmgiZc=:D3TgiIRERnASGViGBMVVuIZeATng/YQ5hNwXbSU84TQ=;
X-ME-Sender: <xms:jLbfagzleclNseswi8oBKJW2GmjGANt9rvMCiJ8jPMtgy2KyFY5xXg>
    <xme:jLbfavEhTrex_4ii4ZuceIs0i4wYDa0bz4YFHbpMiTjNATJlCkRnb_lgJlyHN6SgE
    -bAaIDQ6m7pTuresj87VG0Umzp3rt12797SsOT61xCVjVHLpm1XpRLy>
X-ME-Proxy-Cause: dmFkZTGt21bw/QmlL9rsotX+DodTU+iGRBNClDobGQChd/0WpSIhsDAlFibrEKukT9ykEa
    tpDkZAwUTLWSJCyo27vl6UtjohIOdd+6JVRwt0x+kJ165MYJLlAo7s5qZVyaBgd3fWPtT5
    DeNrdsndUI53430xwJOfxfhlw8rLT42koS9uFGMjwErlL0P4rfr0uxEOJXIYG65Uwbfzlp
    2X6Ec8KGWZxhp2SsXX/TVzc9EEIYx/xrL4tCzM+2UsTb3294/ikF/fTKDaGwm5IK3MXBER
    +URng61Fxc95kltX95eaGCBANMfQ/EsKINeuY2LouEwHeS6Xmn5G/18NAamK0LsVcahIGS
    KXRYrrs3iw8muWBki9q9+/M1T+fgcJyHwCGzR+6W6LFwCXUfyhbnboOoVsoqixcbnw2X5V
    oFPxmrtOtHKzdbEAkDakgy9cL7MM/Obm5cA056oD3dQNhOglDtLCkIixNnlOr5oIiZUcMH
    6qU+kaXPCuUilpyhxQhm5phTIriVpW9WedgxtAQ8iJEPSbQIo+vM+O4tEUbCdYV5eZaZK7
    pEMjLjAfa2GyG0GrY/4yVJIQhPJvstCfXiDDhvhUYT0jy64q080xKgp7j8vpM2HEsBHLmS
    hAFrWhtoBZ9upz7Ye6ZDogavjtdQeECMcXkef2C1tLrf6cKum8kX97mT33gw
X-ME-Proxy: <xmx:jLbfaj1MScX4wUda7Ns_3q7VOHkuFDw_4_7xyBcrd9-k20oI1vU15w>
    <xmx:jLbfajlukY7QUlEp5S4mGBYOXEdnLuF6Uc2xAUc54r1IIV5erHgSgw>
    <xmx:jLbfaj_hlJyY5jghgyo0M23FjO_rzpoaTRAYhNBn4CbadBsSb8Po4w>
    <xmx:jLbfaorb0rnLWeMI6PmrMpmSYW4kTzUdrj6meEi7-MBG_Fv7Qbs0QQ>
    <xmx:jbbfashMAB28XQ3BtCcP8FKZS4YfsM8PvaiVkzpDwzS5tClIidiQvV5K>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 62549782738; Mon, 26 Oct 2026 16:22:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ApuIcoGem8Go
Date: Mon, 26 Oct 2026 16:22:16 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Richard Kerry" <richard.kerry@atos.ai>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 "Julia Evans" <gitgitgadget@gmail.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>
Message-Id: <fde274d2-8549-4fa6-b61e-518f84926ff8@app.fastmail.com>
In-Reply-To: <xmqq33tsqkr7.fsf@gitster.g>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
 <xmqqzew8wb3g.fsf@gitster.g> <60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca>
 <AS4PR02MB8336459DD1A4537A43A5C724EB612@AS4PR02MB8336.eurprd02.prod.outlook.com>
 <a8dc2d4e-bbe3-4190-b889-d9f1355e8d2d@app.fastmail.com>
 <xmqq33tsqkr7.fsf@gitster.g>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 26, 2026, at 4:17 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>> In short, if it mentions of someone using ssh and vim, I immediately 
>>> think they are a Linux user, and I may tend to skip those parts of an 
>>> article, or even assume the whole thing is not aimed at me.
>>
>> This makes sense to me, and I agree it's important to be careful about
>> how we talk about SSH and vim for the reasons you say.
>>
>> I think a lot about how to make sure that the Git documentation is
>> trustworthy and credible, and when we suggest using tools that are
>> unfamiliar or not commonly used, it reduces credibility and makes it
>> more likely that people will leave to find information somewhere else.
>
> OK, so shall I mark the topic on hold until you decide if I should
> expect a reroll or we'll address the above in follow-up changes in
> other topics in future?

I'll aim to send a new version this week.
