Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384535;
	b=STT1Hi5cj+Zv9nI65uFQRlcx9Aotxe5cAPOX+3s3gegpuHy/GLpYjr7UkmYzi22xPaUu
	 9z3+C2vz2xlG6MYkIsYoOxDKz4EjTw06b8kO9N9/GS75Y9Yw0u5LCqwdxbZhVEHjipR0R
	 p5e1PYxstNMLg32tZbNBvqef9RdYYuD6JalPxDznwbOsYE4iuf6b8RDRqGWgcgme8r9/0
	 Z3Gw1adZVTfqXHceuhyUeJez0ciIvl0nPIdR3Zv04jwhGbO+ZzOWAK83rkFYWPJYYSa1k
	 8dilYcdYBDSM5nBmNCU5/qYE4pOGPLvp7C9RZf+L96TasSzAzD5okwhIrHvW/AZyXKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384535;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=IBqB9Lf8821sHjA20R+A1cGB8LYMfhcXyhh3fe95K04=;
	b=bOOgUDjAHrOOupPfI3Ayp/oODf7dxej/GgoFN3PPrLKR58wnPRItWGvdEIAkPpztDuZ7
	 YfCc+WxZdSi0TrjVO8rS+XvRerD7a/JRLtRZi1EDJHvHwmyvl85qezMetrZSHY5Y+TJlx
	 N9QgGP04fEe3d67BlxjvDwSzBYMInSkd4QVi1QJwM7vhryfXUITYG4Zst0O6NLTjDNAGf
	 NDfXaBJ7pzk9vFFXAii02omcwxN8CfSnIr07RHKgYsRYpFTxd+OEzOsP1JXZpjpu/KunF
	 PMAcmh3SaYZoIrzsmu2iZa9mpPkntI88xPcsjFIUYWbZz4mgL7hb3AvpSl2qoPFSO+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=LhhXRcvE;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756C606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 18:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6756C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=LhhXRcvE
Received: (qmail 49287 invoked by uid 106); 30 Oct 2026 18:22:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RdF2JRsjt/sDztODTmXnnoNSNDpDPmutdUrbswSrKQI=; b=LhhXRcvEdLhb0uKS5Jo9Jo7DOnNzuNTgK0Cd5mYHsvv1M9gurl+ju3yIuu4AUjMu5RjtWqVB9syuDKeFEr0LPRPyYdOplmHTk97kM161p86cJ6M/pvYS2X+gY42XZiibFY6aQCofcpeTQe9r8QVoziBqrb5KazUguTA/VZ5wjw7c63/05EXNeFMLTYZxq1pCseT8VtIIayZf7x6tbxbw/HPhIo8gkkawkxxa30eKG6qfZuBcu/4ImZNgsHQCHd247FMyxqjCtfQP2h7lSHVJ0M1IFgAUDiW0EabKc72Oz8gWi+7Ay7BhO0VXtQpD/Jxt5YJbtDPRY4I8vdrYcW47bQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2026 18:22:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 323497 invoked by uid 111); 30 Oct 2026 18:22:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2026 14:22:12 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 Oct 2026 14:22:11 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] ident: remove unused
 author_ident_sufficiently_given()
Message-ID: <20261030182211.GC7582@coredump.intra.peff.net>
References: <20261030173956.585250-1-gitster@pobox.com>
 <20261030173956.585250-2-gitster@pobox.com>
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
In-Reply-To: <20261030173956.585250-2-gitster@pobox.com>

On Fri, Oct 30, 2026 at 10:39:53AM -0700, Junio C Hamano wrote:

> A pair of functions {author,committer}_ident_sufficiently_given()
> were created to replace user_ident_explicitly_given() in d6991ceedc
> (ident: keep separate "explicit" flags for author and committer,
> 2012-11-14).
> 
> But author_ident_sufficiently_given() is never used in our history.
> We only check if committer ident is sufficiently given and use it to
> nudge the user to set user.{name,email} configuration variables.
> 
> Remove the unused author_ident_sufficiently_given() function.

Makes sense. I think I must have just added it for symmetry with the
committer one, but I agree it was never used. It almost looks like we
could drop author_ident_explicitly_given, too, which appears to be
write-only after this patch. But it is somewhat subtly used via
set_env_if() and prepare_fallback_ident(). So this seems like an obvious
cleanup and a good stopping point.

-Peff
