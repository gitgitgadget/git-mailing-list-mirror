Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3162253A0
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792512; cv=none; b=taAkXbiEyGU1rKvQEjgNTrsqCJxSIeyhJPRkfBjjIxlvaYmH2DR67+Q+C0nOwqwqOuQ7fWR+tZP7I9zv8h4ofzTJPOZ2Ivk5Zy/Pa8O+Qi9VU93PPqYhVnzlsyJs6i8pMDZtUZ3vRKx1DvD6zIHmE25O20hU1yMV3l0Tg4ZMuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792512; c=relaxed/simple;
	bh=xOCnuXiTHtibZl0ESZvHTsJhIHQN+ErAGtY+ijhGZDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R1UAyDpjHc4loyQKoZrRJJew/8n3IJ5W3nq6Oo+kTBmYjD2abB3Jeu+bZhQf40Gc2fAmeuL/2rE8loZGTcxRGDvWW+CPoOEZ7Q96ydbGglXI6WrP47iwuoizvfuOqaWGrQrMHTvy3CqcLR+QU+dEpd12fZ1Ba59h+TmhGGjX9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IdDVgZ13; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pUcdCo2T; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IdDVgZ13";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pUcdCo2T"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CCC47A002D;
	Fri, 30 Jan 2026 12:01:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 30 Jan 2026 12:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769792510; x=1769878910; bh=+P3gXhVgBa
	QXbODStuSVm2IxSRRyaIGMpcRiP57gg2E=; b=IdDVgZ13iC4Ph6FvH4gsRJ92ly
	YeeR4wuZfS5NK1Uh/sy23Mzt5LpafsnrQBrpnjskyeIIqVEYUJkRaqsawuJkWjnH
	WvG8K02VVzPclRGO/gFLMWScTzl1sbdCy+vtaR4EN8czlbqOiKXe5UQxlT0U6IOp
	9xj+mAX8cEufF/c3tdQhgYQWXqbE7Wqs7PAIttiyevKGd9MpqVY1pDnWzOU0510X
	q0K/iEsIj1PkBet98NvvsrN2khiLAnpiIwFuDjBmByzKlCIxY/tfsyBT8DBOpCUs
	qKmEWDVf7rMsqmqGrjhpV57J4di9hzfDAKihGz7OOEXOWtUjh5gvrcIbX4bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769792510; x=1769878910; bh=+P3gXhVgBaQXbODStuSVm2IxSRRyaIGMpcR
	iP57gg2E=; b=pUcdCo2TSEttgpPCb3h7IMg1aV8rdgDMQNAKhy3xmwA9vWfHP/n
	XOwDMIWPTfzrd1ApdraF8l37v84l0BK7ChuZBbGBT2rCy//Pa++o7DdeqKnf2Ra4
	gJD6yKbiFNr+g4A9G/PZml+p+DXeDCsZNSvWgJZgfiDqICaU1p9PoqqWmHf6gQSJ
	fguVD0bTnfC92MMQei1HnM1h87q3URe4SH3TYuof7VrMS+LLRJbXFbJylQANic0j
	fDvaFBtbwCjxWrzvb+pQ1KK3GtN/pH25lI6BrmejwnULodh2yV1tqWpkhvUHreVf
	d11pvg6HvZs9ljXeL9bTYkcZrhzCWjlHWpA==
X-ME-Sender: <xms:_eN8abcXul9SYmHnumepQcr5bINaNj7Ooox1A6pIYXtqWjdJ2ijjsw>
    <xme:_eN8aYFpa50e5nfbdAOsiS-n4decB6SS1e2N6z1URA-f-mi7eVBxPczrPhK_X_MOs
    _sJQ8dXa_Vt_zGInWBNAsU5yATdtfs3JZ42Qk2iEXVOTROZ8jUA7w>
X-ME-Received: <xmr:_eN8ac1khEvGKDQmeSJS1D1kNqw-WKduUDYvlkIwYvuu5RUvI-ewi6QPKox_5kO6Yn5uDoebuf7pw6kz1-G8GYIsQAAyLlrItamRDi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehshhhrvg
    ihrghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_eN8aYlDjFK8M-AhjmcNhgA95nagATeuctE3bRiKCx6bqcrJEKakDw>
    <xmx:_eN8aU-Ux29OoSQJ-gdSGaz1dCnMfqlmJfuWt0lY2QQQUzO9jbpk4A>
    <xmx:_eN8aVp5CSY60Pm80ds4Y31LS5GTRzE8Pk8pcqZxvPVNCfBB81HDUQ>
    <xmx:_eN8aVnPQPbKeKW0hXSZ7tC-pklajqo13CIlW9J09uhU78zn67rPxA>
    <xmx:_uN8aRXyTbSE4IWcDr3gIe9CeErUfe1BRRvNfmpT8F93BnxrCfVuZPS_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 12:01:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
  git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH] show-index: warn when falling back to SHA-1 outside a
 repository
In-Reply-To: <aXy0bife-Ubi9gnn@pks.im> (Patrick Steinhardt's message of "Fri,
	30 Jan 2026 14:40:15 +0100")
References: <aXvpSPpfvulKu57P@fruit.crustytoothpaste.net>
	<20260130090525.254665-1-shreyanshpaliwalcmsmn@gmail.com>
	<aXy0bife-Ubi9gnn@pks.im>
Date: Fri, 30 Jan 2026 09:01:48 -0800
Message-ID: <xmqqms1v6nlv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I also wonder whether "--quiet" might be a bit _too_ generic in this
> context. I would rather want to use this flag for something that you
> actually have a good reason to silence, instead of only for a warning.
>
> In theory, the user already has the ability to silence the warning: they
> can simply pass "--object-format=sha256". If you think that's not enough
> I'd buid on top of our `advice_if_enabled()` infra, so that the warning
> can be globally disabled by setting a config option.

I like the "use --object-format then you would never see this
warning" very much.  It is possible that we may want to squelch
any and all warning and error messages, not limited to this one,
in which case it is an option to add "--quiet" to the command, but I
somehow feel that it is outside the topic of this change.

Thanks.
