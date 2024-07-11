Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344412F385
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733601; cv=none; b=aIZTAWnHeg2lw3Y5VigaTO+uZlFumBsJXP4slK8DaAzlUYOYThupoqce8p6Y6HrNlUzaVA4AOujzAvg0VU7Wlxyo6PhKwxqnilW/SASftT4t8WJAl5Nqnd/TZ++AqFe0Y0l/Y7c1AZ2AtLx4+vlwTzMvP2O4Dh2ml+q7iXcXtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733601; c=relaxed/simple;
	bh=CywxUXeBsQ99JtRfVLmIcb0dfD3GWA2H02Gn96weTqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1/qGIb5Br4Nv9DaX+oHms+wj4Ed6T2hVOzl9f6HWBnHRhvIEB3fSBIR1m6UopqmAOM7QVD47YoDiZjlHY4Xt7jCrv8WsyhLftvsO56J8r+Z+HgKg5qAL3ICP0zyD2EPiJfn+9bIzpf9bvl4vSTPf16HeWkYwfGRv+O6fh5R/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19501 invoked by uid 109); 11 Jul 2024 21:33:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jul 2024 21:33:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25207 invoked by uid 111); 11 Jul 2024 21:33:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jul 2024 17:33:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jul 2024 17:33:18 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] builtin/push: call set_refspecs after validating
 remote
Message-ID: <20240711213318.GD3648684@coredump.intra.peff.net>
References: <20240709144931.1146528-1-karthik.188@gmail.com>
 <20240711093954.20317-1-karthik.188@gmail.com>
 <xmqqo774neyj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo774neyj.fsf@gitster.g>

On Thu, Jul 11, 2024 at 08:08:52AM -0700, Junio C Hamano wrote:

> > Do a simple fix by doing remote validation first. Also add a test to
> > validate the bug fix. With this, we can also now directly pass remote to
> > 'set_refspecs' instead of it trying to lazily obtain it.
> [..]
> 
> Everything makes sense to me.  Thanks.

Likewise for me.

-Peff
