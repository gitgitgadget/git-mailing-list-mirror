Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39F1F5F6
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728231699; cv=none; b=F1OIUDuyznTEM3QKVp9JNDnn8G3GBiXXI0kt0/Z/tq9KqmUuhDWDWBTMLJBNkt4ZpDv54wKBRwuT0mSFJ3m5kxOvLq80cPLWaYzxgxhBEP141L9aJ8gfMYkPATCbXu3lC3lW2OYsr4UFkcRoI8RmIti+P+ZrG5qrf/NwfD6FZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728231699; c=relaxed/simple;
	bh=7kgfpGxN8lNf0+ai5pRARDY2dIFs0a/xXJignrA2sYg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H5y97rvWjK806/+zSNm/4ivLLYFLE6gyHOMAy46W5bsYtgVUMP+7YfDgzZsNztQvMoVxb2igoPYDRABGREFy152Y5sSNm+8lv4AltOROPy5hK2J3veZbw219OMaYJ1xwFQM68AgiFiZ1+/lKKSxoHY6OC0011osAt48TrB8Y+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=exr0dGOg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mkVLPHfF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="exr0dGOg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkVLPHfF"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 372AB11400DF;
	Sun,  6 Oct 2024 12:21:36 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 06 Oct 2024 12:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728231696;
	 x=1728318096; bh=bINppQmgRJTKXzsQFnyHgljlDHbgCI/5gMt+0Csv+2s=; b=
	exr0dGOgL1/hqPHEqFLAy5ICPvL4e7YPhG/FVqSLxGsveJGaSWZ5FHCGwu1L0Mtu
	K9+8VdbOoImrj3RPUQUTQA9hXJLSVbeg5fOOhBHg5zypFMFNW+OWnaiNLUxWYNIm
	n13KLx7QRAeRh6vZ/QL8kou7P+T3LievMGbeNLRX3iyskHqDseltZ36WmdPm3mSk
	ZITXNfJ+mxzZ8VUWqcx7y93XuFdyXBJ81HzbwP6vLiad1yzUSjlkxtxc8YNNPgyO
	7Xl6Zp30tela2ioyNgb+h3bF80XazNydLiKUj+fFWZnXr6oBbABc0wxa9oswF4Ai
	IiugZoFs/SqcXctgw5r5qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728231696; x=
	1728318096; bh=bINppQmgRJTKXzsQFnyHgljlDHbgCI/5gMt+0Csv+2s=; b=m
	kVLPHfFjEdmBQLckoe9/eBFx8vEokThBkLtcoxkzB15u2hWSyyQV2/PzxJy30uat
	Bj6ifwv4rrFmvefdtAuwlnQ/E5mwJDCacc6RtEk9t0IWZ2kU2HvlKYKtsmRjPg3P
	sRiJPrfF+jF2ymgxIaoT/q+O55jk8s5t9UvSztarWmrIxtshVafhCjswfCMjZ/rR
	cqfx8wyosDZOGYxa9RrylP7znexmI3bExyvSg3HSxFd1fMTK1k106gjjdYhzmoxW
	1GdEbdea5U5LO5OJX0Bni2dGLYKGK7+pzrsgZwpUIbVnld+aSkV5zmd72DpmZdTx
	aYGALwOzm657nDJHpj1MA==
X-ME-Sender: <xms:D7kCZ2EQl_Vm7qxcUWuugULEW9shl67QeqEM3bhL26BjdpaDtYAioI8>
    <xme:D7kCZ3U7a8ldR251l4kAnHn9GFAa2A2bVDvAJZeZ0YT6ZorMy5m5CGK5XXIKdgTtc
    nlHFEXyr8mLhUc2YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhm
    rghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D7kCZwLHT1enYz72-S375Pa1v6PN-9LI-4wLALboHBkr_CSFQHe8PA>
    <xmx:D7kCZwH0flDcpztVV7p0BRAQfGa9AJs5mwVdgcHdbV3OV_D2HWbr1Q>
    <xmx:D7kCZ8WOdmAaqgLHYbr7wAJZkUjDSIXpzSfTWSbMjp0WRbsyZ8Jhug>
    <xmx:D7kCZzNkQospc8RQWb7pJjGc31PNGqED3voXPAnDgLCWre1fZpVBbQ>
    <xmx:ELkCZwp0Zu8hOor8i9UD47hZXSN1zYDdgjcNJz8-PnADKwUO0A6zHIn3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D5DA780068; Sun,  6 Oct 2024 12:21:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 06 Oct 2024 18:21:14 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Christian Couder" <christian.couder@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Eric Sunshine" <sunshine@sunshineco.com>, shejialuo <shejialuo@gmail.com>,
 "Usman Akinyemi" <usmanakinyemi202@gmail.com>
Message-Id: <92496582-8414-4d5b-8883-8b0a0b3c0988@app.fastmail.com>
In-Reply-To: <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit status to
 pipes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024, at 18:06, Usman Akinyemi via GitGitGadget wrote:
>
> The root cause of the whitespace issue was quoting $count in the test
> command, which led to the inclusion of whitespace in the comparison. By
> removing the quotes around $count, the comparison works as expected wi=
thout
> the need for tr -d.
>
> Signed-off-by: Usman Akinyemi
>
> Usman Akinyemi (2):
>   t3404: avoid losing exit status with focus on `git show` and `git
>     cat-files`
>   [Outreachy][Patch v1] t3404: employing test_line_count() to replace
>     test

You don=E2=80=99t have to sign off on your cover letter.  Just the patch=
es. :)

Of course do what you prefer.
