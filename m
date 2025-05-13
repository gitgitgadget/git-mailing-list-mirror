Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8423328DB70
	for <git@vger.kernel.org>; Tue, 13 May 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142667; cv=none; b=Q/us75Y8ziQQSF7891EmgcahBH5byd5L/CuSDggJgo4NbmDJba2tVR76909OHYSgo7//SkmfgOvpoWLvLeaF3YgRxFGz7d0Qeu5lXNsz/Bw2EwFgn/jTtWroyFWF8vPiRMhGoQIJkjwMO+RMbQOosykNT8Feldai4e2xfccoj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142667; c=relaxed/simple;
	bh=0dBJB33eQDaKo75MYegEOl78sDXc/wulDHc7VkpUmL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kp3V4hBDuny3tV5t+fwLyXb9VBSS7vukogE4TjI5PZcaUobX38UnT/YdMYxSoCCdiod2OnDZy+VNC7u3iw+1VIFiGP2QazAZI11bXz3Q7lewwyfNQnK6+UUnBISvF/KletIPe11+vKh1J8vbBT/7wGh+1KKFRjNTIoyK/YxkBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j3zQC2Ff; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BK27Jytj; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j3zQC2Ff";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BK27Jytj"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F038254011A;
	Tue, 13 May 2025 09:24:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 13 May 2025 09:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747142663; x=1747229063; bh=u7okuRsJL9
	P9b1eVosPEYjEYvRt6FCxKkZKKReUPKK4=; b=j3zQC2FfZLDy4+aBPaYdEHGNq5
	QE88/8XoZXApFtwa46sJankoXDUqOl+ZP0+wXPpLZLh3rwcecnmWKb4/aitZl12a
	aGHUGYSgFEn5fTA4RnAHO3aUNDhcPsPLHqxHs7DeMD4uFH2THTl0Uqqoh1ZYpSbj
	ho9IwU6TaXAXEvgJEOab4i1otmWBbGkiS5nA9leP1uXXrdpQAuZU4J/QFn+9hvrq
	zhTRRy1R95tCS1gaudVI3Ek8o/oySZqlojbYup4TRIkS5TWAWYjqTvzF2leFUf5n
	m0CRKpEpSyaU7kFELd/mVHWAAMJo4BodPADvLXxUlb7TIkf9BBMUTBC1yJaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747142663; x=1747229063; bh=u7okuRsJL9P9b1eVosPEYjEYvRt6FCxKkZK
	KReUPKK4=; b=BK27Jytjp129/LrLIIy7Nee+R7DcPVnqULUAa7rbZTN3OzVESOX
	d3jIGRqFLgyp06G+pdKc3Vh/JKPz4DinGCJ4lXPy6jojxLmz1281csFF2jBkZM/4
	igNVDI7NoDn/H/rWdRkh8a4WFPU4lpXN56kywis4wFcazAN/M/+HOWzJ6b/u/ZuO
	Ij7a4BSbkBKHEbkJLArcmi6FQ7HOplOrrMaBtHhQxyJbrF4a36v0LHaipGF6J0T5
	X7aEJZcHj9yIsFW3fSQjpQ10ac40M3U+GF5hoki9ITS1KXUmpeS8GLhaUi3zZvjR
	xnO8OhGPTC9e7AFi3biCgHEjsTVN5JzOrVg==
X-ME-Sender: <xms:B0gjaNOp0qNWX0_aTyi7rQVAN1CZr5yiqF-QVv7hvA-sF4Bm93Kb_A>
    <xme:B0gjaP_8v9XeLkjkROfHfsB8DS-DMFFfbWOvsZhyfXfX4pccc374bgFFSxXkMRP7n
    GuUUSh2c4lfcJpLPA>
X-ME-Received: <xmr:B0gjaMQqgNQhJIApyoi9Flir20RHM_dax929paGSkk8LX8NjGEZD6BusSFqmny-2l3m3nAH4EpxaKImuS8QX2ThwGu-0tllefxnPaNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:B0gjaJu5kUqftz9lHch-Q9xTnWISJ3sZ-BydILnFS5PFoAn8xMWN2A>
    <xmx:B0gjaFcN9W1wEtiJgYNr6L8EKuM_dse_LqvmMcsH_xFvPGU1ReRN_w>
    <xmx:B0gjaF10bTrdHBzgpnneGt_wgu55frp3eUiLGuD5HQgMHlkTOkPl5w>
    <xmx:B0gjaB-rf5VKPZ--5bcLa8r9mCFYV6_dsQF6LyaMHiv4eMQ2X7fEwg>
    <xmx:B0gjaIIo7xEoaP4Ed2L7yeHm1x3eISJySBm7q5xqFc3osH3ypaLxFedc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 09:24:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] merge-tree: add a new --dry-run flag
In-Reply-To: <1d18ab7feb877a4173ac55814177aefe88cee658.1747093322.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Mon, 12 May 2025
	23:42:02 +0000")
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
	<pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
	<1d18ab7feb877a4173ac55814177aefe88cee658.1747093322.git.gitgitgadget@gmail.com>
Date: Tue, 13 May 2025 06:24:21 -0700
Message-ID: <xmqqa57giqyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Git Forges may be interested in whether two branches can be merged while
> not being interested in what the resulting merge tree is nor which files
> conflicted.  For such cases, add a new --dry-run flag which
> will make use of the new mergeability_only flag added to merge-ort in
> the previous commit.  This option allows the merge machinery to, in the

The first three lines are almost identical to [1/2] here, modulo the
internal name still being mergeability-only while the external name
is now dry-run, which is perfectly fine as long as that is done
consistently.

> diff --git a/Documentation/git-merge-tree.adoc b/Documentation/git-merge-tree.adoc
> index cf0578f9b5e8..7dcc17806191 100644
> --- a/Documentation/git-merge-tree.adoc
> +++ b/Documentation/git-merge-tree.adoc
> @@ -65,6 +65,12 @@ OPTIONS
>  	default is to include these messages if there are merge
>  	conflicts, and to omit them otherwise.
>  
> +--mergeability-only::

But is this internal or external name?

> +	Disable all output from the program.  Useful when you are only
> +	interested in the exit status.  Allows merge-tree to exit
> +	early on the first conflict it finds, and allows it to avoid
> +	writing most objects created by merges.

OK.
