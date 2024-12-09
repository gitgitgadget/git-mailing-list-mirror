Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C319DF8B
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785272; cv=none; b=dm73WqCUc2EsIU9lEP+jzQyr95dbY14/MhosicFeAmo1UIS0xvD35ScrxyeaymMn2WM7HKzikqGDP2q6e+ChsqoxGhw0aRB4a9MSNUogB1R5ogOdGYLrGJ+ysk5Lm4mbM5gyQrD5zswEjHxQw1phigRccOC/Gj9L7vCUTtW8I/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785272; c=relaxed/simple;
	bh=vrRaT0apRXgsxfNbFBVCq+BxciJSHLcJIbDIEQ2kQVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MocaSc4NthRKcw7XBUfnqYBTbkZPg4Z0tHPSdYjiPc2t3/zewN5SBTank04ZtfcG60zOqjpOXS6XOlX3pLRWvbs4dXTmPxJXyA0cowVIMZSXFq7R7Ns4zA781qfeKOMHAg2SKWFt2pCYrx2539mXrehbCLrjzcq6S0YJ7YUeOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFXNvo/Z; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFXNvo/Z"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BBAE1383937;
	Mon,  9 Dec 2024 18:01:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 09 Dec 2024 18:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733785269; x=1733871669; bh=IgAa0pXfWk/Dcn92sq7niz9ZD4qCSuUqb2D
	VKgpPzC0=; b=VFXNvo/ZHk8a8Y5QD7onRFB+ImoYYQbbETx3+CchqcQt1D7avIQ
	D+QskBCHetiuEK9V98dvL6ysYVzH05WVZdO5rdqsxHcGi8ybsqlYMNVjbKY9Toio
	kEfLpEAT9DtBYmC0TYhsC0muC9ADnu4HBoiNrOdrKpl4r1XzO2KKRTwZqsEOmN/Y
	WUYBoLENaRizISc+wp5HxC2eu/UqzEvpXf0Y8dNAPDu9bgqR2tQx9jg6puaVTrQ0
	y5fHa3vVa75/aJT/TLFXjRaTtSZ2FP6sEQuWYGDE0l/e3qGm+GBXH2e5IDRDvPiT
	jcrI0Ys18v8LNo9DYsOCxrHkUb8VmjFOVhw==
X-ME-Sender: <xms:tHZXZ_vk2HX8Gn4LIGvFDy0WiUsLrIEGPMKqMAUuwRBtKeTm2u9F4g>
    <xme:tHZXZwcdbRSfDJ4KFSIJMaiVlRDCggnO1kNhbf-cdywKnFff-ZYbzrp7ZSeFeIvjw
    BkGe5xqvyN7wPeQaQ>
X-ME-Received: <xmr:tHZXZyz-XYbM8qwz4xIxDde4dPWyfn1W34MEqkTCY9otT8_sqd-__Gdl9f5NDi6KYyDlMdp5WC79qL-6x6nuhgGiD33TCIliTTwMff4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tHZXZ-Ms1GUctG7qh_NvWeDHkijm8_Bs1hm3iJnrC7Tf6iB-TMFECg>
    <xmx:tHZXZ__SMnNRnnuYdR6YGsQf6woyoR0yM2xV6Eoz0tCbyChQCdj33A>
    <xmx:tHZXZ-WML9znWE-8QX2mnLn0HV-xLDo2jZjXT881D9qzzkTik4NLAQ>
    <xmx:tHZXZwdNjmRtXDiVDmkKNud2KuG98GxHITrlhHipeodCFXZmEYrphQ>
    <xmx:tXZXZwP3g8MAYNeor_zr61cY8vLYHX53TgMtu5KCSyYakODemNq-Yati>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:01:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/5] Introduce a "promisor-remote" capability
In-Reply-To: <CAP8UFD3bdEo1_bg+aX52xSGxmg9KfNrpiX+2LwUM-yDqjvfZbQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 9 Dec 2024 11:40:24 +0100")
References: <20240910163000.1985723-1-christian.couder@gmail.com>
	<20241206124248.160494-1-christian.couder@gmail.com>
	<xmqqikrtnuyp.fsf@gitster.g>
	<CAP8UFD3bdEo1_bg+aX52xSGxmg9KfNrpiX+2LwUM-yDqjvfZbQ@mail.gmail.com>
Date: Tue, 10 Dec 2024 08:01:06 +0900
Message-ID: <xmqqed2go40d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> I noticed that fcb2205b77 (midx: implement support for writing
> incremental MIDX chains, 2024-08-06)
> which introduced GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL adds lines like:
>
> GIT_TEST_MULTI_PACK_INDEX=0
> GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
>
> at the top of a number of repack related test scripts like
> t7700-repack.sh, so I guess that it should be OK to add the same lines
> at the top of the t5710 test script added by this series. This should
> fix the CI failures.
>
> I have made this change in my current version.

Thanks.

Is it because the feature is fundamentally incompatible with the
multi-pack index (or its incremental writing), or is it merely
because the way the feature is verified assumes that the multi-pack
index is not used, even though the protocol exchange, capability
selection, and the actual behaviour adjustment for the capability
are all working just fine?  I am assuming it is the latter, but just
to make sure we know where we stand...

Thanks, again.



