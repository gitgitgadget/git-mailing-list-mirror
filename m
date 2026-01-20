Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97742350A37
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938014; cv=none; b=eBDvK6/4MhScdFC1EdGxnNt4rYJl12ibktV1vUYa8erE5NUGlubzPTw9AHudAxSo5cYGfTj+szf40rl3Ba1bxSt4MlfZ/pjwCIjDfMQHM9aDG7SUktO39/pyBhMUIFqt2TBxANdai3xfnYVW9bR3YWG42IXsGfww2qvjvamCejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938014; c=relaxed/simple;
	bh=2IvSkksFzqUgxWZcY1uQzBx4H0GU1lzBGPOE6OXkENA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtRuh83u/zdTYFZF9XF3kZnBVnLrZGRnz8pP7eHFYasIV3dTiiMHgUTFSb7zn03xd5c8ybqAISbhbHqwLtX2hquOAk7FCYMkEm/kIuts5aDbsyJsg9puyrgu1t8HmsRv1Ipbp0KD9hSI3HfTsu1OqtxNZrI9agWrN+QA3SCi5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MThndKG2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MThndKG2"
Received: (qmail 116993 invoked by uid 109); 20 Jan 2026 19:40:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2IvSkksFzqUgxWZcY1uQzBx4H0GU1lzBGPOE6OXkENA=; b=MThndKG249M9GfhFvzQxTwgyTNvBlIQKWe9d0zq0doCPvc1iv3UAR8IpeBds2koUfb/cC1qy2qz21vSa+S5fM0lLLArBGYoGKozZm2gjGFSSSSezSWEd3rRdNZ3jHq98oPLsVDyKrUtHq4XhLFyzaaL7EJmDgc5R/pCzmciIEm1dPH84wrKVzZCYw7GM2vyvN8rZNx9PbOuyFam6YWnvVh4bylUOp+e2niRJgYQ3ZrL9908UTueg1i/R8fiAxu0FNOuiYbK/60ixyjWw1wHULwsoJv9L+7G4GM2yc2sbtyRFwP1sID+K5tS5H+mPxYZdTZozfrxpWnPLgPqPQKBrMQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jan 2026 19:40:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 184148 invoked by uid 111); 20 Jan 2026 19:40:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jan 2026 14:40:12 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 20 Jan 2026 14:40:10 -0500
From: Jeff King <peff@peff.net>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Triangular workflow
Message-ID: <20260120194010.GD3295894@coredump.intra.peff.net>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
 <20260119150413.37807-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119150413.37807-1-haraldnordgren@gmail.com>

On Mon, Jan 19, 2026 at 04:04:13PM +0100, Harald Nordgren wrote:

> Would be nice to get this merged ASAP, so I can continue the work on my
> feature without the memory leak there.

I imagine it will not get merged until after the upcoming release. The
usual thing is to build your branch on top in the meantime, though I
don't offhand know how good GGG's support is for then sending only your
patches (you might need to build your PR against the branch that Junio
created when he picked up the topic, but that is only in gitster/git,
not git/git).

-Peff
