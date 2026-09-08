Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590C48F026
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905549; cv=none; b=AbmTGv5sq0OHK0GWuHmknALi2OcDPli2lVJurTHd2z98VK/4jOIKKLjk/EEJgBPHjylxIBrxwiaVH0CP0/ojRZmnhOP3TkKelCG9IfIO9mKqTrfITSVcR4dAdHtLwgvg3gsBmThs87CZoyJcxwI4hks/+d0QjSKeORDxQre+Nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905549; c=relaxed/simple;
	bh=bewUHgm7M+NAT9Fc0N+hKX6/uFKIsv31UdezEFQdmAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXj7vL7gHm89JC5svFJUieNvgz+tqmnJSraK6hu/LjY0cUZ+FcRXSyIOO9X+b03+cfguROApqGRoJd5V7YDbLCguXOwAItt5iORMJl4aNfcwMd6duQzRs/Hubs3f3VOyKyq5psxYT+I+caz+LyuHGtvEgDGKTFAC4d+eXknlkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqhZUI45; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqhZUI45"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f4f824de5dso2124987a34.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788905546; x=1789510346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2DVXKibuOLKvfonFkflBqNrTHhESJJ+nRt4xANSCCFU=;
        b=qqhZUI45xLp+SqOW9u9QxO92FUCUWQn1OtAeLgX5EgkLJoBOhZkAYJ6yornqthEcPS
         Yx20XlAanZt5O33ra3bW6sr8Yznd63jywYjKq2b1y7GoDMdgCD9YMeNHolhJq7yRjskj
         rwBshdNKYZKEInx7LCG/QJItWMkBUEljYE5co0TMVmr9/AGqkApqE5VmoFPrXYWbLIRK
         FbDFEIhumn+fGg/H0W7ev0GnHm33dJdjmYwT14y8Jm3lcMEsOSy+W2Wzs4zkVtimWJEM
         OA92cc+qIcBinu3XCkSzKBacaMy6iMIDk8rDi0jmMOXXxGpJdyDxPI2l2yEM1zoWlApD
         3fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788905546; x=1789510346;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2DVXKibuOLKvfonFkflBqNrTHhESJJ+nRt4xANSCCFU=;
        b=LKqgJIi3MyXm7to2HO5TXTw08nparzJf+ZkDXAsytE7QoAXSS7761CxAko2NwOkdt9
         nA9G22c8kt12J8Vtpi+IdtIpA5KjVqE1+98Csj2nBrpgR1nFY9J7xI8UEzM1jv0EJeh9
         l/CB0YYMh9o6Nvtd/tXcIBwWAPC5yrT53xsg/222D7GBQANeLUhgTts9sQETHhxfhxhp
         qm40bhb0iF/ejF3Va/NQ1FlNoy5IvjY4sIsSrn+KG2hdnNJM08AzP36INJiSBuSjWHlV
         lkuOfNJGNsXjLkyGg+ax/KVZnikfJ3u6/yHo/Hkkv673ybj3yTlLbMALmkmmlZQ/ADis
         nHJA==
X-Gm-Message-State: AFuF++ni3C5+aQrmGm9ZXJcS6s9sq0GLdc6oIK7eBQeZxczE0dLIO3e7
	lewkwdeyPmw3/yKszwbPhQwBfM+cZNxIbmEo8PseDkrlt9xk9GbeibcX9sP8zg==
X-Gm-Gg: AYBFou2DQZOgdkLh0IEPvxZmkHMZ9/1k5GqfXfLLshcXfUN0Jml0lwN0QQIt7oQnIMi
	2vAAHm96MMimgdr3ltzb+ByR9lqkIn4JtladAxO49bS7wDQHdG/I5y179mJ0DbUFLuPsFwC0ODR
	jXRBHyXoCPQVzUFk1G8hH3vVRsZxz/nGgz0QQ0aSdLUOyuSLFCZAymBvp2G4k+j3A0H6xnuYLJS
	ZPr4of5ASgrIGEkJPtV4rktr1Gun7komSV8UqwjuF9EQQD7h9oRsuHycONBRRV/ftPIyLNU2B2b
	+L3YvzrhdG7X5R2dn3qVfdkUsZe4dKcFzfg/6uyVLI0ATnQJWYMXOabbTd6hYqzIjMA4dGdBhS2
	McF/J2sB4iwSe5Zt0vnlP9xywArGI1GsS+EY4GQm580xUcaKfECn+yT1sqj5CMY1ZkFqcfH+kDs
	pAb7DYu03xwUZrSAJ8Q4GL0hv893oZeqJyZSNscVS4AgbRixQBGZ76qgD2QTwxsNDEM0xjs7oIj
	EAPAXljR4lHTA==
X-Received: by 2002:a05:6830:4ac4:b0:7e9:c481:ff8a with SMTP id 46e09a7af769-7fa1f92c677mr22990243a34.11.1788905546513;
        Tue, 08 Sep 2026 15:12:26 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7aef680sm16183834a34.26.2026.09.08.15.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:12:25 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:12:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] setup: split up concerns of `init_db()`
Message-ID: <aqCE801dAwP7pAU5@denethor>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
 <20260907-pks-odb-write-alternates-at-creation-time-v3-1-735d0b5b3e00@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-1-735d0b5b3e00@pks.im>

On 26/09/07 10:25AM, Patrick Steinhardt wrote:
> The function `init_db()` is responsible for creating the on-disk
> directory structure required for a Git repository. It is used by both
> git-init(1) and git-clone(1), and because their expected behaviour is
> different we support a couple of flags:
> 
>   - The `QUIET` flag controls whether the command is quiet or not. For
>     git-init(1) this is user-controllable, whereas for git-clone(1)
>     we're always quiet.
> 
>   - The `EXIST_OK` flag controls whether a preexisting repository is
>     okay or not. For git-init(1) it is, for git-clone(1) it's not.
> 
>   - The `SKIP_REFDB` flag controls whether the reference database should
>     already be created or not. For git-init(1) we do, but for
>     git-clone(1) we don't because it does not yet know about the default
>     branch and about the remote object hash.
> 
> Furthermore, we're about to add another divergence in behaviour, where
> we have to also skip creation of the object database in git-clone(1).
> This is becoming quite cumbersome though.
> 
> Instead of introducing another flag, start to split up concerns of the
> function so that we never create the reference or object database. This
> becomes the responsibility of the caller, which is thus free to defer
> their creation to a later point in time. This lets us get rid of most of
> the divergent behaviour:
> 
>   - We don't need the `SKIP_REFDB` and a potential `SKIP_ODB` flags
>     anymore.
> 
>   - We don't need the `QUIET` flag anymore, as nothing prints output
>     except for the final status message that tells the user that the
>     repository has been (re)initialized. But as this message is specific
>     to git-init(1), we can easily move it there.
> 
> The only piece of information we still have to convey is whether or not
> reinitialization of a preexisting repository is okay. This is handled by
> a new `reinit_ok` pointer that, if non-`NULL`, indicates that it is okay
> to reinitialize the repository. Furthermore, the pointer will be written
> to to indicate whether the repository was reinitialized or not, which we
> need in git-init(1) to print the correct initialization message.

I like the proposed direction here much more than the previous version.
:)

> With these refactorings, `init_db()` is named quite misleadingly though,
> as we don't create any of the reference or object databases anymore.
> Rename it to `create_repository()`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c   |  9 +++++----
>  builtin/init-db.c | 32 ++++++++++++++++++++++++--------
>  setup.c           | 54 +++++++++++++++++-------------------------------------
>  setup.h           | 22 ++++++++++------------
>  4 files changed, 56 insertions(+), 61 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5b25cca510..904d2d859f 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1185,10 +1185,10 @@ int cmd_clone(int argc,
>  	 * repository, and reference backends may persist that information into
>  	 * their on-disk data structures.
>  	 */
> -	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
> -		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
> -		do_not_override_repo_unix_permissions,
> -		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
> +	create_repository(the_repository, git_dir, real_git_dir, work_tree,
> +			  option_template, GIT_HASH_UNKNOWN, ref_storage_format,
> +			  do_not_override_repo_unix_permissions, NULL);
> +	create_object_database(the_repository);

The implicit creation of the ref DB was already skipped so we only need
to explicitly add `create_object_database()`. Makes sense.

>  	if (real_git_dir) {
>  		free((char *)git_dir);
> @@ -1445,6 +1445,7 @@ int cmd_clone(int argc,
>  	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
>  	repo_set_hash_algo(the_repository, hash_algo);
>  	create_reference_database(the_repository, NULL, 1);
> +	startup_info->have_repository = 1;

Ok IIUC, we now have to explicitly set "have_repository" because we
don't want to set it if the ODB has not been created.

>  	/*
>  	 * Before fetching from the remote, download and install bundle
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index e96b1283b7..f2c7e3be6d 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -80,7 +80,7 @@ int cmd_init_db(int argc,
>  	char *work_tree = NULL;
>  	const char *template_dir = NULL;
>  	char *template_dir_to_free = NULL;
> -	unsigned int flags = 0;
> +	int quiet = 0;
>  	int bare = startup_info->force_bare_repository ? 1 : -1;
>  	const char *object_format = NULL;
>  	const char *ref_format = NULL;
> @@ -102,7 +102,7 @@ int cmd_init_db(int argc,
>  			.flags = PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>  			.callback = shared_callback
>  		},
> -		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
> +		OPT_BOOL('q', "quiet", &quiet, N_("be quiet")),
>  		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
>  			   N_("separate git dir from working tree")),
>  		OPT_STRING('b', "initial-branch", &initial_branch, N_("name"),
> @@ -113,7 +113,7 @@ int cmd_init_db(int argc,
>  			   N_("specify the reference format to use")),
>  		OPT_END()
>  	};
> -	int ret;
> +	int reinit;
>  
>  	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
>  
> @@ -247,14 +247,30 @@ int cmd_init_db(int argc,
>  		die(_("--separate-git-dir incompatible with bare repository"));
>  	}
>  
> -	flags |= INIT_DB_EXIST_OK;
> -	ret = init_db(the_repository, git_dir, real_git_dir, work_tree,
> -		      template_dir, hash_algo, ref_storage_format, initial_branch,
> -		      init_shared_repository, flags);
> +	create_repository(the_repository, git_dir, real_git_dir, work_tree,
> +			  template_dir, hash_algo, ref_storage_format,
> +			  init_shared_repository, &reinit);
> +	create_reference_database(the_repository, initial_branch, quiet);
> +	create_object_database(the_repository);
> +
> +	if (!quiet) {
> +		int len = strlen(git_dir);
> +
> +		if (reinit)
> +			printf(repo_settings_get_shared_repository(the_repository)
> +			       ? _("Reinitialized existing shared Git repository in %s%s\n")
> +			       : _("Reinitialized existing Git repository in %s%s\n"),
> +			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
> +		else
> +			printf(repo_settings_get_shared_repository(the_repository)
> +			       ? _("Initialized empty shared Git repository in %s%s\n")
> +			       : _("Initialized empty Git repository in %s%s\n"),
> +			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
> +	}

Previously all of this logic was specific to git-init(1), so now its
moved out of the generic function accordingly to furthur simplify the
interface. Nice.

[snip]
> diff --git a/setup.h b/setup.h
> index 763fd384e8..c4aa464caa 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -256,23 +256,21 @@ int apply_repository_format(struct repository *repo,
>  
>  const char *get_template_dir(const char *option_template);
>  
> -#define INIT_DB_QUIET      (1 << 0)
> -#define INIT_DB_EXIST_OK   (1 << 1)
> -#define INIT_DB_SKIP_REFDB (1 << 2)
> -
> -int init_db(struct repository *repo,
> -	    const char *git_dir,
> -	    const char *real_git_dir,
> -	    const char *worktree,
> -	    const char *template_dir, int hash_algo,
> -	    enum ref_storage_format ref_storage_format,
> -	    const char *initial_branch, int init_shared_repository,
> -	    unsigned int flags);
> +void create_repository(struct repository *repo,
> +		       const char *git_dir,
> +		       const char *real_git_dir,
> +		       const char *worktree,
> +		       const char *template_dir,
> +		       int hash_algo,
> +		       enum ref_storage_format ref_storage_format,
> +		       int init_shared_repository,
> +		       int *reinit_ok);

While we are here, it might be nice to document these functions a little
bit. The NULL/non-NULL behavior of `reinit_ok` may not be entirely
obvious to future readers.

>  void initialize_repository_version(struct repository *repo,
>  				   int hash_algo,
>  				   enum ref_storage_format ref_storage_format,
>  				   int reinit);
>  void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
> +void create_object_database(struct repository *repo);

It might also be nice to document these functions to explain exactly
what we are "creating".

-Justin
