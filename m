Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2232EF646
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911581; cv=none; b=bTT1ohc1d7OUlqJCStVk+qWVfA0QDFGqZTUDxfY/oYFjdpx4QES3Ap/B6dvsoRbOAMR6HXPgG/YBjkEEXsWV7i6kPlF1ZmyyXiSwiFc453cdBqf7S6g7vRCz3CXe5eAeckLUflLQAtkEcFRveihJz3zTV2DQTgCbadiMIioUopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911581; c=relaxed/simple;
	bh=1vZtGKMw23v7A8+R5y/jmnp+v/mDJqRwNddWHf3Tcyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gf0JysYn2afrpGSLK6HUptlPzMuugreIDgjwsalRPWs//TdtnlUrPB+0sKTs5jd8t0SoNkXYkmB25JIBGroTrL2I9FrvqCRuIy5TbWbSeqRkbeqccqhln0gpK4AAx1/B9KRwzMehaY/C7xyW/SffkNx3XU/ECGfBqY1lJJwQFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dIjvsRUq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rThK8/Yn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dIjvsRUq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rThK8/Yn"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CF0E1EC004E;
	Tue, 16 Dec 2025 13:59:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 16 Dec 2025 13:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765911578; x=1765997978; bh=N1RrhRyUpc
	jgkx7QZgPx3YGvlHgMEcK4lsF1dcsDwAE=; b=dIjvsRUqLIzGT6c1ERyGPIWCys
	Vy8XjokDncYC2L0YeWvfwt4k0RLHnBi+77NosJi1olX9VGtRZ83Gjxvuvvjfx2i9
	g8WiZc7IDZ2LNr5X7bFtRRQE7RAyjkZYj1NMLMh2p0OvdtgcwlL8jKNml4Ri5oBZ
	vh15JQUP+GEzYsAs8r3lsyseVfsILkLiLl28uo1VvLGccuDHIRSlqbUaHAY9Vbe6
	iNVrJTrvFoJlMJtGb1l+7CmHClNEY08KmqNHWBDbHcH2YiKvFy19N9YufgZtPCy/
	oAafcT+KqiT5mAIkstPca3Tl9Q0hquvO5JJE8QrVYxYVLxPk+Dc0iTAJq9fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765911578; x=1765997978; bh=N1RrhRyUpcjgkx7QZgPx3YGvlHgMEcK4lsF
	1dcsDwAE=; b=rThK8/YnTG/jZO7nph0qW8wJZPvbcNqeOF6MXcutc3qENr8aFmq
	HbjvpfRTIrXaBG4NSO0fVHuYywfCUyRLcq6rbcq4Ai1R8k2HLXWZMXhWIRXJmToS
	W3nC/uep6JIljw3YUS6+IJwfj62XuwtNYoMB2AoQ6iaAmgGNWLOEaMHvIMZ8wDPf
	ncq2HsmP5QTVA6PStyvYJr7p/3zkeAYuanXn2s788uLStFE95994NQcVDQV+IvPv
	zZCl5qt2FckWnB+A/kbU3HHvh21Nu/sRNS2wuWjtEmto7F558JZoSrhhENXhfruU
	jCJA75OVj63CA6+Mdbhp2W5Ka3ute1Ch6nQ==
X-ME-Sender: <xms:GqxBaYo42SURZ9_cmv6cXoz3vQeNuQL8rhkgbY1sMgY16h6B9lVKZQ>
    <xme:GqxBaVj1rSyUV3xz9NXW1Y4i31WTJ6nU79PMnPUyHlV0YvBCU36OuNxPMntaotXK-
    fBAM2TFKfghgRnq7wZZ9hkUiNixDp7RuM8VhYwkg7TUDbv9tFQCpw>
X-ME-Received: <xmr:GqxBaVgZsXCMsaeMbRGGQ4EEOaEbTo-ykQ72dTXMTv7TCJqRwtBCs54AfYUZ-ufZU3Ni-OM2yZNpG2YjAIWuim6zj-UV8qYWIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegtdegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GqxBabgE7koU0X9KTHPuhaWQRgShmOObIIPy3tNNpSAlgW6JPDBH5A>
    <xmx:GqxBaVIPS94R45HIxN7P8O5j98TRuBdrv3XSZWSY0hGAvB2ieU3XRg>
    <xmx:GqxBaaGLTVX2-k0duOb2LS892ymIg6CxMQLnDI-ygJlpfXF02Fntzw>
    <xmx:GqxBaZRhHKrIoD5KRqej2CVZahswRiFR8vhOVbsuVyNSdbcjaXiaWg>
    <xmx:GqxBaex8RFK9Xt7__04Yyy0hU_cyVsS2a0n-TbySXRxxGH2BY7Iiklnh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 13:59:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  worldhello.net@gmail.com
Subject: Re: [PATCH v4 2/7] strbuf: split out logic to humanise byte values
In-Reply-To: <20251216173842.3357832-3-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 16 Dec 2025 11:38:37 -0600")
References: <20251215205639.2700270-1-jltobler@gmail.com>
	<20251216173842.3357832-1-jltobler@gmail.com>
	<20251216173842.3357832-3-jltobler@gmail.com>
Date: Wed, 17 Dec 2025 03:59:37 +0900
Message-ID: <xmqqqzsu2qxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +static void strbuf_humanise(struct strbuf *buf, off_t bytes, unsigned flags)
> +{
> +	char *value;
> +	const char *unit;
> +
> +	humanise_bytes(bytes, &value, &unit, flags);
> +
> +	/*
> +	 * TRANSLATORS: The first argument is the number string. The second
> +	 * argument is the unit prefix string (i.e. "12.34 MiB/s").
> +	 */
> +	strbuf_addf(buf, _("%s %s"), value, unit);

"unit prefix string"?  Prefix is something that comes before
something else, but this one is at the end.  Simply saying a "unit
string" would probably be a sufficient fix, perhaps?

I read the changes since the last round, and other than this part,
everything looked good.

Thanks.
