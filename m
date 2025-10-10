Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC5846F
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072792; cv=none; b=hbk6cofBZOf7EH2ffd7cBSMFswL1a8Ym9E9H3XgHcimgOuXXiKy3X40ClX3ELB8fWkY1SZzV1NsSLz3Ek6fFHk8aBgYGAk2X7iyCKJSHFIl8KWr1tecNCL8GFW2gQZQlL6R4c12tDnDrEZPT8YyVlFlkGrsnE+7Dnv5IDKTA2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072792; c=relaxed/simple;
	bh=8A0Kq1SxXRrZB5/pZJkr3gfu37YRH5IBWpTDXufjLhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9picYN/Zbqfokz6f2nJXY2t3VPTEcCmbVUPU6unxWAFsvnUUVJikRqpw7Ey7Gw7/1Q+WmmnnizYd0rzw8E5jQeEfEJB0elkqZid5Eqr1aopTO7Vf13CZ/0jbklWi5t6f3vLt32Wnb7M+aKixfgiodtUsunr0LNd8tH4KgGizKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B3Lm/J5R; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B3Lm/J5R"
Received: (qmail 181857 invoked by uid 109); 10 Oct 2025 05:06:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=8A0Kq1SxXRrZB5/pZJkr3gfu37YRH5IBWpTDXufjLhg=; b=B3Lm/J5Rx6ZvFK3+TrzcIGu1lQ9o6P3SwQ3Qq5YPu1TvU2ll8xkuVK9KfA6XykAOVic0dgBZ+7uhvuo+JTu0tb7T85U3iXOpQWTUFzX2N3pl0aNGFTAoALjWcb/AyA0UuJpnSVt5GCmUJSq+PPWXW3g40iDoyW5UmGOCdb/4QcsHTNFrM3sWsdYNHc7dnm5WrlFyTL8k4TYHURxOJ/JRonKgK+XPg67+eUXXmV3ZwXdmGYbQY/5YE31iZOrPkZiWINu25+MugMlIU6HSz7C+cjiIeRX6C0HAJvwVERPajHHJUo66LdbrRPo//xm9fGzpBFzzE5+0CbgUUWt8qF8x5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 05:06:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 282656 invoked by uid 111); 10 Oct 2025 05:06:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 01:06:29 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 01:06:28 -0400
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] doc: patch-id: convert to the modern synopsis style
Message-ID: <20251010050628.GB1897715@coredump.intra.peff.net>
References: <978261e3be4.1760043036.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <978261e3be4.1760043036.git.code@khaugsbakk.name>

On Thu, Oct 09, 2025 at 10:53:53PM +0200, kristofferhaugsbakk@fastmail.com wrote:

> Convert this command documentation to the modern synopsis style based on
> similar work.[1] Concretely:
> 
> • Change the Synopsis section from `verse` to a `synopsis` block which
>   will automatically apply the correct formatting to various elements
>   (although this Synopsis is very simple)
> • Use backticks (`) for code-like things which will also use the correct
>   formatting for interior placeholders (`<orderfile>`)
> • Use backticks on options

These all look like strict improvements to me. Sadly doc-diff doesn't
show much here because the changes are mostly typographical, so I
eyeballed the HTML output (which does look much nicer).

-Peff
