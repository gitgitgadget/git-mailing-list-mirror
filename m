Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FE81724
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204364; cv=none; b=N/zjwm2/ZmTM8wNO+z8Omam/ANf5ibvgvY/jSAiwnPehdKmGfAnLQa43NDRK/ZVDUqFwGyfh1IAjlE2Zb+lVjFArsFeN4To5hRhneEotGyDSUqWsRMIEsTjdLLtt/bRs1e0/IPhz/LkO2RECzrzJnNYU6hT4Oz+Pqyj9St0gWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204364; c=relaxed/simple;
	bh=FqMlgUz4UB1fLwFDjiLl8vsPnnHh2GwJM3G8I+BCPfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQWtRI8sq1cY2Tos1QaX9RZcfF2cYWi96iH5tSrsM9O/cCK7WGTMfebAoSGe0dZ/4Upzb9hDAH45jAMdIw6/sGBpG62FVPfIa7pn3hCW2H2Kq1NOJsgY93qX54ubCJ/OV7zDqPabZszQPOxxB2rTi/uVi2MIrO+fZ/zRQ3b5Ra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cuhTAHFN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cuhTAHFN"
Received: (qmail 27416 invoked by uid 109); 6 Jun 2025 10:06:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FqMlgUz4UB1fLwFDjiLl8vsPnnHh2GwJM3G8I+BCPfA=; b=cuhTAHFNg9COzl/6u/Wo88Iq2e1aPlyX1MSbu7fzjnMKD2ZQyoXS5d4WXDsPWJEmij+k6lNDUbpbCeERqRejSxCTkufLbmjXvw77SCusRrZtBlTJgwNfhfXGlK4JvjSo14ZARG50e9/WngJDFs1djSvUpgpojN90WqupQJvhcQYxeWMXkxqrDTQE/HfWzMIfiLifSQU7nzTJZK+8OweXLXn6OZAUf435eLSK6pW0CM7MqXdnMdsvHqvv/jr3350mqKpYR/KVEhpVJMG8YgyKUafcslUUvwB0BvM863/nF2+uSR+uUWTAc0dZqgJMrMvtQCfCz0fUVNYPuPFmS2Ehcg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jun 2025 10:06:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8449 invoked by uid 111); 6 Jun 2025 10:06:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jun 2025 06:06:03 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Jun 2025 06:05:58 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] curl: pass `long` values where expected
Message-ID: <20250606100558.GA3591871@coredump.intra.peff.net>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
 <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
 <80de7491d24fb51c6b2c3b2fc1728db30e2477f7.1749202164.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80de7491d24fb51c6b2c3b2fc1728db30e2477f7.1749202164.git.gitgitgadget@gmail.com>

On Fri, Jun 06, 2025 at 09:29:24AM +0000, Johannes Schindelin via GitGitGadget wrote:

> Nearly identical compile errors afflicted recently-updated Debian
> setups, which have been addressed by `jk/curl-easy-setopt-typefix`.
> 
> However, on macOS Git is built with different build options, which
> uncovered more instances of `int` values that need to be cast to
> constants, which were not covered by 6f11c42e8edc (curl: fix integer
> constant typechecks with curl_easy_setopt(), 2025-06-04). Let's
> explicitly convert even those remaining `int` constants in
> `curl_easy_setopt()` calls to `long` parameters.

What different build options? The extra fixes are in code that is
compiled on all platforms. E.g.:

> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -970,8 +970,8 @@ retry:
>  
>  	slot = get_active_slot();
>  
> -	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> -	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
> +	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
> +	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
>  	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");

So I think the root cause of the difference remains a mystery.

Curiously, if I build libcurl from source and link against it on my
Debian system, I get all of the errors (including the ones you're fixing
here). But with the exact same compile options (modulo pointing
CURL_CONFIG at the right spot), building against the Debian-packaged
libcurl is OK. Weird.

> In addition to looking at the compile errors of the `osx-gcc` job, I
> verified that there are no other instances of the same issue that need
> to be handled in this manner (and that might not be caught by our CI
> builds because of yet other build options that might skip those code
> parts), I ran the following command and inspected all 23 results
> manually to ensure that the fix is now actually complete:
> 
>   git grep -n curl_easy_setopt |
>   grep -ve ',.*, *[A-Za-z_"&]' \
>     -e ',.*, *[-0-9]*L)' \
>     -e ',.*,.* (long)'

I don't think that's sufficient for a full audit, because the first
"grep -v" regex is removing variable names and symbolic constants, which
might also need to be cast to long (i.e., my patches 2 and 3).

But as your patch fixes the exact set that I also needed when building
against my custom-built libcurl, I'm content to say we have spent enough
time digging. If there is some platform or makefile knob combination
that triggers one we missed, then curl's type-checker will catch it and
we can fix it then.

-Peff
