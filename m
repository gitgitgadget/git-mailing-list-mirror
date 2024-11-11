Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF5191
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731289965; cv=none; b=QHGA7MVS4wPmUv1UWDi3GJWe5zafhzD3LSFOLqvy3x4eq4SkX0MqAXxnUv78TdcI9iT4H+bqmbhQNdXAIobqDayGJ5/fQgmU2GLABGFJi40CxZGOzA2DuAs7nxAEB+Gv1sKm7evhCBbVZEFY0gwF5HoC74JHcpfCcIlMDRNNvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731289965; c=relaxed/simple;
	bh=FsX/yqHFTxPFWwCH/ZZOwzT5fxPreiDeSgqKYk/qcVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o17E0Cvm0XQ1TK7bPbYA2KZGwzy3LK/Y+xRGbNCr7g2YHseHcQ6nfxKJJz5DNtQZI6s0NfZk1TzzN1mpIM8nHm9+QPHLUdpzhwlHA+aZ+TqEZS9sazeh9raw3EGBk42GD6cubrNnwXGInRMSqg9A8yF48b1wUnF3JMNwdOZpxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fMCBLLoB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgjldY6Z; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fMCBLLoB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgjldY6Z"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DDA411140136;
	Sun, 10 Nov 2024 20:52:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 10 Nov 2024 20:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731289962; x=1731376362; bh=dHLdcRm2L5
	7MEPOmXU7pAVtXpViVlVyDV4cTC13sFMk=; b=fMCBLLoB1Qp3USfTQBZLWH6xQv
	UdZOVzyyw99XitG/StBXT5UCKtCmVo7dIPbHM/Eky0xjfw7v5ijdG/VBsmoW17fk
	KE7N3EZUiMpWD1O/M8TeKRLMANydjRWkuVQ9ZxsC7CNTUs+C7i6f+Nn46B+PXtiZ
	+fNyVurxlJwkv2AAMqrHjAggTTDLvIQ7uTvdkNzh9Lry9aHg1+tIBGUt1yOYeoCB
	Ir28lc+y4uPkMOe/WXotCxAdQKlujrRBTk8Lc1QMTmIM00clATvoyLcz3rDFCLCM
	GFWf6CEcopEe+nc3NJsE/qpPhkIoHofK3d0OVf/cVdPSq4OaFsgcq6R/kSBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731289962; x=1731376362; bh=dHLdcRm2L57MEPOmXU7pAVtXpViVlVyDV4c
	TC13sFMk=; b=GgjldY6ZmDZOpMO7PqpGYzgEE2PgPIOJUeC/QhI65341phZrdQa
	/HdVU5uTP3lruqz8OcvUPPgdJZ3ALoymVPS5CSi8S4EczG4NioERvJtiLcAlr6BF
	fXBRjW59Rn0NyUhIuICR9i8i8HpXPaCVIU1iw3u8F/+ixoGmH2QSZkzHexflWMk5
	Dt/hl/mvRHiM0932+H8gxAC4n30VGD2XCYp7Geogd9tigKn1H7j2dFB0rfRDvnVZ
	Qx3e+Gwca4Gr4L6hHA6KtzFRkX9qh73rRB3U85KCqz0YlGbDn8PlD20ebWt2A2aV
	WVUPuArK5JJr03mqjIpSTl4T+j9Bnclz1Tw==
X-ME-Sender: <xms:amMxZ3YOVeNxJA0nAmpuPvjKJm7WD_kkk6JvvqmomTjmGL4VpOKaEQ>
    <xme:amMxZ2ZI8yapSafHwhr3jPs51xEbFgDfxH73uygItmPWZWpudte2fH-R3Hk6YR3_-
    klKCcrERBzknWf_Yg>
X-ME-Received: <xmr:amMxZ5_PCVIAWd5XoDByzuY-hlOzmpO3RrVkmx9JOvFeLoO_bMwzxlBi6uvth8Q6QqlcS7p1KuMwe_kayx9Jv4CLrNfHlMK5gsDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:amMxZ9qsLUyxhaFRG8CjeCU5_tnIMjscObb4UlZp4Yo0Kpskm63kjQ>
    <xmx:amMxZyo5-hnk7lcZnW4HzbPUFWivUoGzl6spu3D3qGWB0BjZoTjSCg>
    <xmx:amMxZzSvhH5kD_3ii0LYFgq4ztqrA2xLmQ63gAgvWBY8HEfMP7QPJA>
    <xmx:amMxZ6ridCI50tWlp7peTYdZjCodMAe_nLpQNKn9M8SwFjjlhzDqMw>
    <xmx:amMxZzf9mttbF96nDadjZHHoEpUymqRPR40aLV_xz6Pm-B-BPWhBxzey>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 20:52:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] log: --remerge-diff needs to keep around commit parents
In-Reply-To: <CABPp-BHauuserYU8t5ybn+ghqRb-c85qwwjLWVe-e5EC8sVVxQ@mail.gmail.com>
	(Elijah Newren's message of "Fri, 8 Nov 2024 07:47:04 -0800")
References: <pull.1825.git.1731073435641.gitgitgadget@gmail.com>
	<CABPp-BHauuserYU8t5ybn+ghqRb-c85qwwjLWVe-e5EC8sVVxQ@mail.gmail.com>
Date: Mon, 11 Nov 2024 10:52:41 +0900
Message-ID: <xmqq1pzik046.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> -               if (!rev->reflog_info) {
>> +               if (!rev->reflog_info && !rev->remerge_diff) {
>>                         /*
>>                          * We may show a given commit multiple times when
>>                          * walking the reflogs.
>
> Should this comment be updated to reflect the expanded rationale for
> this block's purpose?

Ah, we probably should.  Especially if the newly discovered failure
mode is not due to having to show the same commit multiple times.

    During reflog walk, we may show the same commit more than once,
    so do not discard the parents.  There may be a merge commit that
    is descendent from the current commit, and in order to show it with
    remerge-diff enabled, we need its ancestry chain, including our
    parents, to compute the merge base.

or something?  It is still not clear to me in what scenario a merge
commit, in a forward traversal, is shown _after_ one of its ancestor
commit is shown (and due to the memory optimization, loses its
parents).

Thanks, both.

