Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A578207A27
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561479; cv=none; b=dU3Cainj8SYYjNB9AxlbZA36Q7sB0E6SQ2On3WLGX3agUWq8bfOfV2AMBPOPRcEFxLzHIOcVfRbAlK6eMYgJh7rVWl8DhOIb9rT2NCKkodsaRSjGg7QVEyMfuLi/Gtrje2eQFB3n3G4M/t0QcwRjSBqdUU+wNQqlJ/4FjscDC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561479; c=relaxed/simple;
	bh=JT3xVoYeOkMa10G2utSen3uJnXl7rkOvjF4UsLMIc0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VtK3Ua3KOWbYh7UW+Ks2rlnyeiLoJYWCHV/5uzWnVSqgpN2QI30Mbw3X2qY2bXRYZP8dLFJZ024wFlcGawVXBzeViYCyDgnQbnj7V1lX0iTz7kEv+QrFVBh4Y/pvXKWEhc2BQKjmbqyH8T2N6T84Zh5V9JAMhvWO70JVTnYDtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IkaN+rhe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YIdBhcZ9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IkaN+rhe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YIdBhcZ9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2FD1925401F3;
	Tue,  6 May 2025 15:57:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 15:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746561477; x=1746647877; bh=tHM5xtiMqq
	norZMRSVF0cogLdiqcYEDJmRE/614DFu0=; b=IkaN+rheR8eSKDX8QZHJM6jdUD
	S9kA8KhF6cN0IkHDiuQhVCLxklpv4vKmNfoZSUZ2Qds3NpD+lzydM+WvnRTBmIrn
	/ujD3pKoh0qT/jTZ8r5DY6eVifQ3RFhwyQIozWuN4Cf/yQRJXC0AcXSM6qiqg4XH
	vLKs60B9CKw7+wuPoja9mpD1A5tETozy3hup51ox143li7t8pShMrH0KnMoEm9Le
	TAWZ2RmAXrb/vxtSjrSz7BlT4jEiXlp/Rd/Jf9AslhHINOXWe1c+42AYO0hOsvPr
	RkZr9w7etvNCo4kquLnR/0QFWWFXRFIbfbmjDAKO2qppcfPAJIaWn6YAauuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746561477; x=1746647877; bh=tHM5xtiMqqnorZMRSVF0cogLdiqcYEDJmRE
	/614DFu0=; b=YIdBhcZ95AFxpM1xi8oe/TAoM2t2C3qknl3AfE0fDwOF8DuzRco
	31iMJ+nRz7MjxtIaHC1foBjZsHmlmo54ITlfxCjDOszB7SIJMDJXukcurdY/o+7g
	tTSNu0VVfX+y1MLjebclkX0RnJGcBZPR/FtFgw3rw29GRJo/dlEiCQiJk94pmhfw
	5bFwx+tzghQf3n88LvKIydYGpGoYi0lwPyr7TTZp+NkukretNSgo76HvVeUBuKXn
	cUunA9RJPfElg7fi1WTJDGfGP4Muhbf96Fklb9mAHtT4KPpN6pHVx3WL3zdovxof
	Y9NzRO0dqmEF9rq9oEWE4Rg24Fz4fTccmyQ==
X-ME-Sender: <xms:xGkaaC7qRe2YreoG2zQ8mqhwVqzpdra7fXfQaLBcu9O9cG-EoxUJ8Q>
    <xme:xGkaaL4liOUfmdd4b-kK7JSXOwtU8-VpVh_EBMq-FxyWSw1l6ZhsPmN4ZtM_5L1Z5
    YMoqCmI9cdmPXC9JQ>
X-ME-Received: <xmr:xGkaaBceaZMtX7qT2PKxesD_Z13Kwc69UYR2wMuNOKJhsfYfdJ__lHgicFYjlCnY3nCEpi8ogClMV1VZiYp61Nk_GCuBBQmbN4jR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xGkaaPLl4Sgqtvzlu8yTIc1Cq2Kt40VN6UpAjpRhxPiZGY1gAc4Ueg>
    <xmx:xGkaaGIYInB7bKnwnMYkxADZNjMvLfySYBzLY2C0T1gZrcWZsu5h0Q>
    <xmx:xGkaaAwKq1fOmSh4JPdt-yDMCtqqAKlbDufSHFLR5Q37vAyXo2BD6Q>
    <xmx:xGkaaKKghxxVu985hGtkfXV6VfdeKjOMWtoAyqePUWOYOLqovVe2kg>
    <xmx:xWkaaLbMOC4VWqjuh6kvoUxg31UWSFAaYy2Q0oibzf0OGyYV8eE6b8zY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 15:57:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] contrib: remove "git-new-workdir"
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-10-e6d5ddd79a72@pks.im>
	(Patrick Steinhardt's message of "Tue, 06 May 2025 16:12:43 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250506-pks-contrib-spring-cleanup-v1-10-e6d5ddd79a72@pks.im>
Date: Tue, 06 May 2025 12:57:55 -0700
Message-ID: <xmqqjz6tikak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "git-new-workdir" command has been introduced to make it possible to
> have a separate working directory in a different place. The command thus
> predates git-worktree(1), which is what people use nowadays to create
> any such working directory. As such, the script doesn't really have much
> of a reason to exist nowadays anymore.

Yup.  As the original inventor of the concept, I still have one "new
workdir" I use daily, without any problems, so I think the layout it
creates (actually, it created 10 years ago) is more or less still OK
with the current binary.

But even I do not create a new one (not that I run "git worktree" to
create an equivalent all that often).  I do not have an objection
against the removal.

>  contrib/workdir/.gitattributes  |   1 -
>  contrib/workdir/git-new-workdir | 105 ----------------------------------------
>  t/meson.build                   |   1 -
>  t/t1021-rerere-in-workdir.sh    |  58 ----------------------
>  t/t3000-ls-files-others.sh      |  19 --------
>  5 files changed, 184 deletions(-)

Oops, do we have tests that depend on contrib/ stuff (other than
completion and prompt, which should have moved up long ago)?  That
changes the story a bit.

Shouldn't we do the usual WITH_BREAKING_CHANGES transition, then?
