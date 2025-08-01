Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325A18DB1C
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754024377; cv=none; b=a4+JBZBzkl2/lJWe/NwbG4OPzm6A7rZYc6bTYDgwBR4vyv5gr5827i1h0q3m4X5DlofUY6EyruGwCKqO69S5zHlAIEF8u2WeJxQ2jYps0DEGYt82Wy6ORWgl3ivcHbOq0lSsXuKvpZNEMo7EAlBNeUQulQIgGdVfY//0cM6BJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754024377; c=relaxed/simple;
	bh=1nS9tCGEzmiw6Ney0xCTQLTRy/Q7gDrau5vGCj20Svo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXVC3p+NusC0M1ZsR88wPwWRigBX1ZUohS0QWsNUldRv42QwRdqKFuJEmZjLWtZZyngXCi4pYwwayxes5TGsCK9xAWJZhymSTJdxdVM4vgqQi647YJrh5fgs7jtd/Orf8qO0AKX9KgDqlDyvlIlvY80eWkwz8ANl5HYG2bak5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kmEmjZn6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrAtWaUa; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kmEmjZn6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrAtWaUa"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD49C7A0868;
	Fri,  1 Aug 2025 00:59:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 01 Aug 2025 00:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754024372; x=1754110772; bh=jX91arpTE1
	JurcnVmMhw1PNth14ZjYC1Zm1vu41mwkQ=; b=kmEmjZn6y8N93dcIUP3rt2v5zX
	zc82UakLDsDJiGN04nNsFBWlL5D9X3CCQo8HvNmOdqAGRt98rr82Uif9U/Vmq6oW
	L+awW5IO95bMihwkAY0op82GLOri47G29EquU6mrtDt7bJFMmpOphi6hkGGc3g+P
	QzzSq2pmJOHv/1EBVvYR/MejLxl5GcAopGQlnJSjrsiXyXDRlORJuUN6Be54nNt4
	+ULLQOHaR1KXIlJcT9jrrFRht5JO3uwRRckFIbwrbsHGLFTo664WOmAV98K59aB/
	z3qaI9LZNoZ7ksEAZvZRmputc06ekuYWgKPG+yd12p+OvnWDkfUtsXxs+OoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754024372; x=1754110772; bh=jX91arpTE1JurcnVmMhw1PNth14ZjYC1Zm1
	vu41mwkQ=; b=jrAtWaUa6/WnF33Hpb1l1xgmC/KBR3/7av2SIbe1TE+Q397CJ90
	DseSXBzEaIOIUGLviT75b1mnS99vUof83o6MvAnMUUMizjFY/5vJysc5D/8rRuxY
	Uvp+tljPMtO9vfxdyU5vgRZSpk96JAs9Q00VGa7G9bYjr8HaYy7vMRbmTC14dHV8
	QRkJKAm3Nk6tC7o3KeSuNc7oQbuDtWWYs53KDJI9hqzZTiLZBbia1+RgaB2/+OAs
	8ipajYeCUAntE8fNxwoc+csgjqlBUDFP1EaPvcCYqkiIIXTc6J96be9lUBxECao2
	n4U9NieAkVPAP+2LSN+348/6aR278DaFTrA==
X-ME-Sender: <xms:tEmMaOdIDUF7zeVQAyvpGsbrjxfZUk-b_claJ-LD5imLlT7aWKTS3A>
    <xme:tEmMaArv3nHiNLmWv2SPDmxMcaIoZwxtOwDd3UkuI2yvUNUkxY7Ck8eA9lyLyQEJI
    wSxoT__Z-KIdeoLPg>
X-ME-Received: <xmr:tEmMaP8y1LODxK0CKcfoX5p6lhpfpeJVybLiNq8Wsefm4LynM_JMlbYh88ZijtHih7h4DsTplnolpI9SZYHKkZOALlRrZFh6oQitckjaEWD2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tEmMaMeftMLwJFM2X9YIpdxr912KF0UlKAF-rsUVAXsSQgQst8N8lQ>
    <xmx:tEmMaJLwGJsFYem-gxWQLfBHBIIoC7_m7orysztf0HgJUWTf5G2eCw>
    <xmx:tEmMaMgQYuJjXLvTx_uf8INXafWEhYAXSPX3CbdBuu45GQVnlKGIYg>
    <xmx:tEmMaHTZAmZM9dEqwm-LFVT_9jCFO9yJ2w9jdVxD3APdj68-QIeXfg>
    <xmx:tEmMaJ6ux5OpFiIm_lajB6B6QsQOnqqYX2To0qedTuYXnxpWmOllEydL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 00:59:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f903b4b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 04:59:30 +0000 (UTC)
Date: Fri, 1 Aug 2025 06:59:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Han Jiang <jhcarl0814@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/6] builtin/remote: rework how remote refs get renamed
Message-ID: <aIxJrvqLvEl8qM7V@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
 <xmqqcy9gqiht.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy9gqiht.fsf@gitster.g>

On Thu, Jul 31, 2025 at 12:15:42PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The series is built on top of e4ef0485fd7 (The fourteenth batch,
> > 2025-07-24) with ps/reflog-migrate-fixes at de7cc0782a7 (refs: fix
> > invalid old object IDs when migrating reflogs, 2025-07-25) merged into
> > it.
> 
> I'll use the newer iteration of the other topic that ends at
> f0fde561 (refs: fix invalid old object IDs when migrating reflogs,
> 2025-07-29) instead; that was what was used in the version in 'seen'.

Okay, makes sense. I'll adapt my local base to match then.

> > I'd normally have withheld sending until that series was merged to
> > "next", but given that I promised to send something on Friday already I
> > decided to just get it out. In any case, if that causes problems I'm
> > happy to wait a bit before this series here gets merged into "seen".
> 
> Thanks, will try to include this in the batch of this evening.

Thanks!

Patrick
