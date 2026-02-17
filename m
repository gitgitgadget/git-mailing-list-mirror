Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C878F3E
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 05:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771305674; cv=none; b=DP4NmyrRuA1I96mtAkD2NoaLmCgNfvidEWP9ojRrEXYM8D2+qhTLgAhZMfysDeD37BGA+mG4VfmBPwC0T9vxCPCq0QUOUgWh7TNVxcc7Il1s8tZfGKTB6FLv8sfz/sIEvWYS7fmAnifg7LNu6Un0wYoHCBnnuhmasvefik2hsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771305674; c=relaxed/simple;
	bh=eKq9fIatXlwR+jXs1zfdlMXLNu4m2b0/32am7pHiQSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgmC65iXRxojfI5olKEgjfzXa/xS+O67/gH5J/jwjfAn16u/55Lq2JLJnTjX3Y4UQ50VReQI7a4qUFkVNhTPONucZV2o2RF17DcnLgrJleffFOKkLYiOAhyVM12GGjvoo9+jgoOif5Wfw+FqkLU3/58zLfQa7d3dkWfDeiTrHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LnN8YD92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r6o5/c+k; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LnN8YD92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r6o5/c+k"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4472B1D00141;
	Tue, 17 Feb 2026 00:21:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 00:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771305671; x=1771392071; bh=lWZb3A2e7D
	N/+f+CZQEjPksBh9vLFPBZDABanJNgACU=; b=LnN8YD92KinqrmtqDGMowbPbnP
	gL1+5ccVzk0nfYc61TzsVISxYV0LAIEzosym8ZEb5XjXrEMIqBAWx9NoPShNaUEo
	57bOEh+49sHrqeouS4Eeyjbggq+KBvgzTTMG7OQWMZLTikVBPn/XdPdjnWd2jvnw
	DOKiLT8wwAYRWOOBQs7/80FHC1d4hN/q+uj6XwZw43whhmiq9VXBi0Jla5oRns7d
	Ad8hkGjB9tEYvq9dZpgDNupBbgh0WjPdAPfQTGI2M04dNV2mFIGlB0VACazqLx/v
	deBhzTz8ESbMH2R0GUIQMVwdO3oY7PfqWQ6dz+VpdeXaGj/2ddLgmKYYY9aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771305671; x=1771392071; bh=lWZb3A2e7DN/+f+CZQEjPksBh9vLFPBZDAB
	anJNgACU=; b=r6o5/c+kYj8RGNKhf0skJJ/YMfX1GyK6TTdBCTUS+6dQGUFr2Q6
	TWeRuGsSC61gvNLFWzA6jayYt2vpxhpJqQa1P9Qjl4syExnx6LPZPyPfopwdF3oU
	wC3BAGjpXJ7sUV/epawKaVMtVJm2JoJMJdIcAA6Byyyv5HDwUq8+POF3wCRA8h+U
	tUiABoW32XpMm/gxRgm+zSXr6NmsPuNeHWt/By+8KVzkrguV4NhkkCjU5w3sbirG
	w4LTnuQRmUzXZ+X+G83Z05U5J2APwPgR0PNUY+fGaaAqhe1mpcXu7hSTFQH0Dxd3
	e6ZtNUIj5PgYesnflMo42YdfcowCxmbJJ6w==
X-ME-Sender: <xms:xvqTadAXCPmBUSdSpuYrEgbyC0IIshbiVf6Xu2c046NtMTSV9y7rOw>
    <xme:xvqTafNECJm0OiQD2-mTtkMRLMPkXEUxz_qH_vbaxNSWpen0aC6aO2Yues07MZWDz
    0PpGoYRo19Pi_ZFNVc4OcmCF5gqM5-90RWXkfdGGCsc6GbBuRppiA>
X-ME-Received: <xmr:xvqTaSYIPylcWXtWfJNv5SSqr80Za_yQT1sHDkn_4Ao6GpvvtkG6BQQYfgHMk2DO8oDAcefQZqu_aQcxh_nN-EsVoQ9PEVsexQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehshhhrvgihrghnshhhphgrlhhifigrlhgtmhhsmhhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:x_qTaesLHoxDhN9NCHTtHSHAIO_BWEOQ4-TtN7vmGAXL55VQr5PAzw>
    <xmx:x_qTaUMEmtRDiAytwp1guXCw8ar8SlbSjf7WLWEfYs3Tb4wGiOEgbQ>
    <xmx:x_qTaV4hXHxaz0fvy7yLDT5mrPurTvEzrPqcQoUEhopmp45V-Neu_w>
    <xmx:x_qTaaQf5Q1nBHsYkfCZs22f0oKNcJ-Y0Nk4mNn3g2FafXnc9uGnPQ>
    <xmx:x_qTaaMkFuEbzd4fZ1P4Q-nG2bS0eVURJ_FUge7ae-cDm57I_CerC8Fl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 00:21:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
  git@vger.kernel.org,  sunshine@sunshineco.com,  karthik.188@gmail.com
Subject: Re: [RFC][PATCH 2/2] worktree: stop passing NULL as primary worktree
In-Reply-To: <66b0f03a-36ab-4305-814e-6d964f5d33c4@gmail.com> (Phillip Wood's
	message of "Mon, 16 Feb 2026 16:18:58 +0000")
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
	<20260215090815.46544-1-shreyanshpaliwalcmsmn@gmail.com>
	<66b0f03a-36ab-4305-814e-6d964f5d33c4@gmail.com>
Date: Mon, 16 Feb 2026 21:21:09 -0800
Message-ID: <xmqqldgsdjy2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> It might be worth adding the current worktree (or probably the worktree 
> that the struct repository refers to) to struct repository in the future 
> but I think that is outside the scope of cleaning up wt-status.c

Thanks for being conservative.  I would agree that we would need
further thought before making such a change, and if we do not need
it if we have "give me the current worktree struct" call to clean up
the wt-status.c where passing NULL to indicate the "current" is
problematic.
