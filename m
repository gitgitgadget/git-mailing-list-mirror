Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EC204090
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592182; cv=none; b=BPZmHaXM9ROdfx8rCGHoH5gp0Op/z7VCfBgAv+4d5Sc+HrlJrFCoAWb6BWfPVSBk3T2Bi5+3JnEiF61yjtJThpWuQETqMZ6qJ+N0zj24JgNNACbIxnrZ2ZMLaYXoLPgCTjp1jwAWvkrRbZal1HhpDJXtXO/Q+F+SUDQgIyOEUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592182; c=relaxed/simple;
	bh=UHaI8U9y971k/hxFWFFUDCT34LyRPnBs8Eur4nmrZfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N/ekvPxz9c7fyNnkZAxTccd/C3oBBsRvzNTOuZsXkaA7sVlnCqBFRLOXyRdkVSA5+RODIn7kpWTt4cHYq+0x+lOGDLTf7c1FHxdm4ut8tBVK89g8cxB8C8d45+PLE1MuVdW4uaj8a/m/MLLRTjCnaxUglgU7l2x9ZvFumQ7Q9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iutitNZQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DLYGt/ak; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iutitNZQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLYGt/ak"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A75AB7A01C4;
	Tue, 15 Jul 2025 11:09:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 15 Jul 2025 11:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752592178; x=1752678578; bh=UHaI8U9y97
	1k/hxFWFFUDCT34LyRPnBs8Eur4nmrZfg=; b=iutitNZQ3jEV9NcrDYZbZXFOh1
	2u6oTEDZckAzhFheRJHvnr8j03pgQ0dqtQaPDiOoKsvdZ663CEwE93xpsPPMfRHM
	6foRoQ7lYqK6a+yVH6b7bUxRmMIZKFUbBx5k5xXV77Q+41aUbAo86h6yDFy4svdE
	mGT9tmIZnbIS448mr0Y7wotqNkHDd4YCvexcczaW8M1BUcjLU+wVFTF7JqTos7jI
	ul42nEyvQ0bqhfDptYYRSgfRl3aRt0Y7Y5dKE6OD5rZw1qupDaAE/ML3La+Nz3dM
	XHJJJMTz+KqE07CH3/s/zi7Wv+ra19ldXoo89Uu6V/It3vs854GQ3a16zQTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752592178; x=1752678578; bh=UHaI8U9y971k/hxFWFFUDCT34LyRPnBs8Eu
	r4nmrZfg=; b=DLYGt/akR50XwK3zkngE44XECh9br0kPSe6sTeZTfOR0YYeEP07
	PHl41RpHiOBvmAumci4jHr4jIMFkXxgyGiXsnsX2rAJi64qZ8ONMsfbrl9KsSCeY
	cC83H8AIUmckADMM7P6wivIhrwCfVhVWCgAhJwYmHTliAf2YG5U43aBD5CCCnbek
	uVEXv9C5d0Ux8EAjsTQh+nkrUVnFB7ntITaG/IV1V3AivTdTO0aiKo8TSYRTariI
	z+sukQ4TdtguEvVT2iPJIveJt7xJ/MeY7fQdXg6ETNuWhnWvcwLjgll86pDcavpK
	gjYE1XxNF0Z0p2cjQijpjFMqpEyaf2RhnSg==
X-ME-Sender: <xms:MG92aMXIS5sGdSGl7A7WlAnS4PiQJeOJdFTn16FJXUcWqTOWmVCM_A>
    <xme:MG92aOjBencL2F794ciPOP5KB0N5Ec5TMoutCfvscCMr4cIuhYrTjPFHuVKTt_VWr
    2jLpyHDyA5ZInUKwA>
X-ME-Received: <xmr:MG92aCtBzBKMWpRkZi5iLgmuKVoOy-c_zyFpvvzShl7LSJoFKCy_nZPy5AjfG6FaZGykGNxllM6U3_HjBgOw8rmW3Nl9VQIhx12ZzPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MG92aP676ynSbwrQkf_qjujnp-cmNFw4N2_1J5KNVAydc-WZeY-ivw>
    <xmx:MG92aOOuWhpbjRz8aNUkh3jg7Iq6bCGiVPBVispsll69zYSC9-snqg>
    <xmx:MG92aNs3ditRGQx6w5Dl0YYFrqcOs13Lm5AoRBbUhkQ7ODlnHS_p1A>
    <xmx:MG92aBapmK7sclQcH32VAh4uCU1f9Y5Yau6tK0W9BDUwvSmF_wAbuQ>
    <xmx:Mm92aPBIA0blbgJge8DgCYAZBMbuHNC7Zwnq2H0L81j4WAJ4YSWndYQo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 11:09:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,  git@vger.kernel.org,
  toon@iotcl.com
Subject: Re: [PATCH v6 0/5] bloom: enable bloom filter optimization for
 multiple pathspec elements in revision traversal
In-Reply-To: <bab82a6f-e704-45a5-b422-75dec2b86d90@gmail.com> (Derrick
	Stolee's message of "Mon, 14 Jul 2025 22:48:33 -0400")
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
	<20250712093517.17907-1-yldhome2d2@gmail.com>
	<0969e176-b9c7-464d-8e97-cf5cd4a06347@gmail.com>
	<B090DCBA-7306-4BA9-A5BA-DA81D1ABB29C@smail.nju.edu.cn>
	<bab82a6f-e704-45a5-b422-75dec2b86d90@gmail.com>
Date: Tue, 15 Jul 2025 08:09:35 -0700
Message-ID: <xmqqv7ntij80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> No need to reroll anything, I think. Junio's got the right
> fixups in place.
>
> This was just a comment to help you next time.

Thanks.
