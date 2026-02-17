Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BCF280325
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313076; cv=none; b=ZfGIc1VJEQhZqQzBMFWFKJp4Ac4ZnYP95Y93OYiDSTDG0Nwzu4gKCGcXlQ3/F3SlwfNgUyqDMq0mxwrqQGXuIM130Muw2uN5WOj01aeR4axm3I7LZCKLCwZwhBc6mdW+ZV2EPNr5Syjjbcnchgd560X7FhW5oUXoKE1NTAfnzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313076; c=relaxed/simple;
	bh=pz6i8vdwzA4IjeiSCIxauvCRkoRY5awx4AI2R8oWPYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppO9rpu4/CGnnykMEaQauWTKftTXbylT/1PKRWyt7ICu0NsC+SlIzMWQQeKFrewI4w3sl8EP7e+27JMVOGYIjYbwTsbYpiPNxJ4veJWCd1/m7GJ4z50DhsLj13jINk2SV0QZw233UPB/EdI9/HcnxR55K/VhBtwjqrmxmc/pnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pZLM5/Hv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNaCy+19; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pZLM5/Hv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNaCy+19"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24E5F7A034E;
	Tue, 17 Feb 2026 02:24:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 17 Feb 2026 02:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771313074; x=1771399474; bh=gNN15iSSXL
	QRv8oqcnzDoldbr3cnE/x3AjAm1SFIfNo=; b=pZLM5/HvW/5OepImIRsmFUKm1l
	1VtmoBgqaIxVw1yT+wRjAAwsJuUgZbMt3qOGQ2uUzNTB92WYhWbF4jBSIRYIdr9t
	/TfABKfDtz9f9Pfd2MCBGP4QFrSpGQZy26xdQxAS/BSc+qMBw+AFBiQwbN/Mralz
	pPOiRpJO/J/fx6Ic25SwQuByKcleuzhBtzYoGpvUFuLdPBbzcyahcfcyb5vTDkI/
	f5sSdwL1hCDQMd6C0DzC6vLqYaseeSfj70pMMQRwmRoHTdFVPRTPtsib+XYeCQ7p
	fMwFUyBmNT7p/Ypq89we27Fyba5HYr8g4qPHMIq1O4WUXzpimNyVKZCb/WBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771313074; x=1771399474; bh=gNN15iSSXLQRv8oqcnzDoldbr3cnE/x3AjA
	m1SFIfNo=; b=PNaCy+19lOfId/8k5qK8mzhTFn2OOM9L2ZbJfOTYTwsL4KXKUtd
	Dfep88p8IzkNfbMj+uuXiGCqABozNaW6VdOUY9WIsJjeVT1AkayfSvViPAT/wdYN
	vw10ncMlyfUClEw4JqSYpn8SSjmwGOjXJPV+ByB2z1WX9RfQolLL8WV5FnYjg5T3
	enMjZNFJedYOGgVvkBp98ckaaRpXtSiNY1sIsN0AhknD/D4uohOduWNq25ut+27T
	SDOnWaGz6bfCr25aHIVBvaOBEHJCZKGwM6h1qz2mwdATIDipRDswtZoQqM8ciBwH
	ZxsuW24LNC3UicOK/oxj9IQq7KM4nCp1bqg==
X-ME-Sender: <xms:sReUaYobldlJAo1QtJpxlBNVKVPXKJKCgrgOjIFXj5i4lgme43MBuA>
    <xme:sReUaVp2oQ0XfTd7Pk8C8J7aOXcmVX_lJ7c4xI9x6z6kptZu9o1ltylD0_7gForb3
    TlikMDItz8yiBR_yKu93LRKFggyn-VHJxW613ZqRY2Kn6Vusvyasb8>
X-ME-Received: <xmr:sReUaSNO9nIYzk16jvcb2Js_dqvd0OTmkrF42d8U-Ds5gDfKPQaB4mXcD9uWvg6pzABJHO25_U_Whe9UTEgKo_fR4c75W6yL3NnejnjyZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeludehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sReUaezEdngJSlO99umGzyKxL1P-z7U5zeC0Zr-LEdcwp2Nbg4EiDA>
    <xmx:sReUaTsWT97AFJag5pPoI7fhzH1j-rB_WDGsP50lEtFxYtQfO7ObzQ>
    <xmx:sReUaf7Gn6w3L5rd77FJN5LEsU8n_t9WdXWVRLmKt5lCoMHHlA2xqA>
    <xmx:sReUaaQB40pGcMfxIZQbx-75W_MlIiuOY1VnYYUinuIhoKZPj9fw9w>
    <xmx:sheUaTPJd4bt5vqKqX_wVBjZ0RD9NvoY-orh8laEz3SEmTW4lKiS9hyL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 02:24:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b1836d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 07:24:31 +0000 (UTC)
Date: Tue, 17 Feb 2026 08:24:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v6 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
Message-ID: <aZQXrRuX3nsnuyEw@pks.im>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-6-86a82c77cf59@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214-kn-alternate-ref-dir-v6-6-86a82c77cf59@gmail.com>

On Sat, Feb 14, 2026 at 11:34:19PM +0100, Karthik Nayak wrote:
> Git allows setting a different object directory via
> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references. In
> the previous commit we extended the 'extensions.refStorage' config to
> also support an URI input for reference backend with location.
> 
> Let's also add a new environment variable 'GIT_REFERENCE_BACKEND' that
> takes in the same input as the config variable. Having an environment
> variable allows us to modify the reference backend and location on the
> fly for individual Git commands.
> 
> The environment variable also allows usage of alternate reference
> directories during 'git-clone(1)' and 'git-init(1)'. Add the config to
> the repository when created with the environment variable set.
> 
> When initializing the repository with an alternate reference folder,
> create the required stubs in the repositories $GIT_DIR. The inverse,
> i.e. removal of the ref store doesn't clean up the stubs in the $GIT_DIR
> since that would render it unusable. Removal of ref store is only used
> when migrating between ref formats and cleanup of the $GIT_DIR doesn't
> make sense in such a situation.

Nice.

> diff --git a/refs.c b/refs.c
> index 87ef54abd4..6b3883a325 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2192,16 +2192,21 @@ int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *e
>  {
>  	int ret = refs->be->create_on_disk(refs, flags, err);
>  
> -	if (!ret &&
> -	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
> -		struct strbuf msg = STRBUF_INIT;
> -
> -		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
> -		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
> -		strbuf_release(&msg);
> +	if (!ret) {
> +		/* Creation of stubs for linked worktrees are handled in the worktree code. */
> +		if (!(flags & REF_STORE_CREATE_ON_DISK_IS_WORKTREE) && refs->repo->ref_storage_payload) {
> +			refs_create_refdir_stubs(refs->repo, refs->repo->gitdir,
> +						 "repository uses alternate refs storage");
> +		} else if (ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
> +			struct strbuf msg = STRBUF_INIT;
> +			strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
> +			refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
> +			strbuf_release(&msg);
> +		}
>  	}

Okay, this here is the reason why you've moved the stub creation into
the generic parts. Makes sense.

>  
>  	return ret;
> +
>  }

There's a stray newline here.

> diff --git a/setup.c b/setup.c
> index d407f3347b..90cb9be578 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2337,7 +2357,8 @@ void initialize_repository_version(int hash_algo,
>  	 * the remote repository's format.
>  	 */
>  	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
> -	    ref_storage_format != REF_STORAGE_FORMAT_FILES)
> +	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
> +	    the_repository->ref_storage_payload)
>  		target_version = GIT_REPO_VERSION_READ;
>  
>  	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)

Right. If we've got a payload during init we know that we must use the
repository extension. Makes sense.

> @@ -2346,11 +2367,20 @@ void initialize_repository_version(int hash_algo,
>  	else if (reinit)
>  		repo_config_set_gently(the_repository, "extensions.objectformat", NULL);
>  
> -	if (ref_storage_format != REF_STORAGE_FORMAT_FILES)
> +	if (the_repository->ref_storage_payload) {
> +		struct strbuf ref_uri = STRBUF_INIT;
> +
> +		strbuf_addf(&ref_uri, "%s://%s",
> +			    ref_storage_format_to_name(ref_storage_format),
> +			    the_repository->ref_storage_payload);
> +		repo_config_set(the_repository, "extensions.refstorage", ref_uri.buf);
> +		strbuf_release(&ref_uri);
> +	} else if (ref_storage_format != REF_STORAGE_FORMAT_FILES) {
>  		repo_config_set(the_repository, "extensions.refstorage",
>  				ref_storage_format_to_name(ref_storage_format));
> -	else if (reinit)
> +	} else if (reinit) {
>  		repo_config_set_gently(the_repository, "extensions.refstorage", NULL);
> +	}
>  
>  	if (reinit) {
>  		struct strbuf config = STRBUF_INIT;

And here we write the payload into the configuration, if we've got one.

> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
> index 9912433b8c..b743c03a59 100755
> --- a/t/t1423-ref-backend.sh
> +++ b/t/t1423-ref-backend.sh
[snip]
> +test_expect_success 'initializing repository with alt ref directory' '
> +	test_when_finished "rm -rf repo refdir" &&
> +	mkdir refdir &&
> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
> +	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
> +	(
> +		cd repo &&
> +
> +		git config get extensions.refstorage >expect &&
> +		echo $BACKEND >actual &&
> +		test_cmp expect actual &&
> +
> +		test_commit 1 &&
> +		test_commit 2 &&
> +		test_commit 3 &&
> +		git refs list >out &&
> +		test_grep "refs/tags/1"	out &&
> +		test_grep "refs/tags/2"	out &&
> +		test_grep "refs/tags/3"	out
> +	)
> +'

Should we also verify that the refdir contains the data and that the
repository only contains stubs?

> +test_expect_success 'cloning repository with alt ref directory' '
> +	test_when_finished "rm -rf source repo refdir" &&
> +	mkdir refdir &&
> +
> +	git init source &&
> +	test_commit -C source 1 &&
> +	test_commit -C source 2 &&
> +	test_commit -C source 3 &&
> +
> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
> +	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
> +
> +	git -C repo config get extensions.refstorage >expect &&
> +	echo $BACKEND >actual &&
> +	test_cmp expect actual &&
> +
> +	git -C source for-each-ref refs/tags/ >expect &&
> +	git -C repo for-each-ref refs/tags/ >actual &&
> +	test_cmp expect actual
> +'
> +

Same question here.

Thanks!

Patrick
