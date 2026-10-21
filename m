Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792617900;
	b=aiUhmU5Nb/R+u5KBSZDUkQzZuYHcRrpkzUYC5DKyYNPGgvCDMISbv5yGxQsUUQY2X/5r
	 EEZ11A5zpdrgcmZP/iO1A3ScNbhcRTtKNIllnu8FFePDLIOoGwojfBpyIOJT+90/La8BC
	 ac7+WfIYFY7XGpen+MDrLd8LSF2hs3pzRMIBQCRj4V0PnvQM5ogBiF6P9FRa6fNbz7pPB
	 fETEbCLU9Ho27zKwufsSCu9MV+cdb435wDxJwpJKa/E8OtgpAlkmPfr0sC3l1/AXX6qiG
	 bFLbsZ9qKFquiMiX2Xfj9ZjBGfIseGFmHQvOerua5YcV0UBpLBD7GGTImCBBEsfzALw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617900;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=ZFwY/6yFQiAE4ZY3puRthuJXIvr+MuqmYkrA2BoYtdE=;
	b=jkFV4TL7XEPEUfNvsuPRUUhf+SN532pYUJanuWG1K1EGKNOcmG0UvUNUWQCSrTIfaxYT
	 g3g7XP02uiCB8yRxLDigDo7LzrUwTo/Mhs9q2CjDywfIbThasM53YJUx3rnh+9cD2ifeq
	 +4WRA0e+r2z+V0cam+ELiMaLrpHqeGpe/+z5PE22emW0qalvEGFvqlce99MVYeC78X9Z7
	 5oKR7ASQnIalcjOymaRZ2Yl9Tw+VCElJTSttxerSqWnjuXDi4t4isWlbl0I0GfIr7vwuk
	 Nu0Mh6Rr6XQ+5gSUPZf9wC7Lu+La860HEvUrnAAd00NPJqoEW+FfAJX38TLPOWNQq1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=eLTAjwU9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mz2JGffZ;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A985606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A985606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=eLTAjwU9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mz2JGffZ
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E4AB140016F
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:24:59 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 21 Oct 2026 17:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792617899;
	 x=1792704299; bh=ZFwY/6yFQiAE4ZY3puRthuJXIvr+MuqmYkrA2BoYtdE=; b=
	eLTAjwU93Lo20oeqqAM5wb3mS/CU45v3Jm0moSbO7llFgJtjEtKC8OfJk8P4rBT1
	dLumCj4wZeqldt3cTlZpwg6zxVThjPfpbSHU9lY0LH5YE2f42kRhpMF/tBb3GCgg
	c24/YP76OsGs1qiSPI+SlaE17asdvYrKBqeA2B4yFbrnn6CvdD1PxkE2ytK/9cQ3
	FS7pDXtdFwnDVEVqwrqKxAs5BhVDToUt6RK0rAKMXHDap4B39FQMzWPxizPRtcsy
	mtT5qP8Jpdaa95LQ1PwzUJRPvDQKaXenbFTvgUVPLGOvHEtmgaZpcMRu27WAKe6G
	im5bBZAXOeUTEB8w7O+s3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792617899; x=
	1792704299; bh=ZFwY/6yFQiAE4ZY3puRthuJXIvr+MuqmYkrA2BoYtdE=; b=m
	z2JGffZwzQkHqzE3QvYTuQ6s7qBLUMbjEiAnQDr6Bm2IXB5/Rrc/UXRupxMZlFGI
	PYHsHsfBkqLJczyaL8ah2YWTKbLp6ldoZB5NL/n7pVftIqF9HfeCv4AD8OBHJn/2
	3jLPx7+198y1llgjIjkPoFTPopGFDR6HbAxjhgLicW6JMZf62IYXJG5efT+TztjN
	5QN1w3ovpH98BbfLjP2ToubyUAt0Rgzyb2UcHbK4R7cP5swb0oJb5hOKB9qGJV/O
	XUA6sJXhNuIP2KFsN/u0JcA8/1xk72SmvESoGU9JcAh5crwf7x3doCb0TkCzLdzT
	kmsM74VPI8BHN3ov+YR5g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792617899; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QEM6Tsbus0g6JE7tns0Y2cs6XA9bOSCK/ejvr2gruxaBcPJ
	792ci1N9sbJjg22pUK9g2Yw8uW4OVNj6V6L81uMM4Tysk298TItni8hBYEV6yYrz
	EdOAVzLijfcAFxKoBexEvN2QAAcDhaAhLxxVPPJP+rDGJNrCAFlUEq3XlUPOtZgg
	bO1Z59S34D9i1uSkf1wYgoaAASIaXVN2rOaHuPq5z8yTdi5lbaLgX1PjLR36ffQL
	SnrAG2k6N7zF+R4JyM5LYX7SnsI7UTfXJh4mShlNuAPOs250pCybQzphdRpgaT12
	rBkZ/00Ln9bi5deQL5Cpo1Re3LCVGVNsK/Di9fA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:B5rcuyGUCH/lWxdW2dL3GBpUgtjUIbv4gHv/4olTUR0=:+eNcO/wnYpQvDzVgzmZtis6Fkn4aMjVcaI8J252n14o=;
X-ME-Sender: <xms:qi3Zan2dI872kK4RUQezhwEShbXqOn1iQtWh4Nr2lP6XVxrlXkzKlw>
    <xme:qi3Zag4wczU3RYQxYKb2mptksqB055gxyXg_TuBpYJjp-7skyyazU8QwMAZQJW7c4
    bZydg-gs_UO7B52_tod41YbHq69QY_QZXCw7Ctke2ABcJcXYp_OlX31>
X-ME-Proxy-Cause: dmFkZTGzd92cmZaa2Uia3ta6Zr1rMR/Xq+ynYXuajiGLfpkfu/qGvNURrePe/rub/1Wr2E
    ZLcSpmFgt7Z4aMyZ1YswC2rscP82glHuV5bZQnSlt45HszIBRNlv2qd4187p+vLAJ8oUb0
    dtQ8U7NDiLnp8fSZltvdgdJR/8HqowHskzVYmKX2lf3wW+UQUuvLZ+U5NM+QoYmQGU8j8/
    S/Ml16fAbxCWS2Swb7PpHgIK6FprROet3o0VBuB5c39ANh6Ga+QsKTISg0QnABT7k4HbnO
    L3BDDMqsQeN7M1pEn4bpgNRWxPrtHUbzF1mJxSjN+C5Mv0/F7t9y36smHKL4Q5Z34q1FRv
    lndulblUBRa/Mq2zOaC46BqKMnGuVbfOtxQio+JIvX1r5JWrkHwxaWTMBzVGLfShVVbDnf
    Z9rds4JKb2CGFQvVToK/tU96fvP9s7OJpIViF6t5P0wwqEBeWahZzK/LXbXAVeKZ66eIQF
    oB7dndMCgHVfxPEkqx5tGoCmsjCKOxeBAhRAbvHDSLxl0Xjb4uLVCbhlWl+XPTul6qWAhT
    dnOBw536aaF8MclbdexOFtEHXU4QOb34c73nvx7tcV3hsZh17oF1Y+zQ4yc/NA9Wr6ZYSq
    YRR9GrBrMe7Kp7+3pzaD/v9Q/3ru+VQNEJCuHkBWECf5MrC8evm7LPiM6dIw
X-ME-Proxy: <xmx:qi3Zaiy2z42GBd3iN2kwy2VKnBIhHhP7ME6QwFpfEEXeYH11FwC8Hw>
    <xmx:qy3ZamCcdgCVu729H4nIiFrJ4kes5NZt_6P5yXFWCVRMpgENLKfFiA>
    <xmx:qy3ZanZQ4JWLFLWaOJtxiIXNe7zEFAdMNYWUWj3UOtixRs2rJf6KOg>
    <xmx:qy3ZamjHJeS0mRA4G0hAAEOvXSv_mz609VQCMf7fwZd5xbwHiXAvvA>
    <xmx:qy3Zags37X79a-U8n9DxNTi9Velje7-I9qAFi5POZQxW0F8aI1ckP_r1>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E1D8C78273B; Wed, 21 Oct 2026 17:24:58 -0400 (EDT)
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
Date: Wed, 21 Oct 2026 17:24:37 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <25e3db8e-b011-4af4-99ff-5ecb840e92d2@app.fastmail.com>
In-Reply-To: <xmqqwlrbotyd.fsf@gitster.g>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
 <xmqqzew8wb3g.fsf@gitster.g> <CD1E58AB-4884-4433-9AB8-460FE9A882FC@jvns.ca>
 <xmqqh5igw7l2.fsf@gitster.g> <xmqq1p9kw6qu.fsf@gitster.g>
 <xmqqjyncuqwk.fsf@gitster.g> <xmqqwlrbotyd.fsf@gitster.g>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 21, 2026, at 1:16 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> ... indeed, that is how I caught a handful of mistakes over the
>> course of this project that I suspect I otherwise wouldn't have
>> found.  Once found, however, such a mistake is easier to
>> correct.
>
> Sorry, but re-reading my previous message, I realize my preference
> was not very clear.  The last sentence there should have ended
> with "easier to correct with the ATX-style prefix format."
>
> I do not have a strong preference either way myself.  However, this
> is practically a brand-new document.  If you think it would be
> easier to adopt and stay consistent with the prefix format, I am
> happy to go with that direction.

I do find it easier to stay consistent with the prefix format, but
I also ran into an issue where if I format the DESCRIPTION section
like this:

== DESCRIPTION

then I get this error from `make lint-docs`:

gittutorial.adoc:779: has no required 'DESCRIPTION' section!

So it seems easier for now to stick to the usual format, since
it feels weird to me to mix two different ways of formatting
headings in the same document, and I don't want to update
the linter to understand the other way of formatting headings.
