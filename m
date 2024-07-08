Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA91CAB1
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428763; cv=none; b=OkonfqU4YtNOnLe7Mxv+qusJBlCUjymmw6/7qJJSz4ozEOI2RI0UFmXSDC8XUwGDmqjOq/jcGd0AY8RMimlca+ECVlP175sHV0n3fpiuGU2r0F2XGpvKfB7roOlq7O7p4SEtof9pXGMut7/Tbcpql8n4oFCJR5mczGBcIS4dwK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428763; c=relaxed/simple;
	bh=wTfxogw1b7dBFvEPRoHawjZwsLrUkz9VpRRxGRNz0Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQDqaOZ2YRxn1tWj7Z80fkj1/6ovlYG7Sa5RXkuAAEdicaCmRwP38jqIKZ+b33PxWZX3CKfBzF7jlCL9gRCjsAK6nmtrMhc5zNzxCUlAbqAwxE2hInvVc4uXQEyg+TUJxpd/VNm8o8o7M/L4zVCVApbIzOxSu+pzVNCUYuHZKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14088 invoked by uid 109); 8 Jul 2024 08:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jul 2024 08:52:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20487 invoked by uid 111); 8 Jul 2024 08:52:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jul 2024 04:52:30 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jul 2024 04:52:32 -0400
From: Jeff King <peff@peff.net>
To: Rikita Ishikawa via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Rikita Ishikawa <lagrange.resolvent@gmail.com>
Subject: Re: [PATCH v4] doc: fix the max number of git show-branches shown
Message-ID: <20240708085232.GA819836@coredump.intra.peff.net>
References: <pull.1757.v3.git.1720318768439.gitgitgadget@gmail.com>
 <pull.1757.v4.git.1720319311301.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1757.v4.git.1720319311301.gitgitgadget@gmail.com>

On Sun, Jul 07, 2024 at 02:28:31AM +0000, Rikita Ishikawa via GitGitGadget wrote:

> From: Rikita Ishikawa <lagrange.resolvent@gmail.com>
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
> ---

Thanks, this version looks pretty good to me.

One minor nit: commit messages are not actually markdown (even when
rendered on GitHub), so your ``` block delimiters are a bit unusual.
We'd usually just rely on the indentation and blank lines to show the
structure.

-Peff
