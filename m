Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2517E4
	for <git@vger.kernel.org>; Fri, 16 May 2025 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374048; cv=none; b=i5ta6MJZr4nuygld08dghUCdnZLpdcCL3huL/78m3u+awaG3WbF8/krwT3ktzarp58oQupS3brh0TP+N2XfMDyl2RjPYc1M6ulm2xYcuuXSkT5MB3UQZuNJ/gC6Fp20T1/oPQhGkzhICigNtn9m/xLXDIbycPJpoueTpt/aOCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374048; c=relaxed/simple;
	bh=qHlsd5i0qa2O4T9MxgkMggY+Pf/RDH7QdtWe3Okf0dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVtr9YK+Mo52dbE4fvK3YgPklnp/0Im3Ck7NvyOtfOmooYdA8NIYjzteM8DXrUmV+Jpm7FdaEuPF2vmAK+Sc8XUVgjxU2zaqqDjcmlnhBZ7Ufb4k8YwGCCTNSUU3ZgrftloK3n9niTKJQGg5A6cHXLJ8XaZCSxTvRHK86XAAGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tipMbSJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wBduXRjf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tipMbSJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wBduXRjf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 786B4114016F;
	Fri, 16 May 2025 01:40:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 16 May 2025 01:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747374045; x=1747460445; bh=aveSt08Nw/
	nZMOa9SY3XJBx7yodTn0n2fqhsz+rX8yE=; b=tipMbSJrTmP/xbyEKUXnH9DQDe
	w9WKFkLLB58efOIdUmu+CseSUkwQ46ZVk0eKdx/IdEfzmK5ss95R1NHWqELxX6iO
	zUEmFLh8HiYXK7duC1KzafR68HJgnQeT2/u5ymgjBayBmHc537upigihNVSBaMaR
	7eGBhU8PzBRtAw/e6VDt+BDrz3HwBewr/38yKQW1xZhg7XTNEYXm/fVVzITcjntn
	PnuG2vzSIutxlt0gaSRuBR4OrMkAGbbsnTEi/QZd14STJ2BJtZOalApQt+YrqBZr
	ByWdJoik+9d+JUsow+FZNUSlC/k2m8krFMHRU9cdx0gQM1VfJyE9Ap15hmXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747374045; x=1747460445; bh=aveSt08Nw/nZMOa9SY3XJBx7yodTn0n2fqh
	sz+rX8yE=; b=wBduXRjfEwzgvhfKWxzf1ZeaiDv8ierwZzER9brh1Ol/7I/QeT7
	2cQ7hHw/zLjl3fWX6uVtY3dDeEK7L7Zh8jf2OJEgw//m18twyXcyrylcvorNBs9u
	Zi6yj6fnIdYPeFpnjUN2zGXnqZxOrEQRXK9fe5/gHcNeP/MdYkSSGB7+EX2weSaE
	3Wd1nUeGifsSuTOm4I1Pbl5GWTuFq8ZFLgVjZuXGdC7Zw4Vq9agZfYDErKNzhKif
	yDX9SfxQnAEJMbfFLqjN286cDt3FYeIDGMMZ3boRZebRwkdKxlcsiFQwvfchevOB
	XkcdxGGii0gwpWkhImzmU5j3qX3lwQwVZEg==
X-ME-Sender: <xms:3c8maNIPuRO0viCPgNWuyf2bDrtI8q-sMsLVjnGyqQ9HUK_eqnK58w>
    <xme:3c8maJKEkKNELzj16FmgPaJYJ3ccftKa4dBl29dyP_cpQH3SU06Zm0Sxq9Ijol-7g
    -GuYkFD_-erCugj2w>
X-ME-Received: <xmr:3c8maFv2m0VIuxI568sAIUnL5T3cxbDV-Y4kT4_JMjOcvglgXgp2Ohjo4AD5DEm3DExlDkytHA3rXbLhjfnPAvlmZ2FAp9bfX6Sqafsx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:3c8maOYShQ1DE1nMS_CxLINVlqxo40dPNhYwi1X4MDh-paB0TTLc3A>
    <xmx:3c8maEZ072z2j6LoGeppEdjXwf47ZNYIJgc_XrMXuRiAJPRE79qrGg>
    <xmx:3c8maCAC2ulwTEml8dpRnXJ_SzPce0L6uwLTa_imCKbChvGyhVIyzw>
    <xmx:3c8maCY52ZeZUJJDyroQRBK-8l0zmbi_R5U0SEU9iCwtIXcknBvmFw>
    <xmx:3c8maPdr7xvUoUBu8m-CP8HHx4acMz-SrPC5LPxWw1n4um8eN_XTQoGh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 01:40:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id becd4a77 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 05:40:42 +0000 (UTC)
Date: Fri, 16 May 2025 07:40:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/4] fetch: use batched reference updates
Message-ID: <aCbP1SxncSVw2fCa@pks.im>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-2-80cbaaa55d2e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-2-80cbaaa55d2e@gmail.com>

On Thu, May 15, 2025 at 04:07:26PM +0200, Karthik Nayak wrote:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 5279997c96..15eac2b1c2 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1688,6 +1644,37 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
>  	return result;
>  }
>  
> +struct ref_rejection_data {
> +	int *retcode;
> +	int conflict_msg_shown;
> +	const char *remote_name;
> +};
> +
> +static void ref_transaction_rejection_handler(const char *refname,
> +					      const struct object_id *old_oid UNUSED,
> +					      const struct object_id *new_oid UNUSED,
> +					      const char *old_target UNUSED,
> +					      const char *new_target UNUSED,
> +					      enum ref_transaction_error err,
> +					      void *cb_data)
> +{
> +	struct ref_rejection_data *data = (struct ref_rejection_data *)cb_data;

Nit: unnecessary cast.

> +	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
> +		error(_("some local refs could not be updated; try running\n"
> +			" 'git remote prune %s' to remove any old, conflicting "
> +			"branches"), data->remote_name);
> +		data->conflict_msg_shown = 1;
> +	} else {
> +		char *reason = ref_transaction_error_msg(err);
> +
> +		error(_("fetching ref %s failed: %s"), refname, reason);
> +		free(reason);
> +	}
> +
> +	*data->retcode = 1;
> +}

Okay, we stopped ignoring generic errors now and will print them. What
I'm still unclear about: which exact errors do we accept now that
`REF_TRANSACTION_ALLOW_FAILURE` is specified? Most of the error codes we
probably want to accept, but what about `REF_TRANSACTION_ERROR_GENERIC`?

This makes me wonder a bit about the current layout of how we handle
these errors. If the rejection handler was invoked while preparing the
transaction for each reference as we go instead of afterwards we could
decide on-the-fly whether a specific error should be ignored or not.
That might lead to a design that is both more flexible and more obvious
at the same time because error handling is now handled explicitly by the
callsite that wants to ignore some errors.

Last but not least, I think that it would also allow us to decide ahead
of time whether we want to commit. Right now we basically say "just
commit it, whatever happens". But if I'm not mistaken, all the errors
that we care about and that callers may want to ignore are already
detected at prepare time. So if we already bubbled up relevant info
while calling `ref_transaction_prepare()` the caller may then decide to
not commit at all based on some criteria.

Sorry, I should've probably proposed this when you introducued this
mechanism. But sometimes you only see things like that as we gain more
users.

> @@ -1808,6 +1795,24 @@ static int do_fetch(struct transport *transport,
>  			retcode = 1;
>  	}
>  
> +	/*
> +	 * If not atomic, we can still use batched updates, which would be much
> +	 * more performant. We don't initiate the transaction before pruning,
> +	 * since pruning must be an independent step, to avoid F/D conflicts.
> +	 *
> +	 * TODO: if reference transactions gain logical conflict resolution, we
> +	 * can delete and create refs (with F/D conflicts) in the same transaction
> +	 * and this can be moved about the 'prune_refs()' block.

s/about/above/?

Patrick
