Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04129CEB
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896823; cv=none; b=WpyQN7194AaqXappyn5yx10YAmogli/NGg78hUdh34SmC7D51GlK+0HIOwhujGfjI8KoOIYENmzxRSpIcDI42HWEm2hi2e9aNfxDSqHXVihqCmy8DQdAhVJhgZRs5DUV5tl17vLlMyk3L9AiEibBpR03VKL22zd/naT6vX4c3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896823; c=relaxed/simple;
	bh=GawEJOh3MTjl5j1MqGghvK8wt/z/VqU4tftF3GaYNPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdT+7Zy0cot8F2rFkWHFkyTnq2pF0QSwLI5dNiBFfDpBAHEC43hRALvKqpaWVmfK5XT5SrwuF4AxtqBKG3BfD5iQ+4TqjnAglgS0hoMgg/Bm/9lUnblz6+9xVCmJ/tAvpDf7oKUZBsGo2x38AuWk/m5RcjIB47TCPxjTNLuBsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VtzJlmvA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VtzJlmvA"
Received: (qmail 489676 invoked by uid 109); 11 Nov 2025 21:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GawEJOh3MTjl5j1MqGghvK8wt/z/VqU4tftF3GaYNPQ=; b=VtzJlmvANLafLUQYso9aMy1ufjzgpMj+LHepFLgm7gsR+3dJAN/Db7NLRuAdnkKVM8t1WJZ5tK7RQuT3ohrzP0TrcZpLPRBKnXIOkp3L7ZemQaCa5kUlCu03XDpPTOLnPj8doWm+RjNwrCw9fRlaCbepSQE7ESWSx5SnfJ5qH13K9njyviO5i16jzwVGPZLIrZZOWOcAs4E5A0Ol44i0XZbljRqAUJAOn6uNyXSNnIvUpoWxqAz/jEbB3Hd2Eu/qyVjr9eGgCO9lYKPx2X3BicyuDOQAtSboV74AsFmz65MJbEqO+IBjxGxQbP69nhJZ/5gPAw6R6AWdgSdyQV2qLQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Nov 2025 21:33:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 780238 invoked by uid 111); 11 Nov 2025 21:33:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Nov 2025 16:33:39 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Nov 2025 16:33:39 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: ZheNing Hu <adlternative@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk,
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] commit: add --committer option
Message-ID: <20251111213339.GA4053071@coredump.intra.peff.net>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
 <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net>
 <CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
 <20251111191508.GA1907007@coredump.intra.peff.net>
 <xmqqh5v0wcif.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5v0wcif.fsf@gitster.g>

On Tue, Nov 11, 2025 at 12:16:40PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Sometimes it's because I forgot to configure the repository-level git user
> >> config and started development first. Only when I tried to correct the
> >> committer did I feel the pain.
> >
> > OK, this workflow does make sense to me. Fixing up an earlier mistake is
> > inherently a one-off thing, and a command-line option is more ergonomic
> > than using the environment variables.
> 
> Not very much, at least to me.  Fixing up an earlier mistake may be
> one-shot thing but it is to correct multiple commits in one go,
> which would be error prone if you do so with "git commit --option".
> Either "fast-export | fast-import" pipe, or "git rebase" (which this
> patch does not give --committer option, but it already knows how to
> honor existing environment variables) would be used for that, no?

I usually lean on "commit --amend" for this, coupled with rebase if
there are multiple commits. So I've used:

  git rebase -x "git commit --no-edit --amend --author=..."
 
or similar when fixing up incorrect application of somebody else's
patches (e.g., if I ended up using "git apply" and tweaking the commit
message myself, rather than using "git am").

> > Two small thoughts:
> >
> >   - I suspect what you'd usually want there is for the committer and the
> >     author to match. We have --committer-date-is-author-date for rebase,
> >     and conceptually I think something like --committer-is-author would
> >     do what you want here. But obviously it's less flexible, and I don't
> >     know if it's that much easier to use.
> 
> I am not sure how the user experience of this would look like.

I just mean being able to do:

  git commit --amend --author='Foo Bar <foo@example.com>' --committer-is-author

instead of:

  git commit --amend --author='Foo Bar <foo@example.com>' --committer='Foo Bar <foo@example.com>'

-Peff
