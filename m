Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566846;
	b=oUeoiAsAZFT0nWj7grw0FV/2hGIYXfboQ4urrbrAs42FRFKK7wc5th/TfVLqaajjTR3r
	 cdBNibmg5YYuQwPBMqWZ7WA0IPeoq9Bl/8VO1kxei2MB/fdeeDy8nGADLX49R9loWLcRc
	 9M98rd90lwEIC5b99YnlTpBB3CTB0l5HU7jXn2POYjbFqByJioaRHoeZTNZpdTOsvhvSn
	 LvppEF3PrVxVv1ZD/fCWD8vCt363qxFcUBRn5/hM8fuR+7H+T8F0UPkaM80cSRiOXROfD
	 3lXDCAPBUkh3sxp7e/5rb7Zerv91dAjudslMfV9eYF1xr5D7lercuuPHcK4tVZ9xm4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=z8RVEGKRA3nZZZ7SEYLWvYrXbs5yhd9EwlNcVpMmzvg=;
	b=FsbifaxtCsq7lrO2EXyHqVV1ymhtL0xK1tS0N6v1NGyjaQhmol589sSxQiigQN1w8ZeT
	 jFZPYxBhJXMwV5GZNfurKaDG1WOYKmUT3PXSkZ7hpLYVBIT2FkjgxrBoR5EmWHzMVrivP
	 CBfHP0JXTfoFRwQj+V/qWX/AGf84vR8Oot+0U2V4FZ0IZEhMKrsWPjrWYtms72L9dZbyr
	 E7fZfmMI0G5tFGXZRWdHCsJRFnSNSflesCFPU2GQDpjOWYV3lW2VJtfVyJeTbPqhGMf1j
	 mWnY4+Mg4BqmTGePiRCshWPECQjs0fhAoypISrCtBmJ0oulndJsn146I7RUWkPnsY0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=m6loWVRx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XpNJvo+x;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B18606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 00:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B18606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=m6loWVRx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XpNJvo+x
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E4A67A05B5
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:34:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 19:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795566844; x=1795653244; bh=z8RVEGKRA3
	nZZZ7SEYLWvYrXbs5yhd9EwlNcVpMmzvg=; b=m6loWVRxB/fOu3DqzAck9SQtAx
	HyldtPFaawfPSFt0mdIGNu6wCNcUzQXS1QBLFXDKP7uF3+2FaY5YCJuyPl7/OMcU
	zvjFPsvw23LPzBcRl48moxIk1ZyDd0BL8y2NS9w63kIQYS1HuujlcNgBW21y4W/d
	1kek9E/0PivXcYGJIF4A9B+0W8GKoU/qVFvkIWzVVk7YP8kfu+Y4pxTskTOBVZFN
	GjyyVA71mQtBZw+7smBiv0QWqLAcjPeLP7FR0Xt+omeSdqu1YVNabv3uYRPrmtTW
	JTssiIMaz+iKwJ+Iz543bNoQBqa9z4uhbmE8cdR38tzkojFaZkNhYUMGlhDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795566844; x=1795653244; bh=z8RVEGKRA3nZZZ7SEYLWvYrXbs5yhd9EwlN
	cVpMmzvg=; b=XpNJvo+xfU02I7eLJZ3v4fJfeiwtDxdQ8gDzBLmrt2yzD5Du/3P
	OMBWlL5WscFDd6Fc4dCfFekewtYdNuoyytfR89Fij5yk+//4XZ4a2gPQVRtTAyuO
	RMe4ZwtYD0GgtxEjZ4yb9IdHMSxyhExvcclthqdzCfAHAOR+2CPl2+vB/x07GUgT
	GR/9qEhC1keYbzt3PzpzQ4U6rzRTy8qRKnDN2u9KFStBH4XzQnaJEacsSH55yvyo
	VuzwXLfmqzQcZ7JFeyW80vHTlRc0fm/YLmOBW0nFxGYcWfpfEWHDIjnBxQ529tW+
	CDvgbDTyBwsbHXWzt+G81Ua9l0v4HZ0Dnmg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795566844; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nxKXUYrUVdXX45lR5+aG1ReBti74mAfvDBrpiy5aTSovEx9
	dBcAn+5WorsSa1yrVDMY+fhyudqp2NqU6l0h9bGIqNn/GYujGAxBAs5vJpMbnGVE
	Ip5Vpt1Q9BRIcUxR69FfZbGFYo6WXlkFXRt228agXqQwJFpybc2fue0sF/x7wSfl
	L9sjEzEy45cY+foRgflYoNtTFd+VIF1ed27ZB2dyGKsPHT/CqUXVflm0VlpCOY5h
	ryorenuih+ZitDeL+hv1FrWyp+s8J7CrT6PY0uXJ+5E7CqUCZdwWN52CDC8t3Do5
	ju/ZS8++yGqyX/Cfq4/r68tqt0dcDkoWJLfxETA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pK/Y/ZigzMqHaxCOZU0LzodQX98MsvBtYEHtENHOpgQ=:cDfq6qNIGHy0ahZaSJOQVwBVAvBWYgqSNfMcqhat1C8=;
X-ME-Sender: <xms:_CwGa4JdQafpW-0h0CFKzwPmD72EzR4AUoBIJFmLBFPZge5jo7B81w>
    <xme:_CwGa3OXGG_dGR2simNOT3YoKZ6C7WLFKIvyW0H4Iv2-_70wQ7wCKszRBGjJA2K0S
    nmG6QGDJyUkhbE66l5p5k4HHFZlTCP53IxAfNV2fWcCTur7qQKiRvw_>
X-ME-Received: <xmr:_CwGa-6LGlE28AmIewcHk73uvagASGLjlwmDcAN7AKBnEcd4hb-Q0Aw9gk90vjGrC7_a7WhGvrVyUAuynko_uWLhMoAwjD459py579U>
X-ME-Proxy-Cause: dmFkZTGZeRH2PcUedKYmrM8X89abuoWbY9eatJhIw2q3WYiiAL/II1BOwUT3MoOsFbwZ09
    XUpJzdY2w5NQ8sdvIuEJ7zdpQSLAHSimuUZz/5DEDyQs0qb/+Z9Mm1ldIC8d89+ottXztQ
    p+4OBimr/l+Y5wIJObRKgScIfZWnrjnEr08gYqfFojulehAkCdYo8G4HpxmaN8sDmwSPCa
    AvyCdSQw2Yzns9eibIvwSImrqWevmRC1mW+oc5/IR+TAggnAfwjPf5qixxTN1xrw8M1HfV
    +24f2Q5QhJOz0d4Q5n9FkBMXvPsb9+Saae5rIm49kCqHuawMkrF7NDPvX+a0dxTLQmv+lC
    nHMFygbTuxZwxvAjb6DZmZMBYuPJcIaRlILTDRh3fPkQn0Bs3n9XnmQYd2JucGVKIxLO7P
    HabFRva6Focd/ogxbhvF0KgBtLz2g22TdX+kTlfRlnn9tvMat4D6IgL5WrDyRl6ULR5N7Z
    AyaHvyAkoObhl0dAOI+Tj/dJXjBhry2rZ7lj6A8MAl7uFDn8Alow5Dtr2uehvI3gsNt5pt
    wHkBMP08oxe81otF/1WZQGY4bH4Ja8h/YiZsXzm1ayG+SgAxjzLUnHXbVJ8/PzLxG7xh0B
    18Is2KEdvUXk63AJzdwQnDprlwYtN2w+vazsMZ5gYPKX3m1Z7nFatrJbr3Pw
X-ME-Proxy: <xmx:_CwGax6GVjqDKNh3kd91lz-RVAO5E0BbfjqB2VUfCx5OPFIlRbkukA>
    <xmx:_CwGa0GdPGN-RXhyVvtHgexhAeb9On13ZHcggsalS2idzI3p91qV1g>
    <xmx:_CwGa5VYu-wbXdahGAyI0UOkRZFT81_vTxq-kFgcE8SwRIDHjsbAZA>
    <xmx:_CwGawXmeX9A0_6FAWomAD9PlhStnst05frLXnHj-VG_F1cZWKOlRg>
    <xmx:_CwGa8KkJu_ArXL6nd9sYs5gHci83kf5AFPDy224f0uTw301mbb_kFer>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:34:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v2 1/5] notes: store the repository in struct notes_tree
In-Reply-To: <20261124172146.18330-2-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Tue, 24 Nov 2026 18:21:42 +0100")
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-2-okhuomonajayi54@gmail.com>
Date: Tue, 24 Nov 2026 16:34:02 -0800
Message-ID: <xmqq33sphhqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> A notes tree is always read from one repository, but the tree
> does not record which one. Later code has to fall back to
> the_repository.
>
> Store the repository on the tree. Rename init_notes() to
> notes_tree_init() and load_notes_trees() to notes_tree_load(),
> since every caller changes anyway. notes_tree_init() takes the
> tree first and the repository second, and saves the repository
> in t->repo. notes_tree_load() takes the repository first.
> notes_cache_init() passes the repository it was given. Other
> callers pass the_repository for now.

Keeping 't' first in notes_tree_init() and putting 'r' first in
notes_tree_load() addresses the v1 (or is that v3?) feedback cleanly.

> @@ -1034,6 +1035,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
>  	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
>  	t->first_non_note = NULL;
>  	t->prev_non_note = NULL;
> +	t->repo = r;
>  	t->ref = xstrdup(notes_ref);
>  	t->update_ref = (flags & NOTES_INIT_WRITABLE) ? t->ref : NULL;
>  	t->combine_notes = combine_notes;

Here we set '.repo' before checking NOTES_INIT_EMPTY or calling
repo_get_oid_treeish() makes sure that even an empty or newly created
notes tree records its repository, which is OK.  free_notes() already
zeroes the whole struct on teardown.


> @@ -107,8 +108,9 @@ char *default_notes_ref(struct repository *repo);
>   * Precondition: The notes_tree structure is zeroed (this can be achieved with
>   * memset(t, 0, sizeof(struct notes_tree)))
>   */
> -void init_notes(struct notes_tree *t, const char *notes_ref,
> -		combine_notes_fn combine_notes, int flags);
> +void notes_tree_init(struct notes_tree *t, struct repository *r,
> +		     const char *notes_ref, combine_notes_fn combine_notes,
> +		     int flags);

The comment above this declaration seems incomplete; it talks about 't'
being a notes_tree to be (re)initialized, notes_ref (even though it
replaces the underscore with a space in the explanation), combine_notes
function, but not 'flags'.  Now we are adding 'r', so perhaps it is a
good idea to give a brief explanation for that (just say "the repository
that this notes_tree belongs to" or something like that)?

> @@ -319,7 +321,8 @@ void format_display_notes(const struct object_id *object_oid,
>   * Load the notes tree from each ref listed in 'refs'.  The output is
>   * an array of notes_tree*, terminated by a NULL.
>   */
> -struct notes_tree **load_notes_trees(struct string_list *refs, int flags);
> +struct notes_tree **notes_tree_load(struct repository *r,
> +				    struct string_list *refs, int flags);

I trust all existing references to old names are converted correctly
(which should be easy to verify---if not, the result would not compile
or link).

Looking good, so far.
