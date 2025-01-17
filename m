Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6619992C
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114089; cv=none; b=onXvTw1R/AywuomuRH+mCq7/1j1HDxAgyyV+BGaju72z7vISrtViP5l2rrf/AaU7jT+3swxqFzo5HOlc3oN//xOl3xPYIE2i9pZfqMO414dwBY6aW5/HnOQ19X8d/xIXOp1QbyljwPRYuN7wyz3CcZNOPt9k9eFG/zgC0rqLjiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114089; c=relaxed/simple;
	bh=1aauHtsY/QgG9vSxg49IonUHfgDlunalqBU97SNRDNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJefkcCwKhjPuVVc6pVr8bz/+xksc5K7g4Avw3CMDWe4D/WAxuHppxPo1+nYFhMFlTYvqPk71QbExiBjsemBS7y7XOJtyYx5+3dZTLm4zlxLZgSwWKO0SyypPrZ+x18TpOx8J1MNBVL/A86hzckCmNaft3CPn9Eoa0439ss8iP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AJQInCL0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AJQInCL0"
Received: (qmail 21607 invoked by uid 109); 17 Jan 2025 11:41:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1aauHtsY/QgG9vSxg49IonUHfgDlunalqBU97SNRDNc=; b=AJQInCL01W/TCHidUMOGYLn6IzovhIdSxMveH/HyLr5KfpsX0UCSbsq9jf/s2qWPwHt8/1K6X8tk2knI2culRWVbv+aTHqbnd37kcemWw6cQJhK35/0ebH/7ZSCVOKgtBadg/VFqvFLpo6RShJx4fUkLSXncsQrxRIpfKy7dVYycaHsHcYAKa/vt9uq68Tq8E6Mm6KgCHfIvxLXmY8nQQuLCfISkOglNMnavT5rKxQKNFqcpbotuyDucF++SRS4xkI194gmbPD8uLEY62wvH/ufNhPdoDtoq+L10tinnQQURGE2n8Yue5lOS4/TlUn1+6UzzyTp8FdDC+RN9Vi7YcQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jan 2025 11:41:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7411 invoked by uid 111); 17 Jan 2025 11:41:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2025 06:41:28 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jan 2025 06:41:23 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 3/6] usage: add show_usage_if_asked()
Message-ID: <20250117114123.GA2356746@coredump.intra.peff.net>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116213553.2563751-1-gitster@pobox.com>
 <20250116213553.2563751-4-gitster@pobox.com>
 <xmqqr052nz36.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr052nz36.fsf@gitster.g>

On Thu, Jan 16, 2025 at 03:00:45PM -0800, Junio C Hamano wrote:

> So here is a replacement for this step.  Everything else is
> unaffected, so I'll wait for other comments until sending a full
> reroll.

Thanks, with this replacement patch the whole series looks good to me.

-Peff
