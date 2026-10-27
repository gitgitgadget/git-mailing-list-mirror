Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083027;
	b=bbexYaDMMKzHX/8YLUcGGu96gFhvN9fOUcfJQRhIGNDrgoQkk/EdDYp52sCEbYCcyXWq
	 /m/P8XqDL2HUGfKD8O4J3vmO0zzQxwTaiogwWSrYep5mmBXiLr9WrKjd7XrWDIHqEReO6
	 q+hgj+pU89uUj097ZED6fAY+/c6Rnx/lctoY9RbC6PIGHP/vxv5C5FAT70uorZcgRYtrA
	 dWN3Us5UwTv3OdUM1lIPUfIfBtZcufQyWaNu+8Ep0NdpWniglCCLAU6dFYCnEl8VkaQ40
	 7NyT24avLvIZ7h9ZsZR187+it9xK0mLu+LtZi28HvJOf1DrDshqTfZ+Im0OB9BXwiQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083027;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fsFZ0HVuUNWumpL+h1srfbBsKOloHQT4jUmxscooYSI=;
	b=WHMsrJb/fEszNLbBamPqnRJcNJ5xptcZ2mhicTgY6la11+2KUC9taWcBjjcpi9203H6K
	 1PyHHTbGniq6r9DSxe/+zLw2la1mzW1n9QpID/VaF4iOXIAsuhtjwSj54uHmkID8bJQiV
	 0FkjGe9f5NoSyz2dsVd5Y11Pe8xbWmbh1DxPloaCfzjSmB1KYRAfT01PE0DjWykeav+Tc
	 QSocUlsvhzdmqfk8NV4duK5dfT5imhza7SNSs6bVrIFBciM2ZMjmc4P0rBY291iDN3RdO
	 Aeh6RAhh7kFpwq4hlYDNv4AtN78gLbTv2lUjEFAQKwertSvHHPYmKPYSULOepjNgaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="a/fq/X2Z";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b1KrnJmp;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF28606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF28606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=a/fq/X2Z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b1KrnJmp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D572F1D00094
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 02:37:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 02:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793083025; x=1793169425; bh=fsFZ0HVuUN
	WumpL+h1srfbBsKOloHQT4jUmxscooYSI=; b=a/fq/X2Zm735JxtaILtOQ7ASDs
	BtzKraBaQxwOuWcOpq/Qg1rkbEwJImmKX/w1e+IRqpW+TOJExY7Sp+FnGWKfMdgV
	4BrIYHF4vtOaJ8fjRuympJTVlU4YF4BKbsHJvhqrX8f/lTOLq2Qp2bSxcoqMQHF/
	dvPtz8CTL+jWJT4PmGRBpxF2bBYCFBArj+pbyzFCcp8wgATC5bNU+nLOq3Z1zwuH
	jkr8wSLvOrUuUoCwkCQxyBRnZhYffvrXumLPNjQn/Gi/xzCDGxNA0Az7xLqX0Let
	H5dHQl9RyqoUJsqQkBNxuhqRsLSD23TM5XO6ak8PN9MOzwFrDuqqwTsVyzZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793083025; x=1793169425; bh=fsFZ0HVuUNWumpL+h1srfbBsKOloHQT4jUm
	xscooYSI=; b=b1KrnJmp6MlNt8mTAPClepK9rwEZ2lu4XIvsVUJF4LV3q8zkmCS
	G09cSODgRGl86uRqsRSJH+oiZjk777fzl8c+O16s2jT9+qYp3QVxJ4/oiA2slab8
	6PLaloktNl+DkE60pXRUPa04EREWXpT/rLcGbYLFUA0r7A9otBl4qUHosCkZ8Fdp
	4rt182MuOygVTdfirBlbR66bnd//o/w0hGPsL9VvfDCMS2zaiJYOQm/+LrEflD5A
	c+SDg/OCzxpX17SCJ2yxPg+JEue/iAOKwTW29RrdCC0GZ2Kxz3J7smItq4B+xlki
	lSEtZopHUVrsOxFM5cmNkwuZ3q4bcW+Adag==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793083025; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hBugA947Iq4vk/vToFKR46d5P3652PwMuLgD6GZ2FvL4Qpv
	ifsWIP5/ShG69+M4+Jf1iuMd8tJrjEod6mhe0qBPg5eaInzHDnh/zovB91cwhvQ2
	Cv4txiwy4y8tiQa8AGHoTqKJ/VCaGQVOQ5uLdmZYadVcmKcaieSExcF5LxJSSToB
	OeJ7mSV0vNu5mhfuJmT+LVz/mEA7spqMWfxGOQc0m8uk289YkRmFippkSdMHjyjc
	zhXP04T+NkAGsQ0x5lT6ozAhzg7UZx2med4z9X05gLJelPox//PbvibIe6+V61cF
	tXJIcusC+k1k+ch2uxVRv4+6lY/1fSRAr3aWGJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2Ldx1tDppKkb9mguOgGBpMBcUuJl1PFGt9Fzg3QtVGM=:uYLUy2eaHQ7995WJGQLZKOd3nbNxnFd6h1KhniQWtR8=;
X-ME-Sender: <xms:kUbgarBmem_ZFLpEDq78oeThsAI5S3Yhtq71GiAn-k4SI4p0uUJ-rg>
    <xme:kUbgao_QcWtmpHD0y51-1gYxlJcZD__t0X4goRVkPLQT5vvy_fcVWhM1Kq5TBEGUw
    Ac-_gMKlxSLPNUF4N7QpDjemHtCNrSlmQKXzLpDH6Hfj-h5leUomg>
X-ME-Received: <xmr:kUbgaj9PKHswmUjakZwgsNaTCP477HXYa_3HGHHNXLs0_N30IJbGpg>
X-ME-Proxy-Cause: dmFkZTE6PQAIwlbFrodl/EfX2cFbZg6SClRKp6lqgKUwqBdzWrye3Yg2n8oR1LzoTpnSZ2
    TbubyMEqbp0a9RWItR+hDPJirK1Ji8KXO7DjRDVmv7d3zX3qu8RJ2G3grlh9JTTgWpZkVp
    d3MJKuDdg1ws61FWCBKc1Ed6N4oDQzplSKloih9c+BxLEQsumKOOLQ0kqukpIhlHhsyGSg
    DuM3IxX1uWm/aflPOQrM6VNhtqiBoqdoWlJ2ehKjHgG16c34shUcJhQtkPBZ7OZIRgRFyh
    tWID4hYSuS4WZgYQ2yhX6IsjSzaqjz1xIYZ67zwwupuPeMmDJkci4wUtZSSIetlgH3uhVf
    XSXSjYwL+320jRLGFH0ct6Wxq2K7SGQ9RQ+ZDBq40lLXPjThnHjTsXJlC2RfSXJ79rgQjv
    OgcXoX/ySA30tKT3oSGHugZwrDKZY+VF06vEcXhUuFlC2WIkmq6R3gnewbuYH9k5271Qrx
    P926Km/6i4pzDQLQwXB6qUOmzzgw336SJI6rbb+AzZBlYLLT/rqXfg5vfzukJD8Zm8LFTx
    g4UPi3gCRVi5nTc0gTkvqLZmtNlGf2WB7Ft8l1yBXe//vU3rqThSzBhdOSOweeFpTL4LPi
    0VCU7NNlGkszWPu9qKbxd88tGotKmeDfLRTxUzb7F1VVxQd5jhKnIiy+TrGw
X-ME-Proxy: <xmx:kUbganfbOkAjaXN8BRHV2zvJfrPC8NvI6AZ6l6YI4b_boAbtY5Epkg>
    <xmx:kUbgakHXUSjt-e1oNVZroPr3FELf3YPLs2zvdGg0oIoUhGuT_jwGow>
    <xmx:kUbgateNuop8CgFmcLz9b6q9j-nEooFt1DQopRdgFlYnOWYJHXfhuQ>
    <xmx:kUbgamGY5E4dN5Pimx8O9sgzmTpLAIC6va3Otp8bz5eCxkN6zHMKjA>
    <xmx:kUbgao8j5WdbuvqceI9PN07FHLyFmKFAO_zLhtxZ3n-lj7QC5ScBQDhV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:37:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 331bfdf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 06:37:01 +0000 (UTC)
Date: Tue, 27 Oct 2026 07:36:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: allow compound literals
Message-ID: <auBGiu_-qJMd07ua@pks.im>
References: <a4b382c0373e1b410c4c1ef74b313f86076d48aa.1793024062.git.phillip.wood@dunelm.org.uk>
 <xmqqbj8gp3pv.fsf@gitster.g>
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
In-Reply-To: <xmqqbj8gp3pv.fsf@gitster.g>

On Mon, Oct 26, 2026 at 02:11:08PM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > Our coding guidelines say that we'll allow compound literals from
> > mid 2026 if no problems are reported in relation to the test balloon
> > added in 01e49941d6 (reftable/system: provide thin wrapper for tempfile
> > subsystem, 2024-11-18). As no such reports have been received, update
> > the guidelines to allow this construct.
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> 
> Yeah, I agree that it is about time to promote this to the accepted
> set.
> 
> So we do not have test balloon but we know we still cannot use two
> constructs from C99 due to MinGW and older IBM xlc?  Perhaps we can
> raise test balloons for them by now?

Huh, which are those two constructs?

This also makes me wonder whether we should have a look at what C11 has
to offer. Skimming through it though the only thing that I do find to be
interesting is `_static_assert()`. We essentially already have those,
but they are extremely hacky and their error messages leave a lot to be
desired.

C17 is rather uninteresting, and the next version that provides some
significant value is C23. But that one is probably way too fancy and new
to be a sensible target for us now.

> Will merge and mark the topic as ready for 'next'.  Thanks.

Yup, agreed.

One thing I wonder is whether we can now start to replace the split
between e.g. `STRBUF_INIT` and `strbuf_init()`. Right now the issue here
is that you cannot initialize a variable at a later point like this:

  struct strbuf buf;

  buf = STRBUF_INIT;

This is because `STRBUF_INIT` is simply defined as `{ .buf = ... }`, and
thus the compiler would complain. So instead, you are forced to now call
`strbuf_init()` on that variable.

But with compound literals we can define it as `#define STRBUF_INIT
((struct strbuf) { .buf = ... }`, which would make the above code to
compile just fine. And as a consequence, `strbuf_init()` essentially
becomes obsolete.

Now I'm of course not proposing to go on a crusade and replace every
such site, and I only use `strbuf` as an example here. But is that a
direction we want to move towards?

Patrick
