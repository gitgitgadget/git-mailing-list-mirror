Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCE423A62
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976354; cv=none; b=XHHgxgDwMGkiel0bQR1DagELekMxo471RssEm035khqMZmHzX951P383bTeVCke/2G09I/CMyvXnybPrY+wlbwZYfjJp1JgUW37Ws7AQnsJkfBvOk1onKmCQu0cyyyuAyUX5LXaXdH4e0oM+I3mL2ZugKKRHMVtKPvh2tFMVuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976354; c=relaxed/simple;
	bh=StcjGec97ZvQr7oI6pZ6z7SIPaZFcN6Uq+GxfW8B1mg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t+Ex5Nu8M3W9+pUAVfRaZdnW1hEf8A3RtQOQY95qhYZIVUrbwZgdiQU+jbX2cO07jws8WQyqOTtqS9Q4YPWHsH9raPTNg5rD1z5/ICY/bnWlGSs79yqH20W94UwQ1UnWc/yJL+WPOmDs5/xHUs1YUiFRHqSpDAiOlZzg8eyXFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y2rPKT6x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IDVFmd/N; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y2rPKT6x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IDVFmd/N"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B3AFCEC0269;
	Tue, 31 Mar 2026 12:59:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 12:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774976351; x=1775062751; bh=oXY8CioNcx
	YVmy0IxTYwzSv29RpIrRn+BA/HRTN2VkE=; b=Y2rPKT6xXzOkcLlKEoRJWUuI7i
	MRehWEFCF9DNSS+jizKOyiGYFUPuqzyucHf0wQmdXb1JeI34ivw8+FYBKTNaxpXd
	xublHOxLHJs5qJgKREvKQQJwDUn/mZYmNA22QUkzbunc9qK+sdrLJd9a7R3xN8b0
	+mxZYMdyXBNrmkA8Jlx68OVkp1jXCIGh8BJ6YIMWH3FkB2lrKE4839kZOcnOBjxg
	v5IXCl1XLKCHA0zUm225WcD4eU01ou/qkJkmO9z2drxYyo7odleF9a6lXHnw7D79
	TZb8bEkslhHYCdwvIEYxdRTEmHsamH5VXee9XVCiV671QV9jCpd98Znz8onw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774976351; x=1775062751; bh=oXY8CioNcxYVmy0IxTYwzSv29RpIrRn+BA/
	HRTN2VkE=; b=IDVFmd/NPS0acX8raou3AMqbeaPtCi+n9Tfj2QPhPrDr7n+8Xlt
	4iANLmhyYOte6LE+qELzii+Lf8HKjeORtqKYtyfpFbAVnjRpQB39NdM1bba/AQ3W
	H9+7N1WCE5MBn+RuMABKFi92iz+SFmWBxgJQwF+qkR+IEQOagww7iQd6DOiEAU0T
	DjqI5swNTNgUYVZQHo1Xh5d6GDm0CgQIV2ycCEy/g/t0i4TRDL9E/z/xk37GjxtT
	qLbsVJyaaC9EEVoIyRFdVskIjhDkylVPEZrA1lI4dqdBA6jKYgIQb6NNb/VdgMOn
	AJ+tmh9opcpI3ohlRx8s/1aEQEZ6bD5Uf7Q==
X-ME-Sender: <xms:X_3LadsWdqdlLGOEE8HKnGFdMCHYcxbSAtYSsMIWYM_OZgPn-qN2Rg>
    <xme:X_3Ladc948TtollrzeNkU2ZaJBSadQ_l4G5Di7Z2zUlMAhZqQXBPVOsHZarC8kA0-
    b-oeu09gVys0i0WdMfCqs3Zui7HuwdH6rjPop9XUt6eC0l_EL9-gg>
X-ME-Received: <xmr:X_3LaVyMbuCnWbS3tzaQosV8a32RDPddtZHW6cvZgYEwom9re_Jn76vjMca6YJT76n7n0ayM75C7asxDvBCD06qK59ciAVqpbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhkihhnghhttgegsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgv
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:X_3LaTF5HOcdLwLZRjuE7TrMvRAOx7q3HajwTlQNpAHMtdSHWLGTag>
    <xmx:X_3LaZzVbuA_F4kBlXEocFZhD1vrO4kMd6z3UUS541pxAAA9nOD4bA>
    <xmx:X_3LaUtpgaXKaMy82RhvNj3pUU_GLzPbuMTYDS-TAirNXfjqiqjKIw>
    <xmx:X_3LaW1Kwl9v8-K1z4pvCdlvTs9KU-vdiOHaXML6kYnt-d20GiDUMg>
    <xmx:X_3LaTuue7L_k0Fq64XZ-UFbslifbD5TI9DkhWFsKWCpClq3fsUrKy3O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:59:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSoC PATCH] backfill: auto-detect sparse-checkout from config
In-Reply-To: <20260331112516.772635-1-vikingtc4@gmail.com> (Trieu Huynh's
	message of "Tue, 31 Mar 2026 20:25:16 +0900")
References: <20260331112516.772635-1-vikingtc4@gmail.com>
Date: Tue, 31 Mar 2026 09:59:10 -0700
Message-ID: <xmqqo6k40wbl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Trieu Huynh <vikingtc4@gmail.com> writes:

> git backfill currently initializes the `sparse` field in
> backfill_context to 0. This causes the command to always perform a
> full backfill by default, even when the repository has sparse-checkout
> enabled in its configuration (core.sparseCheckout).
>
> Because 'sparse' is explicitly set to 0 at initialization, any later
> logic intended to auto-detect the setting from the repository
> configuration becomes dead code, as it only triggers if the value
> is negative (sentinel).
>
> Change the initial value of .sparse to -1. This allows the command
> to correctly fallback to the repository's sparse-checkout settings
> when the '--sparse' or '--no-sparse' options are not provided on the
> command line.

The author of bff45557 (backfill: add --sparse option, 2025-02-03),
where this .sparse member originates, CC'ed for more intelligent
input than my review can offer ;-)


> Add a test case in t5620-backfill.sh to verify that 'git backfill'
> automatically respects the sparse-checkout configuration without
> explicit flags.
>
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  builtin/backfill.c  |  2 +-
>  t/t5620-backfill.sh | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index 4b2db94173..0f31844ce7 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -124,7 +124,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  		.repo = repo,
>  		.current_batch = OID_ARRAY_INIT,
>  		.min_batch_size = 50000,
> -		.sparse = 0,
> +		.sparse = -1,
>  		.show_progress = -1,
>  	};
>  	struct option options[] = {

I am a bit confused by this change.  What's the difference between
using -1 (which you picked) and 1 as the initial value for this
member?  From the proposed log message, I would have expected a new
code that says "ah, we notice, from this member being -1, that the
user did not specify --no-sparse or --sparse, so let's figure out if
our working tree is sparsely checked out ourselves and set it either
to 0 or to 1", but there is nothing like that in the code.  It seems
that the updated code relies on the fact that this part of
do_backfill() only cares if .sparse is zero or not, and ...

	if (ctx->sparse) {
		CALLOC_ARRAY(info.pl, 1);
		if (get_sparse_checkout_patterns(info.pl)) {
			path_walk_info_clear(&info);
			return error(_("problem loading sparse-checkout"));
		}
	}

... relies on get_sparse_checkout_patterns() not to do any harm when
the working tree is not sparsely checked out.

I am not sure if we want to call it "auto-detction".  It looks more
like "default to --sparse, relying that --sparse is a no-op in a
non-sparse working tree" at least to me.  Not that it is necessarily
wrong, and when people do "backfill" knowing that the working tree
is sparse, I am sympathetic if they prefer to keep the sparseness,
so such a change of default may be beneficial.

Derrick, what do you think?

> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> index 91b5115732..a1a8d736db 100755
> --- a/t/t5620-backfill.sh
> +++ b/t/t5620-backfill.sh
> @@ -149,6 +149,21 @@ test_expect_success 'backfill --sparse' '
>  	test_line_count = 0 missing
>  '
>  
> +test_expect_success 'backfill auto-detects sparse-checkout from config' '
> +	git clone --sparse --filter=blob:none \
> +		--single-branch --branch=main \
> +		"file://$(pwd)/srv.bare" backfill-auto-sparse &&
> +
> +	git -C backfill-auto-sparse rev-list --quiet --objects --missing=print HEAD >missing &&
> +	test_line_count = 44 missing &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/auto-sparse-trace" git \
> +		-C backfill-auto-sparse backfill &&
> +
> +	test_trace2_data promisor fetch_count 4 <auto-sparse-trace &&
> +	test_trace2_data path-walk paths 5 <auto-sparse-trace
> +'
> +
>  test_expect_success 'backfill --sparse without cone mode (positive)' '
>  	git clone --no-checkout --filter=blob:none		\
>  		--single-branch --branch=main 		\
