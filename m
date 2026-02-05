Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CB42B74D
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306792; cv=none; b=XMy+noa0i32LHwjXseAR764b6VZJ5yjwIkOcZcj9ZoxVtGnx48mej4239XxjQTyHz6ciyRbGjXsEKcdK5fOwi5nlPpKhhGmjiE1CXZ8qDKrzorgHcQMkCeDBWMXewho4LlQghph/c2EGSltbHYHnUkqxjgyamXdYQ/ufFtGcWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306792; c=relaxed/simple;
	bh=AmJZJ+Nk8JWXfVU+OeFibQqMSp1rB/5ZArYBFf6Yl2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qedodq5ok/TSfr6p28Z+UsUxFZ1hucUz1EIJN4+BBKQJgIEURjm24K3dUS2bxwvnZ8zxtmcHfSNAdslB1zbiGEDPhgEXvearuCPCXNo2T+sF5jc5FhvIQOjjkEEVfzKib4eMlnZKPwZEgjHNOtySFVGcvW5pT3TGQaxPQUpbqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ele+cRgc; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ele+cRgc"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-435903c4040so834222f8f.3
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 07:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770306790; x=1770911590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Aioj2vIeYTW+usOHrTTrBK4Tmju9VTuQrNjbTaOccU=;
        b=ele+cRgcp5qwXLp7XqoGqVD++eD7F6XeM75pB+ijl46rPlIn+f33rC0r9rZaPpSiAJ
         KaYuCErCduIOCiujCigKMJLFRJrsatcWiluyJh/T9uKZcWyG61uCI7Uk5knDqkm1Wyn/
         FvEch9JwEmuwCI2Lo1v0+c4AcBQfbCNaz+DykFbfvUWLiGnVL8KLQ8VTm5zA2rk1fVBG
         deXZs1tOM+Zf/Whba5YpUE7v1gxS9bmT1fiAKNjgsrd2oxU1epae0LaF5Sy8SeqIBH2L
         QlBQCnUTltT9BytKjNHNzxw8q3hehs9RTpSma4gw0hQBjyrRIilYZaA1LfpcbMmA8bA3
         GJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306790; x=1770911590;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Aioj2vIeYTW+usOHrTTrBK4Tmju9VTuQrNjbTaOccU=;
        b=tVI8p10iabtcjdJYk9KitPbif/y+w9Wo5H15C/+USnrvqD1GNAEil+Ibw1MuQ0Pvni
         ovJvwLZLsxjVOnonBtKGiZ5o8zvTRg8ua9OjWXJ8iY+BopWh2OAwfJml5DwLRPYnIFzN
         +xTi2p8ygMITtW6Ndxm6R3ptKtBb1xCQWY48BqwHGvUb/0RUx2zY4AUK2wlusbyee2RJ
         jWCDWwwUBW7HVcQl+iZHBGsMDozaqLkfiNHOh+IuriCad8U0U+BAQCaflXNp1FnJEEQX
         KisRVLUb5HNPXJidsBl6aEzEbG+SKoE3b+HCwLv9O1nN0/NLboKJ/4zttt7pfzYWLxyh
         Ol4g==
X-Forwarded-Encrypted: i=1; AJvYcCXmQpuwKZPE5zL6YkFLEN9bA1vAoI4cBBOHp4PkeeSr4FOwyCKs1y8srSN+As7bBH5yBGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUti73ZMy/r3XuflOARGqC1TMCoS8wmt82siZrLIyGatmBgRCV
	2u8a7hTMjlbZ8ISoFuclkO91RHDY8m5I+FTevyEGDoNZRGmqkdcMB+Cs
X-Gm-Gg: AZuq6aK4AM4iMASoXb7r7ix26j6gR0mYNhJ3cjc2rCW98+R85lyGWSGMHLOyNQ6E7FN
	96UUOusuF7jxUshVBMTskVUTY9Dp31qv88SKCCAVJ6zUSkBOvsba7JNj/csmX5k7FHfh3bHcIbO
	OU83HXX02qFWRxfZbBCy0JewP0hV1Kpp4Z0B21MyJhAeq7PqGrBMU4ILWVvq68JCBUFM72uXD09
	jI5j79LS92118n1qhDOaXbz0P4A/NWosLX7kir1QN8jfJPzC0i/GY8n4JHDQFX/McXQB8uCPrJ/
	gSa5u9mXCrKYqka4HadrZhxkzTIPuzstnD3vNGuXSjqMXUosonU6YDGYN7smzf+0OiAUAFl53yP
	GDiHvM5JKge6jL5x+FSJv7EZ653+Y6rCjVfoxIoAP+AO57GTbmWebeYGQa3N0+XsdiW7SspXWa7
	42TNNy7fXoD7yhNV/U/w5aYr7738N5NjoLkTBHzh07oQE8y3ovNqhNIOqBGNKPz0LokU1LvGka8
	kB0
X-Received: by 2002:a05:6000:2483:b0:435:a2f8:1536 with SMTP id ffacd0b85a97d-4361805be90mr9860529f8f.43.1770306789943;
        Thu, 05 Feb 2026 07:53:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640f2sm13561480f8f.39.2026.02.05.07.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:53:09 -0800 (PST)
Message-ID: <16274976-17c0-499b-8225-de2d783ed343@gmail.com>
Date: Thu, 5 Feb 2026 15:53:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH V2 0/3] wt-status: reduce reliance on global state
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com
References: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260205102815.134373-1-shreyanshpaliwalcmsmn@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260205102815.134373-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2026 10:27, Shreyansh Paliwal wrote:
> I forgot to include the changes in the version.
> 
> Changes in V2,
> - Explained the changes and the reason more elaborately in commit message.
> - Passed struct repository instead of accessing struct worktree in
>     wt_status_check_rebase() and shifted this change to patch 2/3 instead of 1/3.
> - Added information about leftover globals in the cover.

As well as describing the changes it is very helpful to include a range-diff to
show what's changed - see the --range-diff option to "git format-patch". I've
pasted the range-diff between V1 and V2 below

Thanks

Phillip

1:  1bf5449c7a8 ! 1:  7285c64e672 wt-status: replace uses of the_repository with local repository instances
     @@ Metadata
       ## Commit message ##
          wt-status: replace uses of the_repository with local repository instances
      
     -    Many instances of the_repository are used in wt-status.c even when a
     -    local repository is already available via struct wt_status or struct
     -    worktree.
     -
     -    Replace direct uses of the global the_repository with the repository
     -    instance carried by the local structs (e.g. s->repo, wt->repo).
     -
     -    This helps reduce reliance on global repository state.
     +    wt-status.c uses the global the_repository in several places even when
     +    a repository instance is already available via struct wt_status or
     +    struct worktree.
     +
     +    Replace these direct uses of the_repository with the repository carried
     +    by the local structs (e.g. s->repo, wt->repo).
     +
     +    The replacements of all the_repository with s->repo are mostly
     +    to cases where a repository instance is already available via
     +    struct wt_status. All functions operating on struct wt_status *s
     +    are only used after s is initialized by wt_status_prepare(),
     +    which sets s->repo from the repository provided by the caller.
     +    As a result, s->repo is guaranteed to be available and consistent
     +    whenever these functions are invoked.
     +
     +    This reduces reliance on global state and keeps wt-status consistent,
     +    though many functions operating on struct wt_status *s
     +    are called via commit.c and it still relies on the_repository,
     +    but within wt-status.c the local repository pointer
     +    refers to the same underlying repository object.
      
          Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
      
     @@ wt-status.c: void wt_status_prepare(struct repository *r, struct wt_status *s)
       	s->use_color = GIT_COLOR_UNKNOWN;
       	s->relative_paths = 1;
      -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
     -+	s->branch = refs_resolve_refdup(get_main_ref_store(s->repo),
     ++	s->branch = refs_resolve_refdup(get_main_ref_store(r),
       					"HEAD", 0, NULL, NULL);
       	s->reference = "HEAD";
       	s->fp = stdout;
     @@ wt-status.c: static void wt_status_get_detached_from(struct repository *r,
       		strbuf_release(&cb.buf);
       		return;
       	}
     -@@ wt-status.c: int wt_status_check_rebase(const struct worktree *wt,
     - {
     - 	struct stat st;
     -
     --	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
     --		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
     -+	if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply"), &st)) {
     -+		if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/applying"), &st)) {
     - 			state->am_in_progress = 1;
     --			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
     -+			if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/patch"), &st) && !st.st_size)
     - 				state->am_empty_patch = 1;
     - 		} else {
     - 			state->rebase_in_progress = 1;
     - 			state->branch = get_branch(wt, "rebase-apply/head-name");
     - 			state->onto = get_branch(wt, "rebase-apply/onto");
     - 		}
     --	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
     --		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
     -+	} else if (!stat(worktree_git_path(wt->repo, wt, "rebase-merge"), &st)) {
     -+		if (!stat(worktree_git_path(wt->repo, wt, "rebase-merge/interactive"), &st))
     - 			state->rebase_interactive_in_progress = 1;
     - 		else
     - 			state->rebase_in_progress = 1;
      @@ wt-status.c: int wt_status_check_bisect(const struct worktree *wt,
       {
       	struct stat st;
2:  8a0b489c3be ! 2:  0a04c957f12 wt-status: pass struct repository and wt_status through function parameters
     @@ Commit message
      
          Some functions in wt-status.c relied on the_repository because no
          repository instance was available in their local scope.
     -
     -    Update these functions to accept struct repository or struct
     -    wt_status as parameters, and adjust callers accordingly.
     -
     -    Replace remaining uses of the_repository in these functions with the
     +    There is also a specific case in wt_status_check_rebase() where the
     +    worktree can be NULL, so accessing wt->repo may lead to a segfault.
     +
     +    Update these functions to accept a struct repository or struct
     +    wt_status parameter, and adjust callers accordingly. Replace the
     +    remaining uses of the_repository in these functions with the
          passed-in repository instance.
      
     -    This completely removes the use of the_repository global variable
     -    in wt-status.c.
     +    This removes the use of the_repository global variable from
     +    wt-status.c completely.
      
          Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
      
     + ## branch.c ##
     +@@ branch.c: static void prepare_checked_out_branches(void)
     + 			free(old);
     + 		}
     +
     +-		if (wt_status_check_rebase(wt, &state) &&
     ++		if (wt_status_check_rebase(wt->repo, wt, &state) &&
     + 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
     + 		    state.branch) {
     + 			struct strbuf ref = STRBUF_INIT;
     +
     + ## worktree.c ##
     +@@ worktree.c: int is_worktree_being_rebased(const struct worktree *wt,
     + 	int found_rebase;
     +
     + 	memset(&state, 0, sizeof(state));
     +-	found_rebase = wt_status_check_rebase(wt, &state) &&
     ++	found_rebase = wt_status_check_rebase(wt->repo, wt, &state) &&
     + 		       (state.rebase_in_progress ||
     + 			state.rebase_interactive_in_progress) &&
     + 		       state.branch &&
     +
       ## wt-status.c ##
      @@ wt-status.c: static int stash_count_refs(const char *refname UNUSED,
       	return 0;
     @@ wt-status.c: static void show_rebase_information(struct wt_status *s,
       					 &yet_to_do))
       			status_printf_ln(s, color,
       				_("git-rebase-todo is missing."));
     +@@ wt-status.c: static void wt_status_get_detached_from(struct repository *r,
     + 	strbuf_release(&cb.buf);
     + }
     +
     +-int wt_status_check_rebase(const struct worktree *wt,
     +-			   struct wt_status_state *state)
     ++int wt_status_check_rebase(struct repository *r,
     ++			 const struct worktree *wt,
     ++			 struct wt_status_state *state)
     + {
     + 	struct stat st;
     +
     +-	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
     +-		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
     ++	if (!stat(worktree_git_path(r, wt, "rebase-apply"), &st)) {
     ++		if (!stat(worktree_git_path(r, wt, "rebase-apply/applying"), &st)) {
     + 			state->am_in_progress = 1;
     +-			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
     ++			if (!stat(worktree_git_path(r, wt, "rebase-apply/patch"), &st) && !st.st_size)
     + 				state->am_empty_patch = 1;
     + 		} else {
     + 			state->rebase_in_progress = 1;
     + 			state->branch = get_branch(wt, "rebase-apply/head-name");
     + 			state->onto = get_branch(wt, "rebase-apply/onto");
     + 		}
     +-	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
     +-		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
     ++	} else if (!stat(worktree_git_path(r, wt, "rebase-merge"), &st)) {
     ++		if (!stat(worktree_git_path(r, wt, "rebase-merge/interactive"), &st))
     + 			state->rebase_interactive_in_progress = 1;
     + 		else
     + 			state->rebase_in_progress = 1;
     +@@ wt-status.c: void wt_status_get_state(struct repository *r,
     + 	enum replay_action action;
     +
     + 	if (!stat(git_path_merge_head(r), &st)) {
     +-		wt_status_check_rebase(NULL, state);
     ++		wt_status_check_rebase(r, NULL, state);
     + 		state->merge_in_progress = 1;
     +-	} else if (wt_status_check_rebase(NULL, state)) {
     ++	} else if (wt_status_check_rebase(r, NULL, state)) {
     + 		;		/* all set */
     + 	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
     + 		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
      @@ wt-status.c: static void wt_porcelain_v2_print_tracking(struct wt_status *s)
        */
       static void wt_porcelain_v2_print_stash(struct wt_status *s)
     @@ wt-status.c: static void wt_porcelain_v2_print_tracking(struct wt_status *s)
       	char eol = s->null_termination ? '\0' : '\n';
       
       	if (stash_count > 0)
     +
     + ## wt-status.h ##
     +@@ wt-status.h: void wt_status_state_free_buffers(struct wt_status_state *s);
     + void wt_status_get_state(struct repository *repo,
     + 			 struct wt_status_state *state,
     + 			 int get_detached_from);
     +-int wt_status_check_rebase(const struct worktree *wt,
     +-			   struct wt_status_state *state);
     ++int wt_status_check_rebase(struct repository *r,
     ++			 const struct worktree *wt,
     ++			 struct wt_status_state *state);
     + int wt_status_check_bisect(const struct worktree *wt,
     + 			   struct wt_status_state *state);
     +
3:  e2cf365bad5 ! 3:  74b28d95299 wt-status: use hash_algo from local repository instead of global the_hash_algo
     @@ Metadata
       ## Commit message ##
          wt-status: use hash_algo from local repository instead of global the_hash_algo
      
     -    wt-status.c uses the global the_hash_algo even though a repository
     -    instance is already available via struct repository *r.
     +    wt-status.c still uses the global the_hash_algo even though a repository
     +    instance is already available via struct wt_status.
      
          Replace uses of the_hash_algo with the hash algorithm stored in the
     -    associated repository (r->hash_algo).
     +    associated repository (s->repo->hash_algo or r->hash_algo).
      
          This removes another dependency on global state and keeps wt-status
          consistent with local repository usage.


