Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F0A10A0E
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719805754; cv=none; b=jFpkOeCHI/u3C+BMJflOTMWdhd9OPHkehsdewufIqJ4ECY5tDqjBJHCUekyCVNdLe3Dq7HLSoZwsvpXgAtQDsav5hYjMsqB7/wpFNITm9nEy2xfGsBbV/x+Mzam2hNFlD2F7a+NzU1rcFTju7/1MURPvq47mOeSiGqkAdYLxbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719805754; c=relaxed/simple;
	bh=kj9FVO1sBhsxkcAO/EJHIY4oFjEiT9gQbiKbORsXrHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4nE5nl49ykSNOFlrNRJmiPmfo33tRbcb5MNgYaNZ/YzSPU9ni1PiZEVyRn4DlF8/qLsb/Q/t40PVMYpQEyaVzqkLui+Fnz05yc/jVYsLfLFqYvyxJZSGeMcpRskrghBtbrQpVdePQ7FYcTKmZWOKWnC7oiQMPMGz7dAGCm4Cbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17004 invoked by uid 109); 1 Jul 2024 03:49:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 03:49:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8521 invoked by uid 111); 1 Jul 2024 03:49:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Jun 2024 23:49:10 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Jun 2024 23:49:11 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
Message-ID: <20240701034911.GE610406@coredump.intra.peff.net>
References: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>

On Sun, Jun 30, 2024 at 08:42:06AM +0200, Rubén Justo wrote:

> This has already been sent: 
> https://lore.kernel.org/git/54253e98-10d5-55ef-a3ac-1f1a8cfcdec9@gmail.com/

Thanks for that link. As soon as I read the subject, I thought "Uh oh,
wasn't there some tricky complexity here?". But going back to that
thread explained it all. :)

I think the patch you've sent here covers what was discussed there, and
is the right thing to do.

-Peff
