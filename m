Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59E1F3BA2
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252702; cv=none; b=b34tNpq16wSV9zznHZW327h2mOwWL6pFqV3ZP6KY1tHbLR9tRmkeR5H19o/q5ttGT0+tgfuovcINjXRwIOgrbbbjnkPpfHW7Q0Wp9BunUUY4UT9QRhRbOQG2IqtM+LmWLr619brDSvXCorwELuuhn3O0mykgAWeCg663A3Y/TY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252702; c=relaxed/simple;
	bh=34vGRWT57WA61rJe4lFmSXXSFRRjZUg2BrpXmnz72/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kILgu2f3tjnlxn2GJySzNHQlQCR6fNejOlz7gLA62vacJB6t7/ZyJ8k457HdwsdhTZnLJr4bMlt8J9OS7uJks15RG/aRDknLMYiOWhUQq6mL9tEPpEfwCfEP8ufWe7J46dqorlWxxHpXHar4cIWOBbDnmjP8xXm+23+tVaCYF0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RmTjqmhk; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RmTjqmhk"
Received: (qmail 7455 invoked by uid 106); 1 Sep 2026 08:51:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=34vGRWT57WA61rJe4lFmSXXSFRRjZUg2BrpXmnz72/o=; b=RmTjqmhkqosG1dIUCH4D27y2Qg8NJjfI9CVQP43ecvFCHysDO4tYoRC6w9PyBDUIS8xe3d7qagvLRvQI/uBMg7y91Al0leC1aRjJSGhbgHkFlfNX4gWxwCXZe+xohcE0B0+nhME8VAGx8MS1lhgoHKjmMOvT6VDKxmAfurUDKcBcx54IQwQ4nxsK+TDpN13OllWBBke1FB9tV6IAPj5/AKlyVd07yaQtepM+jrdL1HdOWuXjBwtq67AOr5ne7kGR9uJLe6K1+ZhtWZp+LOsv/GBgJZYCUAOYKfv8EBa0sr4ZxOK/I4RYwC7+Y8nr9hEk1xq3YGB8J+qXjW3M66Z7Rw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2026 08:51:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35070 invoked by uid 111); 1 Sep 2026 08:51:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2026 04:51:39 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Sep 2026 04:51:38 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: fix missing Ruby dependency in "documentation" job
Message-ID: <20260901085138.GA2974806@coredump.intra.peff.net>
References: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>
 <20260901084737.GA2973751@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901084737.GA2973751@coredump.intra.peff.net>

On Tue, Sep 01, 2026 at 04:47:38AM -0400, Jeff King wrote:

> Not directly related to your patch but... asciidoctor 1.5.8, really?
> That version is 8 years old. Looks like we set that version in
> 615a6c37e1 (ci: stick with Asciidoctor v1.5.8 for now, 2019-03-29)
> due to some issues with the then-new-ish v2.0.0.
> 
> But these days I'd guess everybody is using v2.0.x (which seems to work
> fine) for local builds. We probably ought to do the same in CI. If we
> have to catch issues in one, I'd rather it be the one people are likely
> to actually use.

Ah, indeed. It was fixed in f6461b82b9 (Documentation: fix build with
Asciidoctor 2, 2019-09-15). The thread here:

  https://lore.kernel.org/git/20190915212621.GV11334@genre.crustytoothpaste.net

suggests that it could be removed, but was just waiting on a few more
fixes for the v2 series. I guess nobody ever circled back around to it.

-Peff
