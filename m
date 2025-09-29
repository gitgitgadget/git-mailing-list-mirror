Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010DE2475D0
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188310; cv=none; b=CTtizlLyMNg9Jwcon6TNt6xlv7HAuG/LDMoQ/6o1sChkqM54iV/a5XgV5nv7ORcsf8Ooe+C3jxS7r8jXCOozSi5w1ovMIfAjaUr2NHTerMsE0vQYRaPe1fJDBcSPU3xO/h0ObORoc7vqe0aamKuE678Zl5UrCEPWwsd6+uYRMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188310; c=relaxed/simple;
	bh=Ubxxn0it/dgJrBO20QzidUMo/XLeuEFPDx41ZUfjGk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnDzr7y0NAVMcCeiiDYFTOcH/rKtv9o1FZEQ/IvFcr6oNwlc9e6TqLBMuLQAuMinegSqZnAYSlMGTOeT2uqJd0phaYbsBdoHD10sIr9iiiLAOFXKA6ARuxVd9iNRFJIK+sFFp74gCrW4hanHkG8XVjZshb1nJQ4C5ntJczbpPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NE9cagyT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UCWcQV/z; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NE9cagyT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UCWcQV/z"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FFC214000B1;
	Mon, 29 Sep 2025 19:25:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 29 Sep 2025 19:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188308; x=1759274708; bh=MmVhs/MqSh
	KLoEOfjvmJ2sWPMucZq1t1Ne+XXz9Jgc0=; b=NE9cagyTPTzG3sEejDqh0xeI1+
	7SOTdqFCrqjuF175oAskkvLyrw0MqUcp27Mm99d8QoZxRBJA91+fr5Hc2p07MI22
	BvuYTHbDXKKzsdgIGXK2gpq6OTSfpbvAeU3IYJZjYbE2AkuohDFajtoRsUf1HtoG
	VheQMbKwHf3teqQK7+TFEwfFPtWFAuMT9EH0RAqwH/BUzzfI/yWrUhyFRvbzBW4D
	deP+n4yQHdBOhpnMZWGiGkoe8neIsWhA9R3VGCvjf9ElRDstHvkptGfuvElqCwiA
	wMXIyaR1Vxi+bjNf1M6qdmVWkE5uoJDOxBzbrrGfShM2r1ji/mRzQteG3Iog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188308; x=1759274708; bh=MmVhs/MqShKLoEOfjvmJ2sWPMucZq1t1Ne+
	XXz9Jgc0=; b=UCWcQV/znSFXtv1B6/av0xc4ci7+mejAAq0jij13exgFwBe24jQ
	WbgoJGU1QlNIOIJSHP/tiVEOy+/71aSq2J07qubLDvKRE923QzUg1F2vSj6CsrhL
	6nTTOkCxKBnqjUHK+7JHNTS0FbgCdTUrtaq8BGu3gnqfzs57Kcx50WKYk/z44xur
	iZMLnEBA8I5NWpNgmP3Wj/gm6YhsV+TP8boQrJ+1sK9gsznqNEYeTdyTsjsFeVFH
	b5Tt9EDjML1stihljki4KsMSSPIOqYnyE9Lj8F5X87tIQ8QcaGzFTfQ60q/eGsiJ
	tRZwcFBPoplhbsotZ99Wc/4mcSgXAA6uloA==
X-ME-Sender: <xms:UxXbaL9GL3eUCj0jpg1hfXaog6gzMpMa6ZDgqQqlattfbqG6G5LgvA>
    <xme:UxXbaPKwlsTYK7gJ6ZOB5iqWznM93etGmdGpNV97pdST5raH4Qm2cYnJwArnAoPSl
    kkZcIrNZP4_R4bTifkqz56vRwlZpnxOLT9iMXk-kkzHZvK_wenH>
X-ME-Received: <xmr:UxXbaGbLuEbFUqQwpI9C67Mt9XhmTP2V4tTLQ4PjtcxEpC7BNqba9VwDDtTTCnsrobyJIPYo97LAu_zHKulmCawiM9sGMuRR37lw_BLGuuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:UxXbaBLCPgLv5Ex1sU5WnPH2gMCizZuCzUXR3fv-TjI85fu5chqh2g>
    <xmx:UxXbaEBJDkYZ7wXxHeMPHrN5Fj91rw_8n5LVH1zAsNTd3UUQ8bnQkA>
    <xmx:UxXbaGoxdrul2u315dxfOasz5ImWvfLkj6IjgdUHlQ-hJHt_PB8T9Q>
    <xmx:UxXbaPhPQ-kJ05Tf93iGrVmPaMrX5k27ycPyJ4TQ9zaGSFpZLU_XRg>
    <xmx:VBXbaM3D5X7mc0NtPYAxSoa9OQf0tWBVvd56cDiTHA8j-y7_bhCN9hB3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:25:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c679d272 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:25:06 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:25:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Message-ID: <aNsVT_OWOCAB3fzO@pks.im>
References: <xmqqldm0am4b.fsf@gitster.g>
 <aNhX9AJ/zq4IYhmW@nand.local>
 <xmqqseg777k8.fsf@gitster.g>
 <aNsG5Jd_YLgrwarI@pks.im>
 <xmqqqzvo6fmw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzvo6fmw.fsf@gitster.g>

On Mon, Sep 29, 2025 at 03:46:47PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Despite the potential awkwardness I have to wonder whether this would
> > even help us with the goal to speed up the overall process. To me it
> > rather feels like there's another step now that a patch series has to go
> > through, so my naive expectation is that it will rather slow the process
> > down even more.
> >
> > Am I missing something?
> 
> The above is an effort to reduce the chance/risk that the maintainer
> is *not* made aware of the fact that a topic has already been well
> reviewed, or the latest reroll has addressed all the issues
> previously have pointed out and the reviewers are happy with its
> shape, and ready to be merged to 'next', just left in 'seen' labeled
> with "Will merge to 'next'?", etc.

Ah, okay, that makes more sense then. So basically, reviewers should
more explicitly state their overall opinion on a patch series so that it
becomes easier for you to figure out the current state at a glance?

Patrick
