Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513963;
	b=HqIiDmnWOdzVYoUU9CWrTv1vkpMFT5l81tfBo5S9sdZ70rxYHVv0DaTKfgWUzjwuICqQ
	 OzqgnYV264r9Uo0HpfVD8HkQDV3gad1EzBo2fCTkX9c157/B4v0hqJi+OOXR+av3NWM03
	 uDg6p/H8iAVlcbt/PphiUp3GxMMyCjivp+OkC+88QmG7bNLw3Y4FzHzvG4qGjdDd0k8KY
	 rgIQVsJ1MG73sMu1aTgNyEBYNpRyrmZJ+iIPnG16pS4e1fpk7PZWSO2VW2IugEQ1wpEpB
	 YzsHhz0yBbQbObaz8lVCNq+o3eSisEKRocM/bgWTRSb+KRD7QCvJleIpjsqoX0keDZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513963;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DTgNKig3lI96+d0VGub2PlQsI6A+87yhY+D+HD+OG04=;
	b=grPjXKA2GoaYpVmd+14e/DhEu0Bx7bma9g6Y9MvIpqApImv+SpvRr19LZ1eb9YmrQuSh
	 mz0VgcDPk4TICke1u4npix4sUD1Y+9+3XnoG7ohFQbV0QMy7eLq77o5xxO3ARlJA6oVOv
	 9DsegFDUkW3iIfI/6zo5Ik279cRT62bf6JQJgUjL4BqIbaWnj4CwDdy4yBYL5PATaRfmX
	 jAXb1lrRR29ywDaawSQMXuti6bAhMdLIJ9Sr5ovv0kVO296aagrSSiutzXRyQw8zAvrsm
	 UDhmcFu4W4z67R5kaJdKTJOz7L15QMzCpiFB1OQkZNrL6IkpVkRAIXKkDlQUwUy/+6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=YI0hXNT6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=L+rW8BGI;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243D606A323
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3243D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=YI0hXNT6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=L+rW8BGI
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76DD4140007F
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:32:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 12:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792513962; x=1792600362; bh=DTgNKig3lI
	96+d0VGub2PlQsI6A+87yhY+D+HD+OG04=; b=YI0hXNT6ZPl9aItK1+nobqz4Vd
	gU7zZZrWNZxQAA6rMjPvC17ZACBTq3huTNh1dCKhYsbc1cG81jB7jYYtl5UL6+BV
	gZp+GBmR1eiRMuCHbHAEmBokN0lFB4fmYzOvxgSQtLa57P+3hnLaB5TEjKHRYi0L
	AJeWtaWecAnkla2qUcAT300932oLsfvhDAaWjfluEb5hR2+8Z97Uh8GaMu3m12yC
	X+UGKdvkYRuaevOHTNoK4oikAIkDtu3ntwGST4vRkULvKmTQzyMcFDKXnR+94HU7
	N+usRPOql4PdEm9VdRtcELGxQ19AoiGloXcVxsVtJ7rEOk1OlU/ls/m4XN1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792513962; x=1792600362; bh=DTgNKig3lI96+d0VGub2PlQsI6A+87yhY+D
	+HD+OG04=; b=L+rW8BGIXRGE7CsFv/LUpP9xtJCsDhcZR7yqs8RQWXb0U+pjroe
	F0p+nD896s7MZ+G8dbL/OQ/5pkjRuHnrU8dUG3b1p4zZEFkHITbB1B+lwPzFty5S
	tUQutl2jlNLzbiwE0rom/uRQP6hzI12d/giTOXreCmPEpc4aj/NQIBpzJXcZUMzf
	wjjwf8qNxZqB1BZws7BZWaHN7ZE++Se54oPLN5VjY9yUpuPm3gh8JBp8Dt3MpGka
	vnXedRs6WK1FY7jcBUtG5uw7+acZQPwQJyTQyJbWW+InOuAjlVe0mam9wethxSf6
	5T/EVyWKuV5mWoub8WtVqqoWBglf6qGNahg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792513962; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:B3MDgI65UfsLM1b/XONn8hpCStN6SfuorbZjVdIXgZwfI4f
	SfrFGmAdmxzXnm5FHJ6LLDELkvvKfCmjU4oO0EV2zwcV77GE7aK34Y11EZylEmeK
	Jw/sChm0UQEi38vpFWiltvduz8ftMHw/b3a/v3IkptWNpysWUTYxFFbBODjL7cek
	GthJz1BgOTYNTSxohtzD4hqmgR6Wh6fTN7daLpNT5uDJnG1IwhJnFMCV5aPJ0MAa
	pVk0Ks/a+a6SW+qow48yO+32XOWkn+xQwkUI9Xc/e44xT9Ag58ViQit6k0bneljw
	4d17hBVKMm8MZwH3tKBqtor8BV+82DYikDnVoSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lMhtOTOhYGhoFMynYXgGsr8Yk8kQRv/WjdFj0LsF0xs=:TsuW9f0B76Kfzo2zPkcwHs/TFVuw0qKyF4M+A6dLr8E=;
X-ME-Sender: <xms:qpfXajDvK8UMJpoUF9n59qqIZPxmEzYhsuwM3uvIU-ngDT1D3PSQVQ>
    <xme:qpfXagi4CPAqK-kYMkqZezf7jtLJw0__PImogLFryCGYE2peG9XtgFbyLqjsAaNwQ
    ug4OsDp1WXtzIMD5FZcHtCAEI5U8sguNSesdWiuhMIVBtTdUafHG3k>
X-ME-Received: <xmr:qpfXajmZVw54G00XO3hWOtTPsC9RbJeeSFdO4z9dlQMNeEIqp69S0k6IJdeDqGktg50PEJb46qrxuGqhIgH3caZFAWNsIoT8V7Jg>
X-ME-Proxy-Cause: dmFkZTFekSWWbd+oM94tcANOR7X3OgLiwV8H9FCGf/ha8lFnU0o49eFROCsKcHeO/zAKB3
    8aESVBmJOudDxpp2hVvDFXqqsW+xrHg7usAsGv3qDxRTNjd5/ZGLOmaSgN8Xi6FOGC9Sa3
    Kvs2h8M2S1L8i4kd2JW8kgkV5ffQcMQrRUtmNmEhLIpsXkR34eloxNtIJM/fREh7p/E5aF
    QlmpxCQNRnxxDO4AtcyNOpTdNkG3WNtdNrGrKQkCMWFney5Ef3/qlGnrZZZBY8Y5MqfGTJ
    mjSZeVji7ErdAT9VZX72DrljIVyZrvhE+pA9LqHTZOPjaI8jIul4aI6E7QMrBLJbvhKlZD
    bY/IQjHXwXbN+BknlOHN4BEEcDhb3UbYl+oBzJZi8TAbn9Er7qCxD8GBaNIWCs8amMACKd
    PqcrGdGVZN+Dy9pV6Ex8VUkZECYNw+wQUTAn/H6newJ59MFyxwQ5kRoF8sK5bwAIohn+/P
    r+eeJ5axD6jOpT3bDJ/xE8QH2pwdkoYqM9NiRd8wWsew6LZr1rlsl+CxiZF351fACldBNe
    2M0aA8o6/tGzZ/Cy6UIb8i0K72AQBvWzr/enbTFE2lsCLP5jplWamaeIPKn6Fe/d9vyyH2
    t0bs3ZUToPE7u6eTDAkUtAxwEeyTfa8oGG8ZbrOcPbc/IY1uW50RMNm6r1Fw
X-ME-Proxy: <xmx:qpfXakqBoVb42vQsoC3a5Lbyz9PUX5NWUtVzKDimGO7pr91b8rd7cw>
    <xmx:qpfXakG-ZQZmNmkwRIgtnrqXeE76Wry1V4XvciKYwJABenIIahofDQ>
    <xmx:qpfXaoy1wjIxB1THfaSt4RuYeUm6x9dMxrjZntW-GIobG1sNc2DKMw>
    <xmx:qpfXahoo_tjIC42vLZDRrWIzVW2Vsi8JL3oaEoaUPTDTGATpLMeTRA>
    <xmx:qpfXavINxo-ilJIb516DZbzN-vO4aCNWMpawUjm57DP4D5j3Ng59jaaN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 12:32:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] MyFirstContribution: move preparation of v2 after
 review discussion
In-Reply-To: <atd7xT6Vj59omtuN@pks.im> (Patrick Steinhardt's message of "Tue,
	20 Oct 2026 16:33:41 +0200")
References: <xmqqa4o94e0r.fsf@gitster.g> <atd7xT6Vj59omtuN@pks.im>
Date: Tue, 20 Oct 2026 09:32:40 -0700
Message-ID: <xmqqbj8oxrh3.fsf@gitster.g>
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

> Nit: I think this would have been easier to review if you first moved
> stuff around without changing the language yet and only then changing it
> in a second commit. Like this it's basically impossible to see what was
> moved and what needs reviewing.

Yeah, I was thinking exactly that after sending it out.  Will do so
when I try it again after sleeping on the topic for a few days and
seeing other comments that hopefully will come in the meantime.

Thanks.

