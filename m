Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB77E2857F0
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771500561; cv=none; b=nGo4+nGN/v6QMG99jGeJcxhrI2xLxlw1uKFXnAg6r/jAUylTlF8m4ofkTmPH5IbG2srCVJOTr9L6Qtn8GQDOsre3K+SA9duZd+yWTpZsU6tWizzA4+8PGjNQHV9t5S+Kn9ueKn3HO5kuh5pyJwhv6poURA/D/VF4FtgZCTGYdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771500561; c=relaxed/simple;
	bh=Sz01GBn35xDYMW8AEKwl3yVrY4pvxo6S6YIml4IJ/cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwUE5E8PQo0mstl9xxv3QqQdzcPNLniw6TF0wZ4v3XsUA2Cgk4seWmiM7HQYNct5Ole6WA80xbUtWIOZ1jUAZ68DXrkRuLdEIrG2JP3EUqFLvlbinKeOaWuMjpA5h/dKpkc2srIyVa268decrVFqHtWBjBmRC5N2IQUBQJVmhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TmJhcT3r; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TmJhcT3r"
Received: (qmail 2272 invoked by uid 109); 19 Feb 2026 11:29:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Sz01GBn35xDYMW8AEKwl3yVrY4pvxo6S6YIml4IJ/cw=; b=TmJhcT3rpWKlbriZU2ekIARueHQm5MHnHjVcglYBe2/I1IHsF5+gSlG5a0BeqstJm7pCn21Q8MDrXGMXbhslmnmOeMTZJ1WKv4pf+b2oeqHhkj4u6y8d//Qy+fpClzPSmabdFBBDOS8HeeeH3wD/GxmfaBL/p0iJJ5XRyWlpTKC7x1TumgDvAzubhH48slMJI9vUNS9sCvleRzz9ZL+1Shtu4vBVhGoiq3dkMoIFc++/TjM3MvRrKduKoCOaj2HzChfYLBx6O8X1SvhG/yJS/xpBxdMpA5rS8dfX6Fqr8CNiK5necD+ZyPyFCHGub95x3eVej6Y1HjpZBFN4pg/AnQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Feb 2026 11:29:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4590 invoked by uid 111); 19 Feb 2026 11:29:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Feb 2026 06:29:23 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Feb 2026 06:29:18 -0500
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
Message-ID: <20260219112918.GB3529@coredump.intra.peff.net>
References: <aZAMr6XOwKkTa55q@exploit>
 <20260216152730.37478-1-mroik@delayed.space>
 <aZQJEDyUyMv4_c1l@pks.im>
 <20260217063400.GA101988@coredump.intra.peff.net>
 <CALnO6CD6c36ur4cxqNAB=Jy=m6yxVfoSzAAekewQZr2vjjKn2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CD6c36ur4cxqNAB=Jy=m6yxVfoSzAAekewQZr2vjjKn2w@mail.gmail.com>

On Tue, Feb 17, 2026 at 08:21:32AM -0500, D. Ben Knoble wrote:

> > I think that wording comes from me back in 2013, and I just never gave
> > any thought to cover-letter generation by format-patch itself. I never
> > use it (and I probably forgot it even existed, given that most people
> > would use send-email's cover letter generation, and I do my own thing
> > with mutt).
> 
> Funny: the send-email manual's main mention of cover letters apart
> from setting Cc/To fields is in an example…
> 
>            $ git format-patch --cover-letter -M origin/master -o outgoing/
>            $ edit outgoing/0000-*
>            $ git send-email outgoing/*
> 
> …using format-patch! (Which is how I generate cover letters, and
> probably part of why.)

I think I may be showing my clueless-ness about send-email here. I
thought it had its own cover-letter code, but looking at it briefly, I
may just be wrong. I don't see any code, so I guess people generate the
cover-letter independently with format-patch.

Maybe nobody noticed because most people do not use "--from=<foo>" with
a <foo> that does not match the committer ident in the first place. I'm
not really sure why you'd want the two to differ. Which makes me wonder
why I added that feature in the first place (as opposed to just "--from"
with no options).

Mysteries of the cosmos, I guess.

-Peff
