Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176411;
	b=ZnAKaGMSzOZFLYLOwRBn8M28YWwd8zRzDuNBtbWPd3+mllSVCoadc0cTWlo0LYK6oPRh
	 tqXutHScqzcozNLWXrG8ObvuzpZcqwuB/mtZWeFahX2Kr0vu5zRi0szGXT/CJdPxiTmNS
	 gjbMn472GSjjBE0RqIHwmhlQ0WAB7bmYPqP8PU3LOnVTVHkhG/aw6wI4hRUnSWfE6jIv1
	 bEwmh/5QtCz3spGOuM9uLJJnSPyoBn05YcA5If8d/kqUANeQPKpeR8I58fBo7yO3HbLTU
	 jNaebLD9TAR3u5DlxuLTPmvYSyTf9cwzYEoayYZ6y1v7h20xrSUyic4xXfR2zSQXrzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176411;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8/P+MtI6Cua+yPnTAcfFvblNpb+sKAb+S07Aa8cm9/M=;
	b=bZ8IVrd3Q6GlooeheS2+ANNnhpb1fRpnldScfZB0+Dl9b9tMyvEGgDFoNQ2Ihdao/RlX
	 iFWQ2P4P/kS6SPJhECzHXn2JVomKCE9W9m3b6T8CMHl0qkVDS0f9STJVS5ACkXa0hLohX
	 8MFQniM2j479jb0VInZI57UsJvbXrpBHP+cAIshIKOjrLr9mPislXsHMmx/NjpGUOR5w5
	 PpPHbBTI0y/heIQgMQPxomlcGj0Jyq1kbvfQbLLOXNLJEhqyi3hLEL5dXh6dQc1sCk0s5
	 ahEfHkY4+sWpWJz0YS0hhp6OWEMUv+DSJvUuIc9QXm6PD3X5rrBy90Jla6lQgfhjYOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gk6ePLBp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="lnn/7bq6";
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D190F606A31D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D190F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=gk6ePLBp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lnn/7bq6
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24E497A0012
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:33:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 04:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793176409; x=1793262809; bh=8/P+MtI6Cu
	a+yPnTAcfFvblNpb+sKAb+S07Aa8cm9/M=; b=gk6ePLBpQ5W6NC8IksEZp3u3UF
	vJDhD4Ik5ccuPrbT+0H4m6vwyY9nFQ7mfALgVO5vCRM/nyrUJBWvafMMDw0QR6iW
	j3R5EFWA4FJHR4znP/t9oCAv+JBBWKqX03x7aML7cXyGLgAKMJLvNVl89yhX5td+
	q7kLtariGPAhzt8Ou9QQdk8ahMMO6dDUK43nNhqpj4zXhgWnRac3CUtpPj96eR6u
	h7Bd3FK0frhnM+m5bRKZz6iCuMnHsH7/k71Lh709E1Zc2uqRYqjMxa8JIcgOgMfq
	v7kmo51eXJm2fhMsNa6xTEcyZ+q8qQkBbDE3azN2UIWXQNMHvV2ndoQmK+/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793176409; x=1793262809; bh=8/P+MtI6Cua+yPnTAcfFvblNpb+sKAb+S07
	Aa8cm9/M=; b=lnn/7bq6Pe9/UMLJS3m6qPdMOgKXY4AaPXbae+5aoadPTUArCD3
	73jpdO5ft2xF7r/jv8GYziK3ozbgmfepG4JnN/4vEBXRAPkxd+ewlSjizUaZrExj
	WIMVYvl/hp3YUQCSA0ijmXyuNpu5rSqAcRfS5m1S/krQkMv7mJbHhQ+wGHHXanKV
	/Qasyo6wHUmBUenr30pAlBnclRHvQkgxEsPtfy/FxPrV0n+mbb0IqSwoppS29WGk
	/EJ9R/BQcxRRZg4h7mRRhUtUS42JcnjJ1qo4FtrzOxBCRe4uFQrM4fm/GbDPCaVZ
	c2zhvtnxDt7GkAhF527CewUtriQZ6D+QGFg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793176409; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SdDJJ6QkjBpbmSAoTIrQD1udICFRIR7m+qbwBxdREbx5ayK
	ll572iRZU0FOQPZ0uL5/Sk1MgStd/7Y5A4WN0BbgLB4V0KKvf3vJ3nN7JWT4xyEc
	PeblD2D+Bn1YEwlIsAEJ2qmETma7NRfaa6OdrUbkungyW2UNvjoNlzKWuqEAiERe
	YPvp2cKmDwyg2StlqPlzH/yA93HDUxLwxoFVoRf2yM0Df6JocTl1JUu9+EN4fBgN
	jM07eR9cpEDKknFD2+m2KpNLCSsnGPSvgc/m3nYIWLqcq32v/yP4TgIzB+QjMtYo
	l23G/jJtT4Qot477Js7zz2YlAh9Ed/OyZaYQN1w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fpeccN9sbD6Sg7BXjhkaF7x6PDzM149zThu0wx/bnLU=:5rwqY6O86Y+J3la4XrZhRqeCWF3N3Yd7cuFiQcvdpnY=;
X-ME-Sender: <xms:WbPhavCGbUfoiXw09cMfEL4ZdgjzmnIzSIA_2cplg5Feav-yVOZXCw>
    <xme:WbPhas8L8AdQ7VgifoVjPrFdhiu9tnId2tXGlolJUZjfZLOg7Q57-iO8Ij2lIur2j
    PI3PI-F2ZCgjFQKfrNdLck3hK4t9p6jaxqBMwARx0NZVZGIbL-_eQ>
X-ME-Received: <xmr:WbPhan8JI6VErfp3mac8Ol083TshlBgJcUq1nVFmq5luadYXYz4N_A>
X-ME-Proxy-Cause: dmFkZTGJdOb81pcQtoncRJ7WYzIwPxB0oBuD9La1zNpqaCaj34gVgiE/SYTzAkIo3CbxsN
    1xuuuMYeXTF7bpOo/lpTCq5JXZChgqTtFwQ9qJ3gQjNkH+Qt59lSRIwsQ30zfF+2kL+TWZ
    83+k/2D45slZl0zF0S0E5nr/XKFoF68/MfQ+gUpOWo5anA8ss09oX88iReKW7rbWIcAuI1
    Eqw8TeD8u197gJQlyibpg6CBDGs82xI0QAk8OqxFFs0EkGWUyyvptW13Lo/2pIoOEMfQkG
    qjlc2QIxa3wyzOwJ6JoDkCrTLWH+zBR26lIL31s+8I/mBsm9CPm0kv41ClBxbg3EDTePdB
    5QxqvFTHo4uy/94nzS5EJ3HHLoDc/6pIfaajFEuhqOKNvR8BgCRskU4JU2gcHyrYFEtHww
    qGdWBLkr+x/tmyEbaoDv5vXV0YBnw4n2qxDB1cPt/H8N1CjpDtvGSgseZ2rNnGmepCCFNP
    WhJuTVo/IjzS+Sup1O/vlctEyidwc07SYL0ldp7frXA1hG+rcPCkegIydt7/VROrQCajmN
    v74+KIimj1lg5HJQ+MXByAJGQ8LzvYnFcGJjbOQ9Lz3XYPPuvXHkUCb42g9HOCKWilFpVn
    35Psm+f4xgU8TUhu87ebTo4g7C1esJw77HELr8/hU+Ou60oeNVF7fyocYGLA
X-ME-Proxy: <xmx:WbPhareoUZZ13k8WftMnOGuUJyoeSeSRs-K84pM2eRe_pWnaDNDbmA>
    <xmx:WbPhaoG7bgOV7AoQZC3RcVFF4wFerbp03ukGKKwmuWDqgl2Ut1g34w>
    <xmx:WbPhahc9GbYM_2XXhd1sEgoXpNXxzQkSHdl9YhK7P2UQGqmPa89XJA>
    <xmx:WbPhaqG2qOZiVDXrHB9K9q9HUQ9WvbdMlIOznerjHdzyqQ60sYBuRA>
    <xmx:WbPhalGNwKmltEzFeoaMrFHx3KxBq1M-bDkT3JTc0trZO4Qc8SmYcdbg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 04:33:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a8ce326 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 08:33:28 +0000 (UTC)
Date: Wed, 28 Oct 2026 09:33:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 02/12] rerere: convert flags into an enum
Message-ID: <auGzVZj5vbVm3-xf@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
 <20261027-pks-rerere-subcommands-v1-2-d836c36ce0c5@pks.im>
 <c23c4593fa3add2b40613febb2911cfb@fastmail.com>
 <xmqqzevzhqyq.fsf@gitster.g>
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
In-Reply-To: <xmqqzevzhqyq.fsf@gitster.g>

On Tue, Oct 27, 2026 at 12:40:45PM -0700, Junio C Hamano wrote:
> "Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:
> 
> > On Tue, 27 Oct 2026 11:46:45 +0100, Patrick Steinhardt <ps@pks.im> wrote:
> >> Our modern coding guidelines say that flags should typically be passed
> >> around as enums so that it becomes trivial to see what kind of flags are
> >> expected. Adapt the rerere flags accordingly.
> >> 
> >>   <snip>
> >> +enum rerere_flags {
> >> +	RERERE_AUTOUPDATE = (1 << 0),
> >> +	RERERE_NOAUTOUPDATE = (1 << 1),
> >> +	RERERE_READONLY = (1 << 2),
> >> +	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
> >> +	RERERE_NOWAIT = (1 << 3),
> >> +};
> >
> > If we're moving to using enum flags, then wouldn't it be better to
> > explicitly add a "RERE_MERGE_LOCK_TOKEN" to the enum for that case, 
> > rather than have this value only documented by a comment?
> 
> Perhaps you misunderstand what the comment says.  It is an
> explanation for the next line, i.e., it tells the API users "If you
> want the 'immediate failure when locked' behaviour, pass the _NOWAIT
> bit".

Yeah, this. I guess we can help that though by documenting all of the
flags while at it.

Patrick
