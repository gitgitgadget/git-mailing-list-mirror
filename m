Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22F413256
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543659; cv=none; b=oVVMxd2Qn5XwlZmqjxFLezxfydOQD8b8H+fpYgntptzgXCbmSqGyztOTO8VJUqVultoYwM2ddvpjWCchi2WG4T5mA1YzraGKjqzWz/s+aAoUcweXCykJ/ltOEICtTk6p3D8vE1klSoz+v7mD3ZHOg3ofTVFe/IntiQUNJMZXVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543659; c=relaxed/simple;
	bh=YAXM8tQU4vvKf9we079SWGWDwAqVovGPWxUHW612FZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u30bK6L7kz10QDVnYPeZTV9h50Tt37Xfv6vxHUdb8sRg7w+BsnTPQEzXgjxWjGjA+diZ+2Q8OUjnoI7P+GKhR/VLhttmMOWn0NtgnR9qtVifOyWI/OqESoFSr8tXqJvS3NOGfq5WRfvfaMqazNvGcTFkuhNDw0/XReejFLQouok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fsTb08qG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fsTb08qG"
Received: (qmail 144232 invoked by uid 106); 15 Jun 2026 17:14:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=YAXM8tQU4vvKf9we079SWGWDwAqVovGPWxUHW612FZs=; b=fsTb08qGX6dlvsyxHdzZ2Jh9hXOmK3WpZxhJcFkO4UyzrnQCIIA63c5R7DEN3SAmgSvJUYFXyz2V56jA4CSb83akaBGqobeOG1jlRNnpRxVqjXoPi350UA7V1n6NOEXC5+20oUGPTRyVi6B5HkNlfwOCat8JWookzAgY1WLX0S9fzKqrMq7f4Jk7ErZ69VN6r6Q9xZ/99hKPuwAytCutBaTW/4rv8hw3lxNNIpmQWTOSxbWRyWZfq62tnJgqXI4OyHpvdGBSOwqdKnPplma0WOaGPP/7/EGFM674+wiUvL9Gj8pauLQ4KO11V3/d6ctr4GsxEld+nFgBvyRlk8mgow==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Jun 2026 17:14:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 394380 invoked by uid 111); 15 Jun 2026 17:14:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Jun 2026 13:14:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Jun 2026 13:14:16 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] doc: fix a small, old release notes typo
Message-ID: <20260615171416.GC91269@coredump.intra.peff.net>
References: <645638cd87d6d919af6d4310be8176d49fba326e.1781456960.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <645638cd87d6d919af6d4310be8176d49fba326e.1781456960.git.ben.knoble+github@gmail.com>

On Sun, Jun 14, 2026 at 01:28:31PM -0400, D. Ben Knoble wrote:

> No harm done if you choose not to keep this, I think. Stumbled upon it when
> trying to understand Elijah's message [1] about timestamp_t overflowing in 2106
> (I though 32-bit time_t overflowed in 2038, but timestamp_t is something
> different… except maybe when it's not? Anyway…)

Leaving aside the patch for a moment, the answer to your timestamp
question is: signed 32-bit takes us to 2038 (and back to 1902), but
unsigned goes to 2106 (but only back to 1970).

Usually time_t is signed, but our timestamp_t is not, mostly for
historical reasons. And timestamp_t itself is our local invention
because we have no control over the definition of time_t (but we still
end up needing it to call system date functions).

I have some patches to allow negative timestamps, but I ran into
portability issues. IIRC, Windows gmtime() chokes on negative
timestamps.

It hasn't been a big deal in practice since new commits made today will
always have a positive epoch. But negative timestamps would allow
importing some historical projects (like Apollo mission code), as well
as weird (ab)uses of Git to store historical documents (like legal code
going back centuries).

-Peff
