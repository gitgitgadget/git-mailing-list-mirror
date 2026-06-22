Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E7379C3E
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122138; cv=none; b=IacBeTw3ncV2nkJ37Mh8vcRyy8K/dZM8VACfFBuEIUA+6IXK1GXd+fBWynmX7Jcu0ZIDwjtfbB+RiYAm48K33gKd1N23tStdq2ZUZ6bnhWr1UMutthwGHLh0b4UsFlf//veSoRT0RxIoKX+rd71Kl3/1BdWeuOES9EFrrrguXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122138; c=relaxed/simple;
	bh=xudXmLAwoHWT4zK5pFgj6F3fTDjWIfUN7hnbcv/HlgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPX02BF3VwnXHzGUfO6j9DxpuJzjnF8VCMuCJKg64c0k7z7ABKPL4lFc1f2E3EyUZluWXCMNCVedLta9/ZMydIkZ91/nskZw5CFV0FjA5SiadaKvtPQxH62bWpkyT4BfIlumbU6lWbsJIk9QyloLjnlxEsJViAiQbjlB7BDe2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MFgwfcpi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ubpe2bZJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MFgwfcpi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ubpe2bZJ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A760B7A00E8;
	Mon, 22 Jun 2026 05:55:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 22 Jun 2026 05:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782122134; x=1782208534; bh=7brCRBVIRn
	BdugWndZ+8sg/ZuJCBmZF5Nyu0D1AGiLc=; b=MFgwfcpiLypB4JoV1H0TCVLsI3
	ApMVe7A0OiNi/qcXVFsnnJ2wnIJbElecr5gjzH3sW4GvTAdiEoU7xzmRoaUwtEAC
	WrU6Tm1ZLBb8I6lGgPplz3bc2aM9D6QSOM9DAKIsJ/Qy5DCZukWmv4zyd9CAnsVj
	w/4A6jJ+wN9/zaDg6NZf2/NGEJieRyhv+UrZstGwkIvnAWtMXbzNMW6ruTYqotjW
	2TEKlVFOWd4YcHhpoy/aX9gRjTKsfOYzaqQvD/dHL9+mgASVKNrYyK2leJ9PYySL
	Z72GX9vFaIl1v/HU74uA7Fobh1vdql4zkkW/vm3wA2CHEkKmpzhj5z3F0pvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782122134; x=1782208534; bh=7brCRBVIRnBdugWndZ+8sg/ZuJCBmZF5Nyu
	0D1AGiLc=; b=Ubpe2bZJ7NG07ShBY3Na5mrLgiwaqbc8qeMEOHjVY43vx2p/pnA
	s3T2Z1IgWDDo0I1OiwtNb5FZCkY9f/KECA9VgGYwwtudUBv0koFxsJrD2PGjzDX2
	sqh2zAMqIuuiLqorAi/oNExCPkac9GP3kqPyZ6ppc/XR+9A6qyJMfFWgUZyQC/wV
	xVNqRUw61C7D2kz7t1IPYa1iuSN6JnxFd1jUte40lVGTCiCmgXwJnwlzw1461c32
	eduIzCjYuwU/eVVNqqcsy/0KmeU1uZrUOMnh8PEC5Iaxp2aE9KJqyfY6176ZnMJQ
	9zqx2XdftpntfoMJrx7bvZlZjsBsA0QdUbQ==
X-ME-Sender: <xms:lgY5apWKAUgPkKRWJUJ6wlYt4P1FyJ2nZzxtQJnxBuSgTtel1Eqj_A>
    <xme:lgY5agmgtGWtoUQPvj84-mHAqHJgWtMQSvA0NRr_vHrqCLzUwlhqNKUxa2kGwCD3C
    Mb4MAu1Oj6trC_ypmNER1atVYKba6G8tnk6xXQCHb5u2On8tGQxGI4>
X-ME-Received: <xmr:lgY5aqZH5lmFe_Qc26K7O3r1O3bbB5cvp2Y3VImdjHzy1b7O_rZi_6WfY9xK8AcBUWJe0hXth2jYqZPugEv8kPagw1lDkLtMwv3KMiwCpg>
X-ME-Proxy-Cause: dmFkZTEBNZ3SdUK4oePifS9DxYgzA4DhmT+F43++SNyQmW2btUYV/+7nm0TyhsjzUoprXp
    i/beMH+eiZMDhs55EDFM39NhKOnZxhzz3qvT5QlkJwE11BUL73sRu51zT5Axt564qXTyXe
    6sp8B/qi4jRf9a9Ld4Uh9qmDOWtJORPuhJHKmLfGJl8IVzKEwcsgXzef+hk6+68EKzs3sS
    r5Mp3u4a4GQ1kxgVn2V9RRs0UZoQYMHd4eHZmqs+M3wR3cGVP9qde3oa8vAm0Xl1b4hE5p
    mZXwhHbqc3H9XLih1bJNM6XWpxJPLJZjkUuSMobD1qAniLcK0HDO5Uv/EMfURriK7XKSgb
    80MRZZxdkndHXFksIA2l802Y5MmNCFFhtJjSZ3yQwT5Y2zI7BuJ+B0CIzbhOyS4c5IF2YU
    8zp1Fm3ugOVfhFQbHa+CN9ZQPxwmye088xYWvM9TW61TUtkpkYzvzrr4aoAJDq33xDLUi4
    TkakJg0FANA1Vj8jR9FeZ7to+7F16T5psoYHcgFSoQQ1fzWKC49heJFrFgqqhZVqWYPIdc
    k7VFn7xBcZF8Y6SHHZ9tv0OeeqhCwr9sP8QLZB0UAffA50ayhb4ThvvilVLyCNePvr0gbt
    FTL7eVPOA+CQ9ibkqj0apZ/OMVgtJ8WGPBQ+ga96zN4SWFcnBHEAx1W5EX4g
X-ME-Proxy: <xmx:lgY5arOzkwXqtkXBCbkBbFV-Cosvrgo5BBtAVklmqDhA2ti6QRHzgQ>
    <xmx:lgY5avaKm6N6q3am5Qi8kQdyxh_f7m8auRIIeq8XrF4E79eNQdWymQ>
    <xmx:lgY5ap18cSU3CxAkvUaTJfn2gJXBy6nMhMD8RgHVx25OKOJgOTOO9g>
    <xmx:lgY5alcw7nX2EI5hSAYuSCeIBndVRWa6_vizEOG3vzPif5a-DTEHew>
    <xmx:lgY5aiU56ERpq5ABkTH7KaYMWObbAXQTxFxfu_DSkB5GZWvWDgjGafmr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 05:55:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7711b2c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 09:55:31 +0000 (UTC)
Date: Mon, 22 Jun 2026 11:55:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
Message-ID: <ajkGkB2ckf3p43QR@pks.im>
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net>
 <aji9MOE-NTHKXYqn@pks.im>
 <ajkEzhdqzmAePk_P@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajkEzhdqzmAePk_P@pks.im>

On Mon, Jun 22, 2026 at 11:48:01AM +0200, Patrick Steinhardt wrote:
> On Mon, Jun 22, 2026 at 06:42:24AM +0200, Patrick Steinhardt wrote:
> > On Sun, Jun 21, 2026 at 05:34:07PM -0400, Jeff King wrote:
> > > On Sat, Jun 20, 2026 at 08:33:13AM -0700, Michael Montalbo wrote:
> [snip]
> > > > When it is wedged the whole chain sits at 0% CPU. upload-pack is
> > > > blocked in write() on the ls-refs advertisement, curl blocked in
> > > > select(). So it looks like an HTTP/2 flow-control stall on the
> > > > response side. The same stall resets itself after ~60-85s on my Linux
> > > > box and on a bare-metal Mac, but not on the GitHub runner; I haven't
> > > > pinned down why yet.
> > > 
> > > We had some HTTP/2 stalls/deadlocks in the past, and they were dependent
> > > on libcurl and apache (actually h2_mod) versions. IIRC some of the
> > > non-TLS code paths for HTTP/2 were not well tested, which led to
> > > 8f2146dbf1 (t5559: make SSL/TLS the default, 2023-02-23). Of course
> > > after that commit those cleartext code paths should not be a problem, so
> > > that is probably not exactly the issue now.
> > > 
> > > But it might be worth checking the versions you're running locally
> > > versus what's in the GitHub runner.
> > 
> > I didn't observe any similar hangs in GitLab's CI systems, so I wonder
> > whether this is because of different versions of curl. And indeed we use
> > different versions:
> > 
> >   - On GitHub we use 8.6.0.
> > 
> >   - On GitLab we use 8.7.1.
> > 
> > Now this of course doesn't mean that updating the curl version is the
> > fix to this whole issue, as there's a ton of other factors that could
> > play a role in whether or not the test hangs. So while we could just
> > upgrade parts of the stack and cross our fingers, but that feels rather
> > unsatisfactory. Still, one place to start could be to update our build
> > images to macOS 15.
> > 
> > But the big question to me is whether the hang is because of a bug in
> > Git with how we drive curl, a bug in curl itself, or a bug in Apache.
> 
> I noticed that a osx-clang job failed today in t5551 [1]. This time it
> didn't hang, but produced an actual error:
> 
>     2026-06-22T09:25:45.1984230Z ++ git -C too-many-refs fetch -q --tags
>     2026-06-22T09:25:45.1984420Z error: RPC failed; curl 18 transfer closed with outstanding read data remaining
>     2026-06-22T09:25:45.1984520Z fatal: expected flush after ref listing
>     2026-06-22T09:25:45.1984610Z error: last command exited with $?=128
>     2026-06-22T09:25:45.1984660Z ++ rm -f tags
>     2026-06-22T09:25:45.1984710Z ++ :
>     2026-06-22T09:25:45.1984830Z not ok 35 - http can handle enormous ref negotiation
> 
> There was a second test failing similarly.

Oh, and Linux is also failing in the same test suite [1], even though
the job logs are truncated, so it's hard to say whether it's the same
failure or not.

There certainly seems to be a deeper issue here. We could of course just
disable the test again, but by now I do wonder whether this would paper
over an actual bug.

Patrick

[1]: https://github.com/git/git/actions/runs/27940620478/job/82672854864
