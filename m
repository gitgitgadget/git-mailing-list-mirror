Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963C1F3D4D
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526701; cv=none; b=QnqO/1CUebI5UCQAow3EKSaB/cN5QZdkBn5+QBf+YAxWoc8uJpw6J0/IAzJrqqurzEaEB5aNQOc9rtX/rCwSAsMc5CVxEXcajy706Na5wH4V1Yzywy93ZQ4ciLOiLHyeHKNCjIwTFz+ixWHqGL/ZNjYic5flKtiN+5/PhGutqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526701; c=relaxed/simple;
	bh=xUHbdNM97/clRfNhHDu0bsmaG3UudmwX3U8envHo9EY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GrIjwYRe7dD5myJImB7IFaTJJsEJtdpMGFpGLvvORoAiTl0Mvb6Xn23/wf3eQartyXBPCwkGIJOYJ9HLPu7FRtPHZ3wPEIUgnoWlAYLqaGpd23t/AI18tLRyDcnaZtXXsZbfbuzSLK+Mis+pNkatOJSq4sC3UcfLmUNjm7nfEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KGwHSaXa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KGwHSaXa"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01F3211400C9;
	Fri,  6 Dec 2024 18:11:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 18:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733526698; x=1733613098; bh=XOwFRVaIxJjnN2WHgz53h8eOachnXhXAbI/
	JhSJQie4=; b=KGwHSaXa0Qt6wPCZQzUN8HQJfyNJXAR6Q1ugF1XiLTL2jwrlcWz
	A6rZEmxwRF+DFiC8x1rrrIPRKM/P8eOJqAwMkDihdUBLTH00dZwAy466yCOW5JXa
	pbmfucoOHwuqHzXc24RJojwKnax+KgNIRmZBWBcG5ezS/96HlKC/8dgQjd+9XjqL
	ot/E1Dc5I0APu4YGhir3+FhILSaFnJhyA9J/1BHRafriXxU9s2vuUcTgGA1cCmc9
	cg39poXtI9G3Vbc3gjkBhUDFXcduFZwkXy2wPiSTjZaMQ5BsPMrCSNoh8Jw9fq/q
	TXfXfCRYZTtnSsuojvH+AJmw+fKGJqdWO9A==
X-ME-Sender: <xms:qYRTZ1EGVwATCcTgLWsNXHnc-rNd3U5_j5qXiha18KkGRWyzye8pnA>
    <xme:qYRTZ6WSXK08oeCFotljtkO1anuGA4CRFuUXSo7YTK9kumZ4lVYfp_f9YSsz5jEmL
    FdJ3MdsqSNeKhpwqA>
X-ME-Received: <xmr:qYRTZ3IGpzl5qv7th1rUu8cXrRhk1ogSTmHYwFxkiV2fBAfLMVbqsLJTOD_nK6cwXHIjBUwWo1dO0Lnv_8YX6L9xjF6mJ1_co1khrjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:qYRTZ7GW460Qc1fz9d0QCtFmwpa7L260Iq6dpuzx2BO4HDtdOzdhDA>
    <xmx:qYRTZ7XzuShXB9fboTnIkMVM9sn1grk4VM2mvMiXIJ_0pgiXwIpteQ>
    <xmx:qYRTZ2P-44no32rDQFbW9oksWeo4bzM6FSCuD1iaTlBqm_wQY8EzCw>
    <xmx:qYRTZ63TgVzrIe-vq9nU3Vk9XQ2FUeYgbaiW-tpNIOC2wRyGGXJWng>
    <xmx:qYRTZxxLJ-_T0ecwj7fko2AXW43akMci5GaYvE1z_fE3Gjp5xvzwzGcH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 18:11:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2] reftable/writer: ensure valid range for log's
 update_index
In-Reply-To: <20241206-424-reftable-writer-add-check-for-limits-v2-1-82ca350b10be@gmail.com>
	(Karthik Nayak's message of "Fri, 06 Dec 2024 14:13:19 +0100")
References: <20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com>
	<20241206-424-reftable-writer-add-check-for-limits-v2-1-82ca350b10be@gmail.com>
Date: Sat, 07 Dec 2024 08:11:36 +0900
Message-ID: <xmqqwmgcv23b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The corresponding check for reflogs in `reftable_writer_add_log` is
> however missing. Add a similar check, but only check for the upper
> limit. This is because reflogs are treated a bit differently than refs.
> Each reflog entry in reftable has an associated update_index and we also
> allow expiring entries in the middle, which is done by simply writing a
> new reflog entry with the same update_index. This means, writing reflog
> entries with update_index lesser than the writer's update_index is an
> expected scenario.
>
> Add a new unit test to check for the limits and fix some of the existing
> tests, which were setting arbitrary values for the update_index by
> ensuring they stay within the now checked limits.

Interesting.  I am a little curious how this was found.  As long as
the other parts of the system (i.e. the callers) are not buggy, the
update pointer will stay within the range, and that is why I do not
think I can write an end-to-end test to trigger an existing bug that
would be caught by this "fix".  Fixing the existing unit tests that
feed a wrong input and expect some right outcome is good, but would
it be a good to also have a new unit test that validates that such
an incorrect precondition for calling is caught and the caller gets
the expected REFTABLE_API_ERROR as a result, I wonder?  Being able
to trigger a condition that is harder to do with the end-to-end test
is one good thing about having unit test framework, no?

Will queue.  Thanks.

