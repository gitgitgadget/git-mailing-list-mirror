Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171F1DA0E1
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790295216; cv=none; b=npPbKbyqwDuESadxdPu2xThEbUMHHta6I7kl9a6ZYJ4bUU1FFXxoty5tfAlB5QeVrfI9UKN+V2lLsEnxCExCbNGi8Kfm+QFvIW73MTkFWKQhiFsBiA98cCp6DJtcKvTIAB8IFc+vPIskm7bu4G2pLjRHb1tN5Xg/V70hLKh+nr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790295216; c=relaxed/simple;
	bh=IwVsWN4JlwIKVXEW92fGHg6JSkL9phuPFxhX9AO1zgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy7mkwajw3n33gmrOErE2MZXilozAXgpMJALsHpPkcZYjWZ91c3IeLMj9YkJsjXl5gauU3PIWlSCDz5XakyOk6AMeg9zIiwHQ2eE+yrv4bZmG4IyEH5aARaMdHgEkbP7Gwl3JoiWl0L2YdTRCKSdCm6340tamSRU/eeWV//SnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S1HLwPAl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S1HLwPAl"
Received: (qmail 49442 invoked by uid 106); 25 Sep 2026 00:13:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IwVsWN4JlwIKVXEW92fGHg6JSkL9phuPFxhX9AO1zgs=; b=S1HLwPAlEN9TbJ7e18R/RMBzGldKKjU7FGcLA8erFjBIaboDUzIpwlVcwxVoc0oV1pOA02cr/DAClXvvAR4jqlVTOWqvDEk1GWoMj3D0uPCGvfN6aGr1SbaEML8pTeTul6SDpoBGUj7FF+5PrJK8Y/Y8XVd8+zj2A97s/MBIi2lwxRu3qSd1KX7xu3M7k/2N82dat+K1w/3nC+DIwRRlhNTwtJTt7E2/LEB3DGWEl/mASnZoDF1vu4UGOv0HoocGkRVs4WazKX3bbbT0eMTJBfmffkL4tOZXo7uhKF/RmHcHS8T8lWVcZxXxqihkFoBg1u3wOyKIaBzdk9fkyz+OHg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2026 00:13:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 198420 invoked by uid 111); 25 Sep 2026 00:13:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2026 20:13:33 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 24 Sep 2026 20:13:32 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t4205: compare huge output without diff
Message-ID: <20260925001332.GA1408107@coredump.intra.peff.net>
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
 <20260923-ci-large-test-resources-v1-1-c28416d59475@gmail.com>
 <arS_l1hPIr7I2Gn-@pks.im>
 <CAJ-ks9kJWc0e7aEX4vAL-RoJ5kVvfjDABqV86_hZf2Fn-085GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-ks9kJWc0e7aEX4vAL-RoJ5kVvfjDABqV86_hZf2Fn-085GA@mail.gmail.com>

On Thu, Sep 24, 2026 at 04:41:05PM -0400, Tamir Duberstein wrote:

> > It would be great to back up the claim that test_cmp_bin is better than
> > test_cmp, e.g. by comparing peak RSS and its runtime.
> 
> As for the comparison: on Linux arm64 with GNU
> diffutils 3.8 using two identical files containing 2,147,483,649 "1" bytes
> followed by "0\n" (matching this test's expected output) gave:
> 
> Command              Mean +/- stddev       Maximum RSS (KiB)
> diff -u expect actual  5.276 +/- 0.572 s              4199924
> cmp expect actual      0.506 +/- 0.099 s                 1264

Yeah, that's a big difference. This is probably an outlier because of
the giant files, but I've wondered if test_cmp() ought to be doing
something like:

  # first check quickly if there is any difference
  cmp "$@" && return 0
  # if not, then we can spend time to produce a useful output
  diff "$@"

But I never pursued it because I figured most of the things we compare
are not big enough to matter (and really the comparison itself is
dwarfed by the process startup time).

So I am happy just marking this particular case as cmp_bin, too.

-Peff
