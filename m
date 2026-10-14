Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4441AAE28
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976106; cv=none; b=sb6MvzijsiMXSbpCJi1vwjseJbFpdkkHncghPVjgI2fmC8nm5Z8mFjd9LgHFbHjjU4tdLBea73j+Yea9eQldHBR5j/YHt1rIBGNpfkn8cC6t2snknsnV6X46d6LadFaVsgFC+wH7e7s/+9SnkO+suB7PvWfPKFF3lmJiKEtlIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976106; c=relaxed/simple;
	bh=QMLnIziBCYYHNSHr03UfBA8AdBCIrmr/gkTIqz/xWxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJLHH4vlXlTbzMIlRiqWqUAAWomE2ZJkrMTdOq1LEVUqFmTclvF4qwVgIF4oMl0AqQ3jypXVb8SvNAfGRd2xAlckWrl7HiK/SdJ01IMdF2cwlyu+qtRmiE2V5yEXOmnBxWsXqRoMMsgnzL3bZGNkvgXITGAsD8f8IeP8BY7oDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Hmhvaq6C; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Hmhvaq6C"
Received: (qmail 69431 invoked by uid 106); 14 Oct 2026 11:08:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QMLnIziBCYYHNSHr03UfBA8AdBCIrmr/gkTIqz/xWxQ=; b=Hmhvaq6CTzX4LGhjIO1SeWh781cBtIyQ0v9XqUviGL8I+hON/IQqnb1dWyEbTwtLA+807sYpadclsRgMjHpLNi6+Pp7pRvmMbFc5xxc7iY7DOo4cyhuw1yd2KQCxB62HS/efFBou0iuj0bffppcPDw+P0gZM/riuJ9+GWqhKYNLVnQjjSPvPUPfuVlJymumBt2sKhP/M681Pq3ReCJtvqT34gwGbkxOt0qzgPFE3RwWdmPWjW3Mkmcfy++JliSGYN7RKelBp/VsMYoPjYr2QjREfRw1h0BK1WroL4OuVHATB2m46cG/ka7yeP1Wkmq7XCLx+sbiHlpkubM5GeSX7Jw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 11:08:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36996 invoked by uid 111); 14 Oct 2026 11:08:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 07:08:23 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 07:08:22 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 4/8] ci: switch away from unsupported i386/ubuntu image
Message-ID: <20261014110822.GD1356555@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-4-04c24e1f480d@pks.im>
 <20261014091705.GC1341124@coredump.intra.peff.net>
 <as9a4WHSXY4pagpp@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <as9a4WHSXY4pagpp@pks.im>

On Wed, Oct 14, 2026 at 12:35:13PM +0200, Patrick Steinhardt wrote:

> > Makes sense. I did notice this hunk, though:
> > 
> > > @@ -48,10 +48,6 @@ ubuntu-*|i386/ubuntu-*|debian-*)
> > >  		SVN='libsvn-perl subversion'
> > >  		LANGUAGES='language-pack-is'
> > >  		;;
> > > -	i386/ubuntu-*)
> > > -		SVN=
> > > -		LANGUAGES='language-pack-is'
> > > -		;;
> > 
> > I think we have some tests which use is_IS as an exotic locale, which I
> > assume is why we add this dependency. Do we need to do something similar
> > for Debian so we don't skip those gettext tests on the 32-bit job, or
> > does it just work on Debian?
> 
> On Debian we already install "locales-all", so I don't think we have to
> do anything there.

That makes sense. ISTR having to tell Debian which locales I cared
about, but I think that's because I _don't_ have locales-all installed.

-Peff
