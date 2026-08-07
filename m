Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E454EB640
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786144751; cv=none; b=M0/tbKJwu6yQo0JbSn+Z4aumLGFQc+nsTRCE+nN9f4xBROydRcJ4IYJ4vc4tiS15MFsdS7D9Ke95hRuZSr90uoMZ6aHBCtvAKdXUiN5o27Mto5fPgmwDkkYEwS6umg1UunHL1egQoW+OjNI3i7Ct7Vaf/ay8zXCPQ7j0ReCSGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786144751; c=relaxed/simple;
	bh=gkb2210bStUYBdvR4JWn1j4Kg9aG2AAXrPlEhDJatVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USCNzlYp7aEjPNChPcrbBbSiljIjFRgvEto2F3hESWXTLG9Cr0i3UKG9UEKJyI9WKNeb2P/BR2sMJyvqtzhNz6gEsd8b39bdb36sLZGHTKoThHPKvE/rPZMQ9GQZmCtdz7RFRJE5+6qWfKDq7Bbu6o1JmIQFic4K2BoNeNJJt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QQEp07CI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QQEp07CI"
Received: (qmail 7211 invoked by uid 106); 7 Aug 2026 23:19:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gkb2210bStUYBdvR4JWn1j4Kg9aG2AAXrPlEhDJatVY=; b=QQEp07CIP7bYFIMnIngySqq+ZAVw3VrUVsNs6re8IVlXUPIJBOMZlwXbqTQGJh69gX9mvqfIodpeS8IfmmAodqhA7+LMuMDkVUQDw3r8s2WQwdoXk7KHftwrafp2BoCMpRdXdlicx6b3CxrFZ6jB7Jn4ahjIbvKC2PN1LTOYC8jedH/J+bc6/dhfuvquvrA6IyC6v92fZNbKr/NXpIUg/W/Qnd335iFnFVEPfEaZrcHvb4PBPScAtvaHcRBfGePcCMdTDzpl0KiQf3Y8LGx9sGN0g+QazX+gjuifbMum9j/1HRKsCWG2F5s8k4iUdGj9Df1m1sNnUj7a2xm+ooN4UA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2026 23:19:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16294 invoked by uid 111); 7 Aug 2026 23:19:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2026 19:19:03 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 7 Aug 2026 19:19:00 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, karthik.188@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH GSoC v4 0/9] cat-file: extend remote-object-info to
 support %(objecttype)
Message-ID: <20260807231900.GA2293966@coredump.intra.peff.net>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
 <20260806171714.GA1632126@coredump.intra.peff.net>
 <DKIADCID62IW.1MII8E3AYCI6F@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DKIADCID62IW.1MII8E3AYCI6F@gmail.com>

On Fri, Aug 07, 2026 at 02:30:55AM +0200, Pablo Sabater wrote:

> Given that, I think that it could be a good idea to have both, if a user
> foresees that he's only going to make one 'remote-object-info' command
> he can write it as it is now:
> 
>   remote-object-info <remote> objA objB
> 
> But if a user foresees that he will have to make multiple ones, we can
> make what you suggested:
> 
> >    remote https://example.com/foo.git
> >    remote-object-info objA objB objC...
> >    remote-object-info objX objY objZ
> 
> We would have to make the remote optional, if there's no remote die(),
> etc. We would also have to tell apart a remote from an OID in the first
> argument, but full OIDs and remote URLs are not very similar so that
> should not be hard haha.

Hmm, I dunno. Making it optional just seems to introduce more
complications. The value of a separate "remote" is that it makes things
simpler (IMHO).

So maybe it is best to leave it as-is:

  remote-object-info <remote> <objs...>

and then let cat-file handle it under the hood as an optimization,
leaving the transport intact between calls, in expectation of another
possible request.

It does mean that the remote may sit "open" if no other call arrives.
In practice that's probably not a big deal. In most cases we'd either
make more requests or hang up the batch-command session soon after. And
for stateless transports, the connection naturally times out (e.g., even
a persistent HTTP connection will hang up after a few seconds). So it
would only be things like git-over-ssh where we keep the ssh session
open waiting for more commands. That seems OK to me.

> I do like the idea, but I see it more as a follow-up series after this
> one, as the topic of this series is type support.
> Also, I'm biased as I have little time before my deadline ends.

I think we can leave it in the state your series has it, and then later
come back and do the caching optimization. If we're not changing the
protocol, then those changes are invisible to the caller, so there's no
rush.

-Peff
