Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4882382370
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914121; cv=none; b=UjW+ymlf0EflN5UaI1gQ5OXoc+WwQXVlt2zCexgN58OuDjOcxl4qxZHx9J6R4a8QNgky31lh9KBBAw0WeHN0eP7Hy9ngpryZ7uGgTVxaYs1dL+5VBxI4nBfzV71Wewdyu8HDFt5mzLALSMhJyGTKNXa7QxOEofL/jolX+Hemfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914121; c=relaxed/simple;
	bh=JofXQnz0y6qXyvhYzA2eYso7xzer2OtlzkWZNZkMVXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nu2YuJQNNUmd1pLRo19Z4luwzG/Acy0mboFSbFbhn5UN4nSkcU6+pQTncGNJSdcybHouFbbHqzeXf7se6F7WxF3su05lVfxV/F80nvoapKCp/lgk5drO6I3ZtSdH+xq9JGb3lH0H5QsaExdR8rXOnSd1dlZMJQmiq+BZfqCnMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mzEDqm8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WW3J0Sum; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mzEDqm8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WW3J0Sum"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA1941400195;
	Thu, 19 Mar 2026 05:55:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 05:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773914116; x=1774000516; bh=T75aO01ZNi
	eU0XRZAis7wWzWOh7wZ4SULGI/yZ5HlXU=; b=mzEDqm8qNyfzj9jKp2XKzF9I3H
	21RDCLvH+qILCP/PSxrF3kjXIRhPFu70wwjsPjCJa+6egptiUhjrIgOzpGqz49Zx
	YC0POJatrkYMJElhMGgpjeI/P1HrynVxwIspvCocp5QGX3jeJgZX1UJAEzceGc5B
	FvlFakROZoaOk6/kxXW7PPKp31e6fteJCaPR9//jguu3aUyLfCIUt/XQBUMh6BRy
	hDN/OGRlIt/t3f5NrjcvMEL0bPFUgx2HMga2uWBHdJAAcjiEPqAulQM64SrDjpR/
	vYWGm2+lpwmd6dYB7w0oSaFzoP0AKPYHOFYGYkjtzX2IB6cjWRx5sIyJaBmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773914116; x=1774000516; bh=T75aO01ZNieU0XRZAis7wWzWOh7wZ4SULGI
	/yZ5HlXU=; b=WW3J0Sumwum38yR/cj+cg7QvujKXOqkxMW7UOUHAdyEc/hq6lDX
	7J+O4B2P+5YK2HqwfjdaVh8lTxAWvd/HndS04Y6A7TEIipBKz5xMlJEYiAu7HimE
	GxvA+pbJFe6Kd/wvIZVJXbnzz8J+Zo1m5wyAPim3ObN4fbapuiAXDoPmzGgLOPeI
	PnH6IhQl/fyKB5/S0mZ0uICxGglvKZei9R478hUpdH/rBnPyN/tlRMSeR+mwTcfz
	Vd29mT48wmpw/O/MknnHw8gNqgkSDlQDbxLDHQi2tXtA9qB0RQtHeKfRTvaaGIwL
	miGAQDnehRzf53iqwdVAXAlSuFmrr0ez2zA==
X-ME-Sender: <xms:BMi7aRFGvSPbbZiC2rkB72c08d95PD4e1rLTt66PNn910YlaMGb4Eg>
    <xme:BMi7adXbZP2vAdM33Iq9SeCqi93nIgEQjaRp68ROP9D4XxD0KXXoGR5yMg5DERyj5
    kR50nHxzl2W5F9qm2oE9rkV-7nG4VvhOiGThL3w1YxJlN6AvdrJdg>
X-ME-Received: <xmr:BMi7aYIFuU2TlpLiOmlWiqFfWMwWOLiBjCo6g5BBbZrNs5m9La-tdzcJqwnIXh7LQOlOJtxtYNMbiI9nHN-be77Rk1rHiBZfGXqAN86OFUNy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeijeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BMi7aV8ysvutOr5RcUMlIoUgAS1IfvLLbiO84Wy7_hOr3RhD8gB-cA>
    <xmx:BMi7aTIC9sJXKpE-KG-NyZHpqSbzI1Y-KR-9A8_fMpdWYug4Vbx6wA>
    <xmx:BMi7aSkpZrnMBTlk77S_6qKSg1WMW9U60ahFPv2n71jDbMfZTr9Zzw>
    <xmx:BMi7afNvMcEt-yTXu7FEqhRj4JSzWWu4Xk1ps0TUyKsup4_8AG5qHw>
    <xmx:BMi7aTpiB20I-xXY04iAtEzfC-8fptXBSbY4wpmIZucNybiXjpVU2rCG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 05:55:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64096c81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 09:55:14 +0000 (UTC)
Date: Thu, 19 Mar 2026 10:55:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/5] backfill: work with prefix pathspecs
Message-ID: <abvIADZ8kt11t2kP@pks.im>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>

On Tue, Mar 17, 2026 at 12:29:20AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/path-walk.c b/path-walk.c
> index 364e4cfa19..e1ad4b0208 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -481,6 +524,18 @@ int walk_objects_by_path(struct path_walk_info *info)
>  	if (info->tags)
>  		info->revs->tag_objects = 1;
>  
> +	if (ctx.revs->prune_data.nr) {
> +		/*
> +		 * Only exact prefix pathspecs are currently supported.
> +		 * Clear any wildcard or magic pathspecs to avoid
> +		 * incorrect prefix matching.
> +		 */
> +		struct pathspec *pd = &ctx.revs->prune_data;
> +
> +		if (pd->has_wildcard || pd->magic)
> +			pd->nr = 0;
> +	}

Huh, curious. Won't this cause a leak? I guess we should rather use
`clear_pathspec()` here.

Also shows that this path is missing test coverage.

Patrick
