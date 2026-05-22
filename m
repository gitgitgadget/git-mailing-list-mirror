Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE692C375E
	for <git@vger.kernel.org>; Fri, 22 May 2026 02:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418349; cv=none; b=GzXegxYIvZaw7pSpPaDOQfFqplOZts7Fm7KPAe3O7pRriYKHz7WfBiAgB2CimansXgcBRWTKrTAOESAfS6CmIW0sGNcaTe96FVuS7VbhdhQV45SaU2EYWYGw10TDQo85M2Q05rAUkdlkoHoiBJpx+jWLmgYbPkT31pfeB30cAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418349; c=relaxed/simple;
	bh=WVZyOHkAGVuD7zeHe/sNxPsdDZDh5JBMh9Hv3cfEcBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KsIQDa/zw8cZPxsFwU6/7H2zs5ZCnKesgCq8S+JL5s1Thox3+0dBdcmV2gk8uFr/MkHFDdXX1A0Qb7wM5G+o55TVQJFHiUGxsdDS6DF8J7PYlwJZcgY2HWK9N6s7GI5wKtqBwWSS/4efPUKvmifWKP1nu8yGs5xp5M8UxZAiNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xfdz4+Tz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DO9as1aH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xfdz4+Tz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DO9as1aH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E08757A00A6;
	Thu, 21 May 2026 22:52:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 22:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779418346; x=1779504746; bh=0L/QTowD1G
	jCR82pJOHr432Tpcp85wh5VDIqbQ7dkE4=; b=Xfdz4+TzfSTQwDAQPXNVMLm38f
	qvIbSU+Vvhnf2GQwYgsLFBJX3CDqRrQVG02QRI2nN4Joo27NDMsRcVXmvm+OoSRP
	Dr+3r98Er55biFgtfYRdkTEhRB50uqvsJCXdToA/ad92hA8u3o35dar9SAs3giOw
	gatpk4HpsYlUQhd9BzN9sMVp9/6si1VWNUTRNAAQF54+D5eNQp5NyDt/CyYOWTwo
	Zd4l+5vKDNVJLa5xqs7y+npAYNKU+1ASgXlIwUMOIWgvpyNu+7Xlgky9Y1K4PjRs
	N+hXVaX26TbfdZjN9jHh9b2h/ML9cU3OlLbttN5rLuAin995gHpMtKmKKF8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779418346; x=1779504746; bh=0L/QTowD1GjCR82pJOHr432Tpcp85wh5VDI
	qbQ7dkE4=; b=DO9as1aHqsaCS5IPr52Ced8oIvzXSVM9qnMklxeaVyIrkzZaIBt
	Q5d10TWoWSmBLzC6HFkv1IMrDDsSzQhAJzpd9Wj/LRXyCT7QFXXarXL8p/8ecDYb
	tfFU7txkwoWP2Bhkqafy8HO8be2BSUkzkKjJC226TuyQ2GZyWjIEe5VbWS4zlnb5
	Me9Bj2my8er4qmRBAcdGRpUvGgfhPNSFWU2XjsudmLopPIThkCkWmUz/3kpvFIR0
	dn5BEGb0dbk7cPAJ2UX+twn+MbnOe/DRkNmYh2GGa3WP24Qh2u6oTjae8oxF99mn
	YA/HXN4pmmcGJLQ3DMN4tYUz1uaUtx1dciA==
X-ME-Sender: <xms:6sQPanM0-pTBCJy1CeyYS_VZYX8BcdF7jHXVNbAx9DhIYZS3cDkI9Q>
    <xme:6sQPakOreUzSldK0tWDNJs8XxsD4IGG2XhmbYlEXcZZlc4N3trQ232C0tzQuvYYf4
    ObJqWO9Qq1zdDkiPHwbITUqZKOx9vYb_fikyIGsK9-_5S8iC3LPrw>
X-ME-Received: <xmr:6sQPaoj5s8Ze_2MIuhE-HphPH-AZ47xZDZzqXV7s6DD6lc95JYNxuQFKn_PAu7nZcwbTQVyfCW7emYpopZu0ezz2PJiOQXmMIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteeijefgieduheffhfetgeeggedtvdefieeiuddvudetkeetgeefteejjefg
    hfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrrhgrlhgunhhorhgugh
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:6sQPahvd4NREFwnkHE6iJX1kN1CFZSMGAzaGJFykJQboF46fnH2CJQ>
    <xmx:6sQPauQ6_TCEcxslt8uYUVptgsTjSO8TuHp9_RhCu_YGvaYHd_UH8g>
    <xmx:6sQPat1KOLPHq7x24fdBk0HyNHkNCM1jErwbHMzPsdC1XRtsJ_YqGA>
    <xmx:6sQParvJ0P_WxFOjW5XjfmD3f9P4x3xRXijwCeIHgjnSwkiv4zf4Vw>
    <xmx:6sQPavYE5GZyVZ6dB1yELZI3QDB1IHcSy3-7m7KocF1VMH_9k7NbrEqs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 22:52:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 2/4] branch: add --prune-merged <branch>
In-Reply-To: <718e28c7e0120a826385189213cccec1f0fce1af.1779403204.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 21 May 2026
	22:40:02 +0000")
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<718e28c7e0120a826385189213cccec1f0fce1af.1779403204.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 22 May 2026 11:52:25 +0900
Message-ID: <xmqq5x4gw3yu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1e24c95a69..29d38e9060 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -172,8 +174,8 @@ static int branch_merged(int kind, const char *name,
>  	 * any of the following code, but during the transition period,
>  	 * a gentle reminder is in order.
>  	 */
> -	if (head_rev != reference_rev) {
> -		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
> +	if (head_rev && head_rev != reference_rev) {
> +		int expect = repo_in_merge_bases(the_repository, rev, head_rev);

Any caller who passed head_rev==NULL still used to come into this
block, set expect to 0, and have it compared with merged.  If merged
is 0 (which is what happens when reference_rev is NULL and head_rev
is NULL), the control left this block silently due to /* okay */
below (which is in the post-context that is not shown).

The updated code refuses control to come into this block when
head_rev is NULL.  I am not sure why the change in this hunk is
needed.

> @@ -748,6 +750,25 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
>  	return 0;
>  }
>  
> +static int collect_default_branch_name(struct remote *remote, void *cb_data)
> +{
> +	struct string_list *protected = cb_data;
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	struct strbuf head = STRBUF_INIT;
> +	const char *target;
> +
> +	strbuf_addf(&head, "refs/remotes/%s/HEAD", remote->name);
> +	target = refs_resolve_ref_unsafe(refs, head.buf,
> +					 RESOLVE_REF_NO_RECURSE, NULL, NULL);
> +	if (target) {
> +		const char *leaf = strrchr(target, '/');
> +		if (leaf)
> +			string_list_insert(protected, leaf + 1);
> +	}
> +	strbuf_release(&head);
> +	return 0;
> +}

It is strange to assume that whatever upstream repository happens to
use as its primary branch name has anything to do with how the local
repository names its primary branch.  Shouldn't this instead use
init.defaultBranch configuration or something?

> @@ -781,6 +802,63 @@ static int list_forked_branches(int argc, const char **argv)
>  	return 0;
>  }
>  
> +static int prune_merged_branches(int argc, const char **argv, int quiet)
> +{
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +	struct string_list candidates = STRING_LIST_INIT_DUP;
> +	struct string_list protected_default_names = STRING_LIST_INIT_DUP;
> +	struct strvec deletable = STRVEC_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list_item *item;
> +	int n_not_merged = 0;
> +	int ret = 0;
> +
> +	if (!argc)
> +		die(_("--prune-merged requires at least one <branch>"));
> +
> +	collect_forked_set(argc, argv, &candidates);

Due to poor separation of changes, all the necessary information to
assess how sane the above code is is hidden in [1/4] and not here.

> +	for_each_remote(collect_default_branch_name, &protected_default_names);

This looks inefficient, and worse, incorrect.

If we have multiple branches in argv[], they may have come from
different upstream, and because you pay attention to what the
refs/remotes/<upstream>/HEAD symrefs point at, you have multiple
such "protected" default names.  You'd compare each and every
candidates against these names using linear search in the
string_list to see if they are protected (inefficient), and you
reject removal of argv[1] even when it happens to be the same name
as the default in the repository from which the upstream of argv[3]
came from, i.e., has no relationship with argv[1] (incorrect).

> +	for_each_string_list_item(item, &candidates) {
> +		const char *short_name = item->string;
> +		const char *upstream = item->util;
> +
> +		strbuf_reset(&buf);
> +		strbuf_addf(&buf, "refs/heads/%s", short_name);
> +		if (branch_checked_out(buf.buf))
> +			continue;
> +
> +		if (string_list_has_string(&protected_default_names,
> +					   short_name))
> +			continue;
> +
> +		if (!refs_ref_exists(refs, upstream))
> +			continue;
> +
> +		strvec_push(&deletable, short_name);
> +	}
> +	strbuf_release(&buf);
> +
> +	if (deletable.nr)
> +		ret = delete_branches(deletable.nr, deletable.v,
> +				      0, FILTER_REFS_BRANCHES, quiet,
> +				      1, &n_not_merged);

Add comments on parameters, perhaps, to make it readable?

		ret = delete_branches(deletable.nr, deletable.v,
				      0, /* no force */
				      FILTER_REFS_BRANCHES,
				      quiet,
				      1, /* warn only */
				      &n_not_merged);

or something?

Unfortunately the body of delete_branches() updated by this series
is not visible in this patch, making a sensible review impossible,
but if I recall correctly from what I saw in [1/4], with no-force
set, it does not leave head_rev NULL, and instead reads the HEAD
into it, and that is eventually passed to check_branch_commit()
call.

Now, check_branch_commit() passes head_rev to branch_merged(), which
falls back to "HEAD" when head_rev is given.  That sounds incorrect
for at least two reasons.  We are only dealing with branches that do
have upstream, so fallback should not trigger and we shouldn't be
allowing head_rev to be passed.  It _might_ be debatable that it is
prudent to still expect branch_merged() not to find the upstream to
detect errors in the logic, but falling back to head_rev in such a
case does not make any sense.

> +	if (n_not_merged && !quiet)
> +		fprintf(stderr,
> +			Q_("Skipped %d branch that is not fully merged; "
> +			   "delete it with 'git branch -D' if you are sure.\n",
> +			   "Skipped %d branches that are not fully merged; "
> +			   "delete them with 'git branch -D' if you are sure.\n",
> +			   n_not_merged),
> +			n_not_merged);

I do not think we unconditionally want to see this, and "--quiet"
shouldn't be the onlyl way to squelch this message.

When !quiet, the warn_only call to check_branch_commit() would
already have reported which branches are not fully merged, and
after seeing this message a few times, even the most novice user
would know how to use "git branch -D" to remove unneeded branches.

Use of advice_if_enabled() may make it more palatable.
