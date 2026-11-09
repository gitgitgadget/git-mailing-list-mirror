Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208018;
	b=JDuShTitTkqbiqLSUQK9GJaFKJZbcUE278rhEMofS/JkWUIV3PGAjOowNidAxnwr3DHB
	 ee3EupqIWkbr8ib46T8mN4bSQBEZc1Q3medVHIwkbStAGroENJ/ID7S0z4r+rWKxPbWOu
	 i7bOUTfbm8nyTHq/C/VEM9pY+uqpg1Zi32K+xBwht0QHfNOZYxEVxGG0NPHLUxYsri0Di
	 jtIiYN4NcxWyrOrJlfDEo1JQVftrtm+Vm9DkfMhXOPT0n44jzMK7OTKt8cGejWkbOV8Vy
	 RXoqMs48Nq1No0ALmNkQcyb4ucSOPirSeq9YzB+hGSYNMrKMc3Cdmb6uqqv9al3TDlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208018;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q75FiPZdZKP5rA37iKrge0DVPGKANl6+zRAxOiaJddc=;
	b=AAx1dxNjXi3/GxsGGmolUN+Iyl59jDRfLvsTDIeJXEliz63kiNAyy/YeSsBMzJc4aOFb
	 uly7ycDXHU6G55mZ6Tn6XfhhJP8bas1kCIGm9BeZ22J22p3zMlp2Ad92FfOKGnJ9dPoG6
	 9x9khde31nL33UXZ3UhBheTtoSbSwBLTiBtjwaBXs29IVk2UXk9c127Zn9Fx60QEOPlId
	 8bDTxX0sgqP6o/wD281TvRWuTlfWq1iHE0DS3QNuZoHJ/4zF5qZFlc2rpFjO6s8fZfblh
	 53/ttpzwLTDHv/sTDEwPOW+PBIjs8mHChngMH250PfLLpS9ND83l0vDLGmdLJ3TkZ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GqN7rHCU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="xW/QQUQZ";
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D3606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 07:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D9D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GqN7rHCU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xW/QQUQZ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B198C7A0120
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 02:06:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 09 Nov 2026 02:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794208017; x=1794294417; bh=q75FiPZdZK
	P5rA37iKrge0DVPGKANl6+zRAxOiaJddc=; b=GqN7rHCUsmZiaVCElVsNtWEexL
	Mm1RteZalLPBONUuQgHX6XamEyEH2fm+izWMpUXEkf2XW5M3rjtYQmC/roX5Uni6
	8+ass1/X5CnIMsfzKL68YL6Nl1yLM5pytwqgseY/4g5HSRHZ7ca4OWXy26Ys7O5r
	fft/G7y8ASCAUDHdzhjCNme/BSnQZp+LI22qN24nPoobYQ25Pr4xb/KNWfjGzDMz
	FF1mFT4lab/3/r3RbTaW2xx2P0U7r6yfoSa4j+sKTcoTN7kAUwbjne9heinNUY+W
	B9DLbGGkrcQ607s4ORPXg3/DyLx/atfplTETbrLl1zpuq6/NkydvxyooOorg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794208017; x=1794294417; bh=q75FiPZdZKP5rA37iKrge0DVPGKANl6+zRA
	xOiaJddc=; b=xW/QQUQZxab2I8oojsN7sCi0nV1oNtRwdWG31z5Zkr8KpR4BL7w
	pwSYVoveEiW+jvFwLA/fxobWEc+NalxwugR4R9LEMRqyYcawMRGLRrOCofhcvQPZ
	BjVJ9hvbegF+KeNgvhALCQqpnRwotrHslBR6p/dCzj0VzYt7gNVHwmgSr8QM1ZXr
	pD+6V1Z02wEasVwK7QD4vF/vyH+tFGB9qpn24VdEU57h71YEMRIIVg8PFMOXTaP4
	+FhGxJMNhl/YVsWCQqlDt6cSFQtrqaG3TqsHdUyXTPZh56Rj5qXdcEtC71gimjd9
	G5I1dz3Qjj4hAsJPwMyA9fVDv57j6RbTxcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794208017; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:URVs2q64HQeL4uy6K6MYwNomaGm+q4dLAxW0fbhiKXNJz30
	+rja7SVkFa7feUyS4duG4Z8SyD72/pX5ua+KI1eNs+x/Oap4Iko13PNY+nK9gFrC
	PNTtFespf/hdLL+waNAsk93bgU2PrxGxh6vHk/pD+xVjLnCvdzpLT+AsU9bb7L9f
	/j/2U7T6j0P679Y+d3n7cQP+8ZilSXelCTOasOX6S9aB6l8o2ijrXW3gEAjtfsxw
	32VJY7doPVD4A5IKJhPGAN77YUVySspYdHB9SBiUQx2ZicpYEA0/bSnS+zjHGmfQ
	UNXojKhWxT+JKV4bKPAOMei2NptQUV2nnXWeZVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DjqNmsUAu4njKeQx8dBY7zONxVgpFxU+kLYBym/7urM=:s5sVaQdeWz/oEsKdGaYSaP6bvvQujIeOKld/d0SsrQw=;
X-ME-Sender: <xms:EXHxai4FlwnjPt65CLZOsSoaEINKURafDfr6LJL3C1jH4O3wyGCL_A>
    <xme:EXHxai5Ji9H5AuzD50HiqRJkqxZa5UQHffsH3imbFGPt1R3EIOOtha06FqNOwpBpP
    HKuoJkR7ycon_tYiJgfVv_4YZFrxcTL2oIzAeGQS44U4eyOhjSyUg>
X-ME-Received: <xmr:EXHxameKXyRvK2_xp2YlqX9FLaHnL8P39wP13p067pAUQJYvscenxdwPV2uBH-lzBas_F7g>
X-ME-Proxy-Cause: dmFkZTFZaxKTzCaW7LnGyyuDgt1RWECW7Wy14NoCfM5tt+poyZBIzLjXZgvEd+nJLc2hH0
    s2kNNX2W6TmRLxrYa3bLWWziCVsyS44TGVmQcxdvUY/lxdD5mg1K6BHA+id7R/svLms2eV
    ZPjEtt/Im5TeUgqwT65wCF3oCTccUgOySlt6J4uLHce87mbrzNPsk9C4aEnoWrnzSBBv4Q
    z1suDLaWxtwCntUNtJR5tBsOsbVtGStZB7zMi6TlaOmh6Z8/ScYktXf3TC8RHjnyPz7FYN
    o/CHR/DONb1xiT+IgcIV8YEGxB1zL2fehXQB345g/hJp2C2q7zUs4IcSVcpT1w6YJHaVIs
    K28CKPUGbsXz9Ps5M/UpW99VKm4gbjTEifHerf9WEmdiHkODCHTPVApiCE0ATEUR9pi0Ss
    qIRdzl6/7NUYb/xgxAnx1QmmNypPGmIPzI7cyhWp1GM5S5xLRsOZTVOojb8IH8B90eCoj5
    fr3j0u9W1/HCt00RvCUGWu79nSFzx15RaM17lrsVSaGt0iJEIyL3YRnJTDQmXdwVrRA3x3
    TjYAdLykotwvWpfOB2Neq2JpXy5LlfHQznfi57QGzh9zlyHhrRBSTIwR8Xvpts4hU0wckO
    eK/0yiwm1VU66TbyHdFAXfHwqkmZ8rTxbPWLm40rVR1rstEK+8328RDAYbGw
X-ME-Proxy: <xmx:EXHxauCFGhWBlbzHZuyc_XJ7jujYa-jWXchG3cb64nXyLooSYZ4Hjg>
    <xmx:EXHxah92UyiuL5VH6kxUyDMDKPgtnJHoEJcpPiRl_DErp0rZa3OAHg>
    <xmx:EXHxahJz0zwGS7GKVrNNTW3PRRTgwSV388NU__S-7QEuMkXNs1evQg>
    <xmx:EXHxaig-7Re8H9IFHPZAPkEArVkRo36fAQ18ossWXRRQXtyCB3eH-Q>
    <xmx:EXHxal8XKmUQ9KcdDQECgFPR8axhysI_3k0sbMqoxh9MdSq74K_vot7y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 02:06:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f00c8ff5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 07:06:54 +0000 (UTC)
Date: Mon, 9 Nov 2026 08:06:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 02/12] rerere: convert flags into an enum
Message-ID: <avFxCywngxJgwylf@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
 <20261106-pks-rerere-subcommands-v3-2-4ff164d8fb81@pks.im>
 <xmqqqzgxlxrq.fsf@gitster.g>
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
In-Reply-To: <xmqqqzgxlxrq.fsf@gitster.g>

On Fri, Nov 06, 2026 at 08:39:37AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +enum rerere_flags {
> > +	/*
> > +	 * Auto-update the index with previously recorded resolutions. This can
> > +	 * be used to explicitly override "rerere.autoUpdate".
> > +	 */
> > +	RERERE_AUTOUPDATE = (1 << 0),
> > +
> > +	/*
> > +	 * Reverse of RERERE_AUTOUPDATE. That is, update the file in the
> > +	 * working tree but don't touch the index.
> > +	 */
> > +	RERERE_NOAUTOUPDATE = (1 << 1),
> 
> As you have updated the comment in this iteration, I'll throw a bit
> of review in.  The new comment is not wrong per-se, but the one from
> the previous iteration was sufficient to convey the same thing.  In
> other words, I see no improvement in v3 over what you had in v2 for
> this bit.

I wouldn't necessarily say so, as an unknowing reader might not know
that we still update the working tree. I myself certainly didn't, and I
had to dig a bit to figure out what happens with this flag, mostly
because I am not familiar with the rerere subsystem.

> What BOTH versions lack is an explanation why RERERE_NOAUTOUPDATE is
> needed in the first place.  In other words, "How is it different
> from the lack of RERERE_AUTOUPDATE bit?" is not answered here.  And
> I think that is a lot more important thing to clarify.

Heh, in this case _I_ thought that it's implicitly clear from the
comment of `RERERE_AUTOUPDATE`: it overrides "rerere.autoUpdate". I
figured that updating these comments would cause some discussions, and
that's exactly why I didn't dare to update them at all in v1 :)

How about this instead:

    Only update the file in the working tree, but don't touch the index.
    This can be passed to explicitly override "rerere.autoUpdate".

Patrick
