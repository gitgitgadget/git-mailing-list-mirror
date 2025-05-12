Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFCA2566C4
	for <git@vger.kernel.org>; Mon, 12 May 2025 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037425; cv=none; b=ezQqrUOwYbJeedZxtsilT/nr78fiLxO0jJZ5UY0hMX2Dl7KZuAD6fWmCdrAeD+L78t2qkeCEpCFNNLAd8osUqSPYUTzPl+RxuHFZ/W7k6qyJiSujRG7Fq2A6IULATqi1416wS7AdByBsYnwz/18SGt4rqU3z4bzjC3n1qI+Updg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037425; c=relaxed/simple;
	bh=qOVqVZv2oY/oV6NHdGNCl7vu+Ac/j5LNVwyCA12ThhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sdd+GqcXjivq1K5mk4c3DupVNwwDEeQFcIjPOCbGR3hu+h+wJ5AFMWF64iwmv+11fYSmRIOuR4yf4O4wF8WfianziXHrawcUNhmesEJhBf1/2I29w1YYRF9g7YO8lB43nK9cdnJbfg0paXskyX+I62XLbqNU2aRJUbFHPE/7LP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gbEY2O6f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJdJuNFQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gbEY2O6f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJdJuNFQ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 500E91140095;
	Mon, 12 May 2025 04:10:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 May 2025 04:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747037420; x=1747123820; bh=xkp2h/cDEd
	bZ2aCrVa3ljCeQJ4LL0TPyDe7Sy7I1BKU=; b=gbEY2O6fsfIWjnPjliEN9XrTpp
	X6cKdNXch4ZpGFA1meG1xS9BRL1MjBb+wFMAY0rdP3VFH85uLHpcvItyM1fPfq64
	zt7G6kl/BqamJYeflwt1TII6NGaFvZKgotRNT/zKM7toh/ZNDVXzr2FPREInaF+I
	2KIuaOaERAel9c0g1nVYs1l0QMxoPTi1OrHz4ilhp86KVp2EKJPlkv7mi7GWPpiZ
	CfXTd8+7edqhGWFP0pdNpHCUJobT2ppAnd3s+V0Qh4zAAdEwRDTFodVwDpabAOZo
	wH7fNpiLT50hfBeA7bQb2npYE2bFbav120vxVubxlAQKY9x8Ny/dqrWYZezw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747037420; x=1747123820; bh=xkp2h/cDEdbZ2aCrVa3ljCeQJ4LL0TPyDe7
	Sy7I1BKU=; b=VJdJuNFQ5Y9zuhi5QgSrQXfgwXUrJOS54vDp4ne2a2sOfhWFxi7
	61K4G24qMVqLdjBDtEkfvI5BPp1HLRP2IGiaeD8s/IGIleAAwDOwXKJqBHV2msBH
	tqabqqbVg9KF7BA8K+UpphF+WSlC1EsrNCyGjsXeTC8XlE7P4bL8eSzkLcLshppG
	entZP5MlIEY24K5P5bcomkh+3NLU4Hqfw68OznlC7p497wEOWI+6ET7XFgy7N373
	JP2Rh36h2oOBVwqzpVM9hrQ+00Oo2G7266XUfrUlJgaQkmNguLf8DETewZ4Nm9aB
	g3e+WtOqpK8FJ03i9mrS5NNOXcCJ5Y6HhiA==
X-ME-Sender: <xms:66whaODnvJAub_Htn1Z5iuSeEgKYEyvNPDHgUi0r7sieEv6QJ76jsA>
    <xme:66whaIgWOKNRQP-JUfkLW7n62gLqiCIReh17MMXpGFX7uHpMA7vnwqM-MnJFUG_Wg
    LsfXPp1xuvOVfd86w>
X-ME-Received: <xmr:66whaBkg4I-uz_SroJS6MBDIA6Xo8PREPucZerhTrdNRSDtqTNSrL_8lYppun4_iQjkKOnRbHUt2zn_Qc1fdyx1v2-yQuFICEjx11uy-_Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrd
    hnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:66whaMyMMym64p4ulL1WX5DG8JnUtl69Em-HqZH450wMUg9cQvx5jA>
    <xmx:66whaDT_xctuPolPnCCU5VMCyXNMDh2iuRB1RgJHyHtnm78RCGxbTA>
    <xmx:66whaHb9bIM7_GHmtgaNgZ4pecn6Cfbl9CE0D6XkMqTH7CKNYUUTdA>
    <xmx:66whaMSAhVASSi8F93YE23nGwCaas1MXm_xXm7ndzmfPFyqvwBkt3g>
    <xmx:7KwhaEP8BRS7TaaBM695z8_8tFeDSEqAdEHStM2zZhQfIU0S17RqTbiT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 04:10:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 268c99c3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 08:10:16 +0000 (UTC)
Date: Mon, 12 May 2025 10:10:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] builtin/am: fix memory leak in `split_mail_stgit_series`
Message-ID: <aCGs4nRjjHAs6aYu@pks.im>
References: <pull.1961.git.git.1747015647505.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1961.git.git.1747015647505.gitgitgadget@gmail.com>

On Mon, May 12, 2025 at 02:07:27AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In builtin/am.c:split_mail_stgit_series, if `fopen` failed,
> `series_dir_buf` allocated by `xstrdup` will leak. Add `free` in
> `!fp` if branch will prevent the leak.
> 
> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>

This fix looks obviously correct to me. Thanks!

Patrick
