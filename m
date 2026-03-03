Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC236B043
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546455; cv=none; b=NMqrnR06MfRn7ZlUPzDJiY5pRW818HAH8TEdOOwadLu3K7VgAmdFe6YHokkHdEzj3LPuTYzk1g/xJELeZtBNs4SlxF7YyTfPf7wBy9VmnxSmYhvsgKmWYG8jroPMtg7a5bLnNT/NlT5d/8Q4hwApysjwFn1b0Z8MCULTXfPSq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546455; c=relaxed/simple;
	bh=0cs+42HzP764G9QwuDniZaWHGg64xAbpCwU+yjpWO6w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=paqK/5Gq+aNwm7HVFD9ldsd9v0ORgY0Jek03lUc35OTNH36nHF/3PjNl9jAa/xMHBM8ClkdQ9o0WFeIX6vVe5qkPjXE6N3Yv0yLBn37lHqmoQL944Q7DFsBezBl9banJSLQFVJAaorm3YoO9WZnI8F0gHzPTCfXAGbelJjLARVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev; spf=pass smtp.mailfrom=braithwaite.dev; dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b=Uld29WV4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=As6TEADE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b="Uld29WV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="As6TEADE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FCD114001A1;
	Tue,  3 Mar 2026 09:00:51 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-05.internal (MEProxy); Tue, 03 Mar 2026 09:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=braithwaite.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772546451; x=1772632851; bh=sMug7dovfExhroKTDnmm5ABRtkEqH9EC
	UArtRGk/w1w=; b=Uld29WV4w7wxHF3917xNco984vkiUfUGgFJX7KPwq6x3Kk+z
	iEgyeg1Z12GGjtBWegAg3toyukAeBJcufNp6pd8SRpXiLpbHo81ZbmfImipt7hQb
	1CIlBLsYbGp2PsaFIZ3Lawuxyqa2llKr1/xZqYLi5RTbUMl3XqC22NlesFnW6WGJ
	tjcRQusd7frXKbLltjy31bGG3flYCg8a0oZzEmNdq4j2rJjIU7br4IM0XMKF48g+
	zK7D5rIXaVm1Ix66uP2hpSPN63XMimEZMsn+hPgjwwBeKMj/1UsgL0GIAWPxLWVb
	KUqwU4TQL8ZbWsdsFY0zz8Zc0/2vXFhhsMpfaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772546451; x=
	1772632851; bh=sMug7dovfExhroKTDnmm5ABRtkEqH9ECUArtRGk/w1w=; b=A
	s6TEADE3htrTSSLiCkUv47rUEJ7CtA5aK1nxQJJ+sHJh05Z3IYEUxJTSPZr8NwE3
	6KkjHrTBGydYM5bWwTrFgwUDozlJrbB5RGpqLtNW9tkdPy1KOSuCTpffDFayXrO1
	B+4EhjjlPytowdWWosC2pbquEmyNRuJLKPjEQL7j3ka180v/uWfHAk+/PkmNCezR
	xPEiI+j/Kt8Z7LNEBM/G0cq8L4KHSplcTPidWEWDAMgQNx2gfN6Fo6LY5xYSa2Xz
	PJRoYIQ5CuPqk3zSY7JzbAmxRE8F/CqL0H9/qeY0acNmPDcZRBQUobokQnTkLJoO
	tdRHqfru46CjFTnw6NycQ==
X-ME-Sender: <xms:k-mmaYPa1VFfr_hpd88KIFW7443dJ4vXS4KL1Vixa5I7GK9i0nDP7A>
    <xme:k-mmaZyPsuAXiVFhC0bvWD7cZfBNLY4acjFiqthVdsrjJA2gcFGUpmVSlnYno6vnY
    oylJX5vHkGRj7d3VEMK7nTeGwXcyN8vPpWJ-YUB1Br9pc-Fbh8lu4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehlrghn
    uceurhgrihhthhifrghithgvfdcuoegrlhgrnhessghrrghithhhfigrihhtvgdruggvvh
    eqnecuggftrfgrthhtvghrnheptdfgfefgtdetjeetvdfgveeftdfhjeefjeffgeeujeeu
    tedtgfeuudevvddvhfdunecuffhomhgrihhnpegvgigrmhhplhgvrdgtohhmpdhgihhthh
    husgdrtghomhdptghorhhprdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheprghlrghnsegsrhgrihhthhifrghithgvrdguvghvpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhs
    thhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghn
    mhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:k-mmadlc18yh9iC563ou0kri84UHfipBcaN7BvnOXxl2WexoJ4z7oA>
    <xmx:k-mmaZjs2AlsBcm9hga-qEzuXFIsekLQPeOknORXuG4v_xWOQbjGxw>
    <xmx:k-mmaR0hwkmW3KkmDhLRVVno75HFk7OvBs3OcDi06XaLP1DCsXaD1w>
    <xmx:k-mmaSKHcdAjf9EthX0OmSxXZhAWCS-i88fmZ4fyMIfWJuVUAcygNA>
    <xmx:k-mmaUTyko2We-z3XgoJF9lT2AixKWX7k1c5X_la7lZGVeC6vmJEV6gd>
Feedback-ID: i1a914699:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3944E1EA006C; Tue,  3 Mar 2026 09:00:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKwwuKWZdwNg
Date: Tue, 03 Mar 2026 06:00:29 -0800
From: "Alan Braithwaite" <alan@braithwaite.dev>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Alan Braithwaite" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 christian.couder@gmail.com, jonathantanmy@google.com, me@ttaylorr.com
Message-Id: <d4e2aa7e-6c6e-43a5-96ad-848d9447d194@app.fastmail.com>
In-Reply-To: <aaaACBJVAZPypVtn@pks.im>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
 <aaV6PLJCrpb2mQnq@pks.im> <xmqq342i12ky.fsf@gitster.g>
 <a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>
 <aaaACBJVAZPypVtn@pks.im>
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Patrick wrote:
> No, you're right about this one, and I think this is a
> sensible thing to want. But what I'd like to see is a bit
> more nuance, I guess:
>
>   - It should be possible to specify the configuration per
>     URL. If you know that git.example.com knows object
>     filters you may want to turn them on for that domain
>     specifically. So the mechanism would work similar to
>     "url.<base>.insteadOf" or "http.<url>.*" settings.
>
>   - The infrastructure shouldn't cast any specific filter
>     into stone. Instead, it should be possible to specify a
>     default filter.

Thanks, this is great feedback. I took a look at the existing
URL-based config patterns and I think the http.<url>.* model
is the right one to follow, since it already uses the
urlmatch_config_entry() infrastructure with proper URL
normalization, host globs, and longest-match specificity.

Here's what I'm thinking for a v2. I'd like to get feedback
on the design before implementing:

The config would use a new section that supports both a global
default and per-URL overrides, following the same pattern as
http.sslVerify vs http.<url>.sslVerify:

    # Global default =E2=80=94 applies to all clones/fetches
    [fetch]
        partialCloneFilter =3D blob:limit=3D1m

    # Per-URL override =E2=80=94 more specific match wins
    [fetch "https://github.com/"]
        partialCloneFilter =3D blob:limit=3D5m

    [fetch "https://internal.corp.com/"]
        partialCloneFilter =3D blob:none

Design points:

  - Accepts any filter spec, not just blob:limit. This
    addresses your point about not casting a specific filter
    into stone.

  - Uses fetch.<url>.partialCloneFilter, following the
    http.<url>.* precedent. The urlmatch.c infrastructure
    handles URL normalization, host globs (*.example.com),
    default port stripping, and path-based specificity
    ordering =E2=80=94 so no new matching logic would be needed.

  - A bare fetch.partialCloneFilter (no URL) acts as the
    global default, the same way http.sslVerify is the
    global default that http.<url>.sslVerify can override.

  - Only applies to initial clone and to fetches where no
    existing remote.<name>.partialCloneFilter is set. Existing
    repos continue using their per-remote config.

  - Explicit --filter on the command line still takes
    precedence over everything.

  - If the server does not support object filtering, the
    setting is silently ignored (existing behavior).

I chose fetch.* rather than clone.* so that both git-clone
and git-fetch can use the same config. In practice this
mainly matters for the initial clone, since once the promisor
remote is registered, subsequent fetches inherit the filter
from remote.<name>.partialCloneFilter anyway.

Does this direction make sense? Happy to hear if there are
concerns before I start on a v2.

Thanks,
- Alan
