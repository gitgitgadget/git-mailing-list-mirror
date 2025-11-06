Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30BD345CD4
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439631; cv=none; b=KTwTs8IwKWJ95+XRw9/8/N1vfv/SvcUbO5hnVJbDEGVq4XKspjcUiip6ThUu0jQ8hVdDGmDsppRj13WGpa+o/tb1/vhH2EA2w4Yh9i5VGsQPeexZmR2p8GfjK7xssgxYQQxDaptPlKxmXdPfNpXkbC2buvr3nXi7tzGI1zzzfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439631; c=relaxed/simple;
	bh=uIk9w5pEn+OKj+/B8ZDt4SvqBVeYXbHnbtkbr1UM1l4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2e9TCRdOOAwb1hzxPCRpC7nPbwcd+BoRqSjgJDZrg4XCWy4yYN6wo2GmYGtL1dlDesKHnkLwB9vZIzsIwG4PDFVpRr/Dwl2AV29JXLKvrm+acTXvN+2cg/TBArs7Oa0qFYzNVWapiicO+z054ZHJhjp6VFZIFsfKw8wbAU+8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bDCz8h8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=srq7H2v1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bDCz8h8U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="srq7H2v1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BF482EC00B8;
	Thu,  6 Nov 2025 09:33:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 09:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762439626; x=1762526026; bh=coBladRQWn
	hFd/u0vzHd1eOfKIek2isGI1DryoetEvQ=; b=bDCz8h8Us2ZMgCpU6lgMKc2YZV
	WBPEBzomZnbJu1Etkj60F74STVnPZfx8fDbNRL3E2x8rR6zt4CUPz4y6Z75JR5as
	UlLnBxCbvLmyL5Uzov8qnumsLPYeKd9n9T+/KfKqGwrfkpAFggSM7GQhRHXB1QNO
	7HOYxHPWsdKtXJoltfepRtHwQrd32F8qtruQpa5qQWC8rpFgM9ayXiodfVvNnRrI
	en26Jw5wZ8so7oXz1BtgCfTN8UyUDiV2PkGRLu5pAgym8U6BYwLy2cxLAgZGLe/l
	LzCouTMfgKPuR5UVKN4jv8wWaDW7Qr7/Zv4zJLA1mdCJqpncfHmwv+1pMS6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762439626; x=1762526026; bh=coBladRQWnhFd/u0vzHd1eOfKIek2isGI1D
	ryoetEvQ=; b=srq7H2v1KKX/Qej+88xprRVdChQP4jJEqZjU2oyawThIpKw9zMk
	Br1qvsb91JMuPljN/HfxWVW1/AF4si1iWCkAX4eMKN3+LeqgqxFxPEhIC4Z1ut3q
	eQnWn1sZOOY6Mwe23ehb8/3V/nLBB/JPI70Z5XKRH8ZQ1xrkc12Wh/V3i8/X095i
	V/VzYZK8/k9o2/Yaw0f0w0JL3syoXeOM+n678TynhnOcZG3V5gFvuQN8RfXypU23
	oF9NR1KLVIyd6IsmGe3icpbOj10nDpiFQql2sFllJF5JjTxD9Fvr4MRft2KuCMYO
	WiAgJSkz46ZpcHwqYTbqI7LPz0jfv3HyIXg==
X-ME-Sender: <xms:yrEMadg5P3K_WnzOw3pWf04LECzVSYGA4ROPlXWr0opndxNl9rmbbw>
    <xme:yrEMaZeo1cdtm6M70POdUmWYPNkb6ZC7BnCHK0dl1ooCJEmVCiz2AkaeL_cGwOX1x
    gGrb5TdljCWnTglIluduZsRjTFgFnoRC_4PIYsOiByJE2UfqxbZnw>
X-ME-Received: <xmr:yrEMaad6Ip2eFqoyzcWixfY06w3RaLjsYE1lBCO3JgU6KAzoMjmd76n1cB2648c6EqaRcMX4YBwzA97vh0VmXQvzjSZnaf97LGr2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:yrEMab_Gnq7Zg1N8NsqJl4ALCmeKA_i2Z6YtfDHHUxN1O_YMd24aYg>
    <xmx:yrEMaem0n0SPVhIo-Uy0S9QOA9wGZe-84HrRyBHkVCb-gPb_-BIBdg>
    <xmx:yrEMaV_e5pO3NldZE8Vsz3ndqvwhp00xXZXJs6WTRyTLOCbnL0PHLA>
    <xmx:yrEMaUkSfTQwwkGvzaPi4nD2HYrmJ-QQ-59Uzgq0PUAj51XR2ig-lQ>
    <xmx:yrEMaRku3EGvpZoFyf8T_BMdpnuOdEE-VwBufFRn89jrtfBQo4RyZuIk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 09:33:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] object: fix performance regression when peeling tags
In-Reply-To: <20251106-b4-pks-peel-object-performance-regression-v1-1-a386147750b0@pks.im>
	(Patrick Steinhardt's message of "Thu, 06 Nov 2025 09:52:54 +0100")
References: <20251106-b4-pks-peel-object-performance-regression-v1-1-a386147750b0@pks.im>
Date: Thu, 06 Nov 2025 06:33:44 -0800
Message-ID: <xmqqy0ojjkmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Bisecting the issue lands us at 6ec4c0b45b (refs: don't store peeled
> object IDs for invalid tags, 2025-10-23). The gist of the commit is that
> we may end up storing peeled objects in both reftables and packed-refs
> for corrupted tags, where the claimed tagged object type is different
> than the actual tagged object type. This will then cause us to create
> the `struct object *` with a wrong type, as well, and obviously nothing
> good comes out of that.

So does the flow of the logic, which led to the original "validation
while recording peeled tags", go like this?

 - It is handy to be able to get peeled object cheaply, let's cache
   it, because the same tag peels to the same object every time.

 - Usually when we see an object we make sure that is what we
   expect.  Not having to do this validation costs us less, so why
   not validate when caching peeled object?  It would amortise the
   cost of validating the peeled object at runtime every time we use
   it into a one-time cost when we cache.

But of course we do not really get rid of the type checking at
runtime, so we certainly should notice, no?

> Taking a step back though reveals an oddity in the new verification
> logic: we not only verify the _tagged_ object's type, but we also verify
> the type of the tag itself. But this isn't really needed, as we wouldn't
> hit the bug in such a case anyway, as we only hit the issue with corrupt
> tags claiming an invalid type for the tagged object.
>
> The consequence of this is that we now started to look up the target
> object of every single reference we're about to write, regardless of
> whether it even is a tag or not. And that is of course quite costly.

;-).

> Fix the issue by only verifying the type of the tagged objects. This
> means that we of course still have a performance hit for actual tags.
> But this only happens for writes anyway, and I'd claim it's preferable
> to not store corrupted data in the refdb than to be fast here. Rename
> the flag accordingly to clarify that we only verify the tagged object's
> type.

OK.

Will queue.
