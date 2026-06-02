Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EC361675
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412325; cv=none; b=qNtF+z8iALZeW9jZPIEWmefX/8v5rcIVT1GCi0YODF4OaBaCwhhLLSVpAYKObGS4MxpygigtqrbgA7vLMxkjqm9wZz9fMnmy/guh5BHlBZIFmyIquAUosPtscw+DvKzRzZ3pRA2nXhC9kKOYWfX2PMzGVvez6SkUE3YM7UCOD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412325; c=relaxed/simple;
	bh=4E9fj69DBz1/Pb2wxMN5MB578of+ScgFtF/1JzSEymQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV5y+V05G8zKMwiYRdc3d40jx5AkGz70AuL2D+34KJApJTM1zPkVpY1KteU9We8qRarHyzkw4bCjodI9De5bcr7WXSqJEavssdubnpJjxCJG0hBED4WLA3FCBPWqDJKr7y+7B3PdaaKJXp9wNtI4u8XTpYtFuWp+VDhbT310HOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R66Q8olC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hi6bLNQF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R66Q8olC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hi6bLNQF"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id EF1E11D0018F;
	Tue,  2 Jun 2026 10:58:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 02 Jun 2026 10:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780412322; x=1780498722; bh=0H7iJZhk/d
	4DKdoGiqXEksfbTLa+3N2DZxUV7sFIAOo=; b=R66Q8olCjYctHsVfEYyWeRUjlg
	OTWTg1EZSzPI2c/wYr31Cy/yyChJ2F8UGheMbmnKwBwAQqv+1DmcrSupZPT0ecTo
	9ySx0qNzobAF3p7cRPF+5jB6BIwTUNsL6YUb+iWvsSDWGFuEsnDif/ouXSw1yuIw
	+2I1+/Xby6UDzhDyssmUijKCmrYHR6VzcBq14V2vOVMRZcEBrvg2UkuokcTREFOx
	6Uae4EyvxwJYolK4cdsa3UWnSV4k7RVaTo/zYgwJauJdCrIV/h5f7cjbFh+fvtLc
	hkFoJag5ZNLivy/g2zDQv4J5GvSsSWDfp2LY17IPDwM4anBt35zybLSPhv6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780412322; x=1780498722; bh=0H7iJZhk/d4DKdoGiqXEksfbTLa+3N2DZxU
	V7sFIAOo=; b=Hi6bLNQFrpv66/ez4ZLPJzaqkX/v4O6yavhuF+dLdUqk4fRrQMO
	r/8XAvVV91cyDD/Ya5nTtF4xi/pWaLsxYS/RJcv33gRXLujnej2zkcU7VB83cvsd
	0zidQgSvpbsDiHlEVSYi8NIOTsdZteLQao8VC5+BVNAjN/tKZzAItqD4w04uQnoC
	e3xVqvg6IsYqldzeRX7+KjhseYn2evg0EH05Naxp5rFr8I2RiPSNjXr/P/mbEyBG
	9O9+3ByYDW05Xhz2abShjfAi9Ftih84ndfcsOscaB8e/bxCpl/IKI6B5RV3kRKfG
	eXg+6RV6WfR/tTfEX6aa/x8PRW7bQphItCA==
X-ME-Sender: <xms:ou8ear-PGkDe9bEqnhAi1yunDmGep6HdfvA0M_9eO9Z-JW-nhRHSVA>
    <xme:ou8ealjcqCeAhBl-ajDO6K7tm0kx7X_oXI_bpB1ArX30dSBQN78GlghNIp4ZQdJXa
    QgzaCs6TpAVv7ZyctD87af4KudXqY5oBjZQUbytSa0VeTsDG7VUdQ>
X-ME-Received: <xmr:ou8eajcXPrfw_XvZvs8URtTtahPm6x_yHOZbKPnQvBslacvHREKEq6I6pL2s-NmFFaRhhChwMN2iu8Nb8dRd6Hp_sE5jewNnbWOFCgjE1Q>
X-ME-Proxy-Cause: dmFkZTFwRAtmKF0zI/T03Tt3NJfbVZn0F5aJcqg9dFnV5zeEFScux3ONpEO72CB6wB2clz
    +KlP2W6j87ajFJVThuF2aFCzIjjp2k7Fkr5ZDDD2Rnpyt3RfhiIiJkKPJscqQeqoDKaKS3
    eLsdMFIqdWMvuOEgQGC4iidNMKJMe1k5eFjMxWakkOP3ZXF/UMBAdjfieWdzuTQ/zX0kVL
    9yQray8bdO2zLAVGtxli4nC0r59+13p2dlUibWzUgWlVL0WChyIvaSMSK6mhCOrIBsAhEJ
    6hYBlFzJ19V9Bhw/t3kwvLAZQ06yzILueSCdQ/3h8l0R0DjYimSPwaqu4vKRmYeEh8L8oL
    4/fOoeCaKKkB+u9FU05JkMRkFaXDt8pwq2xUETQdvRAfVbeNlS8LdkdcwTIjErLn59w/T/
    eYfKvqArDWlTym8kly8cy7YwFCRlBN8dHa3ENGgc4vkyr4l0e//Ip8eTfRiL+6IBMtRH3J
    tpD8joMuPtJS6y+7JZzCJwqTZg5BcUHYoQchIyF7hzWP3094Bp8mxmamR9QjDqiPeozhyb
    uEomo/RGgkTBudx7tQbhd3g+2Bw1Z2GCo1VI0G4i6uZWsB1rMHTSUnpIU8ajWFJ+egzwEX
    sJh9fJC44Hs04GotubVR+w7oTcO2hvw1/WJNd8MWZxdDAfIqeyvBzbzu2rFA
X-ME-Proxy: <xmx:ou8eakqalTU9WPZlmuFtpT-jOXVPidzCslblWIu1jJQRWDDVwkRwng>
    <xmx:ou8eagBBdCm-aUmrpOIU-0JC4q77y-UHlWD8qoFQLxLnssAkIen9Hg>
    <xmx:ou8eapaTEiAAMWvUrDaRIZ8bRGP726dOVPJ5EOMrXHEeDcsN6YbMng>
    <xmx:ou8ear4t3B10iK25NSIKjIp96CAt-yCqjVJh_9A89dEH2BvME5rN7g>
    <xmx:ou8eagHCcv6UIoFRamDM3788eQyYZ_ZmZff8BvhRDuXTQXev7OYJaxVj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 10:58:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c68dfc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 14:58:40 +0000 (UTC)
Date: Tue, 2 Jun 2026 16:58:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Message-ID: <ah7vnZn72jhfmV3T@pks.im>
References: <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im>
 <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
 <ah2VL-ftCQelNoOc@pks.im>
 <2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
 <xmqqcxy93nph.fsf@gitster.g>
 <ah58IJ8DgSZYRjMM@pks.im>
 <xmqqv7c1xs76.fsf@gitster.g>
 <ah7N5bKAiAORtNkp@pks.im>
 <e6e225e7-f915-4ed0-900d-03a7767fb36f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e225e7-f915-4ed0-900d-03a7767fb36f@gmail.com>

On Tue, Jun 02, 2026 at 02:12:58PM +0100, Phillip Wood wrote:
> On 02/06/2026 13:34, Patrick Steinhardt wrote:
> > 
> > That's entirely fair. My take on this is a bit different, as I think
> > it's beneficial to accept a short-term adjustment for core contributors
> > in favor of making stuff easier to discover/maintain going forward.
> > > A new contributor would probably be quick to learn that every
> > `cmd_foo()` entry point is named exactly the same as the subcommand
> > name, but they will then eventually trip over the few exceptions like
> > `cmd_init_db()` where that assumption doesn't hold.
> 
> Yes, those exceptions to the rule are annoying. Though they mostly exist for
> a good reason (code sharing between builtin commands), it would be nice to
> minimize them where we can.

Either minimize, or if we don't want to (or can't) the next best thing
is to pick the variant that most folks will know about. Which would be
the case if we just picked the first patch in this series.

Patrick
