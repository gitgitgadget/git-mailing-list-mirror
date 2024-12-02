Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D633CA
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 02:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733107696; cv=none; b=az27PuHn/2V9FK3YdoQw2pef4tmMOsB3oBIFzAT++XiRtQO9pkGcU2cLq40eUCMRcV1Syx/ojQhufe0j+orqxM19WPxJO6acHF/z1qRS7VbHPmCi+/kcX1ERjr3VYFH3WdbYFUBiNI2J4S4ixfjdTqimtei369X7bNfid+KyPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733107696; c=relaxed/simple;
	bh=anlBgO3avre3LxRpD+zZRaCpqS4lnb3Xq0vmH4VN5p4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PaTe9kgQxoU3BE6Z0UqRyjoGUodhII5Eo7Z4EGFdXqTr+IZZIF3xXvCBLKwSdpBYYkpymLBI5bYEh7gANjrLlNFGxjD5mb0pltk7bYuqzc+KPMu9AoZdajElrCrvuPxWRrTwTDz/65NDzkg/A4Mxh3Due0g8w7GYNvY1Hk+sZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z5uWY6GD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z5uWY6GD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A24861140107;
	Sun,  1 Dec 2024 21:48:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 01 Dec 2024 21:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733107692; x=1733194092; bh=/ijyI5TCaPlpoq0ImrTYGOerW9PmSkdcYqw
	o591+kDs=; b=z5uWY6GDzdW1o632tmwwwgJkey4OUQVrQMVEC9b+WXINgZc4Osv
	x8yDkqyomsvP+kyDjmI03TZKgDV0APmzS9e2MkJqLVlC8UBI9fNKYxUnc5YZ8wWF
	8FmGOJegk9W0rwxaTvSghffp0bGZHPYjBMDL9/vn/ouMVC3H+YVB5VlFOFX4AMTP
	8YrqEbhLi9CQ5qNP5c2lEXPwmRAoiRJLMiBZi+70n8FQeAbezKrGqSQW5vBcU8fM
	LZxtWxVn7ypJQjgyVc0ZbzNcwoP4NXs3bs1SYULZreYHgTDiCb4OG7xpETlSjppA
	cFUND6Qw/F15bUMdoKWrZkoL4Z5d16lj86Q==
X-ME-Sender: <xms:7B9NZ5HtzsEa5rypfUqBNloCkSl1NpRpDznf2FyqWb6oqBbuNFFX_w>
    <xme:7B9NZ-WILXaMDBqJHPh69sSeTw5qEvlEa90IgcI4Nf9wFW2QTBMEnM9SRVrPfjook
    xYLI4N9n42MBIDTdA>
X-ME-Received: <xmr:7B9NZ7Jf3fpoglNqd7ZGtP0HcpL09138vflAI7DwhbyLbOw7-wkNq7QgGx2djoxGYyZwsPJAuswu_IlQ0bA6wigmYk9OOTqZjczpX-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfeesph
    hmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7B9NZ_EWN41hVac92Jty4vbahldIWkSUgtx8WSgLysUiOBl6q6vsgg>
    <xmx:7B9NZ_UOgf-_ELvC156GEAYFjtwaZ5vKBt4u4j-BP8S2ShVDq-qd-Q>
    <xmx:7B9NZ6MYJn4n9suD1UHJnwXEFy5btpwuZWQp2fExXJM5rvYxg07s7w>
    <xmx:7B9NZ-2APHNP2odesKWjLzsqhE3Cd7wKOUfr2GPzOtqLwbnaZfYW-w>
    <xmx:7B9NZ6TPbZ6gzEKlIHRC6ProWOh4mDFXW1Du1fUvB486g1Nq9PgcxUVD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 21:48:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #10; Thu, 28)
In-Reply-To: <D5Y4Z7I3PJW2.C2AE3WAKRLLH@pm.me> (Caleb White's message of "Thu,
	28 Nov 2024 21:40:28 +0000")
References: <D5Y4Z7I3PJW2.C2AE3WAKRLLH@pm.me>
Date: Mon, 02 Dec 2024 11:48:10 +0900
Message-ID: <xmqq8qsykdg5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

> On Wed Nov 27, 2024 at 11:35 PM CST, Junio C Hamano wrote:
>> * cw/worktree-extension (2024-11-26) 8 commits
>>  - worktree: refactor `repair_worktree_after_gitdir_move()`
>>  - worktree: add relative cli/config options to `repair` command
>>  - worktree: add relative cli/config options to `move` command
>>  - worktree: add relative cli/config options to `add` command
>>  - worktree: add `write_worktree_linking_files()` function
>>  - worktree: refactor infer_backlink return
>>  - worktree: add `relativeWorktrees` extension
>>  - setup: correctly reinitialize repository version
>>
>>  Introduce a new repository extension to prevent older Git versions
>>  from mis-interpreting worktrees created with relative paths.
>>
>>  Will merge to 'next'?
>>  source: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
>
> There is one test that I've updated (added a check that was accidentally
> removed). I can send that as a reroll if you'd like, otherwise I think
> this is ready to go.

Yup, v6 looks good.  Will queue.  Thanks.
