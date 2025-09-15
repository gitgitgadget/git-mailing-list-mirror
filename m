Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21552652A4
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916306; cv=none; b=oWxezajCVZzmrO4IhF+COi0qEPr1inzb10A4iWu9cIsHiPbIViYZ32ATw7J2Mo9jgUs4Ar6FC+q8qW8z4USYhUyztp8yLZ+kYjR+F7qomhbrA9WxZxbAni75hLG640yfuRNytbmMHLqQuk3Jd0Yq5Go9frWOl/QGVKiP26pH9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916306; c=relaxed/simple;
	bh=1L37ewgighCksADXPUpuijxML/OhGk7XFjrFFSKxpio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6C0uzvMOFK79fv7NekHAwmt51yMs9zu4R2iQX7ZySnnRhV3WuhL4jeMiQfDHNYfzLMOQOETqylOq4u4vzvtQpjPVmNbEjOFwrQpHwxbiEgboxfYZSzAlHCa8QeyOcSNFHm7Ts61oDNzd2fgnWiJWUJGHH+06r4DowLTCgLoLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ltxe/baD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XmcLaKY5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ltxe/baD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XmcLaKY5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D9870EC020E;
	Mon, 15 Sep 2025 02:05:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 02:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757916300;
	 x=1758002700; bh=B4qgWXh1DDQNmhA/siYT/ooVwsIImLm9IntFRTooopE=; b=
	ltxe/baDA12oEg6OHygJPYeQIMIXURtgLA852LECstcsMTDR0rtPHU+eSwZNTVov
	+3PTBg5FQ3XKuUw+J2yf1OEAEw1bnnTx0pShn65RU7DJB/jV16FQWP4YI7i6btrM
	TQbyWtuzW6Ya2xmN2dlnz/QviOFcwiFzEt9DeL9xOVBDoFGIMYtlCnqbvaSbgV2l
	jH3Jb0/0lKuW7Co3/dTjZtzDDoynLIu1HObga1p1p2eoA2rmXm1m9D4j2mAkKV9D
	tpHrWEaM3m9n4dg0SWG9bnEDB7LTHnZeIOc9I2RZIvE2eftCC8De33r/FI4LZFZO
	mqbEMABJLDNgLP5o3HI0ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757916300; x=
	1758002700; bh=B4qgWXh1DDQNmhA/siYT/ooVwsIImLm9IntFRTooopE=; b=X
	mcLaKY5rRzV7fKMr1G3sfpitOMHFBDKrMdvoXXJib/qmPs73i6bBH/dzMJNbCCnY
	z6Ay8PaLvt7zavTU3PpX4D1pbIt+8mKP6owKyCfK6I8SfPYaGe6zsX2BZZjEz515
	zrNOx58lpkMTm1dZuK38mYvvWR1eUl6KWF6pOgun0LhvQrz1xYozvEw1GimapJJt
	LeWI58gEizCeWdh0zSadFIJJhgXPyjhswCFv9yejhOwaTJ4BxccBxHskhN+xaHLX
	z5ds6dUdmbPGDT6zxrsyZQKkJE+R9/nuu7FGN2rGknWHVwl6UmGhOxrcjhgbSqD8
	bgLxAyojwQEvuo5/5IXzQ==
X-ME-Sender: <xms:jKzHaMsKXBVRSzv4eEeYYyyenxsKc6AM7Y99peM849ZhSUlBwWjCpw>
    <xme:jKzHaMsChfuDFtoiYQqPZzQxjdYu5WY-kFZyl140iSJ75atcLq4zj7gtb43P3kfIm
    t5sj9mW73ctzVRBjw>
X-ME-Received: <xmr:jKzHaBMWEx6_hIlQi6Ou529N-NCS0OU0XRWnGJKRahab5eQpwP7E76AmjDECQncimArBNiDLODRkVHYFfHwh_8XHkf1cYlOAn4-606O4VGckEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jKzHaK3z2jFrtTG-Ib5qHNtWY4vcQ7INQW9sqZO3--vNg4nt6Zn5rQ>
    <xmx:jKzHaNOvNKUsQaE5pbmYDpfTe9x63JsRCmaElMeS4oM881MWi-vgxA>
    <xmx:jKzHaK14vSvnZB1rFtSXl2vmBMhTepsBPCCmdKk4fJHNVRi2jDwtcQ>
    <xmx:jKzHaEGQwoIj8G3zNgCVCkwXuAqz8xFNkinGWcZ528f0oclOSnFZHQ>
    <xmx:jKzHaBXD4Utc4eiBwuL0vgYO1xiDYoB_u2kKuquzQIf4BDIgymZhukuT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 02:04:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d3afd67 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 06:04:57 +0000 (UTC)
Date: Mon, 15 Sep 2025 08:04:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/3] ci: don't compile whole project when testing docs
 with Meson
Message-ID: <aMeshpRtFWyE0ja4@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
 <xmqqwm64orc1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwm64orc1.fsf@gitster.g>

On Thu, Sep 11, 2025 at 10:02:22AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > these two patches introduce a new "docs" alias into Meson and use it in
> > our "documentation" CI jobs so that we stop compiling all of Git only to
> > verify the generated manpages. This fixes the issue reported by Gábor in
> > [1].
> 
> There are three patches ;-).

Oops, yeah. I added the summary patch close before sending this out :)

> The end-user facing get_option() is called "docs", unlike what the
> "make" side understands, which is "make doc", even though internally
> we call the target internally as "doc_targets" (not "docs_target").
> 
> I wonder if we want to let people say "meson compile doc" to match
> the other world?
> 
> Will queue.  Thanks.

The reason why I picked 'docs' is that the accompanying user-facing
option is also named the same way. It's thus a bit more consistent with
itself to call the target 'docs' as well.

So I slightly lean towards keeping 'docs', but I don't feel too strongly
about it.

Patrick
