Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A3193062
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999250; cv=none; b=ET+P9qTy0EjTOoLg4CHL8E4VSXMtgzzVrnMHMMiCm0Q5NUTLEYxhV1D7NSGwb1f76EE3UgaY2x8OAWcLrxtgYns7ePt24J71Vz/6U8gftqCHA7nzK0YWtC/SR/n4Yrer2bQfFNB9Z0viUk4a9NdcE70A74gDe7WI+6RnYwlXHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999250; c=relaxed/simple;
	bh=TCJwk9vWhiXO3e0xv+7aZR8hqqa5W8yS9GS6swku8iI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KjsZKkmRiGDcuuJKBVB0OOhub9J0iKMLvtlrrl7EIpiccRp1gsTaGL1yY6zycT0j2xkSnEspVKFtX12CdBFfROZ5SLb41t1MBooRWJ7b+7lUFJyakV8wfOlV6uqDV/QLGWkDNPo2z+Hm9kVjB11w0pGakh+oYrtRksyYcFD/gio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbS6NWoC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbS6NWoC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48F2E254019B;
	Tue, 19 Nov 2024 01:54:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 19 Nov 2024 01:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731999247; x=1732085647; bh=VLfLGosiwpBdMJH9ZBRKdwVjfFzUAOJIGwg
	rnQBTk8Y=; b=IbS6NWoCugZtiYQz5FgePtTybn1z+58z/qarkTD2hB5EXTrJzc8
	KUJ/61M1Q4qsVQRepsOn//T7CkuWOuICwk+GjmCtO7+/pV0jSchAp5D/s9bm8bqb
	9AznpmTfS18SlQ0FAcUshuSYDhd3Wr5FgMDkn3w6b4XgVnQd9xuSRPVxAX37ip9C
	OpGzdIQRQz2ozsKDdYAPvWIBr5W464shyp4piMVj4UPDEbdYjDkti2e7J+Qe24FM
	Li3C6KfjxCw30xlTpWaBZ5ETewssd9wPy4w39NmW3kG9IoDGP43xYsJvLUJZOMPt
	EOC3YWYy4TLw/954H+H1oYxLTreRKOtMr2w==
X-ME-Sender: <xms:DjY8Z4QO9fvEzkirkscJDyWu4hd8A-CC34FJ6g3RN5VJVVtudffiPQ>
    <xme:DjY8Z1ziB5Q8EsZ5q3jrkivpx-Ajpq2X5gVtMj8dwswA5lIxg7KWzyXf93HLDCzo4
    -WBUVgjOsPevy2L9w>
X-ME-Received: <xmr:DjY8Z11h6ohWo3r-unA5yRwTWp_7YzbEpT8jlXm37V_hwOlmQJpybZMF4MOxiYV8F98oz4UGAZhrj1AnfkYgfcgQz5xawT3dx7Z5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheplhdrshdrrhesfigv
    sgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:DjY8Z8Bu5Is-UeO0cHWflbjR7tEd-JYe1Bi9tVY-JrlZhJITTtxeBw>
    <xmx:DjY8ZxhsB6GPnoh2IwJUSvL_rN_9FiL-Xm32cqICVemLGAoQ15GzTQ>
    <xmx:DjY8Z4oyTTJDSOSGROdxZUpiMeT8dOLPgkALCFoyDbmc236sRH1kkg>
    <xmx:DjY8Z0gSHHw_1wRUGVd3z5ig_-8JQQkGGBXo3QcR6K3rsTeUghLbAA>
    <xmx:DzY8Z4O_8pkdbCRE5bJFeaBWWNyArCreKVONtP700jPuwfq5zECWB2TR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 01:54:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  karthik.188@gmail.com,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH v13 2/9] refs: standardize output of refs_read_symbolic_ref
In-Reply-To: <ZzwzrI6wJjY2dpp0@pks.im> (Patrick Steinhardt's message of "Tue,
	19 Nov 2024 07:44:04 +0100")
References: <20241023153736.257733-1-bence@ferdinandy.com>
	<20241118151755.756265-1-bence@ferdinandy.com>
	<20241118151755.756265-3-bence@ferdinandy.com>
	<xmqq4j44ggq0.fsf@gitster.g> <ZzwzrI6wJjY2dpp0@pks.im>
Date: Tue, 19 Nov 2024 15:54:05 +0900
Message-ID: <xmqqr077d88i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There are only three callers:
>
>   - "remote.c:ignore_symref_update()" only cares whether the return
>     value is 0 or not.
>
>   - "builtin/remote.c:mv()" is the same.
>
>   - "refs.c:migrate_one_ref()" assumes the behaviour of the reftable
>     backend and only checks for negative error codes.
>
> So you could argue that it's the "files" backend that is broken, not the
> "reftable" backend. Doesn't matter ultimately though, the real problem
> is that this wasn't ever documented anywhere.

You're correct that it does not matter ultimately.  But as a general
rule, which also applies here, anything newly introduced one does
differently without having a good reason is a bug in the new thing,
I would say.

> Another solution could be to have the comment in "refs.h" for the
> caller-facing function, while the backend pointer simply says "Please
> refer to the documentation of `refs_read_symbolic_ref()`."

Yup, avoiding unnecessary duplication is a good thing.

> The reason why I've been proposing to return negative is because we have
> the idiom of checking `err < 0` in many places, so a function that
> returns a positive value in the case where it didn't return the expected
> result can easily lead to bugs.

I agree with the general reasoning.  I am saying this may or may not
be an error, and if it turns out that it is not an error but is just
one of the generally expected outcome, treating it as an error and
having "if (status < 0)" to lump the case together with other error
cases may not be nice to the callers.
