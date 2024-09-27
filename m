Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1CB658
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409339; cv=none; b=pziILLoegu/7CVOx2mfqKjYJfo+XxLMzZIHDSFhVh4DNXR5nW1Ejo2pfSHYL4KjDc8mUvJu5D54poeu+WfvQhWe0nYJYU1ygrBdYuDe4J8dIhZjOmvuZVdutBbdYdDe6xsi0n2iZIwUYTwr24IXgxsDOKYw5jTlTL+Mrlzjb9yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409339; c=relaxed/simple;
	bh=Lfke30ZDADVCleQheq3d0L3hVfo52WiFXgnMLsVrWZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuJfV+YlU9qbl2JMpX++tr1RDu8sCWTJiKu+McsqTdU2GyaL9H2Lf0ksOCH+/0HTsMlmpPybVa7ssMVQHNGwV+0FeVzq2rq59euT3Rqs0mdxSPcIe38CyByK5+saW00ocJ/CQqBkEem8aRBEvzvv0/Ddkdp6ppYKhNkSB2lbpIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4882 invoked by uid 109); 27 Sep 2024 03:55:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 03:55:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9083 invoked by uid 111); 27 Sep 2024 03:55:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2024 23:55:36 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Sep 2024 23:55:36 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/28] leak fixes for http fetch/push
Message-ID: <20240927035536.GG567395@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <ZvVmqpGZkM_m7nXl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvVmqpGZkM_m7nXl@pks.im>

On Thu, Sep 26, 2024 at 03:50:34PM +0200, Patrick Steinhardt wrote:

> On Tue, Sep 24, 2024 at 05:49:30PM -0400, Jeff King wrote:
> > Patrick asked me to take a look at the remaining leaks in the http
> > push/fetch code, especially the dumb variants. So here are enough
> > patches to all of these scripts running leak-free:
> 
> Thank you for taking a look at this, highly appreciated! The series
> looks good to me, I've only got a couple of nits regarding typos that
> you may or may not want to address. Either way is fine with me.

I responded to a few, but I don't think any of them really merits a
re-roll. Thanks for reviewing!

-Peff
