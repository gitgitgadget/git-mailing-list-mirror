Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937638;
	b=YgGJdeI/GlU9biiVzhXwTOVZFxowc+Mn1OGAGgVykqm02sCj20kw9NsgYiP5tqutJVHm
	 CcbGoaWr7E6okSZgLE9XgEj+ovoPdIBskzTSV8gsHvSS+cUCqqm1T0MBi9NYZ/Q1e4qXD
	 ++o0C32FNoRwr4Vl5bIULo6pagYEIctY9FXZUHHuaOzSeAfsNVfEgh7E5+flPpj7utCx+
	 ldC49YxfSACH8ML0P5dEx3aTG/3zJOCh4Qrh9ii07gzLFnLz9z3cQw2AtFohyD6fE0KEI
	 KcaCKVI4jin4ys3I+gjB0VEnvOmSkIUMxGLsneSwkDA0F+BFL/44qFO2hTIcuQ7N8bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937638;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=sCbLpub+LoydRaif7sFFfla+vGKfZWgb2n8z6kwV4iY=;
	b=2PysVY47bP/A5ymopWu/jFRfCC0AU66MtwoYEaLPUgrhxiAsIGrAo1FW3VGjq+na2R2e
	 1Su5WM1ACSf/woGGmI58qswPZvTaffe2svH2JRQ9/S9mbvkfUoeWwdLcZuHuPv/3CD01q
	 LsOQPIt+Xod2E6pduRh+nhL9dxRsuBT7c4PK2fZELsDY5VSo63is3ErSFwlwvoq1JM4hF
	 Jf6JOXOTJnn+sAZMgqqFgqwxz+Eysl03tdUNg1zVAvxZOegJfbENUetkuf6IjS8iRBqmC
	 DHVE1JPmaRIQZ6eLOP4u1+uQ8JYvrlpfsrIbXZNYstvFsuDf3SkABZ/RieiCnKkInkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="CdqTq/pe";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mYLQdTC8;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F8606A334
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E97F8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CdqTq/pe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mYLQdTC8
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 501A31D00233
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 12:47:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 17 Nov 2026 12:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794937637; x=1795024037; bh=sCbLpub+Lo
	ydRaif7sFFfla+vGKfZWgb2n8z6kwV4iY=; b=CdqTq/peENdzjY3upknet/GMOi
	wXUvdSMp4fNheYMnMdc6m+p/cvDanEcYsuwcr1HAmLGBjvP/9ZALEPLQC0V8Y9/7
	YZY5nCPBDO/Ea2Gq+Un8GfKtnSZRlTV2uVkHGxXk7o1m+lQnGVRyVXkq9nYGQOjk
	onaj5XRR6gvRqgIhg6Ju/dAgI9O2St8aChbBoH0vjhdOlF5ZOr1W8kU+BbDjlU/4
	znUMl7dJ/JIU+9t/ewnB9+OSkdzljVJ1tTD9JEFLYDxZLYPsQQ86aqiE0Kx6AVMQ
	IuIDmGKEsoaYacx1OX5mtROOm5stc1MHQba+uY6tingg84tx7R/KlTiRwoNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794937637; x=1795024037; bh=sCbLpub+LoydRaif7sFFfla+vGKfZWgb2n8
	z6kwV4iY=; b=mYLQdTC82GjP0UJuchBGkRjXPGV73a6XayMZfpRsuJOqfFYy1dA
	eNNCIbS/OLkKy9UVf96FzUzLRdU6aN18vX53kQjp1rTrcWPgoALzuN4PlFcSXGws
	b6T00CV2T3e5dh9fGJCaePeGaMsVeBvf7/jrsNyik+drVDvCNLrV+7ykUvtyvaKs
	DgbouXGuyU2ulPTzYxLEleuqqr3Stmi9yipvpzAoaZCWtbUZ5O+33njyYPztXYro
	xwG33HJjJgxfyeRuV2sKe8jNejxBKnhZ0wdYfeLYw1+B6G0DY9WYAY8FgOT26eXP
	YtyyG1Ssg/aUS4VaZV6itDEBeje0jGJygwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794937637; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:M+2M+Q0FJkM5ji+bxkoUypK3yr9djPFYmSZe0I+GAoF7ARB
	uhFrAf/v0U+q/jmxyySEKk1hScOdmuhlvj7WRZ+3NwwIdmG5uL01Ihe1/QEQF+3A
	2xG4c+EArPGpCoDIBt7i9Jm7d7gUkTP+c2wj5Hp5rw60uFixGvaEbLoNvHrX/Wfk
	TWhzT7pDxtPUV8+uW+m1mGoxbGVyPsQxeYy8LOaZ9EcwC8/LSlWVBhyqWGLYFn5r
	7fEi/peGybJTwlJ40eJzmypwTgB9IEgvPqCl2dRF8UIH3e7ddWsqE8xN5/+vO9E0
	jx/l3Y/HjPGurCdJN6jTxRHbLwNq0EwoCYpVVKA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2+8fmZ2Zp2BACELSKwRhBh95xL8+Ayh96hUGn0Izes4=:e/tTXbEtQRxaQESt7//uKssZAitR1O9Fda5hTlXfang=;
X-ME-Sender: <xms:JJP8aqYXiuvfD50c0-Kw3m93IqYClkzkjdsRgVy7XShX5Oqtq7JKhA>
    <xme:JJP8ak0t5c0ZthJqmOpI-Rdfl8D80z-8ih6CUPQj4v6tAhU0k7Lh-fcPbdh0xxowm
    Czk6ROK6wjmZhliRQ6znc3niERKKq1yp1Rro4t_NoXzV1YDeOxI0vE>
X-ME-Received: <xmr:JJP8aiWAwU4ah1MnVfsPCUu3hs7Cfuyn7RvUrVBIynkwhhoTFj1dF2MMoSTaCrVnjbOdEQLRKA7qIutyfqOLySR2L_ZcbSXcPwPz>
X-ME-Proxy-Cause: dmFkZTGo9Y81pQWAs2MecnS/kdS1+9uZT1si/FXnikow/+LU7fIXxXM6YEWSMfwu/R1lDV
    oRKk2XBx9+6qwbjFzrrQ0G8KJ9kfhujY0YNfTYSc4IpQs9VNbnt2RY6pFBCwkx74d/XTDp
    f92Gx4t7BMfz4EeLmjxTDASOJVZWlNefmjvwHUZjMTamB3i2t3GO7C4vY2PliPP9h+558l
    ABq4IR2qPF4X7RODpGHMhmYwC/FRF3pYzjJ//Dlgd8KnImdMQwPHK4XB7sRsRXjABPCUn+
    0USlLqvROwOBeXeFJ+c++0EJDDECX+o8qA0UfkMRBBy0l2RK8F9w9cYEcZLuTJ4D0Vw1kd
    hxtAX7tkHAVfR7NCNvBfluvxBP7ByMRozGWWG9x+cK0Og39fE/fgTKKIEZb0eMMo6jLngW
    j6suPBNPzINiBir5MuRqqCy0k4iIFzcI01LTuUq6WYjacVovRs270hTcKnKc4opVF7Piqf
    BLWVdHnaQHQu+ItnGtmAuTF0J5VfRCeqTRG9O33WHoWc/UFJXFEyrXZaPcHOqgrVb8SEOu
    yNr7VvjPZi+NPqGw7ZhioEWVOW18IWqbj8e0BiOXLuC8YsRBhjlIv+E4qBGMBZFc7xs2Et
    F5Yq+FAyZ7OcwwIuSQuOqbdgNwcwzYc8CJttSjz1jOYl7IpAxoyJGxmLIRQQ
X-ME-Proxy: <xmx:JJP8amVRa4Litcq62IT6TRFBAuNFOCHpTVZDqHoLwEPvCWT2DO_B9Q>
    <xmx:JJP8apfhT_wmYn5IFdZpzM74KPxPwykhQJjjDaj9vwEVgdsk1_mmiQ>
    <xmx:JJP8anU4dibdtJUFSS2uZL14XQh6CHK656C3TSLKx6gteW6DepT8Ig>
    <xmx:JJP8aqcxvoasXgK0fOFgkuSdyoXxKGIg7aoQ9KZh8jhIVQHH24aDZw>
    <xmx:JZP8an--cWa4UcDUPQw5XIYtzF1N1VPdmNkhTkXsDXVk2bgvnwZSEQ3I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 12:47:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Richard Kerry <richard.kerry@atos.ai>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Email formatting (was RE: [Outreachy] Draft internship
 proposal: Improve how command arguments and options are scanned and
 parsed)
In-Reply-To: <AS4PR02MB83363999DA64DD82F6E25FB0EB7B2@AS4PR02MB8336.eurprd02.prod.outlook.com>
	(Richard Kerry's message of "Tue, 17 Nov 2026 09:41:46 +0000")
References: <CACWAS-UqbkgfzsJ2283=OgoUHRs-FeRNYc0zkBR2y0XD4jTWsw@mail.gmail.com>
	<AS4PR02MB83363999DA64DD82F6E25FB0EB7B2@AS4PR02MB8336.eurprd02.prod.outlook.com>
Date: Tue, 17 Nov 2026 09:47:14 -0800
Message-ID: <xmqqik1vfizh.fsf@gitster.g>
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

Richard Kerry <richard.kerry@atos.ai> writes:

> I don't know whether it's because of my mail reader, which is
> Outlook (I know it isn't a favourite in these parts but this is a
> corporate machine), but this email has come through to me with no
> indentation and no blank lines between any lines.
>
> I don't know whether the guidelines explicitly mention this but
> for myself I find both these properties make it difficult to read.
>
> There are a small number of fairly frequent contributors to the
> list who are also in the habit of not putting blank lines around
> additions (or even putting just one after the addition) within
> long blocks of text with reply marks (ie '>' characters).  That
> also doesn't help me be able to easily read contributions.  If
> there is a mass of text with all but a handful of lines starting
> with '>' they are very difficult to spot.
>
> Would it be reasonable for me to ask that the guidelines should
> request at least a little bit of breaking of large slabs of text,
> whether plain text, as here, or long replies, as elsewhere?

We do tell our folks that all text (commit log messages, code,
documentation sources and e-mail communications) must be
line-wrapped to comfortably fit on an 80-column terminal after
getting "> quoted" a few times in the discussion exchange, which
means that the practical limit is around 70 columns [jc: I
line-wrapped your message above as you sent four long lines, with a
blank line between each pair].

I do prefer to see a blank line between paragraphs, and here
"paragraph" includes a block of "> quoted" text, so I do not mind if
somebody adds to the documentation near where we talk about the
line-length limit and line-wrapping such a rule.

Thanks for raising the issue.
