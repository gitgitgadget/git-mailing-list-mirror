Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA673E6DD4
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810328; cv=none; b=TuYPsUlV8vhusisTj1sXN1tGJ5wrexZCXVPEtsLTukh6eikP9MWuLBF9NLJJ34LRmQYfUVCQz5Za1AX4zaB691Vroqvtm8w/0YMd07YQv9QCBj0zB1ZN3RbQzTPfR2Vgi3cpWAHQn1/sC9DIzUEK61pX4YETx7zw3bzNrn5oANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810328; c=relaxed/simple;
	bh=nH27Yczq0fImUYLaB0B4bXnmJ16fPj6YNy8qIfNS6bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n57tcvTLieC72qaCuFlQ9248S75wD8vvfGDC+S5UbJ9nMlSBe6XFnZskwQ0xmztNEuV/FMWaf6H6fIuVGYZp96I7i+7qxhwDi9WmR/MSK1bTfQKaRboHYrvp47lQEZ89FBV0MtD1Nqf8xxRuEb80B8pYO9jVyjQcdPVgaKh8ZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q6ZhRIwD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUl3jOfs; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q6ZhRIwD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUl3jOfs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B7181D00126;
	Tue, 30 Jun 2026 05:05:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Jun 2026 05:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782810326; x=1782896726; bh=gofkZA267d
	Mkh1fD11KPriwQjlhZZzLPjNXMMgRZr3Q=; b=q6ZhRIwDSMGLpsDhd0O+rzoeac
	rdXD4PNmRpciYK40PiDipnQkvVoBZEhR+uz7yzso7f+ykQSJXq8POZiMXa1XH8df
	pYnZ8zC20eSqUuGfcR1nGswLakK5oe02DA/3VUQOaF+567eY/g0VIKM4cwO18s4u
	rW2PISLZFkjByQkjr5g/6uCuPn80L/P175PAlVPlkzaCzb5+gQ5FaSOxbVAPA3Gb
	OFmXgegRKSWNgkf8f/6dRsux8atd7SVIRabaX8lX2fx1FZ2YVs4b1ygzJfYuJiqM
	CuE8anR6AYCsCZ2iL1BTu3AnwY3CKmvO+YEX4LtYRndTEFPrYebhB2oMTZmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782810326; x=1782896726; bh=gofkZA267dMkh1fD11KPriwQjlhZZzLPjNX
	MMgRZr3Q=; b=XUl3jOfsMqMeVe47rG6q0IkRC8McJptPx+BEKBnPZfHZ0JLEbzD
	3Po/1gnmyHzQ7HAhrd0KubbKyIiL+0Ia3iB1YfTVFd3KQY3OvG4//SQl3do35hCA
	HZ15wTeX7ikPoE72G9gTEUxaDmdzIzNQTG7CD29AtnHen9wMb38IvQgR/rbMGnIk
	0eJ+SU/cu/FOf02S45oa5iezYaQG2xCOOvRxTvjGGc63oSlJC6/uIFpCyBXh/2el
	LHnyEITXwG4BspaZKWD7OQD87ExgyFYTOe1BLidpdYCJ3t4LZsEjeCrlx6cqhOsX
	jHuFDbzzgNVG31no4rUjccsCdJUyI+S9I2w==
X-ME-Sender: <xms:1oZDauZOjyPsFydyb6vt8IDbS_X5QWIRfyAX_2DkKCXHebN3QpsuZQ>
    <xme:1oZDaob8HXj3aT-IC-PBSm4geFltOwIQck7Y54z8mY6Araq97IGgMsmwunV_icNbx
    t-YyUMKXIlsBxMz7o_8XG1pit4m7s4a-DfDGOFDv-QMx8OZbeem>
X-ME-Received: <xmr:1oZDat_2FoPVzZLQEq32UvHsgEbCLkMR3K2CDy9kLWQcuboqqOsRfhvbDOatdcD93WgC5pLBdQIavnvgxNl_eeBu4FcncyhvXjEAlXMuEBczag>
X-ME-Proxy-Cause: dmFkZTEYrxH/Mp7C8KDKzETReCZfJIezUciv8Mtp3JMmOLa6qjd2qOrkUp1+OG7UfSDztj
    wd6kkNLSVn7xkGhP93Tk3/sJRgTHydXDapXs5ba6syqSGCFIPaR4JgY2ZZ3sgrnpovRRDe
    qI3NM37h0Osvs2SXBR6A2aPAv2iFR4gEj3NCfFuud3MMVa7kDmc4/uQ9xL5GUTUQU0DZDh
    /fJSInGOUom5BeiIfFDxgKj3sCT/5Uc5hmf9yC/Yod6aNViRPhDvj7nPgKln+y1+uZTtxE
    O38uPLTVPNojAyaP5H7RcJEAU+dkgV+xnnuG98BjaGb/J7ToLCpFUt1HjxKiHUjs7PUTCw
    8u6wsC36MqhUCYPSP0t2cnvMp3BXnklGDlSjqk2UDwmu4AtWvD2MO5IHjuCp00M7j89a42
    tT8pKEfT7w4ME0r39EydfcRUH428lxbvn3xgW2yBZa/m/p8S8lL1tb7WrFDmGvPMuJZJE6
    J3piJSghQahygnqs8YSkNz40HL5lFcRi87PH5bCC8BEOM6ZvalRKsVMbvDXLaEpRv+AKSx
    bzbYTJIhilvbMNkCYl/jWZbQZxzw44JsYqX6r4wYCwJh9kprYHEc7KzONuOAAaq46eS4+c
    or2Fudol/Nk9K/Y7GALrVdlpXKAEzxwv4HRXdM4itkqSDrO0quwUPk0mswSg
X-ME-Proxy: <xmx:1oZDaviER0PuiyQvM9qkO8skrHlVRnF78ifx_hAofJxryamM5AmFhg>
    <xmx:1oZDalejyzgGoG_o0nIzPJzyHmmYzPp1tqk9FeXYTSLxVwqZ_FP20A>
    <xmx:1oZDauoDP3iGS0ZC-M82pwrVDuqfelbfs8kXh6cNhxvwJdDrcsKEvQ>
    <xmx:1oZDaiD6-9-ujD8B-EF7Bu8nWWTCc7Ccvv06bXy3DJ_h3VQIjlpDTQ>
    <xmx:1oZDar7_J4MkQO7ukyEXDQj65bZIdm5puwNfM9UN-1q7k1L85RSnQ1tR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 05:05:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79037d54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 09:05:24 +0000 (UTC)
Date: Tue, 30 Jun 2026 11:05:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t5551: pack refs after creating many tags
Message-ID: <akOG0oMu2KTqqyW7@pks.im>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net>
 <akIJQbOUbdBbkTef@pks.im>
 <20260629203527.GA1895313@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629203527.GA1895313@coredump.intra.peff.net>

On Mon, Jun 29, 2026 at 04:35:27PM -0400, Jeff King wrote:
> There's one other thing you might find interesting. While poking at the
> timings here the other day, I noticed that reftable is very eager to
> stat the tables.list file. Try this:
> 
>   git init --ref-format=reftable
>   blob=$(echo foo | git hash-object -w --stdin)
>   seq -f "create refs/tags/foo-%g $blob" 2000 |
>   strace -c git update-ref --stdin
> 
> We make 2000 fstat, which strace claims takes 85% of the time. I suspect
> this is over-emphasized because strace inherently makes syscalls slow,
> but running with perf also highlights it as a non-trivial cost.

Yeah, this rings a bell. If I remember correctly, this is because we
call `refs_resolve_ref_unsafe()` to verify whether the target already
exists. And as that function is generic, it wasn't easy to optimize it
by reusing the already-loaded reftable stack.

> It has been a long time since I've thought about reftable internals, but
> it feels like we ought to be able to take the lock and then trust that
> the stack has not been manipulated.

Yeah, that would certainly be an option to explore.

> It may not be worth digging into too much, though. I can make 50,000
> refs in 150ms on my system, which is probably good enough (especially
> compared to the files backend).

True, it's going to be much better compared to the "files" backend. But
that isn't enough reason to not optimize it even further -- doubly so if
it actually takes 85% of the time. Sounds like a low-hanging fruit to me
that can result in a significant speedup.

I'll probably not get to it anytime soon, but I'll create an issue to
keep track of it.

Patrick
