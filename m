Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9D39E6FD
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126107; cv=none; b=JlB4+zN+i5AMCnVOYAhkPt9rPdLFVh+pRJT2FYbuopMXng9bqFv9hceUEC4g1AfFhpWD23JL2rss3m9jrnRYtivHrUv0Lq48TBD6fToHBq/A7fKjdAlZleYS+ltp8U0lp62vWBG2LCLKn9r1UyB8RmiRpTZnUrnLF7Q9AHSYPYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126107; c=relaxed/simple;
	bh=T1FcVIbYj/ypySvImOEiDSC1mluBQOceEEw3eaCP5ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRZEx37QZ8vslhj4xRXuzewsW02zzsJmDMNaIF3GZCqDIijpEWUPtBEuQ/PTVG173G8MgFdEU1CtDO/5wEREOuahAFPcEY/S3qovcrG/+9kvZiBUPyNDFc9c88etGO9IEElpcnsoyyXKTrDkufB0yWPmsUeo7E1hSKsfVed6r+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOpmsoff; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOpmsoff"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e615efd7d7so6630523a34.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781126105; x=1781730905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUAhJB5L915/2hfY/RHLukI04PBZw2IqyFaOLbTt6KM=;
        b=nOpmsoffCiaI2Jsn5gUe29IyJi/+v4c4VY3bzNOfxzTz+cGtVRyJmAbCrtId4YF+oS
         2Byue2b3NxZJZrik913dPiljRlMxqPHrGECRdKqCsdbf7zLrZXrQ8MPQnBToXJurP93J
         KjEk3CFzWT3Mp9dXoGMzVm6k/B+vOpV0/sbSELKiqAvRthv8nxRr6TAmXwJOlPTWWj8o
         nxy1uP+DnOH+SonnkVBZTu/sJrrqNhA5RItPFqyFkXhmW5boJC2ljrX97bRBjbRrp+hn
         KZ35b/NrzR80XTv1OWFt/yLDYGjP04+5SzGoTbYaaOVB4shGH6T7HKji+isYhcsHW40C
         mTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781126105; x=1781730905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUAhJB5L915/2hfY/RHLukI04PBZw2IqyFaOLbTt6KM=;
        b=N4KHD41yShn5NjZkXisuxPps4OxAwmiVAvlOUYr4tRv0z/InYtwDT7/L5EumgFLoXH
         orRqgTHPzOICmjIwfLEDE4J/ocsVOxjPCydrzfi8kUNXjlSwT3pLCm9Gi8DzwSyWgl6A
         JAqmCbgkkOMg1SwMKL0svJjCLgdfDj29apvxn4K2SbptUJa9sQyrCpD8y+n6q9i22dsy
         JoGxNMNlr+z/Q5SI87/VXnNIs+O3OSbp/46ZcF2WCmnOIWPC/n9Fz8+rKvDaBwLDSJVZ
         6xqvNzdj0awY4FWZJDc6d9N9kkRBOogLaY53YBQNnB87fcmL4Udcz6hcsLJ5CoK2N14c
         qPkg==
X-Gm-Message-State: AOJu0YwTeXo89gqM2IV1GZ9BM4zJ6l/cjq/VjLqJbcJ73NOrPXDKFwt8
	NGRsQOy2ZVQC1oCZZ+TTNzLM139/06QYJ7Hydz2++PdB5PsK/tmUHnrhL0KY7w==
X-Gm-Gg: Acq92OFQM74uDIuujQprgtHqvL5UynC/nbQoeeciQv64dWxPgfKCzJD0fZ9vROYDjFl
	YK4tW5Qik1kFN4gzdvDUYpMuS07DFW9zfsMsv9EPTyAALiOy4nu+aUhPoalVc1I1/QDaSVLpfkk
	U4DHNcj/KLUXsbQ7v7PL6oVCRvnV2ddT+XVxa5nAVHgonxlFCZTGv6TrGBdlhiFkhR5eHhkcVxI
	8DI2MJkks8Uhog9siFmqTJ2qzUPlFb26rqO/nqU3n7UB7TTLoEbnu/IN37dkhnjNb1KhGA2raP4
	n8c3d03WCNoQyexVFmWUPiUnGyRhn3wJJz6h0G38czXJWCBmySPwUJbXofehtwtyjGV8fhzcYTw
	zKKZ/jajSfiM3sQGpg5bsFRYNAh8w3T0bSX0jTJ5583svj2aN5a8/uMZxKSl6eXe5uTaxODp7Cr
	ZMDzXE/3n7HGu8TU1OTiW+Bm+cenw=
X-Received: by 2002:a05:6808:14c3:b0:47b:d914:48c3 with SMTP id 5614622812f47-4868dbedae5mr20157789b6e.10.1781126105184;
        Wed, 10 Jun 2026 14:15:05 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b32f372sm19101039b6e.0.2026.06.10.14.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 14:15:04 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:15:01 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] builtin/init: stop modifying global
 `git_work_tree_cfg` variable
Message-ID: <ainKs-8_0w_2HhOf@denethor>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260610-b4-pks-setup-drop-global-state-v1-1-5dff3eec8f06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-1-5dff3eec8f06@pks.im>

On 26/06/10 08:56AM, Patrick Steinhardt wrote:
> When executing git-init(1) we need to figure out the final location of
> the worktree. This location can be configured in a couple of ways: via
> an environment variable, via the preexisting "core.worktree" config in
> case we're reinitializing, or implicitly when reinitializing a non-bare
> repository.
> 
> When checking for the worktree location in "builtin/init-db.c" we
> populate any potentially-discovered value both by setting the global
> `git_work_tree_cfg` variable and via `set_git_work_tree()`, which
> ultimately ends up modifying `struct repository::worktree`.

Does `git_work_tree_cfg` have any bearing on the worktree value that
ends up in `struct repository`? Or is it just `set_git_work_tree()`?

> Modifying `git_work_tree_cfg` is unnecessary though: we configure the
> worktree in `create_default_files()`, and that function derives the
> worktree location via `repo_get_work_tree()`. Consequently, propagating
> the worktree via `set_git_work_tree()` is sufficient.

Ok, so IIUC there is really no reason to globally store the
`git_work_tree_cfg` value derived during `cmd_init_db()`. We only care
about the worktree written to `struct repository`.

> Stop munging `git_work_tree_cfg` and make it file-local to "setup.c" and
> function-local to `cmd_init_db()`.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/init-db.c | 4 ++++
>  environment.c     | 3 ---
>  environment.h     | 1 -
>  setup.c           | 3 +++
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index c55517ad94..01bc27904e 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -229,6 +229,8 @@ int cmd_init_db(int argc,
>  
>  	if (!is_bare_repository_cfg) {
>  		const char *git_dir_parent = strrchr(git_dir, '/');
> +		char *git_work_tree_cfg = NULL;

We figure out the worktree locally and continue to set it via
`set_git_work_tree()` without updating a global worktree config value.

> +
>  		if (git_dir_parent) {
>  			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
>  			git_work_tree_cfg = real_pathdup(rel, 1);
> @@ -243,6 +245,8 @@ int cmd_init_db(int argc,
>  		if (access(repo_get_work_tree(the_repository), X_OK))
>  			die_errno (_("Cannot access work tree '%s'"),
>  				   repo_get_work_tree(the_repository));
> +
> +		free(git_work_tree_cfg);
>  	}
>  	else {
>  		if (real_git_dir)
> diff --git a/environment.c b/environment.c
> index fc3ed8bb1c..4e86335f25 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -100,9 +100,6 @@ int auto_comment_line_char;
>  bool warn_on_auto_comment_char;
>  #endif /* !WITH_BREAKING_CHANGES */
>  
> -/* This is set by setup_git_directory_gently() and/or git_default_config() */
> -char *git_work_tree_cfg;
> -
>  /*
>   * Repository-local GIT_* environment variables; see environment.h for details.
>   */
> diff --git a/environment.h b/environment.h
> index ccfcf37bfb..5d6e4e6c1b 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -149,7 +149,6 @@ int have_git_dir(void);
>  
>  extern int is_bare_repository_cfg;
>  int is_bare_repository(void);
> -extern char *git_work_tree_cfg;
>  
>  /* Environment bits from configuration mechanism */
>  extern int trust_executable_bit;
> diff --git a/setup.c b/setup.c
> index b4652651df..52228b42a1 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -31,6 +31,9 @@ enum allowed_bare_repo {
>  	ALLOWED_BARE_REPO_ALL,
>  };
>  
> +/* This is set by setup_git_directory_gently() and/or git_default_config() */
> +static char *git_work_tree_cfg;

Ok, now `git_work_tree_cfg` is only referenced from "setup.c".

-Justin
