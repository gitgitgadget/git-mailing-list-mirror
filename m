Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC824466C
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088973; cv=none; b=nShcb7uHoqr0/c9D4IRnQi7t7exn/q6nvhSPhpIiHS8KmVpVKr3ybaLilMv/KbgCzAYWWr5ev8CKaeYM525PQVnN74lOrxVtfBmk8N1agl3YtQgpr3ltZiFlzGDWruhJlgKK9WlCg7hy/PlFHBYS3aqHc/8Z0bDcSHl8vc9626I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088973; c=relaxed/simple;
	bh=/PiEH6ael875rANQOsPAGjTSW6i1m0SKO4yCecGifwY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nEgQj2uqzq+893F8YvXeirFULAozx0u0ewpI3FqQNWX0jRKJayZ7LVVaUmTHFqoiTuOKGwI49awlKmZ9aJfbbjVpqXj7+t9xsgiDolid6lEsnFaLca0MaAZDY5BXwMMEsNhqeZeY0EUDNXC120FNJOwAFHgUVXBxBNl958mezjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ilkvGBCz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y0A9kMrj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ilkvGBCz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y0A9kMrj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EF5681D000C4;
	Fri, 10 Oct 2025 05:36:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 10 Oct 2025 05:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1760088969; x=1760175369; bh=/PiEH6ael875rANQOsPAGjTSW6i1m0SK
	O4yCecGifwY=; b=ilkvGBCz0YS0KInDBXJT2WH3RTC2DMIDxp3pQhJJlJJhT4sX
	5sYhscytDkITiWBk2m8yX2zB8NnWMWH+DbuAElYqKIzMwuMYdZp2xcqILxH7uyNI
	8yHx50Sz7FmW4FbydVtDYb+pnU1tF8NJ1QVggUUseTnXMoCbCrsX8HFebrzJ43pc
	xuF24t75gP503UZG/dR/qMkm55qb8zeUZZN56+Sb3PeRxZ1BQJh5e5TqJNpkYQTZ
	SUhvdnnh6O1tuTMg4tw6tUofEPdjyKjaXdX2Q2u5PBHeueQuqamUX0Mw1mgSMQ5y
	fEixZluCtvknmC1PSMxIJBbHjezic9lcKiNgvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760088969; x=
	1760175369; bh=/PiEH6ael875rANQOsPAGjTSW6i1m0SKO4yCecGifwY=; b=y
	0A9kMrjUrQrXFu9zGQzHLTPijIZt1oR4XAXrT4JHupJo6Dr4L+lqpkh6myKsywzQ
	jaFzMqgecQj5RdkOcdcML1A7R9kEr9/ZnwlLRuCbeKj3P11iG+qvc6sMnPCUOeOq
	u+zH9QTre21HnF/bjLGvf2HBRyxpHgR036wDv8N7bL/dbetiilNfPrNcEqZTit3j
	2MZcS0VevkZ3OV0YNZqeHyg07QS2xPrvNbuARXh9kCGQPtn0t/u0u92t49bIJJha
	Rea0SN3LRSvuLQpGD/6VeUvBMBZbGDDoInRtRdBRpzanP0DFv7Dmd/SreEc7QxbC
	IeSd6PWEFh1Z27drCyw9Q==
X-ME-Sender: <xms:idPoaE8QsbL0dL96NfdAIYFnin0HpEK74ijGrtCyxq1_kyY83PkIutA>
    <xme:idPoaHi_bZAhqRkkTzeStNeu-MlNk9WYYakt7fkv4Xi_mWc-eC9b2vaREbTUVEDhW
    _rgBcMrFRPMBOcYNV_R-ZIgvmQi9zSqPkvFzcKRngqs8aESGVZyMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetke
    efudehhfelfefgueeivdelledvjeegudejgfehjedttdevlefgleekieevveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:idPoaO722F31hteNW0c8k5BuSWbdpD-cwEccUlhA5-5Q_xioHQmSNQ>
    <xmx:idPoaPp6bdPMaMOPqFrbUGIAvO53Ck0ByiXg4waM-8SnhoP-EKY-tQ>
    <xmx:idPoaAh08_ZvX8D_nslgA4zXZ6nkjKWLdCpBMFCRjAxDMDXaCUNhrw>
    <xmx:idPoaJIY2dEgiijJ_L9HEiS94gVaGfaFFyU2bi5ZCyHLAGKcSm7fpg>
    <xmx:idPoaHOXSBgSJUp4Jpmu-Jiv6I7beZJNTW7Vi0RBcNBgQ8n6bbAT6mDb>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 676961EA0062; Fri, 10 Oct 2025 05:36:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARmp5oHDQt6g
Date: Fri, 10 Oct 2025 11:35:48 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Message-Id: <c733f49a-5287-4d5c-9080-2ce68b25e8c4@app.fastmail.com>
In-Reply-To: <20251010050207.GA1897715@coredump.intra.peff.net>
References: <7a955ecb1b5.1759923933.git.code@khaugsbakk.name>
 <20251010050207.GA1897715@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: fix accidental literal blocks
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 10, 2025, at 07:02, Jeff King wrote:
>>[snip]
>
> I gave a quick look over the results of doc-diff before and after, and
> all of the changes look good to me.

Thanks!
