Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939021F453
	for <e@80x24.org>; Tue, 30 Oct 2018 23:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeJaIDE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 04:03:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35671 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeJaIDD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 04:03:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id q12-v6so10167480wmq.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hsbqql+IaUVfDWVWCU1pZdLZAkChJAXyKEq9tijt7c8=;
        b=ep5aWh/XSpoTyp+zBC/5a9gDAimlgAeHRf3xZzkCwF+DV0PLR5oWZ8Hdgx0l4Ckns9
         w5io/9HuXRNlTbnX8Q4BcsCdzx+g719nombsnFmWfekyulUFs/s9X1BgXI6MM3QPsC6l
         KuKosoiZiVXbe8TAzs6D5lOjKzDsEsChMhWw/Dwm8Hfzlc+l6EuKjaaGaum+ItJRjm8J
         adLdqF2gwwGBJ4DUy3EN1uFnzhi8CPSC2Qdm8sK71vNUVv0vv4qiA45czRQ3zvg8QWYI
         RbiqmKupn1FoMkL2+Teae1LtqIpmrSUVhSklFIdZEGzldQkYUqGbLRLIpcl5o1m+TkTs
         6Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hsbqql+IaUVfDWVWCU1pZdLZAkChJAXyKEq9tijt7c8=;
        b=FxKzbx9/22eWkDsoySWZO2b9wnZ8nVNM2XBpNRx2mDTZNmpVoDwKyj52DHPTCKtqBu
         LfxZONp7gJjprTQLyB9Yrrt1MJ5vqVgSxfru/BNlsT+h1ayPh3WY4qNqSHjeG0iGWOPK
         ow4HQvB2vZkpK2i4+rGGkwngMhHKspSWIfCa4Q4N6HK+IT971cUkO+7pZTrp31/X7vsy
         OBvgcVfXZLCGaUtY+71g2gZBagHPvjbDssu44nxHb6HOhmtSGvUrcui3Q0w0T0Zx2WaV
         DmvCuWAR2KIZo3qzc3dusz6pAPbujEuXTorDKYpcN7H9CndS+reV4w8a2wdDRpnNVFfv
         w9yQ==
X-Gm-Message-State: AGRZ1gLdl87RdBk7tlK87sx1r6qJECZVGPAxVZhflMRQCZOlG613x52F
        SLwqgGtooW5wuQlK38lblfs=
X-Google-Smtp-Source: AJdET5efTxrCro1ZJSpKkBkpo045gTL6llaTyKUDzW8dQTr4THGikdXR+xtcpB1y+UPnuq5OdGAR+g==
X-Received: by 2002:a1c:e583:: with SMTP id c125-v6mr487323wmh.134.1540940852455;
        Tue, 30 Oct 2018 16:07:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v11-v6sm16289678wrw.3.2018.10.30.16.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 16:07:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
References: <20181030191608.18716-1-peartben@gmail.com>
Date:   Wed, 31 Oct 2018 08:07:30 +0900
In-Reply-To: <20181030191608.18716-1-peartben@gmail.com> (Ben Peart's message
        of "Tue, 30 Oct 2018 15:16:08 -0400")
Message-ID: <xmqqsh0nyqx9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> diff --git a/config.c b/config.c
> index 4051e38823..96e05ee0f1 100644
> --- a/config.c
> +++ b/config.c
> ...
> @@ -2307,6 +2311,37 @@ int git_config_get_index_threads(void)
>  	return 0; /* auto */
>  }
>  
> +int git_config_get_virtualfilesystem(void)
> +{
> +	if (git_config_get_pathname("core.virtualfilesystem", &core_virtualfilesystem))
> +		core_virtualfilesystem = getenv("GIT_TEST_VIRTUALFILESYSTEM");
> +
> +	if (core_virtualfilesystem && !*core_virtualfilesystem)
> +		core_virtualfilesystem = NULL;
> +
> +	if (core_virtualfilesystem) {
> +		/*
> +		 * Some git commands spawn helpers and redirect the index to a different
> +		 * location.  These include "difftool -d" and the sequencer
> +		 * (i.e. `git rebase -i`, `git cherry-pick` and `git revert`) and others.
> +		 * In those instances we don't want to update their temporary index with
> +		 * our virtualization data.
> +		 */
> +		char *default_index_file = xstrfmt("%s/%s", the_repository->gitdir, "index");
> +		int should_run_hook = !strcmp(default_index_file, the_repository->index_file);
> +
> +		free(default_index_file);
> +		if (should_run_hook) {
> +			/* virtual file system relies on the sparse checkout logic so force it on */
> +			core_apply_sparse_checkout = 1;
> +			return 1;
> +		}
> +		core_virtualfilesystem = NULL;

It would be a small leak if this came from config_get_pathname(),
but if it came from $GIT_TEST_VFS env, we cannot free it X-<.

A helper function called *_get_X() that does not return X as its
return value or updating the location pointed by its *dst parameter,
and instead only stores its finding in a global variable feels
somewhat odd.  It smells more like "find out", "probe", "check",
etc.

> diff --git a/dir.c b/dir.c
> index 47c2fca8dc..3097b0e446 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -21,6 +21,7 @@
>  #include "ewah/ewok.h"
>  #include "fsmonitor.h"
>  #include "submodule-config.h"
> +#include "virtualfilesystem.h"
>  
>  /*
>   * Tells read_directory_recursive how a file or directory should be treated.
> @@ -1109,6 +1110,18 @@ int is_excluded_from_list(const char *pathname,
>  			  struct exclude_list *el, struct index_state *istate)
>  {
>  	struct exclude *exclude;
> +
> +	/*
> +	 * The virtual file system data is used to prevent git from traversing
> +	 * any part of the tree that is not in the virtual file system.  Return
> +	 * 1 to exclude the entry if it is not found in the virtual file system,
> +	 * else fall through to the regular excludes logic as it may further exclude.
> +	 */

This comment will sit better immediately in front of the call to "is
excluded from vfs?" helper function.

> +	if (*dtype == DT_UNKNOWN)
> +		*dtype = get_dtype(NULL, istate, pathname, pathlen);

We try to defer paying cost to determine unknown *dtype as late as
possible by having this call in last_exclude_matching_from_list(),
and not here.  If we are doing this, we probably should update the
callpaths that call last_exclude_matching_from_list() to make the
caller responsible for doing get_dtype() and drop the lazy finding
of dtype from the callee.  Alternatively, the new "is excluded from
vfs" helper can learn to do the lazy get_dtype() just like the
existing last_exclude_matching_from_list() does.  I suspect the
latter may be simpler.

> +	if (is_excluded_from_virtualfilesystem(pathname, pathlen, *dtype) > 0)
> +		return 1;
> +
>  	exclude = last_exclude_matching_from_list(pathname, pathlen, basename,
>  						  dtype, el, istate);
>  	if (exclude)
> @@ -1324,8 +1337,20 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
>  int is_excluded(struct dir_struct *dir, struct index_state *istate,
>  		const char *pathname, int *dtype_p)
>  {
> -	struct exclude *exclude =
> -		last_exclude_matching(dir, istate, pathname, dtype_p);
> +	struct exclude *exclude;
> +
> +	/*
> +	 * The virtual file system data is used to prevent git from traversing
> +	 * any part of the tree that is not in the virtual file system.  Return
> +	 * 1 to exclude the entry if it is not found in the virtual file system,
> +	 * else fall through to the regular excludes logic as it may further exclude.
> +	 */
> +	if (*dtype_p == DT_UNKNOWN)
> +		*dtype_p = get_dtype(NULL, istate, pathname, strlen(pathname));

Exactly the same comment as above.

> +	if (is_excluded_from_virtualfilesystem(pathname, strlen(pathname), *dtype_p) > 0)
> +		return 1;
> +
> +	exclude = last_exclude_matching(dir, istate, pathname, dtype_p);
>  	if (exclude)
>  		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
>  	return 0;
> @@ -1678,6 +1703,9 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
>  	if (dtype != DT_DIR && has_path_in_index)
>  		return path_none;
>  
> +	if (is_excluded_from_virtualfilesystem(path->buf, path->len, dtype) > 0)
> +		return path_excluded;
> +
>  	/*
>  	 * When we are looking at a directory P in the working tree,
>  	 * there are three cases:
> @@ -2018,6 +2046,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  		/* add the path to the appropriate result list */
>  		switch (state) {
>  		case path_excluded:
> +			if (is_excluded_from_virtualfilesystem(path.buf, path.len, DT_DIR) > 0)
> +				break;
>  			if (dir->flags & DIR_SHOW_IGNORED)
>  				dir_add_name(dir, istate, path.buf, path.len);
>  			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||

I am kind-of surprised that the "damage" to dir.c need to support
this is so isolated and small ;-)

> ...
> +if test "$1" != 1
> +then
> +	echo "Unsupported core.virtualfilesystem hook version." >&2
> +	exit 1
> +fi
> +
> +#find -type f -printf '%P\0'
> +find -type d -printf '%P/\0'

I am not reading (hence not commenting on) tests in this review
message yet.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 7570df481b..ee3cda2e94 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -18,6 +18,7 @@
>  #include "fsmonitor.h"
>  #include "object-store.h"
>  #include "fetch-object.h"
> +#include "virtualfilesystem.h"
>  
>  /*
>   * Error messages expected by scripts out of plumbing commands such as
> @@ -1363,6 +1364,14 @@ static int clear_ce_flags_1(struct index_state *istate,
>  			continue;
>  		}
>  
> +		/* if it's not in the virtual file system, exit early */
> +		if (core_virtualfilesystem) {
> +			if (is_included_in_virtualfilesystem(ce->name, ce->ce_namelen) > 0)
> +				ce->ce_flags &= ~clear_mask;
> +			cache++;
> +			continue;
> +		}

Earlier we saw "is it excluded?" and now we have "is it included?"
They have different function signature (i.e. "included?" does not
need to know the type of the entry), and I am guessing that for the
purpose of this particular patch that may be sufficient, but I have
to wonder if in the longer term we'd be better off to keep the
interface to these two functions similar.  Also, I wonder if we need
both---I see below that these "is included/excluded?" helpers are
allowed to say "I dunno", so that may be the reason why we cannot
simply say "included is the same as !excluded".

