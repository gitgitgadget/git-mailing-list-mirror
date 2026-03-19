Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953403806D6
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914107; cv=none; b=J1BI4th+Vgwv1/8sqByrjkTojWVWRn1mWN3f05v/4BaazI4qTvp48G6CDgcItmuNAy+93CoL8Ip7PajfbXO71kRBjC46GF/4PHPyfQxzItUW359cGs547ZxTJ+Nn+o3KPHy4ktJGfCWIGGI9SIG9U2iHNUY9nv9C7D+CTxqWG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914107; c=relaxed/simple;
	bh=w6bNa1+BRS358djmYGChO1c9r1WRwhgUD5Ixs1WAUS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7WsCS4x6tQ2FqzRIxaR2BSACkTI3PHhZUsNwlScLxilQKd3O58eaTWs4PNhYwxtQr8D8VG2P3+fXFJ3w5GdUU9oIuqLzMuayygpDtlrwt+8GC9gzw6Tpp7nZQxntCyMGvDlT6fB1wnlM4Q0R4R+spugRNVLq8brbGWFXllqHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RPMWOIWZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYjC8REG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RPMWOIWZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYjC8REG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76938140018E;
	Thu, 19 Mar 2026 05:55:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 05:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773914103; x=1774000503; bh=ZNt9EAE0d3
	Q+kjLsqOsfEvW4kcZXTVMOQrKtLMM+Lmo=; b=RPMWOIWZZ604bALslNYCCJnLx+
	YfzNoJ/sE6uOBq2bX6o+3PPD0hUrbepzJMdSesgqVGgFYK05fSbbcMS/DgBkzopH
	9TjSI0aWWYwu3/ZCp20zRGTh8JOabrkayjNc1I7WJeD7JWDJLwnRO+1BWEuWjzLu
	aXluqMf/7/0RWFBsjYFoBn45lgCy7XHNNTkgbFnupGfapa24q4ItnaKFrG8qOxIg
	mTK5QmvpoYA//3ZLxME02L7x0raMes7/BuHYTlxGa+CBqZANRcNec7C8tla+6U+b
	AIKqTjErena5TLhbc7M+ctAfu7ZL/Z3q8GlbSf999jsTUJxu8Ly9hQ9FA6Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773914103; x=1774000503; bh=ZNt9EAE0d3Q+kjLsqOsfEvW4kcZXTVMOQrK
	tLMM+Lmo=; b=nYjC8REGaagvglNmgSGtEPSiXsPrusfQuj/4JlhHZ6bAvfoF1X9
	3W+f/6X3hnQJrojxFo91gvKISay8HW7CQBXL3FFpIxpNcpxLu/iengSorNKMAp4J
	5oM4KAftVC0xMl2/n4XFHxg792NlteyOGuToGAStnJ8HT4q4AUV5rhUwLwCrPDrr
	ErCOz4QH/cfAVz3XD8SRdQNQLTHhoTmkNNAMXyvwm5dgYBBuIa1pEBGNfXf1YScC
	9bIn7F4oJmsE5YFUDJ8kBjNMAm+Fz59aAvqMpcoyVBYaKu3K9OljkWEItp9BaWbR
	Ef7psO5FzebpW89Orv5GYGy5XjNA80ps8cA==
X-ME-Sender: <xms:98e7ae6RVWuq1VAXK9xrEitEh9QLBVL1YHGLQx_Ct19c0d-DVZL3Eg>
    <xme:98e7ae62IeMFEWF2WIrtmFcNop3qHp_WIhxs5L25vJq-isI-8jAuKGE_W_0fKp4pp
    IT3mhEk9xVetQXgLWuqVZ8RAln-ch-ldbvxMQgtU7gFyO5f0Jet1w>
X-ME-Received: <xmr:98e7aSfFBnXlH6Uwst1oU2ucpz9DDwwfoS_1Qsr5It-zspvpMNDyGX4UE434LVBCY3uqaxISYlbwk-xqUFVfHJKhseQeBygQY5nlW35-ekTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeijedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:98e7aaAJF1RoYA4_uGIfxdGfSDAjw0PA7gqvEjgrwc7WmQpOrlTrLQ>
    <xmx:98e7ad8ONs2EZZGK-xl7ilAxMEwyac7tlg6tXfpK8My0OBK_IZ67pQ>
    <xmx:98e7adL8ilfFtd8bgpoMsmTOg4yrK0sigu7zK49mFVbKwYHbogxUfg>
    <xmx:98e7aehk1dpkLyKkcdxK-tcJq0Q8TSYC4fJKQg4ubnWunzUIHOZZ_A>
    <xmx:98e7aR9CXuY_qrd8bBFt9uqIa_xz2HyfjBA9N9f-ptIXjJHlm1p2aQJ_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 05:55:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f9a62e60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 09:55:01 +0000 (UTC)
Date: Thu, 19 Mar 2026 10:54:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 4/5] backfill: work with prefix pathspecs
Message-ID: <abvH8ttRkgu1R57C@pks.im>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>
 <xmqqse9yhzu8.fsf@gitster.g>
 <5122920d-078e-46c6-a494-c6e430df7e3f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5122920d-078e-46c6-a494-c6e430df7e3f@gmail.com>

On Wed, Mar 18, 2026 at 09:15:00AM -0400, Derrick Stolee wrote:
> On 3/17/2026 6:10 PM, Junio C Hamano wrote:
> >> Update the path-walk API to accept certain kinds of pathspecs and to
> >> silently ignore anything too complex.
> > 
> > Hmph, "silently ignore", instead of "no, you cannot use that! and
> > die", or at least "sorry, I cannot do that, so the result may not be
> > what you wanted, you've been warned"?
> 
> The behavior when silently ignoring is to over-download. The revision
> walk still filters commits, but the path-walk then walks paths beyond
> that pathspec. This will be fixed in the next commit, so adding an
> error case didn't seem worth it. I'll do a better job foreshadowing.

I guess this is a fine tradeoff when documented properly. But I think in
that case we should make very clear that this behaviour may change in
the future if find a way to efficiently limit the pathwalk, too.

Patrick
