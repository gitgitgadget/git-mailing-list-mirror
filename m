Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BD271450
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775538921; cv=none; b=SEuk6m6rwl1cYQSr98crKwq1VfhOI+PM1qFb533z1M4epBZnbfQ3Tv5XY09uGhg3VdQPv6lLw3EQBpVAiEOMySzFSQ+BrctNNu7Djj47Ogs5In6ZKZzDVcc8ynDbk8wiJI0IP7UhD7OVb6zW1cm5/SobRqzvJK8dC2350Phhmcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775538921; c=relaxed/simple;
	bh=Etivjs1+i3PEg6kEOip7IanAVXpGdarNTN9wQBWiTx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLZIJ2ZMf1ii9eQBIZYxWF2PdubIF+pbyHPrK0BFHSxXhheFunp43uK74oQRynWz6LzCnSAv2vnL5OsxruGSoKvAW+1n8diCqcmmtGSO0wpl0Zo0wGjhon0WM8KX7simZLUgwQQurs19WbDdbQPtO1JfrWFm25nZlfDkzyYuZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PSz8mI+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E9rVMLjP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PSz8mI+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E9rVMLjP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3937C7A01C2;
	Tue,  7 Apr 2026 01:15:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 07 Apr 2026 01:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775538917; x=1775625317; bh=Kr4gRuELri
	bFgNZc4P5tkR4ZnClwOu3xqwYWZOYb3XM=; b=PSz8mI+ehl17XvAmWDep9hvqmP
	fk7U6QQPAOWoIE/dBT61PWXirQTpROvqHPtTwxeHgGSiSwcqdvyKNjgf2m2VCHwe
	euV07zkteiRyHZzf1+g1vZ9gLLjz3IvQEaR5Xiv1LZ/JrrTdqZ3w2/6aFMi1wT7s
	mZsgkwaGVVDJL2tHNJbus0kqhXIkrVhK8o8ivrFzvrPWkrkv3fLZnLBmrEUfdrUT
	gYJLn4g6T/aymxpy7PSTUCs7MF/UJ5L+as6MegSO6m9Y3HWkt2GUE7JKkcm/vSH7
	Jw+diW8im6xGIZEaN+gsJDOv9dkVgNc1OM5f4SCvN23WZ9H1b1fqr/VZ2PIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775538917; x=1775625317; bh=Kr4gRuELribFgNZc4P5tkR4ZnClwOu3xqwY
	WZOYb3XM=; b=E9rVMLjP11i4X+tdaKEhaXJGkrR/RxLJagU5VuRxNp83LQ578zh
	J+ky3Y6iMe7BYlKC2vOZhdw1ptdt8Z9qjoJD8dAzsbTakk4nCHXIHsFp2QJopZjO
	j5u3Mi4eJbtT2gc2hcYryVesfmqqcbPVt2nU8oLU+jeKnRhGl9YyTmq7shtGTI9M
	jjuK4QHlyDLaH6XomBkg90qM8SQLz7tO4C5EwhxHvXwK7XMAaudPkXmzciGN/Xoz
	ThE6BezZuOnkr7WTlyQamVLvA8hCKU+T7YPKmQMySDYD1lvzt16Ts1tE77v+R8Tk
	0wuHBc0pGFIButXylqkfcGFdkJtdqoHUnUQ==
X-ME-Sender: <xms:5ZLUaU9DtkN-PruDZlJvr3KRdFjM0G-dYbAUX5xjObroqedDFzrAbg>
    <xme:5ZLUaTmJFD_UfHCxPg-7dnHQNkHsYrg4caM0zzIcniU8uDyWFvp8xEINybu_Ioxu8
    Al9aXykVaBvffvBkbvL1H6es07YzXWZLq4Mz7WaktMUCfigLRhp>
X-ME-Received: <xmr:5ZLUaSU2puAA10fAPRlrieGJChhn2PieGZHtddv9gYUP00PyPZbXpr4YBaXfSmOeGxZtHXy90qsibVHLw13WpKABz16c2ostZV6RiUC2rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduleejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiughlihhnsehsthhrihhpvgdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhm
    rghilhdrtghomhdprhgtphhtthhopegurghvihguiiihlhhinhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5ZLUaQF2J4EkE62eGJjg-0F6sEsIRtG8zvaGHD7-nsIEv8qZFFAiUw>
    <xmx:5ZLUaWfh0016r6gpoygpmMM96EG8twJ2dDNCJyiiMn2XkA5WXf37Lg>
    <xmx:5ZLUaZLcqaC6d2_M_WoXgv2xn2f9OKXMdpiy5kHilSWCUQbKYlxFCg>
    <xmx:5ZLUaTFeT03oVqSu9HuXTt7nBETfX3WdxOqsCAqHXcmvQyIvJXSXiQ>
    <xmx:5ZLUaacutHQyueJcVud_z98ddtptngoc-wxPuKW6JIzvbJReMxxOLbVR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 01:15:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b9f6e57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Apr 2026 05:15:15 +0000 (UTC)
Date: Tue, 7 Apr 2026 07:15:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: David Lin <davidzylin@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, davidlin@stripe.com,
	stolee@gmail.com
Subject: Re: [PATCH v2] cache-tree: fix inverted object existence check in
 cache_tree_fully_valid
Message-ID: <adSS4GJyBoB2rY4s@pks.im>
References: <xmqqcy0bc4bf.fsf@gitster.g>
 <20260406192711.68870-1-davidlin@stripe.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406192711.68870-1-davidlin@stripe.com>

On Mon, Apr 06, 2026 at 03:27:11PM -0400, David Lin wrote:
> The negation in front of the object existence check in
> cache_tree_fully_valid() was lost in 062b914c84 (treewide: convert
> users of `repo_has_object_file()` to `has_object()`, 2025-04-29),
> turning `!repo_has_object_file(...)` into `has_object(...)` instead
> of `!has_object(...)`.
> 
> This makes cache_tree_fully_valid() always report the cache tree as
> invalid when objects exist (the common case), forcing callers like
> write_index_as_tree() to call cache_tree_update() on every
> invocation.  An odb_has_object() check inside update_one() avoids a
> full tree rebuild, but the unnecessary call still pays the cost of
> opening an ODB transaction and, in partial clones, a promisor remote
> check.
> 
> Restore the missing negation and add a test that verifies write-tree
> takes the cache-tree shortcut when the cache tree is valid.

Oh, indeed, thanks for the fix.

I also checked whether there's any other such case in the commit in
question, but didn't spot any.

> diff --git a/cache-tree.c b/cache-tree.c
> index 60bcc07c3b..9fe057355c 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -238,7 +238,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
>  	if (!it)
>  		return 0;
>  	if (it->entry_count < 0 ||
> -	    odb_has_object(the_repository->objects, &it->oid,
> +	    !odb_has_object(the_repository->objects, &it->oid,
>  			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
>  		return 0;
>  	for (i = 0; i < it->subtree_nr; i++) {

Yup, this looks obviously good to me.

Patrick
