Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0BD3F54B4
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766062; cv=none; b=TW3ZhiEn5JFWvdl/i4pOYOfS3sXFOBMHchUzKsy8gNf11biX2o7B/kFTA1Q0M3SSV3ovy5eWqwutviDY8lOlDazstmOZAggv+zuv0rgbZxx1P6rQn88wMSRy7a1KPHT3fDOfjO9mL1TZNo5NQahBqH9vu2X56HzSKniy3Q2TyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766062; c=relaxed/simple;
	bh=Dk/K9cvSl1mDl2QqmVn8O1IFRYDMIPJC5pZz4AwUP+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tvHAa/2dFRqD9CG79wmze4HdSPyO202Neu8k2EFbcFt3En6NHY/2b6YQXYMQqH+xdAE3LVd+E+CCLVmqs0KzR60YL0DsTVDrzowmyG6IQvuGz4mczYC7pUBSgG03n1QNxxgQxGIF9I9hDqV+c772kqoAD4TrX9RG7C5vBJWZTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PZWS97BT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aY8rgR25; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PZWS97BT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aY8rgR25"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CB6C7A019F;
	Tue, 17 Mar 2026 12:47:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 12:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773766060; x=1773852460; bh=elUJaMdC9o
	MybZ8BM6LH0EetfJYzxucG9WEyU6GgQ0Y=; b=PZWS97BT2P1k+5snfFBd9DAnTG
	llnTUYChQQmiL1M/mHPCfWPKHnht71SshaS+zhoLt2Q0p2kCa7c44LP8PS55szmu
	G+fAiNjOv0Q89VnT5LRebhUilq/gSMJSSqAhIx+tLZN2dRKLthXqKmQrnzP1M/11
	3Jp40Kdxxq7bva1g+1czGsbI4CQRn1W5XAzX6pD4R4Kn1NT+vgGSaO24bY9HtrO5
	XYQvlKCJ+aFGZFIfNPvEiqWWteNM+fWcA9tZZx4KQrvCZTUEm2NloIH8ExKPcoNW
	WVvovv4ww+qawgTN/Ig8Ier86BkNEHpUP6UXbta7kgAQ3onzVnAqRbSoIa+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773766060; x=1773852460; bh=elUJaMdC9oMybZ8BM6LH0EetfJYzxucG9WE
	yU6GgQ0Y=; b=aY8rgR25zTx3ddzfiLMpVo+RajkhTfyBdPhIH9cK3HMwC2qN5H6
	LeQW547uvXMkKydbNrWMwLYdZTjgYCn0zvXam7gZmmfCBhqybufoxNnhDUR9RI7i
	ZKn5lfH19nkXiqWsaDAdPCJqwbznuaa07LueSPo5rPonSvb2yt0qWDIeNc+kQZlg
	PV3+p2vmnN5Snk+Xz99gYKrNMmc8wgk367Ee6iWy4K8zP6KRwIwSmAbgfb8Yxxii
	nUussiCcp5hUH2BkbunaTX5B7KJwkCFifx8xB3oD8orZqllypNoqakWKgQhrwDss
	C5cVMYA3DIv1C/dkseEH/B4hcBTWH27Pvlw==
X-ME-Sender: <xms:rIW5aXIiISmFomfFSrRxTuQPNfxwLUosCtYP-rePLHAssd3s1hz_3A>
    <xme:rIW5aSkO-JbSQaveeQR4i7QW0CnEEbQ7PeMC7KNsfQmpSTBU11P6pAUn_0OAFTHhP
    N3Cz8z1dCQ2sYDhIAXudcEKToKqA3MZew9k5RSOVJN_LS6v49nQOQ>
X-ME-Received: <xmr:rIW5adHloPSO1BcVBVux6wV6Md5T0nh3v7gzFwUc68_PHL_6xExIFmGVlpvDKxmeM-PokND49vUOXaNHCRtNZpwuhNedRu20_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:rIW5aaEjcrrUtz761KeGPs8qdXq17UN44zmIsZPeuxZnvcvi98tk4Q>
    <xmx:rIW5aSNNac8FevxiwAPpAvB_VpYKXWWgBZIh7Xw7DbMocb0rClW4tw>
    <xmx:rIW5aRHL-GvjdXbwxJ0k14qqxx71kMUllIdieo7W5aSZgpC1t9UfIQ>
    <xmx:rIW5aRPG3t7D6HIxE4x4-81wSZlNKcsiDeyjMDugfLD7U5BnqYUwLA>
    <xmx:rIW5aamlrDBk3b_9ECzpMV3ONeRzSTpTLEiuPlhSwtyAjwgSh7Ugb6o_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:47:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] add-patch: use repository instance from add_i_state
 instead of the_repository
In-Reply-To: <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Tue, 17 Mar 2026 21:20:29 +0530")
References: <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Tue, 17 Mar 2026 09:47:38 -0700
Message-ID: <xmqqzf46l7x1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Functions parse_diff(), edit_hunk_manually() and patch_update_file() use
> the_repository even though a repository instance is already available via
> struct add_i_state s which is defined in struct add_p_state *s.
>
> Use 's->s.r' instead of the_repository to avoid relying on global state. All
> callers pass a valid add_p_state and this does not change any behavior.
>
> This aligns with the ongoing effort to reduce usage of the_repository global
> state.

So we can call this "reduce" but cannot say "eliminate" yet, as the
files uses comment_line_str?

The <environment.h> header lists some global variables inside
"#ifndef USE_THE_REPOSITORY_VARIABLE/#endif" block, and the
comment-line stuff is among them.

The patch looks correct.  Will queue.  Thanks.


> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>  add-patch.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 8c03f710d3..30df920723 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -434,8 +434,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  		strvec_push(&args,
>  			    /* could be on an unborn branch */
>  			    !strcmp("HEAD", s->revision) &&
> -			    repo_get_oid(the_repository, "HEAD", &oid) ?
> -			    empty_tree_oid_hex(the_repository->hash_algo) : s->revision);
> +			    repo_get_oid(s->s.r, "HEAD", &oid) ?
> +			    empty_tree_oid_hex(s->s.r->hash_algo) : s->revision);
>  	}
>  	color_arg_index = args.nr;
>  	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
> @@ -1147,7 +1147,7 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
>  				"removed, then the edit is\n"
>  				"aborted and the hunk is left unchanged.\n"));
>
> -	if (strbuf_edit_interactively(the_repository, &s->buf,
> +	if (strbuf_edit_interactively(s->s.r, &s->buf,
>  				      "addp-hunk-edit.diff", NULL) < 0)
>  		return -1;
>
> @@ -1551,7 +1551,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
>  		if (file_diff->hunk_nr) {
>  			if (rendered_hunk_index != hunk_index) {
>  				if (use_pager) {
> -					setup_pager(the_repository);
> +					setup_pager(s->s.r);
>  					sigchain_push(SIGPIPE, SIG_IGN);
>  				}
>  				render_hunk(s, hunk, 0, colored, &s->buf);
> --
> 2.53.0
