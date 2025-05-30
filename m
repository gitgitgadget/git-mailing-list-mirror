Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56D10E4
	for <git@vger.kernel.org>; Fri, 30 May 2025 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748586741; cv=none; b=nHph4ad8HcvmULv8hS1W+keJskk2GxtIjI+H1TVYzz5sOju+tWp/zverJso6A78I54dVDkx4MGxHJ9dNZwRBv0OMwpaRNdsjPH1Smtf36Izy1l/ziAxT0bNN0z/QRNZ4ZZj6Pnw7mz64dKxbL9Uxgp5ZSa+X6bbayYYEVFhPdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748586741; c=relaxed/simple;
	bh=807MVheNz6nOJEsXkPF/W/XAXWDC3ggKVGfSemJvEP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXkGn21mqf25esEDWk2UrQa2t4mlfY5Yyri0EvXDxtROe/G3BX1j5J5RzAGNUFBEkK2Lfco/2OeYcR7G/rvoS7VEYGoI2+SZk9ff1Py8+mIElWTQ0Ktwnls5I7m9f49BZQgcfNO1PdqHhXOhjx9t0oWtTuK1XbY0w6Y4jjFbakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DftkTJl8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DftkTJl8"
Received: (qmail 2196 invoked by uid 109); 30 May 2025 06:25:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=807MVheNz6nOJEsXkPF/W/XAXWDC3ggKVGfSemJvEP4=; b=DftkTJl8KKM5lzUsRK+8Z4aNX0VWYm6/AJXmChwo8A8yPVfvbQ7oTs/w2U4sJP5qRBdWPS3JInOcceTE1jInenxUHEV86wURfhnaDAFEYUWKbARxY650g+BEflw//NtmQ41NAzH/dDXow4SgPzfGBl45fB2WSqxl6Au9cZjDLBLc22J7+4OsNCdzm3g61lAzkuDsTXxM0bxolkYk/sf9rqxm4X1eKhWalgR1DMzfF5ZKxbcGmAtGpZl64m8uzQips7YNT9kZne50ip9pQ2mrgh2xt09OmzIpMGhRCcIIr3XNpustSai0yAoxswWgbySlVqq2XMWDPhvwoyG2OuqJMA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 May 2025 06:25:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8041 invoked by uid 111); 30 May 2025 06:25:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 May 2025 02:25:38 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 May 2025 02:25:33 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] reftable: make REFTABLE_UNUSED C99 compatible
Message-ID: <20250530062533.GA1321283@coredump.intra.peff.net>
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
 <20250529101136.16219-1-carenas@gmail.com>
 <xmqqtt53l7cl.fsf@gitster.g>
 <aDlDtbUcX5NA8wCK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDlDtbUcX5NA8wCK@pks.im>

On Fri, May 30, 2025 at 07:35:49AM +0200, Patrick Steinhardt wrote:

> What I don't understand though: we have a `MAYBE_UNUSED` macro that has
> the exact same definition in "git-compat-util.h". Why does the macro
> cause issues in the reftable library, but not over there?

We turn __attribute__() into a noop for some platforms earlier in
git-compat-util.h. So it doesn't need a separate #ifdef.

-Peff
