Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792977384;
	b=RghIIxFC7+CJ3qwk6pKUFtWRhsT7iFAXNiPsqzF5oERdbMn1MpGuJt9FndR3DqxiSwnU
	 5xUoNZVbVUgOPhHa5nIbDMEwumrvqhRjLOy5ygLAfsGr1dtSPvTr5oDOHsIcb9R2bBHRI
	 qT6cEsyJyGPCi2A61RqtFHPeWwNDTcepMvGdj7IdZOU1Y0k/dRtq1qpZ3AB7KGFWCIPTv
	 /993hdcGHK+iPZUgrjXDKnWq+prQHCEntJ6goZX2neGJtYiPa4bmTKdScUgOGpYRKW1Yf
	 bwu+XdbbtHMsRjlo+juniZFI310zxu03nkxgCSOgC7WFIPwOglNoQyWLWczGO7Elltg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792977384;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=BsUav2r58nACD38crccsW6VxS72B/0hKpAt7H9fVqk4=;
	b=qDvvOADbml8PHYgmwh4Z2dK/GGZXBO0WHwk5etiEJN1Xfk5XL8wzjJ0jCm7Dpj2Quix8
	 aPY2hrCTWufDKum3fdP1yWSnIecJOS9CFznSmxy9EGBex+wtXfKyzCuH8Q504FXxH8w6j
	 iZuNUaynMYsxOzxskOPHFNsfr2eWhgzsxUzImEz3Z/NMNS0/uKnq+x6itIsLGENN6HltN
	 XHpAgSbl85sAiBo0gpfcw7iQRUmcP5K2sm+2pYteMc22PzfB+h4MnxV9ZnbwiIO1HKqyo
	 COsJCuZjqoCu5TVZHhdL+m9NlvFPDCiaLMxDaQQEowbnY9rCo4GxUFoTHaQcE2rUhYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gIIvnZo1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=j3M4DYsc;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CF606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 711CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gIIvnZo1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=j3M4DYsc
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACE16140002E
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 21:16:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 25 Oct 2026 21:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792977383; x=1793063783; bh=BsUav2r58n
	ACD38crccsW6VxS72B/0hKpAt7H9fVqk4=; b=gIIvnZo1CLZEX6fvLOcdJM9dS/
	8fZbd79gcR5/WPSXZSA4FTQpWFiEryc2fR4uNMFGgY9v5O0U1XAGeYsO0oALoBgC
	TI/fgXEg8JkKV0sQFnpZX+PHuC1DPMoVF2UHdsc2+CqOV9Ng2bYO6f+krcplqXbP
	y83zTeW2kPNlf+xBQo4etgvmVdMIHqAr9pPPUOhbEtNUxMVz4py0YOLM5NyLEcfw
	Y9WhjDLve3H/WRy2J2XdotqVBO0Y/xj0/Banj/SIUkYvZKQtVzwGfA3lJAl+9vkl
	atFKRt3YbMStX/SRBsym7pU1SE/YM0EU2QTG1g4yb/Eu9HmqnUUEv5pjYT1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792977383; x=1793063783; bh=BsUav2r58nACD38crccsW6VxS72B/0hKpAt
	7H9fVqk4=; b=j3M4DYscsao8HicY+gIU/F+mDCqwYQB1I/k2swfDV7UTIoHhPJZ
	gLyJjz5Bxl8N2nWoalMAqoBSAbU3BQmk/DEO+4w7fWF2bCcEWaCtcTcNxLv7cnxL
	rcwEYfSINSmdTp2YHVwA8mFLQGezsempgJA5qHa4nTTXxC/vi5cYl+s/rw1nC17Z
	SDQD1hXjBFu1c7T48F9m/2IhHYU6NCepTcGEO7ApqpZYN/jjZc98iR+D3Aj1hqeQ
	qMFh2PSy2OF13fZdLc1Cka0jxpDjkiEjIApSW34+FWKJ+v2TjMyzIVvxxQHQjuUj
	4yX6d+9DbUMmDRYi5ZPr1TjczTx9BejppAg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792977383; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MEYmG5ZXd8+ye872DthDfE7KRv/TcOYr8drJNfB06jWLDoI
	m00VjmVrcTaCQRir4Xn+dil+4Z2A/0LtcYutmIu4MwaB9AMaxRUw+6xkFof4Xtmt
	7//snI+yAwdaHmYg0qqAo0TCvgxkLs4GOtVDHlDliibDYvqJr9oyJB8azStG0W20
	O2x5Uy/qD8OId95viVxC4lrO5Qf/+H4fVrss8WDSOa+rtUZL5umXN6pFtJzA79BB
	0ZK+B5uED9J0dnB3EUMzyDy71JTVmxxL0HojGAdlfdvH376SFCeN7li6O4jXIQoD
	03I9y4iyH3PjxtRNgZWx63APDPZ1PokbMWTEFsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:L93mfkEmSY2s8X1wBTvQGjzUy34fYu6YWug2COIsQ08=:BsUav2r58nACD38crccsW6VxS72B/0hKpAt7H9fVqk4=;
X-ME-Sender: <xms:56neagivm9ZG9N4GFNzHPAS_P30vqXrlkDYTUL3T3sZ8sKCTc9ebrg>
    <xme:56neasv3W4JTVuf_gp9DZOmXhowMIF8PLUIV8pCqnHsVL5DNShDyPuX1vLmqwZkwq
    OOveNjyZa93985Epd2GOEKyTnZTREzmEuFuITQZUI0EEKSrEuD0wOw>
X-ME-Received: <xmr:56neah4-sOOkKQY_gwGnjKJepUAfCrAsTu6yGtI3mmPxilJb97WoyVRZCDVR4HhF0Ju_YkaRif5YpNuAcidDTN8ZYjVOwH1cRRPT>
X-ME-Proxy-Cause: dmFkZTEQ21NWzZ9RkvjeHqNR/SKuJav588qAtY/Bh/IfFZOClGcT190is0sE6itiynL7Ig
    RdEUD9Ah7lQevPqfwJvuu82N5nQ6fTku/5epWLeR+uxBeMsmdW/MMkuDe+eX27ITWzb+1T
    zEFfZV1E0qM56QzogEHNvV7A/Vyq05lVxPcgfGB9LdatX+VKSBUa/h24z7rb/vH6p1YXlq
    ZYo/LsMAMOkzlg1A9ypPSOETMGbsIJcWM3OLlitdk4wUZel7aohABri5qr3sgUZ37Wqlj3
    62P6sKeeRC3SY6mJJhBFtDlNgM44094QvaRZXD7mMDbVSosb1f4maEwVsUbWKbKEIwn4Ap
    RvJERDeTKkIsBS0ThO185WQSfdDO6ZzFmEVOwimbVqbk1HeF2fUTqoweAu2KmldbGkF6AX
    QWDlNQcy8cBQ1DSKBA0SKwBwAjiE3jhitSXICu/u7NDhlGJhkA1ZMHpwcGZ6jee8X6eNe+
    X1HzhuA2mZnUUXzrhjqYfdSIxy6VJduER6iZLXRtHBZMuuwUIJc3L85poqCNBNHtrNphWq
    s4rrHWyaiKqsUQTr8ob2V8Y3Bn3lavIjcI6eALtusjbbQyVqboYVxw+Cgjo7AbGhTy5XbD
    jGidy9JY0BNle6U3VSWabU4zcEfEzLPB7CE25djA8JxAMuWrABvKGuG1moTg
X-ME-Proxy: <xmx:56neaoPWbnWTZOR9gmDzEy8pdlUpQkGcDQgK6irtaU-MiyWWkE-ymQ>
    <xmx:56neavvWJFaxbe1ZBZsv9-Oeq_pCv4p57QR4SU_9Q0PftkcSXloT_Q>
    <xmx:56nearYpaS8gyn63EdLCbsDAwBotDQYKUuBTXt222v-6AML8GbEvXg>
    <xmx:56neahy9EAHxd85hz4qceYfCWTFW7-dPfY4YDl0fNgiiGugrwAPxKw>
    <xmx:56neagom6QmB7Qps4-Fu9ibwRfYlrB18Si75OxZHbEoxCGFkQkgI6xEa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 21:16:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Sven Weiland <sven.weiland@tngtech.com>
Subject: Re: [PATCH] builtin/reflog: say "would prune" for named refs with
 --dry-run
In-Reply-To: <20261025191559.79141-1-laveeshb@laveeshbansal.com> (Laveesh
	Bansal's message of "Sun, 25 Oct 2026 12:15:59 -0700")
References: <xmqqqzhdy7pi.fsf@gitster.g>
	<20261025191559.79141-1-laveeshb@laveeshbansal.com>
Date: Sun, 25 Oct 2026 18:16:21 -0700
Message-ID: <xmqqo6chw9ay.fsf@gitster.g>
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

Laveesh Bansal <laveeshb@laveeshbansal.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> That will help prevent a similar bug from ever happening again, as
>> there would be only a single place that sets up how the expiration
>> is called, instead of two we currently have.
>
> Agreed, and I think the consolidation is doable.
>
> I suggest keeping this patch as it is, since it fixes the reported
> bug. I'll look into what you describe as a separate patch after this
> one, and the tests added here would stay useful for that patch too.

Sounds like a good plan to me.
