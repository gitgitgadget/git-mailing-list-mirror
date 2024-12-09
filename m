Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE73155751
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733729619; cv=none; b=jN4uxa8AKcJ2RYJZyc+/BFdSvUudijdxAllnLXSptUWGkL+YOBvZVzNUGzUCY+8clZBCVZMTYrzVXV+pLg2e5lOVzyiYpFRpEnjYHFSCkjBsEK9dOig4Ah9ZK/J0NyFWLHIX/0nRsjzgBHmOh0IdSMwod4rveU6VXU6y8dAPBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733729619; c=relaxed/simple;
	bh=doWcnmrHcassVQX4BBN5+chuuxwP6TIfxBrvG/GiDKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L9g60+6fF4H8iwBuMcrzMpH7azAJ5HH3i+cBhbetsGFbFSzxgFQraQsVE00C+5mg/bFIkGl6yuoUALk3R93T/8FC4pU0vTruWdrhjbbJzO8iBiFy+rxmCNeYQ8FjIHtTOtLkn/TDYk9BXLfqt98D/sOPZxog2xQJ2KwgnM0Cscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZScKCrWf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZScKCrWf"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA167114010A;
	Mon,  9 Dec 2024 02:33:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 09 Dec 2024 02:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733729615; x=1733816015; bh=rfAPCjQizSwbK42ZgscN2IvKWvz+x0cYL09
	weZAGhVE=; b=ZScKCrWfbczkYqmkW6C7Z4UOh8/lguX+YU9DyL1YkH7CP8VDnCy
	p2/22YvDbyuFBWN5rlJgIoNqychz/AxkWpMEAH/ecqelRpAhS3hZNCsaBgxTsid0
	7gTzDP8ivHegtahGW9YSCZio9yIs+KJRxBoI/kk2uOuwCgmeUqRmhDCSQJDhN+G5
	FWwCdztHmrOCnAHkoDALMj9I059ROStt6GoDbD1XC0UBFwJTxBh/57pGzwzLNICx
	1Isk4Nm8UKb3xIRAtXRAKuZOKXF72bMlvm6aC/4MAN4/fBz3wAIFbSMrS78OvUbS
	oIMz7fYX28wwI/Kg2OtZ5Z2wFCzp4ABr1HA==
X-ME-Sender: <xms:T51WZ_APMC_KYX4d46QrAKmD7_WszKdk53JqWHCqYYt0TuxsAK17iA>
    <xme:T51WZ1iF_l6s9Au3CQFMfoKTszqcLEw-DHk2HbrOBxf-VIcg_2xrP68XXipHlsUhf
    4UUqQnyfx0ikPG50g>
X-ME-Received: <xmr:T51WZ6kurFIvyySM_IbjJLIYXBF7DXoUrnJ44y7tpxsa2SjSMG2N8kPcGLu9d1yRdgTnaXZUeKNJZC3f2hWicZevJNC-VOcUsijix1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:T51WZxwg67ttREn3p24Ak9QoGyGLOdP9sCe8ilOUQV3d9ScXyIYToQ>
    <xmx:T51WZ0SYCWBXU3H0B8y7b-rSjP36l9KO3Gdz0vY1g-p2XOE3DOqykw>
    <xmx:T51WZ0aJeVqtvnbRnUIQIwkAT7asNMlLH7meC7RXH3vfPWM0qRJ-vQ>
    <xmx:T51WZ1ToOWrt5Ly9OYGK5aBGYjzoP9pkcygtSFLgOKGjOtAgL70q3w>
    <xmx:T51WZ5JWzyEEhz-mwmclapuCbGI_mC06P8GNZr9XgQMQnLldXHIu6DoI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 02:33:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically
 initialized vector
In-Reply-To: <20241209021556.GA1293399@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 8 Dec 2024 21:15:56 -0500")
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
	<5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
	<xmqqwmgf3nf3.fsf@gitster.g>
	<c949fea0-817b-45f9-b8b2-55e1cb55e915@gmail.com>
	<4e60eedc-e4d9-423c-b2e7-f1c65bccc254@gmail.com>
	<xmqqser33ga6.fsf@gitster.g> <xmqqy10pprnp.fsf@gitster.g>
	<xmqqttbdprj0.fsf@gitster.g> <xmqqikrtpqkb.fsf@gitster.g>
	<20241209021556.GA1293399@coredump.intra.peff.net>
Date: Mon, 09 Dec 2024 16:33:33 +0900
Message-ID: <xmqq5xntpaya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think it is this off-by-one:
>
> diff --git a/strvec.c b/strvec.c
> index 62283fcef2..d67596e571 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -66,7 +66,7 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
>  			array->v = NULL;
>  		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
>  			   array->alloc);
> -		array->v[array->nr + (replacement_len - len) + 1] = NULL;
> +		array->v[array->nr + (replacement_len - len)] = NULL;
>  	}
>  	for (size_t i = 0; i < len; i++)
>  		free((char *)array->v[idx + i]);
>
> We allocate with "+1" to account for the NULL, but when we index to
> assign the slot, we count from 0.

Ah, of course.  Usually v[len] is what you never touch (because
0..(len-1) are the valid index into an array of length len), unless
the array has a sentinel at the end, in which case you have the
sentinel there.  v[len + 1] would obviously be out of bounds.

> Or more concretely for the test case, we are adding 1 replacement item
> to a 0-element array, and the result will have 1 item. So we allocate
> 2 slots, and slot 1 is the NULL.

Thanks.
