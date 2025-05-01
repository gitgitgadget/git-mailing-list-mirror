Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5C20B807
	for <git@vger.kernel.org>; Thu,  1 May 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117522; cv=none; b=Ssss2W0BKI4NZYMaquP0/NkMX5ylUiesxUcYGiy3mBzFrL0MmqS6jlyBBqk2ds+xXobmjgWBHQa5bvi7eB/otnABoB3zX5p+L/ZbYJqXABK1sLgQX9gatq/Qpu7YYu0Jew0rF2ckJdqMOZstNDDpw9gkHwKRnSfhXlwOMGzQCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117522; c=relaxed/simple;
	bh=GsSrKXP9KfY8O/ak46OTECUueTsjgkYtttIqcB6jnrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DHxdGU/Jnc5HHC6XuQT67sabmVL0G3Tf5qhaOZ2ZH3Wb6V+E2NjzeVgTukrpzDtG5lpVJ5TfH/sq559BlUmmK9KTgEClFhCHr/SYowjqkyQZiCHqBKL6sXvl+3TemyFMjYtk/tNQXEIHuzr+nNLyL8++8eOsoblZham4OkUb0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gbany7J2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WG+/gngk; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gbany7J2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WG+/gngk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1FC61140150;
	Thu,  1 May 2025 12:38:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 01 May 2025 12:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746117518; x=1746203918; bh=YIY8Emm7sS
	atRsk7lXDLiOTw18vj5cmYaQyCXfZaFTw=; b=gbany7J2qHpzWyYiPspfAUkFl3
	WjwwMehfIGxhrjpcGrrsSCLKyqhmixkUyYe0dmM6Z6lZu+bLFbXYuZfDSKknMpQl
	UuRFsTJCJgaDqt4kkCEpEchiOY4bx1fBfH6sctPaJqZv7scR87E531qButGHhbN/
	fd1xvLwfJhWtYIcGSZCJG9ciEYfK36J5fMkZy07Bg5LhvlRW4RaWXIlHhurQ38zv
	DEpXA1IfEbCq40wP2Lw16XuB5y2mfVMZ5iQ5kTLvfVnzee2ufwJsDgiLQaMIkXHG
	eHifMesR99Xc/iMK/APe3zjT/9fUQZmV6Nml5EcGYzRBOKiEhk94v5aLqVvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746117518; x=1746203918; bh=YIY8Emm7sSatRsk7lXDLiOTw18vj5cmYaQy
	CXfZaFTw=; b=WG+/gngkvef55/B+IBaVpxUdqAKNYKQQLfuckCxXvNcWKq0F6WT
	I4WUUFC66om1Rv0nrGF9IPY9UsZf0zFuNMcosWVaoI4bcW0J8WFroDiZr19tbAJ8
	EZJ1vUl2a545YcgxPEcDBOV4p2Tlg7dMP5tgWYyGxAaU8Ho4UvOmfRzLp4blp1Ym
	Yhm6jGra0xJsC9SFcgTzEBolAtZJdxFZHfuHK7qfj53MoTVxVFQQvlc0M6s2a86l
	wkHsQ+IXWhPZnZgXAuHbJPoc2sW1+cDkFf22JIPr70KRPWu/tl7fiMYoJj2BEtiV
	XWIyolp1UUy8cw+HvdICEmqOKQj51g9XLZA==
X-ME-Sender: <xms:jqMTaJHC3gw5LcsaPJ0K8L0oy3Ei0RW3syurqEpKXxqSfp0iqIwcXg>
    <xme:jqMTaOU5SQHlE1WPrSd06-um2lZ1lO240kaCGk2_UWzAcasoEv2j0WH4QJ_HCH3WQ
    sn6rIx_gtmKcorj3A>
X-ME-Received: <xmr:jqMTaLK8rUI6IDaFzpnnd0Mu3Xk0A0X_RUephaOU1oa9pM-4Q-shkLcNeOdX_uGdNROzTfkkuUxIWOMaaVfkgYsNxu5IIOK6tLAi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedttdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jqMTaPGvfBAeCYnuY_-da7e_cHH3tx0y23S2RpXzonO62ceD7tfA6w>
    <xmx:jqMTaPUzmXfHs-g__naJiAXriv7GwtP3qLXO4b7OSNO7yce_uPQ_GA>
    <xmx:jqMTaKPZq23wufboxNbwcBgcRzrvFbolRMxUz0xwknUFH4dnSSKYSA>
    <xmx:jqMTaO2tlYZZxHWU53J_466F1iRF7RJEGThWKwfyg13MJPfEVTo9Vw>
    <xmx:jqMTaCqMuxxaBqub6QUY6PZ-QTouWJlyocSAe2ZtYnj9lzQF-2AShQJo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 12:38:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/2] scalar: add --no-maintenance option
In-Reply-To: <d3659baa-054e-4a31-a851-5471968aed07@gmail.com> (Derrick
	Stolee's message of "Thu, 1 May 2025 09:21:16 -0400")
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
	<xmqq8qnh1jjg.fsf@gitster.g>
	<d3659baa-054e-4a31-a851-5471968aed07@gmail.com>
Date: Thu, 01 May 2025 09:38:36 -0700
Message-ID: <xmqqh624xp4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> Is the right solution to move the toggle_maintenance() out of
> register_dir()? If this is the only way we plan to customize the
> config, then yes. Otherwise, the second or third customization will
> start to lead to copied logic through these three locations.

It is mostly philosophical, I think, but I actually think the
callers that are allowed to be different is a good thing.  The
callers can pass different parameters to register_dir(), but the
distinction between these different callers would become more subtle
and not immediately obvious to readers.  With an explicit call to
toggle_maintenance() at each callsite, it becomes more obvious to
see who sets up the maintenance job and how.

If this is and will stay the only way, I would not care too much
either way, but if we are planning to extend, then I would say that
it is more important to allow callers to be more explicit.

Besides, you'd need to call toggle_maintenance() to disable it in a
caller outside register_dir(), so it is not like you can hide the
tweaks from readers of the code and make it appear to be simpler.
They need to be aware of what goes on anyway.




