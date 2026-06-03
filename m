Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E7388395
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473241; cv=none; b=I+vOyEJov2njahVnuwy9bOt0Wl2T0E42RQjzTZEXGrgmBwmZMVztyAbQYlM9dhEDuVsxXlPQpl9e0lS4kjFBAnHqvKSvKidbuJK3nyKkNzT8fnGS+/amO4RpNZpQTV1ThzwU2zTJFaoa2GKBAo6LlcDSvVzAV0o13kax1PH68lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473241; c=relaxed/simple;
	bh=8NLWIJzDaGE2BVKV9e8iHStI/2bt81ZTm1WL4t+Ci5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnnjuelZlmD9K3ACRjcRSsJt7vbI+jVLsjcTk8mfG5QHhQzF2DQl44uuF+3yWkUMlts2xNv6UDEIZ8FcmXq3kdJiN/DvVmRlhL5yhNkn9cj67+Ol8aHT4sxm58+lGl4fRntK1JsW9lQcZ5Qqo+2X6Mm9VDLBfcmC+VFvYZqQIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=LrZPPW7/; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="LrZPPW7/"
Date: Wed, 3 Jun 2026 15:53:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780473238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf5G8uiwa8oaXe/tK83av8Vnh0xkDMHHGDLFA82/9gI=;
	b=LrZPPW7/tAWgAsHGNmFxm/4OCV43mxYgX2VKc117PaJBYrPHWqcnCDHiDnPFUE319Sn+Mb
	tVrHw3ZEJxojeL/JNYYT626vF86Kbhf0VJjoHENMdHqvGQtQca/WNzCOegp3hCjtVboksp
	7kosmnrcduu6fO9gHnzcSDa1dpuY+KqgZw8b++KIVn11Ip//Kl9WEvpqIZVIAOfaCGXDnH
	myLHHeth1HkTJGl43KmfVYTUYCz85Fka0pvNlKBgPFA1n+ABAK2wcq4J7GFxKutqde8uBK
	Gve1kinxVftHGYPLowmkuHoyb+N8OqhMZHwcDp/GH45WxfpIvqATZsnvARR3jQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/MyFirstContribution: recommend the use
 of b4
Message-ID: <ah_dh3uozNdYcL0_@wyuan.org>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-2-a7ae5a49e9cf@pks.im>
 <ah8ALHMDVA2Gzz10@wyuan.org>
 <ah_PwOsbYfDCx0H2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_PwOsbYfDCx0H2@pks.im>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 03, 2026 at 08:54:56AM +0200, Patrick Steinhardt wrote:
> Ah, that's what you're hinting at. So you mean to say that folks should
> first understand the basics before basically automating all of the parts
> for them?
>
> I guess I can see where you're coming from, but I'm not sure I agree
> with this a 100%. My main goal is to make it easier for new community
> members to contribute to Git, and that means that we should automate all
> the hard parts as far as possible. This saves those new contributors
> from frustration, and it means that reviewers on the mailing list won't
> have to teach every single new contributor about how they should thread
> the mails, generate range-diffs and the like.
>
> So in the end, it saves both their and our time, but the learning
> opportunity is of course a bit diminished. I'd gladly accept that
> tradeoff though.

Yeah, after I expressed my opinion, I also felt a bit conflicted though.
So I also agree with your intension.

Make an inappropriate metaphor: some usage of b4 and magit are "Porcelain"
to Git. Whether how you are good at using those porcelains like magit or
lazygit, in the end, you will eventually have to face git cli one day.

So the same for b4. If we list these three methods equally and
simultaneously, the logic might be not that correct.

Your proposal:

           contribution workflow
                    |
    -------------------------------------
    |                 |                 |
    v                 v                 v
GitGitGadget   traditional email        b4
```

But I would frame it more like this:

           contribution workflow
                    |
        -------------------------
        |                       |
        v                       v
 GitGitGadget        traditional email workflow
                                      \
                                       \
                                       b4

For exmaple, If I am at this page the fisrt time:
    https://git-scm.com/docs/MyFirstContribution
And, I see these 3 ways, okay, I choose b4.

After installing b4 and reading some manuals, I would wonder: what's
cover letter? what's Message-ID? So after a while, I would still have to
learn those stuff and how b4 indeed optimize those complicated process.

So, to put it another way.. b4 is developed for high-level maintainers,
who are apparently familiar with traditional ways. Therefore b4 saves
their time. But for some beginers like me, I still have to know those
concepts first.

But yeah, there are definitely some people would happily accept b4 and
contribute easily. Thus, I agree this tradeoff.

--
Sent before reading v2, hope there's no conflict :-)
