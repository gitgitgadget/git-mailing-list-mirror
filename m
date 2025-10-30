Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6899221D9E
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792794; cv=none; b=gffKJIGGVJrx4KNgWvb5I0S2zBDBAvdOpt/NEYg3B2224ns9cuNQr7QyAGWa/9KsKSRtoXRCMeB7SwTL7N2SPpPTiTmHjZiDaVms7b0E+EMaxOcxaYr1zq3mKZ5EAE/WwpqJAt7nnKqc/6Q4gwccPuV4vdOT8jZMevflwRv1wbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792794; c=relaxed/simple;
	bh=8fdqCE7Qht9q4PXClHpvn2e497bXMTqUY2bTPRWie+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bb0JynC57gVnWsyZuC8XgPAYyWLHTMQVkUZXudFtF61pFED/csUwKsck1/1r696+mGYMLgFaHzoeK7fVkHVGZg4VAGDuW2x28q5QS72bocDLFOvJ04kQvAwHnzWJ88hxBAFb/3yYR/hj0CxswIFZSEbpxUikz9q0MbWeGOqdIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I4weLfC6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I4weLfC6"
Received: (qmail 381492 invoked by uid 109); 30 Oct 2025 02:53:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8fdqCE7Qht9q4PXClHpvn2e497bXMTqUY2bTPRWie+4=; b=I4weLfC6yQoIgu0bQ+2W9Osdop/oqQxRggrmkxvHIi5qTUDfVYq161p8T5cw4wV9MrMBCansEDsWr/7yy73haEn5uYMdtf6Sxp22cBXczB7n/3ygkA2XcVoUM0CZu/slVIo1+YuKwktLQTNvKQPdbf9zLUPUrh+EEvx+9DlPhcAd8Ax6ovtgmNgyflVpTtxf9DwcNePHU42NH2jV2hON0UF43NKJvjFVRgRpCZ6BMgs8FjyWQnDM7h8aXl3XfVMmxdFlXZLaqqlWxNKraOtWjKEbrKA15V+x76naQN/SuHrpogUDfCcCbbZ+v+pZmRJZ4Ul76kY3fwrJ0YCbnBbvxQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Oct 2025 02:53:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 593345 invoked by uid 111); 30 Oct 2025 02:53:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Oct 2025 22:53:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Oct 2025 22:53:01 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: 'SZEDER =?utf-8?Q?G=C3=A1bor'?= <szeder.dev@gmail.com>,
	git@vger.kernel.org
Subject: Re: [BUGS] Git v2.51.2 on NonStop
Message-ID: <20251030025301.GA1266932@coredump.intra.peff.net>
References: <xmqqo6psjq2n.fsf@gitster.g>
 <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
 <aQKVByfUdYHSEcDz@szeder.dev>
 <000201dc4925$2cdbc450$86934cf0$@nexbridge.com>
 <aQKgxfZ9WQjyrhpa@szeder.dev>
 <000701dc4933$9f79c670$de6d5350$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000701dc4933$9f79c670$de6d5350$@nexbridge.com>

On Wed, Oct 29, 2025 at 08:24:52PM -0400, rsbecker@nexbridge.com wrote:

> What appears to be happening is that the Make environment is only using SHELL=/bin/bash
> for the outer processing but not the inner #!/bin/sh of t7900. The system is using /bin/sh
> as specified, which uses ksh, not bash, which is the trace above. When I run the individual
> tests with bash, the error reported goes away. The problem is, with my version of Gnu Make,
> 4.1.2, the SHELL variable is only being replaced for the command processing of each
> recipe. Once the system loader sees the shebang of #!/bin/sh, /bin/sh is used as requested,
> and fails out. This means that I have to remember to manually run each test that fails with
> bash instead of the default. It is frustrating and now adds hours to my manual evaluation
> of the CI/CD results.
> 
> The trace above is from sh, not bash because of this.

Does "make TEST_SHELL_PATH=/bin/bash" work?

The default there is $(SHELL_PATH), which is distinct again from
$(SHELL). The former is a Git-ism for the shell we replace in #! lines
and invoke from within C programs, and the latter is a make-ism for how
to run make recipes. If your /bin/sh isn't fully functional you might
want to be setting SHELL_PATH, too.

-Peff
