Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97020E70F
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315423; cv=none; b=E8rPH8Sx2Gox9idFN/VQga4DCTAbvKrzylVCcPh6RBxOd55fcSgkbeAyNvDHMXnxGpTmBeSI9qw8OQcbl+GX4S+QXNyG+4rvXRIctta1gJUNciYcwLEIW9ONYWEdTdbEP3oB4xDN27de4zyf1n0xwCERGtAWnlYn8sOYzbLU4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315423; c=relaxed/simple;
	bh=AMpbzjHYLJvalhtvAj56X934vNVFM5BNh/JeVe3zfKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRPuaGj3hRunIYKQCwfImy6ecu+Iq1Zsfil5Uhl+8k9+2G1d28DP96I1N1ZOcYx9/2Mra5zKf74Jb0/ZIMIW5gZaNGYhXnX1PptCau+MKPfaFvRb6/6SW3xOdCz9MmO41jwKNkmaIQg5Sqj1c5MiPgUc5SPKyL+od91TYtnQi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sOBgUEq7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bX/2zBYS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sOBgUEq7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bX/2zBYS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 93CB01140175;
	Tue, 18 Mar 2025 12:30:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 18 Mar 2025 12:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742315416; x=1742401816; bh=EvpGHnOlar
	W7bAEFPB9rDJ5A1U1kn1qoHCHTrSc1wOw=; b=sOBgUEq7TV11ByjfOd5ubF0oz8
	HDR6E7vVTzCiZMyMogjlekpOaq2YldXyPqJ2GkK7LpZgbG0qwqlgg57FCviqvHAq
	4vmj+zJ4tn35SlLwZyb8x2eksTgicfAuLE+hDRtyWzM6qb9Lf0x0lsDxrOqMlOjA
	pp59dLooQK/Bek3Q14CbtvhCBa1NuylyLG54EzBCt8ce2jHZSCqF+Md/50mb6VAs
	sgfI3sA9OqZ+X1uvl/XI+hoq+7Bb5scGDIYHb0dOuOYHIIhjnFou4bl1sCUEy5Wh
	ThGlBTEQXFWw/opamO9z9Jq4lMAx8mDYAlHdvfuTfc1MeQtCUVnvItcakiwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742315416; x=1742401816; bh=EvpGHnOlarW7bAEFPB9rDJ5A1U1kn1qoHCH
	TrSc1wOw=; b=bX/2zBYSIjFgIZ6ngr3SlWmMhYArpZ8o3s2NzD1ETOqOVsqzetl
	yOzEwohHmzcuuxUFRCLMx8OFDoQyyLHegUyrNRvX27NjbHa9zE1eNzMv50J8K0Ou
	ttmUo3UBmrqK+LGFPLmNsDYonMLh73hjSgGVWPsjTm5YHXOAW24pxUN8Kb0hR17n
	Q2FUDf4AjLMa3j8WjrslwjlKt/ySe9l+WtO69rvpRK3ax6LZCmYK+Syvh1+v7V11
	9zjWR7xl8vK6khPC4Sw8k5seWqiJ+BJkLkPDb+v42FEOT1W6hG+lxabiBHbpNidY
	Zp0t368xUD2mqAUGMUMCCrD8qDqA4ZHKHJg==
X-ME-Sender: <xms:mJ_ZZw7cdiKIK8IQSRTVOv7GIz9MNjT6otlILBDDCZ7Bvb_t6oTsJQ>
    <xme:mJ_ZZx5iLr87kgLK_XsBkyePKfhBayu_v5rSGbMwJiM_NIsrV7BAKh4gdMjneTi8O
    q5zDjXhCoCxzqEjrQ>
X-ME-Received: <xmr:mJ_ZZ_cS74G8FzpdpBcTj5l-e5K2QeH7-mjt5pYu2qIk85NjkFw1OkyI9twu2jcZ4tVDBeyvY2XihVuhbQ8jMJqSCFavJJcmc3EosOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mJ_ZZ1JpbBDbZgN4_kL9UqaWMfOXiPQZN8qVrciARqoFtQnXDpxdZQ>
    <xmx:mJ_ZZ0JIpNTnNB0X_xAD1nEaRHlYE6czKB6FTauvLcdufxIoQLEE3A>
    <xmx:mJ_ZZ2ysnHwnxYl7NpRHmFstBOa0sa0hWvi8vNymk6_6-qjokgKcKQ>
    <xmx:mJ_ZZ4IDzN_nCaQbgeICbGrNpAmrJe1Z7NJsW80iu2CEpvhrX28xig>
    <xmx:mJ_ZZ-g52i0stn9dw-8ut0oUAAYGhGcawqTiklF9DC5vSFznthmS7ykp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 12:30:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 5/5] repack: begin combining cruft packs with
 `--combine-cruft-below-size`
In-Reply-To: <7f120c35e95dcf41282c87dc2d1b2640ecdc5d84.1742252411.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 17 Mar 2025 19:00:28 -0400")
References: <cover.1742252411.git.me@ttaylorr.com>
	<7f120c35e95dcf41282c87dc2d1b2640ecdc5d84.1742252411.git.me@ttaylorr.com>
Date: Tue, 18 Mar 2025 09:30:14 -0700
Message-ID: <xmqqh63q47zd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> @@ -81,6 +81,14 @@ to the new separate pack will be written.
>  	`--max-pack-size` (if any) by default. See the documentation for
>  	`--max-pack-size` for more details.
>  
> +--combine-cruft-below-size=<n>::
> +	When generating cruft packs without pruning, only repack
> +	existing cruft packs whose size is strictly less than `<n>`.
> +	Cruft packs whose size is greater than or equal to `<n>` are
> +	left as-is and not repacked. Useful when you want to avoid
> +	repacking large cruft pack(s) in repositories that have many
> +	and/or large unreachable objects.
> +

Shared with existing entries in this file, but let's strive to make
sure we explicitly mention units.  --max-cruft-size=<n> is explained
to cramp below '<n>' bytes, which is great, --max-pack-size=<n> says
it accepts k/m/g suffixes and its minimum size is 1 MiB, which is
explicit enough hint that this is counted in bytes.  This new entry
should hint that this is also counted in bytes.


