Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1B348C56
	for <git@vger.kernel.org>; Fri, 29 May 2026 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043840; cv=none; b=eIbNaHNx8gQaZbMNqGbdhaLTkGvrNR74xSNW6qmYUzFUDUse90AeL7hWU2gkh49usZQrqmuIp4vvHd/sgsoCOwNsvjuTm/gZt0pBydT+v+fBJTdViu7eHPv3uKtipl8HRNnO4hhJF9A4XpMwHlsfIs7gRqT1XkwH+LD7TbcUPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043840; c=relaxed/simple;
	bh=64R2E4txTD92DuHj3TfZLGrTgaA99MEvE8pzB32O6sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBI4VVm0USbgYZtY1UhRrVC3kjlgcQHatEGxniz1vS7+z3xgXu5WUhUmPN079rJmlymXvayRkq2fSKZV3H0szaRjbu4jvUhSn6z6qYUuCF2cOw30GJyknCzt6ykoxrI7fIQJX5vwT1+zsy6Vt69wDLDxU4HLQyre247W0tq2/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AigLgnPF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AigLgnPF"
Received: (qmail 5830 invoked by uid 106); 29 May 2026 08:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=64R2E4txTD92DuHj3TfZLGrTgaA99MEvE8pzB32O6sQ=; b=AigLgnPF06nJSk+sAT6zqTmq/VkF2FUkNWXbfT8MYI6EnJuKRm6pC2c6DWyrfsT28+1KoZeUqtXQ+TPnXLGGL6k9xykE9fv04jEArncNyZp7rxy3VLs4RfoNEp2ayrGYcXHUBvuc3gEEpucW7EclC7OQsrllkGkZNI6ulujnbCBHdIZK1q4S8sXcxQCPWSYNLCo0GRe4HB7a5E42h2gxRYydJX+MxQ6gSnh7i4jjxpVUyX1BWEA+fdYVLiS1VJfozVQX8osYLt6wSUPYjBIXUbE2zXzUzmBb+fUsFWjdUPuKomhfR9KRhoF2ErP9Ftgw8foHES7DUXi4dgjv36TEhw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 08:37:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9186 invoked by uid 111); 29 May 2026 08:37:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 04:37:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 04:37:16 -0400
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] commit: remove deprecated functions
Message-ID: <20260529083716.GE1106035@coredump.intra.peff.net>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
 <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>

On Thu, May 28, 2026 at 09:00:09AM +0200, kristofferhaugsbakk@fastmail.com wrote:

> Topic summary: Remove deprecated comments that were slated for removal
> after Git 2.53.0.

This looks obviously correct to me, but the whole topic made me wonder:
was it worth retaining the old names and deprecating them, versus just
removing them back then?

Topics in flight would have needed an update then, but they did
eventually anyway. So it feels like the total amount of work done is
larger, compared to just fixing them as the topics were merged. Either
way the compiler tells us, and the adjustments themselves are small.

Not a huge deal either way, but just pondering for future such
situations.

-Peff
