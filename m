Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA928640B
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771609; cv=none; b=CfVtDD3xxwTpbc3/OLkK4AEXI1kv6rkea5ru1smeA9Zzc9PsH4diwSbteg802vk5rDv0KSK/gyb6PiP0T/k8uwxbFHUE8FUzx6UFuAc3+TMOUZpfHzmnKKfrJrFRxAzrm/yxWgfpDwm2torMIdZb4GZfvzNlcKMMpsyI8qcTJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771609; c=relaxed/simple;
	bh=1Eizx7WfluvjeD67o25Eshxn9YVyK+EBIieWr8b4LW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc5uh+w6K3M48bgu2R0lKSlFrq+uP0WD2Q2pGSNfPzydSEgz5W4Uvf1BQnpRy3J8FIpZBOYWoSOL1rap8OB4jXU87AtIDxrjc28YnIb1HJ5GhZkQmcy+xEQ0rrEPUKczAh7+Y82KzZCmrrHIOt2WLqf31OCNBwlYsxvezjY7xAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U8pUL6EM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U8pUL6EM"
Received: (qmail 616803 invoked by uid 109); 7 Jan 2026 07:40:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1Eizx7WfluvjeD67o25Eshxn9YVyK+EBIieWr8b4LW0=; b=U8pUL6EMfzmOOhy6kLWv76IR4TeX7vP2zaYTj0sGpRLKA5O/PgHFBs303iTByrATw+cXOlDvLposIwL+IQ2G+jExGx+bkW+vHo0PT3L1A5STpKwfQqIrQaLxblnfDEmRwXhOtd18mYYbpfLmiMqw1FKFy7hjzVO+BNfg/6JoP3TJuv414Vv06eIBwGGCbBxQODLK0jppYsEaC9diluA7kB4SGPR8Xgf3ll9mpVeKktO/CGuiqgUfte3STdTAntg5E6SSVAjJufOgkbgQ/yTkJoP48sIopXdxDOyZ98Dq3otxcPgY709L4qm7G9F2WHzPycWy/yBX+CzJUga29cbjRQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Jan 2026 07:40:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 803691 invoked by uid 111); 7 Jan 2026 07:40:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Jan 2026 02:40:05 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 7 Jan 2026 02:40:00 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] t/unit-tests: update clar to 39f11fe
Message-ID: <20260107074000.GA102520@coredump.intra.peff.net>
References: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
 <20251206-b4-pks-clar-update-v2-1-9a14b10c1a36@pks.im>
 <CAOLa=ZQZnYVuK8mDi6Yb8_+hqw_TMugn6i7BJCj1gbNHOruNWA@mail.gmail.com>
 <aVzvDGVEI2qVJv2F@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aVzvDGVEI2qVJv2F@pks.im>

On Tue, Jan 06, 2026 at 12:16:28PM +0100, Patrick Steinhardt wrote:

> The problem is that we cannot do so easily. Varargs require at least one
> argument to be present, so we cannot make this `cl_fail(desc, ...)`
> without breaking the case where there are no variable arguments:
> 
>   In file included from ../t/unit-tests/clar/clar.c:1053:
>   ../t/unit-tests/clar/clar/fs.h:460:3: error: expected expression
>     460 |                 cl_fail("Cannot copy; cannot stat destination");
>         |                 ^
>   ../t/unit-tests/clar/clar.h:152:132: note: expanded from macro 'cl_fail'
>     152 | #define cl_fail(desc,...) clar__failf(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, "Test failed.", desc, __VA_ARGS__)
>         |                                                                                                                                    ^
> 
> The alternative would be to make this `cl_fail(...)` instead, but to the
> best of my knowledge this isn't even a valid construct.

It is valid; that's how we define BUG(), for example.

There are other options like GNU's "## __VA_ARGS__", but I think eating
the format argument with the "..." is the only portable way, at least
for standard versions we'd support. I think C23 added __VA_OPT__.

-Peff
