Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFE376488
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388425; cv=none; b=Zz/w9LEBT/oLHTglwh2qmiofjuTywPy7IqMdeEtMJbbq4IZZ41B30K6lrOuyeZeYQcG7+BPg50TQehl+a+K7tPVcfsBhTY9+sXF9vxm0EPnnAo0sEOGCdNnkdGiaZbXEbj7qCqKC/KRmxPvNbdjJJ45Kh7o9nQdo0AR+ziYVUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388425; c=relaxed/simple;
	bh=LOSKdeBxTszY4nt4vfpY8fVISB3Eidh9c7TPiRhdXvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMHCB7kycjPqm96G3eFm3nDzppLBikOvrAP7Myhq3LjnuAdN+p7yfaHOHXLhVcAffcb/CGsZd7tzqHWV+ybWasichYNV6YfSZaQt9vc/qXtf5rnScxKrcmY8a2RKQaMrWgg1eRK4pvZ8kNtTqrCKpPW1b+TuTfqh2tTr2CQsdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f3pAr/g6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RUxvXZkG; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f3pAr/g6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RUxvXZkG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C67E1D00111;
	Fri,  6 Feb 2026 09:33:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 09:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770388424; x=1770474824; bh=GOj/j042CU
	+UqjAyPkJT4LxFr+pg26vTufOlSCRCeIM=; b=f3pAr/g6uCoYIbAsELYRwO4/M0
	p9dz/qTuYLeZVcU8l6CCdSZXxceAJ7/y4oVdWhVd46LMYlmahXHyJ8hjGhMqdzyq
	VKlWOxgi5/FBxzxzZC2XGqywi5qrx0Bt0Hl2Xbbw7DUqZIBcRxBx9wpFgbzMG+r/
	6dcPaBdFDdWLR4KOjcsYirdOXYzHuvapm3Q9f1gAxOeLGCfCF/PRfjsm3zHk00Om
	mokqUn6xNxsP4/r8WOEbGwCWgJLL5RAwv8y/EbZGKSigNZP9HuybTo/oBdZSKyH0
	dgQf8FASGfACfCiDm7MJnKGNf9SeS0iZoBRD/Sio72zBqdYlKPq8B/o56fCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770388424; x=1770474824; bh=GOj/j042CU+UqjAyPkJT4LxFr+pg26vTufO
	lSCRCeIM=; b=RUxvXZkGm/4IyREYottdvUvNOvaPARluUF0BC4uCeFlhqunmAwz
	DAsBUU6hN3N3PBMVvce/ioFAz3eyIsXOmYxUl762mVInAgQ9zelr2WxZQ8bU1Nap
	tzU8LbYGmkWq6+2vmYZOpBwHTWW2sx7+dvjK9mhazABxYXFp0Zod0a5IfefVqW4f
	PteFeEZJwwizzyT53Ktj1sEY15Uin2xSKEyzr/4hTA6TvxA9gv8FAlfD+RLAEcMc
	MUtt19FZd4HyxXvL3tZxh6qtge1HZSbIQy8gseXR9EQjBFqQVJTozOdV93Gk0QXZ
	6lJEymTzct5YZNaiPP3FjXH8QqYZIto2iCw==
X-ME-Sender: <xms:yPuFadfjUkGMaKbUDZuBjpkvLocMxk1ngZWrgf6-COIEdLLGQ5hNdQ>
    <xme:yPuFaSokBHet2QFY6W8U0MOvxmwlfYeQp_du2C43nsttI2bdus3iFf7NBxTGEs3Vl
    sVbHmYG9vHIWJpECFjqc3h_KzBb2S0Ig3RhGCL9m0O8Z23vfu4RaA>
X-ME-Received: <xmr:yPuFaT4qd1yYSgNNowueoOHU1pFToaZt3tpQCLLOpWL4Qukf4UXSbsPbBI1wuxHJMJTPFWhXRDeLUbDRG_NsNNe-wqCqZe0xSFIJ8mJtfjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:yPuFaQo0owybpaGERtw0bzW5e7eWTVqvpe2NsZbEBj5vMgtQggQMhw>
    <xmx:yPuFadif1xFQe9tCw-3BJggbK7kHwUZVKyivyrB0w6LOHOtoXQhXyw>
    <xmx:yPuFaSKgHAguSJpPrPhBIb5bDI8vbB5ux_zy_sJE2gnVQUz3jtUxUw>
    <xmx:yPuFaVDEObWiCtxIPAa4K6Val5n3uilFnMCLGaUsEk_wWsNqoyctZw>
    <xmx:yPuFaermztdNJmSakaOgl5uSytkrj7y-9OB3XmpFnnpw7bY2qqUfWNot>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 09:33:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc78155e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 14:33:42 +0000 (UTC)
Date: Fri, 6 Feb 2026 15:33:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 3/4] refs: parse and use the reference storage payload
Message-ID: <aYX7w5flfNe_bUFD@pks.im>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-3-3b30430411e3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-kn-alternate-ref-dir-v4-3-3b30430411e3@gmail.com>

On Mon, Feb 02, 2026 at 01:26:32PM +0100, Karthik Nayak wrote:
> The previous commit extended the 'extensions.refStorage' config to add
> support for a reference storage payload. The payload provides backend
> specific information on where to store references for a given directory.
> 
> Propagate this information to individual backends when initializing them
> via the 'init()' function. Both the files and reftable backends will
> parse the information to be filesystem paths to store references.
> 
> To enable this, provide a 'refs_compute_filesystem_location()' function
> which will parse the current 'gitdir' and the 'payload' to provide the
> final reference directory and common reference directory (if working in
> a linked worktree).
> 
> Finally, for linked worktrees, traditionally references were stored in
> the '$GIT_DIR/worktrees/<wt_id>' path. But when using an alternate
> reference storage path, it doesn't make sense to store main worktree
> references in the new path, and linked worktree references in the
> $GIT_DIR path. So, let's store linked worktree references in
> '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id'. To do this, create the

s/wt_id/&>/

> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index 532456644b..df86da6aa7 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -57,10 +57,24 @@ For historical reasons, this extension is respected regardless of the
>  `core.repositoryFormatVersion` setting.
>  
>  refStorage:::
> -	Specify the ref storage format to use. The acceptable values are:
> +	Specify the ref storage format and location to use. The value can be
> +	either a format name or a URI:
>  +
>  --
> +* A format name alone (e.g., `reftable` or `files`) uses the default
> +  location (the repository's common directory).
> +
> +* A URI format `<format>://<location>` explicitly specifies both the

I think I mentioned this before, but shouldn't we say payload instead of
location here? It may not be a location for all backends.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index fbdaf2eb2e..800a376ac5 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -425,6 +425,40 @@ static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
>  	return run_command(&cp);
>  }
>  
> +/*
> + * References for worktress are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
> + * But when using alternate reference directories, we want to store the worktree
> + * references in '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id>'.
> + *
> + * Create the necessary folder structure to facilitate the same. But to ensure
> + * that the former path is still considered a Git directory, add stubs (similar
> + *  to how we do in the reftable backend).
> + */

I think the last part in the braces isn't necessary to say anymore given
that we simply shell out to a function now.

> diff --git a/refs.c b/refs.c
> index 32b4edaf2d..c1d69082a9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2224,7 +2225,11 @@ static struct ref_store *ref_store_init(struct repository *repo,
>  	if (!be)
>  		BUG("reference backend is unknown");
>  
> -	refs = be->init(repo, gitdir, flags);
> +	/*
> +	 * TODO Send in a 'struct worktree' instead of a 'gitdir', and
> +	 * allow the backend to handle how it wants to deal with worktrees.
> +	 */

It would be nice if the commit message mentioned why this isn't done now
already.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 240d3c3b26..160ecb53b7 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -106,19 +106,24 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>   * set of caches.
>   */
>  static struct ref_store *files_ref_store_init(struct repository *repo,
> +					      const char *payload,
>  					      const char *gitdir,
>  					      unsigned int flags)
>  {
>  	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
>  	struct ref_store *ref_store = (struct ref_store *)refs;
> -	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf ref_common_dir = STRBUF_INIT;
> +	struct strbuf refdir = STRBUF_INIT;
> +	bool is_worktree;
> +
> +	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
> +					 &ref_common_dir);
>  
> -	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
> +	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
>  	refs->store_flags = flags;
> -	get_common_dir_noenv(&sb, gitdir);
> -	refs->gitcommondir = strbuf_detach(&sb, NULL);
> +	refs->gitcommondir = xstrdup(ref_common_dir.buf);

We can use `strbuf_detach()` instead to save an allocation and then use
`refs->gitcommondir` below.

>  	refs->packed_ref_store =
> -		packed_ref_store_init(repo, refs->gitcommondir, flags);
> +		packed_ref_store_init(repo, payload, ref_common_dir.buf, flags);
>  	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
>  	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);

Patrick
