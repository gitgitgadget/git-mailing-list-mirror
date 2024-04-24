Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2915746C
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994913; cv=none; b=KS3NrPIhZvV0lV/p8CiQZBdloVKbchX2UJ1rSFAvM9urARRDq8YXGl1ONWJoO+9ROqDUCVODHr/rs3ZC1kollHFFYDBKjqOOpJWXb+sJy15q7De5cm4N2IDehFeaSATeKB9DDSmqidDWcxQ9swjcZmcU8Z24yUSy/VrgpJKTIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994913; c=relaxed/simple;
	bh=KvuxLwFhr0oQ7DIhc17KxaAfGGCYJ7ZcuSYIpdcQHFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f49feH51vYvng9MtEWVO1vcSupsur+gC1RsEZ2uZtg8nFj+7Yy+vXJvz8sMAxoYQ8IVatMeYdXOh0Kug0VnVfctmfHkScUpi1MsC7yO7xulUcby8VatgLpF2jjlaRUU5EAck1219HFiqFQK7SVr61I/Qz9tJ4YqZ7ZuvU/t2t8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzkNA-0003ku-Ke; Wed, 24 Apr 2024 23:41:48 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzkNA-00E9GO-1L; Wed, 24 Apr 2024 23:41:48 +0200
Received: from rhi by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzkN9-00Bfzt-36;
	Wed, 24 Apr 2024 23:41:47 +0200
Date: Wed, 24 Apr 2024 23:41:47 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: add docs on how to add subcommand
 completions
Message-ID: <20240424214147.qlpyy3cdmb43n47v@pengutronix.de>
References: <20240424210549.256256-1-rhi@pengutronix.de>
 <20240424210549.256256-2-rhi@pengutronix.de>
 <xmqqedauxx2c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqedauxx2c.fsf@gitster.g>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org

On Wed, Apr 24, 2024 at 02:36:27PM -0700, Junio C Hamano wrote:
> Roland Hieber <rhi@pengutronix.de> writes:
> 
> > +# To add completion for git subcommands that live in external scripts,
> > +# define a function of the form '_git_${subcommand}' while replacing all dashes
> > +# with underscores, and the main git completion will make use of it.
> > +# For example, to add completeion after 'git do-my-stuff' (which could e.g. live
> > +# in /usr/bin/git-do-stuff), name the completion function '_git_do_stuff'.
> 
> You have either an extra "-my", or two "-my"s missing, in the above.

Ah, and I deleted one '-my' in the line before sending it…
Will send a v2.

 - Roland

> 
> > +# See _git_show, _git_bisect etc. below for more examples.
> > +#
> >  # Compatible with bash 3.2.57.
> >  #
> >  # You can set the following environment variables to influence the behavior of
> 

-- 
Roland Hieber, Pengutronix e.K.          | r.hieber@pengutronix.de     |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |
