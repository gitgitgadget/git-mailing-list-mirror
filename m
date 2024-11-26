Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D91DE3CA
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649178; cv=none; b=m/dl+paLbVWUjjf84BaQLWZ1KIGnJKhfgj7KgYgtgGAkE+1JzOyv+x0a8Is/LudZOUX1IBEqfxnsG2E1H6EIwipPD9JPC6GHZBsUhv4zjFKrGikdCWc1hQs5He+ByqtqFif3WYzsVyGmIrNjhJL5/Z1UMP91/+AC2NdAatyIo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649178; c=relaxed/simple;
	bh=T6bk0W6TcrJ7VC39XBYiupW+z4EMbn2B64o8pAi4vYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cVPFsp1gXgsQ1WgPRZ81ONLLMAF7zmLxTTZZ3gx2LhHuL5RN/9y+Vddts9okv4VNjODPU5gNpIDkSeH0aBHdsxKXyKGNOKoZ/x7V9SH7A630bXEnG5hRS25x3WHxbGL6AdFJN/NFNHo3buDuFonleAChyCLikAcw9t8zcYvvlp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s94Ix4YU; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s94Ix4YU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 492B011401E0;
	Tue, 26 Nov 2024 14:26:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 26 Nov 2024 14:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732649175; x=1732735575; bh=5oPXVr0qQ8D5EPJbGlmyR7RZJXsTTswpZOz
	qSAfGWOQ=; b=s94Ix4YUkdPTTYcDHJd3Enb8pN0O3YrCK1CxCYB21S29OUh16WD
	VaV0s3Sm0YF+goG/p6qT6Am7e8SDS+cAiCMoKCaWroLailFgcbO3oQ3uRIcXUndN
	HeBl263o/hmW9hbtxWRJlDqzie5TS9ie0Clg7rJCk9O5GFg4o5whUg24ekl85WwU
	zbywXka2n6OTjjBFA36i2CC16kOZadp1aCWPt7TpTdCVJo7NG++QQdkdrKjQSnJt
	Juaxtx5hp2oiCC8vzvasRCL4wBq7HUapyf18lAvn0fN1etehEnXkyoEq1pftS6h8
	jwLgRePXply82VPaTw+nxAIsKr/ZfQjJMLQ==
X-ME-Sender: <xms:1iBGZ1mDPbKYWPpoa_txicO_698SzzptCi3E1IvmmGlR8MDekmQ4dg>
    <xme:1iBGZw3_NLRC6SHTEq702rJq07CWAAFz1h__u9RASyKw0hIxy54Vfz0NMsPoRqjHW
    hH0IAqxN9FxWgppsQ>
X-ME-Received: <xmr:1iBGZ7qeErXn_4MOhhbF1rj_7KFowwWMcfmVQRdxf21nKDVYETTbKmk5PAlDmDiiuUMNe32W3kOUU8kB_uBIiHdsqqE8pqk7a-SyHJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirg
    hluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:1iBGZ1kd5LdzWGZgrDOz9yOxwRp6omRTI8uFMcNvc8WP95jj5sx6Lg>
    <xmx:1iBGZz05zrZ3mkdqE79FN_luGeIyOvNtx8WBkZ44w8Tb9wGO2Yp1PQ>
    <xmx:1iBGZ0vJXUi_WBPs51Wq6db7fYwrE5KyxVE_p_vjLFo3aetjwMYy8A>
    <xmx:1iBGZ3WoiSAJwaVKfojtbq-4I_vlB6hlVwNaCDScfTyrxqWuYBh6_Q>
    <xmx:1yBGZz9fkWe8pRuSS9q0lZT9Y38bDs8RXbUps0yfWUj-w2lT1ZHcXh5S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 14:26:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  shejialuo@gmail.com
Subject: Re: [PATCH] builtin: pass repository to sub commands
In-Reply-To: <Z0WNKV5prRE2Hupw@pks.im> (Patrick Steinhardt's message of "Tue,
	26 Nov 2024 09:56:09 +0100")
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
	<Z0WNKV5prRE2Hupw@pks.im>
Date: Wed, 27 Nov 2024 04:26:12 +0900
Message-ID: <xmqq34jdyey3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So if the code were refactored to instead accept an arbitrary `void *`
> pointer, callers could provide a custom structure and pass that along to
> its subcommands. In many cases we may end up just passing the repo
> directly, but I'm sure there are others where this direction would buy
> us additional flexibility and allow us to get rid of even more global
> state.

I am of two minds.  Certainly for OPT_SUBCOMMAND macro to be able to
work with arbitrary types that are specific to each git subcommand,
we'd need "void *" plus casting on the receiving end.  But it loses
type safety.

I personally think (but not so strongly) that we should add a repo
to parse_opt_subcommand_fn(), if this exercise is about giving
consistent access to the repository object universally across
subsubcommands.

If we want flexibility on top, we can either add another "void *"
for it after we are done with adding the repository, or we may even
be able to make the parse_opt_subcommand_fn() a varargs.

