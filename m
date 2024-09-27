Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9223B0
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409008; cv=none; b=rg3xCl1/xcFSLdFjR4KHnu9Eq7DJAmvjd2yivE8CVuoXHbP41FZdF0shFbgjZZsgwpnW5H8d0KCy0G0FA1Lm0A5FM2MrNjo+uKRtrYH+xiMAiXpyCtrYDcolrugWiWOTEQlMSbJGRAWKDsmz7bPGxdvTIkXoN/szsLVoNKXUjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409008; c=relaxed/simple;
	bh=TPYkRhr8tsk850hDjN/Rf5s5Sv8o7PXWSIEmpvFtlpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0unq3hRFP7F7huJm0PP2xWFlBzZS4Y56CFPkIlgGq7M/eyjT2P29IkT5a4oiuxru8wy0jAZQT7CYTHYO5EQhHSYPM/dGMgaGKfgNaMWmb6N+gX8hzMaZYSs57pZvrkE9fpDt+qpxeDAMfDzScVTskxgOOf5BHPGizG8ThNhTpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4857 invoked by uid 109); 27 Sep 2024 03:50:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 03:50:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9035 invoked by uid 111); 27 Sep 2024 03:50:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2024 23:50:05 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Sep 2024 23:50:05 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/28] http: fix leak of http_object_request struct
Message-ID: <20240927035005.GD567395@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924220109.GN1143820@coredump.intra.peff.net>
 <ZvVmmV0nYq_cEnj3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvVmmV0nYq_cEnj3@pks.im>

On Thu, Sep 26, 2024 at 03:50:17PM +0200, Patrick Steinhardt wrote:

> Okay, looks simple enough. But I found the whole code in "http.c" to be
> quite... elusive, so I had a hard time finding my way.

You are not the only one. ;)

-Peff
