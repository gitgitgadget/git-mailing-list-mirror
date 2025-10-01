Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787A26F2BD
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346553; cv=none; b=EpWxuFW2ldLLhKqNQ8EdRRF02b3zCDb53dHHYHEGoouIL5uwJGYlHayyAbBd4BqI3Sc+5ievTVUhKoYLFXmQU7nLmtnRDjA+pMMidRQs3hpb0T7S1X1o5aEtzTVy22Jsan5sE80ro02zjd9BdDYIbfjLwddirfOGYFGCo9xxsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346553; c=relaxed/simple;
	bh=e9npuPqfzDiij57p5+uaHZXClk/fD1LZIUF5DxqxVkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QesXSzRYq7i+d6jlI7YNX5Jm4CpDD8pQpCyUUGce2ySHVutfUFpFTN7VRK1TF9y3h8g90N9ZGQgqOpWItRaqASMuGg9d+iDrPKntXhpigLAbmfhjywCW6Ps716jAvADGvTv9wbmugcOR1EXLn6S63+FNwXtf6us2GGSqrgN2v+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e2Y1Yj9r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZqujXUs4; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2Y1Yj9r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZqujXUs4"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3796B7A00B1;
	Wed,  1 Oct 2025 15:22:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 01 Oct 2025 15:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759346550; x=1759432950; bh=j/BtcX4kNQ
	4fVHYieYez0azz7AwnRr0JkL6Y0Zba+bI=; b=e2Y1Yj9rLF55qagXpvbJ/B62jI
	Y3kyzZ1c1ORDCB6MwmIDGgC3F55z2yJ/nG7lwyBrEj2t3LL8jUa/r3fmp+PbdgWI
	g4QZpl3qgzdMvF7gnyJr+DBgGJVdMf87X+qST35e8XDKGz1BRK7AkfHGAyro940t
	wjZIx/HYn4+RduBuaNSpkr0+gDi4qx2pG+G2UOxLYNLIKgge8pTe70bv+sfyor6+
	Ud1FgaQSWG/E8bKYyTBCsuK/ZjsTqybo7RFU7THvyZLmvpMtLS/+Cnl+v46/luKZ
	hHOlaT1U/EsWDWDGmVx5SeoHm7Ti9Lz8Zzqjur2aWRPns7/OYwgrC/nrAiGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759346550; x=1759432950; bh=j/BtcX4kNQ4fVHYieYez0azz7AwnRr0JkL6
	Y0Zba+bI=; b=ZqujXUs47wFsZX+hGpw8BIKAsSVeTQmvpL94sggj189lX+hjCK1
	aOlA5PuJLfA5z0IdCsbrvpfO3C2wiVk7AeWADnDiou5d7EX1/v0XCafXy2Gx84XL
	knpKSGCCodlX7Z/sxjo+h0wRm155ba8pBrHrMxp18N2Ewn4B5NTT0ZXlggSczmc8
	nv3FL72Ip4DrDL0xGkWuEHI9niD1o+kweFlgorFsKnIefJ7VppIQAEQWpz1ww9St
	fZhodLyDEsY8qUJdZWrKp+cAWX+B04um6LoOmPpmN0TIK3S5xdoUNPIKTFVQyyRL
	2GjU6ISpNLx7X9Nf3V6tdfUI2oLHnm645jA==
X-ME-Sender: <xms:dX_daEWYsFzw2b4aRImF5tlvS7sOpRnYY8KbRsFS7kAbNazJ-1Zoug>
    <xme:dX_daBAuXp4UkzO2imshJwAL1nhpKm5kFEV3q8y8Js4J0SMtrMskwSh5-cPD0D8oW
    HcEnPQj_jWn1IQD-OQSIhitfZ3h05oKmFuNuGJIgRu2f5xngq9lVw>
X-ME-Received: <xmr:dX_daI1sKUbA4Gmo-rrnDIH8-ttqQ7krQCdPTDTr-hgTR-kBGQ5Q8DoWzBxCcztb08um-R9xeppgsg88wAmvjcZ4YOc-pJw6d4nz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgihthgvuggrnhgtvg
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehhrg
    hnhihouhhnghesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesshhi
    ghhmrgdqshhtrghrrdhiohdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:dX_daD21m9X2IPjlgF6gw_h9lJd-YhTJjO9r1J_8y0V1SzkD1luu9w>
    <xmx:dX_daNAXjWGze3HsAXnpEol6hrfmyTHfe1hhzjxlEOY2yGh9NGyRXA>
    <xmx:dX_daC56QK7zNwoHK22xy2l51BOD4NHBDt3ta6lDtPLGfdQrlf0BSQ>
    <xmx:dX_daOJdb6S3FTgyFN0lSfnUHt9LsNSujFFfSQso5o3Nn1NAMz8rKQ>
    <xmx:dn_daLuhS25BkG9IX5lNREq_uRWGoHtCh4aCIv9NJpKXQ30Z-iuLme_X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 15:22:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  Han Young
 <hanyoung@protonmail.com>,  Sigma <git@sigma-star.io>
Subject: Re: [PATCH 1/1] files-backend: check symref name before update
In-Reply-To: <20251001150805.9652-2-hanyang.tony@bytedance.com> (Han Young's
	message of "Wed, 1 Oct 2025 23:08:05 +0800")
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
	<20251001150805.9652-2-hanyang.tony@bytedance.com>
Date: Wed, 01 Oct 2025 12:22:27 -0700
Message-ID: <xmqqv7ky1l70.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

> From: Han Young <hanyoung@protonmail.com>
>
> In the ref files backend, the symbolic reference name is not checked
> before an update. This could cause reference and lock files to be created
> outside the refs/ directory. Validate the reference before adding it to
> the ref update transaction.
>
> Reported-by: Sigma <git@sigma-star.io>
> Signed-off-by: Han Young <hanyoung@protonmail.com>
> ---
>  refs/files-backend.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index bc3347d18..d47a8c392 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2516,6 +2516,16 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
>  	struct ref_update *new_update;
>  	unsigned int new_flags;
>  
> +	/*
> +	 * Check the referent is valid before adding it to the transaction.
> +	 */
> +	if (!refname_is_safe(referent)) {

Shouldn't this new condition share the logic with what is done by
fsck?  IOW, after doing this

  $ echo ref: refs/../HEAD > .git/HEAD

"git fsck" or "git refs verify" should barf (if not, we should make
them barf), and this code should use the same logic to notice that
the target of the symbolic ref is bogus.

> +		strbuf_addf(err,
> +			    "reference '%s' appears to be broken",
> +			    update->refname);
> +		return -1;
> +	}
> +
>  	/*
>  	 * First make sure that referent is not already in the
>  	 * transaction. This check is O(lg N) in the transaction

Can we also have some tests?

Thanks.
