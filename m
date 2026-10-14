Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26747A896
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969526; cv=none; b=op1pFeUIpU25/tBpJBfS8Yo068fnZXhyPR06qt5MjM3THKBeNJ4Q/fRFPQ8LnOKeYvb2FqKEwn9eQJIudVTa0fpvGlARPnL/J2zsoqlonSm73klITFHxjaRaTj/6ochE5OJmSBG6+FeDmM4bYrE4BPwtOGzKNcBG1NjmrYnAYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969526; c=relaxed/simple;
	bh=wAuBuuDjE260Mt/Zrs9JJ1F0I49gC6uj/dxrZBESwk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUxrOXrCsGmpbc8kKvVWra2W4/dTnZE2GfhBIWbYQuorrimkrz0TrJgsaQKp0yzgPnniPQJdMNtaFBlrhxBYFEKi8ytYLNxshqbBVIntC0EPTkr6pgqEH2D9LYyDOEdVlfPGnNoyVcROh+KdzLn0ZKlLo1JEypaQm1OBRuXrt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LX4Irx6G; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LX4Irx6G"
Received: (qmail 68922 invoked by uid 106); 14 Oct 2026 09:18:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wAuBuuDjE260Mt/Zrs9JJ1F0I49gC6uj/dxrZBESwk4=; b=LX4Irx6G0TwiluDCeBIKH5D0hkp1i73kX+yt5iPo0b/LztwvbcjnE+EocUvg8rzj2MXuwKhHMCjWo97HOiBIzOZz5AzlP3S2NikHsu80mIJafK3QDwxoTHJzfwZI7GZXDbEPmOP7He1NuwhT77J9X5q7GSIb6CJ88uDeFxp9XEJEGsVVFC03Wp9+YLmJrFZxJWFuLGKi4GZprqA4p8eRZj2wKxk5ygdyEWswqsFSkPzOh3dHESyzQMyU2/37afFzl3p2ZfFPCMOy57v4yffVDH8XqMy1yIdL0q+HlJ4mhbtiJIO2e6kMkBwY2x9MvIQP0ZLeSHSS/51BrQJgMp3A7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 09:18:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35674 invoked by uid 111); 14 Oct 2026 09:18:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 05:18:48 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 05:18:43 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 6/8] ci: switch away from EOL'd Ubuntu version in
 linux-feature-testbed
Message-ID: <20261014091843.GE1341124@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-6-04c24e1f480d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-pks-ci-housekeeping-v3-6-04c24e1f480d@pks.im>

On Wed, Oct 14, 2026 at 10:30:32AM +0200, Patrick Steinhardt wrote:

> The "linux-feature-testbed" job still uses Ubuntu 20.04, which is end of
> life nowadays and starting to show some cracks. Switch it over to use
> the "latest" tag instead so that we don't have to constantly update it
> anymore.
> 
> Now arguably, this reduces test coverage for old versions of Ubuntu.
> But "latest" at least points to the most up-to-date LTS release of
> Ubuntu, compared to the "rolling" tag that uses the latest release
> regardless of the LTS status. So while "latest" and "rolling" are the
> same right now, that's not always the case.
> 
> Furthermore, we have other jobs that test with ancient versions of
> Linux, like for example the one that uses AlmaLinux 8 (2021, originally
> tracking RHEL 8 from 2019) or Debian 12 (2023).

Yep, nicely explained and I agree this is a good direction.

-Peff
