Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35683503BD8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976040; cv=none; b=BaKs96F+dLzaCvoBg0uVu5UUXmCgE62IMge/IZUCvYvYHyCVl2YQtYE7hZLEjpmBWDOweoLJjyfFKIX4+0SUXTC3CuhErHGzwwami8kDfQa/K0fUFst9Kep6SCtRjxdCRQxw5epFjyJ/ktkZlgfqGg3aL3qET9z8m2Hv4DsiQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976040; c=relaxed/simple;
	bh=A7RYhSI0NhJLPrGAjpXfW1ySb1HL4oYVqfdh27IbcSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAvbRlTYC5eisWw8p7A5uvRJRBTDiQvPbSHmmaSmH3izuffv+eHdhgAQuycRRXhnSozRUVLVikovOALOlaJfZvoXQZSW5zzxDIc1hAca0BeGoiT44/OOwSqFC43JBl6I8XZY4pBqI4Q9ZOaKPgsLOjmiAkOlnxKhkt2Fw3O/HTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XXt+mTlh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XXt+mTlh"
Received: (qmail 69416 invoked by uid 106); 14 Oct 2026 11:07:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=A7RYhSI0NhJLPrGAjpXfW1ySb1HL4oYVqfdh27IbcSk=; b=XXt+mTlh5nNYv83JjHtuK5228jSDWdvk0uNwILZa8XH108YTVrCZp4HhAQ3/BTlKrHaV4sm3q7q5idxvEADxqN4bPndXdoaSUMydtRkiwBfVZN8mYoGIBormC8dj5Ir2v9Va21SSclBpwGSveNUMtMCyHsK69pwmsPnQcOge/oQ8cr8PFd/C08DCA+8jbMQkdqcEq7JcFpIZF3XyQ/2cnOqmK5TM6oGAdGrMYDxyEQvewUmn+agFbu9xWFdsaUGmeIUUcZ0GWqQ/y6GYJK/zMq6PWrmAjeLUECMsoqiIUNy+eEYLBWvno9am6y+s3azK/usgBo10+h6+5S76aH6f6g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 11:07:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36988 invoked by uid 111); 14 Oct 2026 11:07:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 07:07:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 07:07:16 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 2/8] ci: fix "fedora-breaking-changes-meson" job
Message-ID: <20261014110716.GC1356555@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-2-04c24e1f480d@pks.im>
 <20261014091037.GB1341124@coredump.intra.peff.net>
 <as9a3E6NeR_sQeYd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <as9a3E6NeR_sQeYd@pks.im>

On Wed, Oct 14, 2026 at 12:35:08PM +0200, Patrick Steinhardt wrote:

> > Seems obviously correct, but I wonder if just:
> > 
> >   *breaking-changes*)
> > 
> > would fix this and prevent any issues for possible future jobs. The
> > downside of a loose pattern is false matches, but it seems like a small
> > risk given our universe of jobs.
> 
> In general I think the way we structure these is somewhat lackluster:
> 
>   - I never really understood the split between "ci/lib.sh" and
>     "ci/run-build-and-tests.sh".
> 
>   - There is a bunch of duplication that could be avoided.
> 
>   - And your suggestion makes sense, too.

Yeah, I think there is a combination of organic growth and the fact that
nobody really cares about ci unless it's failing. It is probably ripe
for cleanup if somebody cares to spend time on it.

> I originally carried a patch that merges all of this into "ci/lib.sh",
> and it also did changes similar to what you propose. We could probably
> revive that patch, but if so I'd propose to do that as a follow-up.

I'm OK with doing it later. I noticed some other similar spots in the
context while reading your patches. E.g., anything with *-sha256* could
set the default hash, and so on. I expect you might have found them for
your patch, too. ;)

-Peff
