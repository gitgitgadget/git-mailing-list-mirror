Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272A81756
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909306; cv=none; b=KTcTdDIhzZoFp99bOjpVZAVrQ10D7s4wKJmQO1rjSF6Qz2nYkPv3uTiiYNAa+cvvkHinRSYtsrkMh9dP5sae/kpi5FnCbIqRTKY04HBo8HLpO/+xqWQO5AwvsefjFAJ89RKBDfnLq91e2mG6vVYSDdfE7jr5WLsg2rncGE1wzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909306; c=relaxed/simple;
	bh=0+ZIMHWvrs2MPzvNRXFy2zeZ67jfDEGKh+nAILnZP5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2YxGi+My7Vk/L77mUyGlsv+4Wo2DPjXp8GR+XrjC00xyWTAEuB1bj3qenBzs9HA+zG9xyvspSdGpBw/U/klZXd78h7HnprPYUfB/Ili5IBENDKzE1IMkiiE/g2Mgo6AZ1fzQkwvHNCjJAekBY8EAhOafsmapBrR6R43ycwsrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Jv0bachS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Jv0bachS"
Received: from cwcc.thunk.org (pool-173-48-116-13.bstnma.fios.verizon.net [173.48.116.13])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 412LS9h0024889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 16:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706909291; bh=JUiBSq7b/bGl1XFQ4ITh4dBmd1grrTvo3vCyzSTpOnM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Jv0bachSbJRCt5dWMCtT2GlL4sJ6MpEXo9lDaI21U9tO9KSFdPZbybll8vrSpaZT9
	 zrvwt2T41ycoc9nNYYOfCAAKT3LE7M8FOkb/f551bkgHc+kwKuy4Xr2y/VhOUbHyGY
	 7FseM801XBHPiUM0FjJVzKBgOS38B1a7/tg+6JFnsFDfcypLrvFPJwxZoggbdRzwUQ
	 h1yjSSV0iRWYSUvI5ou6dSOfROJK4ei82yIyAnEetTss+B7FkwCkjAtwSPApei1zkC
	 XFsbG8OpSCUVffkriJuo41IBBhOt+qGc9eOV5JjeP/bR/jeuarFvwr9JeuzjXm1kUf
	 r1+zX/AAGrMfw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7E1C015C02FC; Fri,  2 Feb 2024 16:28:09 -0500 (EST)
Date: Fri, 2 Feb 2024 16:28:09 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, "'Sergey Organov'" <sorganov@gmail.com>,
        "'Hans Meiser'" <brille1@hotmail.com>, git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <20240202212809.GA36616@mit.edu>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <877cjm53bf.fsf@osv.gnss.ru>
 <008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
 <20240202161643.GD119530@mit.edu>
 <xmqq5xz6sn5i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xz6sn5i.fsf@gitster.g>

On Fri, Feb 02, 2024 at 11:04:41AM -0800, Junio C Hamano wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
> 
> > So from an open source project perspective, which is primarily run by
> > volunteers, each open source project has to make a cost-benefit
> > tradeoff as far as the *project* is concerned.  Individuals do not
> > have a fundamental human right to contribute to a project.  Hence, the
> > open source project doesn't owe an obligation to spend a huge amount
> > of effort supporting some kind of forge web site just because some
> > potential contributors are clammoring for it.  Especially if they are
> > saying that they can't be bothered to follow the mailing list traffic
> > because it's somehow too much.
> 
> Thanks for saying this (even though with my Devil's advocate hat on,
> I am not sure how strong our "this is run by volunteers, so do not
> demand" card is these days).

Even though a lot of open source developers these days work for
companies, it's rare that engineers get to work on whatever they want.
More often than not, open source developeres are asked to primarily
work on features that have a tie to their employer's business goals.
Different companies might call use different corporate-speak; for
example, perhaps on e company might use "year of efficiency" or
"sharpening our focus", but the reality is that companies are asking
engineers to spend more time of features that those companies want.

What this tends to mean is that engineers have less time to do
community work --- such as code reviews --- or they have to do that
work "on their own time", e.g., late at night or on weekends.  Those
of us who work as project leads, or subsystem leads for open source
projects, are trying to push back against this dynamic, because there
is always maintenance work that need to be done to keep the project
healthy, including bug scrubbing, code review, improving tests, etc.

As a Linux kernel subsystem maintainer, I am super grateful for those
who do code reviews and those who work test regressions, because in
general, that which doesn't get done by other developers ends up
getting done by the maintainers and project leads if it's going to
happen at all.

When it comes to requests like "you should migrate the project to use
some forge web site, because we can't be bothered to use e-mail, and
web interfaces are the new hotness", the entitlement that comes from
that request (which is in the subject line of this thread), can
sometimes be a bit frustrating.

Going back to the original topic of this thread, my personal
experience has been that the *vest* percentage of pull requests that I
get from github tend to be drive-by pull requests that are very low
quality, especially compared to those that I get via the mailing list.
So making a change to use a forge which might result in a larger
number of lower quality code contributions, when code review bandwidth
might be more of a bottlenck, might not be as appealing as some might
think.

					- Ted
