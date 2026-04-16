Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B42701BB
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326605; cv=none; b=SOUF1dH35/IxjKu89dLRXAPh0DhdI7GT9fN8g3snAq6gMp2AZsVqoyjVpee14+iVKS3pdnu+++zHOnx83fnsO4dIYF1GjA9Z8uuye7EAY0+ZsOESkRomqr/xxQSDnr1TXmw2+iWAAJHH0fmr3UtV6oztSFCcxapzwDckrBbXZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326605; c=relaxed/simple;
	bh=mPqlrYE3aCKDK1K/Gouy55lXXQatoM7b8J2DFTs6gpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbm9Yg+khCVpyZIu+35bFOE4v7OQASY+ryInyW/+sXOokfIpmVWcBlKhEB0WeGBsYWmOVD3U2BL4DWZcqZpFLJrUvakGvXbkwMXzLqbXQi1ckCsQ3rvhcS16GQNvRuE984Dv2v+DiM3OVGjgO2krMiHAulFJWWT76Jwjawzyn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t6CBKBZ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vje7ateB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t6CBKBZ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vje7ateB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 017287A019B;
	Thu, 16 Apr 2026 04:03:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 16 Apr 2026 04:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776326602; x=1776413002; bh=r2Q4ICNc5h
	cXrlJG6hpP38c720jy3KX7u6n/eCOdy+Y=; b=t6CBKBZ5I7E6OkveQnJ76j+FNV
	KobUVaBlJZ0XgfpbXqqDy0u6eZt48I6GNMRjPRG1ceFcCBOZgEv0t/zanCoflaMK
	8Ibz1krydXErux92//lAjjfwBcRD051E2fIBgIly8HEfqty+CA0qOMruHTeS3z1c
	1O6p8q8ak4yV7F848/mb/8ySdxlLI38ZX4yFngYlO6KTMvBTGwATI99T5ZBjr6pJ
	+s6NRp+jKpZIPzPYz7mjkHnW8kg9RPNFRSf62tMzwKX7cKtbpf2SuiAXkeokegXs
	8elQPmZgfj43FaWuCJRySRuGl5CyBqxjAhTd/WJ5ikOOY9SuJl9phy/J6/Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776326602; x=1776413002; bh=r2Q4ICNc5hcXrlJG6hpP38c720jy3KX7u6n
	/eCOdy+Y=; b=Vje7ateBoio7mOpHrW12SkM1QbB8n2HZFvYMEXVs7dme14pywU/
	EXGHf0nJS5qjy6hJFUO8BLD6P5Kt8UaqL+i5RZQWZmPE515znkaEj+nNdMDLEfSf
	fouX0yF/YSwPGq0HeRa1Un9KKh7eiUd670i8E2yP/GogxGr3zdlIiNVYfEdaCQMK
	vlSHISH9Jts0GA+quBnn+9I1cdIPr7iGU5NnSqJR00Suw09TlFEsU2Sysstdi+pI
	NR3AVCPfAofGD8P67oisdut1gPh3LdOPlBukBbgQQgB7ahT6CdVw68U3HdI9htU6
	UukMF9FKjMBBbvzjXdeu/owiUPx1s/gfclw==
X-ME-Sender: <xms:ypfgafKcplxTjX1bwzSvlZz4ye1U9cQy3bgtEozxbuz3yDih2f3BdA>
    <xme:ypfgaak23GBQ9WZYeITyKCCOrVkG6SYtMEYs5wjDqwqcHImpAaVqcZ0Hy7s3XKnkR
    CgeWvof1rKz5GqMBdn02xTFwJJ7GcWEux7gxilC-mqoNizgY5aqdW4>
X-ME-Received: <xmr:ypfgaVEkKT1DQeDgjYuBNXFP1fk5xlyv6dYwM7HKc5pNLp77JY-oU3YayYiMgQjpCTXLOyx9pRibb6fSFi3vk_ovf87T5-VPPEPgC2-vlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ypfgaSHAm6Jp4JbCJpJlGAhqVst40puiuzPQmHc7EOYVaKMDdUqbSw>
    <xmx:ypfgaaPvu1FqW1VKk9T3w1TtQwdXqjtYkQumDIE9xEtQfqYh-cAx-Q>
    <xmx:ypfgaZH7JvW1LFy9YSJXvlJ2aa-B9-nzpt6dBZdCy9tnz5c0VR_IDw>
    <xmx:ypfgaZNsHH2mM-Pb1OVmt86YhmmygCkodP-T7W1BtcuL6DcbJwXbNw>
    <xmx:ypfgaZXbh8uvQp6tbnsGSem7L0swFAEpUqW9Mq7wIDMBQ62_C8X8qMDX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 04:03:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ec851dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 08:03:20 +0000 (UTC)
Date: Thu, 16 Apr 2026 10:03:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <aeCXxdru6GqfA4lR@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqeckifq59.fsf@gitster.g>
 <xmqq340yfivf.fsf@gitster.g>
 <ad3rgbgadjIZRgaz@pks.im>
 <20260414220347.GA3475127@coredump.intra.peff.net>
 <20260414225206.GA3486072@coredump.intra.peff.net>
 <20260414230810.GA3528448@coredump.intra.peff.net>
 <ad80r_oY-uAV2zVt@pks.im>
 <20260416054924.GB646814@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416054924.GB646814@coredump.intra.peff.net>

On Thu, Apr 16, 2026 at 01:49:24AM -0400, Jeff King wrote:
> On Wed, Apr 15, 2026 at 08:48:15AM +0200, Patrick Steinhardt wrote:
> 
> > > Personally, I am still skeptical that all of this is worth it versus
> > > just checking stderr.
> > 
> > Yeah, the more I dive into this topic the more sceptical I get, as well,
> > as shells behave wildly different around `set -e`. So I'm starting to
> > feel somewhat uncomfortable with the idea of blanket-enabling it for all
> > shells, as that will for sure lead to lots of fallout on platforms that
> > we're not testing.
> > 
> > Maybe we should really only do this for an allow-listed set of shells.
> > Starting with Bash 5 and newer might be good enough, and given that we
> > use Bash for some of our CI jobs we can assume that this would weed out
> > failures anyway.
> 
> Yeah, an allow-list is probably much better than trying to come up with
> a list of buggy shells. But that only helps with portability.
> 
> I'm still concerned that this approach is going to create extra friction
> for test writers down the road. This series needed to clean up several
> spots to avoid false positives, and some of the spots were non-trivial.
> 
> Now that was the accumulated cruft of 20 years of test-writing, so it's
> not clear to me how often new test-writers will run into this. But when
> they do, I worry that it may be hard to even figure out what is going
> on.
> 
> But I've said as much in earlier rounds, and I'm not sure Junio agrees.
> So we can note my dissent in the captain's log, and I can reserve the
> right to told-you-so later if need be. ;)

I don't necessarily disagree with your take, I do think this has the
potential to cause some pain. I guess the question is _how_ painful it
will get, and whether that additional pain is worth it to help us avoid
silent breakage like we recently had.

So I'd take a "merge and see" approach here, and if we ever notice that
it's too annoying we simply revert the last commit that introduced `set
-e`. It doesn't have to be a one-way decision.

Patrick
