Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014843;
	b=hWSf48mQW1hSzxvV+9hN0QmaU6KiDX7MHtIkUcPrIHWSwMP8VvOfcVX2HI5ibB8GDq0K
	 gbMKCq5gVzk30uH7cZg4MyLNBYwyXBzUx4ebEya+6AP6lKd/AMkoev4niz05p0Br6SFVv
	 p5UQBq1L1QkhMHpdsfzRuv3OG53Zh9whBbMTYABhvflH4doTrrFbLqvH8itd7vSHRsVBF
	 c9JwXrWLxU3bR+WoiGV/8JAwgspuwyyNnGbCWnRON96ir2fPdpI8e32RmFy0PKxa/lloN
	 VZNpvdIizaoqBhM6IYzy/JawTofyXlIvMkPik/ze1xgIj7uICKNp0zXC116PXWyPoRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014843;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=61ATsdGssm+gr3nJVOfJe9oTi8HR2XbLpHlijs5F2nI=;
	b=rkPosKJn29yPom5fXNXtZCrj1R3n+omg4bqMAxFpFCyvJ023HRQh/8LCY0ZvZRMUOJYe
	 yStYVuWoIkaTpQXfyJwY1zg8wsahCU5kq6e1yHCOYGyb+rSc4KOdeTY0a8y2+kIaN5BVv
	 MsnAXmM2dkNKsmaqgm2oZf85XwaESVZ68LySlN5L86/C+yiIAJfqCQT0oJMk5Ced1RyuL
	 xdBmqbtWriiz2oJni9wAkTo4sL1t1Zo14Cz3BaJVpW42N+n0UnuUo6HnVXqlWiMcmfBRw
	 BG33RsdSBjeuaFczeH1WLywxRWOj+ZJnAd8O5BvRBDUX873rDOVELjd7CpMNXfrk0mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=qmxzOrEy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qmxuG2aN;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A9606A31D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 932A9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=qmxzOrEy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qmxuG2aN
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A83097A01E5
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:40:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 07:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793014841; x=1793101241; bh=61ATsdGssm
	+gr3nJVOfJe9oTi8HR2XbLpHlijs5F2nI=; b=qmxzOrEydKEVe0QFR1g+eaPhx8
	Z+p8ONoJmAQzyGF6qFOYv/jACahkoZN4BQugkw/EerSKgGEx6g6Ju+ApgDa1HTWZ
	67gPxoNQLL3LJvxHNLLHbDBWX5zIdB2lv8+axJ37dbvp5SN4115IWyQFTzr71q8n
	o5XoRM9AZbypNKymPDvoRuM9fEMC5leUFfYEVnroHfta5/tTCn/3//l6ThUTA38j
	5S6rl8hT0KeCzeFspo9GMRQIx+XteKPrkg/YKlgJAgYi4zF8EgfnxSqBC/Lgp9X7
	C+HTlyJO6K1Eiqzo7xiUj1XAPNBXvBW3fFcsB9jxVBNfZSVNEJfeYVqjlJkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793014841; x=1793101241; bh=61ATsdGssm+gr3nJVOfJe9oTi8HR2XbLpHl
	ijs5F2nI=; b=qmxuG2aNmlkxbhzWLi2DjAmNjoWmVoAW9vBkcfLw6qhBReE3Q4z
	5Y8BWSQQk3VjaYa0wBrYyn1LphqNqd+ZH7IX2GR7MlHUOYnQ01h489j6b+GqtQ4t
	0ZXz+l2F5acDFnuaAGA37uHboLesGEMoxxjsLcUuKTRDJ47CzGJ3xwWt/fH7/tyC
	gc5rcNe3/0oa894FCMOgzdZBj1q9Nczlds8v109cKIkgyFHkEu65TgnbrcJCTXZG
	U8cw0+HSrN3iOfA5cdbPpHcBhLAwFMZ/ReDd5IGdCqMMVEiHeu2IbtoAEHXQ6h+U
	k/SnqRhCstbO2qsnbmqkTXHvB2cuoeqCYig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793014841; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RJO0eVfctfqFbvqPee1HcUzmqIUgXFm/qUJmXRSHhlgMZ9Y
	L/pPVnI9hHTptqd3XgUDP44YcUZV+fu6R3SojFTXrSBYPWWh+C4zbVNCVgwAgrll
	SdoSTlgrmcSzoWZC/KBQFyzpnTw76RVJKheCF94jr0vjIXBa6qPcLGR9sLp1ozk2
	o80pRXIlJKHSU7REtBPW6ji1uaJw3Aejd2DhtiLadDxdHy4IeFHcXV3IQvBBlIz0
	Z2elUxM60vGHA2DapBxtYxGuw/yvxWUBFuN0qnmnm1/alGDo3H6q3UihCQ9EOkiz
	2bJh/zVRueQKNnZ2B+LyVR+vGwx6eTQnICn16Sg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xop6umXNbJrzDC6BzFooQbYCVc4/HINBkQXHwZVOatg=:0DM+iDopnMF2PiBVXZf8gJ8fSo+vpDeU8V006wgGUgg=;
X-ME-Sender: <xms:ODzfauh6czE5K0sfOilzIFX4iMaXGaHFf9CRsnnpPA8zGJhjkOrDaA>
    <xme:ODzfamCFpq8q9ChAzMs00giJXpC8wXUAQR5ZmemkH8rxs2FihBXoBM0Jmd1dlh_iK
    tY67V38WxlOJmxGi0QptPPB-4Ut6d7KJj97BPO9Tokq8tdmyUcETg>
X-ME-Received: <xmr:ODzfarEXJQjPVm3-OrGW9wx246RVJ8WmcwvgHi9vu9mfPu4Du0BsZg>
X-ME-Proxy-Cause: dmFkZTFj13MjGBEyjn+RIAl/qQ4K5FJVtk/6rD7hKjlOC1N/DYnLy3PzieXN1JYeodI/66
    fsJZYSVM7LjKVu3oEiy4jQyQyEVwCP6UUYVzTlRIKdBYyttTY0VuLIWAxwTpsW+52fLkQp
    EV74w7R8G7nh6D9Pd3oG3cSWPAf49haNCST+U3ik3P82tli4idN9qo1dJUxQAVPF/FVXQ4
    3jwwvgEa9jSJCpH2V9s79fBcA/l9HfG9UQ1j+Cx9vbCzRdRvQv815LcrGLlxsJfEfJPzJc
    CeNwasZ8LDNjCLrnUusJjsXuftYKJ+snWhobKjJ+//eZ1Gl3OXf9v6/x2pKDxghDBdcJKy
    70o1SQf3dIA0qi4Lqvqnypxyg3qgu3FjddET76o7iF6r5b6rhtlDwVmQO9AhSGOwYlQJBH
    e1ZlenfmySTqhb8ZGlYtZdOQvkVYoPCzMm2iEycaOxKxH7A3xFHNbHn6WdtT1vN0690F55
    pYcAZdUch2uBHb9fgRECf53/Po73W1ITq6VPaRqh/Vbo+OL8Lh0Ts/P7ga2KQ6x18AiINg
    7EAuuLnkW7Hq4NruY7wEc6prds3ZaAojEnNr0+gwMNg6qdWkyHoISFzpGcckkeWVAqISCN
    UyUoeeCS73MrLsxk9LT4yDMcht63mn6kbHxkyq9wqS3eHtth5zqIoEyg1hhw
X-ME-Proxy: <xmx:ODzfamIqYPkzFacU3mMrzRSBFo85GomOVSI8woVLdhpSu2jjJ0bSYw>
    <xmx:ODzfanlNn09qZ7B20zqtZUyDSuiOfhJyI05hygiePin2q7HDKos-Rw>
    <xmx:ODzfamQAka5yMKZ1Y0O-a7m1bi7acHexnr5ARbvq9E406gU452K5HA>
    <xmx:ODzfahIWMjbX0uA5bWCgel-jpncPgKOrjNIGXSWMRXQoa-Po4wIIzg>
    <xmx:OTzfakVFnZ2TeoHHmsQGv5IF84zhHBef6YnNpRrtaHKHImMm12NND3BV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:40:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b2e1347 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 11:40:38 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:40:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] log: simplify --follow following renames for
 non-linear history
Message-ID: <at88KXp0vhXlPhFQ@pks.im>
References: <cover.1792701579.git.vmiklos@collabora.com>
 <ba2dc35c77b95803f184e63cc9933e3765bd1417.1792701579.git.vmiklos@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba2dc35c77b95803f184e63cc9933e3765bd1417.1792701579.git.vmiklos@collabora.com>

On Thu, Oct 22, 2026 at 10:46:39PM +0200, Miklos Vajna wrote:
> Code added in 304812ed33 (log: improve --follow following renames for
> non-linear history, 2026-06-22) implemented the feature by introducing a
> new propagate_follow_pathspec_to_parent() function which adds a new call
> to diff_tree_oid(). Also it introduces a new loop to record what path
> each parent of a merge commit should use when following a path.
> 
> This was working, but fixing its performance would require adding even

It's somewhat curious that you start talking about performance here
without even mentioning that performance is what breaks the current
approach. You mention contributing factors to the performance regression
without really calling it that.

> more custom code, instead of just extending the existing code in
> log_tree_diff().
> 
> Remove propagate_follow_pathspec_to_parent() and the loop calling it
> for each parent. Instead, record the path to follow for each parent in
> the parent loop of log_tree_diff(), right after diff_tree_oid() updated
> the pathspec in case of a rename. Merges are not diffed by default, so
> with --follow, run the same loop for them as well, but without showing
> anything. With -c, --cc or --remerge-diff, show the merge diff after the
> loop. This gets rid of the additional call to diff_tree_oid(). The
> rework has no positive performance impact yet, it just simplifies the
> code.

> This also fixes 'git log -m --follow': -m diffs the merge against each
> parent with rename following, so a rename found against the first parent
> updated the followed path, and the second parent was then diffed with
> the already renamed path.

So next to a performance regression there's also a bug? Interesting. I
feel like giving a bit more time to introduce and explain the bug would
have helped.

> Also, propagate_follow_pathspec_to_parent()
> started from that same updated path, so history was lost on the side of
> the second parent. Now the path of the merge is restored before diffing
> each parent. Add a test for this, which shows the full history of the
> diamond case with -m.

And another bug?

So in summary we have two bugs and one performance regression? The two
bugs are fixed by this change, and it also prepares us for the fix to
the performance regression? It might be easier to reason through
all of that if we were able to split this so that we fix one issue at a
time, but that may of course not be possible (or just very awkward).

> diff --git a/log-tree.c b/log-tree.c
> index b4c97b86f5..c5ac6c2bcb 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -1240,35 +1215,67 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>  	}
>  
>  	if (is_merge) {
> -		if (opt->remerge_diff || opt->combine_merges)
> +		int merge_diff = opt->remerge_diff || opt->combine_merges;
> +
> +		if (merge_diff && !opt->diffopt.flags.follow_renames)
>  			return log_tree_merge_diff(opt, commit, parents, oid);
> -		if (opt->separate_merges) {
> +		if (opt->separate_merges && !merge_diff) {
>  			if (!opt->first_parent_merges) {
>  				/* Show parent info for multiple diffs */
>  				log->parent = parents->item;
>  			}
> +		} else if (opt->diffopt.flags.follow_renames) {
> +			/* Diff only to find the path to follow in parents */
> +			follow_only = 1;
>  		} else
>  			return 0;
>  	}
>  
> +	if (opt->diffopt.flags.follow_renames)
> +		path = xstrdup_or_null(
> +			pathspec_single_path(&opt->diffopt.pathspec));
> +
>  	showed_log = 0;
> +	all_parents = parents;
>  	for (;;) {
>  		struct commit *parent = parents->item;
>  
>  		parse_commit_or_die(parent);
>  		diff_tree_oid(get_commit_tree_oid(parent),
>  			      oid, "", &opt->diffopt);
> -		log_tree_diff_flush(opt);
> +		if (follow_only) {
> +			diff_queue_clear(&diff_queued_diff);
> +			opt->diffopt.found_follow = 0;
> +		} else
> +			log_tree_diff_flush(opt);

Nit: style, if once condition body requires curly braces all of them
should have it. Sorry, I cannot really provide more valuable feedback on
this patch than this.

Patrick
