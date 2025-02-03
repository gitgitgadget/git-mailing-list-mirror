Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD6209663
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618689; cv=none; b=Q4OhcveAfy5iAXbT0nJGi2W9Z1q3kpD8P0uOQ2GPVDecx7zLJ0BWSNQ762KpTgaVu9hJKKdM8vqDS/Rhn0x+wfa8ky4b98oyWxSi+Fou91ffc1T3rlcqwuSDORuGTYNSC7uhwriVlO/RA2U+vmOVdkq5Mf9FrLi60CLRoNL/NHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618689; c=relaxed/simple;
	bh=HIAkvW1ewzhBI1KhBuKVJkNKjoNZQGD4jkNanT6B7nE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVRvi88qAuu+NyHhjfjQ8XKN31xkiJWTezRnEje4L1iKjoj5zrOSuzoa17A54YFeA1bRcBqn/PXu20dJhmO8mJImhKV2/7sRfOUbh0f08eGDMDWueli11HMicXqvVfLOuECFpVo6kBoDEONn0eIT0yU0graE66BzqFHOD6bh5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o5+iZrpO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gC+L1bKM; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o5+iZrpO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gC+L1bKM"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7EBC7114005D;
	Mon,  3 Feb 2025 16:38:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 03 Feb 2025 16:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738618686; x=1738705086; bh=S4DBNnPJUu
	OrByeV8LXh1uVVBXxRjwscPkBLoISb4Wk=; b=o5+iZrpOT5eBWUmQUUia63Od8+
	TznOoRoUtV5WbcdvMaAHi0naTInZMjkdLBRNCHzNCQr5YMdxRxa6ZWSTg11HQDv9
	2hunwVeVm7jS8UTTo4VGHhKqLIIaz1wy7iJ68q8x6NjmCW+yIWsw4Wx/N6JyMysb
	ChHAgLgRQ8ySp84/AVV/28PoC3WRTh/3CCjvDSnTW3bO0Jav2UcVnU+4J4RtmIFd
	GiJLPFP7vs5hQgKAw5Epc4OZN2kJDbZoZzE6SRuSnLejkr0bAQJyCOCVHe65cERE
	I0nH6i/lkKO4tUWZyiDqCVliAVKhWNYCpSokvMdezHA4JBZYipCDmOAP1qEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738618686; x=1738705086; bh=S4DBNnPJUuOrByeV8LXh1uVVBXxRjwscPkB
	LoISb4Wk=; b=gC+L1bKMmCcfUbFbFDmpCK17i7bOb3hx0aHeQqhq1e8c0Otm2xx
	yMHmD623eW8XXzvNRvAi922KmpH+OKwUDWnpOPRJMsQ5RLe0qrT24sMogCjakjQY
	NarYMH23ORD0lAx/nL8iFt8Gu/wST1+qF9ZpCjVZFDwmLTSyhQj3HuzXyTycG1MF
	RxlnYwpDDqOpTCKOATsM2mX+O/oOpokzy8xmMup0oINC9+m/3rTL31MmPzouuaqY
	u/+Mw92/Yn8ETfUCX55/51z7FMD3FLilUSj3o/cbLM2XRGRFecv7mcCLj9D2wuvQ
	sd2/seIb2PfCtFoB+kZwSnei779ppU/588A==
X-ME-Sender: <xms:PjehZ1NBkUlrkK6lm5B013FkkRPVNyjn_88sI8x0nQQQOdgnZ9VFmA>
    <xme:PjehZ39-A07mgF82EhiLo7kQs7xqnPClq8BYdFME7FtIQffLJO3k3dVGGoOMaQsN9
    YakG8Djaj9bHLkt9A>
X-ME-Received: <xmr:PjehZ0ROlxH1kglZNxp1fCRaZQoACB9r2nxsXSEfT5f5_KPglXA7gm-W8ynfEtndTbsBcKQTZIY_9y886cqqtEueARJ34v9_iW0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PjehZxvXUNERoFnZRDasUg1ZcS-nnz-E1B4fXDdkZTbxc-93CixOLw>
    <xmx:PjehZ9ec1bMvTtOwYR2QFyRr8NrQAjwprjEsr6N_RB0_1OLQlMr6LQ>
    <xmx:PjehZ92N9wUljyAPOHFIBuSqvLPeL0jqED3GJ3sArytb16d2e7t-3Q>
    <xmx:PjehZ5-GNdT_8F4Q4RHBDA5yjX8DAZgF5ZKVs_pihlQFGLxTufmjqw>
    <xmx:PjehZ2GNvq6hnoUpr7h6p4s4JNHfwju0ZWVRRpcBHYK1ODdKyYHE9YC4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 16:38:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  ps@pks.im
Subject: Re: What's cooking in git.git (Jan 2025, #09; Fri, 31)
In-Reply-To: <d8661675-1c08-4c7c-9198-be7eabf0ebee@gmail.com> (Derrick
	Stolee's message of "Mon, 3 Feb 2025 12:10:21 -0500")
References: <xmqq5xlu4bt6.fsf@gitster.g>
	<d8661675-1c08-4c7c-9198-be7eabf0ebee@gmail.com>
Date: Mon, 03 Feb 2025 13:38:04 -0800
Message-ID: <xmqqjza61zgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 1/31/25 9:51 PM, Junio C Hamano wrote:
>
>> * ds/backfill (2025-01-23) 6 commits
>>   - backfill: assume --sparse when sparse-checkout is enabled
>>   - backfill: add --sparse option
>>   - backfill: add --min-batch-size=<n> option
>>   - backfill: basic functionality and tests
>>   - backfill: add builtin boilerplate
>>   - Merge branch 'ds/path-walk-1' into ds/backfill
>>   Lazy-loading missing files in a blobless clone on demand is costly
>>   as it tends to be one-blob-at-a-time.  "git backfill" is introduced
>>   to help bulk-download necessary files beforehand.
>>   Expecting a reroll.
>>   cf. <Z4jeQSLmARruE5l3@pks.im>
>>   source: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
>
> I've updated this onto 'master' now that ds/path-walk-1 is merged. v3
> is imminent.
>
> It required a few updates that I'm sure you've been making within the
> merge in order to keep 'seen' building.

;-)

>> * ds/name-hash-tweaks (2025-01-27) 7 commits
>>   - pack-objects: prevent name hash version change
>>   - test-tool: add helper for name-hash values
>>   - p5313: add size comparison test
>>   - pack-objects: add GIT_TEST_NAME_HASH_VERSION
>>   - repack: add --name-hash-version option
>>   - pack-objects: add --name-hash-version option
>>   - pack-objects: create new name-hash function version
>>   "git pack-objects" and its wrapper "git repack" learned an option
>>   to use an alternative path-hash function to improve delta-base
>>   selection to produce a packfile with deeper history than window
>>   size.
>>   Will merge to 'next'?
>>   source: <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
> Since this is still marked with a question mark, I'll mention that
> the last version seems stable and has Taylor's review.

Indeed this has an Ack in <Z51DHdS8SStRGalX@nand.local>.  Let's
merge it down to 'next'.
