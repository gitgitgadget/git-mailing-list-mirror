Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870E3D647E
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334677; cv=none; b=MKV8cKwiL7We3V1+KkIeLrIFKiGbsEvvikHuEs8I16mWUm7Jqtu7fQEw+eGZM4rs8Oe1u98rwCJuyhvzBle8xW3vx+ZrxoPvXNv204gYhZuP45+WXqJGIe0dmIex8qaLdwr/kPAJ0NsxTkZhM59EZdJ4jfhyzchpelHpsTIDNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334677; c=relaxed/simple;
	bh=mqAp2A36CvHnhz9uGzX2GvUiAXEktcT6EUukh6LgVJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skZKAqMfKRDO+qIMuTlqawXjE/+fGs0LD06mPQOaWfah4hBfMmgqnHRU0JFDg9xXowgqWoNmjbqxmq9+EJJzH7AK+TM2rtH+hCGzJMxyVdxDjaJ0SGoxg6s/oR4NuNHnn6j1gBv8yh5tc4hLJK7QoqxlmCpdhHA0hoL0odLl/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U5XUfPGX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U5XUfPGX"
Received: (qmail 10225 invoked by uid 106); 2 Sep 2026 07:37:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=mqAp2A36CvHnhz9uGzX2GvUiAXEktcT6EUukh6LgVJQ=; b=U5XUfPGX6yJZt/U2rzmA1wVAqrvprDMDPZ0kl8qUtJFHWcm5cYrBxgR/pVCsqctuqMHWs1Rx+e9mdqvtK3oGkD89N1XzQyXL/agNr2yDpG0mhNuLIb7eMPGwhBWLPvgR1faIZn+1ilZxuwn8x5B/uDqgJv5/s5vKAmGdeCmH9SUDbP2zxT1P1lO/vZsC1BYgB9WSsOopggNfED+yxvboC/tixf76hwGAtmd0xl4PAeYWcqxRB1ONEEk5ddot+emk0yZ4qcms3uiwL5wLs69sTi/IYPDiTTjQpk8crR/s4kq8O04+NDbcq8Ai40mOB694OdMEs1o81dpuSHNRA6sFLw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 07:37:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 47703 invoked by uid 111); 2 Sep 2026 07:37:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 03:37:54 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 03:37:53 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence.csokas@arm.com>,
	git@vger.kernel.org
Subject: Re: [Bug] Porcelain allows creation of '@' branch
Message-ID: <20260902073753.GC70165@coredump.intra.peff.net>
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
 <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>

On Mon, Aug 31, 2026 at 03:59:56PM -0400, D. Ben Knoble wrote:

> But (with git refs list) we should see this creates a ref "refs/heads/@".
> 
> I happen to think that's extremely confusing given that "@" is the
> shorthand for HEAD, but… it's not against the current documented
> rules, I think. (e.g., "git switch @" will fail, since it sees "git
> switch HEAD"; using "refs/heads/@" will also fail.) git-checkout
> doesn't fail but also doesn't change to the "@" branch. Futzing with
> .git/HEAD and restoring the working tree works, but… yikes.
> 
> Of course, --branch mode is allowed to be stricter; maybe we should
> reject this case?

Yeah, sadly bare "@" is allowed in a component (but not "@{") because
we've maintained strict backwards compatibility. So I don't think it's a
_bug_ exactly, but in the past we have restricted the porcelain
interfaces (so git-branch, but not git-update-ref) to avoid such
footguns. The most notable one is HEAD:

  $ git check-ref-format refs/heads/HEAD; echo $?
  0

  $ git check-ref-format --branch HEAD; echo $?
  fatal: 'HEAD' is not a valid branch name
  128

which also shows off that "--branch" is a convenience option for using
those stricter porcelain rules.

I think it would make sense to treat bare "@" the same as HEAD here. We
probably _don't_ want to forbid any "@", though. Branches and tags like
foo@bar are legal (if IMHO somewhat gross), and less likely to be used
accidentally.

So I think there is no bug, in the sense that the system is working as
designed, but it sure would be a nice feature to block this footgun.

> (I don't recall offhand where we describe valid branch names, if at all.)

I don't think we document the magic porcelain-tightening rules anywhere.
That's probably OK in practice; the point of "check-ref-format --branch"
is to check against them programatically.

-Peff
