Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6AE1A08AF
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272972; cv=none; b=heNBcXVZjRnLSS+4GA85s1EskzOx+fbdhI2YXDpqP2tVv9j2YVZzxn314ebeopvVew3Wz45rNFt8E5ymXseeqxWjO+ZEOdLbNr1eb68CY2qRw4BqME9KKH74dKE7hTGj0p4Nf3Aakpsxnv+pdxATcyj3v2RhPsLSKVoosJ7KWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272972; c=relaxed/simple;
	bh=8D3geDdxbQyS3JBRh+AxN6SB+t4aeIifjXw7bgXKSPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/4043BeQ1avZZ3UZPX429mEPRPJcB+LxnLs4CgGp05Whjc/Y4vj5YLwaQQtSOqyPagsNq+mt2fJjX+C25Y9p13qzcfzmpGJqOOhzHZ1UmE+CHk1dOtCGGG/FFLwqEwVEurQTG6WmaR/7FjmHDqU9a9LsXO18GGLGL+tbqsXx6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XabkFvYP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XabkFvYP"
Received: (qmail 83115 invoked by uid 106); 21 Aug 2026 00:42:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8D3geDdxbQyS3JBRh+AxN6SB+t4aeIifjXw7bgXKSPQ=; b=XabkFvYP6IuUYZkOZAfTbmHYjzdjvw9y3HKxiyFlphEf0Cn8+HVOxteAZY2+uxQkFYA9TuVmXliMEAJVIUXctYKhQ3VaTCnBYS4vPWz/PiwIGbdcTBAM1EfcrefU6suZFmR8sAhldd8y5HzSzRAiAwushe3fj/+94e0aTX0eGurnpMGXA0en1xVuHaStIfVUkRoBGDIANR2lm5F2jbTFaALAwlgZ0Zg5K5nBwmUg1AAIAuQAcmtz2s1DZ3ZdhJp5xsD2Hso91aW3HwozVvakyxYAJ4GZEE64ESUK2qVDh8ITsaKSFpugg+9pnfBq/rUk9bggw6EnViglB5QzQy3X1g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2026 00:42:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 68385 invoked by uid 111); 21 Aug 2026 00:42:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2026 20:42:52 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Aug 2026 20:42:48 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] trailers: stop recognizing URLs as trailers
Message-ID: <20260821004248.GA296777@coredump.intra.peff.net>
References: <20260609004340.GF358144@coredump.intra.peff.net>
 <URLs_not_trailers.b13@msgid.xyz>
 <xmqqcxvcuaak.fsf@gitster.g>
 <c097cc44-3033-4f22-8c48-859de8353f99@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c097cc44-3033-4f22-8c48-859de8353f99@app.fastmail.com>

On Thu, Aug 20, 2026 at 04:47:52PM +0200, Kristoffer Haugsbakk wrote:

> > Can somebody summarize the outstanding issues on this topic (if
> > any)?
> 
> I have version 2 ready. The only code change is using `starts_with` like
> Peff mentioned. What I wrote about the changes:

Yep, v2 looks great to me.

-Peff
