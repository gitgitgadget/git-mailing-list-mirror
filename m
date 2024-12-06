Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD517C98
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733454107; cv=none; b=o/eUE4pRI7i8HPd2IX8t2/+N7oDVh2jtXHjg7gp6ufFdTeTD/x1bPjkMesxBEWzSxAAVI2+2M9MogvnQFB0LlfGCx6iPjSN3+tLLGkyfusVzwuldF1F9TVCKX1sZZ0ZotFSpY+o5uvZE81yJcdJDFobJEdhdyYF8B59iA7mqrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733454107; c=relaxed/simple;
	bh=OGBCvoh1RzeT0h7Bhjb/d4h1QtuzHxOcUBgxmtKky/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MkepaLQ6C/wQO0KqJFBI+4561OZqQlBftjAwo21mEtVVxFJiAqz2zq6cqAt04DarR26AnbFzww1a39sK1DgrasW8BEhjBpcH65/fHl0aHRg9eHn1w/B2/19R2tVI2i1A/Wt59VyFCxE9HvJZZ/ckARfso0ncYxZV8kz+UFMjREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C3aZcFrS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3aZcFrS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DFF2F13808E7;
	Thu,  5 Dec 2024 22:01:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 05 Dec 2024 22:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733454103; x=1733540503; bh=7CZiil8kTRSyxGJDv3XU0/jdVeyTVj9vp59
	TwmVTLes=; b=C3aZcFrSv2C4t2YRtW3GfiqYka+qFKSdi8T53xf58ltYRO8rjGT
	T0BKbQvcpMdIBjsPfiDCudPo0aLkRIKfGEkmmCwjFu1on9dtcZJEkhB4Ka0Wp4Ea
	iA215gAYfaW/CHnEHb2S1VU+j28MeySb7AfblV02+s+pV7kknNl90Hm4/a/3YY3M
	j+lAn2W5ff6sJoA/3AZm8FDW1zD99ibnNIQ+1DYnm6EKaXW1SaLXaEA/Q/J3xT7b
	uG9JwJTobRYUYvRzJg0tYV0aak3c+YUrzIg19LsNh1UGQ5Jar8AP2eszDBOVwMLs
	n548Z4zaEYc3Q/9Q61wqHnJgv6VZ1/o3KvA==
X-ME-Sender: <xms:FmlSZ-kkJigre8XRrvmnGPSoo_gHma2pN8G4qeSMmLgqR75kGo1HSw>
    <xme:FmlSZ10pKbphvdrvljpFgZXDH-p1X_GWMccyJdjKFdMyg3-6c4UezzlvvuEVXiUql
    sbJmwyUz3Q7ta3y7A>
X-ME-Received: <xmr:FmlSZ8qCzP2Lss4KiopjbfiZansjMZNqkGgDIjCBU8OAbgN-fEYbG0-495oaplfUK1VYih8iaFTr2fPGvkzc7sx1q4Op2b8gtw_cTUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhnoh
    drmhgrrhhtihhnrdgvvhgvrhhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhn
    ohessghmvghvvghrshdruggvpdhrtghpthhtoheprhgrvhhisehprhgvvhgrshdrughkpd
    hrtghpthhtohepjhhpohhimhgsohgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    rghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:F2lSZymYsNBvrR7OHsTIblDr0IRxWh4t9AZxGbBn3VEDI08NccRCjQ>
    <xmx:F2lSZ81j9ZO6Q5Nw-M52H-Ad0zYG999Eizcudbt3Waq2XEXQxDfl8w>
    <xmx:F2lSZ5tICL_62laW8olOAwV0kwH8Lzs6QKJjbKE-mUVb6TBlGiWghg>
    <xmx:F2lSZ4W9Q5NS-9AV3bymP9dHafOJE2Uuwe4FuE-EB6oTTbo79FTYgA>
    <xmx:F2lSZywVsM10EFpOs2V4ukOOLm0UkU6CvlWqlUJcW2YmjLKEh7caUX8d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 22:01:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  benno.martin.evers@gmail.com,  benno@bmevers.de,  ravi@prevas.dk,
  jpoimboe@kernel.org,  masahiroy@kernel.org
Subject: Re: [PATCH] describe: drop early return for max_candidates == 0
In-Reply-To: <20241205201449.GA2635755@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Dec 2024 15:14:49 -0500")
References: <20241106211717.GD956383@coredump.intra.peff.net>
	<00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
	<20241204232750.GA1460551@coredump.intra.peff.net>
	<20241205201449.GA2635755@coredump.intra.peff.net>
Date: Fri, 06 Dec 2024 12:01:41 +0900
Message-ID: <xmqqser1zf8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Actually, after thinking on this a bit more, I think the solution below
> is a bit more elegant. This can go on top of jk/describe-perf.
>
> -- >8 --
> From: Josh Steadmon <steadmon@google.com>
> Subject: [PATCH] describe: drop early return for max_candidates == 0

OK, so the patch authorship still blames Josh.  But there is no
sign-off because ... the approach to the fix is so different that
blaming Josh for this implementation is no longer appropriate?

> Reported-by: Josh Steadmon <steadmon@google.com>
> Signed-off-by: Jeff King <peff@peff.net>

If so, please take the authorship yourself.

> Before we even start the describe algorithm, we check to see if
> max_candidates is 0 and bail immediately if we did not find an exact
> match. This comes from 2c33f75754 (Teach git-describe --exact-match to
> avoid expensive tag searches, 2008-02-24), since the the --exact-match
> option just sets max_candidates to 0.
> ...
> So this:
>
>   git describe --exact-match --always
>
> and likewise:
>
>   git describe --exact-match --candidates=0

Did the latter mean to say "git decribe --candidates=0 --always", as
the earlier paragraph explains that "--exact" affects the number of
candidates?

Without this patch, all three give the same result:

    $ git describe --exact-match --always HEAD
    fatal: no tag exactly matches '59d18088fe8ace4bf18ade27eeef3664fb6b0878'
    $ git describe --exact-match --candidates=0 HEAD
    fatal: no tag exactly matches '59d18088fe8ace4bf18ade27eeef3664fb6b0878'
    $ git describe --candidates=0 --always HEAD
    fatal: no tag exactly matches '59d18088fe8ace4bf18ade27eeef3664fb6b0878'

With this patch, we instead get this:

    $ ./git describe --exact-match --always HEAD
    59d18088fe
    $ ./git describe --exact-match --candidates=0 HEAD
    fatal: No tags can describe '59d18088fe8ace4bf18ade27eeef3664fb6b0878'.
    Try --always, or create some tags.
    $ ./git describe --candidates=0 --always HEAD
    59d18088fe

> But this interacts badly with the --always option (ironically added only
> a week later in da2478dbb0 (describe --always: fall back to showing an
> abbreviated object name, 2008-03-02)). With --always, we'd still want to
> show the hash rather than calling die().
> ...

> has always been broken.

Hmph, I am not sure if the behaviour is _broken_ in the first place.

The user asks with "--exact-match" that a result based on some ref
that does not directly point at the object being described is *not*
acceptable, so with or without "--always", it looks to me that it is
doing the right thing, if there is no exact match (or there is no
tag and the user only allowed tag to describe the objects) and the
result is "no tag exactly matches object X" failure.

Or is our position that these mutually incompatible options, namely
"--exact-match" and "--always", follow the "last one wins" rule?
The implementation does not seem to say so.

If the earlier request is to describe only as exact tag (and fail if
there is no appropriate tag), but then we changed our mind and ask
to fall back to an abbreviation, this one is understandable:

    $ ./git describe --exact-match --always HEAD
    59d18088fe

But then this is not.  The last thing we explicitly told the command
is that we accept only the exact match, but this one does not fail,
which seems like a bug:

    $ ./git describe --always --exact-match HEAD
    59d18088fe

So I am not sure if the "buggy" behaviour is buggy to begin with.
The way these two are documented can be read both ways,

    --exact-match::
            Only output exact matches (a tag directly references the
            supplied commit).  This is a synonym for --candidates=0.

    --always::
            Show uniquely abbreviated commit object as fallback.

but my reading is when you give both and when the object given is
not directly pointed at by any existing tag, "ONLY output exact
matches" cannot be satisified.  And "show as fallback" cannot be
satisfied within the constraint that the command is allowed "only
output exact matches".

I think the complexity from the point of view of a calling script to
deal with either behaviour is probably similar.  If you ask for
"--exact-match" and there is no exact match, you can ask rev-parse
to give a shortened one, and you know which one you are giving the
user.  We can change what "--exact-match + --candidate=0" combination
means to let it fallback, but then you'd need to check the output to
see if you got an exact tag or a fallback, and for that you'd
probably need to ask "show-ref refs/tags/$output" or something.

So I am not sure if it is worth changing the behaviour this late in
the game?
