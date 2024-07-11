Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D8187332
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733556; cv=none; b=gM0r1i/MmLjHty6wd5XncK4ukOWPCe0tXc4+mYwuUt04MmBo3zjPWcBlxQC8/aMnslf5MY5X81NMnjC0QLM6XHwuFZWxLVSMy/1BcZjOOM/WIkHHgNeL4suETWW+Ol6TXGRtabcNlPpewfS8AyNIVqdkFvl9IWeTgqF/PT23428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733556; c=relaxed/simple;
	bh=/1GpfbG24lJe9YTF2qSRvc6c5JLNRlYYTaQ/tpMHsxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLLKcXuCKsmx8MkZOL90Eq8XdZ56ySB0cq1VQGDEns6PFCTuSVxFqSZ33mFHGACWeFYQfIrzi4pXZ+AqjvzPE1thU6PbrjRA4AiozQFtaoPsySbDx3LoyQeRBWVGzlhAzStCdl3HoR9BIX7yT1BSbS2kZC/R/OPApyfrobXbLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19485 invoked by uid 109); 11 Jul 2024 21:32:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jul 2024 21:32:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25202 invoked by uid 111); 11 Jul 2024 21:32:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jul 2024 17:32:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jul 2024 17:32:33 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/push: call set_refspecs after validating
 remote
Message-ID: <20240711213233.GC3648684@coredump.intra.peff.net>
References: <20240708140350.622986-1-karthik.188@gmail.com>
 <20240709144931.1146528-1-karthik.188@gmail.com>
 <xmqq4j8yflrq.fsf@gitster.g>
 <CAOLa=ZQXZ6DyE3YjuVU48nQcj0xuW7uPoPvg2yqktk+S6gXwsg@mail.gmail.com>
 <20240710154620.GA3097664@coredump.intra.peff.net>
 <CAOLa=ZT-psS1NecoppGOVdxgn+kMqi8qx2vCLMKNXB4n+5hE0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT-psS1NecoppGOVdxgn+kMqi8qx2vCLMKNXB4n+5hE0A@mail.gmail.com>

On Thu, Jul 11, 2024 at 02:35:08AM -0700, Karthik Nayak wrote:

> > But all of that would be internal refactoring / cleanup on top of your
> > patch. The user-facing behavior would be the same.
> 
> These should work as intended on top of my patch. But I will skip doing
> these changes for now. I do see the merit but I think it is also okay
> the way it is now.

Yep, that is perfectly fine with me. Thanks for working on this!

-Peff
