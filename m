Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E223A9B0
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868405; cv=none; b=D0Ny5YCD5BELg5zmgshVYTCUtG6HHr2r+yOJKNrC9DFfDonPJo0kvJ9GgVGC46FXbYa/nj15JQroFO07uRyjoRR5VlRJvcRKTzfXZb4YYhugCuMtWPu4W4Usti4WOilDkQaTGXGrtSV9HtcAU3YtA0C2M3UqzUyDGtVVXivpSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868405; c=relaxed/simple;
	bh=Sbi97id44FFhm45ztwxyc+m1IvrrMa8vTDrz/iK8+no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3xzMW2c1/ma7pC30inyMXGjxlhwGcJTowgdxRBK36j+0+aF/3TIOjeYGZh1gNpUlLwwWJepTPv+anotyl/zh3B/4JV6SEyuDnEYvsAYXxtePCxlDe/b7qyjpfF3fyUqn0QOTJmHQPfAjfPI3lAeTojYWs01VPZnG3gjc5ZjC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6eIfCpA; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6eIfCpA"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30ccec928f6so2233941fac.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759868399; x=1760473199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4Ni113UV0NgSXVbJS1lUFXmxmkvhjzvUgyn8AQaupg=;
        b=A6eIfCpAECqBq8GYeaLtJ+rwzVGGYjqY9Gf979ACTytUbDy2yVRPXz6rs1YcAvz1k2
         iafR0L0BSsFkzQwU7D2Tv9kI20VzhQfdZ4+zfDlO3f9yHGbPC6M/NBQbiB2syZ+LcSZ7
         3/2zY6gIsI4kaj+FQTI3kxDNb547e1YPq/9V53OEVPMNcs4edPMT5fSH7dQly3B+/j97
         TdKOJEppS8pWXSquLvwT821pH4PdQRiPikUdMWgakU3KfJ0QM8Uc/CxWsUjPjm0L2fyy
         vLxulM4GTYf3T4ddsNzksq1+DlAuhua+FIKSN4vz1+Fo1VjHWKIGfIx/yYGTuF+Oolsz
         5tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868399; x=1760473199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4Ni113UV0NgSXVbJS1lUFXmxmkvhjzvUgyn8AQaupg=;
        b=mrST0elZR7Y0XnWOBWp5LemxieDq97Sw7Nq1qMGimyT+LHUPwwt5QxCTMN7jV6XzSi
         JXFT4DzpfG56tHWE/xZ4Q/ba0MKRPv7NxzKXF3zT23E0NuUgC6MpyWphzOxVpYMjT/CL
         3SC7Gwl4xguVz64bAmFWw73xOtc3kYYxbtkCVrxGVrMOzDpFoaB6bVsFV95OhaGmfkjq
         EvVyL/dzWv5/2VtqNldtnZXtbPXbEhRE4ENRD3D7OLb3iMh2AXDIro0mkx/k9KBa9mlY
         mRCUN6WT3XInkc3benlRWr3vJ/6v3m1SWjC1/BTrN9mDj7wbR0krCSZDSIsIG5LWcegp
         npcQ==
X-Gm-Message-State: AOJu0Yy78LfP/k3/wATRb+yu3Qosa7cicwGOX1lCTFpBr2dOpRcPw98H
	d3ybpHLlPBDZkG5as1VirVmQ8iVmoHVmK/YJvMS8kKY4DK9CNh6GH/wCmMtJpw==
X-Gm-Gg: ASbGncvllM32zbKlgYR32Zp7lTDJ1YpqO1mYdvFKF3iJ8gz6BtA9rFmnPmGuMjTBGDg
	V9jnkH8pXDvGNo8JQfwu2J3yB5qYLei3NlSGKlu2+TVXm6kBBojXEob1+T4civluuTPB48MEiEu
	GWqdcF0y0+8nZSs2G6dZMh2WgzwpK5t3YBqrww/3iEqXAFjxVZqLvfi6/tpQcoC7kkkp7OLiIVA
	BckLmnn5dhQfDqX0xjsA2kco3b6vw2qCM7h5J1A5WOJdu3ydxrX0hD2tKrSl6jasR3NknVXsaOm
	U8EruBvlocDkm/XzDMwb67zABFwMTmi8spFFuD7i/+UrMrbT2nHI0MdhkFMT+6+nKJBzA9IXKUX
	0P1Tj62R/x8O8/fx79ilSjClgsEjKIWmjGPfj3URC
X-Google-Smtp-Source: AGHT+IGfsFSRB0R3mAvnef/jBF3n5J/1Kmgsz3lfZGGL3n2DOTefFFZy2a9IpUfaIG43hNnvGhxWpQ==
X-Received: by 2002:a05:6870:5594:b0:3a6:bcc8:8043 with SMTP id 586e51a60fabf-3c0f988655cmr512242fac.47.1759868399482;
        Tue, 07 Oct 2025 13:19:59 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-3ab794be731sm5543135fac.8.2025.10.07.13.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:19:59 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:19:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] refs: introduce `.ref` field for the base iterator
Message-ID: <q6ti6bevxr4kbsi7pe7slwmvyqhc2sslma3tk3xshohnqadtuv@canofgr644do>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-2-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-2-916cc7c6886b@pks.im>

On 25/10/07 12:58PM, Patrick Steinhardt wrote:
> The base iterator has a couple of fields that tracks the name, target,
> object ID and flags for the current reference. Due do this design we

s/Due do/Due to/

> have to create a new `struct reference` whenever we want to hand over
> that reference to the callback function, which is tedious and not very
> efficient.
> 
> Convert the structure to instead contain a `stuct reference` as member.
> This member is expected to be populated by the implementations of the
> iterator and is handed over to the callback directly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0ddcf22aed..d34fbe55d6 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -962,26 +962,23 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  
>  	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
>  		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
> -		    parse_worktree_ref(iter->iter0->refname, NULL, NULL,
> +		    parse_worktree_ref(iter->iter0->ref.name, NULL, NULL,
>  				       NULL) != REF_WORKTREE_CURRENT)
>  			continue;
>  
>  		if ((iter->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS) &&
> -		    (iter->iter0->flags & REF_ISSYMREF) &&
> -		    (iter->iter0->flags & REF_ISBROKEN))
> +		    (iter->iter0->ref.flags & REF_ISSYMREF) &&
> +		    (iter->iter0->ref.flags & REF_ISBROKEN))
>  			continue;
>  
>  		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
> -		    !ref_resolves_to_object(iter->iter0->refname,
> +		    !ref_resolves_to_object(iter->iter0->ref.name,
>  					    iter->repo,
> -					    iter->iter0->oid,
> -					    iter->iter0->flags))
> +					    iter->iter0->ref.oid,
> +					    iter->iter0->ref.flags))
>  			continue;
>  
> -		iter->base.refname = iter->iter0->refname;
> -		iter->base.oid = iter->iter0->oid;
> -		iter->base.flags = iter->iter0->flags;
> -		iter->base.referent = iter->iter0->referent;
> +		iter->base.ref = iter->iter0->ref;

Ok, so here we already have a `struct reference` setup and thus we
directly propagate to the base when advacing the iterator. Makes sense.

>  
>  		return ITER_OK;
>  	}
> @@ -1368,30 +1365,29 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
>   * Return true if the specified reference should be packed.
>   */
>  static int should_pack_ref(struct files_ref_store *refs,
> -			   const char *refname,
> -			   const struct object_id *oid, unsigned int ref_flags,
> +			   const struct reference *ref,
>  			   struct pack_refs_opts *opts)

This hunk is simplifies the arguments required by should_pack_ref() by
using `struct reference`. The change seems sensible, it might be worth
mentioning in the commit message though.

>  {
>  	struct string_list_item *item;
>  
>  	/* Do not pack per-worktree refs: */
> -	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
> +	if (parse_worktree_ref(ref->name, NULL, NULL, NULL) !=
>  	    REF_WORKTREE_SHARED)
>  		return 0;
>  
>  	/* Do not pack symbolic refs: */
> -	if (ref_flags & REF_ISSYMREF)
> +	if (ref->flags & REF_ISSYMREF)
>  		return 0;
>  
>  	/* Do not pack broken refs: */
> -	if (!ref_resolves_to_object(refname, refs->base.repo, oid, ref_flags))
> +	if (!ref_resolves_to_object(ref->name, refs->base.repo, ref->oid, ref->flags))
>  		return 0;
>  
> -	if (ref_excluded(opts->exclusions, refname))
> +	if (ref_excluded(opts->exclusions, ref->name))
>  		return 0;
>  
>  	for_each_string_list_item(item, opts->includes)
> -		if (!wildmatch(item->string, refname, 0))
> +		if (!wildmatch(item->string, ref->name, 0))
>  			return 1;
>  
>  	return 0;
[snip]
> @@ -476,14 +468,7 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
>  
>  	current_ref_iter = iter;
>  	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> -		struct reference ref = {
> -			.name = iter->refname,
> -			.target = iter->referent,
> -			.oid = iter->oid,
> -			.flags = iter->flags,
> -		};
> -
> -		retval = fn(&ref, cb_data);
> +		retval = fn(&iter->ref, cb_data);

Now we propagate `struct reference` directly when invoking the for each
callback. Makes sense.

>  		if (retval)
>  			goto out;
>  	}

-Justin
