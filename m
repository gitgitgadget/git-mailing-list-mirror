Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D271A682F
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757868; cv=none; b=gqdVvosVHCmEEuVSo/VgRnHJuL7bzN6WWsqTxisiX8/6DlJWtVilZ4WpGAt9sxnuhDvqUzTunk+YZGdIDHNP4nK7dUqmTfNXfdr3iJBRM2yKFZpBYf1M2vzC4WJUO9GS+YsmrBthJoqlBjRpR4Fr8WPlFTFxAAbL1k4Ds/+eOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757868; c=relaxed/simple;
	bh=3scWhSdYDT+xmG3GpJ3cQUTjDYm2tzNPSjvSOBhEtPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMaPKhK+g2CJDNw4J+SJjydQ5KvtKP08SORVXGzZfyOcivhIJXa1VxyirV/c04tIaJn4fBKGuwhnkVIBE0X473iOUrF64sDaVKMbjQbPASCQ99LchcBrSmg8RO/MbCAgz/kaU2uxPdH/A3zVL/A6h0c48I4xvFAIwdRDCLpowUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pKl49Bg2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1/Khqfv; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pKl49Bg2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1/Khqfv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1A4051D0021D;
	Thu,  9 Apr 2026 14:04:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 14:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775757864; x=1775844264; bh=V9L9D/QWBj
	bSDdM7LPBlKbrL0/aKNbgAMLluaLpaLlA=; b=pKl49Bg2GIVJtidgBLQzdM63g8
	4tbhjR8b65l/xnkM6avyRxrtwvzBklcq5/P7JPPt1RsVwq4uiYlMhfi2rsqkOLBl
	6fYDS9pJ4TQkMu9BEQ5x4tFWKWEXxtnuuYA3MKMpMOKZr7sB5dJqSbO8gXuFgRWx
	ab0rDy2/JjK2jGgVUxN6Xve78xUbO6Je/Ae8HcUHqWFnBEeYZiwUuUU40vt+rHGB
	iMYK3+E50UPoDjsBFvRs9QkXIfj+xAMUaf86EghUzWJadSG+RaO/UelUmjO8GyOG
	Jz1IB7mU0qc5tBzeognhXFQYwAT1YwKvi4/SsBofqDSwEUcjVU89+FF4nXlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775757864; x=1775844264; bh=V9L9D/QWBjbSDdM7LPBlKbrL0/aKNbgAMLl
	uaLpaLlA=; b=i1/KhqfvU+/fvFFjcCEvuM1PcaxYJ6eXbd61vhkTrB7IDzDvZl2
	PYbUqqkzrI8gaaqHH4ze0lV6JxDqoCn3TO6uQFImqoLnmyclh7vlEl7Ldem/Xe5P
	8Sp7HAMdyfpa9TwLyDt88OOUkylDTWSX8cTM4Q88H1sHHLQgbhGJgO7sXBs6G7iv
	+zKA66o6UWa99ZkURpOxvK1CjV6Gn97KX3rIlJe3QClATnbY+Z7/cbn7PmK7tHQG
	txWSM2K3Yw4d4oeHD+SpMEp7QGVQ2vtJxSaPuna2O94QjfNGwlsPQ1J8Kp9Isf5m
	FGX+PBj1dLS8j+E29cjgCov1cqAW4LBoktg==
X-ME-Sender: <xms:KOrXaT_ASGPON33xAC78_yUU8m2Nu0dpXWCrP-AxWxRz5HpE9fuKdw>
    <xme:KOrXaTa2N3YCtfEmZSLRLVg4oaovsTvCUba8E5DFufhG_FiLHG3HB8IuEaJtgWGuW
    9p8r95fgXYVsXmOQxM08kXmkZ_2clDv2rNaS4fURmfqaiCzohMJ6w>
X-ME-Received: <xmr:KOrXaa1z-Hn8LmtDvSNipY0UpKzTDLbCUhJRANJ9HQ8QnPITaHnY6C9NdXvuF7yEjvTQMX1q-vJqAEzMxSobHyPn5eyvUhfvzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprhgtphhtthhopehgihhthhhusges
    phgruhhlihhsrghgvggvkhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:KOrXaWYeILRc2iKoEwDZ-WpKM-Of0gso3q-48Uie9h3vGqJByBK1tA>
    <xmx:KOrXaaJkem1fHtvPIBDjl_NBkQh3tqGp_m38Joa8CIa5W9Kzkm7OLA>
    <xmx:KOrXadGDDmS2_KFK_Q6JEabq7lonUottdoiBvOT3whcj2jFhmBQYQg>
    <xmx:KOrXaZtcUHUUQai4KjIn3iNkGT2ABoYsyoq2qkij63m522cUlPUNgg>
    <xmx:KOrXaRFQZf0Ed95KOSG_4N_ag-LWNC-talz8-GwUeOnr0XtStSZLx-Ll>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 14:04:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <paul@paultarjan.com>,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v14 00/13] fsmonitor: implement filesystem change
 listener for Linux
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com> (Paul
	Tarjan via GitGitGadget's message of "Thu, 09 Apr 2026 04:59:22
	+0000")
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 11:04:23 -0700
Message-ID: <xmqqfr54t3h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series builds on work from https://github.com/git/git/pull/1352 by Eric
> DeCosta and https://github.com/git/git/pull/1667 by Marziyeh Esipreh,
> updated to work with the current codebase and address all review feedback.
>
> Changes since v13:
>
>  * Also disable GIT_TEST_SPLIT_INDEX in t9211 per Junio's feedback (every
>    test does scalar clone)

Thanks.  The range-diff since the last iteration looks good.

Will queue.
