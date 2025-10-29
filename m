Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292FEAF9
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753368; cv=none; b=h9vXDUgRDw0aQM4ylACODq/feA2tPtC2ops48qnqEvoEiqNaA2eFEM4gjiL/Lnsd8N0S4Nzm8Am7ABNIZ60G6emP9lTA1Te1lgnKd0eJIrimaFADYA/sExOMq7VeJB0GNmSnC4PrFHihqX5Z67DbkI7uZy7a5B9qD1QE93zBfVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753368; c=relaxed/simple;
	bh=7ikLHdmhkypOYUkR8XQYzROo1b9bSynBzvQNQhRoLbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMDwVWdmqBlaWjDX/cEsq3PKi1Xl5PLKvGPjINMk2gCVyMTB9ZCqh2kKyQfsjzVqbt84+pRFqtbIJLGPJHz0zXNBxOkufP1TbX5zwrduhpy5i4Hb8/vmUAr8WbQ6CHc/nc2KvO84yXpuyPzD7GVF6cl7HXPTHGWhjaYwUzS0ISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gAOoxZLi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gAOoxZLi"
Received: (qmail 377584 invoked by uid 109); 29 Oct 2025 15:56:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7ikLHdmhkypOYUkR8XQYzROo1b9bSynBzvQNQhRoLbI=; b=gAOoxZLiaKiZHeBf4GjfhSFvB2TZEJbON1+HOmIroX+UNeg3ZLADIQl8GETYBEFPXK6Wc5c7KEVSpLLNYbnHB7YhIPYLybX+U6fJOVIkxsQosbfEii2UDtlEuuuDhvKoUL/kQmcnCfJQDhKia/UyMeSzKYTzLZjjO/2slIew3P48yLBsW7XmbjDG/nl4f7ZL+RUElXitfL40u9nZjVAkYe4FU+vyvMCfbWIdZmRprukNoZg2Ica3qDnZkMgHx7C5uV3XnJ5m8pAuMi4g+YANOy5Oq15RmBp2dMVQKokOyp7YW+VVhPfZz3s5xe9l9Ob9bPkpNV7DmnUrmb3OcMiWNA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Oct 2025 15:56:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 585481 invoked by uid 111); 29 Oct 2025 15:56:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Oct 2025 11:56:00 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Oct 2025 11:55:59 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: document backslash in gitignore patterns
Message-ID: <20251029155559.GA1134232@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
 <20251014003404.GC1507@coredump.intra.peff.net>
 <xmqq7bwltlb8.fsf@gitster.g>
 <20251026152614.GB2095501@coredump.intra.peff.net>
 <xmqq7bwhmecb.fsf@gitster.g>
 <20251027142902.GB2758515@coredump.intra.peff.net>
 <xmqq4irkl5ms.fsf@gitster.g>
 <20251028231945.GA4128296@coredump.intra.peff.net>
 <20251029153237.GA1133542@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029153237.GA1133542@coredump.intra.peff.net>

On Wed, Oct 29, 2025 at 11:32:37AM -0400, Jeff King wrote:

> Subject: [PATCH] doc: document backslash in gitignore patterns

Oh, I forgot to mention: obviously gitattributes inherits the same
behavior here. I looked at whether it would want a similar patch, but it
does not define the pattern format at all, and just punts to "see
gitignore(5) for details". I think that's OK. Unlike where we refer to
fnmatch(3) here, you cannot even begin to wonder how backslashes are
handled by gitattributes without reading gitignore(5). ;)

There's also the "pathspec" entry in gitglossary(7), which does mention
fnmatch(3). Though it is even more confusing because of the literal
matching that pathspecs do. I don't know if we'd want anything there
(and I kind of doubt people get as exotic about patterns there as they
would in gitignore).

-Peff
