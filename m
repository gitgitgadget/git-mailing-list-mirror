Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171312;
	b=Gd57kfUoLvC6lU+Eklvocvm26kU5yr7cX7jblAYpf3FVbHqExwqg0nJlqPsCMLRXF6aX
	 3Hrnrl4x+6hQ064sBP2vKn/Onjoz2ek5T4Kp+suYluuJGhyoHFiEq6OByWgOZn2lqa1y6
	 AWW5h2a+UpGRlVynNx0CLn/s50y940LWDS4tN1Noww07+/2S7QgqVConeOYNcUUGFIMzU
	 DjeB/wJCZD3XwyfmNRISe3zM//5vYkfZGTvUSIVNmDaPIa/SMQ5pahFfs5L6h7IGGQKVo
	 KevjaQY4lZC1MUr/GRxQVjWyS604+d6psH4UA4G/pl1hzqL276jIjp2YMogKezYoLZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171312;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wNcTbluXLB6u8XmjfMqA+Gmyeq4IwCGAcGG1PuibCuQ=;
	b=i4p4uXgjfs0kQvgQQWn9LaLCGVAxbS/L271QVGW4vCFfzcu6gc9oCmYdn7Ls9OgkaEwi
	 mP8pxnCH+EBGvPXz1IoUdLxWS5TXX4fxFCj/w8OJ1gklOvTE57z1EjaDS2johOPI8V+P/
	 lpU5Lff9voglwNZpVb/ZVz6pNgaW/ik0qhWAIpr62TvoaTbm52UjH8031HppbAFM4pKnr
	 O1xYlnF2LbvlfO25PPXJICt83WC+4ZhPTqlHnQAegDZF1jJFVYPnPRjcIA2M7r/S3Ha5l
	 dIv0hiFIXcrkEXvx5nhFvdu75zPUNBNcyuMYebdvA2aMYI91nT6ieWbw7ef9n9iCkSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=lyVVpSOa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MitsyerP;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918B606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5918B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=lyVVpSOa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MitsyerP
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 838111D001F0
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:08:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 Oct 2026 03:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793171310;
	 x=1793257710; bh=wNcTbluXLB6u8XmjfMqA+Gmyeq4IwCGAcGG1PuibCuQ=; b=
	lyVVpSOanrfi4JkidPgkXcYPcdtMpV07KWuVf1lPI8rT8ENQI89KY5eC/t0oSYI7
	G2nwXltxEidaSiUu2zWbSorZaOTndFWJa4c9yzrbW/c1VXuM1wB1rve9EWbZlQy8
	dQV7OKgRKECVLSERAXw+cPksOCghXwrD2yKAbrfDOsH9uPpY82AJnIpKqsRX3jTp
	l4dpkgnNE9ch1AbgTNW4O2l6SQn95otiMEoa0PULa0lZbXhCPXs5cNfcXw9EjiSQ
	ZrVFAjAaOBML2cFgk37Rfd9jiHALc0jHn7xJtNQeUadfEvSHGHGVIxIVhY9f/fgX
	XIKCNUpJUM8fJfW95M7b3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793171310; x=
	1793257710; bh=wNcTbluXLB6u8XmjfMqA+Gmyeq4IwCGAcGG1PuibCuQ=; b=M
	itsyerPRJE09rtb0FA1ujXAdd3RiotYj9ze0FTp0H9Hf4jaIyZ+WtqdKIIa/5gP/
	sk5n9IMsW4GLuHoC7VatTCECDOkTlxN6qXefz1D6fDJXBlJLRPwKRDtwM1HhyZGt
	+Y62pZotaEJiRF2t28xc1+HoJmjvT35is2HbiSmgyyJuH4zZNhoyubkbMKIhXVcA
	wmNf0Ea/6yLyTdX22BWojT8WeHLP+3A1oLQHMWIeYbAgrhlLF/0BDBWQl1wccezI
	S+elSTZT7SFqnT7xkuQwLi7o82UHy6PKVSKxb4FFICO7Lli+3+Zast3tQqrFBIV9
	guh/Gp5EmMa8AFyGGja6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171310; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:USVvDcxHl41Y3HdgRuSzUE3VA5zi6FgGGFfzCrHMjSHQ9SJ
	/gN45Lf75o2r8vWEHW4+4IT2q2uDAxLZlkQAV6eqhheXNOIPZW4+b+eF6rZgCX/h
	UlqLQYvnef/x+KF6vUrbRmxuh3Frah8i49cuzy73BIsHN8g1wkeVyVDyMFe4MhfN
	jO4L3nnKVN7F6BJnL9dcGIHwN8R62RgyHUOGFt2lOG7peHVb1MapW0yeYmtlMVYu
	bCTPQCVlNK4cXCCl94czG9e/KOXhzv2ik6vRzOwpAnMpx+Wm7bceXkf+U2tqEpI3
	IUa1OFryKgqNk2H0SJKFcWykaW3kc64O9XRKsaQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3KUkKLcVv45GPiKtCbLnnWPvZf4kQqQps0owZZ8Gh4s=:Dp+FjsH9Dq7wnZGBnjJnSpINxkuc4rR9QzkR/doXYGY=;
X-ME-Sender: <xms:bp_hamFP8xYDV7WzgVv0MFmyOz0ewsXl0nnPM4bZWcy-el0KlAVX9w>
    <xme:bp_hatWR6YJuBUkADIbs2zgYYuiBCuONo1z8Pyw4PUW4o-i1_RuxeqrNNp8BsglvA
    QI8Yp5axrKIrdpM9vM_D9Lvm66XDF-3RDHXM8IhP3ytX3xpA_37tVc>
X-ME-Received: <xmr:bp_hatxrHfG9CYG-l7WuID3nq6qCluEF-ECht2iFZqZs566bEMIMGg>
X-ME-Proxy-Cause: dmFkZTEsGTMUUwirQ7RlccaRgWlNA5+9pSHR/sKrIB52rvU/LnybnLzL1Gp6Im1jSu8mbA
    1kgILD1uHcQiNzd6/wYvXT8eobvC9nGUzp5Jssp004RiZXSL7KfPP92yqzVlc6rr1QtDLM
    KL5s3ERcPKdzXvCdRb/2CSaPipUT2wl435+lkYzQBpMErjpbmXM0kZqyiP0YRjH34mTLRc
    o16a8HffDTwm4o09UIh5L32m2P6yzM2zMRZIUzM7ZtGZ4wEGCj+gfFVTMY3LUexjJY2bum
    XV50MNBaTxQLVGUG9X4SlmQeByRMQCPqh3RTXlslvvAd7rVvFHPUI1PJDep6mOxQ7c0yRq
    uJqYAeWARvS0cYH5Z12SGCmVRo/ReHOrXWy7bBIXdBJUWoeV1tdFiFMC1lvXtXMx4nNbzy
    mgDdTjvSDztdpds6BDiGtFLJIk7pOrjs8D0zxCvPofMw6py/V0bieJdM66V9W0IlsanSeR
    XclkdcZOFXG1UReAAVF8BdVzFUS3MJ7Wzm1zF9Yh4kaFmKVvHafh3xM14vSXGsdrWQuvqZ
    /ZqJ3s5yy/qKuwZX7S2WLC0iuL6NMHkoRTYEsNdHlnqpssyZFnchGdCskzX5qa21Kg822q
    5/99Tl3cFeZrs91K8FMOh9oY7/99RE28l4+I9RyiGce0gS7FJ5ngLx1i42RQ
X-ME-Proxy: <xmx:bp_harPdGHdrOXpbAfyFoOT_ZvwKIj3Gzdwaez3vT3j-X7t5abeVSg>
    <xmx:bp_hau60j5GpFf1L2aAgaLMKHBxPxTaYcscO5MTNSYKo8sV2kS3b7g>
    <xmx:bp_hasPIvePIZIJ9_KgyUB8MWs007gbFsgstNdd9lSqVBFf2G_158w>
    <xmx:bp_haslfhoOZRhB7HAQYnX9aVO4ka7iecYzK3Mij3KPlqUBahKlCOQ>
    <xmx:bp_havlz7P898LkvruCKHi3mCqh-ZcWJN-vlnqmqNaUX_s9r9mMJbqrU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:08:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0dfc0c5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:08:28 +0000 (UTC)
Date: Wed, 28 Oct 2026 08:08:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] odb/source-files: avoid stat'ing already-known
 alternates
Message-ID: <auGfaigL7dXwnLAK@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
 <20261023-pks-odb-files-reload-alternates-v2-5-30559d7ff43b@pks.im>
 <CAP8UFD1-Fh-fiGpFiVtBk09JygbD0P5fOYHgXjvk1X+YUCVyPQ@mail.gmail.com>
 <auCjz2OeO3GiRnDk@pks.im>
 <CAP8UFD0B_ra=GG2GvGX0Sou14gmJFz-PTS-cnCPm0bS=r7E-sA@mail.gmail.com>
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
In-Reply-To: <CAP8UFD0B_ra=GG2GvGX0Sou14gmJFz-PTS-cnCPm0bS=r7E-sA@mail.gmail.com>

On Tue, Oct 27, 2026 at 03:31:43PM +0100, Christian Couder wrote:
> On Tue, Oct 27, 2026 at 2:14 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Oct 27, 2026 at 01:36:35PM +0100, Christian Couder wrote:
> 
> > > Does avoiding the syscall means not printing the "object directory %s
> > > does not exist" error then, when we know the alternates but its
> > > directory was removed?
> >
> > It depends. When trying to add an alternate that doesn't exist we'll
> > continue to print this error. But when such an alternate disappears
> > after we have already added it to the object database then we indeed
> > won't print this error anymore.
> >
> > I don't think this really is a huge issue by itself, as it feels
> > sufficiently niche to not really matter, and the end result itself
> > wouldn't change. But let me know in case you disagree.
> 
> I don't disagree, but maybe the change deserves to be mentioned in the
> commit message.

Makes sense, will do.

Patrick
