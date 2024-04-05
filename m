Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833E1DFEB
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338642; cv=none; b=VhciHaJvEF1CjYQokXOKTcs7ReBMu9Dsq3i+1PH7M9jciKpNKzWxghQVE/dVMB4yg/KV8tcDjvyRetWh+mDDXa48bwsp32qyd13CEyndwWHf3MakrtWME7QOZZOeZRaF+1XyEGsZB/BDdTgg+N0fEHkHAgEwY6eV/tP9WO2LXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338642; c=relaxed/simple;
	bh=+QItTvKEeZKOgmcw6E5hqpGRGSTnFcnLh1nLBlD7aYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQv5qF35aYtwsa8NZ6pJJynIYmXdzHscyzpEfTPbp9YXIDqD0qndK0BBGX2Qb+s2TkWcivKK6osHMpOVaOE35MgO+OAu3Gat32M4kzAoZIFMxny3IHYwB1It3ATPI0HvYf1jo0UNHynuYfbo07mHQIR+LUrdR807sS8BqMYGK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18138 invoked by uid 109); 5 Apr 2024 17:37:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Apr 2024 17:37:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30818 invoked by uid 111); 5 Apr 2024 17:37:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Apr 2024 13:37:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Apr 2024 13:37:18 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] path: remove mksnpath()
Message-ID: <20240405173718.GB2529133@coredump.intra.peff.net>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
 <1b5f3b1d-60e2-4fe7-9ac8-a63ad861cd16@web.de>
 <c085abab-2f10-488d-87d4-65e92e0ea24b@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c085abab-2f10-488d-87d4-65e92e0ea24b@web.de>

On Fri, Apr 05, 2024 at 12:56:48PM +0200, René Scharfe wrote:

> Remove the function mksnpath(), which has become unused.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Changes since v1:
> - Split out removal of mksnpath() into a separate patch, this one.
> - Remove occurrence in contrib/vscode/init.sh as well.

Thanks, both patches (including the errno handling in the first one)
look good to me. I'd probably have waxed philosophical about why
mksnpath() is a bad interface in this one, but I think it's OK to skip
that. ;)

-Peff
