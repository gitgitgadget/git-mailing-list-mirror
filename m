Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D82C0F78
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155633; cv=none; b=LXtMkzUCppc8QSahYH8Ib1HuZYlHz8xgOfC/DxyIR9UQAuoU87XRCw5iXEPVqRhgLVYMINRxYXCjEcCL0Sfl12jHQipgu5UoCDJp2BJ4+X/kzylfKsbrzOw48V9ohAZ8qGNiD9CDy9FIp5mzXdkz70aKbuRqwY9+aQcDIjWbAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155633; c=relaxed/simple;
	bh=mh7HrW3TnD1OTD2C7zplCYD0XRSdHRfvmtlZUSHLyqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4VN4wIuYBLzLYVGL9J8vsu5u1FcJ3of9qf51/K7a8LGicW7+gEJtRi+B3pLzkujW73nsCNXRqBSOWIJpPF4fbD+1VbcvVpi8pNWXpFjl+T0HQiiz2acLlvKnUHBTmGbi6a0eDcnbn/Vboodd89wG2LfkHX4dmnxgIFQA2xmAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RRVRMGRv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NWHU6skh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RRVRMGRv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWHU6skh"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 423E47A014F;
	Mon,  3 Nov 2025 02:40:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 03 Nov 2025 02:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762155629; x=1762242029; bh=Agn8z2H89O
	6heuil3PJOIh8y/SIWJBtC1LadJvim3bw=; b=RRVRMGRvWJPlkFRhNCWq5VEsDr
	F1el7I+vyk33JvkUbbgigCdeeiEEPybboQtvFsahTuj0OUJFQantJnhvJQ8knPFR
	P7pwjC3PgNzDpiYYxQgLh33H3keI/X2ROhGkZKcUZJpD8O3HOk9Lo8qyTXXfp1vE
	G6WMaZIy2Y/1RRvad08dErHPFWiTP9f+grHVtZUxegUIAtklV/yeR576l95YsrUW
	fs9zqFXdoxr+QiMBMNK51bciRa6k+WoGS/YRCNuvouaGpF6sYBNUsxGkPuTP8NP3
	m9rOQ8DaaQY77sLJ2ujzvkvAUK1ffjG7iqpMCEvzns+8ZyzYR5PBsVsNGCkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762155629; x=1762242029; bh=Agn8z2H89O6heuil3PJOIh8y/SIWJBtC1La
	dJvim3bw=; b=NWHU6skhYhjwgqnps5+plkQ3wjINoAw0OIjOvwej7SbH3PU75Xp
	5QyuG8ADPW6YXimWnkwY8wdSOVb5wHw7QzXI9KAspfrkXCg1ujS/U9qO9pvDORjM
	L9maxO9VAfI7l80Lj615bQL//1Cpd0pmUat3qcPxkaReGBlhRSqebuBuVfRwTsNm
	GqZamYq/k3CiD7G1x8jNqbq6tSkajCNuO2AYDcLumh+EEIeQYsYqwpgwYqf5eFrU
	RZ9Y+99t89zuhvT09l1P22324idwr79G+AfUlCcHQkRe59z96tmU/zRwSIfKc60E
	5mo6NMmQrRyEjjz88WL8OeegcNc8YLargkw==
X-ME-Sender: <xms:bFwIafi57nJEbcbdgM2W0dS_64WUGukGjGIVFiCsvD9mxae4zdlSBg>
    <xme:bFwIaS7lhgZLqpZookli0_IbKbkd5ZHy5MdM37oX28c6svBVOnsFvA9XDvxbPRMOO
    al74sUm9XVNLzslS0xRs0qwRjixcPRPt_NcEMqjei3KNEfaldWMSy0>
X-ME-Received: <xmr:bFwIaXZ70cZnQwdZJtTgUrg8JchN8T7sZY30Bt3caty8sCvaxLgdd2fgeBaxqT2JxB4pla1-H89AXmFnptHmfvbJ8bZSCs-47UrECOAJh9Fi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhlihgrsehjvh
    hnshdrtggrpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bFwIaX6_hoYsPTPlTk2FxrbEZJwnf9PuJlR0u_1K-8uU74t9r-0_xA>
    <xmx:bFwIaaB5qFji1URiMBoN0-aMGLZh5f7Okgv4R3gyGoVOKgee5850Ag>
    <xmx:bFwIadfifQCd_8CN6ozJ7ayA95ga2cxW-67dyZ0oBkkaPGBKT3eaKA>
    <xmx:bFwIaZIH1DVv1Hp9dF6EwjbwQ-pkynmj9p93kmgrmquZvRjaXIBBOw>
    <xmx:bVwIaTIrgntQD2HSFHipkYUIItjOOa4YZg_LfiPcaAC8tWoJXlCwr_22>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:40:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e375d7f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:40:26 +0000 (UTC)
Date: Mon, 3 Nov 2025 08:40:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
Message-ID: <aQhcZwv0PdwNc6RW@pks.im>
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
 <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>

On Thu, Oct 30, 2025 at 08:32:16PM +0000, Julia Evans via GitGitGadget wrote:
> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
> new file mode 100644
> index 0000000000..1cefbb4833
> --- /dev/null
> +++ b/Documentation/gitdatamodel.adoc
[snip]
> +2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
> +  regular commits have 1 parent, merge commits have 2 or more parents
> +3. An *author* and the time the commit was authored
> +4. A *committer* and the time the commit was committed.
> +5. A *commit message*

Nit: The punctuation is a bit inconsistent here, as some list items have
a trailing dot while others don't.

> +[[references]]
> +REFERENCES
> +----------
> +
> +References are a way to give a name to a commit.
> +It's easier to remember "the changes I'm working on are on the `turtle`
> +branch" than "the changes are in commit bb69721404348e".
> +Git often uses "ref" as shorthand for "reference".
> +
> +References can either refer to:
> +
> +1. An object ID, usually a <<commit,commit>> ID
> +2. Another reference. This is called a "symbolic reference".

Same here.

Other than these two nits and Junio's comments I think this is in a good
enough shape. Thanks for working on this!

Patrick
