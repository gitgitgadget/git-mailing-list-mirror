Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556391C5D66
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583059; cv=none; b=UAc2MQ3UxbaT+1lP2fiuO3NjgpnxpdxS0wA5EG4XIsizmFvvWWg/8buXJiCnjw6KHCz9bN14tmAwO+MilVdw07tXqzg+Ylf0xCQFXGOr8OPe+aVVw5PLhLvI/R/I6V1bkDPzdrS/1gKMk4WIUs00H/crZy0oa+D4K5HnHAfK3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583059; c=relaxed/simple;
	bh=VlmhYHsfMtMxHnVtBK9h/i9fAQf305RZN4QneIvvxfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iiuL/bwR7cpzU7cdthTwTsH3/UDDhHesMp9sSKlSephiTfsi/NLIK1z1UdpZJHt3tQ7L/uwMD3hRaklg2diacNv3fWK1UqoXAKUEx8Kh6l+YVMTE0hjaZ2HXtH9eR3DnBLZEnn+ibGi6G+6dXl7isNCaRWNZT6jB+8y12hk95jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M7tnQDWK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qWesNPmA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M7tnQDWK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qWesNPmA"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 48A6513801DD;
	Wed, 22 Jan 2025 16:57:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 22 Jan 2025 16:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737583056; x=1737669456; bh=uG2cGUASvI
	sXL5Bp1/XuqpO484HR/aQl7hMwno5o+9A=; b=M7tnQDWKoQGPhsfN4IgYr1X5EA
	Tj4XjrM5dQ9KzB74Zxm2E2qjny9WgdHuu+/FqD7VslfWY7vbrpk7QZDJfZzzSga4
	eFNCnnzNiqj3UGJoT87HnhNMNxOx8hsWw5tgm1F65ATtxelqUgQjS5K7mduGcAif
	gvOgzOOKq3OFLxMjKTmJRNHU3LSa68s5DcljXDX6h8DShQ36ZzhJ2rnazTGolB0K
	e8b+VrhvGmR3PM25Hl6HcjU5bv6QihkawXfZdbJ3UjJsrMwCgSdXmOgzBq4FLLk/
	JXoX7ziU0egV/ODcH5jBoWPsu9oDOnWLshWiyaMgR7yUyvh49IYrniv8xPqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737583056; x=1737669456; bh=uG2cGUASvIsXL5Bp1/XuqpO484HR/aQl7hM
	wno5o+9A=; b=qWesNPmAJNIkqawISbo3UvK1In4r0XgGu33I9GFCllX0m97L2Ku
	o2mTN7wPP2kfGU+dOCnkadce1UnAHtqzBJPsuq0xmpHRMJD+vSya7H2KuqIniQ47
	WMW80kRFhG2CJzmkm4Y5Q85HwDXIOVNZyLghUOsNCM0yC1tFAD5HZrOq/t557kj2
	Uji+JRVhGvVCweROAxcACu5cpF+pj5rBSjnIGJk3NfKEDUmOQ2IgmFo4AQ0T3W4b
	HS+YEYLFVNMVH5YEmh3xYdia1/a/Us2ohfaYB9Ewf3NgV5imsrPLn92KqH84UrZQ
	OaX0r3x1/R7eaOqcAz2FQBombF/V+c3d6Pw==
X-ME-Sender: <xms:0GmRZ6y2bC_J9P2iWLQMhy3hq8rP2e1EOBeJ0CmUq5oiUYSoRXdU-w>
    <xme:0GmRZ2Rr7rNVUqp6XqNm8Ja8MRHhc45VjDdGJBs_KTufnRmvJsQBy14EXPtzCVLMy
    y3rT2CN07LcAPrbCQ>
X-ME-Received: <xmr:0GmRZ8Xpj4BovJOn25uZDxxj-h3zv_w3QjylASzuT14Y_nRUtdGmBa_ENDJ2CxTPYDOxObScvxrou1f81Lp3OBq-NEzqWTI53ap6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0GmRZwjzzKVORrB1_VP7nv8pDg0nIdoRVSXum3FjzSQ83jgFP4kz7A>
    <xmx:0GmRZ8BuQPINya1kSzta_fARylX4Wvg5rfN_xAzOZCgntc5rCm41Rg>
    <xmx:0GmRZxJE1iIOooMhOj1pWJLIBKHVYOJwQpyf3b3WRTzxy-ex6jwu3w>
    <xmx:0GmRZzC5mCUA0RUtHLvHbjlFpAlJLih9QRgWrXpdRKsXmgK_VrGvUA>
    <xmx:0GmRZ_89lpzokJ_NbJDvkCmWbx8ZuHuMj7TH6Lq3c4093WeHYIiGM7ss>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 16:57:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] reftable: prevent 'update_index' changes after
 adding records
In-Reply-To: <xmqqzfjiwxei.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	22 Jan 2025 09:50:29 -0800")
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
	<20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
	<Z5DgxQuc2j_-5GHg@pks.im> <xmqqzfjiwxei.fsf@gitster.g>
Date: Wed, 22 Jan 2025 13:57:34 -0800
Message-ID: <xmqqo6zyv7e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> Nit: it's unnecessary to pass write options. Other than that the test
>> looks good to me, and this nit isn't worth a reroll.
>
> This write_options opts is used later in this call.
>
> 	err = reftable_new_stack(&st, dir, &opts);
>
> and "git grep reftable_new_stack" finds many hits, almost all in
> t/unit-tests/ hierarchy, only two among many of them passing NULL as
> the "use the default set of options" signal.  And majority of them
> initialize their opts like so:
>
> 	struct reftable_write_options opts = { 0 };
>
> So I agree that this one should pass NULL to be more explicit that
> we do not exercise any special features from the API, but so should
> many other existing callers that pass such meaningless &opts, I
> would think.

I may have been vague, but what I meant was that cleaning it up to
pass NULL when &opts is unnecessary can and probably should be left
outside the scope of this miniseries, and done with a clean-up patch
that is separate.

Thanks.
