Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9D1714BF
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229549; cv=none; b=HEX/VD4L7pfsb1K6iMbqres0tMuQY/R1Pk2eO7ggDiuQDzgLg7O299BX3sd3yO6msitWx5Dxrp9xhAxiwLis5tv20RGJdtEW4o7PGvYqwRmPGorjnNA5n9NZ7cNrtj/OdYNL80/5C560HzNvPGuS41YXbVqQ+0w/s9uagNQZRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229549; c=relaxed/simple;
	bh=g3tFZX8IAM2yCsnye/qAZ/3FbrqitDPK68h4FnHb+rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0imdVv/fLW4dAyD1QDE6VpZfMEpoQqgzFYagzsRJburkCyTW/xAK61WRl9uRUrXpjubsK6OmHV7nze/0Svn7bpmKlMdmVPtxk/LKQjqqk7yEALpWGtSdjRq4uOO+m6THZJHUzz/rwHoNLGz9reroITDv2KA+9YnqDZN1RGOYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YIbNjdAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZb8Dl7W; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YIbNjdAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZb8Dl7W"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B029B11400FD;
	Fri, 18 Oct 2024 01:32:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 18 Oct 2024 01:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729229546; x=1729315946; bh=hu0YkiqLLm
	DETIBgM4eJQLyc+byStMXckPGriIG5z9k=; b=YIbNjdAbglp6PVieV3delytqJ+
	O2PpvhHoc168WXwFV6JZ9l0WaNUuP2ELe/FYgR3jW8P5SGU7eJ0ywwwOQ6tZLvR3
	Y6/dH/TfZyugmqU6mNIAc+Af8r4aCRI+QpFgOk6ul08pY6sjPZf3XzgutJpEjX7Q
	ySLVYJ0G1K1FTqmvkHS/HMxU3vG7ffYAD4FFetDswane4c9FeZ5zhXO75mb10Aev
	fAKuAIgSlSNEXot20wIT+k/l8IuIi2w+TlU++LYpKOfkEAxW62fF5oU1yOy4bEdF
	YUOeL7rD1u0AHaXTt+U7hFNLRDPT2eYP/KTiQYvVEJijUzCjr56iIbhxutow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729229546; x=1729315946; bh=hu0YkiqLLmDETIBgM4eJQLyc+byS
	tMXckPGriIG5z9k=; b=hZb8Dl7W8Bnra93yFDQc+nmAxM1Sw4AFJ7qGiqoco9Xu
	WOo8KalIMywY3wthh/2gSa7ZPiTUpN/VXtjYEVeDQWwSiftyewPij4csawQxEg6U
	uCoxwr59kPwUbnt1pekcYrBVAChZtTazEI+cj89stVZYGaLExjbTtvEUmzsrLZRm
	oJF1obexZBsle1i1rcd59KaE/22E/5HRVdJ193vE9zFZYSAHNOQi5bP6macPNQHm
	DPtxOfzdXowxXlYgM391/A/xeaYsQ7Bzy8EB14ohxZn9bvdy/j7B8270lqQ51MRJ
	MrMsjCLdM1rWqDGh+L3UsL/Qv0rRmXYC95S5bSLabA==
X-ME-Sender: <xms:6vIRZzcoqa96r53rG_jcYlONrYByhJk1CvNgpgE3j79UUYfAFTgY0w>
    <xme:6vIRZ5Ol0dGwxiXGmTlhUIv0dXKm3IpFqH8jZsIyk7oymeLOdJo5BaBWXzNgbZ_w2
    DtxGwY6oh_IVj-mYg>
X-ME-Received: <xmr:6vIRZ8jp6cVlAM6gc3397VaP_CTyqlQiJxdZF6flR-7oq5eHc2FatQAbpGx6Jl2upwNnbdqx3KOhe7vN5u0ZCj_vWgcV5AQ0bBjNkYwn5SXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegruggrmhesughinhifohhoug
    hivgdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6vIRZ0-m5aUpx3Z5QVk7liBDt59_RYYRxNidhYhGkDIieLFgoiJOQw>
    <xmx:6vIRZ_uNSgWyPbh1OAHdpIIUKb6mWUiiFcDxMAj2AWTkRlDlp--OlQ>
    <xmx:6vIRZzGSmErIsAnwt2VzIsaKsnxj2mcIiYGx14mE8H9mJfN8ESdMrQ>
    <xmx:6vIRZ2PWF4y_oyKKNN4NwOHitnWv8LyPe6NShPChCuo9FbVKnIK45w>
    <xmx:6vIRZ1V29PrRXh-mvZUzERRddUQPr-3Fm6TKvJhYk21QeE9GWmJN_ZYN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:32:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a8c4ee60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 05:31:03 +0000 (UTC)
Date: Fri, 18 Oct 2024 07:32:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] credential-cache: treat ECONNABORTED like ECONNRESET
Message-ID: <ZxHy5Q-0KJ0q7c6m@pks.im>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
 <20241018052952.GE2408674@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018052952.GE2408674@coredump.intra.peff.net>

On Fri, Oct 18, 2024 at 01:29:52AM -0400, Jeff King wrote:
> On Fri, Oct 18, 2024 at 06:36:11AM +0200, Patrick Steinhardt wrote:
> 
> > Subject: builtin/credential-cache--daemon: fix error when "exit"ing on Cygwin
> 
> I think this commit message has a few unclear or inaccurate bits,
> because it's based on the earlier attempt. E.g., the change is now on
> the client side, not in credential-cache--daemon.
> 
> And I think rather than say "the daemon exit rules are intricate", we
> can actually outline the rules. :)
> 
> So here's what I had written after reading through the old thread. It
> would preferably get Ramsay's Signed-off-by before being applied.

Works for me. I don't really care whose patch lands, I just want the
issue to be fixed :) Thanks!

Patrick
