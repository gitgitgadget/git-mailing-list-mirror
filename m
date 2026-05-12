Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3040FD83
	for <git@vger.kernel.org>; Tue, 12 May 2026 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565581; cv=none; b=mu6D7QbKQ3L4FYQOwITwuwrpKt9B/3JV6IHB6w6alCljKRgmcZeI7ud7YNP3PWa0TXxDYSiQLgb3NidMO4GHiUSmXJ0eZg3GZgZ6ZSW5NIArjDo3551ot6yYmG9QDkoJkKjKwegomWxPAAsZgESgOF1ayb/+Ui60TkvTO7J5BYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565581; c=relaxed/simple;
	bh=ZPu39Iyo94VSLxTKN/B3FCFEpvVB4Q+cXkXdBLgmRpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuz7LdJ3umY5QQmDL8BHpaTW+e7N4RKcdIjCpm8gVBKrruFiTEZkvSynTTZLjl5LvPq65ZOVqUWyo5qe1673R/TSiBwDvpBHAGviOJoRB+uOJciVySp8taONu7BimHAU+/Mlc5Fe4O4rY7/x7DJnEWFndt5oOdGbpXbO5u7GmM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cJdLj64H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sRbxoFiK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cJdLj64H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sRbxoFiK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9EE9D7A0097;
	Tue, 12 May 2026 01:59:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 01:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778565563; x=1778651963; bh=Fjn+cqzDAD
	QTePCFdKBSaUWAWMK5y3DfRJQwc37QMAw=; b=cJdLj64HxBI0AIdx0YfrXmQ2xZ
	ZbeNRP7ufFgmdd6rboAVfVP1y4zX0SP3BRZyTEHpPSh84dqe42+rsltEuHPNyxHy
	H2sAK+FdaX74/Yud0SPYdtoQ+QFUXa8dJOzpHsI/7QFUmO02nyeN3nzHCYveASS2
	EsTqYogEAN/hD/MR07sskwI7is6WefDL7JNhpiCcEdoJU12MEzZbT+IkJJdUB4//
	R6ZdASvhunLOJLMzmhmgBTnAsWGh8IAsPKX36JLrpwCyPyp0dLioch0J0ETI0D5i
	oC7Sy0garxNmk/DH7wPS20b5Sogwip+20lCVNPWPlTVznv0+iKb8Ap3cqzfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778565563; x=1778651963; bh=Fjn+cqzDADQTePCFdKBSaUWAWMK5y3DfRJQ
	wc37QMAw=; b=sRbxoFiK0KxyHsOIuQYpBcyn3EJrhqkuvmIa2Wgw6rG4ytL5p4l
	MpeUROTcFIUrv01nGoc6Bj8YwBN099ZheI0PamTwcXarYLM/aTkOAZcXKQKHGAWU
	L0PxdLdjI2ajK3680EtrgNcyv8CWN761794T5xK/QQaEMEnCTTiZC1oU3HwRZbyt
	um1yS7Vol+47gTSSpTSWvGZqTvnRjOjQ6m+UyneRAa3YXLnqSswHGzgcjgk+77Fu
	Igl0pNP5XzgM3KV8qbA8D6MrbMapVlVDkxQqDuR8xC0oY56zoJ2iswlS/+Z5awDR
	aOt0rs9l2rf01Dc8gcDiyvrPaZP79pi/M+w==
X-ME-Sender: <xms:u8ECagNTgTIr6SvD4FpL6QZPHwSXv0MT1qLqq5n7bzzvtOtUGDSTjw>
    <xme:u8ECapMON9EfIrd9c8GdcCxKhIZlz6bjOASMhab-26Oa8C8skxDNmMwpi95s733my
    w0MLnrFnuAxWe9EKXGRPWJVf7Es-cg_8q_PmyxN2myoYRcvqFwT>
X-ME-Received: <xmr:u8ECapgiUWAhP3Zc-TYYFz-buMpXtoVkAMJr3lyITCN9CRpOQ6QJGAIL--88K5MmtAm3fN7_Px_EWFAInwbxPjSd3pTjUNAq655ahfwK_TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmihhkrggthhhusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprggtthhiohhnmhihshhtihhquhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:u8ECauu4byqW6yRaiJ_ObL280DOfNSbOlr7ngVFvfUov7dxqjETS6Q>
    <xmx:u8ECanSyDfymJOeqndXL4UdLXoFGqvi35xyaFVRVzpb_VDszzpuVHA>
    <xmx:u8ECai2TZg2Y-u_IzXZ1hnfQLeaMrtHhRImJdxmScM1BvQOKQZ7QpQ>
    <xmx:u8ECastzPQQsWPhxfVlhdhEE2moSNvqcKvj_HfvmnXKxqb8YQUECyg>
    <xmx:u8ECahPMDrkC6VdTcWKq6TtMpuxKH3Rg33k0Dkuj2_2rim8yTWKMr0Qu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 01:59:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b39fe22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 May 2026 05:59:21 +0000 (UTC)
Date: Tue, 12 May 2026 07:59:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/2] builtin/maintenance: fix locking with "--detach"
Message-ID: <agLBtvKtvWFn64-Y@pks.im>
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
 <20260511-pks-maintenance-fix-lock-with-detach-v1-1-ccd7d62c9a40@pks.im>
 <xmqq4ikdqvad.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ikdqvad.fsf@gitster.g>

On Tue, May 12, 2026 at 10:19:22AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 3a71e314c9..09cb92ac97 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -1810,10 +1810,32 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
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
> > +			 * We're in the parent process, so we assign ownership
> > +			 * of the lockfile to the child and then exit immediately.
> > +			 */
> > +			lock_file_reassign_owner(&lk, child_pid);
> > +			exit(0);
> 
> The point of reassigning the owner to somebody else is so that we
> won't clean them when we exit as the tempfile.c::remove_tempfile()
> function checks the "owner" is "me" and refrains from unlinking
> those that do not belong to us, so there is nothing wrong in this
> code, but this somehow felt awkward.  In a sense, child_pid here
> does not have to be what fork() returned but anything that is not
> our own pid.  Perhaps "we assign ... to the child" -> "we relinquish
> ... to prevent us removing upon exiting" would convey the intention
> better?  I dunno.

Fair. This is what I got now:

	/*
	 * We're in the parent process, so we drop ownership of
	 * the lockfile to prevent us from removing it upon
	 * exit.
	 */

> > -int daemonize(void)
> > +pid_t daemonize_without_exit(void)
> >  {
> >  #ifdef NO_POSIX_GOODIES
> >  	errno = ENOSYS;
> >  	return -1;
> >  #else
> > -	switch (fork()) {
> > -		case 0:
> > -			break;
> > -		case -1:
> > -			die_errno(_("fork failed"));
> > -		default:
> > -			exit(0);
> > -	}
> > +	pid_t pid = fork();
> > +	if (pid < 0)
> > +		return -1;
> > +	if (pid > 0)
> > +		return pid;
> > +
> >  	if (setsid() == -1)
> >  		die_errno(_("setsid failed"));
> >  	close(0);
> > @@ -2180,6 +2178,21 @@ int daemonize(void)
> >  #endif
> >  }
> >  
> > +int daemonize(void)
> > +{
> > +#ifdef NO_POSIX_GOODIES
> > +	errno = ENOSYS;
> > +	return -1;
> > +#else
> > +	pid_t pid = daemonize_without_exit();
> > +	if (pid < 0)
> > +		die_errno(_("fork failed"));
> > +	if (pid > 0)
> > +		exit(0);
> > +	return 0;
> > +#endif
> > +}
> 
> I was hoping that we can do without the #ifdef in this caller as
> daemonize_without_exit() already has exactly the same condtional
> compilation.  If the NO_POSIX_GOODIES side can just return silently
> wit ENOSYS, shouldn't the callers be also fine if we return failure
> instead of calling die_errno(_("fork failed")), I have to wonder.
> 
> But because (1) as long as we have to call die_errno() here, we must
> keep the conditional compilation in daemonize() as well as
> daemonize_without_exit(), and (2) changing what the callers get when
> fork failed here is totally outside of this topic, I would say that
> the code around here is good as-is.

Yeah, I was also pondering whether I can drop the additional ifdef. But
I eventually decided to aim for the most minimal fix that has the least
potential for additional regressions. So I aimed to keep `daemonize()`
semantically the same as before, and I aimed to only fix the issue with
the lockfile we know about.

I agree though that this is something we should probably clean up in a
subsequent series. We don't have that many callers of `daemonize()`
after all, so it shouldn't be that involved, either.

Thanks!

Patrick
