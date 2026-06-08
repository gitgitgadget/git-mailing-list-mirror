Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14473403ED
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962079; cv=none; b=SVRUkG0nVC3Ll3Nw1os8M2QTwrrt8YbktUDPEmrC/66rxKgPtvj9xo9pCMtlQ/QDvqyfWGR7mz47fgUjVW5vjuwH8cK9OKD54krag9EsAZVGohUqr/QEJxGg2BDkOJKKbHoV2xhUDJ2L7QdUXCiqaOKQQ7zbxzePAQE5BJyqIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962079; c=relaxed/simple;
	bh=YoLFGyTLeb2dW+6EK6kskdTcEyyUnnoAidjqYomcYmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLgZTy8yEOvcGo8hsEyqR3iWC9MzLqDkgvKJP93O5UJRq96xMkTXrSUxNtSUkqTTCXbCv3+ZMLq2efhg7HPgvSlTAE9LkAvoC8l8PdnK2HPiYKkAiW4h6I9f7tY8JpW/7/oxkUy4b5xT7sp13ap9F7vvgLbUFf1yVGQ2CglVzAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aQZM+wjN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aQZM+wjN"
Received: (qmail 83837 invoked by uid 106); 8 Jun 2026 23:41:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YoLFGyTLeb2dW+6EK6kskdTcEyyUnnoAidjqYomcYmY=; b=aQZM+wjNGrvvNm1TLP8K3LqJ5nXdaKtZHyXUlnUFkpyNixo+C2SUBdN+aFYhPL2t/Z7td3ZHSgnTgRX+PywCNSAGhFR8C6S7poSnBF/B48Tj1Oc+rSJhLP5oPzbUfLahtE8MwSgdEbCFWCcSg5O5OqPfMGphjRwbVAKbU8rAFvli8uQsOlGDqKhWWjtpDvW29A1jAyOPuDjsfDoTMJPTUUp7ZrCWBBRXK9JHM/v9Q1iivXVT3zdCAu4YrZ1pzIGRtXSAA4L16+43hFcKbub85l1qDZluYNIgn8PPoC+GWKlFwTX2Nf94YMIHAmsguv6jMVZ3piI6hfC97JwE7INcqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jun 2026 23:41:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 245314 invoked by uid 111); 8 Jun 2026 23:41:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 19:41:19 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 19:41:16 -0400
From: Jeff King <peff@peff.net>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Benson Muite <benson_muite@emailplus.org>, git@vger.kernel.org
Subject: Re: Mirror repositories for submodules
Message-ID: <20260608234116.GA358144@coredump.intra.peff.net>
References: <875x42vlgv.fsf@emailplus.org>
 <xmqqcxy7qfgk.fsf@gitster.g>
 <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
 <20260604061605.GA3194609@coredump.intra.peff.net>
 <fa075b7a-96f6-4fd9-ae94-30ddf323f759@hogyros.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa075b7a-96f6-4fd9-ae94-30ddf323f759@hogyros.de>

On Thu, Jun 04, 2026 at 06:27:31PM +0900, Simon Richter wrote:

> Hi,
> 
> On 6/4/26 3:16 PM, Jeff King wrote:
> 
> > Here's a thought experiment. What if you put the UUID into a URL, like:
> >    repoid://123456789.git
> 
> Yes, that's the idea, except I would want to use a relative URL, like
> 
>     ../123456789.git
> 
> This could solve the "naive cloning" problem, because it creates an
> expectation that the submodules can be found on the same server, or in a
> nearby path.

I see. I forgot that we allowed relative submodule URLs.

> > Now, all of that said, do we still need uuids at all? If the canonical
> > submodule name is https://github.com/git/git.git, then anybody can just
> > rewrite that locally in the same way using url.*.insteadOf config.
> 
> Yes, but we'd then need a mechanism for a server to indicate "for cloning,
> you should use these 'insteadOf' settings, which is a massive can of worms
> from a security standpoint.
> 
> I also don't think these canonical URLs can ever be stable if they refer to
> infrastructure that is not under the control of the maintainer -- it would
> tie the project identity to the hosting provider, and increase the inertia
> to overcome for moves (such as the current exodus from github and gitlab
> towards codeberg).

From your description I was assuming the cloner had to always specify
insteadOf (which they find out about "somehow").

If they're not, then your choice of canonical URL is effectively trading
off some cases for others. In the scenario you care about, you assume
that the submodules are hosted relative to the superproject, so clients
can usually get what they need without further config. The server
operator and the superproject repo coordinate on the names.

But in many decentralized cases, there's no URL or administrative
relationship between the superproject and the submodules. They might
happen to be on the same server, but even that falls down if the
superproject is mirrored elsewhere. So using some canonical name which
works in practice _now_ is usually the best we can do.

> The common goal is that a naive clone should get submodules from a local
> server, ideally without us having to write some tool to make an initial
> checkout, enumerate submodules, create insteadOf settings, clone first layer
> of submodules, enumerate second layer, ...

You shouldn't need to do the recursive enumeration if you set up the
inteadOf ahead of time. You don't know which insteadOf settings you'll
want, but you can feed the whole possible mapping. How you get that
mapping is unspecified, but if you are mirroring the submodules already
on your local infrastructure, then whatever process does that can also
output the mapping.


Just to be clear, I'm not trying to dismiss what you're going for. I'm
looking at this from the lens of Git developers: how do existing Git
features fit into this space, and which features are missing that might
assist in a generalized way.

-Peff
