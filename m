Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBA2EAE3
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004925; cv=none; b=FtnNUjlRvVb34QPMx0zFGipRddTNNyMjnbvCLGnncaDb/vC1vYVH44FMBGVZu+IUHXQyvmNLutB5uWjOUPNMPRVk1wJdNXWVa9mkPuldTTkE98Jz77Iq1vvWZXvzI5pEIVfcvsWWPXJGD4chr1c+DC1b5puwn9Ajx2IaYv4jVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004925; c=relaxed/simple;
	bh=V1WmXClJKZWLBpbQJW153Qrq854wfxzMQ/mmDdPma98=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u9JEaB7tN+W7sCdAWOqBbtEOAq6IXUpcKKH/otBNv8V3ED7nKJ7lg9OKdbgFlaRIQUwnkg17oNuXZl9KtvkgacoCFvU0BcMBrCebiQm4cH9JvNrNUl1J3BaVJNNnh1ciplD6x9TKSZyysHyaqF+j/hazlLPfrHLI2Dx/JWBT/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z7f7oFM9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C2vwwPNo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z7f7oFM9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C2vwwPNo"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 05E671D000C4;
	Tue, 16 Sep 2025 02:42:01 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 16 Sep 2025 02:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758004921;
	 x=1758091321; bh=4xHTYgCJ5faDaxjestq+3HktB6yPo0x2Sb7wY3Gmq1E=; b=
	Z7f7oFM9Uy4Bb4S0bHzVbFD2KdLpGo9PQOhlvSD2/FMxKLFO2rxuECUxppEw/v9c
	SP7kRMUo8r1EgQoay4XMnwmhyj69WzV+/I8y9+M35n3FPviVIe+9GwPE9gL+YZJG
	kA6lzs+p+l5RXBci1RmNbOTtKTAgjn2e01wlYEtJ1p/Dykf8XjYlBFVvqrxEA7Z3
	ZKuKXL1CnVoZ/bHCC4M7/9kx7YNG8W7e2ge3Dwp+djCQdq8G7QVMqDx2klKpUY/n
	wudKNbOhuYnZVgE6dR/WuwjuleY10VNABOfH9vLMZ6wooYPX8R5C6T4NzgmvlcPT
	pUo20VGZhw/d+kUVxRoOkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758004921; x=
	1758091321; bh=4xHTYgCJ5faDaxjestq+3HktB6yPo0x2Sb7wY3Gmq1E=; b=C
	2vwwPNoc10P/EXl1h3MsmqE1lnsvaIssqos4PYsBVCXoZqI0LPahOthjurh+jERx
	g9v4qs2HNOyTHiii3eBmoBFBRDzowx/3lE47hk2M8+UKjeRxF4GVppmkphhxZUjt
	rnNsXbliUlWAPeZSVe80PCgNWdbK6pQdc40JKwwqd0AsBmP9nmgbLClPnUpRi3hH
	ODPrb1dLD/HKmp7ZpupAttyrM15X/okkLYbv7kI0Jl3mezBghXvKxbWr/2MXTHac
	sOEsoSzfYUoqNhfQOCw7eJ0HGqqjcBhr5tYwkMLeyKSrJHChPGYRzDHKkP9jDrOb
	+SQ+npNXGnrJMRmdbPFbQ==
X-ME-Sender: <xms:uQbJaO6ay_L0a1vVhQ3yJJa4ADxX_rROQS30bgyE-oqbVlpTAENGk3s>
    <xme:uQbJaH7nQM2RDM0LB0MARkbiq2e_6pMQLODCVBGWI78eZYLtIsd6wZnO7Mmh4vret
    wJAR6in4k0Y0437QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeduueehtddutefh
    gfdtgfeiheefveelieeltefgfedtieelueejteethfevkeekfeenucffohhmrghinhepgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdr
    tggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uQbJaH42Zwbm1MSMZlY7B-gXuvp5jWHo07d8NqfFLTomG_lH-T31Cg>
    <xmx:uQbJaKAkJSrVJ7ZyX60a_NzN6pUDdLCDrWWKuGktsqJ4SENikqCcNw>
    <xmx:uQbJaNexNNhiZgO-6_WZzCe0MX4U3aG5Fsjvkwu4QWQuAmx-Zn2aNw>
    <xmx:uQbJaJIqpCBMYPl862upbVYhNi5b8AJ2r5nW2qZZeujRaCagUHENZg>
    <xmx:uQbJaDJi_ZTWfCj37Gt0I8uUsn3pS65QIZi2fBD8W-CGJvQzGNFTOvPO>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E2E21EA0068; Tue, 16 Sep 2025 02:42:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA3O5JZkN_G7
Date: Tue, 16 Sep 2025 08:41:40 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <julia@jvns.ca>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <b144874c-c4b4-4f77-a1d8-675314517bf5@app.fastmail.com>
In-Reply-To: <xmqq4it3e1y7.fsf@gitster.g>
References: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
 <1629C205-700F-4A8A-84BE-302D172416F8@gmail.com>
 <236a79f4-e9a2-4335-bbff-79ae0cc67e9b@app.fastmail.com>
 <35faaf30-6326-4784-80ff-723c20ed6b13@app.fastmail.com>
 <xmqq4it3e1y7.fsf@gitster.g>
Subject: Re: [PATCH v4 0/7] doc: git-checkout: clarify DESCRIPTION section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 16, 2025, at 01:22, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> There should be a gitpathspecs(7).  Not just a glossary entry.
>
> This sounds like a good #leftoverbits topic for new-ish people to
> work on, with help from old timers?  I do agree that the entry in
> the glossary has grown to be way too big.  The pathspec magic itself
> should be mentioned there in the glossary, but the details of it
> feels a bit too much and the topic probably deserves its own manual
> page, just like gitrevisions(7) has one.

I added it to the unofficial tracker.

https://github.com/gitgitgadget/git/issues/1971

-- 
Kristoffer Haugsbakk
