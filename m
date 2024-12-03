Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF321304BA
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196223; cv=none; b=AdRgIcPjtZr46MA4af2tXe+5ZVb46HR+U+3OBhgC5CVOgFcKgOfwrCaFw5BhuOlsdP74Z3WdC8Je1FROK6C3XwHJgf2k1uz9brVszpyDgzTkiAPKGj+NaMkd0smckiyHKJhNPVC0WvUnFj7h1RubxV0KZO7F2IdRuf8sJawVnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196223; c=relaxed/simple;
	bh=Y9FzadFXDbnbm3+hD6OKMUdqSrhT2f6wn1FWO15lQTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dyW0oSisQGIj8v8iLku/xlpfDzGp4NMoXGxiteJ1TtnSVuNoM5SA4iCvzSL2YmdgKPUo1RYzmzXwedEPiJZwXm/9hTC3VmeDaWvyU8zqj4Fm+EzlWeribegdDIkxSBUUQI+q7CSU+vV4oyf35JAIMbatG6GKCtWPBYoQVNFfAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G20kru9m; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G20kru9m"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BF3A311400AF;
	Mon,  2 Dec 2024 22:23:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Dec 2024 22:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733196220; x=1733282620; bh=34DW5oDjE+cGkOfYfejN9rcVw52OmhRRByl
	caZEYKJ8=; b=G20kru9mgRv0TDMAEQKPSuNdtxSgqVrYvCei/XvqukY3jYmXwuh
	mSeeptKncouTgpbVnUIpQfJ1g0/d2qH2D9bFqYMhseb0QAwt38CYvFE1ryvlSQap
	ARKRlaKOeCcYZO9C6+HZ33Xe6ZxgpPGHkyuGNeyVAVZjCeGBW/6l05TrHkNGzYD6
	LIYHvAjDq2J5fRN+K/DDYlwugJ8wewKNjPh6a3wa/zU/nE4Z2giNkltNLZ0xEhmQ
	840hsiiTZFRekiRLKsZp3gg7tXGejhWxCcGzNnIkUEDsZLNkGLZf+UtTt2zI7Fd1
	jq5ldhdAtNVU+8QUEA01n2/LtIoJi8pcGww==
X-ME-Sender: <xms:vHlOZy0s3uROrCNyuMaiF42EysSEWtPol6wYkF5h3Im3E3l6BjW-9Q>
    <xme:vHlOZ1FZuxU1THgyd5Ibf_eQjAVI0vS__fu280qTk0HwlRUz-Z1fYw0Wz_vdH7Mf5
    bwZgwdggGssxwiV0A>
X-ME-Received: <xmr:vHlOZ64lEB_9tQpss06L6Oc7G1wekGkO34jauyLlfkSB02MhOfj72ItQqJ2eprVhiy6j7-9dGvhRV2yxa8wEz2Zo0idm4H_pkn0nFnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgoh
    hoghhlvgdrtghomh
X-ME-Proxy: <xmx:vHlOZz3LBaHhKfWDjFpc431-JKkD2V7Fw8H4pFnWyHg0zhvsg4GZBw>
    <xmx:vHlOZ1EbkEJJQxk2hzAylgBTSafUSf3XNaIvQSIXtimp9GEDyJu37g>
    <xmx:vHlOZ88Deb1OC6m1a2R1BnnfXYKtfovHOSNgi_cpRsJVS5RXLU77pg>
    <xmx:vHlOZ6kqZN2YbSnnSJLOCfnI2-rzYAtiA1x0Z-Wdv3RbgjnY8VTBxQ>
    <xmx:vHlOZ0-oI6bESBowITzwWAHUtVrtWcGHSEPkLn9-pUtHGoKtgg_taROO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 22:23:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  jonathantanmy@google.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/8] pack-objects: Create an alternative name hash
 algorithm (recreated)
In-Reply-To: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Mon, 02 Dec 2024 23:21:14
	+0000")
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
Date: Tue, 03 Dec 2024 12:23:38 +0900
Message-ID: <xmqq1pypfo05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series creates a mechanism to select alternative name hashes using a
> new --name-hash-version=<n> option. The versions are:
>
>  1. Version 1 is the default name hash that already exists. This option
>     focuses on the final bytes of the path to maximize locality for
>     cross-path deltas.
>
>  2. Version 2 is the new path-component hash function suggested by Jonathan
>     Tan in the previous version (with some modifications). This hash
>     function essentially computes the v1 name hash of each path component
>     and then overlays those hashes with a shift to make the parent
>     directories contribute less to the final hash, but enough to break many
>     collisions that exist in v1.
>
>  3. Version 3 is the hash function that I submitted under the
>     --full-name-hash feature in the previous versions. This uses a
>     pseudorandom hash procedure to minimize collisions but at the expense of
>     losing on locality. This version is implemented in the final patch of
>     the series mostly for comparison purposes, as it is unlikely to be
>     selected as a valuable hash function over v2. The final patch could be
>     omitted from the merged version.
>
> See the patches themselves for detailed results in the p5313-pack-objects.sh
> performance test and the p5314-name-hash.sh test that demonstrates how many
> collisions occur with each hash function.

These do not sound like versions but more like variants to me,
especially if one is expected to perform better than another in some
cases and worse in some other cases.  Is it expected that JTan's hash
to perform better than the original and current hash in almost all
cases (I would not be surprised at all if that were the case)?

> In general, the v2 name hash function gets very close to the compression
> results of v3 in the full repack case, even in the repositories that feature
> many name hash collisions. These benefits come as well without downsides to
> other kinds of packfiles, including small pushed packs, larger incremental
> fetch packs, and shallow clones.

Nice.

> As we can see, v2 nearly reaches the effectiveness of v3 (and outperforms it
> once!) but there is still a significant change between the
> --name-hash-version feature and the --path-walk feature.
>
> The main reason we are considering this --name-hash-version feature is that
> it has the least amount of stretch required in order for it to be integrated
> with reachability bitmaps, required for server environments. In fact, the
> change in this version to use a numerical version makes it more obvious how
> to connect the version number to a value in the .bitmap file format. Tests
> are added to guarantee that the hash functions preserve their behavior over
> time, since data files depend on that.

Yeah, that aspect certainly is an attractive one.  We should be able
to teach the bitmap file to say which name-hash function is in use
and all the pack data reuse logic we have should be reusable.

