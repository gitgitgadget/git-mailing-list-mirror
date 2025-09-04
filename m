Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F00179BD
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005414; cv=none; b=LRnV+3tU8brJgBwx+No9yaP+4WHEQ6fxYQfEZj/E6rIgPWkpDfK0LDtU4ueJqlg+NMThom1lpFpftP+Ksh1e2r3giqBNLf7Xm9QeRz0XcqXXHGzLIV7VEF8tCQHo9l2Nw6LPXmweQLmIVSEijCidxh/Y7//mh85vspXcEMxLFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005414; c=relaxed/simple;
	bh=AkPuw7bQo27zHcehwJ+XUOm+TeGZikMk+xTajjpk3Yg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekFv7O1oOsblTb7LuxtTReMqqwIuxcwH5pFfePFTX+GQrLq8GbWQJta3EKrEiqCmr/8ZRRnFLEE3iSgGg1aGlso9P1HsTnI4Z3j3EQbplJgA0pMf0j6Y+OrjBtx9TanSyiULhPgE8raGmfqkvNu17MvA2pZJG0naXkD2oQrPCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QmKJDc0c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CienZKzc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QmKJDc0c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CienZKzc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FE36EC024D;
	Thu,  4 Sep 2025 13:03:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 13:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757005411; x=1757091811; bh=jD6hv1bVPm
	Lb+/WKVxpiAea0Lsk+tVYb2eYyvrRb+ZM=; b=QmKJDc0cKPdsR/8iIqe+Fc/Su2
	xfMTVmLpjVdeiQLXyz0PCgiKlGkqfn+69TFw0ywp5rLgFSXng8Y7aPi23IxK01/W
	yxSNtBVllLrJ/0vfYcKMRE6f0tpZGqddirFECGchbRG5YaJ3aa5dI/Ugkvz9d7QX
	SizURKoXJRPO8UwAdUZf17E4BNgTcM6Ax0npMowNoLJhbCwi7iElbQczxd1Mf57/
	y7F7hnZRlzx+8AocSuqU0E3ldnmb8xdjD9J0vu6V9Cyww+S1KB1r7+aPLMvsMNhD
	m3+Vju8kHreB3u71UUmm88o1xxUjJRb9/KVxcSyf0riclxdrc+ntToP3Igvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757005411; x=1757091811; bh=jD6hv1bVPmLb+/WKVxpiAea0Lsk+tVYb2eY
	yvrRb+ZM=; b=CienZKzcOATRTR2Qgr6bm0SGDs6Ni4/d9wG/iL5jQpfS5dk5lc1
	QzVkS7beqljAhGERcdO0OVCvA+Vo8ZsiVaCi2j2jQxC3MZtxffegcR6z+2fOpP8K
	Wwf4etA+ucK2GH4I6fIUaF/UGNxVK2JtFe4f5Uvn2ZCpSdiGG1h5ipriVb+JJpaF
	EBFMqzQZr9ERyF8ijuSOQca7zaWqMAXHhfl95+znPwUVOQ+Q1uT4VXIJio3iY+/m
	rhhXjG5BDlRam0VWCQFNBTbLFzpTJ1l43JAQwF95EeLmBq69HbTMks+0IiMJZHNs
	J4dbWec7wDD4nn9njjzfvLzUZLSLe7Gz7ZQ==
X-ME-Sender: <xms:Y8a5aK1jpLHf2JPMUMYuRkBdDfq3hPBHP0mW5kPOEA8areFWHNhtwA>
    <xme:Y8a5aFg5y4Z1p4hCeBffLaW2wgOjjjn-r9iTO9q3o0PC_fE_QrGE5EaL5462GlOXo
    paCbFHBsfJv3_n0_Q>
X-ME-Received: <xmr:Y8a5aDXqGQt8U7zXplNE5QfPtGJlY5ovhmhVWEXInmDy4xIrtMK_AntQU0klgL4DPJfB5A-A70ZncPnkOEfc5X_zOgJzOXRCamaS1Pk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinh
    guvghlihhnsehgmhigrdguvgdprhgtphhtthhopehhuhgrnhhgshgvnhefieehsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Y8a5aMUlxkfSQke2brP_0IfUdpj4ujnmu6tBk7WsKVY8ohLDEQBhMw>
    <xmx:Y8a5aLgxGcywgVn439PabVpDMIhybMHo4A-kgra3rBx1pIcHTd03IQ>
    <xmx:Y8a5aPbxDf24NQm2Q2kQ20y9csS5w-w128KZN7fBYqnCNuTkzenELQ>
    <xmx:Y8a5aAoO6aezVf9LaKnXM7Zp4Qs4fQjPxQOtQ-1qTeBaNzDM3aHERw>
    <xmx:Y8a5aBXSJ39wOmPh7m64iiVGQ_q7XEdHQipFo1J_Uor3vDbjTHfwE76y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 13:03:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/4] breaking changes: switch default initial branch
 name to "main"
In-Reply-To: <cover.1756992089.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Thu, 4 Sep 2025 14:21:28 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1756992089.git.phillip.wood@dunelm.org.uk>
Date: Thu, 04 Sep 2025 10:03:29 -0700
Message-ID: <xmqq7bye9mla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> The patches have been re-ordered so that the change to the default
> initial branch name comes first.

We have been running for quite some time the "breaking-changes" CI
job with 'main' as the default initial branch name, long before this
series materialized.  Thanks to it, we know that such a flip should
not break any of our tests, so this patch being the first in the
series makes perfect sense.

> That patch now includes a test
> for the default initial branch name and includes the changes to the
> commit message and documentation suggested by Patrick and Junio. The
> commit messages for the other patches have been reworded now that
> GIT_TEST_DEFAULT_BRANCH_NAME is not being removed but the code changes
> are the same.
>
> This is an alternative to changing the branch name now as suggested in
> https://lore.kernel.org<pull.1961.git.1756183921623.gitgitgadget@gmail.com

No reason to repost, but for those who are reading from the
sidelines, the URL would work better with "org<pull" ->
"org/git/pull".

Thanks.
