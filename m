Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B093BB50
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633293; cv=none; b=CiUI9M2ns2yylKJR9SqkGYgCsNqQNnF+YlvFQsI+2h4yh0YXYXrpSLXEQHrThQ50mZYfFK6phgh53X2muE5+wFbYTfDbCekvIgiTvlFU0r4a6Xcdq4spoCZ+EsU+p02lPQDWyWdyrE8NwmIC2bZ0cRPFAjaBz8PiTaoMcmPGum8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633293; c=relaxed/simple;
	bh=PZ0QuaKqik6kLjba/HOZ5fY2z8YPrbwXUt1/eTet9zM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=edNIjNV4GQPxYnaIHIZiyDEz4N9JcPPuBt+5wHO3uZRvkutBwgBpLl5F3Y/+yHD+rT99tAZq6O7ZBwx3f7OdXZvbIx4qgdnrDpn3L9B2UlaW0MyyTtcSNI9Wya7ZegVzk5NlZWPOg7ife0GnBvSYpkl3oCPH6QsLg/DHTtUMlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLAzcjj+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLAzcjj+"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12EDA1140147;
	Thu, 14 Nov 2024 20:14:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 20:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731633290; x=1731719690; bh=NFVu/Ea9LPTAkL7rH6A3evg3AY+yqnXyAiX
	hMg+qSbM=; b=HLAzcjj+JzsQKv186nItGHuvVh8MsKU73i41zgHVNvTvF0AMTNJ
	TF4ZB4lMd/XqqrAx07VCm8Sy0Ox9FLY90X5eFpalHm1dzK6mV+1DtGKSqxQg4ZyB
	0hlJaRVQX6c4ZDYbU9IcwrP7MEN99H96jP/obnr05B3wOzcVSEZ12nlKIxl4BkPP
	4qm3UfKKHtG12JyUs8TdBh7hp7X9EhHxg27sbAluYmct0nY+OkNfKL7oeNd+moHl
	2fm/B9q2k3oJ9vWVycTa3a/RlCmwXUtz6W1SjeORKc0y5VAkZaVNXhlAqEVkVVdp
	cxhUERwC2kltxxQYY5dtAmbhTNbKdYCobZQ==
X-ME-Sender: <xms:iaA2Z-k8ttRyl-fz4nTiYJQV8ow1GMFo21Fk45Ys_rGtV3rqjWvODg>
    <xme:iaA2Z11hE8kwQiHeYnBJw1YNzXZ32pEgwhBlj4yNhXXJGpulpBJcpiTC-MNP52jqs
    zLdk2Yo8O7saBF3Gw>
X-ME-Received: <xmr:iaA2Z8pa1mWBXZt458p4otGQLpK3nUhDT3ADSTLM3FxW7J-MlFIrk9ruGpxOr94i-tOTKXDP4yIg2wL-8BW29B1UEm7Vg7LhIBhu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptedttd
    evffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledunecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iaA2ZymQ8RS2oF-6-d9f0vz0FEDJP_jpry6pupJuDPzltUaey8OKcw>
    <xmx:iaA2Z837bqIE5K5NE6pC6V5KVT9eYTMBngtsPPultrfdD1xZbHsxJA>
    <xmx:iaA2Z5sAXkdp1TkjNjQmkk0meSIidx5PfCtYDUmgMfsLEtttOnALWQ>
    <xmx:iaA2Z4UVE0OpTfkxeRxztTmX4O9TQHWv3KJdxtT7oukKeJuQ3jTn0g>
    <xmx:iqA2Z_Tv_Ys5YjRsnJGwE7Vj4Hnj-rH6CegRe2oQ0Yz5Im549EDKYZgZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 20:14:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/1] Restore the ability to clone repositories owned by
 another user
In-Reply-To: <20241115005404.3747302-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 15 Nov 2024 00:54:03 +0000")
References: <20241115005404.3747302-1-sandals@crustytoothpaste.net>
Date: Fri, 15 Nov 2024 10:14:48 +0900
Message-ID: <xmqqr07d47sn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> For a long time, we've told users that the only safe way to operate on
> an untrusted repository is to clone or fetch from it.  We've even
> mentioned this policy in a variety of places in our documentation.
>
> However, f4aa8c8bb1 ("fetch/clone: detect dubious ownership of local
> repositories", 2024-04-10), this changed in an attempt to make things
> more secure.  That broke a lot of user use cases, which have been
> reported to the list.
>
> Because our security model hasn't changed and it's still safe to clone
> or fetch from an untrusted repository, let's revert a portion of that
> change to allow us to clone and fetch from repositories owned by a
> different user.  If a malicious repository were a problem for
> upload-pack, that would probably also be exploitable on major forges,
> and if it were a problem on the client side, then we'd also have a
> problem with untrusted HTTPS remotes, so we're not really adding any
> security risk here.

Nice.  Better late than never.

> This matter was discussed extensively in the thread starting at
> https://lore.kernel.org/git/ZqUc8DJ1uKcHYlcy@imp.flyn.org/.

> Note that I haven't signed off on this patch because it's based on one
> from Junio and I haven't gotten his sign-off yet.  It's fine to add mine
> once he's added his.

You can forge my sign-off on the old patch ;-)

The proposed commit log of the patch makes me wonder what should
happen when neither of the two bits is set.  Not strict, but we do
not allow ourselves to enter a random repo owned by a stranger.  It
turns out that "strict" has nothing to do with this lifting of
excess ownership check, but the dwimming done by suffixing .git,
etc. to the given pathnames, so there is nothing strange going on.

Thanks.
