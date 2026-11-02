Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613207;
	b=XayZdEj9C281dSueVuwDVknD8tWGPK1Z6EJ83mhlIdoQzMI2R8L2cfQFpxr9FVbfATO9
	 p0il8YwU9EcvgP3zM97IqjMX17ik8WRlBYxbXB1NExiET5+ze13xTbXSmhxUx5tIffiWG
	 xHD1wvEXetIEPTLobLWOmnB2MUea9gz2wDd5Fs3IICdwAzDCWLj7FwDLY5bTVabBeWBd7
	 DjF9FyyAGu7xP+JOZdBPbtG+GPuSqtYXX+CnZmnN+KG9nRenc6dpCUxaa3q0EGjyDLwlt
	 XhLSuG3mFjx8VWHogU2wmcGYwct7/vMkIZEJg5ZGFzQRo1cBBjAPntAXMeQy6XfFAWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613207;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jrFgZwDxIZNnryENlBbHI7VeZEFBcJdEhNTTekuNMtI=;
	b=pOW9tnJ4nAYLPoiRm+0DCVRruWekc/F+Q1t6hnrOnToEAKB1XaB94PVi9UA7BgengOI/
	 1VnGB2Oi7Nf2b+XGHOQ3HsdFPbDPxfPqzlh3GJj5Dpd/n5x/VrCOVm1MRUmJ305u/dQQX
	 SKvfTeb5qTuoA8zth+jmGq4EyEIhGaKnLCngvb+Ro4yvibOZlgnnkbGzy8Nq0jm6ZBzy8
	 BTIRasjP4f0T8lpIBaxoBktytFjMN2Gl/DA4tz6VlLVw6O75zWqZFVzDn6RoyiEBzEdWr
	 4IG8x126K4dE0SJXeIosc2ZFM/vt6B7767SWucGlWE55H/wP0FET4VhAHoul1dwzwqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=cIfmBByX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=B4PKmDfq;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D6606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D69D6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=cIfmBByX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=B4PKmDfq
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 180641D0015C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:53:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 04:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793613205; x=1793699605; bh=jrFgZwDxIZ
	NnryENlBbHI7VeZEFBcJdEhNTTekuNMtI=; b=cIfmBByXzbkmZm0OJ7V8lWpr0/
	9xIpyIUNF1RPGcMVHcpzPb8lPe4fTlJGQtrm6QD5UCMRLIWrs/H5IkP/fehyXs2k
	FuwRjeM/9Q/xl6RgzwDze+a289RQl7XM46FfcZvv1EWlfO+Z0baFpwIWI8GhyIfL
	ac+hROKXS/P8GtHaFlzi9ohEEyj6ePbi9uOMv6bl41Au26s6oG47bzdNXCFi4YCL
	VCVQuS4cTdlz+o+jLh55SeEaW2muscci2hSs9UYIDOSQnQhKmHLFkW+8yNYRx7q3
	87UJXoLauvMwU/NT5iI85nIQ7ZY7lVrfhdzuoD4YNANTQ2uv7P9539LIXZ3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793613205; x=1793699605; bh=jrFgZwDxIZNnryENlBbHI7VeZEFBcJdEhNT
	TekuNMtI=; b=B4PKmDfq8UENDgJhVnMRwk5auQHulq1qtbXXzQTVfvmuAlnedVk
	pCPxmU7YiwWgKYLRYV1LohFMhlZa6x81ibYOftHmsqfTWLmw9Gn3CT+a15xxlwOl
	4hXeBtykI1WrnTrh07AIS1vb0kb8zLU0ARbwF5TemiMRfsoiq52plvNRdvjZuUEz
	gyKrKGNr5V+Hw/MNHKC4PCWetiDVCJFFmeAxUbSEUXgG2WfyAxzLi4Ge1lEhWLXg
	8ySea4LRNnv/fGVf8Rd5wsx/1GTGlZJj2BLqYimGvfd1luG83Dji2Bil6bwAPPNz
	V/+gi+MCCHdbdbrN1FzI2b6mHJYItstfTlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793613205; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HBrk8i3A2tDxzdoZVjmbEPyH2ODHg4j3n8+R8N6lylW3wBD
	vr83t2yKJmRiMlfee1nY74VaRohvynPvJZHjJJ0TJqEBhy7aR/ddzpzXLRx9tufD
	WxRaRakAe6oiMKrQXaqAx1AdkuDJPAl5jMcCs/Zuus7o2xm3NHIwL8DKwxqsxDKR
	kCxkUIlMCmdyYJFv1M8G0xd60MhvRbH2d6L0BS6a/XKUm/t+T4c1rtYsFMhB+JcU
	gWjXox7nD/nVCcOx3n1RPHvhxu5tajBJPldKcGkZIRRDc4GUmdNW5VhOiZunrzHz
	bj1D0DNSQ1Dkae5IDn9c6eGRKqu/qD/wH8LzEKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XPmy1OTg6CC9gr3/6UxV9x0TNEvat/lunS48L8BqZLE=:Yh4ZpuxKD7/zLXgoddMKkrms2tjLpllxOyEBXNftZXk=;
X-ME-Sender: <xms:lV3oaqzhzE_OOoKH8H3o-EaqIfPPXDTx34Cwcdn6mt7M1N6i_dta4A>
    <xme:lV3oap_f_TazfKfd_bdSSgSebcdtZbS9hHXwqnnQKfJGhnNJjNxfZ6vlB9qz8FIwA
    hCSWLZhWkq94slgGSgwStZ_Lpfh1GEZFH3rp60ekzobj7onXVncChs>
X-ME-Received: <xmr:lV3oamJrWNKTNtvmyPwKZEvAs7cNOxSeAdTakbALl0WGqMquyZlyQoBfhWa7cLqp16qJYw>
X-ME-Proxy-Cause: dmFkZTGkVnPVsM83b1XK/E2CPOeUd4dDK9yeT2zPOKJIAkg/HJRz6ULzaTcbL1myaZ4j3Q
    pxVXJhKZgNrWOYfaSq4uqhjLniCYLZqHyFNmTKDvdSUGfUxRuHo/DUMKEMlSBJXE97NZX4
    3i3I7E+NdZXVBFiC0gDiPuyc4/Jo33nbInYyNwzuY3VdDzv/wkspJa5Fbqi+2oz+wPlO0w
    +S6g+iHu4WRzyuqrnSWhOxVS+SP4kY99B2PmhhgfO4McW6itVePovwSOEpNNHg/xrq0rVA
    ds7TBZaaxxpjCqJNj+EqWw59nMW5X4sozOrKJOFnkZ9HYuWt6EQrhC6IEmGkbwpbj5lprk
    FHPvG3H1tuLtuFkaNfwkp1r2cag+rIMBY8vlUN0/HIYJT2NNMswYiqsUBiNIlPENE1atkg
    t8ZvCEFiX1gXW/raRXhL+ic3F9YeNy8ftYoDZ8ZB4/WKOjncnSurEGSqxqjpckcSqtmhi0
    L2ScFCyo6KKm6h0iit0rhTYuhOVb66iKdVaq2/7891UmDhtCZuZjUwJEAlN64SJTg/AvJ8
    MBq5OlaA+nGE2zy66h06jzvaLqXXVH7phoajoSOoNqeRXdzXELsK//LrpqHISg4tkjk3dT
    G/MmDe6hHVT6cnEUhdgkPf+xpI+H5xy+Gz0+bBHpO6sp5FGmYvvbt3BudQRA
X-ME-Proxy: <xmx:lV3oanc0Zd4MmrcaB0npLlc2dpmv7Yhv0bbdjnr6tbQKYuSTFij5dg>
    <xmx:lV3oat8PZJQs8E3duvvQdKzXpWJoMnoJY1YQ0S3MZDY-PKXZGNGV7g>
    <xmx:lV3oaso6oafzU7skYCBNnZOUTQoY2Q999lSoHOIodiIsnTyGdBNtxQ>
    <xmx:lV3oaqD6t6Y8R3E-Qv_qIWQqSNFwVpVOPzlcZ79C84alF5Oahg-Zyw>
    <xmx:lV3oalAzVWUJO2AoQ2pjsdZnu7-YJl2iFESzt4sZg3YELyvBdKuRolsp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:53:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61f3721d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 09:53:22 +0000 (UTC)
Date: Mon, 2 Nov 2026 10:53:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/7] Git 3.0: restrict hex object IDs to lowercase only
Message-ID: <auhdjw9w1lcoFIiC@pks.im>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260907195941.1024289-1-sandals@crustytoothpaste.net>
 <xmqq7bivmwct.fsf@gitster.g>
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
In-Reply-To: <xmqq7bivmwct.fsf@gitster.g>

On Mon, Nov 02, 2026 at 01:11:14AM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > As far as I can tell, Git has always emitted hex object IDs in
> > lowercase, but our object ID parser accepts both uppercase and
> > lowercase.  This leads to much software relying on hex object IDs being
> > broken because it doesn't handle uppercase object IDs and this can even
> > lead to security problems when people assume that an object ID has a
> > unique hex form.
> 
> As far as I can recall, this had quite a lot of discussion during v1
> (or was it RFC?) but nobody seems to have been reacted to this
> round.  Can anybody give it an eyeball (or two) and tell us that the
> iteration now is in line with what was discussed during the review
> of the previous round, so that we can mark it for 'next'?

I've added this to my todo list for this week.

Patrick
