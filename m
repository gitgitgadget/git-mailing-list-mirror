Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB72F8EB0
	for <git@vger.kernel.org>; Mon, 11 May 2026 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778459637; cv=none; b=QSB+yC/+xXXn2vq3O6W+9hFCU53BnYgPVGWyMlQiHen5r9yjkK6PohjVs5aPATq3FgqugnP8V8HcPn7U0lasXzItQbqUcED94+dVw1bD8tdr81sJjEsBArGm2zSUlklE2PHEfxjUOft53Qqv9kDO2QfHPHv1Xbfbnj74KvygnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778459637; c=relaxed/simple;
	bh=JEsSiox2UQeB1VMJVkXcgxVEPewcu6JnOQZmMQFFvqY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nByBtyvJw0/Etf/Hf8PWzEyd/SmvBJJnSLAwVbvRSDWwUpHhqRPrK4el33uNQ791G7itGm/RAvcbbdlJH+Db3kDR8BgO8YfG8RA4mOc1gTbc75Hn3ckEmT8kVYrtKc10zFdVYNTRLFb6rfxrhby2yBvGtbvVu00rHzNhTd5hUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net; spf=pass smtp.mailfrom=abhinavg.net; dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b=PxnFvCj3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O9wYWpt3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b="PxnFvCj3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9wYWpt3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16AB314000DF;
	Sun, 10 May 2026 20:33:55 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 10 May 2026 20:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abhinavg.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778459635;
	 x=1778546035; bh=1IDRb1/GqtE2zc3HU9sZMKnFu4BcObXL2q8K6rwRag4=; b=
	PxnFvCj3U+keNk3fFHfqgEHthM34ilY87Uc/Z9pTrnwms/H1q5Wvpt84S994R4d4
	yZtPR0nAg0MEijPBmU0sVV+SS5lN5mqdlREwk5eCSVNLQ9s33Z6692Y/XjryoYOW
	jzcJVv/ZAdxUOk1kBCoFHg9j8UncStTu3vEoQ16irpVI7Uv4TS3bTd//PHhehHW5
	MAZ/BF9/D+nsBOcAsgy22buFQSi4FcfHea0Ka6Qlk5uwQULLQdo/pVeDPv75iQq5
	gredzEzemyIcX8pPxq+yc92GNdE4tYyX1bYlUTcVla6WOQOBtXJLvSvBke8GftqI
	ctL7bpFVf15RKDizjbzpSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778459635; x=
	1778546035; bh=1IDRb1/GqtE2zc3HU9sZMKnFu4BcObXL2q8K6rwRag4=; b=O
	9wYWpt3qoqfUYYxeQq73NSLX/Z3y3zqAyG7vbb6I61LrWUXuBzQOhYf5n8SMY0hW
	c9sm5UuZoDW9E2u+iPNMTQxtvKT31hZR5r/2XN/MXGzNHsLuD9hC6A5FAPGdQe6W
	7rmXvNgULlpVYZyHkwSoWS+OnRyx14HxAIPej8hUjneAzvxOwBndFlqD0AB5039M
	65yh/M4GG+1a+Vu1TehXFwtnzAEY1f7AFsIP+0wjLhRI0ejeipSOJFGjoxkN8uOQ
	iF8WFJaS2WAFwk3ipjo1gVirUXJU/6DuNCM9B/A3ag46c60AohqtFwyDOPs0hpE1
	REq36Hk0fUx9i9wspbB9Q==
X-ME-Sender: <xms:8iMBaroraDqf8BHheV-rQxSlSYlB65MzUGU2ehtfPvGHm9J315WCWw>
    <xme:8iMBageOquwWMnRqlRLALtbMsrBmVGrk4N6zh1mVNlwL9r4wMvZT5-HvUUigB9jHp
    uj_sjjYeA6MK8w671nISi5QntFaF1ftv4u8qUbrpVA5rnaUFXmoEHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftegshhhi
    nhgrvhcuifhuphhtrgdfuceomhgrihhlsegrsghhihhnrghvghdrnhgvtheqnecuggftrf
    grthhtvghrnhepuedtfffgueejveeiveffhffhjedugefffeevleelieefkeegvdfhteef
    ledvhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrihhlsegrsghhihhnrghvghdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8iMBasQu0P0aWlxj238lWZCt3JSerKiJiTTcbZStyJ-T6_m7P5ReJQ>
    <xmx:8yMBankPeAnHN7ldqXE6-WkFWl9fiBoDGvWrq1aZMy_Y5_tdZmybZA>
    <xmx:8yMBakSC0sSZRHWUomke6RwcAcvqTmfIK06JxaTNKkNpcHlsAMdYAg>
    <xmx:8yMBatPc8Es9fRS4ou9td2SnjJfv1Q0C95Dy3wEku55DgzPzObezBw>
    <xmx:8yMBagWE1HgixjLh7_6YXMbubFT0MJQkrrsnIhyEksMry8IgiPdhb532>
Feedback-ID: i43f949e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E11D23020073; Sun, 10 May 2026 20:33:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxnbQjaRaRXw
Date: Sun, 10 May 2026 17:33:34 -0700
From: "Abhinav Gupta" <mail@abhinavg.net>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, git@vger.kernel.org,
 "Derrick Stolee" <stolee@gmail.com>
Message-Id: <cc21dea8-2184-4db9-9aaf-6cd6910095f8@app.fastmail.com>
In-Reply-To: <xmqqmry6x0dm.fsf@gitster.g>
References: <20260506023944.90691-1-mail@abhinavg.net>
 <xmqqqznk9ih8.fsf@gitster.g> <0911df2d-aaa2-456e-a678-345239cefc67@gmail.com>
 <xmqqv7cu96q4.fsf@gitster.g>
 <63e04828-5895-4deb-a698-5d6f494d23f3@app.fastmail.com>
 <xmqqmry6x0dm.fsf@gitster.g>
Subject: Re: [PATCH] rebase: ignore non-branch update-refs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Sun, May 10, 2026, at 17:20, Junio C Hamano wrote:
> I smell that you'd be suggesting to replace the patch we have
> discussed with another one that declares that it is a bug to use %d
> in insn format?  I do not think how well it would fly.

No, I didn't meant to imply that. I'm happy with the patch as-is.

Using %d in insn format is desirable, and I would not try to remove that.
I ran into this issue because of my own use of %d in insn format.

I was sharing an additional example for how this currently misbehaves:
not only does it generate the 'update-ref HEAD' in interactive contexts,
but it also breaks all non-interactive rebases with a non-empty todo list.
