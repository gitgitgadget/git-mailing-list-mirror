Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E12309AC
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732238476; cv=none; b=ktnp+VvsLzonCk4EBGjTitBq/YPPyQ6MlE3KjO+wxhFBCe1N1LNwSwztr7rRldXHSjC+R97ZDcK1Ochn/xHcWXx927xdQpkWpO7wJ+K9XwZyYHaVXj1Gc97qlEvCbSmkXl8gF7fpK5yTT6cx7kksTbA1T2anLCYRtLVbIRO80NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732238476; c=relaxed/simple;
	bh=vXwXriWx5a1R3G2fJ6wd9sS75SNEjwsRsweAO420FEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HcqS4iC9YWOGaAOQltw07CgWtk35WVT0YRmQwH30Iduks6NnmVWB8Nh+ox0cB9nJHAG6tmxX5IkDLJ1Noa4Nye7mQuq8EXRAKcpvij8ZHuFyJDBcsf3hiXR3CTBFLSL277KRDMo+sMAjD5MiO/25J46uDdsDHz11aMh58dVGYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XedZAuRU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XedZAuRU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F6BB13805FD;
	Thu, 21 Nov 2024 20:21:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 21 Nov 2024 20:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732238473; x=1732324873; bh=1Rq0jKueYHds8hZB4pn7OVE7MWOJupIFBMC
	348TaMJQ=; b=XedZAuRUD4CH/irg8bUR4Ml6wL81XIY401S6RHWYMNjB7ENvsm1
	+KA8k7JmCtODK1l0C32+RQIi7NNxn7CYFqmQPhcFX46NKjku00vZLTTQNhq5NXnH
	1YQKOpItE68ZbJv5GhiStNVZncQzqQw1bOK9uQJ/XTrks/Z+xzIcFaKi80QawfFM
	GlK9jWTCCDMC0lDCMo8TD+mLzjmwYOMeU+5aE+76zGgVdq7N/+8IK1rVA7F/reYz
	VixL+p3i44mThv+qzVtUsFAgjKG0qQ4vTpaqzlio12LJTUaBYpcKiueWmxoUO4P9
	q9jDlpq0h1f0J9+36S3CD4MitbwU5Xd8jKw==
X-ME-Sender: <xms:idw_Z_vKk6pQSCLopF30afWX5rXSlZLOAs7D20kVLxVVKnpxboOz-g>
    <xme:idw_ZwcLpXokxJJfG67TDRvegbR4gItD3BC_1HJF8uRXWfJN5SIrbTsrRB2beb_a7
    mKF6LiNoeMGi5DRmw>
X-ME-Received: <xmr:idw_ZyxUArQzKBdJIzLnZwVPPXXstNp88qvxPHbT1T_PclX79DXbGSoGXZEpsDzZnDfxKaPrbWUBKy4x6hsRgyJJ37Pc3OZTXw7K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:idw_Z-PKEMINs2SFXMrEMAxm5tXKofjFA2LGCA6GdV2pJzpifYUUqg>
    <xmx:idw_Z_8Y9tYgdzTJzJoS9GYY1TyEmkcw3AH2AZjo_aoTUKMCVUDg6A>
    <xmx:idw_Z-VaOE8JyVPmcqLuvdwwuF9NZohjEh6oB_vBqmh9poNMexkuJw>
    <xmx:idw_ZwcDYjBZsZ8f3pJJmFe-l7M2TBadhA39L7oAM1fKWACgSkOEOQ>
    <xmx:idw_ZyZYeXqMM89AoIM5XhR-kLbcJA_GALIM1darmWIa4aZPhHdtIY_b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 20:21:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] bundle: add bundle verification options type
In-Reply-To: <20241121204119.1440773-2-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 21 Nov 2024 14:41:15 -0600")
References: <20241121204119.1440773-1-jltobler@gmail.com>
	<20241121204119.1440773-2-jltobler@gmail.com>
Date: Fri, 22 Nov 2024 10:21:11 +0900
Message-ID: <xmqqy11ccbco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> diff --git a/bundle-uri.c b/bundle-uri.c
> index 0df66e2872..ed3afcaeb3 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -361,12 +361,16 @@ static int copy_uri_to_file(const char *filename, const char *uri)
>  
>  static int unbundle_from_file(struct repository *r, const char *file)
>  {
> -	int result = 0;
> -	int bundle_fd;
> +	struct verify_bundle_opts opts = {
> +		.flags = VERIFY_BUNDLE_QUIET |
> +			 (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0)
> +	};
>  	struct bundle_header header = BUNDLE_HEADER_INIT;
> -	struct string_list_item *refname;
>  	struct strbuf bundle_ref = STRBUF_INIT;
> +	struct string_list_item *refname;
>  	size_t bundle_prefix_len;
> +	int result = 0;
> +	int bundle_fd;

Unrelated changes to reorder the lines, without any justification
worth describing in the proposed commit log message, distracts and
discourages the reviewers from reading further on.  I would avoid
making such changes if I were doing this patch.

The _real_ change in the above hunk is that a new struct instance
"opts" is defined, with its .flags member initialized based on what
fetch_pack_fsck_object() says.  That helper function requires us to
be in a repository, but because you must have a repository to
unbundle into, that call is safe.

> @@ -379,8 +383,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
>  	 * a reachable ref pointing to the new tips, which will reach
>  	 * the prerequisite commits.
>  	 */
> -	result = unbundle(r, &header, bundle_fd, NULL,
> -			  VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0));
> +	result = unbundle(r, &header, bundle_fd, NULL, &opts);

We can see that .flags in the new structure gets the same value we
used to pass in the original, which is good.

> diff --git a/bundle.c b/bundle.c
> index 4773b51eb1..db17f50ee0 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -626,13 +626,17 @@ int create_bundle(struct repository *r, const char *path,
>  	return ret;
>  }
>  
> -int unbundle(struct repository *r, struct bundle_header *header,
> -	     int bundle_fd, struct strvec *extra_index_pack_args,
> -	     enum verify_bundle_flags flags)
> +int unbundle(struct repository *r, struct bundle_header *header, int bundle_fd,
> +	     struct strvec *extra_index_pack_args,
> +	     struct verify_bundle_opts *_opts)

Again, unrelated rewrapping of lines distracts and discourages the
reviewers from reading further on.  It looked as if the patch is
adding an extra parameter, until I read it again.

The real change here is that the enum is replaced with a struct that
has the same enum as one of its members, which is good.

Name the external-facing one (like this new parameter) _without_
funnies, and call it straight "opts".  The internal stand-in object
you create below can use funny convention but using "_" as prefix is
usually for system stuff (and the language standard forbids it, even
though people often do so in practice, from programs).

>  {
>  	struct child_process ip = CHILD_PROCESS_INIT;
> +	struct verify_bundle_opts opts = { 0 };
>  
> -	if (verify_bundle(r, header, flags))
> +	if (_opts)
> +		opts = *_opts;
> +
> +	if (verify_bundle(r, header, opts.flags))
>  		return -1;

This is an arrangement that looks strange, especially at this stage
of the series without reading the rest.  If verify_bundle() takes
the enum and not &opts, there is no need for stand-in opts struct.
You can have a local enum "flags" that is initialized to 0 and only
when parameter "opts" is not NULL, assign opts->flags to it and use
it throughout the rest of the function.  Reviewers will be left
confused wondering why the patch does this in an unnecessarily more
complex way by using an extra structure instance.

Until you start needing other fields of opts in the function,
perhaps in a later step, that is.

> @@ -641,7 +645,7 @@ int unbundle(struct repository *r, struct bundle_header *header,
>  	if (header->filter.choice)
>  		strvec_push(&ip.args, "--promisor=from-bundle");
>  
> -	if (flags & VERIFY_BUNDLE_FSCK)
> +	if (opts.flags & VERIFY_BUNDLE_FSCK)
>  		strvec_push(&ip.args, "--fsck-objects");

And this is a fallout of the above "strange" arrangement.

>  {
> +	struct verify_bundle_opts opts = { .flags = fetch_pack_fsck_objects() ?
> +							    VERIFY_BUNDLE_FSCK : 0 };

	struct verify_bundle_opts opts = {
		.flags = fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0,
	};

to avoid overly long lines, and prepare for a future you add more
members to the structure (the trailing comma helps).

