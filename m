Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFA31327A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798409; cv=none; b=kr2KrfaMvoLWDOGVN7gapGkgoYwT/IjqW0O/AAzc222Wg6kCFPbAakqs4v14T13/iPFgqxp4mPAD1oMq0tXNlmKpVp6REyMaWL/zM2u7VcZ79/9TLUFCtHalJchbxOSdd1AUxeSgouUnSPTgnpMSJwA/ZNaJg7X6mt4O1gWkm+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798409; c=relaxed/simple;
	bh=eTrG3CbUVIcyAguzdYbPxXWEe126YP+bDEnq/5a0mLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuuwUB2fwG0e9KPmNMwcmdj+YEsIFgM+DRJst+Y/rpjkf46yFm77jiDfc4kQIEtFt3pfLJihJ0Ir/dltG0EuGJ4bBJ4cF4QlRhN8AbxbCFjT1ojimj/4FYGWVozICx92vYCKJgBaRc0U7SHg6xmGpKCBI28fpbY2MA20dWTVAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SzpIMUam; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8ahhZS8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SzpIMUam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8ahhZS8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 187C91400281;
	Fri, 10 Apr 2026 01:20:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 10 Apr 2026 01:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775798407; x=1775884807; bh=3cZk10y7SV
	NiHw5XkEwgYEGBXyK5j0zNZbtc8eEat6Q=; b=SzpIMUamo4heHOza7V+xp9Pp0L
	J3kwsPC3JxSa9+51cSRa6euf9o2LDngSP2+cS5xMnhJTPBHgJ8vqa7dmAAUQAoaq
	kU7MJoFOYo+NDq4vFzp1kRG9bfowOQK3ykaIFS+7FLDvfo8/rYtTs6N+rcdM2bQS
	r+pzd+Z4g0ii5gwl2usvoXJ4WuZM4pGy31iDYb/hM5udOa5o4cJWuPUi8Lwj1Bks
	hnHDd3GvViFtrfjn7dtJ9C78d+skfOBpFeZfP15AAx9lQS8RSvbgVf6YTZo5F7Gj
	Hk7svdTUhapnpDfXtTaxzOHN+RQHncaVF47g1e+kdAYPeUQMl0O52Ab/9pHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775798407; x=1775884807; bh=3cZk10y7SVNiHw5XkEwgYEGBXyK5j0zNZbt
	c8eEat6Q=; b=F8ahhZS8VvqVlERL8bcG2Pv4oHsj4pUmnjy54Mc76gwI68xPMIa
	uFOKY8GOJgly8XHEQHy9SVaX3JYalQbKrcs0N+51aNvflKIyTD3XEcMbN8+Qyaxp
	swwzDeuIi0Rii+p3CKvZpLtbGB1Isg+fcOSZK4QH3VgB/rKF360agfBc/PR8+sMp
	ffiidtBFpH0Y9hhrz8VEGFEoAkaQFaOghCVEoYrTJwxXsYQHG6fD8oTbi9gOPUM+
	qEmCXlb/jgQHg2p5o/czSNuZ/vbAD9As3uM78/M6oNz8d2jYlghSOojZ+q5Yqnuk
	asbc6r3vqMGTPjzjPNnsNz3Wf/qGk2Hj6hA==
X-ME-Sender: <xms:hojYaQwyqQ_kJ0uSOHH8N2Cr4gqWPN56mnet4x_Mdgh0d5LHmwdAxw>
    <xme:hojYadmG_hwadISSlPAkaG08_l7LW94JSop5J6dBDDh5H1aaPQIVGfVDIKZdYEk1j
    hnmYDVCM_m3z1HY-vrV0fljk7LxTC9cvfl3a9WKwqNDmflDeUAGVw>
X-ME-Received: <xmr:hojYaZkvCOrQkECsOUD3FY_HUHJtTSMKuGc3R8F-_scYP57jW6UUtnxUEHIw6MknOytv2nX0IeHIaachfthISKDNvYSSQIa3XGDOh2sIF7uRcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunh
    gvlhhmrdhorhhgrdhukhdprhgtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgv
    gigsrhhiughgvgdrtggrpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:hojYafzYex5vNOvOwCwsABZRtg_V-ylBiUHGaF8FGTQGG5j1T9ZaqA>
    <xmx:hojYaepBBt41bmCB4CGwekLEw8FJVBzH-NJ1T24ttX0K-M-qFlqxOA>
    <xmx:hojYae5QaNaKjb8Dmm_BXZQ7vzv2BfYoaVIHt-B0CuTgtAmI6Lc1iQ>
    <xmx:hojYaVclzO2AXdqHC9XoYcQiGLMvttkpMaufy-TWeljAHF9APt4g9w>
    <xmx:hojYaVs5UvBshV7JGTta1HHVskpefs237bfw14JJVySTWvBzCxMhBKNy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 01:20:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a1a5612 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 05:20:00 +0000 (UTC)
Date: Fri, 10 Apr 2026 07:19:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] wrapper: properly handle MAX_IO_SIZE in `write_in_full()`
Message-ID: <adiIfQjobtK3MDPW@pks.im>
References: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
 <xmqqika0ultp.fsf@gitster.g>
 <20260409202329.GA3076846@coredump.intra.peff.net>
 <xmqq5x5zsw8r.fsf@gitster.g>
 <20260409205928.GD3076846@coredump.intra.peff.net>
 <xmqqzf3brgbt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf3brgbt.fsf@gitster.g>

On Thu, Apr 09, 2026 at 02:09:42PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Apr 09, 2026 at 01:40:36PM -0700, Junio C Hamano wrote:
> >
> >> >> As the width of ssize_t in bits can be a lot smaller than size_t,
> >> >> the above "unsigned_add_overflows() triggers way too late for the
> >> >> check to matter, no?
> >> >
> >> > I think it is correct as-is.
> >> >
> >> > The real check against ssize_t is later, when we compare total_length to
> >> > MAX_IO_SIZE (which is clamped to SSIZE_MAX). So this is just making sure
> >> > we do not overflow size_t when counting up the total (and if we do, we
> >> > _know_ we are going to overflow ssize_t, which must be smaller).
> >> 
> >> But then what happens after it breaks out of the loop?  We cannot be
> >> at i==0, so let's say we have a reasonably small iov[0] and iov[1]
> >> that is so large and makes size_t wraparound.  We break out here,
> >> and then send the iov[0] with writev().  But have we checked if
> >> iov[0] is under MAX_IO_SIZE in that case before calling writev()?
> >
> > I think so. Either:
> >
> >   - We completed the first iteration of the loop successfully (and i >=
> >     1), in which case we added iov[0].iov_len to total_length, and then
> >     compared total_length against MAX_IO_SIZE, but did not break out of
> >     the loop. So we know iov[0] is within the limits.
> >
> >   - We bailed at i==0 either because of addition overflow, or because of
> >     the MAX_IO_SIZE check. Either way, we will bail to xwrite() because
> >     i is 0.
> 
> Yup, you're right.
> 
> There is no addition overflow at i==0, but I do not think we can
> construct a case where the sum is not checked against MAX_IO_SIZE
> before the vector is passed to underlying writev().
> 
> iov[0].iov_len that is slightly smaller than MAX_IO_SIZE would allow
> us to keep looping to i==1 at which time iov[1].iov_len is so big
> that we may trigger unsigned_add_overflows() check, but then what we
> send to writev() is the first segment, which is smaller than
> MAX_IO_SIZE, so we are OK.
> 
> iov[0].iov_len that is slightly larger than MAX_IO_SIZE would stop
> us moving to i==1 at the end of the loop, and directly punt to
> xwrite(), so we are OK, too.

Let's drop this patch for now. I'll pick it up again in the next release
cycle when reintroducing writev(3p). Thanks, all!

Patrick
