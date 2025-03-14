Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B71E5B9E
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977742; cv=none; b=pBhTgBuvd4X/rl05bld+4U7J0z7cXJYpDiAuX39UY/yh9RhdxGS3E4QDF5nQ9YEE3CCrZ5iXbe8VD+hr187rLb78FOaagMes0uQy4FmBJ3AOBzStcC+YBuR4Cg04Dn5FKgPK7nK8EkbinoC3Kwp9IycIib9GnWv0CjKp6MCzS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977742; c=relaxed/simple;
	bh=HHrqCf9n9XmPoW5VjJBTFu3sUUuaKlKyHQl9T5tLosI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNctDjLdS706uNxJk3i8BVoBycK2vVK5n5eF5LaftvMuyN7VKYDr7deeOIu5WizEcmTrLTkLbzHvbGdRChwh9gB/ozvawdudHPqK+Cn1Sg2g834v0O4RyaNnAlQHKG3tgYX9AdwtlhoLJDkkD43Qm+t+HiskBQ/+goZkqFfV/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=C9wWBbWJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="C9wWBbWJ"
Received: (qmail 23161 invoked by uid 109); 14 Mar 2025 18:42:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HHrqCf9n9XmPoW5VjJBTFu3sUUuaKlKyHQl9T5tLosI=; b=C9wWBbWJiBqJ6JZKxy7LRH+brulyuIsDJR3g4jYmulFYQ/QusMzAChutk9ScVJCPHWdGuDM1wZkC0JUoWR4Ej/BTefFpaB5FlqAA6+xlQZnYWWsF/mdu+2GpwGGJUoGp9BOQ7Qb5c2Kn7r2bGm9p1QxIxSjy65YR/0ze7ZBMHgkDNgmttOXB/9JVTl++cGNzkLelGbCfyK9nvJ9jHFZvwu272R8F2IBm4WiqWrElnLO4KdznnpHNgluLugQSXwVn6qVV5ST01mn/jRRrSqKCkfcpv+M2DrG4Bdm/cSvAjHUniiIjfv3yhcwCJZ+4S592UeFdWZTgF9eU3X1A2oc9BQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 18:42:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7741 invoked by uid 111); 14 Mar 2025 18:42:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Mar 2025 14:42:19 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Mar 2025 14:42:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #04; Fri, 14)
Message-ID: <20250314184219.GA578880@coredump.intra.peff.net>
References: <xmqqv7sbfra0.fsf@gitster.g>
 <20250314184130.GA578421@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314184130.GA578421@coredump.intra.peff.net>

On Fri, Mar 14, 2025 at 02:41:31PM -0400, Jeff King wrote:

> On Fri, Mar 14, 2025 at 10:36:39AM -0700, Junio C Hamano wrote:
> 
> > * ps/ci-meson-check-build-docs (2025-03-12) 1 commit
> >  - ci: perform build and smoke tests for Meson docs
> > 
> >  CI update.
> > 
> >  Will merge to 'next'.
> >  source: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>
> 
> I didn't dig into it, but I'd imagine this topic is the source of CI
> failures on the "documentation" job like this:
> 
>   2025-03-14T17:50:13.8749066Z + meson setup build-asciidoc -Ddocs=html,man -Ddocs_backend=asciidoc
>   2025-03-14T17:50:13.8752287Z ci/test-documentation.sh: line 50: meson: command not found
>   2025-03-14T17:50:13.8769502Z ##[error]Process completed with exit code 127.
> 
> that I'm seeing in jch (and looks like you have a similar one in the
> latest build of 'seen')

Sorry, I meant to cc Patrick on this.

-Peff
