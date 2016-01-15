From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 15/20] init: allow alternate backends to be set for
 new repos
Date: Fri, 15 Jan 2016 13:51:39 +0100
Message-ID: <20160115125139.GI10612@hank>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
 <1452788777-24954-16-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 13:51:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK3qb-0007L6-LI
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 13:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570AbcAOMvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 07:51:17 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33134 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057AbcAOMvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 07:51:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id u188so2704200wmu.0
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 04:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZkQIlS7xqNqMlOyJ2A+aHr61lAxx8sp4J+SckeG3OiM=;
        b=VPMx8KMv3fNacGF+gFiio59C/Sd+23f3nt9v5T6wg4CKNYdoLgfgNreGfqCA9LbgtO
         qdMMuNVgkvmUemEJDEVcpG7/Lz7s26qfz56eJzQ0ZDTH78sdP0Kr46i9OZWxBROcNMYO
         7loMh5NT3UUZ+m6e1nkDlvkLATjDo9+l62bu0JAZhcS4G/rYPAhc+67mB1NX1WRQOtU2
         dJY+82az/IwYGVLHsongB7ejVBtHTYljNEIc54B5hQCZAM5cNwDpwHUL6h4aYuMP+s7w
         J1MN5XZ9QYv6we354I2YeZZYgns3mBu7JsUN/UBH8wvwA2/4iIqB/rP2Q2yh3uymERMm
         4hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZkQIlS7xqNqMlOyJ2A+aHr61lAxx8sp4J+SckeG3OiM=;
        b=BbG15T9fxj1IVhg6o1Lh5PmB8wFaC2Q/Ru8l8NutDNpTB65z4PTdgYUp75XIgK4d9l
         ErFE1lglCphpXUW8nBFmim+ZXKqPVzCfbSg3otKXy3RTDjOd2NyR/uWC935qBkH4L5aW
         escRxbIo5plAO7PzVSLzxFMtj50LuLHtZffQyglYi78pI/wx6F6zvQHOSyEUJG811veU
         O2mTKPyhGGMrJj+Fc5oYAJckMulMTQCxqgdEK9szFmApx7jzYCDewLNxJtrG9wP6DZ0c
         HrDyhFwEH10sTbh6KMYpsZc65f3zleGBz+Ev52Lz6rlQMJuhJZqNPLcTLb3aaz6e3XC+
         daCg==
X-Gm-Message-State: ALoCoQku+1KO78DOzLA6r63+5d8/AO/ERteyaaRUTxxTspEPiTvemylnzBSb5jbc5nYJ0sAr/URAWin2GOyf0kOGNr6o8vDA7w==
X-Received: by 10.194.175.233 with SMTP id cd9mr9994949wjc.115.1452862274675;
        Fri, 15 Jan 2016 04:51:14 -0800 (PST)
Received: from localhost (host143-110-dynamic.40-79-r.retail.telecomitalia.it. [79.40.110.143])
        by smtp.gmail.com with ESMTPSA id uo9sm10463463wjc.49.2016.01.15.04.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2016 04:51:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452788777-24954-16-git-send-email-dturner@twopensource.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284164>

On 01/14, David Turner wrote:
> git init learns a new argument --ref-storage.  Presently, only
> "files" is supported, but later we will add other backends.
>
> When this argument is used, the repository's extensions.refStorage
> configuration value is set (as well as core.repositoryformatversion),
> and the refs backend's initdb function is used to set up the ref
> database.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Documentation/git-init-db.txt |  2 +-
>  Documentation/git-init.txt    |  7 ++++++-
>  builtin/init-db.c             | 31 ++++++++++++++++++++++++++-----
>  cache.h                       |  2 ++
>  path.c                        | 29 +++++++++++++++++++++++++++--
>  refs.c                        |  8 ++++++++
>  refs.h                        |  8 ++++++++
>  setup.c                       | 12 ++++++++++++
>  t/t0001-init.sh               | 24 ++++++++++++++++++++++++
>  9 files changed, 114 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
> index 648a6cd..d03fb69 100644
> --- a/Documentation/git-init-db.txt
> +++ b/Documentation/git-init-db.txt
> @@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]] [--ref-storage=<name>]
>
>
>  DESCRIPTION
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 8174d27..d2b150f 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
>  	  [--separate-git-dir <git dir>]
>  	  [--shared[=<permissions>]] [directory]
> -
> +	  [--ref-storage=<name>]
>
>  DESCRIPTION
>  -----------
> @@ -113,6 +113,11 @@ does not exist, it will be created.
>
>  --
>
> +--ref-storage=<name>::
> +Type of refs storage backend. Default is to use the original "files"
> +storage, which stores ref data in files in .git/refs and
> +.git/packed-refs.
> +
>  TEMPLATE DIRECTORY
>  ------------------
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 4771e7e..ebc747c 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -24,6 +24,7 @@ static int init_is_bare_repository = 0;
>  static int init_shared_repository = -1;
>  static const char *init_db_template_dir;
>  static const char *git_link;
> +static char *requested_ref_storage_backend;
>
>  static void copy_templates_1(struct strbuf *path, struct strbuf *template,
>  			     DIR *dir)
> @@ -179,6 +180,7 @@ static int create_default_files(const char *template_path)
>  	int reinit;
>  	int filemode;
>  	struct strbuf err = STRBUF_INIT;
> +	int repo_version = 0;
>
>  	/* Just look for `init.templatedir` */
>  	git_config(git_init_db_config, NULL);
> @@ -204,9 +206,6 @@ static int create_default_files(const char *template_path)
>  		adjust_shared_perm(get_git_dir());
>  	}
>
> -	if (refs_init_db(&err, shared_repository))
> -		die("failed to set up refs db: %s", err.buf);
> -
>  	/*
>  	 * Create the default symlink from ".git/HEAD" to the "master"
>  	 * branch, if it does not exist yet.
> @@ -214,14 +213,34 @@ static int create_default_files(const char *template_path)
>  	path = git_path_buf(&buf, "HEAD");
>  	reinit = (!access(path, R_OK)
>  		  || readlink(path, junk, sizeof(junk)-1) != -1);
> -	if (!reinit) {
> +	if (reinit) {
> +		if (requested_ref_storage_backend &&
> +		    strcmp(ref_storage_backend, requested_ref_storage_backend))
> +			die("You can't change the refs storage type (was %s; you requested %s)",
> +			    ref_storage_backend, requested_ref_storage_backend);
> +	} else {
>  		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
>  			exit(1);
>  	}
>
> +	if (requested_ref_storage_backend)
> +		ref_storage_backend = requested_ref_storage_backend;
> +	if (strcmp(ref_storage_backend, "files")) {
> +		git_config_set("extensions.refStorage", ref_storage_backend);
> +		git_config_set("core.repositoryformatversion", ref_storage_backend);
> +#ifdef USE_LIBLMDB
> +		register_ref_storage_backend(&refs_be_lmdb);

refs_be_lmdb is not yet defined at this point in the patch series.  It
doesn't break anything, because USE_LIBLMDB doesn't leak through the
makefile yet, but I still think it would make more sense to have the
ifdef in 19/20.

> +#endif
> +		set_ref_storage_backend(ref_storage_backend);

More importantly, there is no check whether setting the ref storage
backend succeeds.  If a user accidentally sets an invalid value for
the ref backend, a broken repository will be created without even
warning the user.

While the repository will still work fine at this point in the series,
git will die with an invalid ref backend in the config after 19/20.
It can be fixed by setting extensions.refStorage to files in the
config, because the backend is initialized to the default files
backend below when the ref backend cannot be set.

I think it would be best to die() here, if setting the ref backend
doesn't succeed, and clean up the files that were already written,
instead of leaving the user with a broken repository.

> +		repo_version = 1;
> +	}
> +
> +	if (refs_init_db(&err, shared_repository))
> +		die("failed to set up refs db: %s", err.buf);
> +
>  	/* This forces creation of new config file */
>  	xsnprintf(repo_version_string, sizeof(repo_version_string),
> -		  "%d", GIT_REPO_VERSION);
> +		  "%d", repo_version);
>  	git_config_set("core.repositoryformatversion", repo_version_string);
>
>  	/* Check filemode trustability */
> @@ -469,6 +488,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
>  		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
>  			   N_("separate git dir from working tree")),
> +		OPT_STRING(0, "ref-storage", &requested_ref_storage_backend,
> +			   N_("name"), N_("name of backend type to use")),
>  		OPT_END()
>  	};
>

[...]

> +test_expect_success 'init with bogus storage backend fails' '
> +
> +	(
> +		mkdir again2 &&
> +		cd again2 &&
> +		git init --ref-storage=test >out2 2>err2
> +	)
> +'

I noticed the above mainly because of this test, which doesn't seem to
test what it claims to test.  It only seems to test that git init
succeeds, and writes something to out2 and err2, it's missing the
checks that the contents are actually what they're supposed to be.

> +
> +test_expect_failure 'reinit with changed storage backend fails' '
> +
> +	(
> +		mkdir again3 &&
> +		cd again3 &&
> +		git init >out1 2>err1 &&
> +		git init --ref-storage=test >out2 2>err2
> +	) &&
> +	test_i18ngrep "Initialized empty" again3/out1 &&
> +	test_i18ngrep "Reinitialized existing" again3/out2 &&
> +	>again3/empty &&
> +	test_i18ncmp again3/empty again3/err1 &&
> +	test_i18ncmp again3/empty again3/err2
> +'
> +
>  test_expect_success 'init with --template' '
>  	mkdir template-source &&
>  	echo content >template-source/file &&
> --
> 2.4.2.749.g730654d-twtrsrc
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
