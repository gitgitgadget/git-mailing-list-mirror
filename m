Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630020;
	b=OzXxcfgBtdEISE59mbmJKv4UUaEh48EDVQygVFV/tfZtg9uey3/vekria3JZB5mtv28U
	 lEFcIrPnaYPeDiMqe2sRs9B1kOEk7t0vi1bIeIWr1kjvzoM3qHfBwHsdsfm487NHl1fpV
	 KUB28EgVDKHZ9qIuZ1UqPP8kq2tqA+63sXIkcu4/GxSU4iSJNUuUdsr5NZ3/E5nWoj0Ix
	 1v/0yIydi496vRBakDVjbhAFnSjzFo5Xhvj+BVP+poRL6uWw1RDmXY3ZP8n/zARCqDZFw
	 Ad5ICrhX4VVbLHGZ0ghUk/sWQ+r8RDyKrgKgt7ylkWdYBiUpXuSPHjhAmaURbInxovA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630020;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=aB37x5vbssbcb8njAik2zd0swIrL12al6DnzGwJ5Yy8=;
	b=hZ0dF0gWYcBp2KyjsSwujCwxnQSsiZXUAAtTInC1wjjHJ1zsZtWJ685yfTgHBSWvKo2P
	 NTUsZgGuOgUWTl83G/qdx46EvDu+fs7CruH3lp0B14dzQEBnAVp8d8W+3K/v4sjxoVgcW
	 HCo0yIto1tTHyP3wHgS4i40AsAEoX6yPCaWqeeL7bVX9EZQeVL0jm4d7QGfCME3yX6cwB
	 5lRiItCH5SfyRcgIUSuvnVWSaYQN9L/BaRXuigIxxEdmMl/tzGxOIMhr1gVw/id1bT0IB
	 sCuDE2ABGf8q2igip9RWBGSSw8GIHJESiOR1m4vzIba9LlHo3GD3Ev5zSWMkAAuqsEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Ked5r93E;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QU3dwaOd;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E120606A91D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E120606A91D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Ked5r93E;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QU3dwaOd
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A43241D0015E
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:33:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 02 Nov 2026 09:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793630019;
	 x=1793716419; bh=aB37x5vbssbcb8njAik2zd0swIrL12al6DnzGwJ5Yy8=; b=
	Ked5r93Epl2yNEPydlaiZICTr7xaJxrW/sJ13/CBaBXe6CvxTzYbHpfJT5ouaygd
	EpxtvXegTiCURuaKxp+MMO8byYLNe9fNerYdnEEnSkCFNjCxe+5etXfqObWMlzdn
	seDGbIbLn81n0PJNlpxQ4iFceIp8bUmKoWZs29MMoAoRIg5nxOqwZDGQvAo1C6YW
	wKg4vuYUPC93Y4rg+pbunrrjquU+/25VsLjSC4rxt3qO3W76l6HwUMjBVB1quCEx
	svXHX5X8g5vlgEQvAn2SeHdQi8ntRsfx9m2YyjU687Y72v9fnVYJwA9d8ujhzGbJ
	ueozvOuBrq0haaj147s/rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793630019; x=
	1793716419; bh=aB37x5vbssbcb8njAik2zd0swIrL12al6DnzGwJ5Yy8=; b=Q
	U3dwaOdyys8Xn6RYSpAgB4rbubMSePxWlAp0kT4YdJPjhekKZ1kNnj78iTbKiK9P
	8IuOPC3//eVtp7GafpA2plwIVeoaetjtT5lx/Vn7R04j3VGBTCwTIrYs2t2WBY0B
	CximlHniT08OjpzHq5OeSYDXsgwqgSEKs3LFs7xqBIE8kESG41e4XoWFBf97VJw9
	vyCNSlsZHbaXstRsZLTmup+lTGeKZYvlAgtrZuYNJNOkQ3VWwD4+CKhEsBA9upmP
	NkrUqlc1YhPpv74VV3fP6WHF28aLVnDBk6iqnskJq3UvJEvorqj2W42mOaCBGIsD
	gGB3csvNGxBllsOIUDTsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793630019; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dXtjNSs+KN73r70oLRY3GE41PvI7vEDILJIw+fB6YmMKuRv
	9riiU6XZG+0IWolIG7PHnw1urkzJ+9Sqn/9wG5nIHjaWrap4IayXFjum2cTvf8ML
	SLnHWgFAPeZpBRtHmKCVWWxzP/M6u74Ik8EMAzTa+0MUXeKNTwX7INjqtojVTWHl
	LwofCr5+zBt8rm+2N+v+x0gO4lIm8XOdDRVX1atFuk0dIM9XUikCvLNaZm44gpzI
	azmw8ShuSQ2OKj+pSFOELgvrQq0/NUsjcvbhd0uvB52/CrWyUSihpNi716woC1Zy
	caRvncNJ+AQMOKtIZDoFWdoSrVfGDUvnbyUmk/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hQywBq5j0MFwxVFC19PcLCgf8yyHfyXyJA4SlXtsNb8=:DiKqqYSX6NSj2KHE+eLuTIZuH0cpu0hvhgb8NvnZimU=;
X-ME-Sender: <xms:Qp_oateGyL39Sj6zhPznPBk1Kl_6kt44-DdJN0AGprnA_Xxf1aJqFA>
    <xme:Qp_oau7UK69dbKWyJJmrke97uMGQGzi0ixkxCtSZkvtbtmzM27Ti-O3bJwCkxEiTz
    kFlQCbUnie9VoJfYWjtqojbJ1z5kmjz87Lu5d9sf0pGOd9jAbIqpDzW>
X-ME-Received: <xmr:Qp_oagXYIu_Yg1cfCunVcuH6toj_eWbKWEKdJ8wXu6G_y19bZ79gN2DK6CUlHxfpHpd0iw>
X-ME-Proxy-Cause: dmFkZTFuVPUcVroa0ohrRk/MnqGG/toMoHzP0XAwxWo3qFKyZi/OADHxdSPtoEvGovqTKP
    FEWhDGkPXgwEl3lNwqQ6/jWbWBlvYIseDh1Q0mccjPXKolqqWxRZmA/FXrSv/ha115Zkzz
    iaX4l/EZ5RxztPkIaFczsOMbwNNzUlk/xkVYfIQ4pWewE+RDDlJxQtFXrgeAbhIxam1fC0
    zzuBcgH7oBcP3aVw7vP21rjUVFWE6pSbI4Uc1ZhGIQ8Ivn5raWgO4Ts2iia4yPue32BMWD
    kiG0z3/8pSUBVaF6SfDUsEND+kw5rwuoBx4X2rvC+WVadaLryYdPeHzspbhCr507j1sdZL
    1Qd70ijvJ41p6mDo6jtpKYSI6Enb5HC4MEq9daEH0WJojjMwRCh1FhrZaj9Mlq6jAI+2hK
    m1h91QX2x4PZIE9FCJOyuJVzm4hnnDtK4x/Y8Srxmc0d+4SkCCDD348WNs9sfov8kS9KMC
    JhxEoLiisV3Xi7aJGijcLyrrqC8PHHCydp35+5IncYOTqRQMalfQpzq1mJ/PSkWaVRZvbT
    ROqK/jTmJfn+gFsmnH7CEpzUqKgYxLIMM60TayYRS30h/eHUg/juqALGsfGABbMHjb4xmD
    ur6KrrkNp1ZtuRr1OXdBuOYOufe7y+lccbrN6zP329tqAP2sN2ZVDcMy5opA
X-ME-Proxy: <xmx:Qp_oat7nc35XzS4QFoqc58e4lf0GPCnBcOTaPlnmj7tNPtP4jTCIyA>
    <xmx:Qp_oarr8yKTelF0oY1xL6YPZnvQyBGFG_fL1gZWc5As_nJswinU_DA>
    <xmx:Qp_oagnWSpNEO0KNUtcPpttf4Dyqa9jmeNtDnOUGVrLnBNn6N7905g>
    <xmx:Qp_oanOufR_pIU0yhfhU-FWB7VKVmjYGLYaxRCGyk_Ib4_EQDA8Lsg>
    <xmx:Q5_oamAN7qoRAnXiXcSvmzziOwVLp1L1eTN_jRqG8s71m6til03E175C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 09:33:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e91b270 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 14:33:36 +0000 (UTC)
Date: Mon, 2 Nov 2026 15:33:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	GGG <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow
 clone
Message-ID: <auifPbwjQgbIQzzK@pks.im>
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g>
 <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
 <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
 <e1ed2066-5cb5-460c-9c1c-0177d338f7fc@app.fastmail.com>
 <CAHwyqnVMb1BtJ0Eb3HqQx9SNyB9oWkhC7OH2_j=xZSiuwreK1w@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHwyqnVMb1BtJ0Eb3HqQx9SNyB9oWkhC7OH2_j=xZSiuwreK1w@mail.gmail.com>

On Mon, Nov 02, 2026 at 03:10:56PM +0100, Harald Nordgren wrote:
> > I’m not much of a C programmer.
> 
> I'm quite taken aback by this.
> 
> Is the Git code so sacred that even the reviewers are not in a
> position to review? :D

There are other ways in which people can contribute, e.g. by
contributing documentation. Not everyone contributing to Git is a
developer -- I'd argue we could in fact use way more non-developer
contributions.

Patrick
