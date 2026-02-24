Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CE36A01A
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924731; cv=none; b=dQ4BJHxm2HvikNq90IPijwdXD/6vxgghbr8Be1P85evLzlfZTbAN0GAIH9OtA5oRB3aupNFesD73QG1P5bN/MKmgiFO0acw+wTGBg1ZvgrDff4McZ804cCAfs5tWlFu9IejbxOQ4MdNLQFWGCMUvRLW2t4ZYV1NGXprnldOLL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924731; c=relaxed/simple;
	bh=kAP4EAsZ4jkW8ZE6rQ2wuhC1diMc42+nF2FPiomOjW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnSvZFxjBdqfDoWAvjo2gsz9SEplYTprSU8xv8dwNr8XDDT5nAqJBTq7p08WXgOj+95MqOYXvTSxFsY9m6mfU7OrBO2mFvJzsM/SpXpga+hsSW6WJfbvjplRjnryHdnLnu8cylUTitiI4WiMPhY4EHwBYKJ+qnCv/KYZ7B13XDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=REGUBUTg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="REGUBUTg"
Received: (qmail 59547 invoked by uid 109); 24 Feb 2026 09:18:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kAP4EAsZ4jkW8ZE6rQ2wuhC1diMc42+nF2FPiomOjW4=; b=REGUBUTgZoX1hPMXlUihxBsLMkF8PsNFinGhbchdBBZUgFjd21R1vdw4mJBMGG2K8rfWqqBbrSZo1pXP+Pd13WbaOeOQYV5IsCIv0WlwHN6aMJK7awTBedEJE9MsGZefnIVcjSoNeo5E2DhvxiZQe/yYoj36QW9fPapm+1YpRzunTpzmgGeMB+G3o4tpEftwiJn0Ith2yknv0dND/cQH3X/FROSiNK6TCx6T7tq5lFMrORwRLGlFS8+GLWHmlp1jgGPrx6BptM6Rie1LWNhf/MjPMp0gzBTthd6Mrcf78ynhZg2Ie1xGNm1DhPrCBQ0UFvXcG+3BMtCROK+GAYXNig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Feb 2026 09:18:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 143389 invoked by uid 111); 24 Feb 2026 09:18:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Feb 2026 04:18:54 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Feb 2026 04:18:49 -0500
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] format-patch: add ability to use alt cover format
Message-ID: <20260224091849.GA994347@coredump.intra.peff.net>
References: <20260220230633.132213-1-mroik@delayed.space>
 <20260224040400.751247-3-mroik@delayed.space>
 <20260224090207.GB986367@coredump.intra.peff.net>
 <aZ1qLtteLECvnY4R@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZ1qLtteLECvnY4R@exploit>

On Tue, Feb 24, 2026 at 10:09:39AM +0100, Mirko Faina wrote:

> Thank you for taking time to explain more in depth. I'm sorry for having
> CC'd you for such a trivial matter, I just didn't realise it was
> possible for an empty string to make it there, I assumed it would've
> been checked earlier.

It is my penance for having been involved in the mess that is pretty.c
in the first place. ;)

-Peff
