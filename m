Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759B318150
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280220; cv=none; b=RCtZDnmdRrD3rLBBnMsrUmL5IMCkZJL2S3/9FHbewIFRqjEDNqmtwQUwc26uEl84sXVPSGugXI6nFCVn22luZ8Y1zExK9wO12C04GaINfSZQ2Pda8Ny/6pg74RxdgFnpWqDGQRKpHZMzzirHJl+iPBQDlhA7IGhJeWJNh2wHbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280220; c=relaxed/simple;
	bh=GMEG1KSWk56Geh7+4v8LwNbsagqLrH9updwFjUj4WY0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iN4FJ4uDp/jHr4qUUdmYfEYpA9D1OOYPzviLL+SE7xmVND8OtXXwvF4gOAhPTLO3G5Q9d7Lsbf5NNPdvcS5OPTUwT93Zmq3WnXxM7xWskcoBjoUhxSRz4Oy4kLbzSFuIAxsleJyUdPD0vBDZJvQ9lwxosADfbrQszqvbIJ84Du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aj.id.au; spf=pass smtp.mailfrom=aj.id.au; dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b=8/mMfjkq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2gtZdVW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aj.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aj.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="8/mMfjkq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2gtZdVW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1EC2E1D00100;
	Wed, 27 Aug 2025 03:36:57 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Wed, 27 Aug 2025 03:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756280216;
	 x=1756366616; bh=GMEG1KSWk56Geh7+4v8LwNbsagqLrH9updwFjUj4WY0=; b=
	8/mMfjkqPB5b2amZ4qt2JU5YQEsPVL3IuLRCJQiJGAMdn4MCn0tYOaKlm+gBViYU
	E8znY/gf55TAJgsuv7YHvOJXvc+EmAH+XHK5w4GnVOS2IT9ibnHzYqFza93rmQ5V
	fnAewNDcm2evVV0GQV2Boq0rw7WqOfcyUfUWpqAphQGzpj1UQAajff4rDHUwjm8s
	R9ogEWhZrs/fyz6riESzaI1RAkWrC+3LH+vKyPi443H9TsTjAL2nW2CGmyUjntks
	sZ76zrPKNf1dUK3ltZ/Y7vINDbRljqbBK3iWg6+EQ/bJPAc8ZQ5Ju47AhqdzbJYm
	FjRVh5oWZXZTp3SR7saqwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756280216; x=
	1756366616; bh=GMEG1KSWk56Geh7+4v8LwNbsagqLrH9updwFjUj4WY0=; b=Q
	2gtZdVW+gTPRoj5d42TirsWEduv9H51wAs6PENanflhPBRQOyerExZ9CZIzwdYKi
	bSEcRx/wJyffOAhl4L38f5fG2vMMhxsw1Fuey8qJZB45FztViuIjBzUla15FI86D
	LISxU7el+tqH34SvQjpnzHCnlaxp7BzQ+9/QGywN+WvA4EXY81h4UB9hC+GAzAtg
	mX8QXe0znj5++NaDibsTea6s9P993njtDrIePisw5A193Xm9Z6FhT4z4K2bsB8Ur
	VSoPt52ql9aGzOAOsNjSojKQVJzqc9NiLuiNmZii51bLGJdoaUxFakR1heXBFFFr
	bsC3Vuf3YMfoG4nrOXgIw==
X-ME-Sender: <xms:mLWuaLyMlU0rdOiCGww9SQ0mQNIxHUPZJ34jNdDiBjTm8PgbWhKgxA>
    <xme:mLWuaDTwY3LahoomTj30tCWrjRps2hXmclqV2iF5nJcn_sOpJQTSc70qQVLWbJK7S
    UYImOut7L9lRB8HFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpefgueefiedufeetvefgtedugffgveejgefggeffteelteekfefgvdefuefg
    hfffvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghupdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mLWuaB6PRpt9RPLh2uscOopxLRLzshNow6Z1QJnmTGrIT-ldGcVJTQ>
    <xmx:mLWuaFxfqd91qnroYrHrG7QbPHlZb6Gw6oVwY2JKmAqbssjETbfuQg>
    <xmx:mLWuaFbDKyJUl533iLvt7ZQlKrL56w9MRcZsRZiwH_ocO6XIfdD1WA>
    <xmx:mLWuaHR5PPOFHS9SugzZWreHlK4sqS4G3W_6YjqatBl-YEkjn8zCkw>
    <xmx:mLWuaGJbhEuybvEW88n8YLjiLAnl7EKgvZLzwM_vQZD-rnB6C4ixpxtm>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA5FB2CE0071; Wed, 27 Aug 2025 03:36:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbpvHn3zrFiN
Date: Wed, 27 Aug 2025 17:06:27 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Emily Shaffer" <emilyshaffer@google.com>
Message-Id: <25c08035-8bb8-4a87-824c-76c88102a1ef@app.fastmail.com>
In-Reply-To: <pull.2042.v2.git.git.1756279345929.gitgitgadget@gmail.com>
References: <pull.2042.git.git.1756279041881.gitgitgadget@gmail.com>
 <pull.2042.v2.git.git.1756279345929.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] doc: document rev-list opts in revert, cherry-pick
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, 27 Aug 2025, at 16:52, Emily Shaffer via GitGitGadget wrote:
> From: Emily Shaffer <emilyshaffer@google.com>
>
> In f873a273d1 (revert: accept arbitrary rev-list options, 2010-06-14),
> we added a handful of new options to `git revert` and `git cherry-pick`,
> but did not document them except by example to `cherry-pick` only. We
> have a nice shorthand for adding the rev-list documentation, so let's
> add it now, to both commands.
>
> Reported-by: Andrew Jeffrey <andrew@aj.id.au>

Thanks!

My only input is my surname is spelled the surprising way: s/Jeffrey/Jeffery/ :) Hopefully someone can fix that up when applying it rather than needing a v3!

Andrew
