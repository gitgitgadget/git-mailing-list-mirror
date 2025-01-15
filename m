Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA8D199244
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965463; cv=none; b=VlRfdVW2efvq8rKZ/tn0u8RS701cDOwMuh7Ij1nxr7tyhYxpyZ+Qq2qnYHrzM0eANDRwJvCI4kp4lZNmdO+urbSFZMvNNLwpGoVpy7RSp2zCSXi4vs+8mbszSChrWituNj8Nl1ks+RkIf+gs4e518jhn3gQmqTn0xx+2xXO3QDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965463; c=relaxed/simple;
	bh=AuYt+TyJPhFJNQMuEOBD0s35vUzdBTYN6Q4LZP0n+qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFmlfb8QWWBUodzw9Hw8ErAfXhg2O4/eWfBylD3j2NTlttRf5SGDjz/GDdMoMGCX/jjyJeS0HpOVLNkegcNutvmslie4FEz/buPfFCjJ7TsqI7mELOuJq+y/jgz3oudpwPpJTQL9izskpIYKDIgDaoOZ3eKp5CoY1+LBhpgFHBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DNMb1FyG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DNMb1FyG"
Received: (qmail 6226 invoked by uid 109); 15 Jan 2025 18:24:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AuYt+TyJPhFJNQMuEOBD0s35vUzdBTYN6Q4LZP0n+qc=; b=DNMb1FyGyIkSgGktJUxRjWJtHE9/Am4LBkElxWqR8oRrCPpWSC4tl9Ur5Xb9dfTT/Df7n7tQ8r95urbxbVG/imOzv8IOXJsMOXc6hacFauKIoPSluSgOfyOcTe85xgQETlb3GYmXUS4btxHu94MIrblaJUPr62Zu6DQpjcTqGi5oJ6WG8soLEEHcTriIgH4pEJKxLUubi6E/dVylkgG74TYMWntReCzuj+3iMcliSh56BvlLg2nOFkErktU3U+8r8DDcA48W75p6BQKUnw317gKN6Q0eWh/KwmIZtMsz4DLnZd/syoGfWgnHlnJfU3bqIdW7aZwYUfTmf9c5arPL/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jan 2025 18:24:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12297 invoked by uid 111); 15 Jan 2025 18:24:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2025 13:24:21 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Jan 2025 13:24:19 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>,
	Jonas Konrad <jonas.konrad@uni-muenster.de>, git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
Message-ID: <20250115182419.GA86610@coredump.intra.peff.net>
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
 <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu>
 <xmqqed1414gt.fsf@gitster.g>
 <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
 <20250115171423.GB57018@coredump.intra.peff.net>
 <xmqqmsfsx8oo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsfsx8oo.fsf@gitster.g>

On Wed, Jan 15, 2025 at 09:56:23AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > use that everywhere. Possibly it could even do the argc/argv check, too,
> > since every call site is going to be doing that itself.
> 
> It would look something like this; I am not sure if I like the "this
> may show help and exit if the user requested, but otherwise it is a
> no-op" semantics, though.

Yeah, I agree it is funny to have a "maybe noop, maybe exit" function.
Perhaps a different name would help? I'd expect show_usage_help() to
always do what the name says. Maybe check_help_option() or something?

> +void show_usage_help(int ac, const char **av,
> +		     const char * const *usagestr,
> +		     const struct option *opts)
> +{
> +	if (ac == 2 && !strcmp(av[1], "-h")) {
> +		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
> +		exit(0);
> +	}
> +}

I think parse-options will exit(129) in this case, and that's what t0012
insists upon.

-Peff
