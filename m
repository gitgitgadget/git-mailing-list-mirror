Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0F145A1F
	for <git@vger.kernel.org>; Wed, 13 May 2026 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653391; cv=none; b=jKj8zTBx1AKOgGw24Um5EKXsr3hwremNDvgZRrpSTXvWlkeUbFLdeEzr+KfcgsaEZel9VRZJtCsRz2nhokFaDxxB2o+YgHSYrZO/fwuc7KJ4Qo2Sqc/vunvAtgiFu+NSZWSCkBhwIBxq4rbc+SDvuZcQ7J2R3/xJ4tIB/wXHh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653391; c=relaxed/simple;
	bh=6wIQ2qfQ8ZwwBFcPcyT1cpI2SYLsF+W/dziAF2iY1jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjOra3rgnJG+ohLC8ZmyFCJ+LYTJCYAFP+joZa9PzN3wqOGeX8rAsjZPpdQJYBNJihTuKAgbK3A9xxZN5auNcEvU32ikBkHPRroOd95eJgsvPczxiBTzOvLOV3DzEEHyxGM4DpxN9TBaMQkDUbzm39VL3f5ApTNzgiLiYP0apcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I3FmnvbM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkwquoTV; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I3FmnvbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkwquoTV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E1B41D000C9;
	Wed, 13 May 2026 02:23:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 13 May 2026 02:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778653389; x=1778739789; bh=iV0dRjXyd0
	dkpwhma71j+GzFLI3Lo7Xzh8DC3ZqaYZY=; b=I3FmnvbMLnX2eZp9mOkTJZlXHq
	jzOpo9PBay85ohu7UX78phsk4Wm+YyVj1J94AeQGn3sKAuijIjtR+EpL9TNxyv2Y
	D7K8aQV8TZF3G9Y1F9dUz51CSm5E8PitNhNja1BLmvSJxHsAy7sOHNSdI0tIU2+Q
	0NRu6/s/E/Ny7rgGGigdW3dgX7HE+ACwVRP1DNeWOFF4F4FL5e7xdCM5/X0OWlGA
	sx3nzNY+eyqjM4CYJFD+jGstT1Yx2MVz2vzytGT+nIHbjpeqmtBQVoFWIPXsbNp7
	H+jS60ukxl+/CtBN1oLrB2cj89bruGTsBv9Qwu5TTLh7U6WjPyqCeHW6sIgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778653389; x=1778739789; bh=iV0dRjXyd0dkpwhma71j+GzFLI3Lo7Xzh8D
	C3ZqaYZY=; b=bkwquoTVJxWlOGv/F/W07dTFoz5NDOFFfEhKPIkRtf/q7KSMEdt
	tlBtJId1JjOSIwBE1SigysEVmsB5v+aR/dhrBXTcLaL/GRXuf0QpmFWbq5KSikxN
	HB3b9B5Vl4F04OVXh6iQRhmmaTTQlZAXR3zvXQghHVtVcUY8zhx9mwIp0bpeZJyO
	/z7HQPm7fmbr46mpwsYaxxgsW7yrxp8l+Ntf1suR5aX8FMK0ftOEORyuFYW3L+6w
	lr8WlI3+M4+lS4ophjOszZTcGyBOcb+in4a+TeQ16dZqkPj+XzqH00u9g3UyCrSt
	ICDwVQXRmLi2x4jum9udswMJNuuhM2svGww==
X-ME-Sender: <xms:zRgEanf-2d6gb8y-wpxVWN-7tdpZKNzkK7gHB31dhv7_92VviXbZWw>
    <xme:zRgEavdG8oMIu2HwCTJWFthkixOTnykRUMvC5mLQvvCnrDtGR1eNCcCT_DpWqufdX
    foerk5vlbR5N4ArRTTwbq0G_oc15VLsWoY7dzKJBCP46bI1iagoTQ>
X-ME-Received: <xmr:zRgEaiz94WJDjOq-Bc-5DfxySpRCq3fc-f0BLx2gG0OLsugXFDz430-NbwDituLm4zTfM_RhwuAwYoXDoTIQv9hUZ2HfHGyDeRbmLBx9JQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggtthhiohhnmhihshhtihhquhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepmhhikhgrtghhuhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zRgEau_B7T7WGIT7GmyoiN5iOpuym2usgTBCIsLNARjhPfJHW-N8yg>
    <xmx:zRgEaighgbl9ROeVG5cai_r6UiCPoliMovpHVPZmmNH2SwPD-2VTaw>
    <xmx:zRgEatFt8pLJ6VN_XQ78kC0sVabx1LoOWkPdcAWoRX8uya4QDAOoSw>
    <xmx:zRgEap_jaE5aV9XTtIlrE5HddPVAp5MWhn1suct3Cvu3qaBBfohrUg>
    <xmx:zRgEarcuSZI2-WzypgecotDu9ElqQoioTEwijyUhxQ7gHk-OhJy8mxGB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 02:23:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec9b2c39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 May 2026 06:23:06 +0000 (UTC)
Date: Wed, 13 May 2026 08:23:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] builtin/maintenance: fix locking with "--detach"
Message-ID: <agQYx08NnEqN1snT@pks.im>
References: <20260512-pks-maintenance-fix-lock-with-detach-v2-0-dc6f2d284b6d@pks.im>
 <20260512-pks-maintenance-fix-lock-with-detach-v2-1-dc6f2d284b6d@pks.im>
 <agOYLsJF4rHESk9k@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agOYLsJF4rHESk9k@nand.local>

On Tue, May 12, 2026 at 05:14:22PM -0400, Taylor Blau wrote:
> On Tue, May 12, 2026 at 10:30:30AM +0200, Patrick Steinhardt wrote:
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 3a71e314c9..d866c19b92 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -1810,10 +1810,33 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
> >  				   TASK_PHASE_FOREGROUND))
> >  			result = 1;
> >
> > -	/* Failure to daemonize is ok, we'll continue in foreground. */
> >  	if (opts->detach > 0) {
> > +		pid_t child_pid;
> > +
> >  		trace2_region_enter("maintenance", "detach", the_repository);
> > -		daemonize();
> > +
> > +		child_pid = daemonize_without_exit();
> > +		if (!child_pid) {
> > +			/*
> > +			 * We're in the child process, so we take ownership of
> > +			 * the lockfile.
> > +			 */
> > +			lock_file_reassign_owner(&lk, getpid());
> > +		} else if (child_pid > 0) {
> > +			/*
> > +			 * We're in the parent process, so we drop ownership of
> > +			 * the lockfile to prevent us from removing it upon
> > +			 * exit.
> > +			 */
> > +			lock_file_reassign_owner(&lk, child_pid);
> > +			exit(0);
> > +		} else {
> > +			/*
> > +			 * Failure to daemonize is ok, we'll continue in
> > +			 * foreground.
> > +			 */
> > +		}
> > +
> 
> This works almost identically as the original implementation I shared[1]
> original thread discussing this issue, but it takes a slightly different
> approach.
> 
> Instead of doing this automatically as a part of daemonize(), this patch
> only adjusts this singular call-site, and forces us to introduce a new
> function daemonize_without_exit() in order to facilitate it.
> 
> I personally prefer the other approach, for many of the reasons that
> Peff wrote about in [2, 3]. There are two questions in my mind that I
> would be curious of your thoughts on:
> 
>  * Should we transfer ownership of all tempfiles, or a subset of them?
> 
>  * Should we perform that transfer automatically via daemonize(), or
>    manually via its callers?
> 
> Judging from the other parts of the original thread, I think the answer
> to the first question is an unambiguous "yes". The second question I
> think there is less of a consensus on, but I'd like to advocate for
> doing this automatically via daemonize().
> 
> To summarize some of my thoughts after reading [2], I think that because
> daemonize() is about letting a process continue on in the background
> rather than fork()-ing children and then continuing on ourselves, *not*
> automatically handing those off feels like an accident waiting to
> happen.
> 
> I can't think of a situation where someone would want to daemonize() but
> not have the new process assume ownership of its locks and tempfiles. I
> think an alternative approach here would be to document the behavior I'm
> proposing above clearly in daemonize(). Should a caller arise in the
> future that *doesn't* want to this behavior, then we could introduce a
> function similar to your daemonize_without_exit() (maybe in this case it
> would be daemonize_without_transfer(), since not exiting in a function
> that is supposed to daemonize feels awkward).
> 
> I guess what I'm saying is that I feel that future daemonize() callers
> are much more likely to want this behavior than not, and putting this in
> daemonize() feels like the safer option between the two.
> 
> FWIW, I feel fairly strongly about ^ this, but I'm of course happy to
> discuss more if you feel differently.
> 
> (If you do end up taking that approach, that makes the C changes
> identical to the ones I shared in [1], so you are free to forge my
> Co-authored-by and Signed-off-by lines if you want to take that approach
> instead.)

Hmm. I was initially aiming for a more minimal fix, and that's why I
decided to make only this one callsite reassign tempfiles. But there's
only two callsites right now, and thinking a bit more about the problem
makes me agree with your take on it.

Will adapt, thanks for pushing back!

Patrick
