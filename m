Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917033A8F7
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766158; cv=none; b=m5m1rZFeqxcLqhj5hpijEUbMVNUT4KNCDIb5b+wLDuZJ+/LNYHOagAOwk9/SwLiRlKJmvwZPsQBGly7alFgJ/iurPreXF1XqT44y5tzI7mbbWIPGScqJB41oIadpKAvK9fBy23zw+RdJnHlQxHj1xx5+1PVNI48DanX6PfcKfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766158; c=relaxed/simple;
	bh=1sg5KNJOfBlNbkaXFZAJ+AQUCLARQF5HgGeYdDizsZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FhbcDct8yVrN2cmvB6/SSTYGgf7sV3l2Uk8KZEwmgUMovkIDJBqDnr5lxToCGN4kri3doGV93EGmU9fu7vjbZkSPkMNqFTpXIGhJBdUP+DWlBJKi4BcrGAnMdRye8iIXkODG7Ra0kQrTLtEGHvOIxUAOpD/Ad3dAK7z3nO4tlEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gc9EVxGg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DYvT3Tp5; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gc9EVxGg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DYvT3Tp5"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id A12341D00072;
	Thu,  9 Apr 2026 16:22:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 09 Apr 2026 16:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775766156; x=1775852556; bh=2rDezddaYJ
	TPanmwKE/Pql7OU1CsUHv7Cz4QLfHpZV0=; b=gc9EVxGgxmDUhO6dJqXJcMnYd5
	mhR371z8k/Om+KZ3ZTLAmxKbxrG2KEki891mMsl9n8qjuI2VKfM+ZF3MxVEGy3m4
	iOSH3OG9wz0bEyWU1gPJ8Fup1EvTm++dOhv5VV0C8GpU0YlYdIx8OHPPtrGroCz3
	mFIKnywWW336wPOkZB61TwScIp4qdMfaZRnM6EqGRKNj63rN9AYrGAFdV+W01g1c
	KkG4mir18ii3YKmU8Vbx2cyA+v323hD61sil8M61uLu0+hoPBNR8X+eDa+/b9fmU
	dbXm/2exQrbmUku2G2c2XMTjgi2fMnVLBjKjqDCcSj1rp4LkmPIdiBILZc6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775766156; x=1775852556; bh=2rDezddaYJTPanmwKE/Pql7OU1CsUHv7Cz4
	QLfHpZV0=; b=DYvT3Tp52UurhcwjSBxSSSUrlpInUPNI+iruxfEEuygdqZ8IYcA
	vneQ0U7ZB1jYz/1a5Nl18Fo5H1DPwLnqt1Nnb/EuXOU4fv8ub1x/3x78OiGSJuqZ
	bLFSk0CEeNyXn3Yh4PgTSHyBkUboN3HClrfH6Q9jWZNyra6zOx6R8Hei59wO2Wy5
	AnX6DlEiDHTDEgRVnid7h4PxOo7Yyp1/vWBzizZq+WtvvxzVEuDzDIpcb1tzEO2n
	NuMqHPb9KQaO/ga/qFfPKUAjLZZcmsd0cPJq2Yeit7u+BfoD7KWmVnZmu9Pw1KTE
	ofyba6axqUFu6oLXvEJbKCNznYUm49xK1nA==
X-ME-Sender: <xms:jArYacZixYxerGP_mi8rZ-yZ4z1wcani-IZ68TJLm0zNR8o7TXu0MQ>
    <xme:jArYabEzwgAw5Hi2ijCQzTP-lJPOrzdBH8E8EiIkb6cHCm6828wbaNKvrPGvlzKBK
    wXDmiR6Cv-SuxR0WkuQlC1GFe9ho0CAIcYVg3pYMBC608bFs84BdA>
X-ME-Received: <xmr:jArYaQxjEDukvRfAt-yg1_ju_aHSg-OTsd0bU_BszrsP5iFyjRruCEPQ4SEDgA5Iv4rF8aPm5tZnjgj0HwDsjb7u9gKbQheadg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhgvshhh
    ihhguhhrghgrohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpth
    htohepqhhuvghnthhinhdrsggvrhhnvghtsegslhhuvgifihhnrdgthhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jArYadlj9HlYsBgkFZfoeAvU4qlHz6gSwzSB2feNH5kxYJZbWFKD-g>
    <xmx:jArYaZlIRR_hP0OHdAyakKqmdPV5YtdiqUrMAP8fO5_rJBWiFKlFuw>
    <xmx:jArYafx99bkPNdRW1NzSqbzgy5FvwwsPFmgBeE_oXrMGVgeslKjtDA>
    <xmx:jArYaeqCD3fs3dEMJBTi5FfD9zph5qVCh4p7N7GKZ5zMNL_RYWn81A>
    <xmx:jArYab6ACSBWfUhnPfvqhVe4zp659MdAwRNQB0k3uoLjhyjtfUeB4Wyk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 16:22:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com,  mroik@delayed.space,
  quentin.bernet@bluewin.ch
Subject: Re: [PATCH v3] stash: infer "push" when push-specific options are
 given
In-Reply-To: <20260405110953.3316-1-deveshigurgaon@gmail.com> (Deveshi
	Dwivedi's message of "Sun, 5 Apr 2026 11:09:53 +0000")
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
	<20260405110953.3316-1-deveshigurgaon@gmail.com>
Date: Thu, 09 Apr 2026 13:22:34 -0700
Message-ID: <xmqqecknsx2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> +test_expect_success 'assume push when options imply push' '
> +	git reset --hard &&
> +	echo changed >file &&
> +	git add file &&
> +	git stash -m "implied push" file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --staged file &&
> +	git stash pop &&
> +
> +	git add file &&
> +	git stash --keep-index file &&
> +	git stash pop &&
> +
> +	echo untracked >untracked-file &&
> +	git stash --include-untracked untracked-file &&
> +	test_path_is_missing untracked-file &&

A comment on these three lines.

> +	git stash pop &&
> +	rm -f untracked-file &&
> +	git reset --hard
> +'
> +

I suspect that they are meant to be "clean-up after we are done with
the test, to avoid interfering with the next test", but if so,
"clean-up at the very end" is not a very effective strategy to do
so.  Imagine that one of the previous steps fails, breaking all
later commands in the &&- cascade.  Sitting at the very end, your
clean-up sequence will not run.  Unless the tester is running this
test script with the "-i" option, the test will move on to the next
piece.  Installing clean-up handler with test_when_finished may be
a cleaner approach.

	test_expect_success 'do this test' '
		test_when_finished "git stash clear; git reset --hard" &&
		git reset --hard &&
		... do all the dirty things in the working tree ...

		test_when_finished "rm -f untracked-file" &&
                echo untracked >untracked-file &&
                git stash --include-untracked untracked-file &&
		test_path_is_missing untracked-file
	'

You can use more than one test_when_finished in a single test.  

It is often done to add an upfront blunt hammer at the beginning to
do a clean-up without worrying too much about where exactly in the
command sequence a breakage may happen (e.g., we may fail before we
run our first "git add", or "git stash", and "git reset --hard" or
"git stash clear" may be an unnecessary no-op, but we do not worry
too much about the clean-up step doing potentially unnecessary
things.

Or you would set up a clean-up handler immediately before you create
a thing that you want to make sure you clean up.  If the command
sequence fails before you echo the string into untracked-file to
create it, there is no point preparing to remove it when you are
done.

Both approaches are commmonly used.

>  test_expect_success 'stash --invalid-option' '
>  	echo bar5 >file &&
>  	echo bar6 >file2 &&
>
> base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
