Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D4333C1A6
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908442; cv=none; b=cpLsYvBMVWasqGVLFZrEVNUt6FpN7cpYHBktHwwojdwukjEEw19CHGFrqiApnAeEdZHMcdmp9XmOKv+8Xwnp5+5sekgFQisD18ghhRRQm58iWlMw0KE7nlG3Qe6blMVTiS56AJZ8PcdZ7gyN+HEBQoSu6HvRH8lf22WPVAyLPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908442; c=relaxed/simple;
	bh=T0zMLHGW/Z4i8OSPwUt15XQkJK67GVu1h/GVPVo5t7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O6pMkg8WLBh7dFTO2iqZebgXv1JpUPIOm2uVUpJsk8zKiP6sZ719zjKdW7hDLukYeJ3Plnyb/XA9zkuoC5OXKZh5bbcAOxA+y4Ow4sb3HnzkFzPCdHS76SUlnwx/Y8HBC7qwtnOqXJOKTYofcvQp24KMdFf9pDtFzImum/imQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WbZiDQbE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KYPNnyn+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WbZiDQbE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KYPNnyn+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0437814000D6;
	Tue, 16 Dec 2025 13:07:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 16 Dec 2025 13:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765908439; x=1765994839; bh=T0zMLHGW/Z
	4i8OSPwUt15XQkJK67GVu1h/GVPVo5t7s=; b=WbZiDQbEGznr7SFSRZRoS+KSgZ
	qURxIhIvwycpy9BlETEJ+zWejWbdESu8rtyFrE0m6nrdHuSH29DxA5b605VDuScf
	1gDhB1jftJQ6sD+QhFnfiJweUAcpQ1nW6Z5E2mj7pT1qI66fLKXRQ2r5lg0wrMFR
	itsbfGkvPtDUSwSTWcodOS6UJKzGr4vVtBuylu19rtLU3hPOizmbjQ9lK49wVQME
	saywnBjveFrbGIO/tw9HYFtnmf4AWAfOz36nR1oVu/LrtYxIldZVj6cKSadpF6BJ
	8pjgBT0OoYWRsTq0Bozpwqo1HECbRmv9YaxGCC0/o68RAex/tKYGIpzWmqSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765908439; x=1765994839; bh=T0zMLHGW/Z4i8OSPwUt15XQkJK67GVu1h/G
	VPVo5t7s=; b=KYPNnyn+jw8oCF0oz4M2yrLlXPghRcSVUJOkzK8UgW+IaaDqEsZ
	UQcQICsgmk7uHmRW6M0vRnPCFz3RXb6gZNZXwXZRxqpTzq8mGRLK3W09L/cR2yRF
	Fp5CJSs8LdAj4Ri3OJY8kP6EaTnT2daEfMag4krenymL40bSMdYSsRRLSoRIkGpJ
	48VGb4XSfWlpCFo/UTQm44p2RLNRG6PZm+pJWJPhwGzE5ktCBalW9ySlf3JQ2ISy
	AKUgnZHhh9exqMwCZdhsexf34Nliga7MtuKdcxNWHxS7Tq1d5BbR8kCKp9YXpQzg
	ejWBUVU7WotVK1hcqYdwntx2+sl+IhOALTQ==
X-ME-Sender: <xms:1p9BaYR-i_n4mkXTnwczlb_kgVoJRdM0irYO4iCKxVnYNXegFwjzcA>
    <xme:1p9Bacw27hBuj3_WsPPaz9dL-QdE2kTwmJHAZZtgmE2qiSlE9X5Vq_3vk-SwK_1xV
    270dsvBh6RDZcB7VgvGoKEZS9UmdwTnBHSVVM6jnFHn1pHaHxFV>
X-ME-Received: <xmr:1p9Baa2qohQbwBH6TD5jZ6Fj4e8QiCTUg513LZ679NkDfHwEORTdjqVKLfQuhNn6NpqsWfY4jSkVGasv2N3MHkaTtpPOiJq-4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegtdefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1p9Baa4nNiWIpyxwIBJaeD57bAdDfmixNPU0wM8p47xrRZQt77yKcg>
    <xmx:1p9BadVuXqVs3iUaSO56Su5BxoYECYIu6PD56QLsyek6sV-2oOq1HQ>
    <xmx:1p9BaZDcunHX0RdOio_kgxwZwnOc0x7t6CWHQWwAySf2sDisbR0W7w>
    <xmx:1p9Bac5cZAtnRv5uPU5EgoZBq3ILtgAkn5UOg6ssgVAO6m2kMLMoiA>
    <xmx:159BaSULeAQwvJIVrbN9f4JSk4MhdtOM3Rao6CteEp8y8dNcuCbJWAtm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 13:07:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify git-rev-list(1) --filter behavior
In-Reply-To: <xnstt6myzzfyq65w73xuqg7cfso3bdw6tw33shrery4e4gi2zy@pfxq2pjmb2hm>
	(Justin Tobler's message of "Tue, 16 Dec 2025 08:36:56 -0600")
References: <20251215200512.2694155-1-jltobler@gmail.com>
	<xmqqwm2n5ivh.fsf@gitster.g> <aUEUfQDJyPf6Mhtw@pks.im>
	<xnstt6myzzfyq65w73xuqg7cfso3bdw6tw33shrery4e4gi2zy@pfxq2pjmb2hm>
Date: Wed, 17 Dec 2025 03:07:16 +0900
Message-ID: <xmqqbjjy47xn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>> True. I didn't feel comfortable to change the default to also filter
>> provided objects when I discovered that we don't, hence the new option.
>> It's not great though as it certainly is surprising behaviour, but I'm
>> not sure whether we can really change it without breaking existing
>> users. Oh, well...
>
> Out of curiousity, are there any known use-cases where a user _would_
> want the provided objects printed along with the filtered ones? From my
> naive perspective it almost doesn't even sound useful and appears to
> just be a sharp edge. This maybe not worthing worrying too much about
> though.

Perhaps there is no good use case (and that is why I hinted that we
may want to "fix" it someday).

It however is understandable that nobody noticed it because for the
primarily intended use case of "filter", i.e., object transfer into
lazy clone, you use commit-ishes to describe a range to be
listed/transferred, and you never filter out the commmit objects,
perhaps?


