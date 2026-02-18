Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAE199230
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442633; cv=none; b=T9NifvUxXuZzSJCPvmvzYKbPaEuAi6TqEPM3uQ7jI5nxaBuIL1O7fQdLnSaUvlxlumqhsOzVTINuzfy9Suw+6pBHquNFm96H9iwrDb5JlDjtGxPHYxTSw09D8lqw3ooSd9FvgloeFXT8w4xbVwVuU9dR6OaZcGru7pN2Sb30vBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442633; c=relaxed/simple;
	bh=/+P6QKtiJ0ErhRHy5aCeNYZbvVJm/b6zdozqsJ3kJ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqkVzmLPwJQKrVoi5oKCXQc3saK0KHAdOA7eMG/gDMtv1Q3MqCMoRel5JtWj6xzshcjRG1EauFIwPLtQleDTT9QGCS9dm3rxGgXqM4vjh+wZttO5mCSt8ckJwsWlAzdc3V5DlwOKUhU2080tcGMtUdc0j47wQZEx42zTQzkDHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxxJftkf; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxxJftkf"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45f04f1348cso109489b6e.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771442631; x=1772047431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYSVb3ErQ/h0eDc5P7GpHJnNQvHGuc91bmRHYRpdpa4=;
        b=TxxJftkfl0t8ij+W/8T5UZtTIU5QU6DTc53H6guYzqON744p3PtW4KWXmhe+S6p2nK
         0lcw2mV9QDSwO7YwCAchSfSrgQYkZs3WnJ06Ee+x5m/+yHHOS/rTA0CG8R1OM3MJjX0w
         E4j92qoC0t/srD/f0OuiUCKC0FBN1V2WSJpIWmNjbWCN7IaE7QjMeeHG1xRRvkaWw1k9
         1/IsmDe/T3KAIQrL2ElrnMNplPnk5UQT1B7rFvWcKXVI6urXoLX4ebxfvLmbqOQlWqU2
         JpdtMKWddCpVE0/wKCCAXPHGuGB/NR9b2LS7A9TCRdoZvq0yV1Vyj8QChznWbmooxxEr
         3Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771442631; x=1772047431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYSVb3ErQ/h0eDc5P7GpHJnNQvHGuc91bmRHYRpdpa4=;
        b=afqM2q9tphhS21YQGsj73OcouRQ+ldB7OKnwP1rOsbDH1ummtqTtnQ0atlD0K9/kG4
         oS7qdUzfeTdWnSIzKHjXfoUz3BpYSoWI46+Jo+d9+RtMGc7T8ljAQeN4rwF5hychv1gg
         057ZZ0fk7TfhzehF4F8y82VuZQEvNFVRyQRC5S9M4QIft0KMlfuPT3Fw0gyatHna1FGm
         BU4w8nBrfJhvzG1HqYpR/s+/3S3k2gkE93dBMTo7TrK3ue+ZUjHb9N1VED3H0BEkfP6v
         3QmxOqg53Niyrqkrd8xWTWOI2I06irHdIIkAPdDX3PDJUOUyIw1CYtUuIx2oA6XbvL7a
         SjMw==
X-Gm-Message-State: AOJu0Yx4uiu/62RHFAzQIzwiMtuDdL0uEfhHirovkxzzPN7e29h7ywk2
	osKhpox1JLjn4gaDKPOajcHvej/Ye/Ka8X/GIrdkwPpKuWDjqpIDWpKjPPAOZw==
X-Gm-Gg: AZuq6aKzBENbro9JjrrMfS7BHMQfIDapt6y1EhfK5TVVwAPZ1Njh4+y8UFyGfymFBHn
	p0TSoJoTjR7mz4L+dV6j9E72jXrR9UAT6wTPNYXt0uZ/DAXJgWZdxKSqClF0JeGom/tRnysLfOn
	lV3SbTNfh6PIFgfSE8eEkhdOwjz1oXjxkrtRt4yQJidQw5+ppjK7ZAdD2YiJ0a3XWZqycCGAfYF
	UIHLsX17s8JHkzICpaquWvgs6aTeY3Xk3jVNKwxrxXszsLQyZr2PCnj+ByvpzJ+MDG8gLO5GzKV
	LCvyEySMCy7JMK9OPWmhFUKyRtliOyYutszVwJQb8I8jKuxdtKZyl27A/L2stRI3uEaqhavOMst
	vi1n3n/AIdjDnWs3nHADXOksfWx2Z4u/j/reakIUIbsOWsHZvsGYzLjVBzCiPPJ4IJNRJMAHrl5
	+gByXdO/OAQEL26Ll1pJb8CodjK34=
X-Received: by 2002:a05:6808:6507:b0:455:8400:f078 with SMTP id 5614622812f47-463b3f86dbfmr8661449b6e.25.1771442630633;
        Wed, 18 Feb 2026 11:23:50 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4636ae8f86fsm14830508b6e.3.2026.02.18.11.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 11:23:50 -0800 (PST)
Date: Wed, 18 Feb 2026 13:23:47 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>
Subject: Re: [PATCH 2/3] commit: make `repo_parse_commit_no_graph()` more
 robust
Message-ID: <aZYJyT3QZ2lJrkL-@denethor>
References: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
 <20260216-b4-pks-receive-pack-optimize-shallow-v1-2-e98886daff2b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-b4-pks-receive-pack-optimize-shallow-v1-2-e98886daff2b@pks.im>

On 26/02/16 04:38PM, Patrick Steinhardt wrote:
> In the next commit we will start to parse more commits via the
> commit-graph. This change will lead to a segfault though because we try
> to access the tree of a commit via `repo_get_commit_tree()`, but:
> 
>   - The commit has been parsed via the commit-graph, and thus its
>     `maybe_tree` field is not yet populated.
> 
>   - We cannot use the commit-graph to populate the commit's tree because
>     we're in the process of writing the commit-graph.
> 
> The consequence is that we'll get a `NULL` pointer for the tree in
> `write_graph_chunk_data()`.

IIUC, when a commit has been parsed via the commit graph, if the commit
graph is closed, there is no longer a way for commit object tree to be
read. This results `repo_get_commit_tree()` always returning NULL in
such scenarios.

> In theory we are already mindful of this situation, as we explicitly use
> `repo_parse_commit_no_graph()` to parse the commit without the help of
> the commit-graph. But that doesn't do the trick as the commit is already
> marked as parsed, so the function will not re-populate it. And as the
> commit-graph has been closed, neither will `get_commit_tree_oid()` be
> able to load the tree for us.

And `repo_parse_commit_no_graph()` doesn't work because the commit has
already been marked as parsed.

> It seems like this issue can only be hit under artificial circumstances:
> the error was hit via `git_test_write_commit_graph_or_die()`, which is
> run by git-commit(1) and git-merge(1) in case `GIT_TEST_COMMIT_GRAPH=1`:
> 
>   $ GIT_TEST_COMMIT_GRAPH=1 meson test t7507-commit-verbose \
>       --test-args=-ix -i
>   ...
>   ++ git -c commit.verbose=true commit --amend
>   hint: Waiting for your editor to close the file...
>   ./test-lib.sh: line 1012: 55895 Segmentation fault         (core dumped) git -c commit.verbose=true commit --amend
> 
> To the best of my knowledge, this is the only case where we end up
> writing a commit-graph in the same process that might have already
> consulted the commit-graph to look up arbitrary objects. But regardless
> of that, this feels like a bigger accident that is just waiting to
> happen.

So I assume we end up closing the commit-graph when writing a new one.
If we need to read the trees of commits parsed via commit-graph, this
will trigger a segfault since the commit tree will always be NULL.

> Make the code more robust by extending `repo_parse_commit_no_graph()` to
> unparse a commit first in case we detect it's coming from a graph. This
> ensures that we will re-read the object without it, and thus we will
> populate `maybe_tree` properly.

Hmm, I wonder if this is conceptually the correct place to address this
problem. Naively, I would expect `repo_get_commit_tree()` to always be
capable of providing the commit tree. I guess the problem though is that
this would require `repo_get_commit_tree()` to detect this scenario and
reparse the object itself. Maybe we could at least have
`repo_get_commit_tree()` BUG() in this scenario though?

> This fix shouldn't have any performance consequences: the function is
> only ever called in the "commit-graph.c" code, and we'll only re-parse
> the commit at most once.
> 
> Add an exclusion to our Coccinelle rules so that it doesn't complain
> about us accessing `maybe_tree` directly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit.h                        | 14 ++++++++++++--
>  contrib/coccinelle/commit.cocci |  2 +-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/commit.h b/commit.h
> index 1635de418b..f2f39e1a89 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -103,16 +103,26 @@ static inline int repo_parse_commit(struct repository *r, struct commit *item)
>  	return repo_parse_commit_gently(r, item, 0);
>  }
>  
> +void unparse_commit(struct repository *r, const struct object_id *oid);
> +
>  static inline int repo_parse_commit_no_graph(struct repository *r,
>  					     struct commit *commit)
>  {
> +	/*
> +	 * When the commit has been parsed but its tree wasn't populated then
> +	 * this is an indicator that it has been parsed via the commit-graph.
> +	 * We cannot read the tree via the commit-graph, as we're explicitly
> +	 * told not to use it. We thus have to first un-parse the object so
> +	 * that we can re-parse it without the graph.
> +	 */
> +	if (commit->object.parsed && !commit->maybe_tree)
> +		unparse_commit(r, &commit->object.oid);

This unparses commits that were read via commit-graph so they can be
reparsed normally. Looks good.

-Justin
