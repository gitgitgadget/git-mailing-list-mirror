Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98511B3956
	for <git@vger.kernel.org>; Mon, 12 May 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057821; cv=none; b=Zj53WVMZjiuC99N08rFbt3zO0xst2ciWx7KKRLNkShAM0MmtAgxY8WVUwm/hkKmv844RmuOJeIQS9g2adEfHIfi+9PhkqmXuKe3QeGFU3NvCimTS9ORYwtWpIhhLRSA+5fpjV2y6Lh0iKsGH4GW6yf1esjBJd7cpY4tmIOt7MJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057821; c=relaxed/simple;
	bh=NxJLPop+P6nVAtmFe2/ypEANfn7ky66VmlTCyjEGcEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcA3D8mpyhu8Y+PqTSuMEkIAUIFgJievtIwvligMEG+PIycc1HJ0vcYkTpXHGrcJPIhd8JiIcLLMJvSKhx84Nk55OHPldBOxgIDsxXsPD7KQHAV+UubMX8F4lsbkdyy7CWnkeNUSU+7vVtdlIIxc7yly3LEousTk63EN7xyDz4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bYzHBQ9b; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bYzHBQ9b"
Received: (qmail 1903 invoked by uid 109); 12 May 2025 13:50:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NxJLPop+P6nVAtmFe2/ypEANfn7ky66VmlTCyjEGcEY=; b=bYzHBQ9bhcwbUjEhaZAtZ3vzoSlquu9iA7GJOCuhXwAV5wYjG19q9kjgWJeM6AtAbOSFeItAyPcp/c4eLPcWYnHnYWZqS/Ci0qH7HzFFgb5ot6ZdsAl9q0Stp9qyYBFrTAQS6ddql//n4E2WDTuUYtKtVDAP7EO8M1qIZGSQu+H6Nv82yGepdbje/mIAkjC9fNZPTrZo9XK7nvAUkPr0eULIDyAO81zsuWS6aHmGANbVjmy+5wfe0PNvZIP0oeprHE8ZPYE+WcwdjOL0hdDpXO1BK/CjkSvj79q32eXsPMoSh+AVu6PRRnn5xs92d1cuMrS/XLTRN2XPNs0NH+0DMA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 13:50:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6745 invoked by uid 111); 12 May 2025 13:50:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 09:50:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 09:50:17 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/"
Message-ID: <20250512135017.GC1191957@coredump.intra.peff.net>
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
 <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
 <aBhZHA7av8bWH9Ac@pks.im>
 <xmqq5xieq3fs.fsf@gitster.g>
 <aBmg1_wlF2fuk96M@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBmg1_wlF2fuk96M@pks.im>

On Tue, May 06, 2025 at 07:40:39AM +0200, Patrick Steinhardt wrote:

> Other than that we also have some bits and pieces that _are_ actively
> maintained, but that just don't have a better place to live:
> 
> [...]
>   - Diff-highlight.
>   - git-jump.

These two are due to me. I don't have a problem moving them into their
own projects if we want to clean out contrib.

I think diff-highlight is something that _should_ eventually happen
inside git-diff itself (because it would be more efficient and we could
do a better job). But it wouldn't share any implementation with what's
in contrib/.

>   - Credential helpers.

These ones are tricky. In theory they could be spun off into their own
projects, and we already have examples in the wild of things like GCM
which are maintained totally separately.

But I think we may need to find people to step up as maintainers. In
particular, I think osxkeychain is probably used by a lot of people, and
probably shouldn't just go away. But I don't know how the maintainer
would be. I wrote it originally, but don't (and never did) use it
myself, or even have access to a macOS machine.

-Peff
