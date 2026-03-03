Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF23382C5
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561820; cv=none; b=QBu6WeeWjm5EXwqzlLreOWTBxoWi7tie+za+xFeLXada2nVzC8V7MGf7KQ3w1ie6woKsvGR1gURN9snlsVgpPJ2i1YPxN1xaLqBaCMFkJ+hkyr7KiWpGEDrGMuXI+ZF1piTwF2E7zxB92Gj6pInv+Fn/jURWAIFbBq1UWn5Iv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561820; c=relaxed/simple;
	bh=X9mh7yVNIs1QVBCq5j32hYa3qxQOPSnw94qmDE5yZs8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ep6lZ0LyocE/iEHqGGHy9s0TVHupbnxWnxS39fS4u0pRN/OMdrvAS7jcEGPWI12anizPq0rkVvX/r5u9H5e1OpqM5cn2DDZuw0BVoVXSQUshQ6mn0FcYF0/Je8BpiIJDjO5yXqBkSsrNbqKu1PwU7cICFPfNwgXdxPAWROFQNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=m9rNtZYA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gueuAzNi; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="m9rNtZYA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gueuAzNi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 402261D001E7;
	Tue,  3 Mar 2026 13:16:58 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Mar 2026 13:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772561817;
	 x=1772648217; bh=BrHVOljjZzmgAM18w5hlR/hqOSyb7/7UAiUk2DW8PFo=; b=
	m9rNtZYAmYPtgbPPiJQEsN5u9Ru4sSP99PnYG0GzgJJ9Hb1P1VWFlcJUyP4Mysc1
	VTQDaBkAQtR8lm+OW7K1N0mrVl3q4eR6vpqxqn7IFL9+WDqJ9HQ5ZsvNn7UHZtxi
	K3rZZJXdB5n4IyxTrnU2N6hZo+6BrK62UatakOZRUNjNlfaK5tLdn1YwbozYXjvJ
	c1iF1Q732iGuZ0eYsG0jLnDOtNVEzEV2lgZ1H+fBBQAwWTC0bYWGIbR9VT9SxvjX
	KxAhFcKP9btsxdHQlQFAmvalPKyd1MsdkeeLacIrINaTdTMItQut0ONL15T2mpVg
	41HE+tPydwpOWSXodgD9tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772561817; x=
	1772648217; bh=BrHVOljjZzmgAM18w5hlR/hqOSyb7/7UAiUk2DW8PFo=; b=g
	ueuAzNiogZcQkxHR6K+2tbbGzx4yWVjEsYfPYiTJ6W4tHtOHH/7wAjfVWdvw2Qwh
	LDrMz6l4yR0TWHbHtN3eCmWKs1+YzkgKvoLOqbIxL8mZth22VpDtbRYhEawgZ/ag
	5FTiYPbWW8al2H9B5THCEJwWAFFJgY7rUsmey44ZwSbeMq86yGR6xaEr9uqL9l4R
	8ZpsZajJJIriB3HvOHTe1dja6etf5gDqj5+MA5Gyg5rZ2t/QIpaRPxDpvozfOv5y
	s41zJZDoeZ5nQCk0pu/CZTqd5ONGUEEE5V7UXw7+9sBnizGi2f7OLmOqEXslV47d
	bfKNv6FduTTLQDiKBsH7g==
X-ME-Sender: <xms:mSWnafB_4UWfeGBiPfX-w-qdkWjlxUkTia0rLzZX1xavlXB5_1fiqvA>
    <xme:mSWnaQXtw0Z79SfH-v78Hq4sGFr9x7A6MJ1FnP0sCxSCC2RILYWeKud6CWqn_GrQL
    fpl8aavCsSMDQR55c-cNBgPsXcz_xEOPGvebr5yToMzj48MW2iy12k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtoheprghnthhoihhnvgdrtghouhhsshhonhesphhrohhtohhnmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mSWnacdpIF-K_XvKdJzRM6xJMxgEaQN33vsWGDCT3Jh9ol1hM5Epjg>
    <xmx:mSWnaV9XFJ44lDA_Bqps4_9Gx6wjPFCkmeMZXSTR_RancDGqbJJpiw>
    <xmx:mSWnaQkJHu0mkU-MZ4T2kuufIKlq4yTaZPL0wil_dhWedjpwWIPVqw>
    <xmx:mSWnaf9vxR4Ihab5vI0I5JkDloLulzjP4lgwxk_1q2N3um2C4Ip8Cg>
    <xmx:mSWnaagT4SABAGvaIlqbaHl1CuJf1Yl-dVhkJ1xVAcvaZKfiZGIZJk7m>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE5E41EA0076; Tue,  3 Mar 2026 13:16:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5SwzrcE9SNF
Date: Tue, 03 Mar 2026 19:16:04 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Antoine Cousson" <antoine.cousson@protonmail.com>
Cc: git@vger.kernel.org
Message-Id: <1c20a804-8146-49a7-a476-01a9219d9350@app.fastmail.com>
In-Reply-To: <xmqqpl5kdc3b.fsf@gitster.g>
References: 
 <bhYbjxeZY0QZt48g6XVTVfyPo6vbv9yeYLsw9PgFdVKgye6Ue0cAPy_RkNTwAOYEANhHyD6QbaxZrWaPS4__jlTcAVKOaEjrDgAxQYKdYvE=@protonmail.com>
 <xmqqpl5kdc3b.fsf@gitster.g>
Subject: Re: git whatchanged --i-still-use-it
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 3, 2026, at 19:03, Junio C Hamano wrote:
>[snip]
> The command is going away.  You could
>
>   $ git config alias.whatchanged "log --raw --no-merges"
>
> if you really prefer the ugly hexadecimal gibberish, though.

Yes, on Git v2.51.1, Git 2.52 or higher.
