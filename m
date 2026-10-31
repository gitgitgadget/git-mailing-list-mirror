Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423201;
	b=aC/b7o4Pv1Efw86IjTX0srZ05s0QWTXD9dyxtc+bDbwyZSo5twucoOPU8KTPCq7Xi4vE
	 YfhPF73ZTKtqjprBTTDK+8uF1q0efwXrDI9FPWneLd1GFJNPfZr4HdMoJYZror92XSDDB
	 Z+fb83wPr6319nToEhNjNG76C1zOAMx298+GXwjTeMvkOmb0soX21BXdWUrWVej/fDBrd
	 0wfQiW96bvC2bMB8sCih7OMJf/Q0rqw59O2wJCnC0Z/0TVxtQYNyygKdAXXa1Ap7H+6Mw
	 o9kYrVDvntG03XbUK77KQmk292iCdQXYtmdY5YO++k3c8ZaPro+cF2B+xefdWe7hobw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423201;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=qOV/INssqfXbp7/I8CtvdMh5rtE0f08RjpmHoDXENmU=;
	b=beL3lApO1kM634qMg6f4uf6BdWlNhGYmIydpKW9nSJhJK1MgsvOSkXDI1FP9/PI7LGhY
	 OkzY/B7Ot+b/+uafQPPzKTvqXRnwurKhSuA6tr8xeBGdSquogn9pU8/RcrSXG/OqH7Kv5
	 m39+RXnEQmMAbHDhq3AlGfL40bQDpsCwepAILw5KoN1nJuGJfplP9gUPmnDimz+gHIHgx
	 HSHvVKL0WH3ohVPdoQ/mSAdgLA6eSsX5vxZuGoqyejN6OAN5VuY1fdP78LjmXi5pMc5GK
	 /f1ymSgU9DRSwpHVnzFTxLy/wuSthjXzIsaOWdkIEf1MeDm9n1md5Xp2vEOcD/q2SZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=FJQ5Ap6H;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC7606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 05:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71AC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=FJQ5Ap6H
Received: (qmail 50819 invoked by uid 106); 31 Oct 2026 05:06:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=jMbHR/kyU+sLNM+0ON7PeY/w7dw7TMoWKSY1Xz04XrM=; b=FJQ5Ap6Hq8afBSO2o/HGQ5uQDBb9rea/kSV5++2tZ/k3iAUwu7dAEyGiKoM+0YlwHoeukbOM4NUQ/ODrjpB01dPy0SNXBrTzKPLg/G8A1OSJUmLjenxO47iCzO0gMr/FCa3vuvhu5jPUOd87pLUmcFUYED5lPSmY+3INsz8Pxal+CJbjdy3RK594zBI8B9r+6mTWDUlorWERp5Mcwn5ydxwVwSMEWpz4gfmSaoDa1vJf8znYuIcwBolPt2TMAsuh/S2hyI3GF4ntTKe6KOj7Ng+8JKIx5ixQ2Qsp6WisD6KuAhWiB8V+Wu0agotIJXpjYYfXGuIATg49FRK0YTSjbg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 31 Oct 2026 05:06:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 329750 invoked by uid 111); 31 Oct 2026 05:06:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 31 Oct 2026 01:06:38 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 31 Oct 2026 01:06:38 -0400
From: Jeff King <peff@peff.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t5702: be more resilient to env quoting
Message-ID: <20261031050638.GB1202343@coredump.intra.peff.net>
References: <20261031002550.GA626623@coredump.intra.peff.net>
 <20261031020318.tLesiElF@teonanacatl.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261031020318.tLesiElF@teonanacatl.net>

On Fri, Oct 30, 2026 at 10:03:18PM -0400, Todd Zullinger wrote:

> > It doesn't quote every variable, but the presence of "=" now triggers
> > it. We could loosen our regex to accommodate both versions, but there's
> > a simpler fix. We only care about the value of one variable, so we can
> > just print it using the shell invoked for the server-side command.
> 
> Per the coreutils-9.12 NEWS¹, it now honors "the
> QUOTING_STYLE environment variable, defaulting to
> shell-escape style."
> 
> Not that I think we should keep the env parsing; as you note
> there are some pros to replacing it anyway.  But if we want
> to use env somewhere else, we can set QUOTING_STYLE=literal
> to get the unquoted values too.

Heh, I started to wonder if there might be such an option, but then
realized we were probably better without it. But thank you for (as
usual) filling my brain with more Unix esoterica. You never know when it
will later come in handy. :)

> I didn't properly review or test your changes, though they
> do _look_ sane at a glance (albeit a quick Friday night
> glance).

Thanks. The thing I most worried about was messing up the quoting of "$"
in the embedded shell command, since otherwise we expand $GIT_PROTOCOL
in the outer layer. And as it would obviously be empty there, that would
give a false pass to the tests that are expecting it to be empty (but
you can see from the upload-pack one that we do get it right).

This is a case where using an "<<EOT" here-doc might make things easier,
but I stopped short.

-Peff
