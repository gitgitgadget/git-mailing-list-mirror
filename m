Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD82B9A2
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733204195; cv=none; b=U8/XEsp+5vA8wnXEYJ4RgE0TAeH44lFYuhdY3idkunSeuWHQ6GgBTQo+ydURgBZWezD29AfU7NIBJV2M+EnLSfjkBUIjZZj2+cNRZl5ZjliyvZHy0Szsfol+V1zKQXnv3U7STkta1foybfRNcBTR+c/Ln3BNCNiPX7MvvfhRc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733204195; c=relaxed/simple;
	bh=qvI3qy9IV9Lr+nv0Jo4MMGYw9oQ7VCOexpLhvjvbjao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N8Kx2+hFg/oDYHy3SdPKDt/8SRNOPU4cABKk6+4LK5s/LmCUyJXMZyMUpeZSZQsW82BsFddS104yXtGqQXZl53Wwd4ZyU2aHgouq/+ehAu/F+OYYTbrDwho4wEM2hVF5vF465Ls2aN3MHyMclXYZPiyLuaCLyd70hrGENaJ6Nw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zRyHgAlB; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zRyHgAlB"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63BA92540174;
	Tue,  3 Dec 2024 00:36:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 03 Dec 2024 00:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733204192; x=1733290592; bh=qvI3qy9IV9Lr+nv0Jo4MMGYw9oQ7VCOexpL
	hvjvbjao=; b=zRyHgAlBAfhuBezZ54jfqzfqhh5tzW9oFxueCtqD5ww6R0ZxCF/
	fuYwntGN/4m3SrYP48vAgPGvG3KUI62GdYFIf3vIpbmCiUr++7iT5SD6JV6Y368P
	SdhYNalB/gZOAp+xYlvRpF633zt3DIpM9hy4bX5AiSNwc7HafWZHavE6BZJ0yZB0
	L04+Efh1tdWoh6zoZvt+8IDfngM7Yv7W3TF/meMO3VI1y337m1JeFIICE6Wq6zkn
	LwDe4Xict3w5YDZQhUBpzbR7MWIVcb5Ps7BeNihmfc3Hxllq6VlaaiOsBq/crE/K
	uHtZmzNvQu3l5pYgYpv/heyeKE/GIEXaWmQ==
X-ME-Sender: <xms:35hOZ4eNtFm4Fotz65oCz97Z9wKOGX8cRtXjyDH_1HKCdyPt374ZzQ>
    <xme:35hOZ6OocTsc6h1tys4lXWRkiQkkq1HCOlOQP-AKgjXHnzvN_qnQZ6hs5BEts5-zU
    T1LY6eYFnpI_Iyvnw>
X-ME-Received: <xmr:35hOZ5iXizQfGFnjeJ4l0uSq3-M4aLR5tSVznEm7DfxKnsNaPvP-jsDCpx5LaHGb8XudLDHIpvIL_7rmi_YHRgQzq6ovz4tyq3R5998>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeuudejgfehkeeggfdvjeffudeftdeitdfftedv
    lefghedvffeigeffkeeiffeiudenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvd
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghm
    rhgrshhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehmhhesghhlrghnughiuhhmrd
    horhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:35hOZ9-HpZ5tC_gBBp05yvaYXHtj4IcV_h5y2YGK9rD324RjDpY-uA>
    <xmx:35hOZ0v4ZCRSDynds4bJNA2vZhmvPaURdVHA7qFX2sq9eLACZfCu0w>
    <xmx:35hOZ0G2G6YLny6RUROgbtTL-n8Hr0qz75P3GhW_Yy4sHoyza6o_Mg>
    <xmx:35hOZzORFHSQIcz47_eSqiq6vBA7VTPyr3LJN8oAlIxDt9HYUdlDuA>
    <xmx:4JhOZ1FEIzQaK9vPA0Uy6BsYGSTjxpPF41u-5CC-XBw3q7KsMPsSwsZx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 00:36:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  emrass@google.com,
  mh@glandium.org,  sandals@crustytoothpaste.net,  ps@pks.im,
  sunshine@sunshineco.com,  phillip.wood123@gmail.com,
  allred.sean@gmail.com,  rsbecker@nexbridge.com
Subject: Re: [PATCH v5 0/5] Introduce libgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <cover.1729032373.git.steadmon@google.com> (Josh Steadmon's
	message of "Tue, 15 Oct 2024 15:50:52 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1729032373.git.steadmon@google.com>
Date: Tue, 03 Dec 2024 14:36:29 +0900
Message-ID: <xmqqjzchcopu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> A quick note: normally I'd wait longer for more feedback before sending
> out a new reroll, but due to some firefighting at $DAYJOB, I will not
> have time to focus on this series for the next several weeks, possibly
> up to a month. I wanted to get V5 out before then, but please understand
> that I will not be able to address new feedback for a while.
>
> This series provides two small Rust wrapper libraries around parts of
> Git: "libgit-sys", which exposes a few functions from libgit.a, and
> "libgit", which provides a more Rust-friendly interface to some of those
> functions. In addition to included unit tests, at $DAYJOB we have tested
> building JJ[1] with our library and used it to replace some of the
> libgit2-rs uses.
>
> [1] https://github.com/martinvonz/jj
>
> Please find V1 cover letter here:
> https://lore.kernel.org/git/cover.1723054623.git.steadmon@google.com/

Haven't seen any traffic on this one since it was posted.

It happened during my absense, but that is just one potential
reviewer, and it is unnerving that nobody showed any interested in
the topic, unlike any of the previous iterations with active
discussion subthreads.

Anybody interested in reviewing and championing the topic, or should
we wait until the topic gets refined and resubmit?

Thanks.


