Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F01F0995
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691289; cv=none; b=iAmtPain7IcoMJ6CEjncVeii4pnVsCgGcFZMi32qG3EXDBKsBjaNaxAOpH3oi/9KDpY0DPi4qYXSNuM41OdhUk1QCLaaNe1HDMcU0guFsjo0u46n9gDzI7hYSj8Rxf7Jg97MNz5My79T/nzZmjQF11me1107Itz/jNlOw36AxpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691289; c=relaxed/simple;
	bh=y6AkYrQ1UdDv94dv/iZEw4BHeaenslkrv7TTmyOMLiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1XGa8032J0c55VSJd7lQ4CgrV8xPneOxC2xwxn5kL81hDFUmREaJVKVMjRYjijQucaOk06OYFygbXRn6HGYNKMKSykxJXQlm7ZuFS4mbNRM3CSjL3Pwl92Q5opof21C3K7uY7DSetOV/7cTaoZ/YjTE7RHRM6aLeowJlVFmMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LQaWvopb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X0GB4FNe; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LQaWvopb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X0GB4FNe"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 598FF7A02AB;
	Thu,  5 Mar 2026 01:14:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Mar 2026 01:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772691286; x=1772777686; bh=tI7Xq3Kgz2
	MZPEapHQV3d25H+ojKy318Bbnz+ayoF3Q=; b=LQaWvopboNRe9k+AfX5VYfXO9g
	2V/DOt40B9nn0xJXqtPYjf4Cus7TF+8JjbPM7fK9i7PuVj7jaLmmYafUhQ2K8mHl
	06wZGCkRV/VuhLhuZa3Qeryo6rg1p8G0ha1h9O8QB+A9gE1L0BtIBkSJXwtfoqwW
	bDtxpgIqnuDUcceWPTsiVAsbQ68RVMYCVIfaULcmwXDPUWI6arAecYICxA9WnkBy
	AM4i/wGsSGdGhMv5kGH/YJTjL8n7O5xe5jWX4boLAYQrZQvg4E5IOVyA8Mj374E9
	lazewiz+mGKc5fsS7EnxCm4bO67ZPtq9l+qfZIEkbDGQwGlQU25C7wxJl2Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772691286; x=1772777686; bh=tI7Xq3Kgz2MZPEapHQV3d25H+ojKy318Bbn
	z+ayoF3Q=; b=X0GB4FNeGyTE2wL0EOQOFRoy/YEXSPxZvSb1HjMi9e/mri0/8eN
	n2zWBNg3c0U3ps4HdCrCbeFHG37Wl0kPiTOFJy/vJnl9L1Ls8lR3r20K9yUXMWqJ
	P7CSjKB0JYNuumppWxFjANYmjE2pJrc4avgv+VIFvjROGLrxH/FA3bQ+RZjSMAnK
	nS8nvm9z6M6TyFGT/Mw5ysyrxJpJg/1e6rGqnNKWLdYJyUnwU+0979arypnJVpwK
	cteGzpDl0V2M/4RN44QGVOd1tGJ1nwmdOVfuHOXML10hfQ9oO/fdb6v8um2qDF7q
	yBxmtEUwKCMBniwUPqRwC+whJWXsH7NlK4w==
X-ME-Sender: <xms:VR-padCnvk_Nrho3nV3ouaZvWqRk2yrvmqB9ZxVAlmRKN9KXttrVIw>
    <xme:VR-paalOG-FcGsulAfbkjt1rPDNcT0IIRRACLEiyXEudEoF9DqvnwcenieBWhqlOf
    QMt8fk-vq4FnEdZPCCrMRnaI8zHaSctfr6ZS9mG97L2D6veRPQmFRY>
X-ME-Received: <xmr:VR-paewRpQa2woUMsfvR1FCOJM4DsL5Dj_y1cvu9RSvpp76TbtLQwc6iKfydgYT6RdOdY0Mqg0YOvRazhhPbkWcHjqHqD02xvmCCdNythPYF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehfrghsthgtrghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VR-paUTH28QZ3-8Szc7JNOB4w9T7mJEsS-W0iHUy-qr_9it0E5b67A>
    <xmx:VR-paW9-iRl4DqTDfWmgrtDp1pWnw3Q5vzOeh1DpPwvEwZuiEsF9Ug>
    <xmx:VR-paSuNLhhrIZCDdcf0aJFort5AJJ44Q9ghVohH-UtgTHyzNE23vw>
    <xmx:VR-paeMNDg-AHikxBilVtDHFrielVpGpsGGR-uV_G-w3MEInDQ395A>
    <xmx:Vh-paRFkd9-twzekFU_gLBfGLVlTGr2Smvv9VGtUho2uH9V1zD73wyGz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 01:14:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9cf39722 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 06:14:42 +0000 (UTC)
Date: Thu, 5 Mar 2026 07:14:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 0/4] for-each-repo: work correctly in a worktree
Message-ID: <aakfT3oio1XQSl4R@pks.im>
References: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
 <20260305012035.GA53966@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305012035.GA53966@coredump.intra.peff.net>

On Wed, Mar 04, 2026 at 08:20:35PM -0500, Jeff King wrote:
> On Tue, Mar 03, 2026 at 05:31:50PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> > Updates in V4
> > =============
> > 
> > Minor updates from Peff's review:
> > 
> >  1. Update the comment of prepare_other_repo_env() to avoid duplication.
> >  2. Rename the new method to sanitize_repo_env().
> >  3. Move incorrect removal of 'int i;' to correct patch.
> 
> This looks good to me. Thanks for accommodating my somewhat-bikeshedding
> review.

Likewise, this patch series looks good to me. Thanks!

Patrick
