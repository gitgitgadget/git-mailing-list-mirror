Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD319CC0C
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773541555; cv=none; b=KxXCVYSaEMDaReyP6m80fBECUJ0VnToenMbuWfm3UYxEt7TdENyszo1lSAIeTQt2QlmPYeZKfMhG2e/xUpCBnDohHpWPESyIjwQWdRdAO+sOR2TnVqRCm3zRYq/gNTC+lwNeFjNdMCoob1r+yLdZ7+pfoIZ5/lBEq44kHIxA40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773541555; c=relaxed/simple;
	bh=lqLVtiUNkUe77U2WOHMHKhiOiU2qKoR+/OxS7KMKfbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VJgDMhQeINs6NvWtu7bEwqcXNXkL/7vXwbxhxC11IjB9G+qbkhzigvH10aMJWhAaXglbmz6LZ66PY5bqQZ4gAfg0MmDDPJgfI/WUq6nDoe6s7/ouFmCa3kJJnfut5YVsj3Syozjk9w2e/f6yHbjBaNYd5I4yXvn9Oc/sIzm5noI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W/cEUSEI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/M8hQYg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W/cEUSEI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/M8hQYg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43DBA1400093;
	Sat, 14 Mar 2026 22:25:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 14 Mar 2026 22:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773541552; x=1773627952; bh=emPMd+1mw/
	3ayVxJKODQXsnQz1eAKcxhjMpQ4SJSvBo=; b=W/cEUSEIyNQ9g9EnQoDEsUvdom
	IMHYdCGtoQm1tJxXwinGvMtNfelPuYkfWU89EMM5XS2wiZ7peHa+ytISKvMTHN4s
	rtSwpjxOqUO51V4QJWYq+Y3aW/vYfK1fHIpCI9vFJor+XjqeE1F211OEzuwiOpsv
	7Ja255q4SLWWqV1/h3OvzF5zOY4puX1jz5tJ87iEoBDVq518tieKgPXPAnfC8lDx
	TUTT76Y0PCnaWhdWn6fVw72zl8pCSjrKVBBIKACj6pRLti+47nS+8j6kU1emjUwC
	4u8+uHgxAY7FaIa/OILMONBgb6cHuS0+cMB5bxvxcZk0FY3rNoJatwCyFlNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773541552; x=1773627952; bh=emPMd+1mw/3ayVxJKODQXsnQz1eAKcxhjMp
	Q4SJSvBo=; b=Q/M8hQYgiWJ+ubZQjKwS8OnOFb0ybMlP4RgWgk9FYv3H8B+LgHe
	O7LKNfst1I+NSQOjVP0tX9rNCXKlIdlQbyXuWxsvUw5bnTTD3o3mNVY74hi7ITln
	EkH+5fMS52HN9ASFaI4Q2AyjDBAaI0BlWO3+SzSLGg89klTDmvfw+qM1GTwY4Oqq
	0aHq108NJbNXzcXgqm/rZooMP87ajnBJPxkq/QrNlZXdpZTJ1LsTDsNokvFPV/01
	tJ81dtTHp8wLepwGLYgQgffZm+oiuvDvXSRA/R/KVebD+y5G95U0SAXXGQ0Iztde
	+T3ekjMoa0wIFcbgBLoFwwzwaWLV3IVNbgA==
X-ME-Sender: <xms:rxi2aT_zLaMN22TnGqaUR7B9gJ_73AWMvLuOsXHA7HIpMO1h66mzow>
    <xme:rxi2aRNW0ChHW7wSWSkLi7CGdRezB3X1LnIkHu0IeEQyUFV0Lf3JAHzHrQeMofWjb
    bp4DikesTOESAI-cG3UKLvujrEmma36FgSzgZtxRglbAXEvkRVBlqs>
X-ME-Received: <xmr:rxi2aRF1o5a6fZGKcNV5KYgmzA-hyamJGnDOLF2e6Vl3Mwcd6FXEBMk8LsVLfTPeDXHYJK_gKdzDQPl-jfE-xNBN2YvJwhlLNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleegvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rxi2afR3bqwRjX_dtv1F0CPyp7MhduTSNGh4Wd5ET19EXj54bwRa9w>
    <xmx:rxi2aeuS9y3gghZOpGOTosocQGMei1EOK8-yEJSO2E16gqv_icnbJA>
    <xmx:rxi2aXLxfTKCIXsHa8kQIWSfxXyKltby4E2-DcV8UY39PcSsULidGg>
    <xmx:rxi2aTmUZ2DAsh6MXPB_4OkM9-vvkWIrD1VXZ_ussooNZ-5mYXP3rA>
    <xmx:sBi2aVgchuDtCHsoirdRRSkNuozr0hlTfUfnPWpJh4kEKklVR3fR1QUD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 22:25:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4] checkout: -m (--merge) uses autostash when switching
 branches
In-Reply-To: <pull.2234.v4.git.git.1773482375668.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sat, 14 Mar 2026
	09:59:35 +0000")
References: <pull.2234.v3.git.git.1773393818235.gitgitgadget@gmail.com>
	<pull.2234.v4.git.git.1773482375668.gitgitgadget@gmail.com>
Date: Sat, 14 Mar 2026 19:25:50 -0700
Message-ID: <xmqqfr61vnf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> When switching branches with "git checkout -m", local modifications
> can block the switch.  Teach the -m flow to create a temporary stash
> before switching and reapply it after.  On success, only "Applied
> autostash." is shown.  If reapplying causes conflicts, the stash is
> kept and the user is told they can resolve and run "git stash drop",
> or run "git reset --hard" and later "git stash pop" to recover their
> changes.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     checkout: 'autostash' for branch switching
>     
>     cc: Phillip Wood phillip.wood123@gmail.com

I very much appreciate this, but somehow this "cc:" seems to have
been ignored.

>  Documentation/git-checkout.adoc |  56 +++++-----
>  Documentation/git-switch.adoc   |  26 ++---
>  builtin/checkout.c              | 179 +++++++++++++++++---------------
>  builtin/stash.c                 |  30 ++++--
>  sequencer.c                     |  67 +++++++++---
>  sequencer.h                     |   4 +
>  t/t3420-rebase-autostash.sh     |  24 +++--
>  t/t7201-co.sh                   | 160 ++++++++++++++++++++++++++++
>  t/t7600-merge.sh                |   4 +-
>  xdiff-interface.c               |  12 +++
>  xdiff-interface.h               |   1 +
>  11 files changed, 412 insertions(+), 151 deletions(-)
>
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index 43ccf47cf6..9d5f5c51ae 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -251,20 +251,17 @@ working tree, by copying them from elsewhere, extracting a tarball, etc.
>  	are different between the current branch and the branch to
>  	which you are switching, the command refuses to switch
>  	branches in order to preserve your modifications in context.
> -	However, with this option, a three-way merge between the current
> -	branch, your working tree contents, and the new branch
> -	is done, and you will be on the new branch.
> -+
> -When a merge conflict happens, the index entries for conflicting
> -paths are left unmerged, and you need to resolve the conflicts
> -and mark the resolved paths with `git add` (or `git rm` if the merge
> -should result in deletion of the path).
> +	With this option, the conflicting local changes are
> +	automatically stashed before the switch and reapplied
> +	afterwards.  If the local changes do not overlap with the
> +	differences between branches, the switch proceeds without
> +	stashing.  If reapplying the stash results in conflicts, the
> +	entry is saved to the stash list so you can use `git stash
> +	pop` to recover and `git stash drop` when done.

The new conflict message in sequencer.c correctly points out that,
if the user wants to use `git stash pop`, they would first need to
clear the working tree (e.g. `git reset --hard`) because the
conflicted changes are already there.

The documentation here is a bit too simplified and may give the
impression that `git stash pop` is the immediate next step when
conflicts are present in the worktree, which is probably something
we want to avoid.

>  ------------
>  $ git checkout -m mytopic
> -Auto-merging frotz
> +Applied autostash.
>  ------------

I must be utterly confused, but the documentation _before_ this
patch does not seem to match the reality.  In the following
illustration, I am switching to another branch that has contents in
transport.c that is different from the version in HEAD:

    $ git checkout master
    $ echo >>transport.c
    $ git checkout jk/transport-color-leakfix
    error: Your local changes to the following files would be overwritten...
        transport.c
    Please commit your changes or stash ...
    Aborting
    $ git checkout -m jk/transport-color-leakfix
    M	transport.c
    Switched to branch 'jk/transport-color-leakfix'

Hmmmm.

The new behavior is silent about individual files, and instead
reports "Applied autostash."; even though it is consistent with how
other commands may behave when given the "--autostash" option, I am
not sure if it is even necessary.

Even in the documented version, the "Auto-merging" message is
presumably given only to the paths that needed real content-level
merges, and the paths that went through the trivial tree-level
merges (i.e., paths that are different from HEAD and mytopic but
without local changes) are not reported.  The behaviour I am seeing
does not say anything to either trivially merged or really merged
paths while branch switching is happening, and shows the local
changes at the end of merge_working_tree() by calling
show_local_changes(), which runs "git diff --name-status"
in-process.

In either case, the stashing is a mere implementation detail of
carrying the local changes with you when you move to a different
branch, and moving with your local changes is what "Switching"
branch is about in this system, so I am not sure if we need to say
anything more than the current "Switched to branch 'mytopic'" in the
successful case.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 1d1667fa4c..1968e46ae9 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -17,7 +17,6 @@
>  #include "merge-ll.h"
>  #include "lockfile.h"
>  #include "mem-pool.h"
> -#include "merge-ort-wrappers.h"
>  #include "object-file.h"
>  #include "object-name.h"
>  #include "odb.h"
> @@ -30,6 +29,7 @@
>  #include "repo-settings.h"
>  #include "resolve-undo.h"
>  #include "revision.h"
> +#include "sequencer.h"
>  #include "setup.h"
>  #include "submodule.h"
>  #include "symlinks.h"
> @@ -845,83 +845,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  
>  		ret = unpack_trees(2, trees, &topts);
>  		clear_unpack_trees_porcelain(&topts);
> -		if (ret == -1) {
> -...
> -		}
> +		if (ret == -1)
> +			return 1;
>  	}
>  
>  	if (!cache_tree_fully_valid(the_repository->index->cache_tree))
> @@ -930,9 +855,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
>  		die(_("unable to write new index file"));
>  
> -	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
> -		show_local_changes(&new_branch_info->commit->object, &opts->diff_options);

Ah, this is what you lost.  I do not see a reason why we would want
to lose it.

> +static int checkout_would_clobber_changes(struct branch_info *old_branch_info,
> +					  struct branch_info *new_branch_info)
> +{
> +...
> +	init_tree_desc(&trees[0], &old_tree->object.oid,
> +		       old_tree->buffer, old_tree->size);
> +	init_tree_desc(&trees[1], &new_tree->object.oid,
> +		       new_tree->buffer, new_tree->size);
> +
> +	ret = unpack_trees(2, trees, &topts);
> +	discard_index(&tmp_index);

In my original outline, I did suggest 

 - check if the local changes overlap with paths that differ between
   HEAD and the new branch, and if not, we need no stashing;
   otherwise stash.

 - then switch branches with two-way merge

 - then unstash.

But my untold assumption was that the initial check was done by
running a moral equivalent of "git diff --name-only HEAD <branch>"
to obtain the list of paths that differ between branches, and
a "git diff HEAD" to obtain the list of paths with local changes.

If you are using the real branch switching machinery in the
"dry-run" mode, then it is a waste to discard when we find out that
there is no overlap.  So if I knew you would use the unpack-trees in
the dry-run mode, instead of two diffs, the outline would have been
more like

 - Try unpack-trees in dry-run mode to see if there would get any
   failure from overlap.

 - If unpack-trees would succeed, we already have the right contents
   in the index after the above dry-run.  We did not touch the
   working tree so far, but if we kept track of which paths we would
   have written out to the working tree during our dry-run, we can
   write them out of the index at this point and we are done (we of
   course need to update HEAD to point at the new branch, give the
   "Switched to branch 'foo'" message, etc., but the real work of
   switching branches is done).

 - If not, discard the dry-run index, stash, switch branches the
   usual way, and unstash.

which might be more performant in a large tree.

Having said all that, what we see above, while running the same
unpack-trees once in dry-run mode and another for real, may be
performant enough and complicating the dry-run code might not be
worth it.

> @@ -1165,6 +1136,8 @@ static int switch_branches(const struct checkout_opts *opts,
>  	struct object_id rev;
>  	int flag, writeout_error = 0;
>  	int do_merge = 1;
> +	struct strbuf old_commit_shortname = STRBUF_INIT;
> +	const char *stash_label_ancestor = NULL;
>  
>  	trace2_cmd_mode("branch");
>  
> @@ -1202,10 +1175,34 @@ static int switch_branches(const struct checkout_opts *opts,
>  			do_merge = 0;
>  	}
>  
> +	if (old_branch_info.name)
> +		stash_label_ancestor = old_branch_info.name;
> +	else if (old_branch_info.commit) {
> +		strbuf_add_unique_abbrev(&old_commit_shortname,
> +					 &old_branch_info.commit->object.oid,
> +					 DEFAULT_ABBREV);
> +		stash_label_ancestor = old_commit_shortname.buf;
> +	}
> +
> +	if (opts->merge) {
> +		if (repo_read_index(the_repository) < 0)
> +			die(_("index file corrupt"));
> +		if (checkout_would_clobber_changes(&old_branch_info,
> +						   new_branch_info))
> +			create_autostash_ref_silent(the_repository,
> +						   "CHECKOUT_AUTOSTASH");
> +	}
> +
>  	if (do_merge) {
>  		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>  		if (ret) {
> +			apply_autostash_ref_with_labels(the_repository,
> +						       "CHECKOUT_AUTOSTASH",
> +						       new_branch_info->name,
> +						       "local",
> +						       stash_label_ancestor);
>  			branch_info_release(&old_branch_info);
> +			strbuf_release(&old_commit_shortname);
>  			return ret;
>  		}
>  	}

Nice changes to preserve the conflict marker labels.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index e79d612e57..1016d88e52 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c

This can and should become a separate patch that is a preliminary
preparation step, [1/2], with its own documentation and test, only
about teaching "git stash" command a set of new options to use
custom conflict labels, I think.  And on top of it, patch [2/2] that
updates "checkout -m" to use the improved "git stash" with custom
labels support is written.  It would give us a clean logical
progression of the series.

> diff --git a/sequencer.c b/sequencer.c
> index aafd0bc959..53e04d8a94 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4632,7 +4632,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
>  
>  static void create_autostash_internal(struct repository *r,
>  				      const char *path,
> -				      const char *refname)
> +				      const char *refname,
> +				      int silent)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	struct lock_file lock_file = LOCK_INIT;
> @@ -4677,7 +4678,8 @@ static void create_autostash_internal(struct repository *r,
>  					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
>  		}
>  
> -		printf(_("Created autostash: %s\n"), buf.buf);
> +		if (!silent)
> +			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
>  		if (reset_head(r, &ropts) < 0)
>  			die(_("could not reset --hard"));
>  		discard_index(r->index);
> @@ -4689,15 +4691,22 @@ static void create_autostash_internal(struct repository *r,
>  
>  void create_autostash(struct repository *r, const char *path)
>  {
> -	create_autostash_internal(r, path, NULL);
> +	create_autostash_internal(r, path, NULL, 0);
>  }
>  
>  void create_autostash_ref(struct repository *r, const char *refname)
>  {
> -	create_autostash_internal(r, NULL, refname);
> +	create_autostash_internal(r, NULL, refname, 0);
>  }
>  
> -static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
> +void create_autostash_ref_silent(struct repository *r, const char *refname)
> +{
> +	create_autostash_internal(r, NULL, refname, 1);
> +}

Changes around here to optionally squelch message(s) is better
presented as yet another preliminary preparation step, I think.

> @@ -4752,7 +4775,8 @@ static int apply_save_autostash(const char *path, int attempt_apply)
>  	}
>  	strbuf_trim(&stash_oid);
>  
> -	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
> +	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
> +				      NULL, NULL, NULL);
>  
>  	unlink(path);
>  	strbuf_release(&stash_oid);
> @@ -4771,11 +4795,13 @@ int apply_autostash(const char *path)
>  
>  int apply_autostash_oid(const char *stash_oid)
>  {
> -	return apply_save_autostash_oid(stash_oid, 1);
> +	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
>  }
>  
>  static int apply_save_autostash_ref(struct repository *r, const char *refname,
> -				    int attempt_apply)
> +				    int attempt_apply,
> +				    const char *label1, const char *label2,
> +				    const char *label_ancestor)
>  {
>  	struct object_id stash_oid;
>  	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
> @@ -4791,7 +4817,8 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
>  		return error(_("autostash reference is a symref"));
>  
>  	oid_to_hex_r(stash_oid_hex, &stash_oid);
> -	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
> +	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
> +				       label1, label2, label_ancestor);
>  
>  	refs_delete_ref(get_main_ref_store(r), "", refname,
>  			&stash_oid, REF_NO_DEREF);
>
> @@ -4801,12 +4828,20 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
>  
>  int save_autostash_ref(struct repository *r, const char *refname)
>  {
> -	return apply_save_autostash_ref(r, refname, 0);
> +	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
>  }
>  
>  int apply_autostash_ref(struct repository *r, const char *refname)
>  {
> -	return apply_save_autostash_ref(r, refname, 1);
> +	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
> +}
> +
> +int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
> +				    const char *label1, const char *label2,
> +				    const char *label_ancestor)
> +{
> +	return apply_save_autostash_ref(r, refname, 1,
> +					label1, label2, label_ancestor);
>  }
>  
>  static int checkout_onto(struct repository *r, struct replay_opts *opts,

So are these, to teach the machinery to take optional conflict
marker labels.

Thanks.
