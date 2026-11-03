Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691034;
	b=om6O1F+/q40WDW0Sjp3ymSeTmU5/L4+gW+pt1VX1/QFNQWK75AxxhmzwWuR8SzoXjENH
	 GpAWFBNCTfVx458m20KHsaAAvu85A4S/8VBuD3bAAf4DihqK0DnKa4la+/bpfLbS3AzZe
	 uBlDPopvKvgwWjLMtPIRw+RheJLI4SnZVhGPKGyamzkkS05S/FYhX0ZSBE8PTRDN5Gs71
	 uUydiiFNd903EvlOLlEtO4zcXs3q4CbelwmSI5ykTx9h8FuzEjXRE1xAI38FqEObye/Ci
	 naCXgebd/jYpwc+hcekGFtobY+no8q6lTfa6domk6oO0/AE5hThKRn2NgtvWEE3OfOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691034;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Up/JO60ONm7XCs3+xag3aZjVmkF3Hq8TWX/76MYIVxY=;
	b=H5L8SfYxfUckUoBqi8AjDSRfBSvxPuFHsUFHRZ5gRJHIIUNaQglRK6BUJnOQiyvhUWwo
	 pJwSFSzH4jfzvptrQNnRoVXfOiOQdAytSTYbcCyT00nSMNtg9U2znF+bbhgDl7WyWLX8P
	 +u6L07/odMHXsSlRSdGAQotRNnS3oKtwXfeSue7s4y2aPNOd2EBmWMdkZr8Lp5fSLON17
	 Ue0Uw8823rpDTvk3uOvc+yvX5IxHlzxXR0z/hstRxDhvgwO3Aprs5Fkly8+V7GQg0sPAl
	 3REyNBFU/eVOag387yv9ITsRXXkQyxJShPFwGRDJg/n5fnKBfD5kjkeB6DskJ8GbGcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=OeHtqfUJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IXBQKNrP;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC31606A329
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC31606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=OeHtqfUJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IXBQKNrP
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 15A8D1D000EA
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:30:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 02:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793691032; x=1793777432; bh=Up/JO60ONm
	7XCs3+xag3aZjVmkF3Hq8TWX/76MYIVxY=; b=OeHtqfUJkG1WVwXeE8uTgEss20
	RXMnMYQhSKdC1MmGETImtGKWU8TV23EiNWfnYmqhRCnmFbG6Q7R8bzObDg98kLQI
	7upJz1uL77AErT/dVswknoSpezY9bVq46o90NqbzDRbT9bBta+eP88zSc/QVKlH2
	LUXH46zzGexMBKq7xGZQ/hCV0/JU0BeDLnNqtxcVJ84HjdVPZ45iBNoORiBL1wVo
	peEYuhzOgJdyQWs9y0dL7z/uFCzxkAoKY/IjoB0GN6qmhwX93Uasx7n9ouaFs8g4
	ujckS7/9CPDZuUaXHae4WnEdVCerp0DdX9dfkjHivvnkuVqhUj9tXilX5/rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793691032; x=1793777432; bh=Up/JO60ONm7XCs3+xag3aZjVmkF3Hq8TWX/
	76MYIVxY=; b=IXBQKNrP3AuoQ3c05r5svIVtUXpIW/15YVKKaGnIDuUwXP7HPtC
	8HMEUkxCYgV45dUg6LJwGo9lkMXyg8wCLnG+tJLy5xkFnvd9WfG8YMyD/K4GokbN
	NWQ1P4Pj9XCfmgL67ZLwbBCGav66czoKjWYN7b3HK71q6kx256HZbwxXIYlig9/w
	tlt0KxOsOm1M/RMACiZVGSvd7R/VHaisv6QuvLdb8W1WhJ5iIl1YmUBDZ+qwA9kD
	/vr74FihLH0Ck2AsDTZCb5BydOiu8pZ5dEn1Fs4gcfOvA4gQ1ai8n8HPGirTq3oX
	qTo8EczwwcMcNgFl8Mq+9IUxGMXH68iHq3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793691032; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:TUuNfCmyNixz9YN1ge9f/i7833099OIOE5UhIhcArZFQXL2
	BVvmxJyb+Xg+QRDY6EuZZo9fes73HvU8T3DZrf4JZeyscJl4tcz17YzcjsKvgcd8
	2l5c2l7XTfTATLuHSWZ2oBLK4O0fOqJ1iGhu+zuFDTeMCkG0pa0NXf/Os5Hi6+w4
	aUTxvHQoyYKgAwjWsGn5djnyFxZDhPh/MS5NmIqJGPDBrjyqfXnoLlLlWOl8FNCb
	VOZGDCPvr9VdQsyb3wFWLDuXxk32hMqmtl0z0sGSH7Z3VQWTmjwkKkjxV+i8p1A3
	LPw4mi66m/ggOsPiUCOKa0krZ4hQEepupD1+4WQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Hgd60ammt+sP4H6XwLBO2n2LmCvCuOWCB7nkLeLjV0o=:sspl3QW3pbb5C4ypjQDQloke9t0NQuAUxroudxAaR84=;
X-ME-Sender: <xms:mI3paltPZ3CIjHnd7eH_C7ulGNoaCTJkEzf-mjzxkYawT6cKHrAflQ>
    <xme:mI3pal6D_nBlzuurHcLpHvcCdF6meVjY7Ujhh6pysRB1B9gTTw3m_kDRfmUTnRhB-
    3IN2WjmkMF4x7GmFuMsJ0LFsTZnsghplICtKmsKkNob91e0GgE9c_c>
X-ME-Received: <xmr:mI3pamJripl4TwORfaiQujZZk4Cq_jfY07NeFf0TpRhXIh02L6TiVg>
X-ME-Proxy-Cause: dmFkZTFtkHyE5LLy523Ia5Ho6hPlbERUAyjRctxZPNTwfbsc7F7wjOZfI75lNZ3fKMrjOV
    STTgxex99Xq6bejkbpwmaPW7XkESm00qX7/O7MSt1WHgftNsaVSOFXfWdF2Dlv/Qb8VH0E
    wwLHrPWGeuvsy7oA5XpePwuMjOuo+l3bX7kx7HDr3iOG+q5mu1pv3tK+3hQwBFEkfiikQq
    LKNlugl3QtX787Jb+C17NT3aJz2hPHLyrQDZ+Lhzof/bvJmJpHQhZn9yPF999ikJszvobi
    U8Dq35UogYeWrwPXq0g84jdiVXDB7nJO75UmiRW2Lf/lufYa54yL6K5Q1cNOI4ISJQ4hAq
    1uGQvgKZXnu1sUm13n/cRo2k0aNip2wyvOHhHcLoQXo6oe5Lraf1wtpzoXH1aJKFrBz/be
    O1/dsxPsHIs1TkDVmNYvt3DF2lCkFvmGmmEcp+BR1bKZoVmbbX73nobZohDHt63ixmvvRh
    B33K2u8V87gREqMQRYOfvwfeE9cuKIxqtKFyIUYlfa8iZE96ghneAwvUM2fNspJZPqcnFj
    gF3oyUbAg1nrvTP8pXjMbv7W5z9VBilwfz4FKBpdghCPnonfBl1p6dCkblZdWvejGWwNDt
    IdQp00cpzd0u11P/TlJPnWEiZE15hteCTjx8MZduj9SfetzURL2Qwjzac0FQ
X-ME-Proxy: <xmx:mI3pal5IjJ9oB6vx_aEW93xnXbz404-uvOTtCzuZYQmqUlc2yB85dA>
    <xmx:mI3papy_yJzEprzw6BTt6OKtrIgy36jVv5mzZFYYPEkbYrbpGulK3g>
    <xmx:mI3papY-ARTSMG0sj1C8weomwUwAErYjlFBJ6UWpumiwv5fca5S-EA>
    <xmx:mI3parRz3dZcR6lWlMKhfh1Bs45T2BiezhAVJoMy6vDoxrPZdQ2gMA>
    <xmx:mI3pah7PEGc4cEiyTXW_0fH-qOtYcseu_J3U6yv2VkkrVp3gRDDSOslX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 02:30:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7cc0dde2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 07:30:30 +0000 (UTC)
Date: Tue, 3 Nov 2026 08:30:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: Ejecting things more aggressively out of 'seen'?
Message-ID: <aumNkxzE7wfa519p@pks.im>
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
 <xmqq1pclc210.fsf@gitster.g>
 <414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
 <xmqqbjbpptzr.fsf@gitster.g>
 <47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com>
 <xmqq1p93ofjx.fsf@gitster.g>
 <auhfD1ryB-7JwOYl@pks.im>
 <xmqqv76fjjhg.fsf@gitster.g>
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
In-Reply-To: <xmqqv76fjjhg.fsf@gitster.g>

On Mon, Nov 02, 2026 at 08:17:31AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > One state that confuses newcomers quite often is "Will merge to 'next'?"
> > with a question mark at the end. If we were to document these we shuld
> > probably also document that state.
> 
> Hmph, really?  Just like the subject of this e-mail message, a
> trailing question mark is my way of saying "I am planning to do
> this, but if you think it is a bad idea, please stop me with an
> explanation why I shouldn't".

The question that newcomers often have here is whether they need to do
anything about this. They basically wonder whether that question is
directed at them specifically. Maybe rewording it to "Will merge to next
[on <day>] unless told otherwise" may help clarify?

> >>  - A topic goes into the "Waiting for response" state once reviewed,
> >>    where it remains until the author responds.  After staying in
> >>    this state for a month or so, it is demoted to the "Stalled"
> >>    state, and eventually dropped.
> >> 
> >> We should probably have a rule that says "a topic that did not get
> >> reviewed for N weeks is ejected from 'seen'".
> >
> > I think that's reasonable. Becoming a bit more aggressive there doesn't
> > make too much of a difference anyway -- if a topic gets evicted from
> > "seen" and then later on regains interest then it can still be included
> > into "seen" again.
> >
> > By gut feeling I'd use the same rule as for "Waiting for response".
> 
> An obvious alternative is to queue only topics for which I can, by
> judging reviews on the list, at least say "Will merge to 'next'?"
> with enough confidence.  It would reduce the size of 'seen' and the
> friction felt by contributors when their topic is once queued on
> 'seen' and later ejected unceremoniously through no fault of their
> own, other than their topic being forgettable or uninspiring to
> others.

Wouldn't we lose the ability to integrate topics with one another early
on to see how they interact? And it makes me wonder whether this will
overall slow down progress of a patch series if it gets merged to "seen"
at a later point.

> I do not know which one is better: educating contributors that their
> topics being uninspiring to others is something they should not feel
> bad about and giving our reviewers easier access to these candidate
> topics, or being strict and mechanical and queuing only topics that
> some human reviewers with a certain level of reputation have looked
> at and have not just shown interest in, but have said are ready.

Overall I would say "strict and mechanical" is a good property to have,
because it's also easier to explain. But I don't think we should put the
bar too high for integrating into "seen" so that we still retain the
ability to test the topic together with all the other in-flight topics
well ahead of being merged to "next".

So maybe instead of someone saying that a patch series is ready, the bar
should be that the patch series has gotten at least one human review
that was somewhat favorable on the overall direction?

> I can do either.  It is less emotional stress for me to do the
> latter.  Between hitting 'seen' and then later being discarded, and
> not getting any response or reaction at all, I am not sure which one
> our contributors find more acceptable.

Hard to say. In any case, whatever we choose, it shouldn't only be
acceptable for newcomers but also make _your_ life as easy as reasonably
possible.

Patrick
