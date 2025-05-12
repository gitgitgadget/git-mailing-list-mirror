Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9B25A2B7
	for <git@vger.kernel.org>; Mon, 12 May 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057335; cv=none; b=rO9Cw4SoDHButbsjoRtqffNzFmniheRzAHqmvb4deomnj+Cb+sTxJxE/RXxxZVqnvNuTnefV4+Vp8ITzsPkcykNxl2zKPWc3DQWhfqfVtyNGFxaD5yTH5O1t3Vc2o0U7JkZwu1nNrlAk43P7ktqgPNqFgU9KR2rT4LhCd8rBM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057335; c=relaxed/simple;
	bh=fK82MvLWo8yP9WlFNIgFgYol8LxLax8Yseq/i2PWy6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7hfCCYLBEIPKlAfCVb/JVkW5y52FHKCQi6wntT2ejpbYC+NFZMSepI3F2qyQVoWPKEH4CILjc9msAXbke4TZ7rFCbo9j0aIwnSNQeoBR+194OAfcves8/fXNy0RYmPO6bFLsO2j9oPinyTWaQwJYxM7HIHOvxjYMhPB+Y2h5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LUW4cxuY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WbAYuHnH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LUW4cxuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WbAYuHnH"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 464CC25400A3;
	Mon, 12 May 2025 09:42:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 12 May 2025 09:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747057330; x=1747143730; bh=MyIAZGJrva
	rsNPeWKnoywh5KHlJpkydEBfdKL9wI6Us=; b=LUW4cxuYU7qZZqhgHHUtpxny9A
	qiiOW97limeHp2LRlL+nsJ60mQDSyFQa5ECI61wrYciEZ3D4COSn2U0HuNh6nIK8
	J/LddzSPdJUQzvGdLS8IvvXp6ByapPiIZidSxrL5VLZmqjJaFsFJ51RxkxYtbkQb
	QPjuabaKKdW7Ohd8ddObtIVawBg/vLi8JIYIwoHtWOMJW6vzEJa+NjrMvzFcNTpq
	C+GTY4odhyRZWLhLQurizfi7HQ7orPJaKp3wDAlU4h13fBoEDPSOZEMw+wDCQh+f
	aLkB1zRCuygYhfM2eT89o91pcmpgHKhZMmj5yk8XhUAUDnnqZhYD1bg74NbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747057330; x=1747143730; bh=MyIAZGJrvarsNPeWKnoywh5KHlJpkydEBfd
	KL9wI6Us=; b=WbAYuHnHM+LZQHlVeIuZVtBju0GkX6Da9w0CqJ+KVPgqMtHxXnY
	H1BpCzsg1dMr27ArgBMVKU8Tm50W3HIPPSx6rIieqfHFbhc9IEGFludYJiIQ63cT
	cko6rljLblbi8wzHrlLNCDuC2NCN+3I5LU6fzpz1OganosiLVdEzLday6K/bdoR5
	jxcYKw/E4TLRPl7UV5oxGUVtc8Mmres1mZmNV53kyVyvwHQLb1kkB+i6T8zzhoKb
	Rr8yxE4pdOr/Wj6rWKh3J+jyE7GXyfx/+L9mQ4jULk/bGKp0eVSk1UGSPTV/lBfQ
	DjW2pRymsqhocIrQajmUJKMbHEQ6Of1Rvsg==
X-ME-Sender: <xms:sfohaDPox--cUDBsgkC2qCBVi0ykHSiHdpQkaAhYao3bseO08-Fthg>
    <xme:sfohaN_LtUNcIgbUnNRJAAskA2TX99wrNeynPGBaJ1U2mWv_b5DK7_zCzaQpwl14C
    7QlTh9uhEd4d9uVUg>
X-ME-Received: <xmr:sfohaCSAhnR4w-Gf_Fj6-YTA2knkXF8KThSl2pjDAedlkyoGIOfgPp5dtpJdoyKImcqKsqXgvR-JmGn08CVdQ6_irLh9YNuQF5mybpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlvghonhhmihgthhgrlhgrkheisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sfohaHtTeBK3w-h5uUYSKC0NL5LXRdvKiMbnGLaPFXY9fBO8mWDPEQ>
    <xmx:sfohaLfR49M6q7KUL9sXFyFbFBMMseJ-6GwvLhQkYRY3nWiv3qvVCw>
    <xmx:sfohaD1RBW67I3uNW6zFoY3_CBKD6E45T5mK7iORhDQi_1FFAWagIA>
    <xmx:sfohaH_2Gdzo4S4e05qeZf9mYXkp8D7IYvFlL0iNQfoEsBi6ahmKZg>
    <xmx:svohaEqXVhC7pXizXnVuimdlfoPNt4nIwJXfPax46eFvxqmbT7AWs2b_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 09:42:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH v2 1/4] test: refactor to use "test_grep"
In-Reply-To: <4f92a1b4c24a6942fc55d305865bb55833d13c45.1746884789.git.gitgitgadget@gmail.com>
	(Leon Michalak via GitGitGadget's message of "Sat, 10 May 2025
	13:46:26 +0000")
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<4f92a1b4c24a6942fc55d305865bb55833d13c45.1746884789.git.gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 06:42:08 -0700
Message-ID: <xmqqo6vyvtcf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Leon Michalak <leonmichalak6@gmail.com>
>
> Refactor to use the modern "test_grep" test utility instead of regular
> "grep" which provides better debug information if tests fail.
>
> This is a prerequisite to the commits that follow which add to both test
> files.
>
> Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
> ---

These mostly look sensible, but I would title & phrase the commit
description to 'use "test_grep"', not 'refactor to &'.  It's shorter
and more direct ;-)

Thanks.
