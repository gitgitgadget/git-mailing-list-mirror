Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715561;
	b=Gx7spX04NtvN5q9FWIT0eRY90kOV4Z3Aj8FS5ZLAtAG6byuQmYS/V11Krcf5qF9PeYvg
	 sGR2W5WwW34NxXlpWdCsZz7oSdkw6kiIhAseTfhvU/WkG7d/FSIVnM31C5mYeN4YAR/+S
	 gV3WrHnh9i8LqQT4Nm7JhHI887fHJG1YE19F6z58Nrb+e9UhB8/jDssMfVD4cudO58tfr
	 1h2WdHtQtD8ukJPkkwC7dFxUZN97IpOEDVzD3GZPAabIjcS4/uiHJ1VOeSoqJlXnjrHzW
	 ZWtRSWqIbA7feeq5hiOkoHIobzFA6SCu0vw0IvatPElXSPlvLpLi8OpuSzpdiHEktLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715561;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=RusRy7ZyijoCdQap2UTOT/KMkVe+KnPRwFep7buH9TY=;
	b=Pt/FXfOFXDZqUlDLqga1QFRBv+1no8VGF+p5JlCzWVejMdBKfX/Ojoiv0CJexIJPPLyL
	 wZJ8CO7YmCqD2my/pd5VgQ3dC2bOUr9e08oKLtLLRGWE5v8Tm2/djBv1aIIaju0oWgcLb
	 yHhzMrm0u1TNvY5uCHMWsEvoakHsQ9u+IcXygK6LwqUE43Xigrnv1eWg6PM24pEtuLz8G
	 LxCzwkNoFGKWIuOcYOS/5r/n1CfdMUKTz85x6EXYs+pyGF6GhMysdJXwKW1UARsDnt6D7
	 p9SVpc0Dtv0/ZRqLuvySrMVI8cFC87jDhlkiCcQl84Xj9WM+vnln4dNQTFb45HPMXnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z2C3zBxI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="FvHUKc1/";
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3F606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 17:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F3F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z2C3zBxI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FvHUKc1/
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A92647A00A1
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 12:52:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 26 Nov 2026 12:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795715559; x=1795801959; bh=RusRy7Zyij
	oCdQap2UTOT/KMkVe+KnPRwFep7buH9TY=; b=Z2C3zBxIFjHO+WqgtPgkg3/Cq8
	/YyqobqH/rJoD6Dq8pWry0YAIEE/QrbfZQeC03yCC3YJiO32tf9SkqTnRyallgGF
	/ZTdYqzDE9trBmF8m58W76Gvej2/YD5xYg/exb5A+iD+UDuQGrKao5+TD4Fxq9kh
	hpiwioPzV/Gm1o2W6TUOy9B7MLpqFxvXYkJ0I91PJC0DPR7YP3z4QvnzVNtbXv1S
	gGoEwvhe/AO0lnXV+0rW6uAyrnxJW/8pWpzcrbiSArAMhkf8hSpwggkARFS2mxh9
	lkhuEAClR2xaspHEtYBvO+DaRDsKGe5GuVrAS6iU9YiSd/hLJ8A6Ffc4JhhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795715559; x=1795801959; bh=RusRy7ZyijoCdQap2UTOT/KMkVe+KnPRwFe
	p7buH9TY=; b=FvHUKc1/4Rl2BNmtEtdTLY0N4NpkS6iqVwJChzWh7IbDzZL3oMw
	WeiZEpBlsfBv0pTOEtpic5roFntskGNkQGjClDkVz8sGp5stJcl7mP2l41HFi8mO
	vxnlc6KfHu/H8VGKYxeqwsomG9PlXm7efwRNkH7sczZO2CQ8Fna7gRCTYPG6unxw
	N1A1KNuvPVcu8JOnWToi/ScGdaXLNnghDQ3y30/An6XM+IY1Id9h0fr+yuA/uQBU
	rV/K50GTmVenpI91TbNNXYGlpeYIPQjjd3PTx8h3zSNPgiz491PS3VaCfjImonLy
	ZxtqZDE/lLP27QStdcTKITE7ZaUK0r6RKPA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795715559; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NyEz0ZzwtyHPtbffl6FM14cUDph2sp+QTmTzwp6lD3OJB4c
	Xl/tU2DOEYo3j3m8+oL8NbZdC4nAXhnRNgVqNE+zKRMjVnBjw4Md0D7XtkrFoB2k
	p7ZVwhY6Vw0GtyafuNK8UljhWgY0BgSYvfdrUy6SFAmGqsd//OIP9Y+0NcJ0kFIq
	x2A9uOX/HDwdv416vGULn3I64YJmIv/sLFqjSSIrG40ZJTplu5GKiAkX3GOX5/Fw
	ITNeGPn3JRPOV+szZ8t7yPVShPCBgL1yVYnG1C77ibuBxsz+rQ+KFOwgvIYLSIP+
	Xp9/yS/47cP4v+w339gEpIiiiQ5nIJZjRrZwqWw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DDckdWiFO8He5hDo0J/OXbLrNwmEzvndvPAX0VJCJ+Q=:pyR/qu19JMXJSIOBz5Q44u9ebklEsRpzXrrtLg8QNHQ=;
X-ME-Sender: <xms:5nEIa5EQv3NPYm_9ac8rPJJcPTW5I5Ai_rV2g_3ooSiCBaqnh-n1mw>
    <xme:5nEIa9ZOUYMwXAtZ0_VH_bSvasiZA1RGK8A-B9UJGXWK7AguxO1awJF4SethiwA5s
    g9esG9szC5x3u-MaKu6O12W9PjOz84zryZ35Jii_8qFBScA2y94RNU>
X-ME-Received: <xmr:5nEIaxWTR8uaswao6aUk9YwjDqyiWLabR4E90ZK9J6_1iENrSlqz3ULnBPOEFR5Rkv1W0D8kzmWWkQQOmPYqzWpfHd42oTy33Cf_GCc>
X-ME-Proxy-Cause: dmFkZTE+Y6aI/S6uQBz8DC3jb4FV/DefjOvN0NDohunixqpx7lZTtSmXVwQOW+wdLxpEXW
    k87b6SHoRvmAn0APsfh/gYhDck0o8pTkPRQz/zRFy6cV0WvvVFWBUW8akCaFkHCXnQPP0X
    oIabuFf9Tmtt1CvMBc6VHJNm/s2R25ABwIeZ7RgzMGFTwslxWWsADKVBE7bofcJ4/rPq5N
    yhEfYNJ8NvSyzB+0VFWwmkOR+7Hfxnp0rQgCcINv2xyKAxRk3mDlt0Ndfofpruf4qYh2EM
    BOU324vvnEkGdzXEfjT+sCfLbqIRUcXdWJSW4I8NMe9kHurZEPZUgq209MNs+78jxICPZ3
    GjWsUZG3gA17kmzeDxcJMmDeX2nEwegmOGr7k2pv6z5euGouyRXkEHdGLQwkjbkpJvPe98
    +W75nqdfzyBLnFC7s0qg1g6UIi0XpBsxwRepcrhXcnnTME6YEBdYpPsNIGFhemi6q2hoad
    voovrckjzboWaimuXgAYbr8Df236D0VqvghW/lsGI9EalBMj7MTIe9wxf03dEfzts91kj2
    4T8+h1Oi9rcWFSkKSf7F75qt1XLZoPhLG+0x9phkqDau5yUZ/zmiND5UldqU/5sp5yu93d
    6s65dwaXBE5uT8AKetDdzJGprqilFmLO/PC8VY8wq50hejU3B0vADC+bY4FA
X-ME-Proxy: <xmx:5nEIa7mb4x0XDJIeRIF34HpqbvFVI3LjBkhG3hN6aT1W2PxhmLoX_w>
    <xmx:5nEIa0ASnFy21t5LFQyMCkBZRVQUtfcXdpWvl03rLJMGkbeEa_uxdQ>
    <xmx:5nEIayhDkdrDAFiyvj07l6byykrLHpp-kyBOxsK-1TWdrReCnImexg>
    <xmx:5nEIa5zY0q2Vm1tWp6kxw94BzbjPztOYk2MiHhrXF2aL_2RU4h1iKQ>
    <xmx:53EIa-wb3Wp3Gkvo3V01AQlZ5Zm1_zdQTb352__eVLCY9FrcdtNjDKoE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 12:52:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julian Maurin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Julian
 Maurin <julian.maurin.dev@proton.me>,  Julian Maurin
 <julian.maurin.dev+github@proton.me>
Subject: Re: [PATCH v2] remote-curl: honor --no-thin when pushing
In-Reply-To: <pull.2328.v2.git.1795684746909.gitgitgadget@gmail.com> (Julian
	Maurin via GitGitGadget's message of "Thu, 26 Nov 2026 09:19:06
	+0000")
References: <pull.2328.git.1795595886592.gitgitgadget@gmail.com>
	<pull.2328.v2.git.1795684746909.gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 09:52:37 -0800
Message-ID: <xmqqo6bbo4yi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Julian Maurin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julian Maurin <julian.maurin.dev@proton.me>
>
> "git push --no-thin" to a smart HTTP remote still sends a thin pack.
> transport-helper.c does not forward the "thin" option to remote
> helpers, and remote-curl always runs send-pack with --thin.
>
> If one pushes from a shallow, treeless partial clone
> (--filter=tree:0) to an HTTPS remote, a thin push lazily fetches
> every advertised tip's missing tree from the promisor one by one,
> and --no-thin has no effect over HTTP to avoid it.

Incorporating this use case into the commit message makes the motivation
immediately clear.

In builtin/pack-objects.c:cmd_pack_objects(), creating a thin pack in a
shallow repository passes --objects-edge-aggressive to the internal
rev-list walk, which visits trees of boundary commits; dropping --thin
switches to --objects and avoids those lazy promisor fetches.

Will replace.  Let me mark the topic as ready for 'next' unless somebody
objects (but I suspect that the rest of this week is relatively slow, so
I'll wait for a bit longer than usual).
