Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F42015278E
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751734680; cv=none; b=QPZSGZtVuJXUH23TIBiag+oFFwiQMb39wmDmp5UHBM8vLTFZ8uECzm4R12WJsXYSHFb82PIMUyQ808X54/uKagB9HonFUZTCht7vFUNLhGrfZaKLlNwe1Xv25impyyEvkNkhrcMztecqtj5ng1KK1O+ezIZR04f/WeCwmum7Dbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751734680; c=relaxed/simple;
	bh=pYdWkBjuXVFxoCxxZR24GtDs4sxB+VZL6VCQdU6ztVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIeUJPZecM/TMCBsni95wPulXyHHgYTEVteIC7HogbjsfEgyqXBpCbWpleDRqp4jFPbnttzDdkW2x/+81tjImVQDG1PFh2x2LChmENEWghewiqYdJm2nYxeCbnewa8FJhvf2h7QF3H6grt5pClDZPZhMWhZR5zsUdQo5bQoEoec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TAnQV027; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TAnQV027"
Received: (qmail 23872 invoked by uid 109); 5 Jul 2025 16:57:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pYdWkBjuXVFxoCxxZR24GtDs4sxB+VZL6VCQdU6ztVc=; b=TAnQV027ErMI0Hesnj2KKdXy2f9OU4m70ndPg7jXxvDsDBl+t2dlPFEc8XChe84BvoeZfxxzY4AyYY9cvG7ntrDbZ3UcabZ1a1M/uTEhq+tqcSAaySS+3Dq3pRpIjh2VTq7EXoIlL2DK7jD5a3+FLeS3oUeAwIRkRwUUVEvYlKDwvmN4ABvJwzjrlGDol5O1LU78iJsaMs7+ev1s4Zn+4JPHXd96N07klaaFc2fhQyYl9nqaW453QPRsrvMfOyHPSnTWrtH4g66kjj/R+TqZUX09l+1nxm7iF9iPzwPaq4TsRUGQkiCmJXcCugqMx00l26BDWPpgSK1eHM9kBFW3bg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Jul 2025 16:57:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3256 invoked by uid 111); 5 Jul 2025 16:57:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Jul 2025 12:57:52 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Jul 2025 12:57:50 -0400
From: Jeff King <peff@peff.net>
To: Per Cederqvist <ceder@lysator.liu.se>
Cc: git@vger.kernel.org
Subject: Re: Allowing "/" in the name of a git remote is a strange choice
Message-ID: <20250705165750.GA1951664@coredump.intra.peff.net>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>

On Thu, Jul 03, 2025 at 09:33:20PM +0200, Per Cederqvist wrote:

> > $ git fetch --all
> > Fetching origin
> > From $PRIVATE_URL
> >  + 4e31956300f...30e26ebbb19 chat/master -> origin/chat/master  (forced update)
> > Fetching origin/chat
> > From  $PRIVATE_URL
> >  + 30e26ebbb19...4e31956300f master     -> origin/chat/master  (forced update)
> 
> Every time I run "git fetch --all" git updates the origin/chat/master ref twice.
> 
> If it was up to me, I'd add a check to valid_remote_name() to ensure
> the name doesn't contain any "/" character.  I doubt it is used often.

I think the "/" here is really just a special case of a more general
problem: overlapping fetch refspec destinations.

For example, try this:

  git init repo
  cd repo

  git init one
  git -C one commit --allow-empty -m foo

  git init two
  git -C two commit --allow-empty -m bar

  git config remote.one.url one
  git config remote.one.fetch +refs/heads/*:refs/remotes/collide/*
  git config remote.two.url two
  git config remote.two.fetch +refs/heads/*:refs/remotes/collide/*

  git fetch --all

which gives similar output to what you showed above. Of course it's
easier to see here when the names are identical rather than one being a
prefix of the other. But it's fundamentally the same issue, and
forbidding "/" would not fix it.

We could perhaps detect these kinds of overlap, but I wonder:

  1. How expensive is it to do so, and when should we do it? Obviously
     for a handful of refs a quadratic approach is OK. But what if you
     had 10,000 remotes (this is not purely hypothetical; GitHub used to
     manage object migration in its fork networks with configured
     remotes, but hit enough performance issues to switch away from
     that). So I'd be hesitant to check this on every "git fetch".

  2. Is it something people actually want to do? It's certainly a
     _weird_ configuration, but I could imagine there being useful
     corner cases (e.g., one URL is an infrequently backup of the other,
     so you don't usually do "--all", or you set skipDefaultUpdate for
     one of them.

So I dunno. It feels like a configuration error in most cases, but not
all. I'd probably say that people touching the config manually should be
allowed to do what they want, but maybe "git remote" should be a bit
more careful about names being proper subsets of existing remotes (it
should already prevent the exact-match above, I'd think, because the ref
namespace it uses will always match the configuration name).

-Peff
