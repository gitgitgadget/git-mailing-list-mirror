Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75C25745
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187909; cv=none; b=XT+uMarAgBoxqKwLvgTi3pve0LP99VWNVHw4nQLlH+Xn+cTAztffNXZ5Pn//8OmGPG49Jz3uE8u6dueGgvAQMQEJfko3lpNtNYq9cVtsPbiMTxxqNCqDCnin5zBQK0y7ggAG1TdMgkFcrqcDflbuX3DGUtG+Co1grwlz8Aeyobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187909; c=relaxed/simple;
	bh=KPVz+HBoObbnKyVDbI9qGaQta0GeaiP0owYKiNnIRdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bFa9noQV7R5mNYyudurNuRU4AezXAtjl2KIp+EETKpHOKKbZlS6wMVcwOgLGwnzHA2aMCKmaD5roHfzAO582SXkLkvg3zmI9hF7rCfBvJ1x4e41UZzWPG5fjSJo2fzQzo7xrRDY7hPMB6rFU+/CpiBU9GHiQ7fHSeboN8uArZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6FdWTLk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6FdWTLk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6CDE25401EC;
	Mon,  2 Dec 2024 20:05:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 02 Dec 2024 20:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733187906; x=1733274306; bh=cvREcR6tQCXxtO8rCjVXwdkxCCUALf1d5EP
	3j+cKtzg=; b=E6FdWTLk03xlsF0y0OP/hO6l5q8HDMGXMQYXTvN4dhe5F6p2iL3
	hVkK/+E7K8oWCTWxcgXvuDCQ3HMOwFTGFtRBAum/croQrdK6NlbGtQ/UWVm3ntBa
	46UDVD3TlgNkD6M8sqQGhYnJJWi5kFsiOzOAj96br6vpBhNp6liRvEqHePq0r9Ug
	YQdvldI7f5DRyRqoblcZyHp2S2IlWOg69pj5LS3htv7FWKyXk6IRuY20tPo7v8W+
	qB5vBqkEMB9ZMF0JUK9/uxigg0ow1EgH7JzvaSpkR4OwleYHDiJ611yHsRihW/vg
	xRYZmEdG0rYAC7kStlrPIN3kYCfVLcNu02w==
X-ME-Sender: <xms:QllOZ8B4fopYIhVi5OieaY2SPBbeB7unNjtLniYy_bcX0GMW_lhriw>
    <xme:QllOZ-gFTLFqOxwtOv8-9qO7Mz90zoyZqBVWSYyWlBVq7LN7bOHe6I-7Wf-FEjmkk
    mV2Z_AIAtltCCW_tw>
X-ME-Received: <xmr:QllOZ_lL7WNuTPf9qKPQxHmnc4YHBYnW3gYXpZfpm-B4IZPm49u1DfPAO-gsvSYdm9nxV1YxY7bIMRpbQl1Lpm15qFkN1YgqaO8mriI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghikhhophhonhgvnh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QllOZyx7uvrSWy9VhCo2KQEiEHjGaDrdOuy1oGhvKNyZgWOVTHGWHw>
    <xmx:QllOZxS-4zwcEhvQwlP2J8rPYrPxy5XbG4GAqYZHh06ihzoBhVKz6g>
    <xmx:QllOZ9aCFJ22fD-vMuydGrerX35NIlCDJ-bKFNfWt5TnuHt0fesi5g>
    <xmx:QllOZ6SKLfPEip30ERUtW3wYoC1-M2I8NFn__fBCtyhaRd3oF5vfTQ>
    <xmx:QllOZ_NJoNzpRKSgYk8NesmcYx9Wq3QSX5Jh6s6hUth83dwSzWvmOvCL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 20:05:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kai Koponen <kaikoponen@google.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: rev-list --ancestry-path with arg - bug or undocumented
 requirement
In-Reply-To: <CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
	(Kai Koponen's message of "Mon, 2 Dec 2024 14:45:17 -0500")
References: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
	<CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
	<CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
Date: Tue, 03 Dec 2024 10:05:04 +0900
Message-ID: <xmqqfrn5h8zj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kai Koponen <kaikoponen@google.com> writes:

> From 447a2367f8d3318e69adccc1b011b0d04792e438 Mon Sep 17 00:00:00 2001

Do not include this line.

It is not a part of message, but merely added as a mark that a new
message starts here in case there are two or more patch e-mail
messages in a file.  Since you are sending one patch per one e-mail
message, you do not want it.

> From: Kai Koponen <kaikoponen@google.com>

Let your MUA have it on the From: header of your message; you do not
want this line when your MUA is configured correctly (and yours is;
we see From: header saying the same thing).

> Date: Mon, 2 Dec 2024 19:32:25 +0000

You do not want this, either.  Your MUA records on Date: header the
time general public saw this change for the first time.

> Subject: [PATCH] doc: mention rev-list --ancestry-path restrictions

Put this in the e-mail header.  We add [PATCH] for a very good reason:
make it easier to find patches in the mailing list traffic.

>

Here is where you "sell" your changes by explaining why we are
making this change (like "existing text allows misinterpretation
that makes it sound like doing this and that are possible, which is
not true").  Please do not leave it empty.

> Signed-off-by: Kai Koponen <kaikopone@google.com>
> ---
>  Documentation/rev-list-options.txt | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt
> b/Documentation/rev-list-options.txt
> index 00ccf68744..1c678294af 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -412,12 +412,13 @@ Default mode::
>
>  --ancestry-path[=<commit>]::
>   When given a range of commits to display (e.g. 'commit1..commit2'
> - or 'commit2 {caret}commit1'), only display commits in that range
> - that are ancestors of <commit>, descendants of <commit>, or
> - <commit> itself.  If no commit is specified, use 'commit1' (the
> - excluded part of the range) as <commit>.  Can be passed multiple
> - times; if so, a commit is included if it is any of the commits
> - given or if it is an ancestor or descendant of one of them.
> + or 'commit2 {caret}commit1'), and a commit <commit> in that range,
> + only display commits in that range that are ancestors of <commit>,
> + descendants of <commit>, or <commit> itself. If no commit is
> + specified, use 'commit1' (the excluded part of the range) as
> + <commit>.  Can be passed multiple times; if so, a commit is
> + included if it is any of the commits given or if it is an ancestor
> + or descendant of one of them.

As these files in Documentation/ are input to formatting programs,
please do not reflow the text unnecessarily so that what you changed
stand out, instead of forcing reviewers to go word-by-word to sift
through the changes to see what got really changed.

Thanks.
