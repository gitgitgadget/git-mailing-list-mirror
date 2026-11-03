Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732448;
	b=eP+2FSEmMid94uSuaUK4jZ5o9FzQnkUl+3vgxCNV2mOGwVqGbnPXe1ydylCVMX7DoRpZ
	 StfurX6S01C2zy38xFD/bPMs7oPHzV7QmgyhMGc7dx1BiCdSFypE6aVACmf+0iG/DSzhB
	 jUj76huQxqLrcbU0oex1FgW9buH7lwqBFb3EVVPQmZu7m/Em7xWJg1M/52GVZQW+T4elf
	 2HXLT67fHy9SHmojuKE1SmD0MKG+Fl1plBZZT2U4jTkjeasBV32FiRtAxEL68INryAHNG
	 wlmsBNwXkOoZIf0OeIfnOTAuvI2T2+etvqqa8ecSN0oQ2UakXGJ78O8i8wNsrsvJpOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732448;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=RPkI3UMT0PwQ1RyjvXxzxucwryTToIyGkPEQoiubMzY=;
	b=PabJuNBAfoApr6gCGGxwVlMSvVCQyXzkwozgwDZcPh52AZrExUZQMh5I2+2wgKtLla46
	 jirGgBBgI8bXTB6WCaoZdp2ylvEic/0Mhbzev2fw68px2ZyzYpdkw//dhA7mmgSp9UCeG
	 Oa1CAWScNDkQbLSvetHSrQi1sLUyDVhrVHU6wzb+L7TIyO9do/HURLyHEZtZD/9PNqtut
	 HmJoA9GqCHqMfWUv4PcXzDpw/JMO0LETj3tu+VuJIL4UDhHzVbA2ji32vn3cuOoD1Njfl
	 B1bCu6fAnXoU80cZk9S0N4d7V0CflXarFDCUW+OBIQkCcRHe6hCAeKBZY3VoGWOPokg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fj+NvuQW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p45nYMJf;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF58606A32E
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF58606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fj+NvuQW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=p45nYMJf
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3828514000BB
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:00:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 14:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793732435; x=1793818835; bh=RPkI3UMT0P
	wQ1RyjvXxzxucwryTToIyGkPEQoiubMzY=; b=fj+NvuQW2OFZBQjP+pOO9yxgdP
	FKKkbQ1tFV+xGq2c3KZpKGtGZV3dac/qrzz4uq60DCLSbizieu9TmzQCTI3/9dFe
	4iScmf6muyjukMH/K2EXXeGr1ZO6k09IJEsX60HH2F5/e93qzWsjdu6JwJWCynX6
	qT2te4CUfdgTL6gU4FwqV2s+DIpK4p+KYh0srF2Pnn5eSIjyD3Zio4LcJpgPR2j/
	lLJypf10A55ebcYIa+N/cGr6CaYNbhRkkO9z9yyQgERZ6HwdIQhvTWW/ZUzD4QXJ
	1u9GVvl2iSEL3fivPDqR18ocGDi7dCdwVuPEmgrOfeJJ1KOX0hyl+m7HBdMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793732435; x=1793818835; bh=RPkI3UMT0PwQ1RyjvXxzxucwryTToIyGkPE
	QoiubMzY=; b=p45nYMJfe+cL9ICPEJ9crRi+nILuYX/s1LSAL8TsNxo6WBtbZS3
	o74Cd4jneSjeQDO3KsBTz291iT1IFJXcNZOQsd9lrEsXeWr1WH+wSzQbxbQ1zxoC
	HQRbwLHwvlOx0qGe3mZnWcYFLWUbLp0F9dKdRo+G773ik6F81Mu6ow+a72b+fwHH
	tXKuEYAayVVBnadIRgnEzSoiB6FzM+DEWwGUgJSTfDmfy1HG7R2DXhD/YVmv4Y37
	DzncUf6mrvZ4mU/oo44daUtKg7n1h3fXa7BU4GBBO29WTAiOaqui80pqqQtZxUFP
	rLA6NP/WhaJWKOXlGLhTTXQ6PbNqvmC2ymA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793732435; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ESuK190ipPEAbRYxCMSSMDnFEsTC9qAYrUsj2H8Lltf9Ack
	qEkOOSbm0z5XQoxbe2HesKaeJc9oKH3NaoxnH8WAAYQ0P5iUEBup9mRRuQlR++2t
	kwBPlI8TC56mnyfKyJjwZWtH0tF8IUXr3me61psmyou4NmAE7m6XmIeBUC0FFBAT
	gubISRQrt4f5MKeD+87aLWrZdh37Ch/vpAi4yY0iJMXePiDEBsw+8ubCdceLDSg7
	3YsqxcFNa5/F0cNxmMz07M0RPUhrRhB56GELMhgQ1RX/hTbCqjU1kwYQ5+RvrD59
	DX55wb3l9B2CRTqQAjuD6IWijb0pKqaufsRNNGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:P4Qy0P9mNiDTwLX5NiBkFVegE2EDK3S5NYm9NeNqZQ4=:RPkI3UMT0PwQ1RyjvXxzxucwryTToIyGkPEQoiubMzY=;
X-ME-Sender: <xms:Uy_qao-OBqrgVusHz9uz1iJCm2rFNQY8WEnfodPy4JDjYxLlLFsIVw>
    <xme:Uy_qaoIkhWgKw_ekuVf0hMnrDiMtMjsQNOo6gOv4LCKIluGi39HfBpJajiuONz_we
    rtS9m_xiKogg9Qc_B2rvTqruvuL5JOdi9DYomv75VrqyDniIUac0Q>
X-ME-Received: <xmr:Uy_qarZf07cfMdebwixqpfdjaYRUaRkCq9UB8UnOTpQn1poKCVnCNH-MDqVuft6DC6yEaJFBfNgwOrh0u5b9567gLAk-f5H3URvI>
X-ME-Proxy-Cause: dmFkZTGtWzLa82aNYSkH6KEGtYrW7oM1AfACmh2gJBO6DlrNd5zkxRfV5c/XCijOpVJwa5
    zmS5N3WZHPrNHAA1k1dwByx5yflddY7byo02R9eq/OQNk9SpPfJF48vV8P64e03G+0XPRg
    2+2WoEMirwOfumuPdH08gyh10o+V9vFTvF0KmRIOeOV6TYI7IGOHDxknfVb8fMufeRKZF2
    xvYWZQFNp7y1vivU3DWHMahJqP330HufrTnNROtKEgU4tKxMYB11hvBygZdW4mNX5j4lcD
    Gbw+RXJ2wYc3GTmDdippLCnWDYQza7ZN9JsH1OfcsU/wKBoH6DbfK4JkqgDdNPtudAWfjX
    eoz0HTXaZooPox+negFlZxbvo4g9PVp7iZ4ayhqnhmeOV5ZnfPdQX5Y3tCvACTdfLeoQlT
    ddI6/YA0rrrkGb+LYihEdI2YFZjadm4Twj6zJEzk8k/ULDN4rL18c8QDG91+hZ14nYwvs5
    BhVKgVnL0k1hD3HGzADWtjffWFHbeBKR2yaCr8Pz/JrdiWTjMeErxK3Wr02sx2IfRRSKCk
    a3sFI1FSiGOwM7mrd3bOOD4WvMkCYBxWZC1yxx7GqGChm0gL9XIt9b2KSlmi3wpIMpTKpr
    TFcHc9KnWNg5EEnulzYyQy6FdTq6DdOaRv+8IYFLRQ5t9Fp6fv43VN5ju+Ig
X-ME-Proxy: <xmx:Uy_qaiLIjyXk0yZN62wTnl-dNyOlVYHpK6W2tjaUuDEqJtv03GEY7Q>
    <xmx:Uy_qahA-wJGsJ74pLEKUp7rEhQGncWGuLwJFO_kbww7V9I1S3jXcrw>
    <xmx:Uy_qavpN7ufhp6zPudWeGrNt6UHzRhhFTi8xxf1K63f2GmA8Dm2PIw>
    <xmx:Uy_qakjZ0PZtoBu0FvaCiMVVH4DrFpnGOhuXONpdLqJSAt2VRqw56w>
    <xmx:Uy_qaoT7hhbfeNxUIV_HDpFRHl0iJ09ACrr0pdEm8LU3ex4WRbC5P1mz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 14:00:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] ident: remove unused author_ident_sufficiently_given()
In-Reply-To: <aum2GVDloMarZvwi@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Nov 2026 11:23:21 +0100")
References: <20261030173956.585250-1-gitster@pobox.com>
	<20261030173956.585250-2-gitster@pobox.com> <aum2GVDloMarZvwi@pks.im>
Date: Tue, 03 Nov 2026 11:00:33 -0800
Message-ID: <xmqqtslx7nam.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 30, 2026 at 10:39:53AM -0700, Junio C Hamano wrote:
>> A pair of functions {author,committer}_ident_sufficiently_given()
>> were created to replace user_ident_explicitly_given() in d6991ceedc
>
> Nit, not worth a reroll, but isn't it "was created" as it is a singular
> pair? Might just be me not being a native speaker though.

Neither am I a native speaker, but "Syntactic vs Notional Agreement"
is what makes both valid.

Treating the "pair" as a singular subject is the strictly formal
choice preferred by most academic and traditional style guides.

Even though "pair" is grammatically singular, it represents two
distinct things, and in this particular case, we are retiring one of
them while keeping the other, treating the "pair" as a separable
two.
