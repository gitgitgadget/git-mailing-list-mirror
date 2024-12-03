Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB461AE00E
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268300; cv=none; b=u3ylt2PnbfMtXDEWgtBtnocL5lqCIg/UJ7SjjwA1X6EjYf6o6OMxdPWPUq0fuBFNQyu6zru+xL6xkHVUrNzUTUCRHYPb9hQvxv1bhMcPUa24y8QSv8UP0LExrfwfKHgKgv7PHPInCfqUYyFzOylMSCrPKR6n9j72HeXYXj6wEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268300; c=relaxed/simple;
	bh=ciZA9tkCw1VIybzdjVLM5Pb7Che5kHr3e8ErvgBkId4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hc8qxZJFIGwa5DhTmHchWcj5PPPKq7EK0rjbzM4rnBehq82yS2JxZD2hTY4nn+ltb/I+JKC2xKwd759BOgGZFFrneHj8ZcW+4yRxfkHqqpp7M+pEGkrDu5GULzrpTCw6rbc89oQtxyu90jm1/amukNHz9wRcawzT2zFWqKxhpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4E+efwa5; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4E+efwa5"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 298FB2540150;
	Tue,  3 Dec 2024 18:24:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 03 Dec 2024 18:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733268298; x=1733354698; bh=Oo8maGW0gKOO5DL/XRU7jsPvCu0eNMQIJDI
	GEKfAFfU=; b=4E+efwa5FbwJHNzTCp7ct4X9U0+N9Jj1AZuz7M19FrPJAD6d9eg
	COptwEroKuQOGhbMbl1lznK9zO9NI7B5BhLjUaaSiD6jVb9lwUawM4D05nQGW3Ei
	XZ2Cum8QaQtdjfGz5aLqYPVcnGMA1uJdXjM3qIgWUt7ilaMiLvWQf+pJg5TxKzQQ
	yYL8JQrPJdoIT+8xlMy9NSHQB066E7toFpcQC6Vw5Uh0gwGpKe/44ZfvbdbISIoT
	JpTgu3mlLBCb5irZXrKL0nOBLgLry8E/AupHNUKfsqy2oCBU0pMaMotOEwJdhJTJ
	SyWorubC4w6jFSgb5E2a8wolirEmpJ/jytw==
X-ME-Sender: <xms:SZNPZ1cnsrusSpJpzGs6ylli0k4SAPSffOy9atvQbevUim4Gv-UwPw>
    <xme:SZNPZzMGXficytjCYwv3HOUQfIDV9c2zxNRNQnWf9GYcYVqiS1alzH91fotkq08he
    -DZfjINhJAu5rSiuw>
X-ME-Received: <xmr:SZNPZ-jNkTsWTxIt5xtx-85qviDA52RBLFRnLWvUjbykpvg1-ir6GKvKE2si8gAIyB-qdQxjOgEx8vjI-Q3E3WozAz97oS47b-ktnzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghikhhophhonhgvnh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SZNPZ--H1qKzfnw_3wy7_ZfFTurZ_Q1Qv97CrwIl18A2JL-6JTjR6w>
    <xmx:SZNPZxtfEOLBr7X3F5ZeTbubBoDKMLN4rnvl3XwcSJ6KknsKp0g31A>
    <xmx:SZNPZ9FcNY5rxKMGbQnECZsZhwe4odNjFpvS8Hg02zhf63jHvP0grA>
    <xmx:SZNPZ4PcZb-cvDjUCYIwK2hkg0pZbsCrX5xxBCZEj2fXBA6Uzzc0eg>
    <xmx:SpNPZ7JY94AOfmvKngcr99YoF0GMLEnj5-wfyErNThGFNSbvqYEeMPcV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 18:24:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kai Koponen <kaikoponen@google.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] doc: mention rev-list --ancestry-path restrictions
In-Reply-To: <CADYQcGrD5KtM1sZQbccAtDaLmUXD8Gxv_nUWmapjfZm=TMq=Jw@mail.gmail.com>
	(Kai Koponen's message of "Tue, 3 Dec 2024 12:14:34 -0500")
References: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
	<CABPp-BE1C2izp1a0Xm8_0KU+kas8XKejDyix+AzXqbCOeVp2Dg@mail.gmail.com>
	<CADYQcGpyTL18N2t8t-HwafB8VEVbBt452fsE0yMBvRvZd1mbVw@mail.gmail.com>
	<xmqqfrn5h8zj.fsf@gitster.g>
	<CADYQcGrD5KtM1sZQbccAtDaLmUXD8Gxv_nUWmapjfZm=TMq=Jw@mail.gmail.com>
Date: Wed, 04 Dec 2024 08:24:56 +0900
Message-ID: <xmqqldww9won.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kai Koponen <kaikoponen@google.com> writes:

> The rev-list documentation doesn't mention that the given
> commit must be in the specified commit range, leading
> to unexpected results.
>
> Signed-off-by: Kai Koponen <kaikopone@google.com>
> ---
>  Documentation/rev-list-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/rev-list-options.txt
> b/Documentation/rev-list-options.txt
> index 00ccf68744..f0a46f9da5 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -412,7 +412,7 @@ Default mode::
>
>  --ancestry-path[=<commit>]::
>   When given a range of commits to display (e.g. 'commit1..commit2'
> - or 'commit2 {caret}commit1'), only display commits in that range
> + or 'commit2 {caret}commit1'), and a commit <commit> in that range,
> only display commits in that range
>   that are ancestors of <commit>, descendants of <commit>, or
>   <commit> itself.  If no commit is specified, use 'commit1' (the
>   excluded part of the range) as <commit>.  Can be passed multiple

Thanks for accomodating my pickyness ;-)  This version reads very
well.

Will queue.

