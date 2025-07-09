Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C22609D9
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102865; cv=none; b=Rmhg/Gnv4qUhWs4ZiNFk+Vz3O1X+AcxucVjF2VqBkT5d+q7Snu4KjyUXB6xjPaa6KaXrJ6qcgE2CstZrvDK20lKXRnwqpJ7Wvj6LUwS45W4+9GNdGDqE7ptSgbPSuU+srgD96frtrwG24tdnRi7LljJHZtRMqA0jysXw+dInPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102865; c=relaxed/simple;
	bh=q88ulpzDPHiLwKJNAuq/6d0lFy2eIzUYLRyHvjNXtm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKqktX6kWsaj9WlBkChJFhufZudSmPjj7uTXIY+GKMQI6yHz7eeL8fjIEIx9W57gEa7TbUYIA9P5mpt8lf15v2VDpVFBjeqx3P2o9CIXHjV6Ijj4v8kvMFayAJIM+teRTazCgl2pc+5JrJTUYImA69+P54/asmBOvVU1MtKqpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dt5txcw6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eUPyW/n1; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dt5txcw6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eUPyW/n1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EA457A026C;
	Wed,  9 Jul 2025 19:14:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 09 Jul 2025 19:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752102862; x=1752189262; bh=PQzYB4iU4T
	sscnrBCIIOLL8D8e10SLEQ9WgxA9vRav4=; b=Dt5txcw6wR/vt339QAct/vqWuj
	60rU/x97cnQoHaEmMLBRospmQ6980q7GCVm32AGF0eVIxqJoF58lZfiycbw+hFQ5
	fzJjSsTzMRI8yPVXqFCnEAryI3CoWp57/2Mph87Tzsnu3k3/dPMdOHm+OjyJi761
	+AB2Ke4WOnJZFoPrQhuf5FoX6h2ImveBMOKZLEAzLgwUHbGp8PZBa55xu7qu62Z2
	jzRpTFPo+tuyXODZVxJdRBSl3foaoIECj40NgKCaERGkCW2bLdYfKL8X6/REzT8Z
	Z+Njdf1YPzBKkmgxdviVXz//efNwM5pLdidfkx9Os2PLEfpm9gRK1E9piQUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752102862; x=1752189262; bh=PQzYB4iU4TsscnrBCIIOLL8D8e10SLEQ9Wg
	xA9vRav4=; b=eUPyW/n1fPPvI1fMjiIe3FLrQQmRHJCyQON4bXvLp7BscToqiry
	SDbWRGkqVZ2jHZpu29Rj7Zpptg2Fp1uCmMYDaxfC5Lz59ybb+OuV0U/cEWDkd1xF
	ydJv3IrfpFjYFJGQiVpjA3nmQNmlkrnbnod2nAXHHnbt1E3fuyD/YG3801O/UDi5
	UlsaDMVMmYM2gU44XJdlUJRy0Ti5pjAjaONkWjkzm1ht1fQFTq1IG+liLYZ+ALXr
	2c28UsOCObp4Xi3X5qqRl6Q8u8Axau/XPDOtUXkCZNNFLhk9eW7WpJoEeJ2D/Leb
	a+ypzf1ASFmMxXSpWRtcTvnL+duixGuo3fg==
X-ME-Sender: <xms:zfduaDzms6DiBlVCI088ya2oHbZdesrZhDePrd23oxKTnrvsy8VGxA>
    <xme:zfduaILE4NtJlVncIuKCHPCu50ltl2iw-wLcib0sOBcZpkRx44bnCAnSKMH8mj341
    qOePeG1aJVSoTXXdg>
X-ME-Received: <xmr:zfduaNEspYDqBo_N-GhnKr9jsxnik50GZigUj1oqCKGBDwXuyMDkUP7RXOHHOQtp47lbeYQET7FnVEzYl8nw_LR0FnfYgBY0FYHU1QU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zfduaM8KxDzXWA6MECdvRmzveRXZH1hGcZF4i-zvA6xZiTCahfp_lw>
    <xmx:zfduaFJKpIsghkXt_YH6VFZCbpK0XEVACP74RTZx1iIBCjbmKjRQsg>
    <xmx:zfduaCtNWHjaQwCDT7iWnHUaUNMMGLMzPljU7bGz3o-PK9horNj_mw>
    <xmx:zfduaEBkXXh005UPplxzVdiLbP_SZwP8N-1n4OMPrAs9AcE-lA_25g>
    <xmx:zvduaJOm_EGmlcDG2QKt56unVUibS9oBX7_xZ9wldCHqkIkbLX5VnNv1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 19:14:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6] fast-(import|export): improve on commit signature
 output format
In-Reply-To: <20250709141253.623563-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 9 Jul 2025 16:12:53 +0200")
References: <20250708091738.4072857-1-christian.couder@gmail.com>
	<20250709141253.623563-1-christian.couder@gmail.com>
Date: Wed, 09 Jul 2025 16:14:20 -0700
Message-ID: <xmqqple99ctv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +static void parse_one_signature(struct signature_data *sig, const char *v)
> +{
> +	char *args = xstrdup(v); /* Will be freed when sig->hash_algo is freed */
> +	char *space = strchr(args, ' ');
> +
> +	if (!space)
> +		die("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
> +		    "got 'gpgsig %s'", args);
> +	*space = '\0';
> +
> +	sig->hash_algo = args;
> +	sig->sig_format = space + 1;

This is minor, but as I already said in the discussion of the
previous round, let me remind readers.

I think "*space++ = '\0'" followed by "->sig_format = space", as you
wrote originally, was easier to follow.  If I were doing this 6th
iteration, I would have kept that part of the code around here, but
would have renamed "space" to a more generic "cp" (very often used
in this codebase to stand for a character pointer).

Will replace and requeue (unless you have v7 before my tomorrow's
integration cycle, in which case this iteration may be skipped).

Thanks.
