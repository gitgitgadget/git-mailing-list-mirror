Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C734F26F
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553299; cv=none; b=VIv4mVcG3FkCzqAqUckqjXYzrqUoyJpz9vWWlMP1rmkWzMERn7+DJUyAZIiTNCll51LVBHkL+48N30iSyI8LRGsoWMLkA9kDxcjRzK6h28gfRT1K+UfpfZBr5vjvwC5IdWRfEbbutxE7HEoZOvG1/ylzS7atxtMkPTrH4dUzAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553299; c=relaxed/simple;
	bh=2R5LTQnVghjUjb/WbAUe6x2xfYuUm5tx6cF+uQXkd4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V0NFJwOpi8kD8Ch9MghG0JHr/eLO6c02qKPEXae7VaYhOaMNxUtLJrT3pMITiGYBnwkGBStdLP5dZbVaO7tmmptcd6v61L4oVzRf2ANRgI+QM4iIN2ceV8SFvuu3P1f/vKWrFtBpxG31x8Du/DBhKgROmtMN+3DZoIdh29yc0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P+xKqzy3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Poh44FxD; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P+xKqzy3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Poh44FxD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B15E1400230;
	Thu, 26 Mar 2026 15:28:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 26 Mar 2026 15:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774553297; x=1774639697; bh=UnZfyUuy3G
	YwZOJogCDGpIgRpgij2z26QhieQQ5rjeA=; b=P+xKqzy35XUK6rLXrvM0oRbrr1
	RnL8tNMCkGy9ZbdU/iUX7RP3v0wWCQfMS2l4Vd+JQ+i7YOiNMiitHrjCf1jqSJD6
	Za9wGNKkO9O6n6sWWhyMcvGi2WCXt1wSRl4GPqt2iEsNbz5lJsUd0Cb1f2IY2Yq3
	RSfBnNCaigVLj5pjvpRF3rSbrFTA9FQc+3IuKGDaBPRkItBm7PR+Asaoxb+CIIys
	8X1M3S6wjQQmaGawEulnt8WKd0vEB2/e9Unm8k1ZB+PgRXhXVuJyUbnbOSRO6VCz
	je+nyOKQ4J4CZCo9UsUtB7R8Zt9B6YYdmWOkCwKEVv0e6jEg+7FSmwvpFCTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774553297; x=1774639697; bh=UnZfyUuy3GYwZOJogCDGpIgRpgij2z26Qhi
	eQQ5rjeA=; b=Poh44FxDd6cNe8xUUhldrRuazN2R9pqUcy9aUkENnXlVDLIUUvC
	+1wNflp4jZIicYkVK+qKtBheyuIh2610qVxbylxlzCyVEEkA2VuXL1HDWOG+PhWa
	SBwOc/+52ex3ELDXN88ZEsnNU5s8ORt+yqszUUW9FVf1dWG/tPS9ww1tZy3fyvcx
	1vuSnk+w/jtl8amFo+n0Ywui6kx5Nj5gby43V3bxhikdSazodVQrofNXqnG3RSFk
	prfo0zZMLeMY2b8Lcpxb4UimSjjsmfNfPZm5xTThK4cSLMPb3riTMqIoH1g0E9jE
	6wchjVmmbjieWf2a0Yi9QiEC0N3uInuy5lw==
X-ME-Sender: <xms:0YjFaam-JwPSAoATc_gWQXLBEv-Fn4N9fJZzwYU6_jPylb7YC3CueQ>
    <xme:0YjFaY3EMsINQJF_q7BWBTvytXA7Ldb3NFE6X8NsTz_GJI4zgWj1MieD6II0dksTa
    R_WnDY6Kcm4KjwNktZTWy5W7LWkrq7dpu-EJbrddXKVtmZ_rhsTDQ>
X-ME-Received: <xmr:0YjFadprGjKaCtxybPkkk4YxdQID7hqbT6L2CSWoEsFimS-DPCjXKHRdNCsP8OO6vHfAmJjfLNymKcwNkf8by2rizW6HdYwMCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0YjFadfVPWRDgW3TGVImJa43QpvHbGOpSf08CcrZb4NrIVzONdJtvQ>
    <xmx:0YjFaUps6H0iXJS4yBwLJOIkFrpP_66lvl5oxln6vf1kb7uus6kwyg>
    <xmx:0YjFaWHlDrzDNQVmKcPuxUA8VIC6n2iWiLUlv7_HOxmxtpGIxeOq-Q>
    <xmx:0YjFacvjw49XORcOXBWoevaEtzCDt9xkLi2hDdNqzkqFwgdEi_5h3g>
    <xmx:0YjFaTlHk49RSVtgTBQBcfwelzpSNnEvwCP1T7g6vZgTDJyYzWMHd9jr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 15:28:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael J Gruber <git@grubix.eu>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] revision: make handle_dotdot() interface less
 confusing
In-Reply-To: <20260326190444.GA415796@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 26 Mar 2026 15:04:44 -0400")
References: <20260326190243.GA412983@coredump.intra.peff.net>
	<20260326190444.GA415796@coredump.intra.peff.net>
Date: Thu, 26 Mar 2026 12:28:15 -0700
Message-ID: <xmqqikaipf00.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> There are two very subtle bits to the way we parse ".." (and "...")
> range operators:
>
>  1. In handle_dotdot_1(), we assume that the incoming arguments "dotdot"
>     and "arg" are part of the same string, with the first digit of the

"digit" -> "dot".

>     range-operator blanked to a NUL. Then when we want the full name
>     (e.g., to report an error), we replace the NUL with a dot to restore
>     the original string.
>
>  2. In handle_dotdot(), we take in a const string, but then we modify it
>     by overwriting the range operator with a NUL. This has worked OK in
>     practice since we tend to pass in buffers that are actually
>     writeable (including argv), but segfaults with something like:
>
>       handle_revision_arg("..HEAD", &revs, 0, 0);
>
>     On top of that, building with recent versions of glibc causes the
>     compiler to complain, because it notices when we use strchr() or
>     strstr() to launder away constness (basically detecting the
>     possibility of the segfault above via the type system).
>
> Instead of munging the buffer, let's instead make a temporary copy of
> the left-hand side of the range operator. That avoids any const
> violations, and lets us pass around the parsed elements independently:
> the left-hand side, the right-hand side, the number of dots (via the
> "symmetric" flag), and the original full string for error messages.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

OK.  I was hoping if we can do without a temporary allocation, but
the const-string "..HEAD" example does make it clear that it is not
something we can achieve easily.

And once we accept that it is inevitable to make a copy, everything
else falls into the right place.

> diff --git a/revision.c b/revision.c
> index 31808e3df0..f61262436f 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2038,41 +2038,32 @@ static void prepare_show_merge(struct rev_info *revs)
>  	free(prune);
>  }
>  
> -static int dotdot_missing(const char *arg, char *dotdot,
> +static int dotdot_missing(const char *full_name,
>  			  struct rev_info *revs, int symmetric)
>  {
>  	if (revs->ignore_missing)
>  		return 0;
> -	/* de-munge so we report the full argument */
> -	*dotdot = '.';
>  	die(symmetric
>  	    ? "Invalid symmetric difference expression %s"
> -	    : "Invalid revision range %s", arg);
> +	    : "Invalid revision range %s", full_name);
>  }
>  
> -static int handle_dotdot_1(const char *arg, char *dotdot,
> +static int handle_dotdot_1(const char *a_name, const char *b_name,
> +			   const char *full_name, int symmetric,
>  			   struct rev_info *revs, int flags,
>  			   int cant_be_filename,
>  			   struct object_context *a_oc,
>  			   struct object_context *b_oc)
>  {
> -	const char *a_name, *b_name;
>  	struct object_id a_oid, b_oid;
>  	struct object *a_obj, *b_obj;
>  	unsigned int a_flags, b_flags;
> -	int symmetric = 0;
>  	unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
>  	unsigned int oc_flags = GET_OID_COMMITTISH | GET_OID_RECORD_PATH;
>  
> -	a_name = arg;
>  	if (!*a_name)
>  		a_name = "HEAD";
>  
> -	b_name = dotdot + 2;
> -	if (*b_name == '.') {
> -		symmetric = 1;
> -		b_name++;
> -	}
>  	if (!*b_name)
>  		b_name = "HEAD";
>  
> @@ -2081,15 +2072,13 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
>  		return -1;
>  
>  	if (!cant_be_filename) {
> -		*dotdot = '.';
> -		verify_non_filename(revs->prefix, arg);
> -		*dotdot = '\0';
> +		verify_non_filename(revs->prefix, full_name);
>  	}
>  
>  	a_obj = parse_object(revs->repo, &a_oid);
>  	b_obj = parse_object(revs->repo, &b_oid);
>  	if (!a_obj || !b_obj)
> -		return dotdot_missing(arg, dotdot, revs, symmetric);
> +		return dotdot_missing(full_name, revs, symmetric);
>  
>  	if (!symmetric) {
>  		/* just A..B */
> @@ -2103,7 +2092,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
>  		a = lookup_commit_reference(revs->repo, &a_obj->oid);
>  		b = lookup_commit_reference(revs->repo, &b_obj->oid);
>  		if (!a || !b)
> -			return dotdot_missing(arg, dotdot, revs, symmetric);
> +			return dotdot_missing(full_name, revs, symmetric);
>  
>  		if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0) {
>  			commit_list_free(exclude);
> @@ -2132,16 +2121,23 @@ static int handle_dotdot(const char *arg,
>  			 int cant_be_filename)
>  {
>  	struct object_context a_oc = {0}, b_oc = {0};
> -	char *dotdot = strstr(arg, "..");
> +	const char *dotdot = strstr(arg, "..");
> +	char *tmp;
> +	int symmetric = 0;
>  	int ret;
>  
>  	if (!dotdot)
>  		return -1;
>  
> -	*dotdot = '\0';
> -	ret = handle_dotdot_1(arg, dotdot, revs, flags, cant_be_filename,
> -			      &a_oc, &b_oc);
> -	*dotdot = '.';
> +	tmp = xmemdupz(arg, dotdot - arg);
> +	dotdot += 2;
> +	if (*dotdot == '.') {
> +		symmetric = 1;
> +		dotdot++;
> +	}
> +	ret = handle_dotdot_1(tmp, dotdot, arg, symmetric, revs, flags,
> +			      cant_be_filename, &a_oc, &b_oc);
> +	free(tmp);
>  
>  	object_context_release(&a_oc);
>  	object_context_release(&b_oc);
