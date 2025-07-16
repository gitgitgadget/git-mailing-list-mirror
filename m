Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB611D63C2
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641101; cv=none; b=sJ3mn7sCmI+rN5epJPAu/v8b3UC/xu5NRECfi0xpsK7kj68cMjVkr2PjPfeJhZUtbx+fUHdZCJ1pa90C1l6DD2x8ERVeXjbNWTlhgw3nxyiYFYRhAZqztzr5cucDEsBvEIqDQ4hK+mU2Sqd2KvpilRVYlqxkhfXA4LUywQlz0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641101; c=relaxed/simple;
	bh=MA4GnXFkGCzpD9Sa5U752Skkfa8boiRk7/b/VDuh9mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILeNbAOZOctzkXd/8M3hGbWeBEIxGQCNZ7YMqMCQccI9dNCSGi3lzCGq+F6iPh1+FzmglZZevxDtpbh5RbZtY5c78eFSR51lGZKEMwHhJcJZppG6oL0jxvNhFEmUUfbztJc5UJ3RaPiAsQluZMfxBrTF4eAk08gextNXxGurG8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TrmzCUJq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TrmzCUJq"
Received: (qmail 377 invoked by uid 109); 16 Jul 2025 04:44:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MA4GnXFkGCzpD9Sa5U752Skkfa8boiRk7/b/VDuh9mA=; b=TrmzCUJq3A3sUNf/Ye2exko7KZ2afnyKYOxLVHxmvIBW2lRIDoJbu/uJSpt5KeIU8uwyraIRV1ZpnTeFJ8n7tRpLCsjDkyY7rcDoTbneL6TpIWmNPp/r6A21cWbv4aKXH1OcFVxvLknViRfxIRzU1hS+USnkjehKlLd8hVqsteRY8/Tc4VWXdCxYh3fHWxFny1EL4QSfas5r2WsVd5sSbVd9lWBzLQmDIgb1HSsnCUkyIMBuUQpEL/b7oMTVom9AX9QgaTXrDVxQxUxmk7K2cvvQusnb2G79WQlZTdJImCSNFHAgKci+VoRtK+goX7vaeuDLxDXQRZ6TjIvJlNEiDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jul 2025 04:44:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9319 invoked by uid 111); 16 Jul 2025 04:45:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jul 2025 00:45:01 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Jul 2025 00:44:57 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	redoste <redoste@redoste.xyz>,
	Jacob Keller <jacob.keller@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: allow non-real name contributions
Message-ID: <20250716044457.GA1395735@coredump.intra.peff.net>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
 <20250716002523.1392423-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716002523.1392423-1-sandals@crustytoothpaste.net>

On Wed, Jul 16, 2025 at 12:25:23AM +0000, brian m. carlson wrote:

> -Also notice that a real name is used in the `Signed-off-by` trailer. Please
> -don't hide your real name.
> +Please use a known identity in the `Signed-off-by` trailer, since we cannot
> +accept anonymous contributions. It is common, but not required, to use some form
> +of your real name. We realize that some contributors are not comfortable doing
> +so or prefer to contribute under a pseudonym or preferred name and we can accept
> +your patch either way, as long as the name and email you use are distinctive,
> +identifying, and not misleading.
> +
> +The goal of this policy is to allow us to have sufficient information to contact
> +you if questions arise about your contribution.

Thanks for updating. I think this reads very well, and you included all
of the citations I asked for in the commit message. So this looks good
to me!

-Peff
