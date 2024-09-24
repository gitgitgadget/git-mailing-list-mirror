Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4681B85D5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187031; cv=none; b=Xc5UgK9dvqQip0H55/xxGHUCXh2ZeuBBsidc2oHcDVMkeTXR7ZDp+INZ4hV1JMOutRVWjgSo9h1m5hzrclwFdJ0LbF5ZXF7JokOpXQoJ3Tg0+44w6q0/oN23udkDeGiEuUbMoOqt3vMmHecw1adiClGGNWsugjxxE4V2hQchGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187031; c=relaxed/simple;
	bh=P/7zBHSTZIkq3HtdoUb+AFJDPKz5WMNyXKRZ1+7YoTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIFv0OIDpV0rnVpX7lW0t3lxjUkSsz6QcUl4SilieFfj3Dpql2mHmlo8xRE2hKfHTG3j2T9IDSMvvKnFpldwSMKeQUvJ4S8CL5qUGjC0VZPS1jrtm7wDQ0hroPweKTb8Zu6UTaH9hQFnReQ9cNnhvxpTycnD42a7HbbCjjOB4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLP1C6z4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLP1C6z4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-208e0a021cfso29344705ad.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727187029; x=1727791829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JrxESpDug7HfmC4rIqO8wWeSsHQrt8/7FUpoI6nP9+s=;
        b=OLP1C6z4+370RAGDAFcPsoFNcR2nT8eDkv+8Fp+fNJ5DoXkODvBsbbzzEEyCQh5Zyg
         7+soDt+pYQ4u30gJwPGa8KpM3nlVaAKE/J7iMEPEFsaqHwMYNTacQzvVxeEGXVOfdOGq
         vbs6BL595j3sppyHrCXtlAYTMKQF7L6ZSIIXM+j2sxkrpSqRjAeCrc16KLXf//ntgpdT
         jpZmM+cz+fx7QgdkMK3I2WrN25ufzWGRJeqGc+WJLEcpNMZdipKDXw1GwteCneNPhnCJ
         OnZlGfJ8nB+O8vkEVTCaLOj4KuSYt7wX+MDvVGurIdR+qbrjkOgozb+HN4J8RSDwYlgo
         SdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727187029; x=1727791829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrxESpDug7HfmC4rIqO8wWeSsHQrt8/7FUpoI6nP9+s=;
        b=ULqeaLR7o6Er/Qboogn+DE52qHzwpil6gw9VnPs5NKnhRaI1Bz0Oww+DpTbQ5/nnWU
         yZdlhgtKWNh5W9D3tsatiRDf//0WVbfXJWgByPAIdfLpAaUjlKIJuKKTmDOdIX74Iw7m
         vq+hnr1DA1qn+wGTLnpsS226ou1+e96rZDJvxFFzvWOmivFp9En+wee3CxLIfsseoDFW
         bbhSxlG2CkVxsylfTsSeHZTNXOg8rcbhbYbAwLraAmOALiz726GJnFDu9HO/ESpU/yHI
         YH1aGTIz6/sTrx/Ml//aDScZGjIHHqwkWHRjl0o/5ZNr7Ra4owkfvZdLD45Bbls04pBp
         vuWQ==
X-Gm-Message-State: AOJu0Yz6R5A+oyrc6byQ5GtxJATcfoi9NBubbbg53ATfdaORCbgVD3RJ
	Y1lwuUhzbWBrPP12GancGoP879+ufVDX0IN8iEOlXv6rDclui8gZ
X-Google-Smtp-Source: AGHT+IHD1Rng7ujPeEODh6eXQpAjY2BIJ9jffBxe+/6QcEqNAfaC+cVVwFnsmt2ZMThCWWrNIGRERg==
X-Received: by 2002:a17:902:ccd1:b0:208:d893:5707 with SMTP id d9443c01a7336-208d8935c47mr197669945ad.1.1727187029127;
        Tue, 24 Sep 2024 07:10:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e6bf2sm10782295ad.30.2024.09.24.07.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:10:28 -0700 (PDT)
Date: Tue, 24 Sep 2024 22:11:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ronan Pigott <ronan@rjp.ie>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] config: fix evaluating "onbranch" with nonexistent
 git dir
Message-ID: <ZvLInrIQRj8xpSgF@ArchLinux>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
 <cover.1727171197.git.ps@pks.im>
 <535d0d07506e8248e47f90c1a7581679fc297b3d.1727171197.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <535d0d07506e8248e47f90c1a7581679fc297b3d.1727171197.git.ps@pks.im>

On Tue, Sep 24, 2024 at 12:05:46PM +0200, Patrick Steinhardt wrote:
> The `include_by_branch()` function is responsible for evaluating whether
> or not a specific include should be pulled in based on the currently
> checked out branch. Naturally, his condition can only be evaluated when
> we have a properly initialized repository with a ref store in the first
> place. This is why the function guards against the case when either
> `data->repo` or `data->repo->gitdir` are `NULL` pointers.
> 
> But the second check is insufficient: the `gitdir` may be set even
> though the repository has not been initialized. Quoting "setup.c":
> 
>   NEEDSWORK: currently we allow bogus GIT_DIR values to be set in some
>   code paths so we also need to explicitly setup the environment if the
>   user has set GIT_DIR.  It may be beneficial to disallow bogus GIT_DIR
>   values at some point in the future.
> 
> So when either the GIT_DIR environment variable or the `--git-dir`
> global option are set by the user then `the_repository` may end up with
> an initialized `gitdir` variable. And this happens even when the dir is
> invalid, like for example when it doesn't exist. It follows that only
> checking for whether or not `gitdir` is `NULL` is not sufficient for us
> to determine whether the repository has been properly initialized.
> 

When I dive into this bug report, I feel so wired about this behavior. I
don't mind whether the code sets "gitdir" field. This is not important.
In "setup.c::setup_git_directory_gently", it will set the
"the_repository->gitdir" by checking the environment variable
"GIT_DIR_ENVIRONMENT". And by using `--git-dir` option, the code will
set this environment variable, so these two ways will set the "gitdir"
field in the global variable "the_repository".

We actually check the validation of "--gir-dir" option before we set
this value. Let me give you an example here:

  $ git --git-dir=notexist -c includeIf.onbranch:main.path=any fsck
  fatal: not a git repository: 'notexist'

I am curious here. And I notice the following difference in
"setup.c::setup_explicit_git_dir" function:

    if (!is_git_directory(gitdirenv)) {
        if (nongit_ok) {
            *nongit_ok = 1;
            ...
            return NULL;
        }
        die(_("not a git repository: '%s'"), gitdirenv);
    }

Apparently, the above example will execute the "die". For
"git-archive(1)", it will simply return NULL. This is because we allow
some commands to run outside of the git repo. And we distinguish them by
using the ".option" filed:

    { "apply", cmd_apply, RUN_SETUP_GENTLY },
    { "fsck", cmd_fsck, RUN_SETUP },

As we can see, the code will check whether the "gitdir" (although it is
not set into "the_repository" structure yet) is a valid git repository.
We already have this information.

In f7d61c4135 (config: don't depend on `the_repository` with branch
conditions, 2024-08-13). "config.c::include_by_branch" drops the global
variable "the_repository". This solves the problem reported by Ronan.
Because it happens in the set up process, the "data->repo" will be NULL.

    config_with_options(cb, data, NULL, NULL, &opts);

    int config_with_options(config_fn_t fn, void *data,
                            const struct git_config_source *config_source,
                            struct repository *repo,
                            const struct config_options *opts)
    {
        struct config_include_data inc = CONFIG_INCLUDE_INIT;

        ...

        inc.repo = repo;
    }

But the problem still exists for "git-archive(1)", in "cmd_archive"
function, we will initialize the configurations by using "repo_config".
But we are not inside the repo.

I wonder how we use the global variable "the_repository". I think the
main problem here is that we use "the_repository" structure outside of
the repo where we have already broken the semantics of the
"the_repository" variable.

> This issue can lead to us triggering a BUG: when using a config with an
> "includeIf.onbranch:" condition outside of a repository while using the
> `--git-dir` option pointing to an invalid Git directory we may end up
> trying to evaluate the condition even though the ref storage format has
> not been set up.
> 
> This bisects to 173761e21b (setup: start tracking ref storage format,
> 2023-12-29), but that commit really only starts to surface the issue
> that has already existed beforehand. The code to check for `gitdir` was
> introduced via 85fe0e800c (config: work around bug with
> includeif:onbranch and early config, 2019-07-31), which tried to fix
> similar issues when we didn't yet have a repository set up. But the fix
> was incomplete as it missed the described scenario.
> 

Yes, exactly. Because before 173761e21b, the code will always find the
files backend, it does care about whether we are in the git repo or not.

    unsigned int format = REF_STORAGE_FORMAT_FILES;
    const struct ref_storage_be *be = find_ref_storage_backend(format);

So, it won't complain.

> As the quoted comment mentions, we'd ideally refactor the code to not
> set up `gitdir` with an invalid value in the first place, but that may
> be a bigger undertaking. Instead, refactor the code to use the ref
> storage format as an indicator of whether or not the ref store has been
> set up to fix the bug.
> 

Should we? From my above comments, it does no matter whether we set the
"gitdir" in the "the_repository". Because we already check this and we
have this information. I think the main problem is that we use
"the_repository" badly.

We could run git commands inside the repo or outside the repo. If we run
git commands outside the repo, should we use the "the_repository"
variable? I guess we should not.

Because "git_config", "repo_config" and so on use the global variable
"the_repository", so we will encounter the trouble. But if we could use
something like "data->repo". We will make everything OK:

1. When running commands inside the git repo, we set "data->repo" to be
"the_repository".
2. When ruing commands outside the git repo, we set "data->repo" to be
NULL.

> Reported-by: Ronan Pigott <ronan@rjp.ie>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  config.c                  | 15 +++++++++------
>  t/t1305-config-include.sh |  2 +-
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 1266eab0860..a11bb85da30 100644
> --- a/config.c
> +++ b/config.c
> @@ -306,13 +306,16 @@ static int include_by_branch(struct config_include_data *data,
>  	int flags;
>  	int ret;
>  	struct strbuf pattern = STRBUF_INIT;
> -	const char *refname = (!data->repo || !data->repo->gitdir) ?
> -		NULL : refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
> -					       "HEAD", 0, NULL, &flags);
> -	const char *shortname;
> +	const char *refname, *shortname;
>  
> -	if (!refname || !(flags & REF_ISSYMREF)	||
> -			!skip_prefix(refname, "refs/heads/", &shortname))
> +	if (!data->repo || data->repo->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> +		return 0;
> +
> +	refname = refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
> +					  "HEAD", 0, NULL, &flags);
> +	if (!refname ||
> +	    !(flags & REF_ISSYMREF) ||
> +	    !skip_prefix(refname, "refs/heads/", &shortname))
>  		return 0;
>  
>  	strbuf_add(&pattern, cond, cond_len);
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index ad08db72308..517d6c86937 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -389,7 +389,7 @@ test_expect_success 'onbranch without repository' '
>  	test_must_fail nongit git config get foo.bar
>  '
>  
> -test_expect_failure 'onbranch without repository but explicit nonexistent Git directory' '
> +test_expect_success 'onbranch without repository but explicit nonexistent Git directory' '
>  	test_when_finished "rm -f .gitconfig config.inc" &&
>  	git config set -f .gitconfig "includeIf.onbranch:**.path" config.inc &&
>  	git config set -f config.inc foo.bar baz &&
> -- 
> 2.46.0.551.gc5ee8f2d1c.dirty
