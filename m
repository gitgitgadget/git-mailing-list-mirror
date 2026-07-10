Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160E40BCB0
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690096; cv=none; b=B1Xpx/R8z00XDBlYHvbsC9Edil1ZA/X/DEFPiF0ajvzhFqNODRv+QKbgqSesKPAEiOlSycZidgA1g7IwGnnU/EKRlr4GvLWeT4Q8huABIWWkDsdTAc2pgzGInZ81qjTLLLbE57GOto+HPkLV1tazQZ7/oE9bH91oY7ipZ0/CQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690096; c=relaxed/simple;
	bh=LWC4c6PTs/HBhBXA8xStyLeCBowJvHHZSGRrRYiNBPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtuwWQwCihwZ9WRdHdzDOSrht0iXLiO/t4n8+cHLeXJzgT20p1EAZV9EFGoyanUuUXKnxEKYYgsWaRUP/3xEsj+QSXy7SLAWh8AU2SJ5dgM3BHxm6ZTirRsw6s5AV1J/q8igPQK51OH8UTHRYywxgS+iGyk50T2+WRoFA52RGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivBS2vSe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivBS2vSe"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f75f7172so1122845e9.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783690092; x=1784294892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zODjZII5/StAn4mG1FRXvuIpwc0lF40ucr+eJVesoto=;
        b=ivBS2vSeZKJuetMyfVoLa80q0oHviErw370tBMVRurqOvtS6ZVk7zO/trGb2venpaw
         hmYm+/gjTAOIHbewQwESoeh4QuRYaKOeMSNI6mw7wFjYNiB5Jnrzk4FQS5FsPKr9dIwc
         JUqKOb7JE1dTu0kF9sD4X6ok++NlebU9eg7V3DbooP89FrNdpZ0nmVarm7++iK5Qk+pD
         5tPrxYD3Wg4LKCuMTz/DPPJcieO8ajMfoxxVfIvkqyagq58ROMGiDJWz8l8nlciKHBQ2
         CnIhiTQGCSyNSidgYbrkDO8Usdyhtnp4SvpBQD4S4rIQipH15OzWhj6aZRKVwUAFUeIn
         Y0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783690092; x=1784294892;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zODjZII5/StAn4mG1FRXvuIpwc0lF40ucr+eJVesoto=;
        b=qfwZLRCtxxxGlM+iw4Sd1isJR5S14J0c7jQsXYuZ5i5sAqj4BhgLeLIAdZ0y6NgegC
         0t9ONvYELigmxxE+hVVlcxEYGJdWHpxNWCwYLjDRqe96fd/yu/rqgjIhvxim1+7JKF2g
         yKvAZ0f4E3q4rKDhwAm8IcjtZVXRPKCrsWJP2v2jQZB5tN2clGbKjGRWv3pRR06pb4DE
         Rs+TOqHrnCWtGEwWXALX/7aPkKRqDaW8zldbEmcRcKqXmW90XXiW2vpcSGzOe8h3dtFd
         ZOAfLr0o3zmgyK2jJBuKaO0sVFIOVZCrxrkf4gvmGXghwYAbVodBRhKeNbr8s1mf5PZX
         X8Bw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1cUnL+inkkEAxd546sAJg25hkCFpxR4xZ7UE1OnyWdtHi3vSEN8QrTM0Ms92DtMCKy+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznp1VwTlFvgb+hRVCvPV8eFX7DhqZr9bLqnTx/9O122VK3sZX5
	tgz62cPo/JjLp1Q/Z4LRMn2LFvh/WizKbEKssGJ5tGQ31t3096tRaL4tAotE1A==
X-Gm-Gg: AfdE7cmn4p31Ughrxn5J8l14K9DQgpouDi+YJDKydEFxxY8RzLN/JolgUeVdPPa7zjY
	L4EolOL7pFlS3YOgoP+SGMVizZ8zYKH0BrbLGtyt3wO8xYrITszgbeayDT+wvo2qU4y1f0+oBC6
	6nb8H8XMRjmMy6+4focQn4LLcc/eoIRiGa8Bk/vtU6QXlL4rP5AXsfe/hVo8uQnU01OpdmfHeGA
	s05dZYrHIjv4R6UwE94+CXNIHwuUEOviv9wKZS0p9/LNfRvnk7AOL1DssM6MIKnYUXLbV/0ZAJr
	2gXCUR2NGky36nJKK4OYABFq+eu4XFiH7oTxVo/UwlQvF9Gg7IYWeCQl479Y/WjzViEjkgCiRVr
	nTKs/ADJVWaaReXRF9rdLTqDD7D1D8aQ/r5kLp31UwupdGeJmraqUQAQ1L1vE9vXk+YQTgNyKT0
	3qLmoqthXlayvn6ebbWtOpoPZyPRqBOGgJncxB8o8bOv2KddFFgIYUqACw5ijYSN0E0r2aMQ==
X-Received: by 2002:a05:600c:a43:b0:493:d741:5d72 with SMTP id 5b1f17b1804b1-493e68db0fdmr123230965e9.38.1783690091571;
        Fri, 10 Jul 2026 06:28:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:33f4:2760:38a0:c4f? ([2a0a:ef40:69a:b801:33f4:2760:38a0:c4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e0eff1sm37749055e9.0.2026.07.10.06.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 06:28:10 -0700 (PDT)
Message-ID: <afb76b98-661a-4663-8e8b-fd00572db5ba@gmail.com>
Date: Fri, 10 Jul 2026 14:28:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sequencer: honor --empty when a fixup!/squash! empties
 its target
To: Farid Zakaria <farid.m.zakaria@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Farid

On 10/07/2026 05:13, Farid Zakaria wrote:
> When "git rebase --autosquash" melds a "fixup!" or "squash!" commit into
> its target, the result can be a commit that no longer changes anything
> relative to its parent, for example when the melded change reverts the
> target.  Rather than dropping or keeping this empty commit, the rebase
> stops with
> 
> 	You asked to amend the most recent commit, but doing so would
> 	make it empty. ...
> 
> and the "--empty" option has no effect on it.  This makes backing a
> change out of a series awkward: reverting a commit as a "fixup!" and
> running "git rebase --autosquash --empty=drop" ought to remove both the
> commit and its revert, but it halts instead.

I agree this is a use case that we want to support

> The reason is that allow_empty() decides emptiness with
> is_index_unchanged(), which compares the index to HEAD.  A "fixup!" is
> applied by amending HEAD, so the commit it produces has HEAD's parent as
> its parent; it is empty when the index matches the tree of that parent,
> not of HEAD.  A meld that cancels out its target is therefore never
> recognized as having become empty, and falls through to "git commit
> --amend", which refuses to create an empty commit.

and with this diagnosis.

> Teach is_index_unchanged() to compare against the tree of HEAD's parent
> when amending, and teach allow_empty() to classify the result as "became
> empty" (and thus subject to --empty) unless the commit being melded into
> was itself already empty, in which case it "started empty" and is
> governed by allow_empty as before.

However, I think that rather than changing the current check which 
changes the behavior of a fixup commit that becomes empty we should add 
an additional check to see if applying the fixup makes the target commit 
empty. With the patch here a fixup commit that becomes empty is only 
seen as empty if the commit being fixed up is empty in which case we 
always accept the fixup, whereas the current behavior is always to 
respect what --empty says. When I'm planning out a series of commits I 
sometimes create empty commits where the messages says what I'm 
intending to do and then I create fixups for them when I get round to 
writing the code. If one of those fixups becomes empty I want to know 
about it because it means I need to drop the empty commit that's being 
fixed up as well.

> When --empty=drop applies, the emptied commit has already been created
> by the preceding "pick", so drop it by moving HEAD back to its parent.
> Do so before the rewritten-commit list is flushed, so that --update-refs
> and the other rewrite consumers map the dropped commit to its parent.

If we're dropping the commit then we should not record it as rewritten 
so we need to remove the rewritten-pending file. Any labels and 
update-ref commands that come immediately after the dropped commit will 
see HEAD pointing to the dropped commits rewritten parent.

> Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
> ---
> At Meta we maintain a fork of LLVM that we regularly rebase onto
> upstream.  A set of internal patches rides on top, and we keep each one
> as a single commit by folding follow-up changes into it with autosquash
> "fixup!" commits.  That works well for evolving a patch, but not for
> retiring one: to back an internal patch out today we delete it from the
> history by hand with an interactive rebase and then force-push, which is
> easy to get wrong on a shared branch.

You'll still need a forced push though because you're dropping the 
commit. I think the change you're proposing to git would be useful but 
you could automate your existing workflow by setting GIT_SEQUENCE_EDITOR 
to a script that drops the commit and it's fixups from the todo list.

> One open question, for a possible follow-up.  A natural next step would
> be a "revert!" autosquash directive (and a "git commit --revert" to
> create it), mirroring "fixup!"/"squash!", so
> that retiring a patch would not require generating the reverse diff by
> hand.  I have deliberately left it out of this series, because its
> semantics are not obvious: in particular, whether a "revert!" commit
> should carry the reverse patch as its own content (and thus be an
> ordinary fixup that this patch already drops), or be an empty marker
> that instructs the rebase to revert the target commit during the meld.
> Opinions on whether such a directive is wanted, and which of those two
> shapes is preferred, would be welcome before I attempt it.

I think having support for creating and squashing revert! (or possibly 
drop!) commits is a good idea (I've a feeling there is some discussion 
about that in the gitgitgadget issue tracker). Using an empty commit has 
a marker has the advantage that applying it cannot create conflicts, so 
you only have to deal with the conflicts caused by the commit being 
dropped, not the by fixup not applying cleanly.

Thanks

Phillip

> ---
> base-commit: f60db8d575adb79761d363e026fb49bddf330c73
> ---
>   Documentation/git-rebase.adoc | 12 ++++++
>   sequencer.c                   | 96 +++++++++++++++++++++++++++++++++++++++----
>   t/t3415-rebase-autosquash.sh  | 64 +++++++++++++++++++++++++++++
>   3 files changed, 163 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index f6c22d1598..7eb8bbe95f 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -282,6 +282,11 @@ by `git log --cherry-mark ...`) are detected and dropped as a
>   preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
>   passed).
>   +
> +A commit can also become empty as a result of `--autosquash`, when a
> +`fixup!` or `squash!` commit cancels out all of the changes of the
> +commit it is melded into.  Such a commit is treated the same way and is
> +dropped, kept, or stopped at according to this option.
> ++
>   See also INCOMPATIBLE OPTIONS below.
>   
>   --no-keep-empty::
> @@ -591,6 +596,13 @@ changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
>   are moved right after the commit they modify.  The `--interactive` option can
>   be used to review and edit the todo list before proceeding.
>   +
> +If melding a `fixup!` or `squash!` commit cancels out all of the changes of
> +the commit it is applied to, the result is an empty commit.  The handling of
> +these empty commits can be configured with the `--empty` option: the emptied
> +commit is dropped, kept, or stopped at.  This makes it possible to back a
> +change out of a series by committing a revert of it as a `fixup!` and letting
> +`--autosquash --empty=drop` remove both.
> ++
>   The recommended way to create commits with squash markers is by using the
>   `--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
>   linkgit:git-commit[1], which take the target commit as an argument and
> diff --git a/sequencer.c b/sequencer.c
> index 0fe8fed6c3..435b100e3d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -823,7 +823,7 @@ static struct object_id *get_cache_tree_oid(struct index_state *istate)
>   	return &istate->cache_tree->oid;
>   }
>   
> -static int is_index_unchanged(struct repository *r)
> +static int is_index_unchanged(struct repository *r, int amend)
>   {
>   	struct object_id head_oid, *cache_tree_oid;
>   	const struct object_id *head_tree_oid;
> @@ -856,7 +856,26 @@ static int is_index_unchanged(struct repository *r)
>   		if (repo_parse_commit(r, head_commit))
>   			return -1;
>   
> -		head_tree_oid = get_commit_tree_oid(head_commit);
> +		if (amend) {
> +			/*
> +			 * When amending (e.g. melding a "fixup!" or "squash!"),
> +			 * the commit we are about to create replaces HEAD, so
> +			 * its parent is HEAD's parent.  It is therefore empty
> +			 * when the index matches the tree of HEAD's parent
> +			 * rather than the tree of HEAD itself.
> +			 */
> +			if (head_commit->parents) {
> +				struct commit *parent =
> +					head_commit->parents->item;
> +				if (repo_parse_commit(r, parent))
> +					return -1;
> +				head_tree_oid = get_commit_tree_oid(parent);
> +			} else {
> +				head_tree_oid = the_hash_algo->empty_tree;
> +			}
> +		} else {
> +			head_tree_oid = get_commit_tree_oid(head_commit);
> +		}
>   	}
>   
>   	if (!(cache_tree_oid = get_cache_tree_oid(istate)))
> @@ -1786,7 +1805,7 @@ static int is_original_commit_empty(struct commit *commit)
>    */
>   static int allow_empty(struct repository *r,
>   		       struct replay_opts *opts,
> -		       struct commit *commit)
> +		       struct commit *commit, int amend)
>   {
>   	int index_unchanged, originally_empty;
>   
> @@ -1798,13 +1817,33 @@ static int allow_empty(struct repository *r,
>   	 * drop_redundant_commits determine whether the commit should be kept or
>   	 * dropped. If neither is specified, halt.
>   	 */
> -	index_unchanged = is_index_unchanged(r);
> +	index_unchanged = is_index_unchanged(r, amend);
>   	if (index_unchanged < 0)
>   		return index_unchanged;
>   	if (!index_unchanged)
>   		return 0; /* we do not have to say --allow-empty */
>   
> -	originally_empty = is_original_commit_empty(commit);
> +	/*
> +	 * When amending (melding a "fixup!"/"squash!"), the resulting commit
> +	 * replaces HEAD, so whether it "started" empty or "became" empty is
> +	 * decided by whether the commit being melded into was itself empty: if
> +	 * HEAD had content that the fixup cancelled out, the commit became empty
> +	 * and is subject to keep/drop_redundant; if HEAD was already empty, the
> +	 * commit started empty and is subject to allow_empty as usual.
> +	 */
> +	if (amend) {
> +		struct object_id head_oid;
> +		struct commit *head_commit;
> +
> +		if (repo_get_oid(r, "HEAD", &head_oid))
> +			return error(_("could not resolve HEAD commit"));
> +		head_commit = lookup_commit_reference(r, &head_oid);
> +		if (!head_commit)
> +			return -1;
> +		originally_empty = is_original_commit_empty(head_commit);
> +	} else {
> +		originally_empty = is_original_commit_empty(commit);
> +	}
>   	if (originally_empty < 0)
>   		return originally_empty;
>   	if (originally_empty)
> @@ -2260,6 +2299,30 @@ static const char *reflog_message(struct replay_opts *opts,
>   	return buf.buf;
>   }
>   
> +/*
> + * A "fixup!"/"squash!" that melds into HEAD may empty it out.  In that case,
> + * with --empty=drop, we want to drop the commit entirely.  Since the commit
> + * being amended has already been created (by the preceding "pick"), and the
> + * index and worktree already match the tree of its parent, dropping it is a
> + * matter of moving HEAD back to that parent.
> + */
> +static int reset_head_to_parent(struct repository *r, struct replay_opts *opts,
> +				struct object_id *head)
> +{
> +	struct commit *head_commit = lookup_commit_reference(r, head);
> +
> +	if (!head_commit || repo_parse_commit(r, head_commit))
> +		return error(_("could not parse HEAD commit"));
> +	if (!head_commit->parents)
> +		return error(_("cannot drop the root commit"));
> +
> +	return refs_update_ref(get_main_ref_store(r),
> +			       reflog_message(opts, "fixup",
> +					      "dropping emptied commit"),
> +			       "HEAD", &head_commit->parents->item->object.oid,
> +			       head, 0, UPDATE_REFS_MSG_ON_ERR);
> +}
> +
>   static int do_pick_commit(struct repository *r,
>   			  struct todo_item *item,
>   			  struct replay_opts *opts,
> @@ -2493,7 +2556,7 @@ static int do_pick_commit(struct repository *r,
>   	}
>   
>   	drop_commit = 0;
> -	allow = allow_empty(r, opts, commit);
> +	allow = allow_empty(r, opts, commit, flags & AMEND_MSG);
>   	if (allow < 0) {
>   		res = allow;
>   		goto leave;
> @@ -2506,9 +2569,24 @@ static int do_pick_commit(struct repository *r,
>   		unlink(git_path_merge_msg(r));
>   		refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
>   				NULL, REF_NO_DEREF);
> -		fprintf(stderr,
> -			_("dropping %s %s -- patch contents already upstream\n"),
> -			oid_to_hex(&commit->object.oid), msg.subject);
> +		if (flags & AMEND_MSG) {
> +			/*
> +			 * The "fixup!"/"squash!" emptied out the commit it was
> +			 * melded into; that commit was already created by the
> +			 * preceding "pick", so drop it by moving HEAD back to
> +			 * its parent.
> +			 */
> +			res = reset_head_to_parent(r, opts, &head);
> +			if (res)
> +				goto leave;
> +			fprintf(stderr,
> +				_("dropping %s %s -- resulting commit is empty\n"),
> +				oid_to_hex(&commit->object.oid), msg.subject);
> +		} else {
> +			fprintf(stderr,
> +				_("dropping %s %s -- patch contents already upstream\n"),
> +				oid_to_hex(&commit->object.oid), msg.subject);
> +		}
>   	} /* else allow == 0 and there's nothing special to do */
>   	if (!opts->no_commit && !drop_commit) {
>   		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 5033411a43..508dcc7527 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -510,4 +510,68 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
>   	test_commit_message HEAD -m "something"
>   '
>   
> +test_expect_success 'fixup! that empties its target is dropped with --empty=drop' '
> +	git reset --hard base &&
> +	test_commit --no-tag addX fileX 1 &&
> +	test_commit --no-tag changeX fileX 2 &&
> +	test_commit --no-tag later fileW hello &&
> +	echo 1 >fileX &&
> +	git commit -m "fixup! changeX" fileX &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~4 &&
> +
> +	git log --format=%s >actual &&
> +	! grep changeX actual &&
> +	grep addX actual &&
> +	grep later actual &&
> +	echo 1 >expect &&
> +	test_cmp expect fileX &&
> +	echo hello >expect &&
> +	test_cmp expect fileW
> +'
> +
> +test_expect_success 'fixup! that empties its target is kept with --empty=keep' '
> +	git reset --hard base &&
> +	test_commit --no-tag addY fileY 1 &&
> +	test_commit --no-tag changeY fileY 2 &&
> +	echo 1 >fileY &&
> +	git commit -m "fixup! changeY" fileY &&
> +
> +	git rebase -i --autosquash --empty=keep HEAD~3 &&
> +
> +	git log --format=%s >actual &&
> +	grep changeY actual &&
> +	: "the retained commit is empty" &&
> +	git diff --exit-code HEAD~1 HEAD &&
> +	echo 1 >expect &&
> +	test_cmp expect fileY
> +'
> +
> +test_expect_success 'fixup! that empties its target stops with --empty=stop' '
> +	git reset --hard base &&
> +	test_commit --no-tag addZ fileZ 1 &&
> +	test_commit --no-tag changeZ fileZ 2 &&
> +	echo 1 >fileZ &&
> +	git commit -m "fixup! changeZ" fileZ &&
> +
> +	test_when_finished "git rebase --abort" &&
> +	test_must_fail git rebase -i --autosquash --empty=stop HEAD~3
> +'
> +
> +test_expect_success 'squash! that empties its target is dropped with --empty=drop' '
> +	git reset --hard base &&
> +	test_commit --no-tag addS fileS 1 &&
> +	test_commit --no-tag changeS fileS 2 &&
> +	echo 1 >fileS &&
> +	git commit -m "squash! changeS" fileS &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~3 &&
> +
> +	git log --format=%s >actual &&
> +	! grep changeS actual &&
> +	grep addS actual &&
> +	echo 1 >expect &&
> +	test_cmp expect fileS
> +'
> +
>   test_done
> 
> 
> 
> 

