Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8DE20B12
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307694; cv=none; b=jmm+PwMmmmnHoyr8r0hKckyud2farxa+2c4ikP9XP/E+czUfxLyhm/jHwus6wHkMaR0GkvN9BdiFHDRCJbUkhP6PsIYUQ/co9Ux0p2rQVP5WnKpQEqPxuhkT+oo++enAUtUSo71DfOyTsB7ZoSfnEPKykcBYgsY9z993GtVdjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307694; c=relaxed/simple;
	bh=8hgGj+tAVjvzEo43M3t0KxNP6z3R4PX9Dt5B5A6nWjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhur7aUywgWuC2rzVEiZozEhUbPqhi6wXBgX0nzjwOwQlMJh2yoXbJlt26HxkvdorY5TrSx6CCZvhD0sPKIpMDWCSSlnKTmZBnUy5+H/Ub/xMzTegPihNU3a4y+pEu545FAfyH5gVnomrRxiPwsFMgNBGKkjwODsrCPrs7mrYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31909 invoked by uid 109); 6 Jul 2024 23:14:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 23:14:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7074 invoked by uid 111); 6 Jul 2024 23:14:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 19:14:50 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 19:14:51 -0400
From: Jeff King <peff@peff.net>
To: wonda-tea-coffee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, wonda-tea-coffee <lagrange.resolvent@gmail.com>
Subject: Re: [PATCH v2] doc: fix the max number of git show-branches shown
Message-ID: <20240706231451.GD746087@coredump.intra.peff.net>
References: <pull.1757.git.1720046185710.gitgitgadget@gmail.com>
 <pull.1757.v2.git.1720259599119.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1757.v2.git.1720259599119.gitgitgadget@gmail.com>

On Sat, Jul 06, 2024 at 09:53:18AM +0000, wonda-tea-coffee via GitGitGadget wrote:

> From: wonda-tea-coffee <lagrange.resolvent@gmail.com>
> 
> The number to be displayed is calculated by the
> following defined in object.h.
> 
> ```
>   #define REV_SHIFT        2
>   #define MAX_REVS        (FLAG_BITS - REV_SHIFT)
> ```
> 
> FLAG_BITS is currently 28, so 26 is the correct
> number.
> 
> Signed-off-by: Rikita Ishikawa <lagrange.resolvent@gmail.com>

Thanks, this version looks good to me. As Junio noted, we'd generally
want the "From" to match the Sign-off (where the former is coming from
the author name in the commit). You can either re-send, or if you give
the OK, he might just fix it up as he applies.

-Peff
