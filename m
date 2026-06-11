Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20983B27DF
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190560; cv=none; b=Esx3CCk4Wf31VueLzA4q5/wPpTpMuhmyy8wTkwlGEsSXIQA9dQ5kn8FjHHLtZavoOZKRP7mX1ekX1MIA91AXtXhvfZoAkOl0Ee+V1F7VlKY6NTGXmf0ZuA5BOZWAnv2WN1XPJnJ4AyokpAbi3dRvj/hAX9D8XFk26JUMhsjLDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190560; c=relaxed/simple;
	bh=O+eekLzFyK7EDQu4Fb1/CWyvFLFkEwwHdSJMXi08L6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSYlbDCZl4P+N7TYPSWLmhR6KUTp2d4pf3agbYdQQTU3DuI5AKAghFCAb94oJQpBTpG1031KiQcNF9N3YnKDfI7sLk93Gy3R6TziiIyWk6VDRUQUkR2wh9r1tgrrFqcAl9VL8V1ujl+Ys2DoAPsO6gTTTTSTwCaNW5eUjVFKCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghwxL1VN; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghwxL1VN"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59eb501bcf0so2735874e0c.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781190557; x=1781795357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlxgL4JfxbRwsBP1Otqw8jA/m/by+bxwGQR4r8edwsk=;
        b=ghwxL1VNuZMMM7x4BLqkuRqGpJBAvPwGE0SVQnb3ujpZfbiRy7TEAkm9YCiMy1ggOw
         zcAuGoTCj4OeadEtq2Qq0ff8mAeWIztaR7PaU4aFSkqwmA+NDEwJlOWR+qfmYpFFiCjT
         JTvOLyWMPPGTL7j0NyfPjjTCX2LXqbnK18F2bXXmstV5vX4ugP5B2yU+qseo7VZJLqeV
         Iu2kBf0vQx8ebJEhFEIEc8c2qvtpUneF/6R5D3WyPXm8KEfpG1Qd/1MaDhWLCm6+GROF
         4hws4GBBh9gQdIU5+IZt0gppLL+FV39B0LPLK+hRvOYIovnT0K04v5b2otMykh3iPTWj
         Sx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190557; x=1781795357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlxgL4JfxbRwsBP1Otqw8jA/m/by+bxwGQR4r8edwsk=;
        b=jrzyHNmIxOKuV12kp0fqx+g/r5OUgawLzz7EIUiZNI+Qw01VHXbAJKJF9n31n9pFir
         kx2BoYauzo9K+sEnuyFElzyoZJ/5ses6LEusoCYajryVbu6pNfYuWgW+TjWPGUvtLLmq
         0PIyGjo59Isrtoo5L7+a0u+jmOj6cWAwIRS9kgm3rIB7HVtWEfK7BSYvxh9gY6/kM7NN
         u2b3McKNr5mLuBcHK7wtedag2tPqPxiATGJXmIE2Kc1KOlZVklF+PLYVhw5bIMjOSIGz
         pXg6LHZcE+Zpn8hixkuuxprTe2NcEnFWqhLQ+CFl9HrY88sIXWpj5doGsvEFzlXA6O2Y
         P06w==
X-Gm-Message-State: AOJu0YyDx5Ik8OaSngl5ikJ46ZlBty9x9pPbpWy7joi+ISpOvbK3du+k
	wrwlrpRIxadXx4+LRp8Zkw3WvWgOy+iTsVTINYFtJnZsAmz7m+w2mSTWss6PYA==
X-Gm-Gg: Acq92OFIcy9MjrxL9oeVCR0630CTNGFAYDlKuxP62/9HRkpl4Ehq3EoU8w6UUDkB5sz
	HNAcBidEt3i5V/8SXa0BLT7Fvxcc9Z11u+BCeGAEvb62q5srJEHt/klGPN/UlDkfdkmf6Bw2uih
	xRm//O1qzqYNySNlPYF291QzDvMiyF2gG76sL/aJUbJQY2KqNjrr2so6yykwuf3df3Ym9Cy0Ovs
	p6H4r7sCzFljULpkAtsHqKjLuT2F/ljSqXIC0F1V11ICgZ9/qA70XQ01ArjGKFLdZ+5rWyNzOoi
	HxGw0zYW83qgLWqHu3EaYlYdk2kwudLWNxY8lz6vO+Cw2AJRVzpZy5tVqIV6pHNg4XuWPjCE0IB
	kVyKIwOgfijkVSw5v3gg8PowjTB6sEqq8jpNiEcu+twdkmvdRWeLLuxslh4jdvEe/iAYHQZ0kjT
	u5wBgnN+7BESzAg6U2e7B4m8CzfEY=
X-Received: by 2002:a05:6122:208a:b0:5a2:4391:1730 with SMTP id 71dfb90a1353d-5baff4f7de1mr1247444e0c.7.1781190557363;
        Thu, 11 Jun 2026 08:09:17 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb06a93bf9sm1658571e0c.3.2026.06.11.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:09:16 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:09:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] replay: refactor enum replay_mode into a bool
Message-ID: <airORumUxyTsN7Bz@denethor>
References: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
 <20260610-toon-git-replay-drop-merges-v2-1-5714a71c6d83@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-toon-git-replay-drop-merges-v2-1-5714a71c6d83@iotcl.com>

On 26/06/10 04:49PM, Toon Claes wrote:
> In 2760ee4983 (replay: add --revert mode to reverse commit changes,
> 2026-03-26) the enum `replay_mode` was introduced. This has two possible
> values:
> 
>  - The value `REPLAY_MODE_REVERT` is used when option `--revert` is
>    passed to git-replay(1). When using this value the commits are
>    processed in reverse order and the inverse of the changes are
>    applied.
> 
>  - The value `REPLAY_MODE_PICK` is used when either option `--onto` or
>    `--advance` is used. In both cases the commits are processed in
>    normal order, and the changes are applied as-is.
> 
> Since there are only two possible values of this enum, simplify the code
> by converting the enum into a bool. This avoids adding code paths that
> check for invalid values of the enum, and shortens code where the value
> is checked with a ternary operator.

Naive question: Do we expect there to only be two replay modes in the
forseeable future? I suppose if other modes were added in the future
this change would essentially be reverted.

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  replay.c | 59 +++++++++++++++++++++++++----------------------------------
>  1 file changed, 25 insertions(+), 34 deletions(-)
> 
> diff --git a/replay.c b/replay.c
> index 4ef8abb607..1f8e5b083b 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -18,11 +18,6 @@
>   */
>  #define the_repository DO_NOT_USE_THE_REPOSITORY
>  
> -enum replay_mode {
> -	REPLAY_MODE_PICK,
> -	REPLAY_MODE_REVERT,
> -};
> -
>  static const char *short_commit_name(struct repository *repo,
>  				     struct commit *commit)
>  {
> @@ -81,7 +76,7 @@ static struct commit *create_commit(struct repository *repo,
>  				    struct tree *tree,
>  				    struct commit *based_on,
>  				    struct commit *parent,
> -				    enum replay_mode mode)
> +				    bool reverse)
>  {
>  	struct object_id ret;
>  	struct object *obj = NULL;
> @@ -98,15 +93,13 @@ static struct commit *create_commit(struct repository *repo,
>  
>  	commit_list_insert(parent, &parents);
>  	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
> -	if (mode == REPLAY_MODE_REVERT) {
> +	if (reverse) {
>  		generate_revert_message(&msg, based_on, repo);
>  		/* For revert, use current user as author (NULL = use default) */
> -	} else if (mode == REPLAY_MODE_PICK) {
> +	} else {
>  		find_commit_subject(message, &orig_message);
>  		strbuf_addstr(&msg, orig_message);
>  		author = get_author(message);
> -	} else {
> -		BUG("unexpected replay mode %d", mode);
>  	}
>  	reset_ident_date();
>  	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
> @@ -269,7 +262,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  					  struct commit *onto,
>  					  struct merge_options *merge_opt,
>  					  struct merge_result *result,
> -					  enum replay_mode mode,
> +					  bool reverse,
>  					  enum replay_empty_commit_action empty)
>  {
>  	struct commit *base, *replayed_base;
> @@ -287,7 +280,21 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
>  	pickme_tree = repo_get_commit_tree(repo, pickme);
>  
> -	if (mode == REPLAY_MODE_PICK) {
> +	if (reverse) {
> +		/* Revert: swap base and pickme to reverse the diff */
> +		const char *pickme_name = short_commit_name(repo, pickme);
> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
> +		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
> +		merge_opt->ancestor = pickme_name;
> +
> +		merge_incore_nonrecursive(merge_opt,
> +					  pickme_tree,
> +					  replayed_base_tree,
> +					  base_tree,
> +					  result);
> +
> +		free((char *)merge_opt->branch2);
> +	} else {
>  		/* Cherry-pick: normal order */
>  		merge_opt->branch1 = short_commit_name(repo, replayed_base);
>  		merge_opt->branch2 = short_commit_name(repo, pickme);
> @@ -303,22 +310,6 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  					  result);
>  
>  		free((char *)merge_opt->ancestor);
> -	} else if (mode == REPLAY_MODE_REVERT) {
> -		/* Revert: swap base and pickme to reverse the diff */
> -		const char *pickme_name = short_commit_name(repo, pickme);
> -		merge_opt->branch1 = short_commit_name(repo, replayed_base);
> -		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
> -		merge_opt->ancestor = pickme_name;
> -
> -		merge_incore_nonrecursive(merge_opt,
> -					  pickme_tree,
> -					  replayed_base_tree,
> -					  base_tree,
> -					  result);
> -
> -		free((char *)merge_opt->branch2);
> -	} else {
> -		BUG("unexpected replay mode %d", mode);
>  	}
>  	merge_opt->ancestor = NULL;
>  	merge_opt->branch2 = NULL;
> @@ -341,7 +332,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
>  		}
>  	}
>  
> -	return create_commit(repo, result->tree, pickme, replayed_base, mode);
> +	return create_commit(repo, result->tree, pickme, replayed_base, reverse);
>  }
>  
>  void replay_result_release(struct replay_result *result)
> @@ -381,13 +372,13 @@ int replay_revisions(struct rev_info *revs,
>  	char *revert;
>  	const char *ref;
>  	struct object_id old_oid;
> -	enum replay_mode mode = REPLAY_MODE_PICK;
> +	bool reverse;
>  	int ret;
>  
>  	advance = xstrdup_or_null(opts->advance);
>  	revert = xstrdup_or_null(opts->revert);
> -	if (revert)
> -		mode = REPLAY_MODE_REVERT;
> +	reverse = !!revert;
> +
>  	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
>  			   &detached_head, &advance, &revert, &onto, &update_refs);
>  
> @@ -430,8 +421,8 @@ int replay_revisions(struct rev_info *revs,
>  			die(_("replaying merge commits is not supported yet!"));
>  
>  		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
> -						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
> -						  &merge_opt, &result, mode, opts->empty);
> +						  reverse ? last_commit : onto,
> +						  &merge_opt, &result, reverse, opts->empty);
>  		if (!last_commit)
>  			break;

The patch itself looks trivially correct.

-Justin
