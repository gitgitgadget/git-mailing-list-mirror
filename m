Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF72D73AE
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506824; cv=none; b=FFSTB+DUaip4HU5CNv4m3EkGXMteyKxbNMj4BBEgjk5xb6TGo0cj4jmFLdl8w7n4DGVEPCIGHdrL6yilxZirAitSrUEs34LEm5+OlwnZBPy2cL9ByLTLRgkfSvDdJ1HC87K/JRAKCISGckqp626WyNS1DdVXLOwsOV4LMv4g6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506824; c=relaxed/simple;
	bh=ojLEobNYFC4u/Go0qVL4PVq8wzZTMzUVTekVFqkaxLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hylpNAcxdfakdF0TS8uTUNPZMlXrLqvewEpTeOPj3+GcMv2gFW1Yz6JpLBE35CjOYd4YwfUJYmmCQ0w1JT+0g4F2KyisBq0+Hvs6RtVLY02THGKsLC11BdK3eMn9RdlalD3iB1FbEMm43Ais6mnCvFIOUzDE00TVJGdxqMZJv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZLVhldHn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZLVhldHn"
Received: (qmail 50371 invoked by uid 109); 15 Jan 2026 19:53:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ojLEobNYFC4u/Go0qVL4PVq8wzZTMzUVTekVFqkaxLk=; b=ZLVhldHncB2F0SC1Nt0tDdp0fVpzs5Bii2n2Kr7JK6X7gYpqA7TYP3o4TrniSSCb/pW/MEHuptc2scYZZE+3lp4RlHZWxTgxJD8VRnWbemQgBzX4YT8gNFv1Z8I44O9ut+FnR82AeFZH7JxKVjpN7xenHyu+bEgfRh0Ws3pfI3GaIUKpxuYa/ZF8t99Wgt3jINIyBDfi5oQGo6XPf34X8NATUZUXG5Uz3VH7pqQ8bf0EHiQGX+HGIQ6ULGXRO5DG9YmdSrWG1N11bETHQgQS6TO8K8a378SJXj2p0zLdu0TDgdX9PYhc6S0Y+TZKmLD3PWxQg5snG2zGsJGWe1KKJw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jan 2026 19:53:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 82405 invoked by uid 111); 15 Jan 2026 19:53:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jan 2026 14:53:37 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Jan 2026 14:53:35 -0500
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v25 2/2] status: show comparison with push remote
 tracking branch
Message-ID: <20260115195335.GA1053259@coredump.intra.peff.net>
References: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
 <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
 <fa744efc598cd902e9a3a4a17b24134351ca5803.1768306316.git.gitgitgadget@gmail.com>
 <20260113170321.GA265671@coredump.intra.peff.net>
 <0037e6b9-e57d-4cd3-b156-c8cbf439347a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0037e6b9-e57d-4cd3-b156-c8cbf439347a@gmail.com>

On Thu, Jan 15, 2026 at 10:31:41AM +0000, Phillip Wood wrote:

> On 13/01/2026 17:03, Jeff King wrote:
> > 
> > Can we make this configurable?
> > 
> > I build my daily driver off of the 'jch' branch, which now includes this
> > series, and I've found that for my triangular workflow the ahead/behind
> > for the push branch is just useless noise. I treat my push destination
> > like a mirror, where I always just push up everything at the end of the
> > day.
> 
> This is a slight tangent but if we're taking about making things
> configurable I've never found the actual values of the ahead/behind numbers
> particularly useful. In a triangular workflow all I'm really interested in
> is whether (a) my local branch is behind the upstream branch and if so is it
> going to be a pig to rebase it, and (b) my local branch matches the push
> branch (i.e. do I need to run "git push"). I don't really care exactly how
> many commits ahead or behind the local branch is, the counts are just
> distracting and don't really answer the "is it going to be a pig to rebase"
> question - the only way to answer that is to try it and see.

I mostly feel the same way. The only time I recall thinking the numbers
were important is when they are wildly out of place. You "git checkout"
a branch and it is 1500 commits ahead/behind or something, and you know
you've screwed up setting the tracking branch somehow. ;)

> So as well as configuring whether we show the comparison the push branch it
> would be nice to be able to configure a simpler output as well. That does
> not need to be part of this series but perhaps we should design the
> configuration to be extendable.

Yeah, I agree with all of that.

-Peff
