Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A34B04A8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976427; cv=none; b=VgzBV7Yo4rFttv5dZk2Or3jujfDtv6De0qHdn5qly1eIbtgQIDbM8ItxeJyr6r/hLpXoc83s7m07kcun2aTA3eGryJ0vcwPquoEWxcXyK0YT/rFIWpL9msuJ9bZohmtuvsT3pIfcH436A46hnnKhDFll99ltpfy8kC08tM6y+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976427; c=relaxed/simple;
	bh=IbllCJE9bkfq7M56mJv0/l6rvijFMEuX/wNhLHhx0t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6q/6Z3LYhKFq+xGD9Fr6id05OUUfmR1I8FhPluOM8rg4Mb1xn5YkbdVUzK3hpYGb3Fz5gRXefWt1L7ts1f1uSsvMzCgPEF67Y4+6H/3c++5TVavw+J7Me0PmJiAR7wVM4tPvCSaSt9XrpDQQj29J8S3+gjHVILyKcaJ4EbbCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b8Gve/rt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b8Gve/rt"
Received: (qmail 69452 invoked by uid 106); 14 Oct 2026 11:13:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IbllCJE9bkfq7M56mJv0/l6rvijFMEuX/wNhLHhx0t4=; b=b8Gve/rtyrJS9JXdUprpSZ/K7g5uTxYNOX6yVgJD657Alc30iMW/HaE508ScfdQgdIP+chxtiZdVrcvxtW5HsYKVkrUVGUa9HbUIRPZ6z47kHj5hj2Jkv6YjjgNKXhvz5mecG8yw/HcgMJYpVsOndLb7U2+zYeij5m0EnluMu86nasmslaHcwgXBEUTcV020mlc3C/Ond6KE1msHt4SezJRTPP5em0m946Ol0v6JpMmlXFf+Es/gwWu+xi+qhOqE8DTJ4IxSjR1A4EzuXEnXFfYi9GCPDNRv9d70FGsaoHj4c6tvMcrSudKyylUkqtZIcL1y6+I1JKabmjiHY+03Sg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 11:13:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 37052 invoked by uid 111); 14 Oct 2026 11:13:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 07:13:44 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 07:13:44 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 8/8] ci: improve reftable test coverage
Message-ID: <20261014111344.GE1356555@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-8-04c24e1f480d@pks.im>
 <20261014092137.GF1341124@coredump.intra.peff.net>
 <as9a5RngDLM8Miue@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <as9a5RngDLM8Miue@pks.im>

On Wed, Oct 14, 2026 at 12:35:17PM +0200, Patrick Steinhardt wrote:

> > > Instead, adapt the job to run reftables together with SHA256. which is
> > > an area that we don't have test coverage for.
> > 
> > Hmm. Aren't both sha256 and reftables by default part of the breaking
> > changes flag? So I think we probably are already getting coverage there.
> 
> SHA256 is, but reftables is not. Quoting "t/test-lib.sh":
> 
>   GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
>   GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
>   export GIT_DEFAULT_HASH
>   GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
>   export GIT_DEFAULT_REF_STORAGE_FORMAT
> 
> So we will run our tests with the default hash function, but we will
> run with the "files" backend by default.

Ah, OK. That feels...weird, since the point of WITH_BREAKING_CHANGES is
to check the new changes. Maybe reftables aren't breaking enough? :)

I'd say we can punt it to another day, but if we _do_ think it's a bug,
and we fix it, then that would make this new job pointless. I dunno.
Maybe there is a good reason we are not pulling the ref format from
build-options in the same way.
