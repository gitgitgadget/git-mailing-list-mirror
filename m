Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94F155308
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 02:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796672; cv=none; b=di28zhPJ3Tg6mXQ/07HMqi9v4EruOHwfNUEIedKkBQ5UFhHq37vxhUTGSrK3DUf/I54yochEXXE3/jX4zcrrpq5okxpnHZ56260FHkaGm/KKbo5cyZBUZcMPWbDM8eV+n3biU68afqBOpO25pxVCMHfKQ2erEqvn0UJafl/Ab3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796672; c=relaxed/simple;
	bh=2WXgR9mLDagOToC+rAeohFtuhdCIG0/9ANV6SH+uaIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U3q/bFJmxolWxKzupy4UvqaT85lpnV3hFFidFW2N2zrfWgNNmrINaJ11/FgaTgElRr7FWuuP/SIvTwFKlbjk8HpsdxN/FEI4iaUJkaaOv503QJmPGATqXgHPBkxwgmnlnwuHdKXquo5O1OzZRF2ErWT84RnAbHIwQa36bt3Jdes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sx5cToJ5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sx5cToJ5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D425D114019B;
	Mon,  9 Dec 2024 21:11:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 09 Dec 2024 21:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733796668; x=1733883068; bh=2WXgR9mLDagOToC+rAeohFtuhdCIG0/9ANV
	6SH+uaIA=; b=Sx5cToJ5OIHpWCgxObj5Oo73gIUAHiMCa70O7ML1W09qxDm12M1
	QMZb++2KyF5WBp9sHVjuL8n9LXkJAso2cJaxO/BNRtIZagVu2DnzIvPfV9B37zx9
	wteLyDTSAag8tm2pMRqwqdl6hjnq71N2/2hI/c7TxA+pknx/Qa+4eOg7U1MyL6MM
	RXngMXKsZBu8BA7DXOdvp58DWHKy7utsDG8kuDuSdi3uxS3gJ1ck3tugBKc7WreA
	yfktvucP2ZcWU0FZ0t0F0yh6URK5JhPZ3aiJsD43GAfCPEb0ozmjawiizgDxCk5Y
	HMTSPYGiV+wJrxJQeARbpXAsxcahO7SNtGA==
X-ME-Sender: <xms:O6NXZzh6PQ7ouSPMgKCru7vpc7j06alcLSMRNEKFEdSinqRySJuSzw>
    <xme:O6NXZwB2kc_vDuAMAImVyi2_-uhdkH5AMkNpiPiTEShODZ4MEX-yrYHaS5sjmnhCF
    ZUw0R47zdam2I2NRA>
X-ME-Received: <xmr:O6NXZzGWU9DSncnOrWtwxJSpzcrNvdOSumvvYT_f2Ovpeikj-fMLKVplsIAkwi5F4Y3MZrFiBB-ed73ohH5l7tkw6yFuchxAsO66SBo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:O6NXZwRllgSKuk-ZuBC0B2Wb35LcKOgEkEnPzxZ02P14ZTD8f-2ZZw>
    <xmx:O6NXZwxfvuZOFqgksW525D6fYBnP4juhlgf0P5n9UopVFTebDYk18Q>
    <xmx:O6NXZ27cadBXWL3du0PF0LQEpmybZzIgGKXa0jWv9GYInjtAmJOiBw>
    <xmx:O6NXZ1xAI-UxxFGEpBiB_qww1l8CRDZukwE4JzRtu1ztUPC4xcF3RA>
    <xmx:PKNXZ88hHLFhrOL_RusTKbI0OGZUTDzXk7C5zQ6zp702JqMWdBXdEX8b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 21:11:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bundle: remove unneeded code
In-Reply-To: <20241209-fix-bundle-create-race-v1-1-e6513bdcbf8a@iotcl.com>
	(Toon Claes's message of "Mon, 09 Dec 2024 11:41:29 +0100")
References: <20241209-fix-bundle-create-race-v1-1-e6513bdcbf8a@iotcl.com>
Date: Tue, 10 Dec 2024 11:11:06 +0900
Message-ID: <xmqqzfl4l22t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> The changes in commit c06793a4ed (allow git-bundle to create bottomless
> bundle, 2007-08-08) ensure annotated tags are properly preserved when
> creating a bundle using a revision range operation.
>
> At the time the range notation would peel the ends to their
> corresponding commit, meaning ref v2.0 would point to the v2.0^0 commit.
> So the above workaround was introduced. This code looks up the ref
> before it's written to the bundle, and if the ref doesn't point to the
> object we expect (for tags this would be a tag object), we skip the ref
> from the bundle. Instead, when the ref is a tag that's the positive end
> of the range (e.g. v2.0 from the range "v1.0..v2.0"), then that ref is
> written to the bundle instead.
>
> Later, in 895c5ba3c1 (revision: do not peel tags used in range notation,
> 2013-09-19), the behavior of parsing ranges was changed and the problem
> was fixed at the cause. But the workaround in bundle.c was not reverted.
>
> Now it seems this workaround can cause a race condition. git-bundle(1)
> uses setup_revisions() to parse the input into `struct rev_info`. Later,
> in write_bundle_refs(), it uses this info to write refs to the bundle.
> As mentioned at this point each ref is looked up again and checked
> whether it points to the object we expect. If not, the ref is not
> written to the bundle. But, when creating a bundle in a heavy traffic
> repository (a repo with many references, and frequent ref updates) it's
> possible a branch ref was updated between setup_revisions() and
> write_bundle_refs() and thus the extra check causes the ref to be
> skipped.
>
> The workaround was originally added to deal with tags, but the code path
> also gets hit by non-tag refs, causing this race condition. Because it's
> no longer needed, remove it and fix the possible race condition.

It is always a pleasure to read a patch based on the idea to
directly target a nicely analyzed "root cause".

Thanks.
