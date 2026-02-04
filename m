Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3CC309F09
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186364; cv=none; b=lbaVu1mPIchTAmJeaZuwmRPj+JfEt9T+qAs1thek3hft3bbN1AhU5Gf//Kj32mO0BtC4DJ72Zbn8xKuPCNlDRU/3PguoYfBAKQI3KRDSxQP7jFWnnWomiXvWtgDM0uQDtjzgkPpzRJlPEQFC/c0jTnKK1XvoAl6T+k3loSQVivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186364; c=relaxed/simple;
	bh=Gr8qr/jocO/1RBgDQrtUkDXjaXkXB7D9LPK1FHQUghA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB4looTAFrEiAj8NYQrZE3LLuV4tSw1SqRGH593P5a0RFBS/9KTi1X5WJzkkGTb3YKWETF31lMqksIiqg5dPX75kILoKMWopsI6X6Q+m3FXchQfLJDSivWb+7DM3qkmcPamOqCcyeFYZN0tlW+xBg8f6iMmxwpLfoFIv19ChR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Eo5aoGgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wAkfDbXT; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Eo5aoGgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wAkfDbXT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A36407A0158;
	Wed,  4 Feb 2026 01:26:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Feb 2026 01:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770186362; x=1770272762; bh=nJe8NtOj86
	uZPmOzHcockygga0TiQMw+obsY8cbxZKc=; b=Eo5aoGgylNTCUVgj4jGos58hSu
	fVw+zxXQxDZC5p6CX1J9iGmmBq5U6h++Wlfr3Pht3vZh2fdT3w2E3RW2oeRvSnEw
	WS7YojSzD01c9fyxh0UF3EYZ01vudejGI3pXZCT8r3srCQxs1nPtSkFRLIxNsy2h
	ZAiV6xbluAl1HrDnZ8/Qk/pR4QstuMUcT+J1eUtephaxo/MLco/0Hjgz0h3J/D4w
	FckAO/CpdT7dNCYye7s1YEvZmVcFNxbCqIPEUFBLMyqG/yRZe9Q5NL1F9e1Wly8m
	asSSK1Hm/TJmohb0O2l2OiaiBC7opK3MQxFu/2NiOzHIRgi7q3eMFFQHaHzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770186362; x=1770272762; bh=nJe8NtOj86uZPmOzHcockygga0TiQMw+obs
	Y8cbxZKc=; b=wAkfDbXThs3M//BeXquDFqW9P9bnTwZkzYZetlJHjCfv6D14TEM
	qTKYiBCQjfcMEwAPFfu4m5QzXohO3oI1YCc5QoL+XxhYGUa1ZoR9o7Jt6MF7J3j2
	HpzxCpoggqvAoiuG01Qax3UlAgxqCdronRW+SVtC52R9YHQsbPx2sGCKqJFZraNR
	rYKnPyVlcqLkyR9Rr5BfjJK7YBlKNA2+ppCFqk/Eiu8vLtkSAjIP9ubbq9pcO4Zr
	aC5lFw4NenYABWA6QzXGFDEXxV1Yh2zEJ4eBdxNubdBqgwZO/3LmKCAz/DmGisgV
	DkfhcrlPayIzFHtLoHkINj6r6wv7lhnTgKw==
X-ME-Sender: <xms:euaCaSlVvn4u9mOLugrZtXSXjEjzCzCWaaFzcWXWTa790uN3WL9_fA>
    <xme:euaCaRQQK7nTyJdVguLEe1p5lZIND9-cQ4ZMJdemCjOA2RRVeewpvLDAB9rvQl58b
    CoLH4trg2J_4WMnVfOKDdvfDUbRtQCGJPP2VX_suDRFCrq1EHJKaw>
X-ME-Received: <xmr:euaCaeDYtea4VK_pxmq2hpjjpBVKysaTetZaRytAdoBgPyf9e8MiPBqkNmaVu4aPJUaxpek7RSUv_EUwV9_gLJec-OvMID8HLi-anCg83ioOxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:euaCaQQbkbOlz7dpXG2vopkaeEXD7norvhmomp5gbrPsrN8-nYa2nQ>
    <xmx:euaCaUqUH50iberQ-HaK9KKrGJunruBuPvhmH0vkqGimuQOP3gWqeQ>
    <xmx:euaCaawgdjCZCZO7UFc2Mo_fGDUq0H3r3sUHtpp2Ftc0AJ_VWED38g>
    <xmx:euaCaRJ7CXiyN0vyh6UOPQxNUrlP7nqzESd7j-Zst4huDZhcOwMeDQ>
    <xmx:euaCaVQbMsXGtAEFwbZetKPanaqiD2edXmHkHvOgPKcFdzbyIHP26pE9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 01:26:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce4a1a5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Feb 2026 06:25:59 +0000 (UTC)
Date: Wed, 4 Feb 2026 07:25:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] odb: support ODB source specific transaction
 handling
Message-ID: <aYLmdIh8WB7nSZPL@pks.im>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
 <xmqqjywuvd7o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjywuvd7o.fsf@gitster.g>

On Mon, Feb 02, 2026 at 05:16:11PM -0800, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Changes since V1:
> >
> > - Renamed the files transaction type to be `odb_transaction_files`.
> >   Associated functions were also renamed accordingly.
> > - Updated commit messages.
> > - The `tmp_objdir` subsystem has been left unchange in the version. In a
> >   followup series, I plan to couple tmpdirs directly to ODB files
> >   transactions.
> 
> Ah, I was wondering why the changes are so small (it looked
> essentially s/loose/files/ and nothing else to me), but if we are
> leaving the tmp_objdir stuff out of the scope (which is sensible),
> then there aren't much left to do relative to the previous
> iteration.

Yeah, agreed. As long as there is a subsequent patch series that fixes
the `tmp_objdir` thing I'm happy. It'd be a no-op refactoring for now
anyway given that we always write via the temporary object directory,
but it's a good cleanup to do on top.

Anyway, I'm happy with the status quo of this patch series, thanks!

Patrick
