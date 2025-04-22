Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC91EB1AA
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307804; cv=none; b=a1EzRsdJNyvRHRegWcu9I1izGEJmQpXzG1ZG2B2uyO53H+Y9NvQHHtTHbk/W1u9Zal6StZjV1NOlK/Hgr1X3rkd5bUJOX+kaD+YZaWBRwZA/TpldnrcwbN1MkGwFcahLkIlHZvREkymhsaLRUu93D5ghNnyY32CnoLZ0DDsBzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307804; c=relaxed/simple;
	bh=inIco1Ik2DcIA7Om4U/rtqWEiPvHAV6vJyLwbCEkq9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNFNaE0KlFQPAtDAUIRENsHJ6qzN0MWoRX7FadrdzMy/LNHPAwp9UEGb9RN7YuHXRlqB0H3M1qLDXv5ZmxuoOPb4wjeBFU1EC5c6c85tW6oKCi8amD4ctUTcunI80beCTIseItoWjDLMK3vLH9vvhZJkkN24HNA59S0VjqV2fNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S1olf7yo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bEee14Hs; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S1olf7yo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bEee14Hs"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EF3E4254022C;
	Tue, 22 Apr 2025 03:43:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 03:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745307801; x=1745394201; bh=/l4m0wQvTT
	NIwr2ZQ6r0+kUpm/A0kwliXpF0x/Cynas=; b=S1olf7yom9XpDL5nw804wQlKJv
	oKKqZ8THfJRiZfP5SRR5/2YP/5tc5+hyeg1CFTNQJLNsMoC28dpYaJKkEAsGrRr9
	LX95KgD6ZmCH6JMjzwHamu2KI3EjZ5uB1uynDv+UdwPROlHZjIGdWVqSRNteHwq/
	lGp86A6J8LTkc0ycidrr+0YD19LOY/DeF9JdMn0OdnspPoNiE5Hdb+cYdXbu70jp
	PD3WgWoXChcHNHE0ky04GgnR/uD03plf+ykQIIhhf7a6n8JWjlI0HWpj+GSqC3YX
	lgWYLYmBdDAtlAFaSSDkiOClJVPmbFvRoVv0QuDqNaNFL9/bPtXBF+f8em+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745307801; x=1745394201; bh=/l4m0wQvTTNIwr2ZQ6r0+kUpm/A0kwliXpF
	0x/Cynas=; b=bEee14HsXB7GTMv9R5Z/kzGke+JvYw+1iLHUR8ZX+Z8ghFyJmeI
	Wd252bJ87iJvFyxo+AE+mPxPMAMVPyQpwklVebxJyYpIyUFcWXydqeHfKON9sPhM
	o/XsnwJjdhNREJi6gkj+dUkAS/bPv33R1S2R2qfsPC9zuQXFUJ9mYbeFLzroxIaW
	UTGBkdQZgwzWqg6F1kf9l/aqg7QhNNueElilLadSQlTmybtbXggNSmm1IpuHoC8P
	IUEUf8jGlAdnlX7ALU8hn4odi/yfgpJtHFi0mpK5q0qh1cKe3bfryNSxDpo36SUg
	Wzyi4fDjomZWSvSt31ZQ2lMHw8kfSqUs0ew==
X-ME-Sender: <xms:mUgHaH_6a26AauoMBmtHIaaVKUVyla4Mqn1V9ACEfMk_FmjxR3kVFQ>
    <xme:mUgHaDveEV7_mvtsUj_kFdgv6CFWJ_pqjCmC-gqtN3M7_D0hY6bx-4tiF7m_nikzN
    YWgNy2tGsE7gwKBqw>
X-ME-Received: <xmr:mUgHaFD5CBvN1nvjINgeMWOOSjhymaQlRwV16_umBi2id6vBYau4Kj9oNrjifIvzkB0nWs2yg8qXRrcpnDxxPwRI1uWtjWjsjVnCwiHkk_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mUgHaDdzcw3cRGzFKOwecfFaJtL2P3OZvvgrcCaQUZxd3qsw5sswQA>
    <xmx:mUgHaMM8o5jgnk5DD9oW7L76GUHlgy_8y_33y2SwlT5tjmqT7S3l5A>
    <xmx:mUgHaFmtwkTtKy-I44snPYaLnI9QF6R4WGGLSLTOjgN66CMqAGiwxA>
    <xmx:mUgHaGtWS509y3DBklSHpmKdPdEEEskPG8McZUvkdSTw__sbP6ceHA>
    <xmx:mUgHaM7J5aJ8-jOU7UY8Ou7J4IiI5c1-bpFdw1ybiAHKVKxCZM7JZHC9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:43:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81c3b4fa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:43:19 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:43:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/6] mingw: do not use nedmalloc on Windows/ARM64
Message-ID: <aAdIlq8Np8LpahLS@pks.im>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
 <6c2e17eca68b143eff7b33d195bc66a486471547.1745239150.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c2e17eca68b143eff7b33d195bc66a486471547.1745239150.git.gitgitgadget@gmail.com>

On Mon, Apr 21, 2025 at 12:39:07PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> It does not compile there, and seeing as nedmalloc has been pretty much
> unmaintained since at least November 2017, as per
> https://github.com/ned14/nedmalloc/issues/20#issuecomment-343432314,
> there is also no hope that any fixes will materialize there.

This kind of raises the question whether we want to keep on maintaining
nedmalloc in our codebase at all. Is there any strong reason to have it?

Patrick
