Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241421EB19D
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545165; cv=none; b=r9d2Si/99/uTBICTWjstgxGgslh5tI9yk5XQm6MFzIWXXQYaBoDcmgU9yBTWoB31c92WI6Oyl1eK1CvGmjgq0dfChNzkVJ83YEF/dWweFNYtbdKa4TdAZNuOLAsFRCvKZNHAVAjMT9FbUtlgvdVIPgXbLHOcebuq5v115Fyzyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545165; c=relaxed/simple;
	bh=p4wwVcLRW8CZiW+EKPP1q0DftGhwfE4tjbK/hMAGtDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OyVx5QjI7QnGQB0ya7BchA9gskfJud0MKWRGFm/aPgmrFFwIRaadLj6x6cDY7P3o7Q6DDid2Ifypn1Oll9hsLqrvWGiw0kf1qyOqthu4RkLAzaDs/0p/hlj/WFCcIq5KNEkP0leOb3o0vel+x6jhYSTHyRL67aEHAwjt48pclTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nOJqnDpL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2wNmk6l9; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nOJqnDpL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2wNmk6l9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E41942540230;
	Fri, 21 Mar 2025 04:19:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 21 Mar 2025 04:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742545161; x=1742631561; bh=EVmVLJqSiB
	ck+cyEtIf1Ts14RgYFWpS1LW+ripk5SHc=; b=nOJqnDpLG4K8294xXgDXXMhk8E
	LbfGlmGLdIqN+Q30v9gYeVL2m1ItIkL4i2sjkUrjDXITIZ6d5tb3fpmPjWEw5all
	0VYBgi65uRxM3zChWzlvw2KKlTK7i0tsJ+XJTq8j0ylxfDrCKghl1otSioReJB8h
	s87xB44TGDERuw5Zmh3ciS36qVWPoHTPljrJnIU8icdh1s4+RxDSPNvU6gxY2s1v
	1t+gsiqKIfu0L4Zf+hFn4tJdW1j4W4iwliT7KEinHCHUREvIEuvMdQhDam0NVPr/
	kb55uRDHJmHqEXCmF5LioXrF4pNFnrneUaRBcz+rsO8q0CMU04Ny68LbFm3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742545161; x=1742631561; bh=EVmVLJqSiBck+cyEtIf1Ts14RgYFWpS1LW+
	ripk5SHc=; b=2wNmk6l9koZNqPX+ux1HgSCg87WC0F7Oys7WAtBvXMzu10hFoXw
	bG/84A6jvBjwxItzmYZHPZczgzt8ox1HnuHQxooMmXsy3/pZOHnD1rh92Z2DDGWc
	czuPXcsokHdML8Zzp6kBb2kRVNPANcpN/iDKVQgsFW3+bq9m/WWNJgUEzxcW5U93
	GUUYrGIbNlmK+5zEPM+oIDpSfF7QwVCaKLYZRBviOe7BhgVLCT+DvWjD0tD3OZIU
	V7P7K624UGBEyyKUBmR28tGNIbaSgyCswxF1cNGZIKL/zRo2VMJ6CUqEekqdjo8E
	ksZ2AN1x7uQDs/FGy2SCcrUTiqKFWKbet1g==
X-ME-Sender: <xms:CSHdZ04d3IKK94z2l6wt4eeZPTHqqEe3FRVrvxTQmL3NCcD3f0cXwQ>
    <xme:CSHdZ16q6mlO5YGicuau9lbJPCnFqBiUxGwFOpblz9kyYJcudqrN03zs3J08Py5t7
    mABz_Orhkd1zBHKIQ>
X-ME-Received: <xmr:CSHdZzdWA3gDxfEAWrU-aFcN-KYkx_HXV-90rz_e2SZrC5AbA6LlyBfINbgmUv0-Qi86Mnx8VtJ43TZs9jTw3KM7d_6t6AEmfx7HiQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CSHdZ5KLeIrwUCR2YuKp2ZgPziyqgd0LTK-Fr2vwZ8sTQX-JcMk7Qg>
    <xmx:CSHdZ4JdlMVed2KcRNtvLJQVnXQSXtdijSDxUrioelVPdDHVp6Rxxw>
    <xmx:CSHdZ6w47dyPN3LMq-QWfBNmhde_w9IQhcvJFBuLj8mIUlIL21jF8Q>
    <xmx:CSHdZ8I6GQvnwXviTf9I2N9wZgY-n0ZFfNSROigq9uzEc7o_dLM0Sw>
    <xmx:CSHdZ82HS7tRlGRgeeG-bi0cYLNJdDswB4mNRH1ykluWkxHId7fCZpU8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 04:19:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: jim.cromie@gmail.com
Cc: git@vger.kernel.org
Subject: Re: RFC: git bisect worktrees ../wk-A:../wk-B
In-Reply-To: <CAJfuBxyUvvmevCC7bqLNJM-kTRVtMEhF4rSgf_1OQxezCOLSHg@mail.gmail.com>
	(jim cromie's message of "Wed, 19 Mar 2025 08:11:24 -0600")
References: <CAJfuBxyUvvmevCC7bqLNJM-kTRVtMEhF4rSgf_1OQxezCOLSHg@mail.gmail.com>
Date: Fri, 21 Mar 2025 01:19:19 -0700
Message-ID: <xmqqo6xuvlrs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

jim.cromie@gmail.com writes:

> hello all,
>
> it would be super convenient if git bisect was able
> to flip-flop between 2 (or more) worktrees while bisecting.
>
> This would leave both A, B in re-test-able states,
> allowing detailed forensics on the differences.

Many small questions come to mind, including "why two, not arbitrary
N?".

A bit more constructively, I think you should be able to build the
machinery around "git bisect --no-checkout".  In "no-checkout" mode,
the bisection machinery is used only to compute which one to try,
and then you can update your own checkout you choose, which can span
across multiple working trees.

And that machinery you'd build around "git bisect --no-checkout"
would be the place to answer those many small questions like "you
can use N worktrees round-robin fashion to keep the last N states
for comparison---what should the value of N?".

> if this were a well-known feature, I could imagine that
> tools like rr would be enhanced to exploit it,

So, if you are planning to teach third-party tools and enhance them,
the feature for them to exploit already exists, I would say, in the
form of "bisect --no-checkout".

