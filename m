Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773465;
	b=Dmg7y/MJLh1BkSlpG6wcrbA7Kl2H/ZlCGg3hC3mgoutlGhUOgiWZsuzghFUMNm7/qZyU
	 HjYspGCWZoE2EG1uj5yhBAN5zUJidbTP4ejND4eTRvlBVMkF7gqTD3B0AAdOmZte4Y2dZ
	 sz/GFbWP0pDu7+n0FojxEkzN9Oj3snSXRR1kwu6RijbKNnP/H98IPNmGgDc+vMj4ivYI/
	 /wGLzmiYjItPtkli3JU5MJump0rP6Bvr7tHP7+WaxzEQp71FikX5Kz8NZzX37Og8gBGTb
	 3sMA5ZM96S0aW9twiQ7TbF4z5Ddu9BVisQVrEGwEG/V9CYEDIGX2qy7HZq8RRy3JCkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773465;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TSJ2PTSvzV8Fb0X6KUebF5KILBo3i7W1C9Kv+uCULqA=;
	b=MPRxGaaS7+AS6nsIDIuSYso70xZyaZxxg6qSHAaq4n6/Jvnoeu4EQGCHTkJdOiZsGxTj
	 0lEmTkWoUyWY/86D8T6WBFSFXC8HnMDyolFk07iqyvxSRXwmFg15FiiXjb1hlv/yRM2uH
	 lp6hU3dizIEJ+RlsW8gZ/l0sVjZNhpYIEONEbxwo/MyrLGaeDx6kf6qPXGdsDgVL2urpq
	 AykE8+a6jRltXiie36QZxbASUWacJbkpCnfiAaqBKVxx6PpULF0z62BM5fHOmG1uJ+FcH
	 OJ3wl1kEkJ5BtPNdBu2ehemNBmm2UgjUQqtaPsCcDt7pgneB23vC58Jc4WzzjEtxcbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=iXFEsLxt;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06982606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 06:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06982606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=iXFEsLxt
Received: (qmail 12225 invoked by uid 106); 4 Nov 2026 06:24:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5in1jaQDG3yo0nwaflhhx9enIiwaiGAKghHqnUyAprs=; b=iXFEsLxtSLqfzvc/Sr8UyqfiMlu8cTpQW/hAY4qxT/CChEVMnPcnU9yUA2jOdhVW0GLFL7Cld53nRtAzfSNu/mmbfZG5DC93MD6q0UUlWNSDjjWlmapHUWU6lTvLOeX9Bfo1yDNwYSwzdkfq9b7P9SRZjfkkXUrQofAAXNUcYQchT9Fc+PCKF4h1F70wrBfS4paYjtqeDZ5IHgFvaHZ+wumc12o2sHnxERl262zITu7zcFq40XM3veqIs3A5pVlp0Xri105ksYiXi+k27fqr+mEyQGq1bSXXsrM1H9wJVyRqExlS8GyRV6dO46m/nd3GXRTxd1+CdT8A3sm+W/dI8A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2026 06:24:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29498 invoked by uid 111); 4 Nov 2026 06:24:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2026 01:24:23 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Nov 2026 01:24:23 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: Matthew John Cheetham <mjcheetham@outlook.com>, git@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http: preserve wwwauth_headers across redirects
Message-ID: <20261104062423.GA1763458@coredump.intra.peff.net>
References: <20260819-http-preserve-wwwauth-redirect-v2-1-4c61039432b0@nvidia.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819-http-preserve-wwwauth-redirect-v2-1-4c61039432b0@nvidia.com>

On Wed, Aug 19, 2026 at 08:21:04PM -0700, Aaron Plattner wrote:

> When cURL follows a redirect, it calls the CURLOPT_HEADERFUNCTION for
> each header received including ones from a redirect. http_request() sets
> fwrite_wwwauth() as the header function, which will record the wwwauth[]
> entries for the last step in the redirection chain.
> 
> However, when http_request_recoverable() sees that cURL followed a
> redirect, it attempts to update the credentials for the request from the
> new URL using credential_from_url(). The first thing that does is call
> credential_clear(), which clears everything including wwwauth_headers.
> 
> If the new URL should use a credential helper rather than credentials
> embedded in the URL, this loses the list of authentication methods that
> the server provided in the redirect.

OK, the problem description makes sense. I think the root cause here is
that wwwauth_headers should not really be in the credential struct in
the first place. They are a property of the HTTP request, and we get
them _back_ from the server; we don't send them. They are stuffed into
the credential struct because we pass them to helpers, but they're
otherwise unlike the rest of the struct in that respect.

So one possible path forward would be to pull them out of the struct,
though I think that does create new headaches. We'd need to pass them in
to credential_fill(), for example, so it can feed them to the helpers.

So it may be the past of least resistance to just hack around this reset
problem and preserve them (i.e., your patch).

> The WWW-Authenticate challenge is not derived from the URL; it is
> populated from the server's response, and after a redirect it describes
> how to authenticate to the redirect target and it needs to survive the
> URL update so that credential helpers can know which authentication
> methods are allowed.
> 
> Add a new credential_update_url() that wraps credential_from_url() and
> preserves wwwauth_headers specifically. Use SWAP() to avoid having to
> copy the whole strbuf.

So my biggest question/fear would be: are we creating a security problem
wherein we use auth information from the original server with the
redirected-to server (the avoidance of which is the whole point of
clearing the credential struct in the first place).

And I think the answer is "no". These wwwauth headers are coming from
the server back to us. And as described in 6b8dda9a4f (http: read HTTP
WWW-Authenticate response headers, 2023-02-27), we get the headers from
_all_ servers we talk to (the original and the redirect target). So we
have to deal with this problem already, and do so by resetting the list
when we see a new HTTP request start. So by definition, the wwwauth
headers we get back are the ones from the redirected-to server. And so
preserving them as we move to that new URL is the correct thing.

I see that the credential_update_url() wrapper is new in this iteration
of the patch. I actually think it is a slight step in the wrong
direction. We know that retaining wwwauth_headers is safe here only
because we know we the updated URL we are feeding matches the response
from that server. Any other hypothetical callers of the new function
would also need to consider that (and if they get it wrong, it fails in
the insecure direction).

That said, I'd highly doubt we'd ever get another caller either way (nor
add any other data to the credential that is treated this way). So I am
OK with it, but have a slight preference for the original inline
treatment from the v1 patch.

> +void credential_update_url(struct credential *c, const char *url)
> +{
> +	struct strvec wwwauth_headers = STRVEC_INIT;
> +
> +	/*
> +	 * credential_from_url() clears the whole credential. Preserve the
> +	 * WWW-Authenticate list, which is derived from the server's original
> +	 * response rather than from the URL and is required to authenticate to
> +	 * the new URL.
> +	 */
> +	SWAP(wwwauth_headers, c->wwwauth_headers);
> +	credential_from_url(c, url);
> +	SWAP(c->wwwauth_headers, wwwauth_headers);
> +	strvec_clear(&wwwauth_headers);
> +}

OK. This strvec_clear() at the end is almost certainly a noop. We
swapped in the value set by credential_from_url(), which will always be
blank. But it probably does not hurt. OTOH, if that assumption is wrong,
we are throwing away useful bits that we pulled from the URL, without
even knowing what they are. So maybe:

  if (wwwauth_headers.nr)
	BUG("credential_from_url put something in the wwwauth_headers?");

would better describe what's going on.

I'm adding Matthew Cheetham to the cc, as he was the original author of
these wwwauth bits.

-Peff
