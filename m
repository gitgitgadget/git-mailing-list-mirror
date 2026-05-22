Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5285723395F
	for <git@vger.kernel.org>; Fri, 22 May 2026 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418298; cv=none; b=jr79rjJZ39u084WNUX+IxGWgVOhRrUSV285aGJ/F0kqWAFTECpxR/pirSO6OlPXwPtfmo19HJlLKOBA2M/4NRP/x5GFNZDPPCne/upLdkJUK4qvm25CUKjo7wnAXNPEKkbD6aHP97gcUtBar1A1a9dJzOrpFH6j1WtI4BSaVSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418298; c=relaxed/simple;
	bh=5cVuOu0titi7C0x3ioPmhTwCWF53TPKIe7ol7Qp76+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GxG5JBHzh1CS6D4N1t0eiC+3bXOHx52k4SIUJKjSo/1rF5JF2CIwn70O5iGb4NS753834OaAAQ56elKdJQC4kFHY+SPy32byXIOdaGWxiCugp8h9yzDJXemP4M4ddFr1u0o4qhx3axdLwY7IT5oAeGKQh+l7EDeZeX+58SCKPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UyIfZfP0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LlFEcDWU; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UyIfZfP0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LlFEcDWU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2BBBA1D0008F;
	Thu, 21 May 2026 22:51:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 22:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779418295; x=1779504695; bh=yCTib/F9r3
	CZD71fKogtVICgKbPnES8eG9IF2CrcN0w=; b=UyIfZfP0DMDLhUaRuJQPbPJpRV
	E3y1Ebb19eOKkTPaewcpKqQGdoH5tN9/aN05g/nxK7b9SUvlwwaEftcJ7jAavwCt
	4vTNwjXxw4X9oMKrsjPh3ZhHGBfetHrV6wVJfUwuSr0/4B+kkBpAV/1TsLz0KrsN
	Nw9izK034QCo6c+iuiYjnpZKqyY2+obl8q8FA5x4HdIx0JVKR+DuKTCK54ZP4y4b
	lUmb6EKQPrFIWm1Ox2FLF6JdyXQ/74G4FU2aWjHvm5dwKWK5vzLDnPtac5PNkisT
	lHlhHIZAISJLeCMXDQMBi9ScWSuGYJTSycyNqrRyxyQYcj+drybHOYWEHo0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779418295; x=1779504695; bh=yCTib/F9r3CZD71fKogtVICgKbPnES8eG9I
	F2CrcN0w=; b=LlFEcDWUBKUwkerSD5aiXnn5AVL8HARmcRyGJiWBSkAh6v+U4P7
	w9SiPF6TEPr2ZsyN5slf8pQRQ0td9eHvvi6CYxetPPj9RhKVQlUv8+K6BqQQI+JH
	ZiA7Ktn6WcatfbjX4ElY9BMERZgBj+gZ6WlPbk9rUuN5CBSjxlpRZW7xTkPOjhOe
	FjdOhWMcaPkrV8oG3mh72COKYJJluUYJ6t35CaR+zZD8kyKsSEUD5UInpfEXNLLn
	dmhBShu9/ceA6JdMcBz5L+jL6L/ovyhOs70uXPNQaWYbMxGV4ZkAq4nVhf1jTi2O
	faZmWDojCg5ibWtfG84jlsdU/HWFtb5FPiQ==
X-ME-Sender: <xms:tsQPan6xOpng6ZttHfbInEK1AQ8EdbmNeHvK10anQECBmAEODkn6Tw>
    <xme:tsQPavLKatz74vL3Hw_gCUlKyOu6k0_D8tmJVPHl8DeE46r6oyS7QrxaO8uvFIsu-
    wuG82nO2tBSbc830Ua65uSAsuGFZDdptMXr8fAaON4ULtPAI6picg>
X-ME-Received: <xmr:tsQPaguxKaqyZS0OzGAMSrdt3In-WnQuzJja4-IaXHqxp3L64K6b66qDMMUaWHU7THv-SZb_DEWiqt26uWpEmv6-DnT370cgww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrrhgrlhgunhhorhgugh
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:tsQPauKxozeGz9BT9qOnYaVPBJDcPoeG2uiDMYHm9T71d3PbxzEdeA>
    <xmx:tsQPap-dkAJldKa6mrHIVdG7La2iuZnjLYGEzqRTxLhbDrsVWVajWw>
    <xmx:tsQPanxWEYhzdNmQhtK-q3NDdjKTIuEfFCLVm3GwWcIjyimLb9f91w>
    <xmx:tsQPam6WPzkuKuKKJldNlmGUZ-g1lTntNxIJYfDJRz9EVlBNoeLMTQ>
    <xmx:t8QPal1CsXjOVyu6ZkI_o897BQjQQI-LALc-xsJPq5cjJ67KvLqF0QzE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 22:51:34 -0400 (EDT)
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
Date: Fri, 22 May 2026 11:51:33 +0900
Message-ID: <xmqq8q9cw40a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

Due to the way the patch is split between 1/4 and 2/4, it is
impossible to comment on the change to delete_branches etc. that are
needed for this step.  I'll use "git diff master... builtin/" instead.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1572a4f9ef..b89fd56112 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -1,43 +1,47 @@
> ...
> @@ -132,78 +136,87 @@ static const char *branch_get_color(enum color_branch ix)
>  static int branch_merged(int kind, const char *name,
>  			 struct commit *rev, struct commit *head_rev)
>  {

This one is called from check_branch_commit().  In "--prune-merged"
code paths, as we will see below, kind==FILTER_REFS_BRANCHES is
passed.

But note that there is no reason to expect "--prune-merged" will be
the only one to pass FILTER_REFS_BRANCHES to this function.  Most
notably, "git branch -d" without "-r" would set FILTER_REFS_BRANCHES
to filter.kind and passes the value here.

>  	/*
>  	 * This checks whether the merge bases of branch and HEAD (or
>  	 * the other branch this branch builds upon) contains the
>  	 * branch, which means that the branch has already been merged
>  	 * safely to HEAD (or the other branch).
>  	 */
>  	struct commit *reference_rev = NULL;
>  	const char *reference_name = NULL;
>  	void *reference_name_to_free = NULL;
>  	int merged;
>  
>  	if (kind == FILTER_REFS_BRANCHES) {
>  		struct branch *branch = branch_get(name);
>  		const char *upstream = branch_get_upstream(branch, NULL);
>  		struct object_id oid;
>  
>  		if (upstream &&
>  		    (reference_name = reference_name_to_free =
>  		     refs_resolve_refdup(get_main_ref_store(the_repository), upstream, RESOLVE_REF_READING,
>  					 &oid, NULL)) != NULL)
>  			reference_rev = lookup_commit_reference(the_repository,
>  								&oid);
>  	}

We find its upstream in reference_rev; if this is non-NULL, the
branch MUST be merged to that revision for it to be safely removed.

>  	if (!reference_rev)
>  		reference_rev = head_rev;

But when ehad_rev is given, and if there is no upstream, we check if
the branch is merged to whatever happens to be checked out instead.
For the purpose of "--prune-merged", therefore, we MUST pass NULL in
head_rev when we call this function.  We'll see what is done in the
caller later.

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

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 45455cb8ce..c8589cd3a6 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1798,4 +1798,143 @@ test_expect_success '--forked requires at least one <branch>' '
>  	test_grep "at least one <branch>" err
>  '
>  
> +test_expect_success '--prune-merged: setup' '
> +	test_create_repo pm-upstream &&
> +	test_commit -C pm-upstream base &&
> +	git -C pm-upstream checkout -b next &&
> +	test_commit -C pm-upstream one-commit &&
> +	test_commit -C pm-upstream two-commit &&
> +	git -C pm-upstream branch one HEAD~ &&
> +	git -C pm-upstream branch two HEAD &&
> +	git -C pm-upstream branch wip main &&
> +	git -C pm-upstream checkout main
> +'
> +
> +test_expect_success '--prune-merged deletes branches integrated into upstream' '
> +	test_when_finished "rm -rf pm-merged" &&
> +	git clone pm-upstream pm-merged &&
> +	git -C pm-merged branch one one-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next one &&
> +	git -C pm-merged branch two two-commit &&
> +	git -C pm-merged branch --set-upstream-to=origin/next two &&
> +
> +	git -C pm-merged branch --prune-merged "origin/*" &&
> +
> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
> +'
> +
> +test_expect_success '--prune-merged with a literal upstream argument' '
> +	test_when_finished "rm -rf pm-literal" &&
> +	git clone pm-upstream pm-literal &&
> +	git -C pm-literal branch one one-commit &&
> +	git -C pm-literal branch --set-upstream-to=origin/next one &&
> +	git -C pm-literal branch keepme one-commit &&
> +	git -C pm-literal branch --set-upstream-to=origin/main keepme &&
> +
> +	git -C pm-literal branch --prune-merged origin/next &&
> +
> +	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one &&
> +	git -C pm-literal rev-parse --verify refs/heads/keepme
> +'
> +
> +test_expect_success '--prune-merged unions multiple <branch> arguments' '
> +	test_when_finished "rm -rf pm-union" &&
> +	git clone pm-upstream pm-union &&
> +	git -C pm-union branch one one-commit &&
> +	git -C pm-union branch --set-upstream-to=origin/next one &&
> +	git -C pm-union branch two base &&
> +	git -C pm-union branch --set-upstream-to=origin/main two &&
> +
> +	git -C pm-union branch --prune-merged origin/next origin/main &&
> +
> +	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
> +'
> +
> +test_expect_success '--prune-merged with a local-branch argument' '
> +	test_create_repo pm-local &&
> +	test_when_finished "rm -rf pm-local" &&
> +	test_commit -C pm-local base &&
> +	git -C pm-local branch topic base &&
> +	git -C pm-local config branch.topic.remote . &&
> +	git -C pm-local config branch.topic.merge refs/heads/main &&
> +	git -C pm-local checkout --detach &&
> +
> +	git -C pm-local branch --prune-merged main &&
> +
> +	test_must_fail git -C pm-local rev-parse --verify refs/heads/topic &&
> +	git -C pm-local rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged spares branches with un-integrated commits' '
> +	test_when_finished "rm -rf pm-unmerged" &&
> +	git clone pm-upstream pm-unmerged &&
> +	git -C pm-unmerged checkout -b wip origin/wip &&
> +	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
> +	test_commit -C pm-unmerged local-only &&
> +	git -C pm-unmerged checkout - &&
> +
> +	git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
> +	test_grep "not fully merged" err &&
> +	test_grep "Skipped 1 branch" err &&
> +	test_grep "git branch -D" err &&
> +	test_grep ! "If you are sure you want to delete it" err &&
> +	git -C pm-unmerged rev-parse --verify refs/heads/wip
> +'
> +
> +test_expect_success '--prune-merged skips branches whose upstream is gone' '
> +	test_when_finished "rm -rf pm-upstream-gone" &&
> +	git clone pm-upstream pm-upstream-gone &&
> +	git -C pm-upstream-gone branch one one-commit &&
> +	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
> +	git -C pm-upstream-gone branch --prune-merged "origin/*" &&
> +
> +	git -C pm-upstream-gone rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged never deletes the checked-out branch' '
> +	test_when_finished "rm -rf pm-head" &&
> +	git clone pm-upstream pm-head &&
> +	git -C pm-head checkout -b one one-commit &&
> +	git -C pm-head branch --set-upstream-to=origin/next one &&
> +
> +	git -C pm-head branch --prune-merged "origin/*" &&
> +
> +	git -C pm-head rev-parse --verify refs/heads/one
> +'
> +
> +test_expect_success '--prune-merged spares the local default branch' '
> +	test_when_finished "rm -rf pm-default" &&
> +	git clone pm-upstream pm-default &&
> +	git -C pm-default checkout --detach &&
> +	git -C pm-default branch --prune-merged "origin/*" &&
> +	git -C pm-default rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged protects the default branch by name only' '
> +	test_when_finished "rm -rf pm-default-alias" &&
> +	git clone pm-upstream pm-default-alias &&
> +	git -C pm-default-alias branch --track trunk origin/main &&
> +	git -C pm-default-alias checkout --detach &&
> +	git -C pm-default-alias branch --prune-merged "origin/*" &&
> +	git -C pm-default-alias rev-parse --verify refs/heads/main &&
> +	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
> +'
> +
> +test_expect_success '--prune-merged with literal arg also protects default-name' '
> +	test_when_finished "rm -rf pm-literal-default" &&
> +	git clone pm-upstream pm-literal-default &&
> +	git -C pm-literal-default checkout --detach &&
> +	git -C pm-literal-default branch --prune-merged origin/main &&
> +	git -C pm-literal-default rev-parse --verify refs/heads/main
> +'
> +
> +test_expect_success '--prune-merged requires at least one <branch>' '
> +	test_must_fail git -C pm-upstream branch --prune-merged 2>err &&
> +	test_grep "at least one <branch>" err
> +'
> +
>  test_done
