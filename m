Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419B1B28D
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905675; cv=none; b=s8DJYIw+xzvP5gDpP5/0fWpJRXzUJf8J5shzsx8sulUmBJ2yDlZcr4gaQ7jT+cI/Oue5wYYoO5dbRMUnpsgK/cXgYZqRVrx+5vR4/lkid3ZtHt1pmr8YzyFgbu6lBK6i2Fckge2u/FGpLI1/MfveVV6zSpFAU+qYxpb9kTjhhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905675; c=relaxed/simple;
	bh=VYsVcTJsRWgGF2Yyabmzhb4sWdMRz3HLGSMwxrR+QEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXAhWqR2e6JxXRZ7cQbX8JaCLntMzFOBQZ3mvkTgj6YyA5jVge5qwWyZNcfStPPBkXF4cU7yf+IWHz16HG2PiEFDiiUvgPqVHLHPlQ+P7sFWmOmlZ1ICZvgAmKUuBiStP90H9cfd3ckgVPAkOqYVpuSoCFjioLySHf32SnS4/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17986 invoked by uid 109); 13 Jul 2024 21:21:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 13 Jul 2024 21:21:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14128 invoked by uid 111); 13 Jul 2024 21:21:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 13 Jul 2024 17:21:04 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 13 Jul 2024 17:21:05 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Ilya Tumaykin <itumaykin@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
Message-ID: <20240713212105.GB554779@coredump.intra.peff.net>
References: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
 <ab974e62-098c-4200-bee3-7de8d9115516@gmail.com>
 <xmqq4j937pyf.fsf@gitster.g>
 <20240710093610.GA2076910@coredump.intra.peff.net>
 <d5d27cad-bacb-4a79-bb50-e65d2bb6808b@gmail.com>
 <20240711212628.GA3648684@coredump.intra.peff.net>
 <622849f1-de52-4b92-9465-931014c8d3eb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <622849f1-de52-4b92-9465-931014c8d3eb@gmail.com>

On Sat, Jul 13, 2024 at 02:19:39PM +0100, phillip.wood123@gmail.com wrote:

> > Do you want to just re-send your patch with a commit message to replace
> > mine? (Feel free to steal the non-wrong parts of my message ;) ).
> 
> Thanks, I'll do that

Thanks. Note that mine is in 'next', but I think it would not be a big
deal to revert and replace (I'm not sure it is even on track for 2.46
anyway).

-Peff
