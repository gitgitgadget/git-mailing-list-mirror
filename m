Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231AF154454
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154777; cv=none; b=SExn7I6sKtLt+5H/vROAYDS8aemTYlzDUo5x7aReTymV1jHUBCMaUScIa6OrZDgifV7gkJxNQl5zqkqRaX5Zb+ZK0qFBbT40aWjcCv5g9HruhlpqqmOI+3t8qWxduREae8X/JA6C6EXVIKt9MpMALCZooQFWW0/XMSjVbe3rZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154777; c=relaxed/simple;
	bh=aalzRCjmxXvuTn5WD30PwwDROAKGFhRq8Y1+NAXyNlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNzmQdDSLpTxMCfITYuteMhpQJiZ7x4q+nd9esjL1VAPaZzwEjaUv9xkXODNr7oJRZbMh4ywmkrlOJyWYayUj+5K4+pcNXQN+UaoQt2uh+e+bC7y8NUdUD2FdsWV3w+XhBkM1mcEPwRnaOmQ1MZCk2TP9CmbJKBkkdgvfWDHvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hq83mlSN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CllNOI39; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hq83mlSN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CllNOI39"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBF5D2540086;
	Thu, 17 Oct 2024 04:46:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 17 Oct 2024 04:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729154773; x=1729241173; bh=wU2kBsOe3g
	jyd81cnk5VxmvneJWEX9Bw1WRXvxrLDuU=; b=hq83mlSNs7LhC5PrnfmAGQ+5NA
	1hGP5p9jgDnduUmY9fhKkqFo09DQ5/aIRCeFAtPTFS6vEUkDQ449qpbh4unL0uQw
	SP8l12ak3eHqSRLbhpESRPbXGW6nwhCyHZJgbCC7XlwWsFi4MfyeTlb9IAcyzVlq
	lP5cU5l7/MOfr+5GfexOIZyxuN0ZdWPinx4rdESoSJNEqyAsLtyiZVACcDN0r08z
	1ZFLXAetC//I3M2bnKlS3lwincadsut/Rfxhc9ApCYtUYVBycO5tR1MuFG/yEXDR
	eJAysSi3fIDEX5UKa6DiXZBhXsDSaM4FNrEGloafwNk5zaX2ohPARYO+q/zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729154773; x=1729241173; bh=wU2kBsOe3gjyd81cnk5VxmvneJWE
	X9Bw1WRXvxrLDuU=; b=CllNOI39OkCvfZU2NCW9L/2np9DYVSOJ1VMUMSBlr1ZY
	4oJJJy+2cIUyVSi87RgIkv805fOSWqE9R+mcopbj7sOAC+snQVC5c2b0RfDlcRir
	8f2Dk0Zj+4H5J9DdwoyqEnxRxZJdD0L/Sz80Sl2dCwJcUnZskKVCiwDyX/dhODI3
	yHduv74xrLk8i54505lcLUP5xgcMIVtX3w6NBgbNOofXKm6NPi6Ltl5ghbjh/kna
	j6BFcqS0YrDOYpsrzn3nB4U01gtgWXIe0/p6/NrNRdRBNbnALQ1vJUNqSefM4vch
	zU/jJVRlg4abR2VEvUwbgA4lTm0DhP+EZwTgM66jcA==
X-ME-Sender: <xms:1c4QZ-ov05_r07CjQ2lhNUO7SYnCfwhXmBZ6xk8kLTlpVXyk2n5gXQ>
    <xme:1c4QZ8q-pSlN-dKybtV8qRo3rDOl3wXYPehKWaznt52cE4foJJoXupImyX1YTrppa
    amXXjhDrE8MMIuHew>
X-ME-Received: <xmr:1c4QZzMQlKpOCys1MxNGPFGgp5F1DkV2D_5B4GqaAmHlx8j78u6QHmhZgsgEQsKzCvv8_tX3r308hFISZmF8Jt4Zrl-x7g1x4ClgyFcSGOnVnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheprggurghmseguihhnfihoohguihgv
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1c4QZ94jgBUomBAtPj74TYCZRiu-LnpPcWo35PHMU894BTMETG11lw>
    <xmx:1c4QZ959tBj0NXt_0h437tTvMWiB6SLGr8XUjQ32gKoa2sA6r2xk2Q>
    <xmx:1c4QZ9infbuvttWHUiLpzo75oIVUbWUWG-ve1vnEMoSNxNHiFFeIuA>
    <xmx:1c4QZ34YCjdFjv__AKtFfTVuVmmPzT1AEgAC_l7XYie3xq_hatumaw>
    <xmx:1c4QZw35qn6IiQCITUtg1IOvIBLWiCM2hLxkkm8w5r-fX7TX1k-rdYj2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 04:46:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cf2d2ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 08:44:50 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:46:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
Message-ID: <ZxDOydD7kpSGchiQ@pks.im>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <20241016145539.GA703747@coredump.intra.peff.net>
 <20241016150922.GA1848210@coredump.intra.peff.net>
 <ZxAiAUdtddwk5RS7@nand.local>
 <20241017023319.GA1858436@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017023319.GA1858436@coredump.intra.peff.net>

On Wed, Oct 16, 2024 at 10:33:19PM -0400, Jeff King wrote:
> On Wed, Oct 16, 2024 at 04:28:49PM -0400, Taylor Blau wrote:
> 
> > > This all seemed eerily familiar. Try this thread:
> > >
> > >   https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
> > >
> > > It looks like the conclusion was that we should adjust errno handling on
> > > the client side, but nobody ever followed up with an actual patch.
> > 
> > Thanks for digging. It would be great if you both and Ramsay could unify
> > on an agreeable path forward here.
> 
> I think the patch Ramsay posted elsewhere is the right way forward.
> Hopefully he can fill out a commit message with the summary and then we
> can proceed.
> 
> (I'm happy to help with explaining the credential-cache side, but I
> would just be hand-waving on the cygwin parts).

Sounds great to me -- in that case, let's just drop my patch. I was
basically just trying to get somebody to have a look at the issue, and
it very much seems like I succeeded :)

Ramsay, do you want to polish your patch with a commit message or shall
I pick it up and iterate on it?

Thanks all for chiming in!

Patrick
