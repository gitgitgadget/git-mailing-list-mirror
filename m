Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9A1EB5E9
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307807; cv=none; b=XRGlnzJVsfJrTyosOzzqnSlQhrPEeSMo5SNO+Fji7BLzXJfkZVjlm7i+ss0uv2GsDHIJDRZu0464pp6fiXcvfjx7pUXQTp62mRhdOqjM+wBGemdEbaLtnsM4AhRptMz8zwgh2oTZB8dUGE2NhBhfidN1wlWDFNxoOYDVT9TahnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307807; c=relaxed/simple;
	bh=UpXz4K1ZZgfJF3RGiAXbiqCedlnuOpLKmpBMQwPrgzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC9ee37QWyKgTGGfazpL0O1ZgcAqm5eqHHCRRo60QATZVsZe8QVlNpRgZNFte93FC4mq6xkqQhGsRuYDomAQF4K6Jl+ScOUsvs9lGbF6A5U38J4aEEgrl854dceMx/HDvfH8KV/zPX9ZPnvaKk4jfu+iRNezkX66xVeapJOIl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RWN/N6pJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5JPV8iH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RWN/N6pJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5JPV8iH"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FD34254020B;
	Tue, 22 Apr 2025 03:43:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 22 Apr 2025 03:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745307804; x=1745394204; bh=ryzl2OOEhU
	qnTECP19svq6okXcIByO3DEfMUBV5FQr8=; b=RWN/N6pJSl+ruAZ6AabPqrFmxd
	ErpmUsv8KWaIBnM/ka3gsmrTx99ca8+iGilmIZXfwil3v6ZZc1FvDv+z8MZYDdmG
	E6/MfCw1Z4OUCRH1F8/4k3ytahUFfEZSxJjxFeBjgfbhlRl2pq4Ur6Rj9uYyYemR
	jelL2GTXKUMnytTCT5HLbr7I+zCFtQXbfpp6va0A0VCyPRcm8SZEUFrAryttQEHG
	c7aevzOO56m0B0n/sADK8lVtf8lss6KFhAsTD96CO3GdzNNSxcjKMRa6yB9lH+et
	FTdzMcO2kovKOwuMnefNTKzjZxh3ZUVvBdcH/LD/ahCRtubiPZpHEyoogKRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745307804; x=1745394204; bh=ryzl2OOEhUqnTECP19svq6okXcIByO3DEfM
	UBV5FQr8=; b=O5JPV8iHD9cpBdyRYVJESNsdX94kSMy2j9AwoqzxRnG0+sSsCz5
	yUcE/GfzHuE0gy9L1gPwgTqpsjNCO3NE3aVGQa+et/kDD+8oiiF7NfssJEkN/mjj
	t9Alh9+Nz5PSUkEKNOULw89rROi8nl710OngMSQU67pwN6CNfTY+sZ72fOfOsK3D
	bMt5wlu3FnO5RZT0sfBFdO65zjdN20SrGxxfP8Qgrsg3VrF6EnkdWM30oFgjOj8u
	j1ApmBAyTMC6X3enG8kHSKCrHvJLsWjjt3gyiT/9g/wipnUBK4T1Ps0iewP+BKRk
	TNRynH7eFSXFTh2uJYjaSJGMKKWd1LGAlQw==
X-ME-Sender: <xms:nEgHaFMI-EnHCViZeRTODZBc2XXreYpvNPysnbhwYpAxR55HjFfdPw>
    <xme:nEgHaH85kESLw73PJr0hPYWTGuKbbzCxwxRGtRRSuPi9WfJAtTfvtqGYv0PqDpeW0
    q6dPnrSYSka5ue0Hg>
X-ME-Received: <xmr:nEgHaETthN-7BPZsmOlU5ySjPMa5hpphWmyydRLwl1IcBwx5evCvC_n-m9iRpY6R0iXv-AMpqr1gDbDC7VILhjuB7I64ubSX9sOt8wiZ5R0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:nEgHaBuKV5CRKPJf4_ayMBOIuuiGUdlG0Kq3KtaBilFuniMnhp9_ow>
    <xmx:nEgHaNfTgRK7fa_lbcpXI9Ol_5QAo7gthhMMyTtauQ80POIo2-BMcw>
    <xmx:nEgHaN34tMJD00kE4rQvBSB-oNmzYkOMQPZlDMQmXH8nhDdR6RKszw>
    <xmx:nEgHaJ8V_gJncCqCqHJ4UIZH4NJ6kwaiMppXqhSdMm0Ygnvsib70Yw>
    <xmx:nEgHaFIiVCQRX9UvVb2EPUwfQ-oe7wB8EpuSARlXHQWSZ08MlClwoZsk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:43:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2a94e58 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:43:22 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:43:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 6/6] max_tree_depth: lower it for clangarm64 on Windows
Message-ID: <aAdImbydzMUkCFqB@pks.im>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
 <6ebc3ef57fd0455fc70c4a8531c7ed094d9cdaff.1745239150.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ebc3ef57fd0455fc70c4a8531c7ed094d9cdaff.1745239150.git.gitgitgadget@gmail.com>

On Mon, Apr 21, 2025 at 12:39:10PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/environment.c b/environment.c
> index 9e4c7781be0..cc853950bb2 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -82,9 +82,21 @@ int max_allowed_tree_depth =
>  	 * the stack overflow can occur.
>  	 */
>  	512;
> +#else
> +#if defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__aarch64__)

Tiny nit, only because it puzzled me for a second: this should probably
be `#elif`.

> +	/*
> +	 * Similar to Visual C, it seems that on Windows/ARM64 the clang-based
> +	 * builds have a smaller stack space available. When running out of
> +	 * that stack space, a `STATUS_STACK_OVERFLOW` is produced. When the
> +	 * Git command was run from an MSYS2 Bash, this unfortunately results
> +	 * in an exit code 127. Let's prevent that by lowering the maximal
> +	 * tree depth; This value seems to be low enough.
> +	 */
> +	1280;
>  #else
>  	2048;
>  #endif
> +#endif

Hm. This whole construct feels rather awful, if you ask me. Instead of
papering over the issue it would be nice if we eventually fixed the root
cause, which is that we use recursion on a data structure that has an
unbounded depth in theory.

Anyway, that is clearly outside of the scope of this patch series, so
the bandaid is good enough for now.

Patrick
