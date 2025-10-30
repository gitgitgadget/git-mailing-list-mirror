Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703D157480
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838753; cv=pass; b=dfKKiVuNMZXGJOaOP6cjhXdlJwSUdvSkMswynJxi3+2KMW+az33FMpBLAaZdAoXMWp+Ab02JcHph5+NSibrZqlejdDn8OSPpw5wIpqjczodpHW0RkZSX5cmuzPhYqXNYZG4YKaF4a9Aa7aWtxdKNok/r/jtKZY7Sga1yYXx/NoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838753; c=relaxed/simple;
	bh=oZiOszZOF4f8REHqNnjXycgO7VJ1Nhk2iwfOJeoOCE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn1di5/gFzyszMMxOvLaZ8ar6GVaRkUkxGn2AlDRvH7Pfd+mFQ+0F5Y8IELQK0ncOlOSK2H859PgSNz1D1ESBsGOLINnGMijOWR/fb41U1ALqUJQttyqtaubtRgUZCo4zh+MGvwY4GUjB+o1C9rIjxg+lWBj9JIWS1s0sf/YEcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=SlEvihdH; arc=pass smtp.client-ip=23.83.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="SlEvihdH"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 545328A306D;
	Thu, 30 Oct 2025 15:39:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (100-121-221-249.trex-nlb.outbound.svc.cluster.local [100.121.221.249])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8334F8A391C;
	Thu, 30 Oct 2025 15:39:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761838743; a=rsa-sha256;
	cv=none;
	b=QSiAHG7ZxklT+WcjhH6kDv9dWvrp4dhqgreVfVocPpY82ieAcNKnzaIjTzQZW9ja7EiVuH
	c79xEJLbKUd6GM8QxOee10FexjXlp1LZGfPHiCuzuqMFtj2sFiNdE/h9c3INerautQdQ4Y
	gdjCdZRkmD51ihIZJ3fxSQdFCLH5qxjDpy07mbBKUfSFmM4c05qD4lxTM9sI/ro6dWydEQ
	ocdxnhZd6JIP2BVNWcGYeOaPAMq0dXOWn87gIeo6ZReKLUWtv9Yvx+pVOuRBzsyhC2IDPh
	bpdFGETiF++KtsAnW8OujywB9YskN3eQ3eRe/nuAjO2NarMR9+cufTxQGN6c8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761838743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tf87m4ixLEyNxw2zZgf6xda58P9OT/iT88Dp0OOby2Y=;
	b=Yxm7wxFSlHaKyi7RDVDYu5NxEfjGewEJlzK33s1Rnle7N79iAL8ttf+byko58LW4nzsK4l
	L22wgJ4N7LhZjtNCR2wUAvM73NRGoH6g+JhMNvPl/40oWJJ76PypncEEbQnT5cA07nntr3
	bwfd0HzS3cuSCO9d8TaqBZgLiP8CNqQphI5a1XdLuSdhdCeHPFDNih2MKmypcVhIKwFpdP
	XTMfSParmv+J8k1iuMIVmrP65oOyriveYecKYCcrgMsb1YwffEj8yfx74JHZ2GGw+bMnK7
	CUj+jDRqtW7P5ZQxEfjQQvDdRE1wzXYebt5/n6xVhJ//3EQmVFBN511jDb8V8g==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-zsxvq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Spot-Invention: 0e3f159034a5fcc8_1761838743741_304950320
X-MC-Loop-Signature: 1761838743741:1284293451
X-MC-Ingress-Time: 1761838743741
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.221.249 (trex/7.1.3);
	Thu, 30 Oct 2025 15:39:03 +0000
Received: from ubby (unknown [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4cy7ZG5Tcfz6q;
	Thu, 30 Oct 2025 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1761838743;
	bh=tf87m4ixLEyNxw2zZgf6xda58P9OT/iT88Dp0OOby2Y=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=SlEvihdHqHjiYPyWIa1zoIeazws+JeUBOXoS1yFpIKaEPK/eSAQZvuWnyPeSSp7A+
	 +30OQCY8UCm2xzmBL3xMgvYuis8K8BGtwhFvr4PHOcoyr9tpj3ng6eB4aJTuVwv3E/
	 q/iRPnRlFA1Vbs7M/uRE4NSj0kObNddXmZXQxL9uIgsznFuhDx+5RvI/LtrCog437G
	 9cZEP+Wqpe8ATR/AKdGhjMV+DWHiggUmz8h867JxOXu0g/xQkIpY06cb9Qdm13YlXO
	 19l4x7qxgEeHd0AbDoNN/dNEg/+6IFdPD7lI5b5HwT8Fd+pBY+7kK+E6l1c1lQXQgM
	 PC468XKdws+gw==
Date: Thu, 30 Oct 2025 10:39:00 -0500
From: Nico Williams <nico@cryptonector.com>
To: Mark Bauermeister <warfan2007@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Cease and desist for companies and government agencies misusing
 git
Message-ID: <aQOGlBhrvtmpbfDJ@ubby>
References: <CADanQgA3h52hax-mdSTBV-tNDGvNRSxLU217aVygj7Cs7Lu8Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADanQgA3h52hax-mdSTBV-tNDGvNRSxLU217aVygj7Cs7Lu8Bg@mail.gmail.com>

On Thu, Oct 30, 2025 at 04:27:10PM +0100, Mark Bauermeister wrote:
> Long story short. The guy who was responsible for my firing spent a
> good 4 months journaling my work and harassing management behind my
> back only to blow up while on the phone with me, accusing me of such
> heinous crimes as sending a PR from a fork (at a time I didn't have
> write access to the main repository...) and *gasp* REBASING.
> 
> This dude is convinced (to a religious fervor) that Linus Torvalds was
> possessed by a demon when he came up with `git rebase` and that in
> order to defeat the devil, we need to plaster merge commits
> EVERYWHERE.

That's nuts!

By the way, Linus did not invent rebasing.  We used rebasing at Sun
Microsystems, Inc, (RIP) since 1992.  We didn't call it that, but merge
commits were absolutely verboten (they were called "merge turds").

The Solaris engineering organization had thousands of developers, and
often tens of large projects with their own "gates" (forks), and
everyone rebasing all the time, and the end result was linear, easy to
understand history.

Rebase workflows are the only workflows that scale to such project
sizes as Solaris used to be, or as Windows, Linux, etc. are now.

Nico
-- 
