Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607D36165E
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761017; cv=none; b=Zma/rqw1Ish2/jMbPn3e7tyAPh+8RDE2XtR1iZYLkHF4Hjy4bXtFCsW0WmFJ28xKlsWR6bLtpo9FYVQdSDi5zP7tz7SyYGoA/h3B2GDmZC14CB60ZHBzghZfx0wyc/xKCaxrD1wBiep+nnPbPyGf8mkQUmFS/dOvsjGQxRUHXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761017; c=relaxed/simple;
	bh=QwAXFGVtvhHlj4gzQ2lsEnkSx4kerslfODk9MwDQD1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHj1xDFiPRGWml7UhF1lL4P7sOwZfz9E4+ZqKxfx2hbBZS2DJPta5Ecg+ZIylgh1PxkMfB0RjkxgVOEtjuV4jfCJ+gJj1fo4S2wiVHNUTZLogLzW/iLuyyiCPI+Obq/GG9v5WRl5dZSo49z6YUEQKoiTZZGaf7mrRaj9jXSMP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SSzV9n98; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aBWLPRyU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SSzV9n98";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBWLPRyU"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7145140016B;
	Mon,  7 Sep 2026 02:03:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Sep 2026 02:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788761013; x=1788847413; bh=s25DxMQ3HL
	kX6Eq5tx/IVkaKhlb9qJb5kwxrULawxcY=; b=SSzV9n9880ccjlWCPbWsO0rgSo
	YeaODRJiHTVhFApkPiwkMyZXy1ZxYvqxvAFbHpWqsepfOa7KwLDPNwM/941QlqMs
	p4ooFSRRwBPv7GOcmn1V5sRQSRr9PMkNg1G/qNxrJc5GBX2suQi9GG2Gz6ufeHSU
	zuu7KWnzHyh547929+TDJbPeC4WW0TKY7vCiwWZRP6VelNIdSKd6I5eim61Xz69s
	oxA1Y/9mcVDLsCtva8JaLPadPzUQ/zUlRqKw36c1Mwe6Pmt0pDw44CjjQYa1XSR7
	H81ZQpBXCfDoa5SuqA2dFUYMvSnxDO10jRtcIaBDwkbzcbn04xT96h7Iujqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788761013; x=1788847413; bh=s25DxMQ3HLkX6Eq5tx/IVkaKhlb9qJb5kwx
	rULawxcY=; b=aBWLPRyU+plnCzuba9kT8dTWIni6W9s3f+A+xyEyzA9+PsauxvW
	s3PMAsNh5vR2pGI5VsLyWp4kOaA7Ay5spTujXs6jIiGeYikrp8odu4o4CnOhy6yP
	tosDF1gIQBGoTMvC18UWbyV/kddmf78MUnjGVxPJPpdVGH1E5qMLvYYV0Z+ncpl4
	AK7lpM0pLTRZbDemff8uBido9iJleQTSNyooHEr3nUpmj5VvH6D6YqYwVTzCZrjJ
	yf8p8M71SaWEK8b0emBj1onjo1RIAzkm672sELd1LxP8HaVFA757VYg130TSz6Cf
	P7XUDDxm//J3nWk9o1Okz7IWYOKZKIpCG6A==
X-ME-Sender: <xms:tVOeagyOxQoC0WR7CPI-DlrnIeGsGh4xu6RZWBAnu3Z0fFHGHg7Wow>
    <xme:tVOears6niBPO24qjSzFwYA1QTRJr3C9vLqDYhVHtAMX9ottXlpA0UzRN-buu8a3S
    kufUdlj4Q15oyk-8csiRHOdW7GVyWonEMKIs7JrOos-df_K9hfFPg>
X-ME-Received: <xmr:tVOeavsLBY_q61_t6yL_qsHCVUQ87al0krZRaWPGuzHcKtkm90XEZQ>
X-ME-Proxy-Cause: dmFkZTEj/dUXHLafrW2SZLIm0I04npsrARs3TKEVtU7+61V5U6tL+PFxby0jO/GqxmMuKS
    P1dGjD0+y4tDK6A4p3qPes7ebPcnR4cQWTHAHNSfaZgCSPTeNk5oP5UE5CSy/cp4IY7H/V
    PeKD3WVieEnOyW/pSA9Ii3v7IJmwYoZD+qB1MrXOPyJmvplsxz6056frYZm/6u/8nY/fuv
    cOnkLTvswa00U44UVjZf++dwx/WQCqx50oz45CfpYxXzWJjxjVMTqzFFFBhw24pZ8y/1K1
    OtYgu2yS5T6Vmyh+Ht182PAR46j9S5Oaip0HhY97Rf83LvUJWA9+6OBCUZOWAxSOUX42si
    qTyxHz0cof95zmm1maLFQWF3aOaYGvudsHm1Qrm8C4GkY5WCmbCzxkYQJYr15+gF7jR69m
    XyAWACkhQ3Y9M3o8ZcLwpXbiuei28/y32eCpJoAX9CLdQS2GD+6SbDVivIFcKmY9Mi49Xh
    Znvtu8tmyBArx76JihVdnVo6CYkuP1fU/PgWgAraStPsr7Ay5J5+27OA1FLwaZeEvFzG1F
    n/9qUKd2B38diln2mAwML5v13a+36QoiiO7LE3LwrT5KFPJ3RMwAKL3lnZU+o8AasWv06r
    B6Hd/hGyodC6mT6M1UEAQESyNbC4E0APwVQiynJ9ALN9PNOSaw3qlScEF/HA
X-ME-Proxy: <xmx:tVOeaoMfGAykeOyd1epgaW2krm0J0H2fK7INF2n1dZ1JeUPHU7RZ7A>
    <xmx:tVOeal2YuuNXFem6AD8JFPSg4kyJ945eyxT_tZWkhKn573LNdIBV3g>
    <xmx:tVOeasPuo8E8OosLa4pa8RbsyyumLr6pQDgi_mUeSuACYRnCEKBCpA>
    <xmx:tVOeat3k5l5QCL8mpgG23Moaas899el3rZucpOXIN4kcGRITPzR40Q>
    <xmx:tVOeakwXxh8eak6ZSZzwfed4bT8Hy89E2hRnkU3WGpDTgVqVpAxPFLDS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 02:03:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a18e7c03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 06:03:29 +0000 (UTC)
Date: Mon, 7 Sep 2026 08:03:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] ci: bump debian-11 job to debian-12
Message-ID: <ap5TrxRXrYZzwMN2@pks.im>
References: <20260905135822.GA3914811@coredump.intra.peff.net>
 <20260906151137.GA328152@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906151137.GA328152@coredump.intra.peff.net>

On Sun, Sep 06, 2026 at 11:11:37AM -0400, Jeff King wrote:
> On Sat, Sep 05, 2026 at 09:58:22AM -0400, Jeff King wrote:
> 
> > I started looking at this because I got an apt failure on a debian-11
> > job today. It might have just been a transient mirror failure (although
> > it reproduced for several minutes afterwards). But this seems like the
> > right step forward anyway.
> 
> BTW, I noticed that the linux32 build is using ubuntu 20.04, which has
> been out of LTS for a year. But bumping isn't really an option; they
> dropped i386 platform support, and so has Debian.
> 
> I'm mostly inclined to leave it unless/until it starts creating
> headaches. To some degree, if we cannot even find an image to test
> again, it might not be an important enough platform to care about. But I
> can also imagine there is a long tail of oddball 32-bit platforms that
> Git does run on (like small ARM chips), and it's nice to at least have
> some coverage. Possibly there's an ARM image we could use (looks like
> armhf?).

I agree that in the best case we'd find an alternative that works on 32
bit. But as you say, the list of x86 distros that still have support for
32 bit is shrinking quite a bit these days.

One of the bigger distros that still supports it properly is Alpine
Linux. We already support it via linux-musl-meson, so it should be easy
enough to extend. In theory, we could even merge these two jobs into a
single job. We'd of course lose 32 bit glibc support, but that might be
fine.

> We also seem to use 20.04 for linux-TEST-vars. On the surface there's no
> reason it couldn't be using ubuntu-latest, though I think this may be
> one of those cases where it's doing double duty as "test exotic configs"
> and "test on an older platform". But might be worth bumping to the
> oldest in-scope LTS.

Yeah, might be worth it. It would've been great if they had a tag for
this so we odn't have to bump ourselves, but on the other hand it's only
a small bit of churn.

Patrick
