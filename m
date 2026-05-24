Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523242D877D
	for <git@vger.kernel.org>; Sun, 24 May 2026 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779616538; cv=none; b=JIPiXKJfKE5vbaQY+uy/q/cMiMQutY0Qm3UnawXViXiMwsttUrLJWshB7iIvp8vwfGcesFggi7tD6dgCTKViJkuv7ZmAi0ztV2xxO+OeC/VLc45b6XmP/OzveYxzErjAmgMhIvtn2Ii5pmapS8/9heCGk5NJ5Bz/y4jhlAEvm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779616538; c=relaxed/simple;
	bh=nFsknLFouGxxwDpelCxoLa1o2sRNcY1eVkQpiYRj3iI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZhRDYpGMDFLb/Hi38qcnUO/pzqPilPDTr4/KyBUPYz626mNIr7dkPzWRG/UiYifBouAdO8YvenFTGR8IBNwXsZbEl8Wvlcm/6CtN8ieyJ/k0/59scyMnnMrk0mtyp1zN85stk8YtqSiRruhb2j7nfhpHaKA2pJk9aMODjhRRRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=geb3Si5K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lv8PQuuZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="geb3Si5K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lv8PQuuZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 61C67EC00E3;
	Sun, 24 May 2026 05:55:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 24 May 2026 05:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779616535; x=1779702935; bh=wYHzOZWaFb
	oOxyWLyg4oodrpaJ4n2nLXwNvQsWvAEqg=; b=geb3Si5KUroVtnbHBOaibKQySd
	8EXZ3REZSjAOfvN6K9z5wXeFspuoV3P/U0sSNBLrVJoypnHjPTfSx8OPeliGmfK9
	bXKDcBc0zGCu1DHXQxYgevgGME4/AfQ3bBRPiugRX+ag4W8fTaUtv6CzSchmzcrs
	gBbaf6vSLG0Ym7Gh9d8/7dYq5mPEOppKRjO8sv46+sc1hhqWdWfwOc/IlHCGsjPR
	Zhmace2eKmrf0Mj3LvmEiCna0MkeS5rg+IikS4gGivzbg5fAQvK3kkZSoNJTLy1d
	x8hBu/mPsZRlw7aTHVjOCkr/Sl8wXgxDB9ZuIL09kasNzJcpFgOpeqmOriLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779616535; x=1779702935; bh=wYHzOZWaFboOxyWLyg4oodrpaJ4n2nLXwNv
	QsWvAEqg=; b=lv8PQuuZCxCJqiqGlysAkyFyZPzFUUyUDBNflOx/+1mVAq1hyB9
	ZcDm8zpS+LDKV3dUFbi/upHWlWCA6wdzgglUU7t5kmMCFVvNTwfzFkgdsHCiu+0w
	lzp6TxpaP1uPxaSQ+ElRsLXaX/l2qhFvsmjp3D8QuTRjAHtOqp6ZiXUPcpVwcC5r
	F+7QyAM43tz9jwelqmt4Ln63tA2Cd88rxr9vZZ9I8E9xdLL5ZZSTIEk2uUR9FZit
	okYCjengatjPZQkoC86iEBpd4F3EkfF6ouA+3lSyY3fd1f1sgOkhTUrqbAWLYYIp
	mI0cRunZ2DNAFAnGcAs/eRjMt4jWMptFNxg==
X-ME-Sender: <xms:F8sSah1kEAs9aHHLjoqLZt0bYWQ2bTb63C-wu5J61njF9dWJ9SU1ow>
    <xme:F8sSaqqOXBMgIiiWpPG5AC-lX1fIcfNXHRzdp8P2ha7G5W5OiZNG9tmcxHqNoxUb3
    WgtGYEW-cvvJCQg9OsfLpWyHCaUhq-qLwp9GmiOBSbNsrgQ6_WUKTc>
X-ME-Received: <xmr:F8sSalhPa97oi7MTzFwJv5JOr7_BzRLxNiIgcW5GxaddhMWtmqqHD3OsyUK8N0LdlUtFtgBT2_WHoNzAY1nfWgfns9dm9tnUzbSB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgt
    phhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epiigrkhgrrhhihigrhhgrlhhiuddttdesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:F8sSau-Npp9YexbapGq9pVoB_O71ZST7mGCac4iTMuUvTOBXvnvKCg>
    <xmx:F8sSapVYQzl3pNMkclE5pNUuqlAEVQXlHk4MzFIMQJmDa2MFWVqamw>
    <xmx:F8sSaqBLQNSqnVA-rIy4kFLdypajWfJTu26ivGSHSGlW-Hggk0QDRA>
    <xmx:F8sSamHv2GML3xqR1z8-uBwTxynfPQqKWBM9Nkz_iW0a2VxWKf7B4w>
    <xmx:F8sSamxRqB27jMciadXXUmdRM-aOzUfFcVVWK2eeorINbqrDhmcS4wjq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 05:55:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Siddharth Asthana <siddharthasthana31@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Zakariyah Ali
 <zakariyahali100@gmail.com>
Subject: Re: [PATCH 0/2] [GSoC Patch] t2000: modernize path checks to use
 helper functions
In-Reply-To: <pull.2256.git.git.1779534462.gitgitgadget@gmail.com> (Zakariyah
	Ali via GitGitGadget's message of "Sat, 23 May 2026 11:07:40 +0000")
References: <pull.2256.git.git.1779534462.gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 18:55:33 +0900
Message-ID: <xmqqldd9i12i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is my GSoC microproject submission modernizing test path checks in
> t/t2000-conflict-when-checking-files-out.sh.

I do not quite get where you intend to fit these two patches.

> base-commit: 60f07c4f5c5f81c8a994d9e06b31a4a3a1679864

This is fairly old, v2.54.0-rc2~9.

But the thing is, your earlier clean-up to this t2000 script
4a9e0972 (t2000: consolidate second scenario into a single test
block, 2026-04-29) was queued on za/t2000-modernise-more was merged
to 'master' at b5d94909 (Merge branch 'za/t2000-modernise-more',
2026-05-21).  But what is most curious about these two patches is
that the [PATCH 1/2] starts like so:

    From: Zakariyah Ali <zakariyahali100@gmail.com>

    Now that the test script has been modernised, consolidate the eight
    separate test_expect_success blocks ...

I take that to be a reference to your previous effort in za/t2000-modernise-more
topic.  But these two patches are changing the code as if that did
not even exist.

If the za/t2000-modernise-more topic were still not merged to
'next', sending in replacement patches works just fine. but a new
patch that ignores anything that have already been merged to 'next'
or 'master' is counter-productive.



> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2256%2Falibaba0010%2Fmodernize-test-path-checking-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2256/alibaba0010/modernize-test-path-checking-v1
> Pull-Request: https://github.com/git/git/pull/2256
