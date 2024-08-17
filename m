Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF62AF17
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723891456; cv=none; b=nUyq3obBW4IpDEHrcE0XqBDjwCx5hrjODf9kA6HbLuWkJOXjaa7768t9Y+IpGpbOniqoae2sxmDew3Uv1mV8nyQ4h6ToZ4iFFwk0fBO2Ggl6lgZTQoRpaMZO++Z5Y/p8Rypl+7/jtCqa8Bst4mkApPfJ0PAqi8YpYOIjYIYratc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723891456; c=relaxed/simple;
	bh=Er9oi18tuWdOputpSPSdAbNYkVWUFVcfLBp1xcZdwOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKuYX8rzC99BS7LGRZ9EDgwvh1YrcfmIKEj6hE9Kt4O5GVH9o5Ijf+oFTauEoapPCltkECmPrz9hB0rJmGaK23g6RKifTiAqrb6ribdHoO7dCmvcGjYLCIBfO30bWUvhkzKCzWeDRunkWeXlaxg3kFir0EOkDCb4A/zgMnMUXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25958 invoked by uid 109); 17 Aug 2024 10:44:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 10:44:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29106 invoked by uid 111); 17 Aug 2024 10:44:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 06:44:12 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 06:44:12 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] pseudo-merge: avoid empty and non-closed
 pseudo-merge commits
Message-ID: <20240817104412.GE551779@coredump.intra.peff.net>
References: <cover.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723743050.git.me@ttaylorr.com>

On Thu, Aug 15, 2024 at 01:30:56PM -0400, Taylor Blau wrote:

> This series fixes a couple of small issues with pseudo-merge groups,
> where it is possible to (a) select pseudo-merges that are not closed
> over reachability with respect to the bitmap's pack or MIDX, and (b)
> generate empty pseudo-merge commits.

Thanks, the whole series looks good to me (I left some comments, but it
is all just walking through my thought process).

-Peff
