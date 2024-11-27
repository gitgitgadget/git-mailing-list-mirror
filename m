Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692311917F1
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696256; cv=none; b=g87WDOumB9d6l9pw5XDzrFE6ZbCB8UJPA35Q/NUDK46U2s1U9eI13RpGvBrfVbpYbpBHo9n2ZA8//JwdnKMfAHhl7rh9oUf5ozhW9hYbaWDc3zPCO9SNDX3vAko9pi30ovdzVtP8Qefm8WVox9vjI5yw4JPZ2MALIGhuC2CIpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696256; c=relaxed/simple;
	bh=hG1Ml1j/3xxyKtbHZlZsRwlr7aLERoNVeBP9nX8piPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF8BvDK7HbS4scd7eeIVjJWd3RHJV+OruDUpwORYxnkZQPdnzHRArxmjv46BYKbnKz2r3zZ6JIIrIPf3DXxTdVFJN+ZDVNshQbRfIUz0qeXczCWbvUALfbcizDrKWmvUeV5VAI47hHb32f8VPbcTCvFrPihOn80n94TuOa2lUVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=arllUmHl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ngpFuLjP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="arllUmHl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ngpFuLjP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E0271140191;
	Wed, 27 Nov 2024 03:30:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 27 Nov 2024 03:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732696253; x=1732782653; bh=0g2YFr8Ooi
	jHxylJac9UHjx8ggmxGvPC+wOYas4Jx6c=; b=arllUmHlh6l8kEp5KeuGfEL9nY
	aT7ofCjp+EaPF873q+ouFeOSKCv/CiYb/bSXIN7Jr3aLoTisrbFj8cLGmTY0rGdF
	xYa1v+MfobcOjKLvjAzFizAEbwr1bfJL6x9ppjJhUVjbw5U2G52pb38TXDVGgupc
	0NZs/QHtkndNrc7AyO8BknEnQ6zKdqh9OHCj6ah8LUPMqAT2Y1xsT03Dko9bnkM2
	yrdjiLCpVejzlcmeD8xNCsBnWVMPkAzNf9qDUHdh+vnbJ7yctDYGVYChfQpdHkt6
	oGiEIRSu0qEHvRajpLCTmKjJjd6tQaySJ5kN0byPhfk7li18Ms3neASRLaSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732696253; x=1732782653; bh=0g2YFr8OoijHxylJac9UHjx8ggmxGvPC+wO
	Yas4Jx6c=; b=ngpFuLjPLHfsuk54UeA+mcEf3R69ltFYQ8f2tdVbXqLC3iTvbNn
	FkgSV6Kz5soxFx2hpuytk3QNdWRqd4W3VL29JNdGAf+FfK74t7V9kpb6U7A5eWYL
	cSeA2ZLqpY1SfL5j1OCNdL2IcpQy1dbOzTDw20y8ODGOoo9s3X13Yo17kTuI7ymt
	EhGMvvQGhLVLjeenfVx92IrQId9uJy/juXrScSHNnhA8lpbio+jn4J95b/Y3JaBh
	RVrqB80OvTM5QoEmRQNT7Hg+2SEZqIbFZv0jjrUQBvZk9CA/834PUwL3i0/DeGgZ
	gfRx6apZ0hKDeg3Vv4S7QMnoLuUh9oKmSlg==
X-ME-Sender: <xms:vdhGZ-if2daRnU_E7aPALFj_UPRzyy2Iy6e4e8ZxXTIPCMEDAToGxQ>
    <xme:vdhGZ_ChKeIROX0ft6WlT0tnUNQqUIgjTzcJRmDp53nH_a8SUzH_WKeBHVagz8Jd7
    oGrZUYt7_0fgZ3nHA>
X-ME-Received: <xmr:vdhGZ2Hr1xNkMBeqrzYBh5PD6QA5-J2s63XdbF8PWpMNJcIUCTZdj37Pq5dKuee-XQpw57RXsT9bT1dq6Zao3-M0_mL2ajsTnx-ql4qwyvQVgQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeekgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvth
X-ME-Proxy: <xmx:vdhGZ3TKt9DlDRNIJ_vzMmAKg16GYYN7yGATxqDuJ8VSrXNp2dOdvg>
    <xmx:vdhGZ7wvWXVKvut8YZHJAlpS7qQh6nmg9yrlg2vlmIhVQ9C4cohr8A>
    <xmx:vdhGZ17XEqK-QJRxfaPBlBxODIRt2IqIHwldRi8x8pSzKdsYKTrR1g>
    <xmx:vdhGZ4y4yXC3NJlq0xO01dfxu3C6yqCpMnc5eofSR0ahRMVNRAe2Aw>
    <xmx:vdhGZ7-KbwDi63CwQFyXtrZDg2MbcKySU824ZMaV-h-DKSGxpfaIJeL_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 03:30:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 905882cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Nov 2024 08:29:45 +0000 (UTC)
Date: Wed, 27 Nov 2024 09:30:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Nov 2024, #09; Mon, 25)
Message-ID: <Z0bYpiP2JDEzqJXr@pks.im>
References: <xmqqttbv4ty8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttbv4ty8.fsf@gitster.g>

On Mon, Nov 25, 2024 at 05:07:59PM +0900, Junio C Hamano wrote:
> * bc/ancient-ci (2024-11-01) 3 commits
>  - Add additional CI jobs to avoid accidental breakage
>  - ci: remove clause for Ubuntu 16.04
>  - gitlab-ci: switch from Ubuntu 16.04 to 20.04
> 
>  Drop support for ancient environments in various CI jobs.
> 
>  Needs review.
>  source: <20241031234934.3451390-1-sandals@crustytoothpaste.net>

I've reviewed these changes in <ZyixnuBY5TcyrHEj@pks.im>, even though I
don't feel a 100% qualified to comment on the GitHub changes. But given
that bc/drop-ancient-libcurl-and-perl has been merged to `next` by now
it would be nice if the above series could be merged soonish, as well,
so that the GitLab CI is getting fixed.

Patrick
