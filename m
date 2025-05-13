Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC31531E8
	for <git@vger.kernel.org>; Tue, 13 May 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143267; cv=none; b=g9OvsUpr0+RJ7bG8YmPMoMg4r5jD+PjriICLGZQFWOLiNZF9swEUTWq7MqkY4nUn7r6ocfaZglEeb6Db/1BHqv1nIWpDKgUf6TCGOlJ7vdAd1XhA1aFzK4a+rPnrVBTiDgdaweEIRg26IF65RiK2Mmm4aU/fXnRukZ5gjdR4uVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143267; c=relaxed/simple;
	bh=Bpo9AXSzHAMACGyKXTVniNUR9yoRWTUx6N/yz+3VM6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mUpLK98A5XncrxNDE+wdaY7fY1GnX9HWK6Tc7fGt5+3wpT3MdUKGIBfNUWb8c4YbHWfIUrF7Ktp8O8dRLVs+NoPbfvqLqdg/01xzCZXofvoVBs44WLiTpzBXPrWG8Symw9dwoHrc7xbbPkD7fOTHhsO7WSjGVrGTtGykQRHDc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PZASQeKu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DrAcangg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PZASQeKu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DrAcangg"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67C4925400F9;
	Tue, 13 May 2025 09:34:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 13 May 2025 09:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747143264; x=1747229664; bh=tA+SweFLSz
	N+Q/4wGHKFNwCPgwBrpOvRiYLBhENdgc4=; b=PZASQeKuA5ZO+n/LeTHlWWdV6p
	LbPZq6CStqnqHqVMVWNF68l5RCbF9jbC2ajlvfpvFADFiHcequl+BXqzy88oGYRt
	WB++aTnZzjAVqdO0Z4Sql+lugbDPNgPD1EnDg2HCjkBGulGmmNFjHiHq5COjc/SR
	msMSqJV8bOcMhozwJdflYARaLe8iDa1FHLk2JCtO9hLN91WkMe3tW3wiIENyzRX9
	rGN39brMabaDyYsuSmEKqKeRO+uz0iRl2mom2co2UhCrZbg99dfLh7vraVgySaCb
	3dBQinJXCUGHAqWpo0YR8URc716VnnU8F4LfpiX1BWV4NElGtbq+86XMndRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747143264; x=1747229664; bh=tA+SweFLSzN+Q/4wGHKFNwCPgwBrpOvRiYL
	BhENdgc4=; b=DrAcangg4+lsDYTY7qWtFgqMcBbmfsIFf94T5Qqft+lAlmFkk00
	NhOofpH5s9bqfWu2m0P5HsThUVX8PZoiftq+0AhFXQSeREHbRMF1TUPc9hBDK4cw
	ZSRd9hh4Nlu2TegdEoPgx9qTY4eUp9HCdAa6I0Dq3pB4FNzKtKVCsu+tuiR6j38w
	a3G6RtIuIsq0wPsQgT6o9xnws4A+/td9sikjhKHg45DUrbvYK4Y0In4XV5CGO5zd
	XFVN7rmYVec2WSXxguv1Xr0jajTifP4hCFqLLMBtx8bBOxYebxpSZAvKPMwjoW0j
	gvvaqzznroUpZbRa+yVW8wCx/FIm5VTwdOQ==
X-ME-Sender: <xms:X0ojaOCWJ1efCzfwbp4wp1YhuArsXxEhr65Hgcgrc1kzX3PZiCLRTA>
    <xme:X0ojaIiZ3kt8mzcEftrplHMSRShT2OQgauHji05ZR9fHSEqEVcnDJC-qsButhOUcG
    7sYXMla9e_-VL3Ngw>
X-ME-Received: <xmr:X0ojaBnnd7ySLUkbuD_DwyCaad3axcJfyVRIIo8sUSXPJWiMYoY4Mb4lntxDyw2Qqh-hK9doKyY_x_X3dSxknAzAalaWUtG88UT8p9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnh
    hjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:X0ojaMxHnfZ6Szb50tKS68k65jitkt1xhWWI5xrZsXoReF_MiCmhQg>
    <xmx:X0ojaDSezKMedJ9qVUeVKiTHa1Oo052S0Q6fRu1ZGelJ799cBP_jHw>
    <xmx:X0ojaHawGAWv0jV6lRlhlgrEaqoo0EHmOySQ0AXnzPz438s_vLVMCg>
    <xmx:X0ojaMS3cs1oJWeLpVhSKOcUdsEAfH7PR3IMQiQJUldbHT0PmtID8A>
    <xmx:YEojaNXBTol0hOJ6n5kUH2ib20yD4fhxu4cp5yxIj-KkQ7bODNXP6GIL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 09:34:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v4] mailinfo: fix pointential memory leak if
 `decode_header` failed
In-Reply-To: <pull.1956.v4.git.git.1747104551204.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Tue, 13 May 2025 02:49:10
	+0000")
References: <pull.1956.v3.git.git.1747066627330.gitgitgadget@gmail.com>
	<pull.1956.v4.git.git.1747104551204.gitgitgadget@gmail.com>
Date: Tue, 13 May 2025 06:34:21 -0700
Message-ID: <xmqq4ixoiqhu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
> +static int decode_q_segment(struct strbuf *out, const struct strbuf *q_seg,
> +			    int rfc2047)
>  {
>  	const char *in = q_seg->buf;
>  	int c;
> -	struct strbuf *out = xmalloc(sizeof(struct strbuf));
> -	strbuf_init(out, q_seg->len);
> +	strbuf_grow(out, q_seg->len);

Call to grow(), while it does not hurt correctness, would not be
necessary here, but let's take this code as-is.  As the result of Q
encoding (and B encoding as well) always is longer than the decoded
result, strbuf_grow(out, q_seg->len) would always be over-allocating,
but it would not hurt too much.

> -static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
> +static int decode_b_segment(struct strbuf *out, const struct strbuf *b_seg)
>  {
>  	/* Decode in..ep, possibly in-place to ot */
>  	int c, pos = 0, acc = 0;
>  	const char *in = b_seg->buf;
> -	struct strbuf *out = xmalloc(sizeof(struct strbuf));
> -	strbuf_init(out, b_seg->len);
> +	strbuf_grow(out, b_seg->len);

Ditto.

>  	char *in, *ep, *cp;
> -	struct strbuf outbuf = STRBUF_INIT, *dec;
> +	struct strbuf outbuf = STRBUF_INIT, dec = STRBUF_INIT;
>  	struct strbuf charset_q = STRBUF_INIT, piecebuf = STRBUF_INIT;
>  	int found_error = 1; /* pessimism */

The remainder of the patch also looks good.

Thanks.
