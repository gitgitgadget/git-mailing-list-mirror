Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2433F375
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762805500; cv=none; b=Hd0S3n9SiZdaY0plDpIolwIF6lRlNyuzvDCwvYiK841es/EQ1VEqJJ8r2djpNv50i8fIjE7W0nUGdJiSAD5c0OjoiCT+U9uAdLJ0w+XixcUj6f//bUdO01OFi5egid3zVs5dHbqOCtSJhSXCb3TQCLIJyZqC4kHtnDu9OshQnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762805500; c=relaxed/simple;
	bh=Gu+TlMXbe64v/Nmi2mwmgJBJz4sogZoD3AKlrmO6cCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5tEnyXUk/ukHeL83+Mh8Vlmgx2/AhfupTH4FyeeFEDvbfKEpNFFkTGqwvgsBgYGTW7RTo7jmmIfOKxb8GdrK61iJ4cxKpIkEiVGgdQtXltLjvEB4t/ZMJZzkM9Ufg/tIXawEA7GfW7f0wRAZZU5E4/qWjjv6VCa7RcNUs9XvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PEqQvZWG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PEqQvZWG"
Received: (qmail 482504 invoked by uid 109); 10 Nov 2025 20:11:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Gu+TlMXbe64v/Nmi2mwmgJBJz4sogZoD3AKlrmO6cCo=; b=PEqQvZWGq0Ac87bW7tUTiE4eh/Ye/l48cFixG9NPtjRqeGyM4lFuGSEMhahmT6JkKJzcyWZSgRYSO+qV+ra5xttEu/8pd6TWwiUYTDZo0webVtVoA+o3XA0QvWf88vuRTh3vUBQKHjUuh0JmGswIRRiGvmMdKQsYKvApDx9FVKLvBo22c0AHX9qOb+1uq2VMi0j7DMBe41gxWmjNX/AZYbMdjyuduYZ4y3SLtNvZ0foHhZYDK/XI9pQMsawWJK2wJvrtunlq6bXpdg7U/Q4mcb+K6J/FB6+MW4/kHhJyI8AlQgmk1thhs/8m0YBMQNZxLzNpUv8adGrprElXV8sALA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Nov 2025 20:11:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 765257 invoked by uid 111); 10 Nov 2025 20:11:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Nov 2025 15:11:36 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 10 Nov 2025 15:11:36 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: phillip.wood@dunelm.org.uk,
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] commit: add --committer option
Message-ID: <20251110201136.GB127132@coredump.intra.peff.net>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
 <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>

On Mon, Nov 10, 2025 at 06:01:57PM +0000, brian m. carlson wrote:

> On 2025-11-10 at 16:50:04, Phillip Wood wrote:
> > On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
> > > From: ZheNing Hu <adlternative@gmail.com>
> > > 
> > >      This patch introduces the --committer option to git-commit, providing:
> > >       1. Consistency with the existing --author option
> > >       2. A more convenient alternative to environment variables
> > >       3. Better support for automated workflows and scripts
> > >       4. Improved user experience when managing multiple identities
> > 
> > What's the use case for the same person committing under different
> > identities? We already have a config mechanism to set different identities
> > for different repositories but I'm struggling to see why someone would want
> > to create commits under multiple identities in a single repository. For
> > scripts it easy enough to set the relevant environment variables if a tool
> > wants to create commits under its own identity.
> 
> Someone who works on the same project under both their personal and
> corporate identities.  For instance, me working on the Git project.
> 
> Some open source projects also require a CLA and you have to use a
> particular address to match the one that's listed on the CLA.  For
> example, Google requires an address with a Google account, so in the
> hypothetical state where I was going to contribute to one of their
> projects, I'd need to use a different committer identity with my Gmail
> address.
> 
> I've also kept business logs in Git when I had a small business and I
> might well need to log approving a profit distribution (with my
> corporate address) and log accepting a profit distribution (with my
> personal address).  Those would need separate digital signatures from my
> two different email addresses.

Is a "--committer" option the best solution there, though? I'd think
you'd want to set user.* in the repo-level .git/config (or using a
dir-specific include) would be less error-prone.

That doesn't help for using two identities for the same repo, but in my
experience it is easier to use two separate repositories for that to
match the organization of the work (even if you may sometimes fetch
between them).

I'm not totally opposed to the new flag, and in general I'd defer to
people who say they find a new feature useful. I'm just having a hard
time imagining a scenario where it's the best option.

-Peff
