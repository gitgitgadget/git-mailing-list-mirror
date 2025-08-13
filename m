Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E2D223DF5
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065531; cv=none; b=XpMyBIqdhJWGoXDPsmIrWaIItqEmpKbZOm6sjvMnGBWDqPBOb8kaXV9qA5IymVw0WILqllIgF7W7AYolzb5mAWJ4GcV8FXpmh7tb7eL9ZM6nDThcKkeTFn19g4Qbfp6QXU5Uope3RoAO8q7Krm+sUcf8mv9KSYuu3OjMzGUrrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065531; c=relaxed/simple;
	bh=p24EgeDEiDCet5JbNh5Wx+cBWfMN5U6rfJ8wz0/UP6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMTfb0l+8QtXULEekY0KceNO2/olkssmV+SyLhnc1N3Y6tTmS8hC6S8uTcskLdR9x7nCSaQM3H5PZq8FIbh4LEzhrCKJtXf1qDMdF0IFeXaLgb+xroi9Z0bv+pOZAFtKButpP3Lt22/UCxgTRhHKYVQDPN8wA80/NUm6KLfVNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hqDe41Ea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQAhChip; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hqDe41Ea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQAhChip"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01CAD7A00E6;
	Wed, 13 Aug 2025 02:12:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 13 Aug 2025 02:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755065526;
	 x=1755151926; bh=Lzg8t0ru2ECleVySRcpyyEYvXpKF+ndEMQzi+rYJD2c=; b=
	hqDe41EajxiOqVr8ql5bDycWGFko+4/Hao1S+QYo2AMICJU+ynuLVplQsm3U8lml
	9myjptN6zeQtSlKhCg9j7hYhLJws9DwKgcdVibcRURD/Ro0mLd9H4zY4IZs5upEI
	5CTwfmXJOB7o1IaVNiUCBoEAeQ49Efw/Sf/4JyzbIeubYutK/nl6/7KdySdmJ6Qt
	OqZtyALxI3Tm7+RcdibhUdgfUdqw3gsx3uIOf/mCL460RLtGcUAuOotHjJI+ldt9
	5MRfjAeFB0ZvtDD7aJdP9lG7N5TAzp+3M7Ak4Qqx0BqAWEP/BEErDngwomBa/DSw
	i7QfQ3zviX6dSewIIfVgVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755065526; x=
	1755151926; bh=Lzg8t0ru2ECleVySRcpyyEYvXpKF+ndEMQzi+rYJD2c=; b=Q
	QAhChipQ5mwjZDF+kpzJUArE1TlxCkZ97mbUMi5wtUR3N1bJTIkfqcegB7ejuANu
	Upq9N6T1lgRiAExFCNPJA8vqOAeOLZfbiAfhL/Wt2UzjWRIHeT6WrEIMQ/hsYvDG
	L8XJudAuaMpTgXKEunT4Ho+oWl/SIwC3fenpPw0ZyY8x3eFtihUqgM/xkQacAc1W
	0uFkWEE+KXjiIx44ZRf8UsQ+FU9iKzCzIKwjsy7VKpOVS6dUUuRR3hRCmtLLHUz8
	atO052qO26hQ55j2BCBAhlAR1VXgDEuw/mNwYiE7u5Ag61Xy6UyN98S2kmH67H/j
	7yLBJvpVA8wYnCr896+yQ==
X-ME-Sender: <xms:tiycaIxAaTfCH_HT4Dgd32DO1me1mP7sHHxQkBVD-Ye6fH8tnPfV0Q>
    <xme:tiycaHzW8LPUPDGOh6nL6hYb1WRT_CVUGKxCVeJj9HPZhZkR-zQCb4bA7BtlgC7Iv
    BN28fN8huqRTWB1zQ>
X-ME-Received: <xmr:tiycaAzlL8YJDExEujwZIo1a1SxzKqnoNS7DUgfooToKkAC2qafUe7mdUdik-ZqiapdUDZ6_2PxhdF-AEgvYyoB5qqQjR9w1p2Uzogi5QWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tiycaBYLUy6MluUxlhRkCK6zLdZtJPrSBzPTuj4OqR1S8pCRQbMNfA>
    <xmx:tiycaBXWlaUmppvronZLqUSr2PVsMsYsQRQpUeyUxsn19Sn4We3IDQ>
    <xmx:tiycaPhMuAbAeMHu5eiu477c5m5U8WGgvfS-6cdfneQ14KHCSTHt3Q>
    <xmx:tiycaPvWsG2190wZyj5k_o55uv4C2H88otySNcgmRlosNpb96jMlmA>
    <xmx:tiycaAvZen4otnijIwWLvdgj1SYvQuYLmkwhptda5WNu5_ehmfAcna51>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:12:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f58b2f95 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:12:04 +0000 (UTC)
Date: Wed, 13 Aug 2025 08:11:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Carlo Arenas <carenas@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] reftable: a couple of improvements for libgit2
Message-ID: <aJwsq-dLyQ9I7fDo@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
 <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
 <CAPUEsph_rWfbxobf0fWuGcWF=XNa4911FAXvB7agbfyUiZDr6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUEsph_rWfbxobf0fWuGcWF=XNa4911FAXvB7agbfyUiZDr6Q@mail.gmail.com>

On Tue, Aug 12, 2025 at 12:00:53PM -0700, Carlo Arenas wrote:
> On Tue, Aug 12, 2025 at 2:54 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > Range-diff versus v2:
> >
> > 1:  ce08ba1217 = 1:  1613715dc9 reftable/writer: fix type used for number of records
> > 2:  80a87ff19a = 2:  4a082b71fb reftable/writer: drop Git-specific `QSORT()` macro
> > 3:  e230c97347 < -:  ---------- reftable/stack: fix compiler warning due to missing braces
> > 4:  dd413b76a2 ! 3:  3977a1f497 reftable/stack: reorder code to avoid forward declarations
> >     @@ reftable/stack.c: int reftable_stack_reload(struct reftable_stack *st)
> >         struct reftable_stack *stack;
> >      @@ reftable/stack.c: struct reftable_addition {
> >
> >     - #define REFTABLE_ADDITION_INIT {{0}}
> >     + #define REFTABLE_ADDITION_INIT {0}
> 
> This define shouldn't be needed anymore AFAIK

It doesn't exist anymore after this patch series, as it gets removed in
the fourth patch. The above change in the range-diff is merely a result
of me swapping the order of patch 3 and 4.

Patrick
