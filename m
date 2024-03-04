Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978922085
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546525; cv=none; b=da3/Nz617zWr6nYsBS4dNummcfGdqsLJQuaRi60+lh/Y0fo+Q1nBWEPXqilUl1fg2ZBFEaP0NpEK2T0j8hinvbrqtNv9ICvuzRmlSTmuOB93Cisce7p7gkvibpFWkk+nFjnh3w2WMnhFlhbZ8CZBa1eTO0ZNMiVBgZ1wEKNtQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546525; c=relaxed/simple;
	bh=aCJlYdmY9DgS0nGE+KEu5E1b7CmbxRjXneErIt8aVHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2C8s63tPr6dQdl/Ub9g63sqquNQS9VpQAsUUf6K1XdO2fp9km9CA1H0RHjT/tiE81aYg1OJdLnVfhbhsSI4btv3onrQEvuSLMSNMpVMYFD/9VKDHhz+Z3YV1qVZqw93GNroK+RMOpOUiIar21AaqXtgpbmq9FB7FPWe7ki4mGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29762 invoked by uid 109); 4 Mar 2024 10:02:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Mar 2024 10:02:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11725 invoked by uid 111); 4 Mar 2024 10:02:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Mar 2024 05:02:07 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Mar 2024 05:02:02 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] some v2 capability advertisement cleanups
Message-ID: <20240304100202.GC3723539@coredump.intra.peff.net>
References: <20240228224625.GA1158651@coredump.intra.peff.net>
 <ZeV7-NkUwT53IvIa@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeV7-NkUwT53IvIa@tanuki>

On Mon, Mar 04, 2024 at 08:44:56AM +0100, Patrick Steinhardt wrote:

> On Wed, Feb 28, 2024 at 05:46:25PM -0500, Jeff King wrote:
> > While working on another series, I noticed that upload-pack will accept
> > the "packfile-uris" directive even if we didn't advertise it. That's not
> > a huge deal in practice, but the spec says we're not supposed to. And
> > while cleaning that up, I noticed a bit of duplication in the existing
> > advertisement/allow code.
> > 
> > So patches 1-3 clean up the situation a bit, and then patch 4 tightens
> > up the packfile-uris handling.
> 
> This patch series was really easy to follow and feels like the right
> thing to do. I've got a couple of nits, but none of them are important
> enough to warrant a reroll.

Thanks for reviewing. The typos you found are definitely all wrong, but
I think the topic is in 'next' already (and they were all just in the
commit messages).

-Peff
