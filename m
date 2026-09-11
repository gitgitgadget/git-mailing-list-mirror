Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D481E5B9A
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159091; cv=none; b=nl0YD8DU0tF13LFJhorS0vK0UJLYVSwpUOjURnkQV/UcJIk4PehpsXUNgHOI2u7hNKbIK5vYMneWLwTBtMbcJBOZZdxMQz1ypC9DyFni+LvxZywGltENHMXE8cwzhN+zBJpeICQzLrWQoB7oX66Cq+Wsuuar0S1wGcOhJAj8iwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159091; c=relaxed/simple;
	bh=YpolqlJLOAg9W8pvlUbpimry1Vn2H2I6Hjs1LWrTeF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVfXWUW1hJaQBRxCtbn/Hnc3+Pp/o69xZVAoEfHlfJjmBNsya2D2UUjsQgBwBty930tn2L4tEZwP2EgDyRHWWPqLPdcsKFV3HGO5nn5yu3h0To3SWD7yUhaWA6BOpYYy0OaFXBMZbe7B+NFYsdOQ9JtPxQvqISjw2orgETIQJkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MWOF/DEI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MWOF/DEI"
Received: (qmail 35230 invoked by uid 106); 11 Sep 2026 20:38:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YpolqlJLOAg9W8pvlUbpimry1Vn2H2I6Hjs1LWrTeF4=; b=MWOF/DEIIvcHj7nsKkKjm47N1dtiyOPRP1B4fimDOouuxxBNvWY7usobIQE3JXzOaxf7Fq9srPpyJrE3L8WZxn83V2Ea3X2cusUQMko+q+9FA3mUqMWIDzuxRqJik+6HaV3hMjvsH/e5kgjc+C7xokKwM7/cvNDgr1fMbBK0z0AO1KSnNVACvWlOva4fqXuOpQI2itHejq557w/TQSSCgdV4KM3i7J7IiQATZRJYqVQaqRiqY2pqwJYLMVZmsROjcZEqpYbLJpJr+iKqv1ITmYhnSqbWil0JIu9KFhqfQV+hWuXR1rO543SgtETIRDiq0qGDJuBXXNZCdfKqmi+3Bg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2026 20:38:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 175979 invoked by uid 111); 11 Sep 2026 20:38:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2026 16:38:07 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Sep 2026 16:38:07 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH (RESEND)] ci: use system asciidoctor
Message-ID: <20260911203807.GA1622087@coredump.intra.peff.net>
References: <20260902071113.GA70165@coredump.intra.peff.net>
 <20260911195250.31201-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911195250.31201-1-taahol@utu.fi>

On Fri, Sep 11, 2026 at 10:52:50PM +0300, Tuomas Ahola wrote:

>     The release notes draft for v2.56.0 already claims that asciidoctor
>     has been updated to be installed via the system package manager.
>     Clearly it refers to this patch which isn't, however, anywhere near
>     the master branch.

I was confused about what was going on from this description, and why
patch 1/2 is not mentioned here. But reading the "What's cooking"
conversation, I think it is simply: this patch was missed when picking
up the jk/ci-use-system-asciidoctor topic.

Possibly because the lead-in patch from Patrick got duplicated (I notice
that jk/ci-use-system-asciidoctor is not based on ps/ci-depends-on-ruby).
But whatever the reason, this was supposed to go on top of the jk/
topic branch.

Thanks for noticing.

-Peff
