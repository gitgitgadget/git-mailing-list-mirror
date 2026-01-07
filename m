Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6D2F7ACA
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780339; cv=none; b=hcNtz5FP8RPBQu0fbfs1MSi5Lj6NE1ScSvIKAOwAYrfCE/yiCfCSrOElc7CfifQvI6ZRAqKElB4gY+dRBWV75HNCvYhshmsOab3UJ8SWfXwfDhnNmo8b1/6b3/HfeSI3f9ebDLtF9XoN74L5LBdetvqlCNAgwPd8iCXrJXuJMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780339; c=relaxed/simple;
	bh=2VRk4qZ9RGVI3ZnUnwkjj1qz5/tFAuG635Q6Mu/jRuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYRw7agYtiFavU+WUXCJL3lhgIGZ30AFJQxovHrF7SXp3xWUVVs4H1qg/EWHcwHf6n3w05AUnzuSqMQMRgXGgXdH1S9wgt7UZipxZj5/0yfincJvmbWVNupxC+s4rFOydNleatbAfvxPlJxoE9WthBv5OxgyXeyYS637JIZ4Tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QCHWP14t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=koe5jNa7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QCHWP14t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="koe5jNa7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5490A1400171;
	Wed,  7 Jan 2026 05:05:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 05:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767780336; x=1767866736; bh=lDAh9I9PJS
	HUJ9Gj5NNGjiJSp1uHVoSNerd/IGWbNOg=; b=QCHWP14tt98k6XPlSR64os0D1h
	oCJah2Fq5+zpSMB46Frd1Ism+FiAPz555iDOtypbJuqOOASonXY3nbVqE9nSL6Pk
	56DLwH2sOKMB3iW4HH9p3qF24LioC7f9Nl8wVZY3/2Au/yeVC4jww6qLJUgE7VHg
	g2vZDMcWC++b4J04+XzxR9Tay62j8y/1oyE4fQFyglOu3/doE70CgXM9yoTPmB8C
	9TTn5tldCyc6UjTFNIlM2g7IiUJhqavkMNqYCOXpnhtvh8CLzBRbcgB/seO4wCbc
	jWMH+KKS2Tjpu8vsn/YuxYeQCL/hHbAdRguhfCN/xUwRf2eCLnzYfP2OL7PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767780336; x=1767866736; bh=lDAh9I9PJSHUJ9Gj5NNGjiJSp1uHVoSNerd
	/IGWbNOg=; b=koe5jNa7zzvyzD+KVo2wV6xSPFGofyZ6uXeFOQ5SQxYpoTEjJWl
	+vSKjDlimq/R6rwU+Qqr00ZzIWoCTi7ukuK3sKqXtLUd4D68LF0nGnmWIvW0uQPY
	aJKOPO3R2dcXdo+9bQM1USiYycfynJ6bDwBBhBAqQFBvJQ4/QWisT3opdDoAhKOb
	kN60CWwx1RlX6NmGsREuUQ7Sl1v8+PCp6oJ/3/xG1Rs6DrcDbDfbInJDOa8KQAw5
	6VEu8M1hLmlIJp3FQ8/CDJ8hEcrTleUiWpSemJDlP9RiQa+wMdg93aAi82llKFMY
	vdHLkZBZoc9GIomhLKVHVa8v8FVo0dSd9OQ==
X-ME-Sender: <xms:8C9ead4lJhg4vFv_Ok69RsehvCLnHlCx-M5r4uFJvVnLhJca5qp-hA>
    <xme:8C9eadKXufk0QkLxUmtOHQGkNruhApaJLtLF4b39g2GWdGg2tmgYCOR5cbKXJUz6-
    IqIT-tJMxTc-T2OATXwcR5-egOOObrAyY07_2kQF3hbnud7_adZmw>
X-ME-Received: <xmr:8C9eaWssSA_bgo_X4_ZubGxNJI-g8M8890gWJy9iT7_pKT90_kSWqnmc42hi46h92M6E2X5aToq6Nym7kT-WabNVk5xgxWuK6dD2RjFahbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8C9eacJ59qSqAvXpZrPbUz0RK1xr8JzRrRVWK31LWrXWWgRNl9ojtg>
    <xmx:8C9eaf_34nBHFIRp1Awv0dMkuL4ZXi1CZ5hmrK0jKDpdrFjcHNqyzg>
    <xmx:8C9eaVwR1A7p6KnLylyfDRtjseHSkNDFVDxWyDjud2vmqCHEt3M7xg>
    <xmx:8C9eac5njhRI5kwTqGxP2IxzUJjOtMgJgbK5c0wrN5IRXR41cQrYSg>
    <xmx:8C9eaR6UC4iBD_KcieyV7J7NBb5M6Bw3mCVTdVZNr-6RBRaOPUonXEZi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:05:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 236c8469 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:05:33 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:05:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/9] list-objects-filter-options: support 'auto' mode for
 --filter
Message-ID: <aV4v6_DFJtraLlPI@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-7-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223111113.47473-7-christian.couder@gmail.com>

On Tue, Dec 23, 2025 at 12:11:10PM +0100, Christian Couder wrote:
> In a following commit, we are going to allow passing "auto" as a
> <filterspec> to the `--filter=<filterspec>` option, but only for some
> commands. Other commands that support the `--filter=<filterspec>`
> option should still die() when 'auto' is passed.

Okay. I assume the idea is that the user can eventually say `git clone
--filter=auto`, and Git would automatically pick the best filter
advertised by the remote. Sounds reasonable to me.

> Let's set up the "list-objects-filter-options.{c,h}" infrastructure to
> support that:
> 
> - Add a new `unsigned int allow_auto_filter : 1;` flag to
>   `struct list_objects_filter_options` which specifies if "auto" is
>   accepted or not.
> - Change gently_parse_list_objects_filter() to parse "auto" if it's
>   accepted.
> - Make sure we die() if "auto" is combined with another filter.
> - Update list_objects_filter_release() to preserve the
>   allow_auto_filter flag, as this function is often called (via
>   opt_parse_list_objects_filter) to reset the struct before parsing a
>   new value.
> 
> Let's also update `list-objects-filter.c` to recognize the new
> `LOFC_AUTO` choice. Since "auto" must be resolved to a concrete filter
> before filtering actually begins, initializing a filter with
> `LOFC_AUTO` is invalid and will trigger a BUG().
> 
> Note that ideally combining "auto" with "auto" could be allowed, but in
> practice, it's probably not worth the added code complexity. And if we
> really want it, nothing prevents us to allow it in future work.

I guess the question is what this would even mean, and I cannot think
of any benefit to allow `--filter=combine:auto+auto`. So agreed

> If we ever want to give a meaning to combining "auto" with a different
> filter too, nothing prevents us to do that in future work either.

So basically the case where the user knows that they definitely don't
want blobs, and in addition they want to pick the best filter advertised
by the server? Yeah, that sounds like it could eventually be a nice
addition.

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 7420bf81fe..f13ae5caeb 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -52,7 +54,17 @@ int gently_parse_list_objects_filter(
>  	if (filter_options->choice)
>  		BUG("filter_options already populated");
>  
> -	if (!strcmp(arg, "blob:none")) {
> +	if (!strcmp(arg, "auto")) {
> +		if (!filter_options->allow_auto_filter) {
> +			strbuf_addstr(
> +				errbuf,
> +				_("'auto' filter not supported by this command"));

Tiny nit: the indentation looks a bit weird here.

> @@ -146,10 +158,20 @@ static int parse_combine_subfilter(
>  
>  	decoded = url_percent_decode(subspec->buf);
>  
> -	result = has_reserved_character(subspec, errbuf) ||
> -		gently_parse_list_objects_filter(
> +	result = has_reserved_character(subspec, errbuf);
> +	if (result)
> +		goto cleanup;
> +
> +	result = gently_parse_list_objects_filter(
>  			&filter_options->sub[new_index], decoded, errbuf);
> +	if (result)
> +		goto cleanup;
> +
> +	result = (filter_options->sub[new_index].choice == LOFC_AUTO);
> +	if (result)
> +		strbuf_addstr(errbuf, _("an 'auto' filter cannot be combined"));

Nit: let's maybe also add the `goto cleanup` here. I'm not a fan of
leaving it away for the final statement as it makes it easy to forget
backfilling it in case this function needs to be extended in the future.

> @@ -317,6 +345,7 @@ void list_objects_filter_release(
>  	struct list_objects_filter_options *filter_options)
>  {
>  	size_t sub;
> +	unsigned int allow_auto_filter = filter_options->allow_auto_filter;
>  
>  	if (!filter_options)
>  		return;
> @@ -326,6 +355,7 @@ void list_objects_filter_release(
>  		list_objects_filter_release(&filter_options->sub[sub]);
>  	free(filter_options->sub);
>  	list_objects_filter_init(filter_options);
> +	filter_options->allow_auto_filter = allow_auto_filter;
>  }

Why do we do this extra step to restore the `allow_auto_filter` option
here? Are there any callers that reuse the filter after it has been
released?

In any case, this function does have clearing semantics as it also knows
to re-init the filter options. So it's somewhat misnamed and really
should be called `list_objects_filter_clear()` according to our coding
guidelines. That's certainly outside the scope of this patch series
though.

Patrick
