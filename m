Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2113CF93
	for <git@vger.kernel.org>; Thu, 23 May 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455165; cv=none; b=VhUL34UdAcAp5U/FgiQbAJcj7gzNgbZ2eOZ5qdCAtzvnhsT0maIh3rCXzuE5gIXVz3DWIxtcNr+Oy08yRiGz0+mb3UraoC9dOCcGCZKbtppSYVDPL2giBt9Osu3Y43NXryQ2VqNMf4WsqBzjlCKZBFwOHbiG7oAppI91id22KPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455165; c=relaxed/simple;
	bh=vzoWz7pJpkSxDFo2D/zHgHiDtDoO37K9i3aw/Ns3F80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8tfHj9VLYZOon1pHj1XpM3Eb7TmpD3cDIb/cFIPf5FzTpT0fo5aQ/11aeEaNOPBqHo7jj15RjO2oew49yAc1SEvm2LqkId4IRc1TOB0IiAoe07ioHz8q/H+Exu2wsNhw1IxoeEA1E2X8RRn1eWaUWGlkWkAK+B1W54BxSx+H80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31038 invoked by uid 109); 23 May 2024 09:06:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 09:06:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28448 invoked by uid 111); 23 May 2024 09:06:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 05:06:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 05:06:01 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
Message-ID: <20240523090601.GC1306938@coredump.intra.peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g>
 <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <20240521070752.GA616202@coredump.intra.peff.net>
 <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>

On Tue, May 21, 2024 at 09:59:55PM +0200, Rubén Justo wrote:

> > This feature can be annoying even with current versions of less,
> 
> Hopefully, reducing the blast radius to a new 'P' option, will make it
> palatable.

Yeah, that would be perfect. I might even use it, then, for the rare
cases when I want to look at a really big hunk. I do still think it
would be useful to be able to configure its pager separately (in my
case, I'd use "less -FX" rather than my default setup, which doesn't use
either of those options). But I'm also OK to leave that for now and let
it be somebody else's itch to scratch later.

-Peff
