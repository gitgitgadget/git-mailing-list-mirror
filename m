Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792939637;
	b=anoRSaPw4zxYo/pm1D0/FOJXiG2VcCxkME/xR1E8youAOT0aDxjmq1+3LveWCcN9WZf4
	 IfX09SQwqcpLWSuF81tJdlYG1GVh8HHjdVW1SA/PUJUFjl6LCHDWcvptJSFjIKVbb7cvL
	 tDI05luiQ/6nja0Szodw2LrbgoQya8qXHxbTiX5ve3kDqMbjOSHxbr7YrUHhl6Sc+FpIn
	 i8fHapHD4D1R0TYklUYacuURx651dkPX3zF607ZVhl8rHJjUFKO5xW2XLUVE5xTx5hwer
	 qGSMwDofcOhnxGJYpgKDh2J3uxu0MNhJPawl+3NdWqndfhoJ27etDj3JCuHrXnGhWqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792939637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wE6B2KAbM6+jXYEY4qkP5Qk4wjQsyBb5AI2bk0eqAr8=;
	b=tGZh1EuDownGEjTRr4UogY12SK5WIQRoPc57C4I9YvGqCakl1lbY1h3Z/3eqFpF3wGtJ
	 umrVjIygMxEBsATnzXv9sKz/SkhptwH9gwhcsfZqkrV82oUaRgEMrGKgXybLJKflrERta
	 S+qEFSnWNL7w+IiaYRtSnNONlI1zTHRD9J8GFYR2Vs8A4Nm4JpGoGO25Z/VkAI3lwTVvH
	 fZDCC4Xvr32j101W0lwgbgheOiePzF0DvE6WvUkdwGF+FLNjaZGUvREMhv+/OvhjD1ij5
	 LKF0GVH3DyYqb9gwjZIZOLDxVDJ1B5oykA+FxEIIoIatCElYhRxVwM5QtfqeUG1xzjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PGPY1ZWx;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F39606A31B
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 14:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1F39606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PGPY1ZWx
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1187112f8f.3
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792939635; x=1793544435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wE6B2KAbM6+jXYEY4qkP5Qk4wjQsyBb5AI2bk0eqAr8=;
        b=PGPY1ZWxgRRqvf2AGRE+K7RwA/8nygFp56uYhvZ/Lp6/uEEQCGqRx/tCuKiIdnCZck
         c5txYSyZKvo4hEuTgW4NET9CLDfS2nyYQYy2Nf1Kt46WG9vPCLtMumdj2Z5nr4FjsE8w
         N8bgQzLyTy105teN6Iwdykwz2luottqfqMHZfcJCJ7VyApz0FfRtarCDjo7Gx7CVcYaQ
         HW5r2o5YIA65XzPDCnoIkmLOx6UNBnFFDaXG2w1PvQkgtWJaMJY4szPX0tpt6PU92HKz
         RxYwnaYugmc8jVkXH1uuYvj1tF8vJYxHP3ByNNQZ/styKqIyDsLmJiuP4xkKdVxSq8gs
         G74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792939635; x=1793544435;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wE6B2KAbM6+jXYEY4qkP5Qk4wjQsyBb5AI2bk0eqAr8=;
        b=ihDUYUwWJOzJIPX+Z7lc6h11I1KPJkO1FELXga+jFw84yjXPkvbeXx4B6TpIQCuzEt
         B3Pv5KE10ACkdKUf4W6XQoHVespJ7he1nidAAgzu4dNP+5mVTbxqEz7u6BCClrcMMdZB
         ALG0p5U+wRxo+HlVD+0O7fBrJaIqNkUCx7ZrMm0LKYNKmjyUNwMolBp16vGu8/RFR/Js
         PFOCI0fdkVZ8P0TWlnCL+2GpE0v/TOuDpbPqQB4fjJ8Go9xR9kJotw7U5ufagd1KRksQ
         Wwvhz/9Dd/8VKJVFcxxANNpRGceHNmBFwab8zz7nokYea7puDUmBC7EvOabdHfSzpWDN
         uTZg==
X-Forwarded-Encrypted: i=1; AKwUvBwC5EX/WWA+Z9aYzyctPlG9k/g3jLaDVHjtbo9HCaFg/WcajWv19ECzgF+MKdGmcs3sOHw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJT+3xubimKyVbYUaej5X1nvk0fzhF32+5Mno8/XcyU3tU3VTmc
	7wm2RKaGr7ZJowm2/C10QZn8fmH9H36sZJ7nvv7lCp1xAZ0m/pEFC4pX
X-Gm-Gg: AYBFou2lDrctuGO5Xkv+4GLXoXbo5f8WmI6xdoUYNfW2VyYpd0aXgxt7TZSMRxRGG3p
	0rioA4vJEqHHPrrHgmj8DKhY0m6LDuJDeg29a96Lnz8peJYct1bzG1/fP4tLfpk8LBnshTqa3G1
	rdcf5iWFsKGSGpdr/CTp7KQXlbr14wXYCHC1y/6bBWwz9iY146jGd3Nj78UXn5Y2TbGeT41UxUU
	Qgt1VyP10tvmuTcYbWxnCkMFtSQdkUQ4DGS3GxGDId+PXnvnoqi1xhj9Sv/V1ulGpd8SVlG8TqT
	j0Zojjb3oiixmsw75MxRfwwZZSpQ+FDwYKaYCScIKZcbkruTjffNgDFNlx3miVnmRvTrV40WT8r
	3QgDT/D43WBbLXMd5+UoCXanTSYsK/8oYBrRrRtTc1tJDOf4EPCHDaVOcNqHGLexln/uQKKzBUU
	njO6ZQj29wMqTPCqaC8ZbLVDP9bglCmZCR3ewPgxA3HfAH8lVdCxEwrKAXbYmsd8omqLr+IgdQ1
	kNbEAyf5l+Vh8s35Z7j+kEafSUvB3kfLrqugSU1Q/GOtuTd3EDPJzdX3BBNyA476elI226x4qr1
	xqmDElKfrHVnvk4DvDZ3Wp0t3WFRZxUbEQ==
X-Received: by 2002:a5d:458a:0:b0:48d:f0e4:27a4 with SMTP id ffacd0b85a97d-48e3eb8bbdemr5261523f8f.24.1792939634989;
        Sun, 25 Oct 2026 07:47:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb90dsm9576773f8f.22.2026.10.25.07.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 07:47:14 -0700 (PDT)
Message-ID: <e08fd267-7017-493f-8f1b-d8dfb568b5fd@gmail.com>
Date: Sun, 25 Oct 2026 14:47:13 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by
 branch
To: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com, haraldnordgren@gmail.com,
 ben.knoble@gmail.com
References: <CAPig+cTZEcn_5TG0iMVJJym8Zhu1KYP+y9Oc1J=JJgDYSzNSdg@mail.gmail.com>
 <20261024165311.57387-1-me@jaspermayone.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261024165311.57387-1-me@jaspermayone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasper

On 24/10/2026 17:53, Jasper Mayone wrote:
> There is no direct way to ask which worktree has a given branch
> checked out. "git worktree list --porcelain" prints the branch of
> every worktree, so a script has to parse the whole list and match the
> "branch" lines itself.
> 
> Teach "git worktree list" a "--branch=<branch>" option that lists
> only the worktrees that have <branch> checked out. It can be given
> more than once.

Playing devil's advocate for a minute that means the script still has to 
match branch names if it wants to know each branch is checked out. It 
does make it easier for scripts that are only interested in a single 
branch though.

> A worktree that is rebasing or bisecting a branch
> counts as having it checked out, as it does for "git branch -d" and
> "git worktree add". <branch> is a branch name, or a full name under
> refs/heads/.

That's useful because "git worktree list" does not show branch names 
when they're being rebased or bisected. The commit message should spell 
that out.

> This keeps the choice of branches in "git branch", which already has
> --merged, --contains, --points-at and patterns.

This sentence seems to assume the reader has some context from the 
previous iteration

> For example, to list
> the worktrees whose branch is merged into origin/main:
> 
>      git worktree list \
> 	$(git branch --format='--branch=%(refname)' --merged origin/main)
> 
> The --format is needed because the default output of "git branch"
> marks the current branch with "*" and the branches checked out in
> other worktrees with "+". It uses the full name because
> %(refname:short) gives "heads/topic" when a tag is also called
> "topic".
> 
> Each worktree's branch is found once and looked up in a set of the
> requested branches, so feeding it every branch of a large repository
> stays cheap.

The implementation seems to duplicate much of 
branch.c:prepare_checked_out_branches(). It would be nicer to add a 
preparatory patch (or maybe two patches) that adds a "struct worktree" 
member to "struct checked_out_branch" and converts 
"checked_out_branches" to a hashmap indexed by the branch name. Then we 
can implement "git worktree list --branch" in terms of a new function

const struct worktree *branch_find_checkout(const char *branch);

in branch.c that looks up the branch in "checked_out_branches" and 
returns the worktree if it is checked out, or it is being rebased or 
bisected.

Another thing to think about is that normally the main worktree is 
listed first, but if we are listing a subset of worktrees there is no 
way to tell from the output if one of them is the main worktree. I think 
that matters because we don't want to delete the main worktree - "git 
worktree remove path/to/main-worktree" will die but it would be nice if 
the script could avoid calling that in the first place. So I think we 
want another patch that adds something like "is-main-worktree true" when 
the main worktree is printed.

Is there a reason we reject syntactically invalid branch names, but 
accept the names of branches that do not exist?
	
> A detached worktree has no branch, so it is never listed.

I'm not sure that sentence is really needed.

Thanks

Phillip

> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jasper Mayone <me@jaspermayone.com>
> ---
> Changes since the RFC [1]:
> 
>   * Junio pointed out that --merged and --no-merged narrow the problem
>     to one workflow, and suggested selecting worktrees by branch
>     instead, with "git branch" doing the choosing. Eric had the same
>     reaction. This version does that and drops --merged, --no-merged
>     and the reachability code.
> 
>   * Junio's example piped "git branch" through sed. Its default output
>     prefixes the current branch with "*" and branches checked out in
>     other worktrees with "+", which are the branches this is for, so
>     the words come out as "--branch=+" and "topic". The documented form
>     uses --format='--branch=%(refname)'. The full name also avoids
>     "heads/topic" from %(refname:short) when a tag has the same name.
> 
>   * <branch> is an exact name, not a pattern, because "git branch"
>     already has --list <pattern>, --merged, --contains and friends.
>     An invalid name dies, as for "git branch -d". A valid name that no
>     worktree has checked out lists nothing.
> 
>   * Eric, a "git worktree foreach" would be nice, and it could select
>     worktrees with this same --branch. I left it out of this patch.
> 
> [1] https://lore.kernel.org/git/20261021173350.67854-1-me@jaspermayone.com/
> 
>   Documentation/git-worktree.adoc |  21 ++++-
>   builtin/worktree.c              |  79 ++++++++++++++++++-
>   t/t2402-worktree-list.sh        | 131 ++++++++++++++++++++++++++++++++
>   3 files changed, 228 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> index e6e77252ab..4db11eab88 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -11,7 +11,7 @@ SYNOPSIS
>   [synopsis]
>   git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
>   		 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
> -git worktree list [-v | --porcelain [-z]]
> +git worktree list [-v | --porcelain [-z]] [--branch=<branch>...]
>   git worktree lock [--reason <string>] <worktree>
>   git worktree move <worktree> <new-path>
>   git worktree prune [-n] [-v] [--expire <expire>]
> @@ -114,6 +114,9 @@ whether the worktree is bare, the revision currently checked out, the
>   branch currently checked out (or "detached HEAD" if none), "locked" if
>   the worktree is locked, "prunable" if the worktree can be pruned by the
>   `prune` command.
> ++
> +With `--branch`, only the worktrees that have one of the given branches
> +checked out are listed.
>   
>   `lock`::
>   
> @@ -268,6 +271,22 @@ mismatch, even if the links are correct.
>   	to parse the output when a worktree path contains a newline
>   	character.
>   
> +`--branch=<branch>`::
> +	With `list`, only list worktrees that have _<branch>_ checked
> +	out, including a worktree that is rebasing or bisecting
> +	_<branch>_. _<branch>_ is a branch name, such as `topic` or
> +	`@{-1}`, or a full name under `refs/heads/`. The option can be
> +	given more than once to list the worktrees of several branches.
> +	A detached worktree is never listed.
> ++
> +Use linkgit:git-branch[1] to choose the branches. For example, to list
> +the worktrees whose branch is merged into `origin/main`:
> ++
> +------------
> +$ git worktree list \
> +	$(git branch --format='--branch=%(refname)' --merged origin/main)
> +------------
> +
>   `-q`::
>   `--quiet`::
>   	With `add`, suppress feedback messages.
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 77ecd0f71f..1d7db5f7fc 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -15,6 +15,7 @@
>   #include "object-name.h"
>   #include "parse-options.h"
>   #include "path.h"
> +#include "strmap.h"
>   #include "strvec.h"
>   #include "branch.h"
>   #include "read-cache-ll.h"
> @@ -26,6 +27,7 @@
>   #include "submodule.h"
>   #include "utf8.h"
>   #include "worktree.h"
> +#include "wt-status.h"
>   #include "quote.h"
>   
>   #define BUILTIN_WORKTREE_ADD_USAGE \
> @@ -33,7 +35,7 @@
>   	   "                 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]")
>   
>   #define BUILTIN_WORKTREE_LIST_USAGE \
> -	N_("git worktree list [-v | --porcelain [-z]]")
> +	N_("git worktree list [-v | --porcelain [-z]] [--branch=<branch>...]")
>   #define BUILTIN_WORKTREE_LOCK_USAGE \
>   	N_("git worktree lock [--reason <string>] <worktree>")
>   #define BUILTIN_WORKTREE_MOVE_USAGE \
> @@ -1125,11 +1127,78 @@ static void pathsort(struct worktree **wt)
>   	QSORT(wt, n, pathcmp);
>   }
>   
> +/*
> + * Return the full name of the branch that "wt" has checked out, or
> + * NULL. A worktree that is rebasing or bisecting a branch has it
> + * checked out, too, as for is_shared_symref().
> + */
> +static char *checked_out_branch(const struct worktree *wt)
> +{
> +	struct wt_status_state state = { 0 };
> +	char *ref = NULL;
> +
> +	if (wt->is_bare)
> +		return NULL;
> +	if (!wt->is_detached)
> +		return xstrdup_or_null(wt->head_ref);
> +
> +	if (wt_status_check_rebase(wt, &state) &&
> +	    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
> +	    state.branch)
> +		ref = xstrfmt("refs/heads/%s", state.branch);
> +	else if (wt_status_check_bisect(wt, &state) && state.bisecting_from)
> +		ref = xstrfmt("refs/heads/%s", state.bisecting_from);
> +	wt_status_state_free_buffers(&state);
> +	return ref;
> +}
> +
> +/*
> + * Keep only the worktrees that have one of the "--branch" branches
> + * checked out. A branch is given by its name, or by its full name
> + * under refs/heads/.
> + */
> +static void filter_by_branch(struct repository *repo, struct worktree **wt,
> +			     const struct string_list *branches)
> +{
> +	struct strset refnames = STRSET_INIT;
> +	struct string_list_item *item;
> +	struct strbuf ref = STRBUF_INIT;
> +	size_t kept = 0;
> +
> +	for_each_string_list_item(item, branches) {
> +		strbuf_reset(&ref);
> +		if (starts_with(item->string, "refs/heads/")) {
> +			strbuf_addstr(&ref, item->string);
> +			if (check_refname_format(ref.buf, 0))
> +				die(_("'%s' is not a valid branch name"),
> +				    item->string);
> +		} else if (check_branch_ref(repo, &ref, item->string)) {
> +			die(_("'%s' is not a valid branch name"), item->string);
> +		}
> +		strset_add(&refnames, ref.buf);
> +	}
> +
> +	for (size_t i = 0; wt[i]; i++) {
> +		char *branch = checked_out_branch(wt[i]);
> +
> +		if (branch && strset_contains(&refnames, branch))
> +			wt[kept++] = wt[i];
> +		else
> +			free_worktree(wt[i]);
> +		free(branch);
> +	}
> +	wt[kept] = NULL;
> +
> +	strbuf_release(&ref);
> +	strset_clear(&refnames);
> +}
> +
>   static int list(int ac, const char **av, const char *prefix,
> -		struct repository *repo UNUSED)
> +		struct repository *repo)
>   {
>   	int porcelain = 0;
>   	int line_terminator = '\n';
> +	struct string_list branches = STRING_LIST_INIT_DUP;
>   
>   	struct option options[] = {
>   		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
> @@ -1138,6 +1207,8 @@ static int list(int ac, const char **av, const char *prefix,
>   				N_("add 'prunable' annotation to missing worktrees older than <time>")),
>   		OPT_SET_INT('z', NULL, &line_terminator,
>   			    N_("terminate records with a NUL character"), '\0'),
> +		OPT_STRING_LIST(0, "branch", &branches, N_("branch"),
> +				N_("only show worktrees that have <branch> checked out")),
>   		OPT_END()
>   	};
>   
> @@ -1157,6 +1228,9 @@ static int list(int ac, const char **av, const char *prefix,
>   		/* sort worktrees by path but keep main worktree at top */
>   		pathsort(worktrees + 1);
>   
> +		if (branches.nr)
> +			filter_by_branch(repo, worktrees, &branches);
> +
>   		if (!porcelain)
>   			measure_widths(worktrees, &abbrev,
>   				       &display, &path_maxwidth);
> @@ -1174,6 +1248,7 @@ static int list(int ac, const char **av, const char *prefix,
>   		free(display);
>   		free_worktrees(worktrees);
>   	}
> +	string_list_clear(&branches, 0);
>   	return 0;
>   }
>   
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> index eeaf800d74..ea08bf79fa 100755
> --- a/t/t2402-worktree-list.sh
> +++ b/t/t2402-worktree-list.sh
> @@ -318,4 +318,135 @@ test_expect_success 'worktree path when called in .git directory' '
>   	test_cmp list1 list2
>   '
>   
> +test_expect_success 'setup for "list --branch"' '
> +	git init by-branch &&
> +	(
> +		cd by-branch &&
> +		test_commit base &&
> +		git branch topic-a &&
> +		git branch topic-b &&
> +		git branch unused &&
> +		git worktree add ../wt-a topic-a &&
> +		git worktree add ../wt-b topic-b &&
> +		git worktree add --detach ../wt-detached main &&
> +		git -C ../wt-a commit --allow-empty -m a &&
> +		git -C ../wt-b commit --allow-empty -m b &&
> +		git merge --ff-only topic-a
> +	)
> +'
> +
> +list_paths () {
> +	git -C by-branch worktree list --porcelain "$@" >out &&
> +	sed -n "s/^worktree //p" out >actual
> +}
> +
> +test_expect_success '"list --branch" shows the worktree of that branch' '
> +	list_paths --branch=topic-a &&
> +	echo "$(pwd)/wt-a" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list --branch" can be repeated' '
> +	list_paths --branch=topic-b --branch=main --branch=topic-a &&
> +	cat >expect <<-EOF &&
> +	$(pwd)/by-branch
> +	$(pwd)/wt-a
> +	$(pwd)/wt-b
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list --branch" with a branch that is not checked out' '
> +	list_paths --branch=unused --branch=no-such-branch &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success '"list --branch" never shows a detached worktree' '
> +	list_paths --branch=main &&
> +	echo "$(pwd)/by-branch" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list --branch" rejects an invalid branch name' '
> +	test_must_fail git -C by-branch worktree list --branch=-bad 2>err &&
> +	test_grep "is not a valid branch name" err
> +'
> +
> +test_expect_success '"list --branch" keeps the normal output format' '
> +	git -C by-branch worktree list --branch=topic-a >out &&
> +	sed "s/  */ /g" <out >actual &&
> +	echo "$(pwd)/wt-a $(git -C by-branch rev-parse --short topic-a) [topic-a]" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list --branch" works with -z' '
> +	git -C by-branch worktree list --porcelain -z --branch=topic-b >out &&
> +	tr "\0" "\n" <out >actual &&
> +	cat >expect <<-EOF &&
> +	worktree $(pwd)/wt-b
> +	HEAD $(git -C by-branch rev-parse topic-b)
> +	branch refs/heads/topic-b
> +
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list --branch" shows a worktree bisecting that branch' '
> +	test_when_finished "git -C wt-b bisect reset && git -C wt-b reset --hard HEAD~2" &&
> +	git -C wt-b commit --allow-empty -m b1 &&
> +	git -C wt-b commit --allow-empty -m b2 &&
> +	git -C wt-b bisect start topic-b topic-b~2 &&
> +	test_must_fail git -C wt-b symbolic-ref -q HEAD &&
> +	list_paths --branch=topic-b &&
> +	echo "$(pwd)/wt-b" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list --branch" shows a worktree rebasing that branch' '
> +	test_when_finished "git -C wt-b rebase --abort" &&
> +	test_must_fail git -C wt-b rebase -f -x false base &&
> +	test_must_fail git -C wt-b symbolic-ref -q HEAD &&
> +	list_paths --branch=topic-b &&
> +	echo "$(pwd)/wt-b" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list --branch" accepts a full branch name' '
> +	list_paths --branch=refs/heads/topic-a &&
> +	echo "$(pwd)/wt-a" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list --branch" with a tag of the same name' '
> +	test_when_finished "git -C by-branch tag -d topic-a" &&
> +	git -C by-branch tag topic-a base &&
> +	list_paths --branch=topic-a &&
> +	echo "$(pwd)/wt-a" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '"list --branch" shows unborn and prunable worktrees' '
> +	test_when_finished "rm -rf wt-unborn wt-gone && git -C by-branch worktree prune" &&
> +	git -C by-branch worktree add --orphan -b unborn ../wt-unborn &&
> +	git -C by-branch branch gone &&
> +	git -C by-branch worktree add ../wt-gone gone &&
> +	rm -rf wt-gone &&
> +	git -C by-branch worktree list -v --branch=unborn --branch=gone >out &&
> +	test_grep "^$(pwd)/wt-unborn .*\[unborn\]$" out &&
> +	test_grep "^$(pwd)/wt-gone .*\[gone\]$" out &&
> +	test_grep "prunable: gitdir file points to non-existent location" out
> +'
> +
> +test_expect_success '"list --branch" with "git branch --merged"' '
> +	git -C by-branch worktree list --porcelain \
> +		$(git -C by-branch branch --format="--branch=%(refname)" \
> +			--merged main) >out &&
> +	sed -n "s/^worktree //p" out >actual &&
> +	cat >expect <<-EOF &&
> +	$(pwd)/by-branch
> +	$(pwd)/wt-a
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   test_done
> 
> base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e

