Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CF42847B
	for <git@vger.kernel.org>; Fri, 29 May 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088453; cv=none; b=MvQmlcQvCN+NOyMUwtaz4+cJzJ/Or32K8GxxaXrqWuAlTjorHCPagYdS+FCloHIslqn4iAW2pQvl+tYXFg9r4s71ZJzKz2BMVcItemAqTODeVc1INMwtT1HNfhwOUp9bIxayDMFXyaTliHxccJGTIVE6M2oyKBr97ZeTKZn/f0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088453; c=relaxed/simple;
	bh=TXd7J0AeI+kQlzPpdUB0ERY+lGTlrtCN2mcHZaAHXWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeNxk7DTfaMY4xjPpxUp1GvwFmh5zWPOhQklt2N+oURjzagOsAotD9s0sMgNxR3HhG8Y++uaE8ZJgxZ9Rn341d4Ies/qt7QVvT5NJZfoP0AZHhAunyo14TkCzgq4DrUO6EftTShfYKjgELaVNhq+bzhIVNozr1cUHnXRlPqOHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JIKOfmxC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JIKOfmxC"
Received: (qmail 10165 invoked by uid 106); 29 May 2026 21:00:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TXd7J0AeI+kQlzPpdUB0ERY+lGTlrtCN2mcHZaAHXWo=; b=JIKOfmxCQKrygHYnCbnXJWjCoIWqN5qBJAay97phnszejqYcMnRA5bKv2+0k3nl8ACLAVsNUujckKiT2tROddwCKEdnlYiiSEu0wKvUkSHPU7iBIb2heTrPOcg/r/4OWDzgB1Fw4hklZONb1Bw3wyJ/F98BC1FmkiYaXYfVtL6C9w1fD0ywb2bHLsQbxtC3ak1Vm2buaob/QO8CZhJ6MefbA3V3Chg6eMp+9z/NyP8HUChYjTWcKr98SOHM15cNesGMjtrQU7N+CXww8+cME5RLGUG6ABG1XeWsM5rgK8ob+d9lE/0pm3NOCRr6VkU2rRlCa51fOAePNs9lXK/f7rw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 21:00:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18956 invoked by uid 111); 29 May 2026 21:00:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 17:00:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 17:00:49 -0400
From: Jeff King <peff@peff.net>
To: Wesley Schwengle <wesleys@opperschaap.net>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Subject: Re: git hook question
Message-ID: <20260529210049.GC2628906@coredump.intra.peff.net>
References: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>
 <20260529052141.GA1099450@coredump.intra.peff.net>
 <c5527d8c-9147-4355-a07d-153d3977108e@opperschaap.net>
 <20260529192350.GB1711766@coredump.intra.peff.net>
 <4d938e1e-fdd3-42d6-a879-4d394ee8c00d@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d938e1e-fdd3-42d6-a879-4d394ee8c00d@opperschaap.net>

[re-adding list cc; let's let everyone benefit from the discussion]

On Fri, May 29, 2026 at 04:14:33PM -0400, Wesley Schwengle wrote:

> > I don't think the hooks themselves should need to be aware. If somebody
> > is calling "git hook run pre-push" without providing arguments, they are
> > breaking the contract to the hooks. You can get away with it if you know
> > your particular hooks do not care about those arguments, but in the
> > general case, what should a pre-push hook that _does_ care about the
> > remote name do when it doesn't get any arguments? It's an error.
> 
> Are they? The manual says this:
> 
> git hook run has been designed to make it easy for tools which wrap Git to
> configure and execute hooks using the Git hook infrastructure.  It is
> possible to provide arguments and stdin via the command line, as well as
> specifying parallel or series execution if the user has provided multiple
> hooks.
> 
>      Assuming your wrapper wants to support a hook named
> "mywrapper-start-tests", you can have your users specify their hooks like
> so:
> 
>          [hook "setup-test-dashboard"]
>            event = mywrapper-start-tests
>            command = ~/mywrapper/setup-dashboard.py --tap
> 
>      Then, in your mywrapper tool, you can invoke any users' configured
> hooks by running:
> 
>          git hook run --allow-unknown-hook-name mywrapper-start-tests \
>            # providing something to stdin
>            --stdin some-tempfile-123 \
>            # execute multiple hooks in parallel
>            --jobs 3 \
>            # plus some arguments of your own...
>            -- \
>            --testname bar \
>            baz
> 
> There is nothing about the contract of the hook, in fact, the way it is
> written there isn't really a contract.

This is a made-up hook, so it is up to the person defining
mywrapper-start-tests to define that contract. And in this example,
implicitly it takes whatever is in some-tempfile-123 on stdin, and
--testname as an argument. What those mean would need to be communicated
between the script invoking "git hook" and whoever is configuring hooks.

I agree that is not made very clear in the documentation, though.

> > So whether you are getting input as arguments or over stdin, it's
> > probably something the hook needs to deal with (or at least think
> > about).
> 
> Right. I see where this is going. That means I think the examples in the
> manual are incorrect, no, that's harsh, it could be stated more clearly in
> git-hook(1).
> 
> Examples like this:
> 
> > [hook "linter"]
> >   event = pre-commit
> >   command = ~/bin/linter --cpp20
> 
> seem to indicate: Any script can be run as a hook, the fact it needs to
> respect the native hook structure isn't mentioned. This is mentioned:

That example is OK-ish, in the sense that pre-commit does not take any
arguments or receive anything on stdin. So you really can invoke
whatever program you like (though it needs to understand how to use Git
commands to look at what is staged in the index). So the details of
"~/bin/linter" are doing a lot of the heavy lifting here, which is left
unsaid.

But the later example that adds "event = pre-push" is actively
misleading. How does the ~/bin/linter script even know in which context
it's being run? In the real world you are more likely to invoke a script
that is aware it is a Git hook and can react accordingly.

So I suspect there is a lot of room for expanding the documentation and
explaining some of these gotchas. +cc Adrian, who wrote these docs, for
visibility.

-Peff
