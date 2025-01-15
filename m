Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACA35944
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980124; cv=none; b=PhDObl1HzhiXxruA9NqlXCrAQ/lJof2awehn+Fjj8MJ5+JGKEZoMyowX13qPTOv3Cof5NwWGWv330V/GjoKBpMWGiS0Qut2trIhF3yrnKK6hk+5fvvFiPbqwsa3nF/O7B6V3NUyrHGVFHOk5CCR3fAMqD48BA5mRtNNx8ROzScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980124; c=relaxed/simple;
	bh=hK0iXuaMGHRtHXH54LejEqplBwmuEyFxB59fbGDFj1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+p4rPmOnZ9tm04nglgdr62AdycGDV3qoA76bSK7p9EkkthIqB2HgCnmHTaeS7zpUtz1YTg59x7oDUDOkcTx2FJP0B67izegM15bPqrZxhQp53CxDbVegHX84EI5FVPZfZgUskrQxz/DH5ZP5tJmxSZ2YL7adhrSSmR6poIvO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Suz+gvkN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Suz+gvkN"
Received: (qmail 7998 invoked by uid 109); 15 Jan 2025 22:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hK0iXuaMGHRtHXH54LejEqplBwmuEyFxB59fbGDFj1Q=; b=Suz+gvkN9fgcEeqnNC44ieoWuZNH2EAubwMVcNN+5vjqn2xdD/NRzBDffc0+wNzvXWvVljQDguPRBGko4sVyFgRaTbwaBI8EJcj+oiqqZ1mrAjcWc+XksqKU3tz0vSmY1CqovfF9YfHwipNYPOAEo7vZAA1HYxkKH/O9ZSfchxaMDW4T3tA/DdeX+r8a2xNwWimIADxQQNF+vAhiogeINct91Lv+moc5hC6T6KP0rzAitHWxPZbxLVkgcjXnHBN0WlwYDEaG5QW4FVTFu/FkyefR6nuG3TJGG+LqoqK25XLoVX3XkePAKE/dwBdImnqaNsy5hS45Kc0QnrMN3kgq/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Jan 2025 22:28:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16182 invoked by uid 111); 15 Jan 2025 22:28:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2025 17:28:43 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Jan 2025 17:28:40 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>,
	Jonas Konrad <jonas.konrad@uni-muenster.de>, git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
Message-ID: <20250115222840.GB132248@coredump.intra.peff.net>
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
 <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu>
 <xmqqed1414gt.fsf@gitster.g>
 <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
 <20250115171423.GB57018@coredump.intra.peff.net>
 <xmqqmsfsx8oo.fsf@gitster.g>
 <20250115182419.GA86610@coredump.intra.peff.net>
 <xmqqa5brydz1.fsf@gitster.g>
 <20250115212952.GA96537@coredump.intra.peff.net>
 <xmqq1px3ybf7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1px3ybf7.fsf@gitster.g>

On Wed, Jan 15, 2025 at 02:11:56PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And it uses code 129, even for "-h". I don't see any explicit rationale
> > for that in the history; I think it goes back to the beginning of
> > parse-options. It happens via the PARSE_OPT_HELP flag, but curiously we
> > also trigger that for ambiguous options (which should exit with error).
> > That might be a bug-in-waiting if we start handling PARSE_OPT_HELP
> > differently.
> 
> There is another class of callers that are protected by the same
> "argc == 2 && !strcmp(argv[1], "-h")" condition, and they call
> usage.c:usage(), instead of calling usage_with_options().  These
> calls (but not all calls to usage()) need to be updated to use a
> similar helper, say, show_usage_and_exit_if_asked().  Sigh...

Oof. And that uses vreportf(), which always writes to stderr. So more
refactoring.

-Peff
