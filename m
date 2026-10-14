Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054847A887
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969482; cv=none; b=TCfeaGEDAzVxa5zX8/SmuKQjEoe+ggPgNRq/abjhcH37l6BasI9rUDsKIlJU7sITU7eN009Skx0eMgkzJuCXkjZ1eyfwFYQKVEkfbJZlSdtX+X29+uQorPJHLOesgqCD6/xd4VU1OK8Wpo56qprX8Q7HlCyqfKP/ToiEH70S3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969482; c=relaxed/simple;
	bh=TGu+OqnZ0/teMdVnU5UPrRyzEJBQoMBXGrUCvvYQdRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg7NwaRetJr87yDEKyuqj+bT0qNH49ruc0QBaVtS3SPq4DntKkHRokVZb9znCzFik6lLE3flu9d0uDqyPsMiCe9G7TcWITSpYHgAX1wHqfFeLj7OHWPVgPtkx3BJi4SFlP1O4IBm+Ef86ZYPaZbxb+sR+XnyJZE0dMAmWp4l9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SvKQf8bj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SvKQf8bj"
Received: (qmail 68906 invoked by uid 106); 14 Oct 2026 09:17:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TGu+OqnZ0/teMdVnU5UPrRyzEJBQoMBXGrUCvvYQdRg=; b=SvKQf8bjmLK5EjBQn9NIZImbjMU7RqpcFFhr/b2i0hUBXdX0kqKemqDadIbgbJkLY71q528B0X+BhelK0h7SWmyCxEVPGDBdZdv3HnmqpKLfBelRC3DSlUZYbf1iRMgJL5+ODGxDUp0z3XFenNYkwTsC2tmNrzhxtpAHSkz6ywNQVj5a+w6l3z4UGXhhVCWXP5j3Cc3Oky57zKEjnZ2oRkP4TaYRZ2scaIqJmKKO7+6YxyBdyqjLGQkli7Ch3uBbQ0xK/i+eHZqXXy0U5xtJ7bhcGOzeqggBlXE75jNxFqbvmD+chhezJPqG1JrDtY4koJGT2w5vtp1vqCKoync4Ow==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 09:17:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35667 invoked by uid 111); 14 Oct 2026 09:18:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 05:18:04 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 05:17:59 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 5/8] ci: rename linux-TEST-vars job
Message-ID: <20261014091759.GD1341124@coredump.intra.peff.net>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-5-04c24e1f480d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-pks-ci-housekeeping-v3-5-04c24e1f480d@pks.im>

On Wed, Oct 14, 2026 at 10:30:31AM +0200, Patrick Steinhardt wrote:

> The "linux-TEST-vars" job exercises Git with a bunch of non-default
> options enabled. The name of that job makes you want to cry though due
> to the weird upper-casing and because it doesn't really tell you what it
> even intends to do.

FWIW, I have always hated the name, too. ;)

> Rename the job to "linux-feature-testbed" instead.

I saw the name discussion upthread, and I agree this one is good.

-Peff
