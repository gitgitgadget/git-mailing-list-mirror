Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795111;
	b=V94gTwzXLQ3tI1W/SHfz6Ubv3+koFK6fxce19OuHqUBfRZi/ihnYNFdwPXzOVc9UwefA
	 lOAz+VFOfFn5X8qrHpw1oc4FlpxpIVjNoFwoOK+e2rDm4WR1EBpLxP9cRzZLy4MZPMoz9
	 e8u8qkA7q3p/S3km9ZXdoVCsRtSfUAj4+2cFY44FIio7wkz0yytxNBO4wnrcOHbXj9Ncb
	 j55qcbTiG7dtXIwZpA/74Jdi9LHRNLhvdqE2ZftaqFyEyzwSQwHFNGUIXT+5b87SZnJ5X
	 m2xCg1WnWNELbIO3cI15/THklHwN7DnA56sGbvPCQN+Bzl+MdF9k9+Sl+QmkXXqdMVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795111;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=zVzVEpRCDU+mSIOAGV5hhp4ORCBwW7h4CdtyMn3RkDM=;
	b=yBlPedH6KHXLlT3qmOdmqoTEjgYlaWV6Jvy9OwbXQRjl6HIv/V8HGjwianySmGgix+R0
	 wMk4QonZaEXt3Q5aVQzBLWTyu0zRC3ti8KlZtMSbx/Ctu9qQEXmlOQxUbtHr5vxVRYTYe
	 ResUPqDYNeAA41PPN7lR+fyz5kjBLHgSVIx1m7NcoScu064WO09ZVf67Qt+UrjPxNpRp8
	 HWumWyzgNTLmGgkByOYrofchZhK97VCbdug6sP3sufokZHZpMZAjweNoc+PBlr+1/BtFg
	 sDNeMGzeFA7eIZa6RfmdrpGdt1SZr3lnUy7r/e0OvMgt+9gtzWG/jaXJc26Jo6KjRaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="cX223/E2";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="FV6rA/bX";
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDDC606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 12:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FDDC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=cX223/E2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FV6rA/bX
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D38BC140014E
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 07:25:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 04 Nov 2026 07:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793795109;
	 x=1793881509; bh=zVzVEpRCDU+mSIOAGV5hhp4ORCBwW7h4CdtyMn3RkDM=; b=
	cX223/E2Kd7NoH5dtbvrg84AgF1W48h8vVBqK95hEa1JMrloH3M2aH+OuupiuYCO
	wE6MecLkXs433ZGZXCyiALMUDJMwCvDt+hGM8Zpee9Vf5K7gs88zvr7WOs22pTew
	XYX1vv7GHk8tkcjrqd7AYwHt3aSYB1tjaOYalsk3sd6uEEtZ/usslaEl85Ho3k4H
	YT4EOcLRlacKuVVEcme5b1NhT5jHQaUOSi89iQPpRpJO7VBVTVT8+KbknlDubFGD
	wGfumSbX8736zFSObB6fym+E3R4tjUfqQW8sM7RrB18AR+/baNqhPGubqH9XDAQa
	/zr2kcESXTY8R7dDT58IMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793795109; x=
	1793881509; bh=zVzVEpRCDU+mSIOAGV5hhp4ORCBwW7h4CdtyMn3RkDM=; b=F
	V6rA/bXyXFVWho+GyquoI9NMam9+WUwAnIo7gmhZ7vMKHcdtI2DFHtrxqW0n9/KV
	cxbU1quClTm92XXUeaiLp7m/KSWxelKXQruMNdG8RZc4l3o5yOPRtTk7pSV8U3lk
	KU8yHp9CYdtfIbvuR8x5KxqHtaHTkI3vzsQGb/YBxr8PcHyLlbLs+pTE5G5XCaFf
	eCU3WK/87NwfV2MbKdUO2RDqBwGXXuBtW0j94y0aJPHWBw43zHPt6X6XNtcFbwSN
	cfd0l3Mo1W/KJeAugQitBfoxAUYjhygimPJKfYn46QJscP7rAauYdugqzkITGT/8
	h+HjeSMaj5gF8IU6XnRNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793795109; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qoBqcj1QJZX/M7SEMRrT0j2Q1lFZ94dt8zrytFWoGiaxw1n
	TcaT9Xzbtp6QSxgAlBzfGAigrgWe59Q3idABTjgWGm/bJieLRR1IaF+zQQEJH4pl
	Mvn86Dvr91SvXK6WoPlYFsjcRQJNMEqsft/Twocsxcn1hpp8gbjULamv0zC2G7iU
	uIaaCgguK9TPtUt+mLNrpQnD6eb6WDFrdM6hLweJb1mqFthGHpKD6fyg/9rTVCej
	TjHgmIXLclSJU+cv+ft0Z/kH31m0HtBATZbKOrHVzDlh/vxl8ZAziD0xDHFlpzIQ
	5mWlXHR64qs6waJ8T+ffNTYUh+YNNihaK/f7zIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dxFyoLHqlcFiABmOPz6QBGQ5SjJXssi5KTqfyEyKS1o=:Zd6pnYSs3tx4qEsIfFl276oZiqHJtMAMmA7b3+AUKf0=;
X-ME-Sender: <xms:JSTragdrwyqGzukdwkeCb7zy_9RfXPjK7vIoMQiDBPNHN7u0AIV1dA>
    <xme:JSTrapOc_-aGq8-XUsfi_s2ElOFG84iF3L0qcGl9U5dU_RGgmbG9EAoCdk41LNKLd
    5NHFUGm3HxX6N3XEIM97NNhCo5YWyE0N5swSauKLpsmvxpgsQQ6gw>
X-ME-Received: <xmr:JSTramjK70Bro_5xL_21uDK6n72MKdtEEpbf23EgbB6SmD_Of_ECtuB-_vDShZaNhBh1TMg>
X-ME-Proxy-Cause: dmFkZTELKTHhEJ4LpS+awbLMFpiv7OLu6iPghG13frpcwe7bnNOU4xOFp0EAo0kgdcvU3D
    oBH4f7vO2U2KzfEfyBT/sN99tmRYeFLJHUwXP6L88gp0YeTdVJCVUlu6hZeDXxlhVe9egV
    srO7iWGRuWafXlO2wCwrQldXZ9Zg/4+nOMWNgFwQWWAnSugAnJmpepna1bPhi/OtwfuHny
    iyt8RJGKKyJnXCRGJ0+rX60CTBoTsGyGce+62fXEWg/WDIMOgT7YH+4jx5eWQRN+sl9gnX
    wGVTZVaPf/vKe/3lVZYkHIjoJF2sQwrqNRJkN5HfwqB/qj2QycZQ47SEBVQ9A9Q3sDr5Ux
    v3mSvVpbzxS43fN+zcGW9EExSqjTQtUDUnnGZ8BoNCdmQCjFoxQT7uYYvcwRitPkhjdA6O
    c3V9WMvWZ08SUYgErPD5MReoM6N1KtWpg5qaAWmR7N1YpfdVhnJmzMx97FnbTWCqQ9ie4U
    ylXUg4V+djkfZ6EkCLQYLcEwYx1I8GxUgUM9VSMVAY1IwFIC7tIpJZSJpf9GN7R4UeWrSQ
    vi6x2zXStVmNnSM41eICc6xDHCbJmqvuMTRSvByK1d4J5EQKOx5OrSDYnkAERTfUh1adzf
    NyGgcDCDHYn5FNzatrxWqHH8JBSbALNUq51wDe5Q33TtEc6+bGdB3EDYIByg
X-ME-Proxy: <xmx:JSTrak2s8rYWZWd7Xrbxr8xKiUC30IPQrQ39BOmLDYHEZchNp27ylg>
    <xmx:JSTraojAXTaITyKCbAtke5FKbJfFm5iv4OjOIMBpkeSKMp_LagukAQ>
    <xmx:JSTrasd32xyldusqeuNTHllirYS6olqS5sOqxSeOyDvSOSxXgdDaNw>
    <xmx:JSTrajndbfxjU1Ur8mXH7LJp_a0YL4DO3-CqbMPHgysJpDWWL1c9Uw>
    <xmx:JSTramfAA2wX8Gm-FM3IaE_4lUPPMyGjuWcK3aP246C9oX2k13IGCoKO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 07:25:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4c7e960 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Nov 2026 12:25:07 +0000 (UTC)
Date: Wed, 4 Nov 2026 13:25:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
	Ed Maste <emaste@freebsd.org>
Subject: Re: Is anybody using .cirrus.yml?
Message-ID: <auskIPBRorDxDj6N@pks.im>
References: <20261102204151.MA00I%taahol@utu.fi>
 <aumQMJLMeI4sfeNI@pks.im>
 <CAPUEspg_9CGMtakHO3Stj--exd5nRNv7i3vW5tmMF0Arzmo=zQ@mail.gmail.com>
 <20261104095752.2rs5_%taahol@utu.fi>
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
In-Reply-To: <20261104095752.2rs5_%taahol@utu.fi>

On Wed, Nov 04, 2026 at 11:57:52AM +0200, Tuomas Ahola wrote:
> Carlo Arenas <carenas@gmail.com> wrote:
> 
> > On Mon, Nov 2, 2026 at 11:41 PM Patrick Steinhardt <ps@pks.im> wrote:
> > 
> > > Anyway, if nobody runs it anymore we should remove it. But let's wait a
> > > few days for Carlo to answer in case he still does have a usecase for
> > > it before we send a patch to drop it.
> > 
> > Thanks, but there is no reason to keep that file around AFAIK.
> > 
> > Carlo
> 
> Thanks both.  May I have your acks please?

I think it would help if you sent this as a separate patch. Otherwise,
this patch here is going to be very hard to discover for anybody who
isn't reading this thread.

> -----8<-----
> Subject: [PATCH] CI: delete defunct Cirrus CI configuration

s/CI:/ci:/

> Since b5a9d7afcd (CI: add FreeBSD CI support via Cirrus-CI,
> 2019-12-20), .cirrus.yml has powered Git's VM-based FreeBSD CI.
> 
> However, with the shutdown of Cirrus CI on 2026-06-01, there
> don't seem to be any drop-in solutions available to support our
> usecase---while there exist tools in general to run Cirrus pipelines

The three dashes are a bit funny, but okay.

> locally, managing FreeBSD VMs doesn't appear to be covered.
> 
> That renders .cirrus.yml completely nonfunctional.  Delete it.
> 
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>

Other than that this looks good to me. As said though, might make sense
to send this via a separate thread so that it becomes disocverable.

Patrick
