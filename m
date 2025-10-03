Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008670824
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759461493; cv=none; b=K+aZAkzm0qNOEEqAFKUYdzlIvuMiEuR/MVWYvjUBmQw3IBZ0ynxAPqsez6/aplA8S1bBco7sTAzBCLADimV82joB0e1V8OqmkTC/3/cGM8+7H+MfDZjjSD2uxVmoW+xx2McNQbGOzNwQGhKzBSgyaoUxch9iP0G27Qr8/X4oWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759461493; c=relaxed/simple;
	bh=FQL65NUXvli+DhqdtquyFh5jZ6OXEXbFPf0dXqg4Ly8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzHKMay6hZ+TGrbiKoiihVlQbtS1XIfsu3wivDC6Hk6kQBNdIvvLA3eTaqvCCnqcjx5KFya5Cx50MoY1oMWcuBGOHTqYcOWdeUGHX/64Giy6izIl78Z47EJSGiM0dKUkwiSeV1GUl4+a+f7cC+3SufRDoVuavtabfMfIhhvbJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YFjs0tU1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YFjs0tU1"
Received: (qmail 112420 invoked by uid 109); 3 Oct 2025 03:18:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FQL65NUXvli+DhqdtquyFh5jZ6OXEXbFPf0dXqg4Ly8=; b=YFjs0tU13Us7WPzTEFhSAPxrl5ti2tFTat1PSR8OdCc13EDo81Ln4uPe1eBzjiZ5VILkcYCSLUbkVo7sIhC71NDEREY+B0TrIHoMrCl7m09tYpbWWfXT1KVVctlKV5ZvWId56hERhTW3UWx50tPIeTCWtID/nS21s5hbzWnMJodtMXL08WyUtC0DEwe5Q+vdhsvbKIoSP9aLV9kNkKKN4Vp8c+EwH0q0UDE1RyAiFLWps7yiN3iqBgJw0TzOnmj+pAAzkiCBY+CjPMG/0KrIXSvvJr06UB2Bgv+ZgqDf6M5+eQE3TXRNwxkhb2MtIZSjRxo77SjGlZhu6EF5Kc6E+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Oct 2025 03:18:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 161580 invoked by uid 111); 3 Oct 2025 03:18:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Oct 2025 23:18:06 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Oct 2025 23:18:05 -0400
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
Message-ID: <20251003031805.GB6381@coredump.intra.peff.net>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
 <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
 <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>
 <20250923174825.GB1136654@coredump.intra.peff.net>
 <bfaaf26f-5759-4812-9057-b3e0bf7c7949@gmail.com>
 <20250925022555.GA3202669@coredump.intra.peff.net>
 <20140030-6bf1-4393-a941-bfdbc69c79fb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140030-6bf1-4393-a941-bfdbc69c79fb@gmail.com>

On Fri, Sep 26, 2025 at 11:06:38AM +0100, Phillip Wood wrote:

> > If I understand the suggestion correctly, it's not to license it
> > specifically to GitOxide. It's to use a permissive license (like GPL
> > with linking exception) that would make it compatible with other
> > projects with similar licenses (like GitOxide).
> 
> I was responding to this paragraph in Johannes' message
> 
>     Note the exception? For new Rust code (and of course excluding code
>     that has been ported verbatim from GPLv2-licensed code), GPL v2
>     could be used with an exception along these lines: This file is
>     licensed under the GPL v2, with the exception that it can be freely
>     used in the Gitoxide project.
> 
> That suggestion is pretty close to what libgit2 has in its git.git-authors
> file[1]. I'm not sure how practical it is to special case just one project
> though.

Ah, yeah, I may have misunderstood the proposal then.

I don't think that really changes much with respect to my concern, which
is for existing code. That probably needs to be explicitly granted
permission to relicense, whether to a specific project or not, and it is
hard to pinpoint a definitive author for a lot of it (even if many
authors have agreed to relicensing) because it has been touched by so
many people over the years.

So there are probably two separate legal issues to consider:

  - how the explicit re-licensing grant is worded

  - what problems may came up with porting existing code that has been
    touched by many people

-Peff
