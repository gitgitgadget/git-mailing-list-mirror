Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117932DC352
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431195; cv=none; b=mv/P4xyDwbjOjxueei0Vp+VrFSoyY04XB2KgLMK8B/wLk/HtCxr+yS8BJ/1nBpnLYYw8M0kik7vvsq2upymAPHWzJ7Ozbw2AxwrzwM4vLoGn8Dr1kdNU98JWA0wXUXK/7E9+RPdGpEvufpu7Wlc5i8OlDFOZt6ZKheCrslJmDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431195; c=relaxed/simple;
	bh=mmBlXGIwqYWwxHK25ItOYr7QRpQjpd8CFx68lThkS/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8LsmykqEgqb5Mq4ayGv/VROni0GebGDjmkuq6wFYaygIy1QjklItkM1Xbvzu5icl5Lp8MUwuLUWAQKUsgg9TRMuVNj73t00A3TkLNNX1qzeFq2+OafyT7gjQ846XKLB+Kj2Zbi3sKU521mlnB1PRVZr0aKfUUmp53OqIaf8HPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFNtCfkb; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFNtCfkb"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-65a431e305eso9174661a12.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 08:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771431191; x=1772035991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sGVD3v6cBoJIMw0uvWYF1tnBGL2361Xb1bpl7hVUMCs=;
        b=CFNtCfkbZqcx5dOZf9tdJwh/Tv0MpXh801XlzOKjUbBddVjz/vMNPqJ4CEbjYQgtAj
         i4RcYq1/+5T0/t69S63HJTr0mJqpxrEwBDiKLogN3VouOGhk8yWqg0IFta0LEpqpCOWj
         WEW6Vijg6pvnGvvqGQwksjUkCGT63uPtZlx29EH3l0AChNvCSZx6xwnJzlpG7tzLd1X6
         pzcMDzp5LxUcH3Ma7v5fPvayJgBMCyLH3fDWG2MgHE32+ooZQoxVRPjV4U//41j3Ee1o
         TLvOfdqJWgVdq7h4W9B29ePXLg7EoXhi+4epqizd1fOqI0lXwohYDparVGfy016wQfbr
         KHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771431191; x=1772035991;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGVD3v6cBoJIMw0uvWYF1tnBGL2361Xb1bpl7hVUMCs=;
        b=wYdB5NJtXstmW8p8ugMFpg9Wx/qriW/bWyEx1wqiEP8jCki3on1wobk997SA6WqKw4
         +ojS+/k5OcDMJ7KlM88OLrJh6XNWqDPiQIEF4/nOT7APJjC+abqCA/OvO7zyGhmvEFFz
         RrZ1wsPsCmIvqOWty294CbKd1W0+BqPpZI8+4wDAuE2UnCjNGvUlJh7iHDJpCsJIL7bI
         LUdf/EVOdmEqtBvOHwL0bvS8DZXggXPwMvHbTjwf8JKyy5END4OpGDxiTkTrESMgc6qt
         SIMA2c15GA1q7COrTJv0QLdMOwiVWqSc6YPfy9g80rczONTzJrQ6W2lWs6K48taP2Jyz
         WT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGWQhgfoxe02RQXehtNbxk8FQfCZnHw0EbOZ6RFQinPXAy20rEk4cMBOPuHlO1DNPQlCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWctgtTXKBxAAOJWUjZjig8+aOTCWm6qyd5fzTl+9z3IWcpJj/
	3iG1veoIs53+blSf8Rhb9HKAl8kQ3OhU4QOeaOIC5TjWZmy4RkQ7z8dx
X-Gm-Gg: AZuq6aJ/WUbZnyXPQNhCSjNJ/LNFF0g/Zv5TumGBOuV4hrGhNPcVYk62l5A5Kr38Hlt
	TyIO5ERXDReoOrR+U+L+UrlPcThPfajBLZg1gzfMVSoDSLyrw+DRljt0qx4+hmFyVa6kBcogFVF
	KZFefeGDkgSCEAWKdUZY0I462XinNdr23AiCGL9mjIoJ9Vviv0zttWSuUTrsyI7YAqCN0iQKY2N
	As30kUhskY9XMHai7NJJVlXXN2W8n8lQ+MoBlFdNaO7nyBJQ8SWHm0s9qv9956wKLJZbrIUZ4Wx
	bK2nCVum2XxKAlfNFFHJ4CULrs+DVomZiKND3zSfFhWowaW5oSq+Kl/5/S39CsN+3NYUaZCHGPg
	WGc42D3Jd+xjbe2ar+cwpMGrZQNkBUuQdpVozWTjgeiWtrfFCk4Y7014rgHOYJBY/T20LBf6584
	LA7ieO3kFKb0FRWk7AUL2wqTNNk0wqo7Lq7b37MV6oMHLQP3+e/QJG6RCjTKWZymdLm8b0cpggB
	M8ZrQ==
X-Received: by 2002:a05:6402:3649:b0:65c:139:2579 with SMTP id 4fb4d7f45d1cf-65c01392959mr4816869a12.15.1771431190726;
        Wed, 18 Feb 2026 08:13:10 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad19bf20sm3406205a12.5.2026.02.18.08.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 08:13:09 -0800 (PST)
Message-ID: <df357921-dd2c-4bc8-aaaf-1ea5259b22b1@gmail.com>
Date: Wed, 18 Feb 2026 16:13:07 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/3] wt-status: reduce reliance on global state
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260217173037.63438-1-shreyanshpaliwalcmsmn@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260217173037.63438-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/02/2026 17:29, Shreyansh Paliwal wrote:
> In wt-status.c code still relies on some global variables, including
> the_repository and the_hash_algo, even in cases where a repository
> instance is already available via struct wt_status or struct repository.
> 
> In patch 1/3, update function parameters and callers to pass struct
> repository where no local repository access was available.

This breaks the build when running "make DEVELOPER=1"

wt-status.c: In function ‘count_stash_entries’:
wt-status.c:1011:51: error: unused parameter ‘r’ [-Werror=unused-parameter]
  1011 | static int count_stash_entries(struct repository *r)
       |                                ~~~~~~~~~~~~~~~~~~~^
wt-status.c: In function ‘read_line_from_git_path’:
wt-status.c:1314:57: error: unused parameter ‘r’ [-Werror=unused-parameter]
  1314 | static char *read_line_from_git_path(struct repository *r, 
const char *filename)
       |                                      ~~~~~~~~~~~~~~~~~~~^
wt-status.c: In function ‘abbrev_oid_in_line’:
wt-status.c:1377:51: error: unused parameter ‘r’ [-Werror=unused-parameter]
  1377 | static void abbrev_oid_in_line(struct repository *r, struct 
strbuf *line)
       |                                ~~~~~~~~~~~~~~~~~~~^

It would be better to use the new argument to replace "the_repository" 
in this patch. There aren't that many so the patch is still a manageable 
size.

> In patch 2/3, replace direct uses of the_repository with repository
> instances already available in local structs.
> 
> In patch 3/3, replace remaining uses of the global the_hash_algo with the
> hash algorithm stored in the respective repository instance.

These both look good, though I think the commit message for the second 
patch could be reflowed to give a more consistent line length.

Thanks

Phillip

> These changes remove uses of the_repository and the_hash_algo from
> wt-status.c and reduce its dependence on global state.
> 
> The 'USE_THE_REPOSITORY_VARIABLE' macro cannot yet be removed, since these
> patches only eliminate some uses of the_repository and the_hash_algo,
> while some global variables are still referenced.
> 
> In particular wt-status.c still relies on the following globals,
> 
> * the_repository, this is still used in functions like worktree_git_path() and
> wt_status_check_bisect/rebase() which are dependant on the worktree API and they
> are being handled in a seperate patch series[1].
> 
> * core_apply_sparse_checkout, this is already being addressed in an
> ongoing patch series [2].
> 
> * comment_line_str and DEFAULT_ABBREV, these both still are used in
> wt-status.c but they dont have any equivalent local instances.
> 
> [1]- https://lore.kernel.org/git/20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com/T/#mf664ad751faaf2eaca138302b1cc9d3856c9fec3
> [2]- https://lore.kernel.org/git/5e56e1cc4172cfff9e917a068184e102aa70bf1d.1769256839.git.belkid98@gmail.com/t/#u
> 
> Shreyansh Paliwal (3):
>    wt-status: pass struct repository through function parameters
>    wt-status: replace uses of the_repository with local repository
>      instances
>    wt-status: use hash_algo from local repository instead of global
>      the_hash_algo
> 
>   wt-status.c | 62 ++++++++++++++++++++++++++---------------------------
>   1 file changed, 31 insertions(+), 31 deletions(-)
> 
> ---
> Changes in v4:
>   - removed the changes regarding worktree_git_path() and
>      wt_status_check_bisect/rebase() as they are better handled seperately.
> 
> Range-diff against v3:
> 1:  960216e45c ! 1:  a3683a5e17 wt-status: pass struct repository through function parameters
>      @@ Commit message
>           do not have access to a local repository instance and rely on the_repository.
> 
>           Add a struct repository *r parameter to these functions, and pass the local
>      -    repository through the callers.
>      -
>      -    get_branch(), wt_status_check_rebase() and wt_status_check_bisect() already
>      -    receive a struct worktree *, which can provide access to the repository.
>      -    However, some callers pass NULL as the worktree like in wt_status_get_state(),
>      -    which would make using wt->repo unsafe and lead to segfault issues.
>      -    Add an explicit struct repository * parameter to these functions as well,
>      -    and pass the repository through the callers.
>      -
>      -    Both wt_status_check_rebase() and  wt_status_check_bisect() are called from
>      -    branch.c and worktree.c,
>      -
>      -    * In branch.c, wt is always non-NULL as the functions are called within an
>      -    interation over worktrees in prepare_checked_out_branches().
>      -    * In worktree.c the functions are called from is_worktree_being_rebased() and
>      -    is_worktree_being_bisected() respectively which are further called from
>      -    builtin/branch.c in reject_rebase_or_bisect_branch() which has a non-NULL
>      -    worktree as it is called inside an iteration over worktrees as well.
>      +    repository through the callers where already they can access a local repository
>      +    instance either directly by struct repository *r or
>      +    by struct wt_state *s (s->repo).
> 
>           Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> 
>      - ## branch.c ##
>      -@@ branch.c: static void prepare_checked_out_branches(void)
>      - 			free(old);
>      - 		}
>      -
>      --		if (wt_status_check_rebase(wt, &state) &&
>      -+		if (wt_status_check_rebase(wt->repo, wt, &state) &&
>      - 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
>      - 		    state.branch) {
>      - 			struct strbuf ref = STRBUF_INIT;
>      -@@ branch.c: static void prepare_checked_out_branches(void)
>      - 		}
>      - 		wt_status_state_free_buffers(&state);
>      -
>      --		if (wt_status_check_bisect(wt, &state) &&
>      -+		if (wt_status_check_bisect(wt->repo, wt, &state) &&
>      - 		    state.bisecting_from) {
>      - 			struct strbuf ref = STRBUF_INIT;
>      - 			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
>      -
>      - ## worktree.c ##
>      -@@ worktree.c: int is_worktree_being_rebased(const struct worktree *wt,
>      - 	int found_rebase;
>      -
>      - 	memset(&state, 0, sizeof(state));
>      --	found_rebase = wt_status_check_rebase(wt, &state) &&
>      -+	found_rebase = wt_status_check_rebase(wt->repo, wt, &state) &&
>      - 		       (state.rebase_in_progress ||
>      - 			state.rebase_interactive_in_progress) &&
>      - 		       state.branch &&
>      -@@ worktree.c: int is_worktree_being_bisected(const struct worktree *wt,
>      - 	int found_bisect;
>      -
>      - 	memset(&state, 0, sizeof(state));
>      --	found_bisect = wt_status_check_bisect(wt, &state) &&
>      -+	found_bisect = wt_status_check_bisect(wt->repo, wt, &state) &&
>      - 		       state.bisecting_from &&
>      - 		       skip_prefix(target, "refs/heads/", &target) &&
>      - 		       !strcmp(state.bisecting_from, target);
>      -
>        ## wt-status.c ##
>       @@ wt-status.c: static int stash_count_refs(const char *refname UNUSED,
>        	return 0;
>      @@ wt-status.c: static void show_am_in_progress(struct wt_status *s,
>        }
> 
>       -static char *read_line_from_git_path(const char *filename)
>      -+static char *read_line_from_git_path(struct repository *r, char *filename)
>      ++static char *read_line_from_git_path(struct repository *r, const char *filename)
>        {
>        	struct strbuf buf = STRBUF_INIT;
>        	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
>      @@ wt-status.c: static void abbrev_oid_in_line(struct strbuf *line)
>        }
> 
>       -static int read_rebase_todolist(const char *fname, struct string_list *lines)
>      -+static int read_rebase_todolist(struct repository *r, char *fname, struct string_list *lines)
>      ++static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
>        {
>        	struct strbuf buf = STRBUF_INIT;
>        	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
>      @@ wt-status.c: static void show_rebase_information(struct wt_status *s,
>        					 &yet_to_do))
>        			status_printf_ln(s, color,
>        				_("git-rebase-todo is missing."));
>      -@@ wt-status.c: static void show_sparse_checkout_in_use(struct wt_status *s,
>      - /*
>      -  * Extract branch information from rebase/bisect
>      -  */
>      --static char *get_branch(const struct worktree *wt, const char *path)
>      -+static char *get_branch(struct repository *r, struct worktree *wt, const char *path)
>      - {
>      - 	struct strbuf sb = STRBUF_INIT;
>      - 	struct object_id oid;
>      -@@ wt-status.c: static void wt_status_get_detached_from(struct repository *r,
>      - 	strbuf_release(&cb.buf);
>      - }
>      -
>      --int wt_status_check_rebase(const struct worktree *wt,
>      --			   struct wt_status_state *state)
>      -+int wt_status_check_rebase(struct repository *r,
>      -+	 			const struct worktree *wt,
>      -+			    struct wt_status_state *state)
>      - {
>      - 	struct stat st;
>      -
>      -@@ wt-status.c: int wt_status_check_rebase(const struct worktree *wt,
>      - 				state->am_empty_patch = 1;
>      - 		} else {
>      - 			state->rebase_in_progress = 1;
>      --			state->branch = get_branch(wt, "rebase-apply/head-name");
>      --			state->onto = get_branch(wt, "rebase-apply/onto");
>      -+			state->branch = get_branch(r, wt, "rebase-apply/head-name");
>      -+			state->onto = get_branch(r, wt, "rebase-apply/onto");
>      - 		}
>      - 	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
>      - 		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
>      - 			state->rebase_interactive_in_progress = 1;
>      - 		else
>      - 			state->rebase_in_progress = 1;
>      --		state->branch = get_branch(wt, "rebase-merge/head-name");
>      --		state->onto = get_branch(wt, "rebase-merge/onto");
>      -+		state->branch = get_branch(r, wt, "rebase-merge/head-name");
>      -+		state->onto = get_branch(r, wt, "rebase-merge/onto");
>      - 	} else
>      - 		return 0;
>      - 	return 1;
>      - }
>      -
>      --int wt_status_check_bisect(const struct worktree *wt,
>      -+int wt_status_check_bisect(struct repository *r,
>      -+			   struct worktree *wt,
>      - 			   struct wt_status_state *state)
>      - {
>      - 	struct stat st;
>      -
>      - 	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
>      - 		state->bisect_in_progress = 1;
>      --		state->bisecting_from = get_branch(wt, "BISECT_START");
>      -+		state->bisecting_from = get_branch(r, wt, "BISECT_START");
>      - 		return 1;
>      - 	}
>      - 	return 0;
>      -@@ wt-status.c: void wt_status_get_state(struct repository *r,
>      - 	enum replay_action action;
>      -
>      - 	if (!stat(git_path_merge_head(r), &st)) {
>      --		wt_status_check_rebase(NULL, state);
>      -+		wt_status_check_rebase(r, NULL, state);
>      - 		state->merge_in_progress = 1;
>      --	} else if (wt_status_check_rebase(NULL, state)) {
>      -+	} else if (wt_status_check_rebase(r, NULL, state)) {
>      - 		;		/* all set */
>      - 	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
>      - 		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
>      - 		state->cherry_pick_in_progress = 1;
>      - 		oidcpy(&state->cherry_pick_head_oid, &oid);
>      - 	}
>      --	wt_status_check_bisect(NULL, state);
>      -+	wt_status_check_bisect(r, NULL, state);
>      - 	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
>      - 	    !repo_get_oid(r, "REVERT_HEAD", &oid)) {
>      - 		state->revert_in_progress = 1;
>       @@ wt-status.c: static void wt_porcelain_v2_print_tracking(struct wt_status *s)
>         */
>        static void wt_porcelain_v2_print_stash(struct wt_status *s)
>      @@ wt-status.c: static void wt_porcelain_v2_print_tracking(struct wt_status *s)
>        	char eol = s->null_termination ? '\0' : '\n';
> 
>        	if (stash_count > 0)
>      -
>      - ## wt-status.h ##
>      -@@ wt-status.h: void wt_status_state_free_buffers(struct wt_status_state *s);
>      - void wt_status_get_state(struct repository *repo,
>      - 			 struct wt_status_state *state,
>      - 			 int get_detached_from);
>      --int wt_status_check_rebase(const struct worktree *wt,
>      -+int wt_status_check_rebase(struct repository *r,
>      -+			   struct worktree *wt,
>      - 			   struct wt_status_state *state);
>      --int wt_status_check_bisect(const struct worktree *wt,
>      -+int wt_status_check_bisect(struct repository *r,
>      -+			   struct worktree *wt,
>      - 			   struct wt_status_state *state);
>      -
>      - __attribute__((format (printf, 3, 4)))
> 2:  906e682cd7 ! 2:  f3b4c3e972 wt-status: replace uses of the_repository with local repository instances
>      @@ Commit message
>           struct repository *r.
> 
>           Replace these uses of the_repository with the repository available
>      -    in the local context (eg. s->repo or r).
>      +    in the local context (i.e. s->repo or r).
> 
>           The replacements of all the_repository with s->repo are mostly
>           to cases where a repository instance is already available via
>      @@ wt-status.c: static void wt_longstatus_print_verbose(struct wt_status *s)
> 
>        	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
>       @@ wt-status.c: static void show_am_in_progress(struct wt_status *s,
>      - static char *read_line_from_git_path(struct repository *r, char *filename)
>      + static char *read_line_from_git_path(struct repository *r, const char *filename)
>        {
>        	struct strbuf buf = STRBUF_INIT;
>       -	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
>      @@ wt-status.c: static void abbrev_oid_in_line(struct repository *r, struct strbuf
>        		strbuf_addf(line, "%s ", split.items[0].string);
>        		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
>       @@ wt-status.c: static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
>      - static int read_rebase_todolist(struct repository *r, char *fname, struct string_list *lines)
>      + static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
>        {
>        	struct strbuf buf = STRBUF_INIT;
>       -	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
>      @@ wt-status.c: static void abbrev_oid_in_line(struct repository *r, struct strbuf
>        	int ret;
> 
>        	if (!f) {
>      -@@ wt-status.c: static int read_rebase_todolist(struct repository *r, char *fname, struct string
>      +@@ wt-status.c: static int read_rebase_todolist(struct repository *r, const char *fname, struct
>        			goto out;
>        		}
>        		die_errno("Could not open file %s for reading",
>      @@ wt-status.c: static void show_revert_in_progress(struct wt_status *s,
>        						DEFAULT_ABBREV));
>        	if (s->hints) {
>        		if (has_unmerged(s))
>      -@@ wt-status.c: static char *get_branch(struct repository *r, struct worktree *wt, const char *p
>      - 	struct object_id oid;
>      - 	const char *branch_name;
>      -
>      --	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
>      -+	if (strbuf_read_file(&sb, worktree_git_path(r, wt, "%s", path), 0) <= 0)
>      - 		goto got_nothing;
>      -
>      - 	while (sb.len && sb.buf[sb.len - 1] == '\n')
>       @@ wt-status.c: static void wt_status_get_detached_from(struct repository *r,
>        	char *ref = NULL;
> 
>      @@ wt-status.c: static void wt_status_get_detached_from(struct repository *r,
>        		strbuf_release(&cb.buf);
>        		return;
>        	}
>      -@@ wt-status.c: int wt_status_check_rebase(struct repository *r,
>      - {
>      - 	struct stat st;
>      -
>      --	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
>      --		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
>      -+	if (!stat(worktree_git_path(r, wt, "rebase-apply"), &st)) {
>      -+		if (!stat(worktree_git_path(r, wt, "rebase-apply/applying"), &st)) {
>      - 			state->am_in_progress = 1;
>      --			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
>      -+			if (!stat(worktree_git_path(r, wt, "rebase-apply/patch"), &st) && !st.st_size)
>      - 				state->am_empty_patch = 1;
>      - 		} else {
>      - 			state->rebase_in_progress = 1;
>      - 			state->branch = get_branch(r, wt, "rebase-apply/head-name");
>      - 			state->onto = get_branch(r, wt, "rebase-apply/onto");
>      - 		}
>      --	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
>      --		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
>      -+	} else if (!stat(worktree_git_path(r, wt, "rebase-merge"), &st)) {
>      -+		if (!stat(worktree_git_path(r, wt, "rebase-merge/interactive"), &st))
>      - 			state->rebase_interactive_in_progress = 1;
>      - 		else
>      - 			state->rebase_in_progress = 1;
>      -@@ wt-status.c: int wt_status_check_bisect(struct repository *r,
>      - {
>      - 	struct stat st;
>      -
>      --	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
>      -+	if (!stat(worktree_git_path(r, wt, "BISECT_LOG"), &st)) {
>      - 		state->bisect_in_progress = 1;
>      - 		state->bisecting_from = get_branch(r, wt, "BISECT_START");
>      - 		return 1;
>       @@ wt-status.c: static void wt_shortstatus_print_tracking(struct wt_status *s)
>        		upstream_is_gone = 1;
>        	}
> 3:  9c0a1d82ad = 3:  7efaf6b3fb wt-status: use hash_algo from local repository instead of global the_hash_algo
> --
> 2.53.0
> 
> 

