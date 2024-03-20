Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACE12E48
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967149; cv=none; b=bxdZw+2z+T7wWrUOsoc5WwOtwRM++ZexY0WYRK+6yMzKoJDHhTKIpzq4NsMdf9cGnm36Yk6UMA7c8odpVj4104Pni8PiWiMaIqJxA0zOqc1ZPWERFA8vtfD1k/3gVtiJRxCJPvoBsXy+3MVCFHk0OPJqtK7ZG4ZNYNFhnT5BPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967149; c=relaxed/simple;
	bh=eFjdeOSJtMokpUWRJ08VSQ+DjRyKAchqqOTCTrfA6a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfbUnnQwS21E95ylTP7Kb75l2IzQIon5cvvDYJM8clmN+Nk5Tjr4EVaZtnzq1SI7/4et4Tgupkzbx1cRujdEW8KKKndUkAKd8a7blVdVkLV5YKNIq3K3Px6jw9qWdci0CPIY6jjW0dINtJz/iPIZdepizTZWcY9mY91s5YW0nxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17941 invoked by uid 109); 20 Mar 2024 20:39:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 20:39:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22260 invoked by uid 111); 20 Mar 2024 20:39:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Mar 2024 16:39:08 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Mar 2024 16:39:05 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Matt Hickford <matt.hickford@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: highlight local worktree in `worktree list`
Message-ID: <20240320203905.GA2966606@coredump.intra.peff.net>
References: <CAGJzqsmy9RcWJeFLkZjCrrhv_y5q_R3yYUMhcyafY3jOUJFxOg@mail.gmail.com>
 <20240320100232.GB2446185@coredump.intra.peff.net>
 <xmqqedc5hsse.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedc5hsse.fsf@gitster.g>

On Wed, Mar 20, 2024 at 07:38:57AM -0700, Junio C Hamano wrote:

> > I think the only thing it wouldn't do is show worktrees that are
> > detached from any branch at all. I'm not sure if that's important to
> > your workflow or not.
> 
> If such a mode in "git branch --list" were written, I would imagine
> that the output from such a mode will include detached HEAD from
> other worktrees as well.  Perhaps something like this?

Good point. I was thinking it only iterated on refs, but of course we
already show a detached HEAD in the main worktree.

-Peff
