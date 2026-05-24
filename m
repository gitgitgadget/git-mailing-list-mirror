Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3427A12F
	for <git@vger.kernel.org>; Sun, 24 May 2026 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624543; cv=none; b=e+MaoYECdTFTfu/5yli8+r4/McXzZXQbyL9VnbomJNfGxgXjMlmfDA0OL1HdR17JHqqlx8h5IfqXsYFcxLYwNu0Z0NNJgCnzmFz9qQvTXjq2W6V7Snm82QVTExEri0z8akMdgIGIV7HK3yTPey4CLUaSYC5dAcdwHiR3YQx1QuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624543; c=relaxed/simple;
	bh=YPKxrD7HDWdtAc4A8FITVEcLGzF0A3nspZ/+TFXqAiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qeW5s7dHKWQekOto0yE0Snk+mQ9x9muU08p2WOObrxXSTDX/fcn+6tUIednW1KgdJIqnWD+J/bazS+H4YH9GSq2p2cIgJJDWlBflO7jhWUObk2E7HakwCc0IWfkX15Li5CJDW8U6U7sUwYyoulbyylRVbJ3cn3bK3pslw4KXti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EiD4+jSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLc8y7So; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EiD4+jSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLc8y7So"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 00D5A1D0002E;
	Sun, 24 May 2026 08:08:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 24 May 2026 08:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779624539; x=1779710939; bh=lOfYfx6UKY
	UNkbSjY8pNg5pjuUUkd1HbdEIOM5a0ia8=; b=EiD4+jSdapmc4lmPpFh8t/tndF
	gctRSKAVaaoqIAIUVC9rHz0ayrBBJVnfSCbtGbWFgFJdFQNpPvlUCDTfPZlDMEaP
	EmZUacXnmjva8sr3ViZ2UHRqVABu2CnGYuc76EWy41+r/yka00Yk5JptU37aPJua
	aWlRIFp9RcO/NVM14C9dzzt7shizx1Yks7mZCMhI2x9plKN6EIQPiPuNVJvr74Gi
	IPy/iIuoE6XYdgTEC5cBnal39V3VZxOXHBEUn71eP4AnMA1P0k7Aq8o2z8GEIAp7
	aAZCxaHU5pQ8eMvMMjDFjn9loko0hNgVm5lYOXu/zRavaC8JDfbYH4C0PjVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779624539; x=1779710939; bh=lOfYfx6UKYUNkbSjY8pNg5pjuUUkd1HbdEI
	OM5a0ia8=; b=gLc8y7SoOfO5yYih/CVvEnVWlzqPpT5AKJGJ/a9W3ZwbGJl82ii
	nbWSjjmaZDAFD8WSqvXhYCfIk5udZ9ColeAPKFvtX0hBOVfzTPHeyb1XxxCc7gLT
	w61gh8ahWvjqIRBwURnraI7MFPX/9AFUJQvSLi45BmimQipUusV7tLhdqb8IG6vu
	jozAGXYUVzUjc4m16NMSaa8TuHaXNvrro3csh9om8hEsfGshSUGvk1Qq9UxJev4s
	CrlTrgR8nDXU6K6ng3xMLycDsqTUqbNk+kXkA8QzE5bpS/ME5zEXq+3TomDNzvdX
	lPnLttZRDq0zRidBV+3J7pgUIlN9Pk3q/iw==
X-ME-Sender: <xms:W-oSatkvgKHpyQoZF1P9hdK744igNEus-YBh_NJPEIP2fvsUSsyVfw>
    <xme:W-oSav0VzJuql9nNl1bGdB1isKkXL6g0JQh4YXYXxhoclRvsRychPOz93lWJWJxFU
    JkdCGtHJuDnzPYZRqZr8jpo0xJxLwmHXVRhzOnuPhga8NMI2ZGEqA>
X-ME-Received: <xmr:W-oSaoq4zMpavqekoci6P82gYAwy_TKKB-hRSBc_sGaNrHoCGhmhOeeSHkt96KfMkS3ZAYJZRn38qDth23bRWlLr58qKTfcB_zU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peiirghkrghrihihrghhrghlihdutddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:W-oSasecTusLTIiL2lTWoLx-tY1CBT9Yb7_qjNN6Fmsb3eaujURxtA>
    <xmx:W-oSanrACJixCC8fZbg-mtfIhCKw5XuZzlGkmQRP3ps9AC-Eh6PYew>
    <xmx:W-oSatHdtSM2el0GHiAQnGUseD3DYaYoLxQK0tx7ICyxtAVZqbpYkA>
    <xmx:W-oSantLUNwcVcCaQGRKzVMpKJWidC59dUF3zuwm6APEMr_cWJJImQ>
    <xmx:W-oSakIvjvx8zt576-Nbb5Zk4jLCvlzMoOA74oXK2dDKEA9ErH-E9F2U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 08:08:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Zakariyah Ali <zakariyahali100@gmail.com>
Subject: Re: [PATCH] completion: hide dotfiles for selected path completion
In-Reply-To: <pull.2311.git.git.1779590184752.gitgitgadget@gmail.com>
	(Zakariyah Ali via GitGitGadget's message of "Sun, 24 May 2026
	02:36:24 +0000")
References: <pull.2311.git.git.1779590184752.gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 21:08:58 +0900
Message-ID: <xmqq8q99huw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Zakariyah Ali <zakariyahali100@gmail.com>
>
> Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
> ---
>     completion: hide dotfiles for selected path completion
>     
>     The completion helper for index paths uses git ls-files rather than
>     shell filename completion. As a result, leading-dot paths such as a
>     tracked .gitignore were offered even when the user had not started the
>     path with ..

Writing 'path with ".".' would have been easieer to grok.

>     Hide leading-dot path components for git rm, git mv, and git ls-files
>     when completing an empty path component. Explicit dot completion is
>     still preserved, so git rm . can still complete .gitignore.

I am not sure why this is a good idea.  If we said "git rm g<TAB>
and offered ".gitignore" as a candidate, it may be annoying, but
tracked (or untracked for that matter) ".gitignore" and "gitfoo"
should be treated the same way by "git rm <TAB>" no?

>     This removes the existing TODO expectations in t/t9902-completion.sh and
>     adds coverage for explicit dot completion.

In any case, all of the above should be in the proposed log message,
not below the three-dash line.
