Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47ED15D5D9
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138244; cv=none; b=WrM+imhs5MK1+WewwpOEqJeWHcWDiCF8YPqEL/YHqGv+6BeYf0nuQYFVeEkcNpCzNT7tQMFpB2Uti/4N83NaE2H62Q+16oBEglUwNF90Nja1SUL/rEhwjacsYU/IXzKv86rEG/imNwENCNi7E7HBbvRmivAZt4si+loTmFZpDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138244; c=relaxed/simple;
	bh=yLEflJOd9sTnx+qHDP5MefCqgf02v1PCMiN5GElHX1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek7mqmUrVxRta7gL0hnbckZBpa+RGP2sM1gpc47nrQKBB+n2bQnw8zK+eA0X7m0glIFjSEz+gf2SnGe1bSXtDe5lUDNHrdiCrZ3zWYM9n75U4INBdwwTcQQOcal2Al0hXlCHdrDhqfp+7/KPegW98BtuSjOcyrLBfzRIcX7j40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17449 invoked by uid 109); 12 Sep 2024 10:50:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 10:50:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24542 invoked by uid 111); 12 Sep 2024 10:50:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 06:50:40 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 06:50:40 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] builtin: add a repository parameter for builtin
 functions
Message-ID: <20240912105040.GA603079@coredump.intra.peff.net>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
 <9aaf966254493678d3e25b93cb11017c814d3087.1726001961.git.gitgitgadget@gmail.com>
 <xmqqed5rdw61.fsf@gitster.g>
 <xmqqfrq56gqm.fsf@gitster.g>
 <ZuK4RXMfherFBIxP@pks.im>
 <20240912104319.GA593177@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912104319.GA593177@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 06:43:20AM -0400, Jeff King wrote:

> I do feel like I have only started seeing it in the last month or so. I
> wonder if a new version of binutils changed behavior or something.

Since I had that Makefile reproduction, I ran it against an older
version of binutils. And yeah, it produces the same outcome. So it is
probably just some kind of Baader-Meinhof phenomenon.

-Peff
