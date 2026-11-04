Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773624;
	b=W+zUBn4vwFH8ZYminntrKQsFZG9u2W0SKxROIOq3brCiHNm6ShplUXWkQohta/xE5OmG
	 hrynFTlF/+KXtEoDht8KyuvJZrIvXVvuunmghhUpo/SrCXqeZaxIG0oKdF53k7qSYZZQs
	 1YhPDxyjppnW7ocVC0hwj/D11yLRmMUEZcXB5/kPtLicDG/dnw/ppRuWdr9Z+sJpKWS95
	 rOFNY78lQekY0cd1UH2z50T/gz3sq7uiO2k+pIyjPJbW2NWXomQ2m6B2OcHGB7GZa59pr
	 KG6uknHvU4UIS1KBp6T4tcuP1VLzqnFO00r4MdOhERXVVDJetYLtlHTZyyRzkkMemag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=t1bno9+occMZ7JLaAANKTy/QRQWA1nCxl0FURg8vnLI=;
	b=NvK7zspK/1TyufNBVYnNmlKZ41f32QAb23X1cGiqn7vvhkaKnHbgC8WwIagjBG0Eap0W
	 UQPTmalsrHoh/MqDWck3/ivJHVZtHNUHOhb4jCZZTNi5g9EE00z5LOMmSG3/nJZu/4MPc
	 aQ+t5uu1shDS5SRWDCJb9ZP5KnMRWGR0oLYvh4EQw4ILk0uS6mmYcntec0dzXwpXuYN51
	 6zL1ODGI4gOJm15cWtb/3rAthG+erwogDGYuXb/LYbBHTgT0hLxbwkkBDtdKhXbaHqgW2
	 UJQiCB6Lh56Lf/s1lPtbPnpLoiMGJA6TiqdJY/CAkQ5lyG1M0LFcsb9DvjfWKMWJ6bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=dJV9Af+L;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4865606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 06:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4865606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=dJV9Af+L
Received: (qmail 12265 invoked by uid 106); 4 Nov 2026 06:27:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lJuY10zGpPLXV6Mb+VmNcsmTvBJGOM1ENlL+jP3xSCo=; b=dJV9Af+LduMaNawVgu22BbsepWqfDLvQw5SK8s6ZLAL8T63PH1riNZTs/XQgMtOOsDPjb5sjxq+jkkfn9QAre3efA43U9SOhFaNHqlOJPFVr31Nza6XoAaFKs3970RTPr7pOxfNO2uAGReHwer+EA4enNRcfEKWflgh+pFakC8f9bpm+uRqHbExIE2pxYKxXvC5xQKBdVvxja9A3pVQtK2QJLAr6kDQkyhOHvOFAY/gemjKcGmPK+CGoiClig80OTK4cDZ0ugVRwJEVcjnKnq5E0ATj6dHhPxA249Q+xlT6K0ff0LhYJZSsq88CHH0HmJoWWaqJSOsSKW9LnJDwtFA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2026 06:27:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29527 invoked by uid 111); 4 Nov 2026 06:27:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2026 01:27:01 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Nov 2026 01:27:01 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v2] http: preserve wwwauth_headers across redirects
Message-ID: <20261104062701.GB1763458@coredump.intra.peff.net>
References: <20260819-http-preserve-wwwauth-redirect-v2-1-4c61039432b0@nvidia.com>
 <xmqq8q60u82x.fsf@gitster.g>
 <xmqqbjarowvi.fsf@gitster.g>
 <xmqqwlqvmxa5.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwlqvmxa5.fsf@gitster.g>

On Mon, Nov 02, 2026 at 12:51:14AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> For those of you who are watching from the sidelines, this v2 lacks
> >> the threading history.
> >>
> >> The v1 is at https://lore.kernel.org/git/20260602161150.1527493-1-aplattner@nvidia.com/
> >
> > Any takers?  It should be quite easy to be more interested and be a
> > better reviewer in the http transfer codepaths than I am.
> 
> Second call.  Anybody?
> 
> Unless we see some volunteers to give it a review in a few weeks, I
> will discard the topic out of my tree, as 'seen' has been crowded
> with topics that have been collecting dust without getting many
> reviews.

I gave it a review. In short, I think the patch is OK as-is, though I had a
few small suggestions for the code (and it might be worth describing the
"why is this safe" part in the commit message).

I think one of the reasons it didn't get much review is that the wwwauth
is not well understood by other folks who work on HTTP, and the original
author of the feature wasn't cc'd (I did in my review, though he's not
super active these days, so I also wouldn't hold my breath).

-Peff
