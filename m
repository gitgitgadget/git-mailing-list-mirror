Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014F353EFD
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500311; cv=none; b=Z+jl3jnSEiX2t/QTcB/5drc95qrLmJ6FpSqwGQyAnFBRbAwkIWkwf2Nd/EgQSZqGFMM+/y18YxpU6oTaZrE7AUoeGnnK8gj6igNddD2g9ohZvD9/t5AQgIwT5esubxXm5Bu9EdZxFSxMyD3IJnnmBX52snPaXE8slCvNVVd+/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500311; c=relaxed/simple;
	bh=EjBCcbDDOYChtCMYQ0kWMm7mzPvJWDmNDmB4zOqUWNQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SyG/FqXs8L5s3uT8bPDNnw1Dp1TyOwJrcC03n+Slnm/Y6JS6k17a3fQ/Q33h5GvlrlLRepx8qocLieWWgvHyGTyN6IrfPzlYiFUuXb2f13fIM0D6S2lDckPLsqvrQh95SAbXqvVQ6nCTK3bFqnFJJKm4qjF6RrUEFvpv6ywXoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=n6881Q07; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tusGI57A; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="n6881Q07";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tusGI57A"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC19314000F5;
	Sat,  7 Feb 2026 16:38:30 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 07 Feb 2026 16:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770500310;
	 x=1770586710; bh=kIDMAmjTdZXO+8R9MtCqLIS/w4mSB7n8K/RoL+qEjSM=; b=
	n6881Q07qsL+YnRgI/fh3yy49mntIVq5eVvalWXu/GkpUMf01qC95mQ55dbxnneS
	xsuASnww9h0294xVTFPGOTy2e3LpDfM2SJrxRBw9G7APaKcMpioGhSgb0rI/73Z3
	ikCyM5Io/ujKgJU7+t043FVCx87ACFi3prHt/EvqluLj2j5dUA8qZUZGuij8OUq+
	TkmEIu9Q9sF3gKI5QMPXmJ6YRpgHKGh/bxWSH1eBR1SXbkm0xNK0d2Wq5HJOPmQG
	a1/iqAjcVQhldlVhVGsLcuIoTqNF9t+6eWL8L1IQEJmgILMqvMSysvqCRYbTq/oE
	HyOQ1f2yrkKWc9Jw1wQn8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770500310; x=
	1770586710; bh=kIDMAmjTdZXO+8R9MtCqLIS/w4mSB7n8K/RoL+qEjSM=; b=t
	usGI57AW4fISpHQE4Bbp0fRKkB3JktdK782iiSpgUemqwCUayXtPRhRQfTywn0f7
	Vle4s+Qpe5tw1qMJJbADQDMlJfpnn1lffU69UGorcSBMlHpMGT8oaWDTUwSzwubx
	lwRTGEVCzai5uNu6ORMWfucD4S7LxgqQuTHO40HhLQIU52ZmGj5vY2XAXYLYlwUu
	k9MTdDAqbKDM86jiX6xZuqonHO4tEvg8mtXo3ZKHWlbjG4Jc1yLDfkVWIHjm4+ng
	1LTmKr8B20Z8/iAkZhVKABsKxdNVRG9IgApfRCYgJz9/xiUpKkYWt2+dgYFbnK0q
	GPCdKqRhZxDUaOzVkgKnA==
X-ME-Sender: <xms:1rCHaeHpCZPAd5kLy8kc9QYmuA3kUYLII3pj4VCfsS9DV8i1L1Y0qlw>
    <xme:1rCHaaKOUxi46mHcpK0DBsQEieneU-s9HDPug5kKVZ5R9FuvunjNXFlI-J-Md59LA
    L0UQPbbO9CnYmrwGOXC9hGdr-Fw4WFXrkceT8St1IZFfpndRq85xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehjrggtoh
    gsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphihohhkrghgrghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1rCHaQcwGeNOUQNPEGP48WZQGQWnBunxSxMTNXd99Rc9a7UklU2WuQ>
    <xmx:1rCHaS4rAzoBGENm9ZBfPfSisGouBO4gapMDaMot6NBnYcQIY_eO7g>
    <xmx:1rCHafuKQYYvmtfbhNksHkSOGMe1Kri5axh_aUwcF8CQ7-X_YrYJ6Q>
    <xmx:1rCHaagOdyie3hDswU7_OYzDZmZ3AukDd1jS_yMz4O6ZqeVJUqpyBg>
    <xmx:1rCHaWUjaAFNPyGiBOD5caCySA068HsDE1sAQRrfoRJW9_uPtojTMgoY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E63F1EA006B; Sat,  7 Feb 2026 16:38:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2HMo44wO33B
Date: Sat, 07 Feb 2026 22:38:10 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "Matthias Beyer" <mail@beyermatthias.de>,
 "Jacob Keller" <jacob.keller@gmail.com>, pyokagan@gmail.com
Message-Id: <32614598-48f0-4e3d-ba8c-e8d96b71dbd9@app.fastmail.com>
In-Reply-To: <xmqqldh4b5y2.fsf@gitster.g>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770476279.git.phillip.wood@dunelm.org.uk>
 <83c100a73ec722bf72a15b7b40b0c82bf8829168.1770476279.git.phillip.wood@dunelm.org.uk>
 <xmqqldh4b5y2.fsf@gitster.g>
Subject: Re: [PATCH 3/3] templates: detect messages that contain a separator line
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026, at 22:27, Junio C Hamano wrote:
>>[snip]
>
> I have no qualms about the topic up to the previous step, but I know
> one of the things that I sometimes do will be broken with the change
> in this step, namely, when I know what I want to write below the
> three-dash lines, I would commit with "---" and additional notes
> below it, so that I do not forget during "format-patch".
>
> When the commit is turned into a patch email, possibly with some
> other material like "--notes=3D<ref>" that adds notes there, the
> resulting message will have two three-dashes lines, but because "am"
> cuts at the first one, and "apply" knows that the garbage lines at
> front, including three-dash lines, do not matter until it sees "^diff",
> this works out perfectly well.
>
> Admittedly, I myself do not send out so many patches as I used to,
> but I suspect that there are others who have discovered this trick
> independently, and they would be unhappy to be interrupted by
> commit-msg hook like this.
>
> A saving grace is that when the user is stopped with this,
> pre-commit hook that inspects the contents to be committed
> have already run successfully, so rerunning with "--no-verify"
> is not with too much risk.  But still, I am not sure if this is a
> good thing to do overall.

Maybe this is not the right tool[1] but perhaps the hook could respect
an env. variable to disable this check and hint about it in the error
output?

=F0=9F=94=97 1: https://lore.kernel.org/git/cover.1709495964.git.code@kh=
augsbakk.name/
