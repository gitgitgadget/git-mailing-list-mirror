Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0D283FF4
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011239; cv=none; b=KiGMas3AGv0w/i/bSKfgcCCZgpZLdy6Dms1KPpnMvd+NqmkjoUvbDopGVuZu+jWIBnf4IrWXUJHiZJ50r+CqByleZgnkVtg4a+6EMYmrEm6IdyQxwX6RfToq4LAjQSlrIXB7fw5xwX5PHvH8r/btg47GQed2LSTg1STFHrGCK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011239; c=relaxed/simple;
	bh=UPy8NFOlFESkj1LXGb7LrNIt/+uNgp33HhNay3Pv7OM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLuWh/UmqduobhP0SqqZ9HC4eD81nUIKrFHZfv0ab2UeJlyTPcKoPjbGLSGDRwEDcHnlQbAsdcsqfcB0ALcaeUGg3RsNGkWpmebUXCLzwEe8e6tvrz0N1bLzDSH4gbFSxCiYhgeGkZDqmL9wbLe/kpSwl2C6stqeM9+WzLvhiPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QKxgQ2kc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/mvpIAN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QKxgQ2kc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/mvpIAN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACA6014000D5;
	Tue, 12 Aug 2025 11:07:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 11:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755011236; x=1755097636; bh=UPy8NFOlFE
	Skj1LXGb7LrNIt/+uNgp33HhNay3Pv7OM=; b=QKxgQ2kcMtbBPvPykXzK899V1n
	xDX72SUjKb4YtyKC4lhJAMnM+Yh3KjvkkFCRaEIar4+R/oDzKtbBPHoBE33DNh64
	tobc+D6W4LwqXYL2KReATnwVIJLtsKcolZr0sBFkAv2nR0IkP8ixgqd2GYI3U96K
	MryhBFraj1oJYoEoUgCiJRQcbGWpzxXg9Cp5mMG4HiVgzh0jFzY8EZ90HJzv1Wjb
	eJC4cyYiSKb1MlMaM4oC4hWy2d62nCWwU4oWygUpHufdKYOoTS/YitvDFN+kFikq
	1MOvxWTt4N6ca8ABtsikGpUoVhtVXhYID5b4oF8Np7YPiT2TSfcWPe5LZiQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755011236; x=1755097636; bh=UPy8NFOlFESkj1LXGb7LrNIt/+uNgp33HhN
	ay3Pv7OM=; b=a/mvpIANaPCGSTtNQYWroERbTxFVmyvEzUEbNIYsxWIS1Ad+2SG
	Yy1KEaKHON5v/3sXgjIT4sKezF8TCkoxpRIdxnQ9WAB0tBqQnL/nuldvnnozLx+s
	6zn19uEa5KoZZzkzysGqCcA1L0QQupHA5q2BWoVa9O+YtpNqBKU95Zapp0zpYvT1
	VpNrgCgaqJMarvfQDoKQpB+jY4N2nkXenIh4F4LdnB2mgSZsvInewPECumIdJpAR
	aHyZM47A6v3rafTGAjtOOSkv5q/O9f7BsWbkhVULdUi8ybPAmrvSrSkO+rU45QTO
	dhiz//AEqs8CrTq+a4oLw96KV9d4iovJv6Q==
X-ME-Sender: <xms:pFibaAQUXDA7am2LmOs2FGmT89q5_m4knt631VcyDCvoR1DbpW7PwQ>
    <xme:pFibaIUryqoOmJbTxbg1iaRq8fvfnY5tsAgaMsUKcAO8wn7E8F3uCpWjNlas1T3Le
    uN7oFeD2538xrtCAw>
X-ME-Received: <xmr:pFibaKYT6qg7yniOaAP7xvAMFaGK-wOvutiX2Iru_dkviJl3jY_24Gph6D5AxA6Mkms7W22QeQdnu6etkxiK15cvyuxHfMHQg5gYIJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:pFibaG23mvdArFiXJwg0nc4amvENLPaLoO7IHFWafmziyEWI7JvqIA>
    <xmx:pFibaEhVvlq0L2G1pYWV2Ucg7a7XxvYMyAGRjjUO4nPbKU6YAZ32VA>
    <xmx:pFibaCYT9Dl8BaYW8rUYQaaRIk9Wkz5KFpDkemELluJLQzhXSua5WQ>
    <xmx:pFibaMQxVazGazg650V-m35qZMHI6BVntF6PVBBK53TyfpdyLNhbHQ>
    <xmx:pFibaKkBWu8orephjn2jiUakx2F3ZG9TY8qRfQCRGIoG08ICwVcTiyr3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 11:07:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] for-each-ref: call --start-after argument "marker"
In-Reply-To: <CAOLa=ZR_ACey173CvkMPQ5DXwGKei+2L-JEWqGueX3NhDXk=5Q@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 12 Aug 2025 07:36:29 -0700")
References: <1a32a666-fcf4-4f05-a468-2afa07fa0e2d@web.de>
	<CAOLa=ZQqY8MDTs846mkVsxXrmOmC5O_sv6BxUHqYjGk1Ag+Osw@mail.gmail.com>
	<xmqqtt2d3l3c.fsf@gitster.g>
	<CAOLa=ZQGaZA=Yynv5JkYpSbYBczfVnemwmzABrqB6er19Utfeg@mail.gmail.com>
	<xmqq349wy5hg.fsf@gitster.g>
	<CAOLa=ZR_ACey173CvkMPQ5DXwGKei+2L-JEWqGueX3NhDXk=5Q@mail.gmail.com>
Date: Tue, 12 Aug 2025 08:07:15 -0700
Message-ID: <xmqqectgwpcs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> I was referring to the fact that I made the change from "start-start" to
> "start-after", but "marker" would've been the better replacement, so my
> review was concluding that while I was here and made a change it still
> was lacking.

Thanks for clarifying and unconfusing me ;-)
