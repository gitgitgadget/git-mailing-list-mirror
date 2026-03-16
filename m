Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D8346FAE
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646719; cv=none; b=TRHpTYc5aUGYPanGu3Umd5zziJ5mhNApVzXxKAkT8yl7YeBN8jXzcr3kbdNLt8O10/hUM0Bw8ectAndXV6iv1xBTYUrQbXm1sfCzp8xnNNEw/XfkuypL1P1QO9A88X4xRnKV+9Srk6dPp2GQkiz445mdlfyfO0fLUyZrC9MlM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646719; c=relaxed/simple;
	bh=15iyUcQSmQe5hAOvx3a+PmoKZFphhmoPVykF2WgzspQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+DaAAEzOErxV2Q2C13l4KpuwrXrurB5hGxD+fFrIBV69AY6s8WvIyjR69G/8Gr1s/jbQytmkXOl98McVStJFKbs9m1k7Q3P4LClvUY9zTlxRxwrlvw9RsRXr46PMy++rUYs4fH0YdUGI2+VPK5JazoYMKu/VVEsqlxiI2pkyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E2dmaD6e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=weiG5RXu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E2dmaD6e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="weiG5RXu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C0E6EC05B4;
	Mon, 16 Mar 2026 03:38:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 03:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773646717; x=1773733117; bh=emfJmCRtks
	gW6aQ4nu2bCp35qK8J4ZJf0u0LDfVKJxs=; b=E2dmaD6eAMtAapxYgthojAl3Dc
	YuRUIPz8JWRhcWx9M909kmKUm/zyxqzAWOtyYnHsC7AodGw0NI5+ipZ1vBHpzd2R
	5MCzi++NAq7V+njVhIZvDBYjPFQmS+jjlr+3+JjdBeX74PinO0coVlhyeKYjX40D
	H468sMxvyLImKdd+E6iw1U6jC3a42mpr9pV6cmx/0+zoAvSQyYv5RkpD1cAZVKk1
	+YlgxzHdGWhnxbh1aeuWBJQxnLUEFoFA/XNJ3L99PUTDg4b5czgmBuewzSTxc7JR
	OP51ltYY/oHvu3gDVGPyOPWaikBF+BCAT076HXFeo2EEHgmhpYutOEstQt1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773646717; x=1773733117; bh=emfJmCRtksgW6aQ4nu2bCp35qK8J4ZJf0u0
	LDfVKJxs=; b=weiG5RXup5WMCDjuJmk5HJ1y30t3MU1QcvYRb6sE7G9brfecD5P
	d/8Fz/q1cHb6R+/S3KWYb3PvAQQLuR5MmoJQ9oqmQE6tizq1pwiuWpvmJaYwbbf9
	ISwYiLJLUStIH/LQTdyeiKKl38iuHYldJtuPa6UumcnzrvSlUy9YPGy1fNV2HToH
	kXVuJlqIY6UR6l2zRKQz1s4ucspYm5jhYiHQOLNM3rd7dV24hVipVRuvmJqpn4Dn
	kNOJdIwR5FEHddoIdwx9/No54O6BN2TMxY+wtYkExViSjfCl/HS944S3ecBLPLuP
	JJsyj3+zwGohDm+EJz0n2qALG93wsFjGl9A==
X-ME-Sender: <xms:fbO3abMSThxWJeym7hlmZetz9biRf5SWCgm-TTX2OEZbVTY3zQTyEw>
    <xme:fbO3adtL2ZEoIghQWmsOcJdzXmRGavHjACPRWGVS6rBAPHNm9LIrPe_fAws-7LL0o
    KgDDitjfrW_egNS_MKlIQzN3RA1ZDHJkfZ0-2JHMp2GWGc5jJFW>
X-ME-Received: <xmr:fbO3adWJ8ZXc0FFixqhFct37kc5TNLlYsoI-L8YrUg-RUMGdMEqiZJVkReY2B0Tj-iO-UNAPuntWHxdgkzOQ1h-3UmPCyCsVh97qaPQ7a2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fbO3aduOmqqcdWa_-hVxnn6fm37aSTKWOGeXVZrTzcIlJcPxl4Ujqg>
    <xmx:fbO3aRWf3omx-pBQmWsGsLXfodlOfk4gn0ocOJO0UrC0raFQ2YRjAw>
    <xmx:fbO3aYlaQfd7i5CU18Loic7USQl2jIGDn_aKjUMJnNf97I0gDM0O0A>
    <xmx:fbO3aSawYLA3wZMkfadM56R-l8uSycyLTWwslijq4cdWNNGwibUBJA>
    <xmx:fbO3aX9GZZPx6245O0UeFJWKZ1xDRQuk8gWtd7DSwcC5jcbGntBjPWvu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 03:38:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a1125c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 07:38:34 +0000 (UTC)
Date: Mon, 16 Mar 2026 08:38:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] worktree: remove "the_repository" from
 is_current_worktree()
Message-ID: <abezeNELL9SU8v82@pks.im>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
 <cover.1773591528.git.phillip.wood@dunelm.org.uk>
 <075700a22568913988c9fa8e1ff49db1a1a5b606.1773591528.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075700a22568913988c9fa8e1ff49db1a1a5b606.1773591528.git.phillip.wood@dunelm.org.uk>

On Sun, Mar 15, 2026 at 04:18:50PM +0000, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> is_current_worktree() compares the gitdir of the worktree to the gitdir
> of "the_repository" and returns true when they match. To get the gitdir
> of the worktree it calls get_workree_git_dir() which also depends on
> "the_repository". This has the effect that even if "wt->path" matches
> "wt->repo->worktree" is_current_worktree(wt) will return false when
> "wt->repo" is not "the_repository" which is confusing.
> 
> The use of "the_repository" in is_current_wortree() comes from
> replacing get_git_dir() with repo_get_git_dir() in 246deeac951
> (environment: make `get_git_dir()` accept a repository, 2024-09-12). In
> get_worktree_git_dir() it comes from replacing git_common_path() with
> repo_common_path() in 07242c2a5af (path: drop `git_common_path()`
> in favor of `repo_common_path()`, 2025-02-07). In both cases we have
> a repository instance available so use that instead. This means
> that a worktree "wt" is always considered current when "wt->path"
> matches "wt->repo->worktree" and so the worktree returned by
> get_worktree_from_repository() is always considered current.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  worktree.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/worktree.c b/worktree.c
> index e9ff6e6ef2e..344ad0c031b 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -58,7 +58,7 @@ static void add_head_info(struct worktree *wt)
>  
>  static int is_current_worktree(struct worktree *wt)
>  {
> -	char *git_dir = absolute_pathdup(repo_get_git_dir(the_repository));
> +	char *git_dir = absolute_pathdup(repo_get_git_dir(wt->repo));
>  	char *wt_git_dir = get_worktree_git_dir(wt);
>  	int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
>  	free(wt_git_dir);

Hm, okay.

> @@ -78,7 +78,7 @@ struct worktree *get_worktree_from_repository(struct repository *repo)
>  	wt->is_bare = !repo->worktree;
>  	if (fspathcmp(gitdir, commondir))
>  		wt->id = xstrdup(find_last_dir_sep(gitdir) + 1);
> -	wt->is_current = is_current_worktree(wt);
> +	wt->is_current = true;
>  	add_head_info(wt);
>  
>  	free(gitdir);

I have been staring at this code for longer than I want to admit, and I
still haven't convinced myself that this is not a change in behaviour.
I think what I'm wondering about is what `is_current_worktree()` is
actually intended to do. In other words, what _do_ we consider to be
"current"?

Naively, I would consider the worktree "current" that the Git process
has been invoked in. So if I pass a repo other than `the_repository`, or
if I pass a worktree that is not the one that Git has been started in,
then I would expect the function to return `false`. With that naive
assumption your change would be breaking the existing logic.

But I have no idea whether my assumption is correct or not, as
there is not really any documentation of what the function or of the
`struct worktree::is_current` field. And having a look at a couple of
callers doesn't really make me all the wiser.

It would be great if you could shine some light on this and then also
add a bit of documentation to either the function, the field, or both :)

Thanks!

Patrick
