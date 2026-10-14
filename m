Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625CB534451
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985663; cv=none; b=IuXJ+Sc0yEWNKKbqt5PDakeQbx7gDMzhtSSZ9BzJCJSNnraZ6lmYOentXufQAA0LO4rZCEPI5Xo4rrhYTwrQTzgyp+WBeVM1NLM6xmjlzJ3Cn4noWEeo8NE1a566XtgTWfQolTui5fXAH7HFUpwJIKIx/peD2KXJPecucW1IWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985663; c=relaxed/simple;
	bh=ITrukaBiJMlFUp+8Ownm1sCQZwoRktWrkrA84uYxH8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP3oCKtluqOqoUD5q/86iOAYc4LEzDTE3CoTak941vw11XSXyU3VmuVjIhCybXMsps0+amPjZGfQvtM7ELjm9yfhuyK/50VZT+Nzozbi/VdwiaID/dJ8+/IAKDGt1Q3d5nf3/ZBvCQ3kELaq6M2NhMxlRQyQjkYcOsuHXqEKqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hSejnRlZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hSejnRlZ"
Received: (qmail 70013 invoked by uid 106); 14 Oct 2026 13:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ITrukaBiJMlFUp+8Ownm1sCQZwoRktWrkrA84uYxH8w=; b=hSejnRlZjV7zbe6kyMxcKkqMjkD1GqHQT668fON3okkWpeIXkPJVr0ghbvFY+XxzbwDE2GOMWWWyQ8JRZgY50O121aT8qG9utiWj2ygTugErKNj2OAQ8MAmEvzp+QelQf9seyKJS3gouJKQxhCLrRaqDGeWnCQyDDLomGFJAEpBAam5LWJMhpp7Tx59YHAjCWyfwIboIxpR4b3kEO+OJFJJkWoZxd5HELKjOGvKWZrgwfPv4czSdXYxf+GrP4CpOzgACxhQ1f0HkUhQ1NUrdpYpKv5HXdSGREScaipwWo+yt4JzaBhBkGY9KVqwQHZKLfbEqlt8m51D3fWCf1Jw8hA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 13:47:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38423 invoked by uid 111); 14 Oct 2026 13:47:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 09:47:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 09:47:39 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 8/8] ci: improve reftable test coverage
Message-ID: <20261014134739.GB1935857@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-8-04c24e1f480d@pks.im>
 <20261014092137.GF1341124@coredump.intra.peff.net>
 <as9a5RngDLM8Miue@pks.im>
 <20261014111344.GE1356555@coredump.intra.peff.net>
 <as9lGraxDWjEjhCK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <as9lGraxDWjEjhCK@pks.im>

On Wed, Oct 14, 2026 at 01:18:50PM +0200, Patrick Steinhardt wrote:

> > I'd say we can punt it to another day, but if we _do_ think it's a bug,
> > and we fix it, then that would make this new job pointless. I dunno.
> > Maybe there is a good reason we are not pulling the ref format from
> > build-options in the same way.
> 
> As you mentioned in a preceding message, it's probably just that stuff
> has grown organically. We added the job when reftables was not slated as
> a breaking change, so we couldn't really pull it from the build-options
> at that point in time.
> 
> I'd punt on this for now and just leave this as-is, because right now it
> increases our test coverage. But if we revisit I agree we should figure
> out whether this job is still worth it.

That's fine by me. We should just try to remember to re-evaluate the
sha256-reftables job when that happens.

-Peff
