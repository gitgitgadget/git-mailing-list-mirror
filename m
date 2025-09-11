Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1182EC57D
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629510; cv=none; b=gqRHy2txyxsBK5exB/DSFWP+KuceQjNpQo5CN8Wwe0zraMHbsHo07QVXOiRqLvwaXIf3sh4OWK1AoD1pXsneithMbIVvroSallUhCsUeiO5HeZEgnAOM/nEAeYj95xtAX012YYG+0EQKel6d7dE5N8VCt31KYy9/lbCm6ZdJb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629510; c=relaxed/simple;
	bh=/54g8ah0gGzROam6PlMZ+tYEi67Df/33w5M9DDHcjnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4vsZPYUgYYmVqpY60+ajuFMU66GZ4MDvtcBV49IW55eZbCTvzTcFBa545bMMoPKIZyr5g5WsbdgoAn9rwISLJbe7l4q4bALxp8IfMtfMMfQDJ5m5k5UdNqfLagbu2fOFCk0ALO4jSFkjA9NVIRF0/+24GHMysT5Dh3grrBAEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jhIaC4Ys; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jhIaC4Ys"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea3c9376d90so1163281276.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757629508; x=1758234308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmFngsC65ViCbSbWH6dFYuMCssKo3/i/rVs6AIOBFSc=;
        b=jhIaC4Ysu35FRw9tzg4VORzy3Zku1FNyymBuArcc3QrF75aTYcS1fnNuwKuAP8TOUU
         SEPj4I6O7ELWufwdoUDS8OZkmptucArvr/ZLQ8n9imFxcrUoVYd4m7el0ezzvjBSD3ML
         o+FgkpxxkamE4w+5AzlHcrjYChdcJVhnk3FKzRodbwGw0m1KhlUF+/nCCrstualaCtKB
         p/s9MFUBXz0xdUI045oYfKGjoWYwEbUqDXuEXSFdwoW4bj82Uu/q/PT8rdl4RA0Bjirt
         CLrN3w9T1ncV/ozSHuNxsgMo5bfaqfgA9t8ob3Q8xxr/sgWHPYK7rBAGU0bX2/FFWYwx
         pxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757629508; x=1758234308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmFngsC65ViCbSbWH6dFYuMCssKo3/i/rVs6AIOBFSc=;
        b=DLBSSTXoB/FEyIPHpvU40RzPPw8pOs7jAtTVMRfLg1POsgaejvvh+gBVsdtUP43Gzw
         6VT30CD1c8c3hEyjA2OhwcnswVlS7vQXGtMJ/2Wqyv6kmrdpu7Wi3tFSkGpGE7u7H32m
         zZ08+2/LRDWi/AGsZump/uYsTzK5DPIqsPQTh3T0Ke5Nm1DXwxUN9puEqrXfIz9jfyxo
         Acafa82yvH4U9aqMgh6B2SjHhSI8KBMbaqTtUzI5Pj9J2dmh4Y6ZhFY97SHYK0sbPFY7
         cCcYpV74vjmOVKr0LELDEP+xdQMMQsBbSm8FpYwpT6GJsYq4BalRQHZMo1z4kdIXWHwK
         dZPA==
X-Gm-Message-State: AOJu0YxngjPFInEcEq/ygL/R2xX4SzQy40PLEBRg96qfkJBUint66URF
	Rvv5D4GuU/dGRrnmlnXkKpiurHzftiZQMsN/gjUH9ICvPKhgZJ3D1P9LVPLud9zvw5y+avQkSb4
	k6mEa
X-Gm-Gg: ASbGncvXFyaC63rYYMssGiBOyiSuvDfu5Q4ioytwuUFzSfBmPmnqQzFW/I+bn4PwYYt
	amzpnWjIZAd1nLix9WFDhzpUPiafk8cRDLj4z9FHtiAjcm1wlog6WSwUXrBXUHPMPP33r+fLOCZ
	nuK5pFVxvLfFdaJRJsCLUTdlBq6oPLdl4Ya/mOrpqf4rRdvvcz6koaWLpO9q6c0z2LbDttTaJqr
	f+nCaAZ1pN4+f72qH+t3VpMnNNsXZ5UBWjHsAdpbkgRg7KVdNDkt78aB+DgXAY+NdrcME9LUDas
	fvqc+BpPnonZezybbnJr3UA/8mHDtuyzIsS/ywATAbjtMpbbGHBNzk5xtv7NQ86jnMvc5YkDbri
	3rAap6UfdI6XkJBkgjOI277nLdDxcVsCzCFYRJZIlxfj21JcIbIsAeg/+TohxJJvOk9Rme6dsWj
	RHd/SKQjhPog3in+o2LYcO+R4LOw==
X-Google-Smtp-Source: AGHT+IEFLaU1aW+JBBnemJOJFev7xqFZdjwVznLL8gXwFXoCXPqQ3R1txUl004YDRj4F/dnSfPxD3Q==
X-Received: by 2002:a05:6902:1501:b0:ea0:4df4:577b with SMTP id 3f1490d57ef6-ea3ca732233mr4348287276.24.1757629507827;
        Thu, 11 Sep 2025 15:25:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-ea3cf006fa3sm841941276.12.2025.09.11.15.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 15:25:07 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:25:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] commit-graph: return the prepared commit graph from
 `prepare_commit_graph()`
Message-ID: <aMNMQdMk2S4MTARG@nand.local>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <20250904-b4-pks-commit-graph-via-source-v1-3-d932c2481e1a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-3-d932c2481e1a@pks.im>

On Thu, Sep 04, 2025 at 02:49:57PM +0200, Patrick Steinhardt wrote:
> When making use of commit graphs, one needs to first prepare them by
> calling `prepare_commit_graph()`. Once that function was called and the
> commit graph was prepared successfully, the caller is now expected to
> access the graph directly via `struct object_database::commit_graph`.
>
> In a subsequent change, we're going to move the commit graph pointer
> from `struct object_database` into `struct odb_source`. With this
> change, semantics will change so that we use the commit graph of the
> first source that has one. Consequently, all callers that currently
> deference the `commit_graph` pointer would now have to loop around the
> list of sources to find the commit graph.

> This would become quite unwieldy. So instead of shifting the burden onto
> such callers, adapt `prepare_commit_graph()` to return the prepared
> commit graph, if any. Like this, callers are expected to call that
> function and then use the returned commit graph.

Hmmph. I see what you're saying, though I'm not sure I agree with the
implication here. Presumably "r->objects->commit_graph" could be
rewritten as "repo_commit_graph(r->objects->sources)" or similar. But
I'm OK with this approach, too.

>  int generation_numbers_enabled(struct repository *r)
>  {
>  	uint32_t first_generation;
>  	struct commit_graph *g;
> -	if (!prepare_commit_graph(r))
> -	       return 0;
>
> -	g = r->objects->commit_graph;
> -
> -	if (!g->num_commits)
> -		return 0;
> +	g = prepare_commit_graph(r);
> +	if (!g || !g->num_commits)

Makes sense; this isn't an exact translation, since the conditional now
also checks for the NULL-ness of "g" first. But that's necessary, since
if the (now-removed) earlier call to prepare_commit_graph() succeeded,
we know that "g" is non-NULL here.

Since that function is now responsible for handing us the commit_graph
itself, checking for success means that we have to see if "g" is
non-NULL first before doing something with it.

> @@ -799,12 +796,9 @@ int generation_numbers_enabled(struct repository *r)
>  int corrected_commit_dates_enabled(struct repository *r)
>  {
>  	struct commit_graph *g;
> -	if (!prepare_commit_graph(r))
> -		return 0;
>
> -	g = r->objects->commit_graph;
> -
> -	if (!g->num_commits)
> +	g = prepare_commit_graph(r);
> +	if (!g || !g->num_commits)

Same here.

> @@ -1012,23 +1006,26 @@ static int find_commit_pos_in_graph(struct commit *item, struct commit_graph *g,
>  int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
>  				  uint32_t *pos)
>  {
> -	if (!prepare_commit_graph(r))
> +	struct commit_graph *g = prepare_commit_graph(r);
> +	if (!g)
>  		return 0;
> -	return find_commit_pos_in_graph(c, r->objects->commit_graph, pos);
> +	return find_commit_pos_in_graph(c, g, pos);

These and other changes may have read a little bit cleaner if there were
a preparatory commit which introduced "g" as a variable on the stack,
since that would change:

    struct commit_graph *g;

    if (!prepare_commit_graph(r))
        return 0;

    g = the_repository->objects->commit_graph;

into:

    struct commit_graph *g = prepare_commit_graph(r);
    if (!g)
        return 0;

, without affecting the rest of the function, keeping the diff at least
easier to read (or smaller) by eliminating the "r->objects->commit_graph"
to "g" change.

Not a big deal at all, just a thought that I had while reviewing.

> @@ -2519,6 +2518,7 @@ int write_commit_graph(struct odb_source *source,
>  	int replace = 0;
>  	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
>  	struct topo_level_slab topo_levels;
> +	struct commit_graph *g;
>
>  	prepare_repo_settings(r);
>  	if (!r->settings.core_commit_graph) {
> @@ -2547,23 +2547,13 @@ int write_commit_graph(struct odb_source *source,
>  	init_topo_level_slab(&topo_levels);
>  	ctx.topo_levels = &topo_levels;
>
> -	prepare_commit_graph(ctx.r);
> -	if (ctx.r->objects->commit_graph) {
> -		struct commit_graph *g = ctx.r->objects->commit_graph;
> -
> -		while (g) {
> -			g->topo_levels = &topo_levels;
> -			g = g->base_graph;
> -		}
> -	}
> +	g = prepare_commit_graph(ctx.r);
> +	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
> +		g->topo_levels = &topo_levels;

Makes sense.

The rest looks all good.

Thanks,
Taylor
