Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7E1F416E
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857165; cv=none; b=WK2kWT8AsX96oDRrqUtA9VhiSfO1ty4X+zCX2voa7VzpA4BbTrvaXI9ZhdxG4WiNU2bfVugJGpSrVEG9SweW2LCL/sMIvu+gBdzw8yzA2FneLjVLwR2YSD1Tw6so2TeVKQaBj/N0EeQ/OQ/TVnzpTQlAh3JfhXWysZYBDZQXksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857165; c=relaxed/simple;
	bh=vplUaK8r0ue0N4zIt19RTgU/ckAK0apfNA90um4uRb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPIqov1jrm91dRA7Z3GXGKSD7KwGiJfG+Cf+reRSfju48517G0R+Uo2l7q0Uwx1FvXLHQkyhiY28GWSpFBBnjhs8nXqfaPPjwDsvKWmtNUjDQTEjenKAGpieeEHyc8N0EJLNBc7ZhQ7J3015LENAlcAQb+WHEvtfPD2Y1CSho4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKs1SsLm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKs1SsLm"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa0c039d47so1178514a91.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738857162; x=1739461962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2q3NlNE69B0/WuOK/YkMNhMcmX5n0IQizMtVJab7Go=;
        b=QKs1SsLmWru/DfjinH+d8Z2akz/o9oTg1gxyHFATEASW5HJlbu+JWHmKrOspvxcq2b
         9IITrs5mltF4nU8pm1Qlqg5A7xWHfgBHR+gaPmqC+wM/gS18nvgBJGn2W2dZXzIRtnPu
         9DRM7qnmEvfxO1Qp+CZkRdNvy6vK4mJkvJn/8zmY/Vu+nwTeImR5R6zMuNMA9WXOuorn
         YMetdWN4BCUdDrOiHMJwJjep+5ztats4uMZiRwRIzxTWRzLKgBsPCCaJHZ+6ydecC30c
         MSUgEnImEBeA/KYEeGsb+JmlWvFOJgJAz8PaGVEkTVUgz8Aaz6Ph6KoPHb1UyLZixxTA
         MSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738857162; x=1739461962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2q3NlNE69B0/WuOK/YkMNhMcmX5n0IQizMtVJab7Go=;
        b=g+IcDN2Z0F4IeYZzQT1HtcHom7CL78KkZHtZkaJ4tkd4J6Cr8szoTGii7kehy2UbRX
         ka50VtCnKvM4pwWYrUSlRbWGW/uzNEOhN+fkzsJg5zAAppcGqCzsn+XuVbg0RuVseJxD
         phbQYpg0Yo//niYAJwP0SR4HsqUo/38RVyh7rjoGHDQVqZYRdwcbf9KsM1GD987bMefc
         g2kQm7rwaE0AamaO0rmb3MiJ4waRa9b84rRtSBCSlwxGSr8BOIAkKOcxlopVB1PBu1Xt
         QfT7BY9CW9+yDWChupoaJNc/vEgZ08ZwYoA2HbLJcnnfjVddgZ63v9xLKBs7j1K2/on/
         oVXA==
X-Gm-Message-State: AOJu0Yx8a5MUpMrTD/XRyUtujyV2CaVX+xlcLRCyfArmwabb+z9AwouL
	WUaaupczXVq79nHsJ+7CDyd7Obpwx69RNEm4ea2sbt2fLn+T6LbK8x82WA==
X-Gm-Gg: ASbGncu4ddrc6ZAhlKBRSHmPYkGuavy1e3Bk8FPgVbGm4Abh5MyHihEgcAVnR3evCmr
	nblQNai7wvLFUKEml9g2foTnD59U1WSFhA3pqDdO62ZyQVRewxvE9/Qr/WOrOz2h8y3kxsISZ06
	JVBji4dPrOUQ4/U/7TTw+DoWJpAm70TFgoaN1+SlSLEfaGaugpbAqAjllbkVsww85er4I0Z6TE4
	8tnFC3buQSmVRWdI4W3eIHTrn16U4wnF/DF0DaeYzu6nexid1LMBZeJclI9S218auSJcg==
X-Google-Smtp-Source: AGHT+IGL2ep8stOjGvqrzH/uQz/aNuiHAdXyQuQlMB41g8mwkzqiCKE+nLcs4455itvz6E/MBTpVWg==
X-Received: by 2002:a17:90b:44:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-2f9e0834927mr13118621a91.33.1738857162371;
        Thu, 06 Feb 2025 07:52:42 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fa09a4f875sm1686658a91.24.2025.02.06.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 07:52:41 -0800 (PST)
Date: Thu, 6 Feb 2025 23:54:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/16] path: drop `git_common_path()` in favor of
 `repo_common_path()`
Message-ID: <Z6TbMGcPftyhUyC3@ArchLinux>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-10-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-10-4e77f0313206@pks.im>

On Thu, Feb 06, 2025 at 08:58:06AM +0100, Patrick Steinhardt wrote:


> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 2cea9441a6..761e302a36 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -151,7 +151,7 @@ static int delete_git_dir(const char *id)
>  	struct strbuf sb = STRBUF_INIT;
>  	int ret;
>  
> -	strbuf_addstr(&sb, git_common_path("worktrees/%s", id));
> +	repo_common_path_append(the_repository, &sb, "worktrees/%s", id);
>  	ret = remove_dir_recursively(&sb, 0);
>  	if (ret < 0 && errno == ENOTDIR)
>  		ret = unlink(sb.buf);
> @@ -1102,6 +1102,7 @@ static int lock_worktree(int ac, const char **av, const char *prefix,
>  		OPT_END()
>  	};
>  	struct worktree **worktrees, *wt;
> +	char *path;
>  
>  	ac = parse_options(ac, av, prefix, options, git_worktree_lock_usage, 0);
>  	if (ac != 1)
> @@ -1122,9 +1123,11 @@ static int lock_worktree(int ac, const char **av, const char *prefix,
>  		die(_("'%s' is already locked"), av[0]);
>  	}
>  
> -	write_file(git_common_path("worktrees/%s/locked", wt->id),
> -		   "%s", reason);
> +	path = repo_common_path(the_repository, "worktrees/%s/locked", wt->id);

From my perspective, we may use `repo_common_path_replace` here to avoid
using the raw string pointer? This is because we return a changeable
pointer "char *". But we pass this pointer to a "const char *". This is
not critical, but we may make the semantics clearer.

> +	write_file(path, "%s", reason);
> +
>  	free_worktrees(worktrees);
> +	free(path);
>  	return 0;
>  }
>  
> @@ -1135,6 +1138,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix,
>  		OPT_END()
>  	};
>  	struct worktree **worktrees, *wt;
> +	char *path;
>  	int ret;
>  
>  	ac = parse_options(ac, av, prefix, options, git_worktree_unlock_usage, 0);
> @@ -1149,8 +1153,12 @@ static int unlock_worktree(int ac, const char **av, const char *prefix,
>  		die(_("The main working tree cannot be locked or unlocked"));
>  	if (!worktree_lock_reason(wt))
>  		die(_("'%s' is not locked"), av[0]);
> -	ret = unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id));
> +
> +	path = repo_common_path(the_repository, "worktrees/%s/locked", wt->id);

This one as above.

> +	ret = unlink_or_warn(path);
> +
>  	free_worktrees(worktrees);
> +	free(path);
>  	return ret;
>  }
>  
> diff --git a/path.c b/path.c
> index d721507be8..f6b795d75f 100644
> --- a/path.c
> +++ b/path.c
> @@ -634,10 +634,10 @@ const char *repo_submodule_path_replace(struct repository *repo,
>  	return buf->buf;
>  }
>  
> -void repo_common_pathv(const struct repository *repo,
> -		       struct strbuf *sb,
> -		       const char *fmt,
> -		       va_list args)
> +static void repo_common_pathv(const struct repository *repo,
> +			      struct strbuf *sb,
> +			      const char *fmt,
> +			      va_list args)
>  {
>  	strbuf_addstr(sb, repo->commondir);
>  	if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
> diff --git a/path.h b/path.h
> index 904eeac068..496f27fdfd 100644
> --- a/path.h
> +++ b/path.h
> @@ -233,29 +233,10 @@ struct strbuf *get_pathname(void);
>  #  include "repository.h"
>  
>  /* Internal implementation details that should not be used. */
> -void repo_common_pathv(const struct repository *repo,
> -		       struct strbuf *buf,
> -		       const char *fmt,
> -		       va_list args);

So, we finally mark this function "static" and delete the declaration in
this patch. We cannot do this in the earlier patch because
"git_common_path" is defined in the header file and it needs to use this
function. Make sense.

However, I somehow feel a little strange especially in [PATCH 01/16]
that you have added a comment:

    /* Internal implementation detail that should not be used. *

When I see this comment, my first intuitive thinking is that if we
should not use this function, why do we need to expose this in the first
place?

This really introduces confusion.

> @@ -343,7 +344,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
>  	if (!is_absolute_path(wt->path)) {
>  		strbuf_addf_gently(errmsg,
>  				   _("'%s' file does not contain absolute path to the working tree location"),
> -				   git_common_path("worktrees/%s/gitdir", wt->id));
> +				   repo_common_path_replace(the_repository, &buf, "worktrees/%s/gitdir", wt->id));
>  		goto done;
>  	}
>  
> @@ -365,14 +366,16 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
>  		goto done;
>  	}
>  
> -	strbuf_realpath(&realpath, git_common_path("worktrees/%s", wt->id), 1);
> +	strbuf_realpath(&realpath, repo_common_path_replace(the_repository, &buf, "worktrees/%s", wt->id), 1);

We rely on the return value of `repo_common_path_replace` to elegantly
do this. Make sense.

>  	ret = fspathcmp(path, realpath.buf);
>  
>  	if (ret)
>  		strbuf_addf_gently(errmsg, _("'%s' does not point back to '%s'"),
> -				   wt->path, git_common_path("worktrees/%s", wt->id));
> +				   wt->path, repo_common_path_replace(the_repository, &buf,
> +								      "worktrees/%s", wt->id));
>  done:
>  	free(path);
> +	strbuf_release(&buf);
>  	strbuf_release(&wt_path);
>  	strbuf_release(&realpath);
>  	return ret;
> @@ -384,11 +387,13 @@ void update_worktree_location(struct worktree *wt, const char *path_,
>  	struct strbuf path = STRBUF_INIT;
>  	struct strbuf dotgit = STRBUF_INIT;
>  	struct strbuf gitdir = STRBUF_INIT;
> +	char *wt_gitdir;
>  
>  	if (is_main_worktree(wt))
>  		BUG("can't relocate main worktree");
>  
> -	strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id), 1);
> +	wt_gitdir = repo_common_path(the_repository, "worktrees/%s/gitdir", wt->id);
> +	strbuf_realpath(&gitdir, wt_gitdir, 1);

Why we don't use above pattern which means the following:

    strbuf_realpath(&gitdir, git_common_path_replace(...), ...);

I think we should be consistent. And we should not use "char *" type to
pass to a "const char *" type here although this won't be harmful to the
program. However, git_common_path_replace will return a "const char *"
to make sure the caller cannot change this pointer.

>  	strbuf_realpath(&path, path_, 1);
>  	strbuf_addf(&dotgit, "%s/.git", path.buf);
>  	if (fspathcmp(wt->path, path.buf)) {
> @@ -400,6 +405,7 @@ void update_worktree_location(struct worktree *wt, const char *path_,
>  	strbuf_release(&path);
>  	strbuf_release(&dotgit);
>  	strbuf_release(&gitdir);
> +	free(wt_gitdir);
>  }
>  
>  int is_worktree_being_rebased(const struct worktree *wt,
> @@ -585,6 +591,7 @@ static void repair_gitfile(struct worktree *wt,
>  	struct strbuf backlink = STRBUF_INIT;
>  	char *dotgit_contents = NULL;
>  	const char *repair = NULL;
> +	char *path = NULL;
>  	int err;
>  
>  	/* missing worktree can't be repaired */
> @@ -596,7 +603,8 @@ static void repair_gitfile(struct worktree *wt,
>  		goto done;
>  	}
>  
> -	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
> +	path = repo_common_path(the_repository, "worktrees/%s", wt->id);
> +	strbuf_realpath(&repo, path, 1);

This one as above.

>  	strbuf_addf(&dotgit, "%s/.git", wt->path);
>  	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
>  	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
> @@ -626,6 +634,7 @@ static void repair_gitfile(struct worktree *wt,
>  
>  done:
>  	free(dotgit_contents);
> +	free(path);
>  	strbuf_release(&repo);
>  	strbuf_release(&dotgit);
>  	strbuf_release(&gitdir);
> @@ -657,11 +666,13 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
>  	struct strbuf gitdir = STRBUF_INIT;
>  	struct strbuf dotgit = STRBUF_INIT;
>  	int is_relative_path;
> +	char *path = NULL;
>  
>  	if (is_main_worktree(wt))
>  		goto done;
>  
> -	strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id), 1);
> +	path = repo_common_path(the_repository, "worktrees/%s/gitdir", wt->id);
> +	strbuf_realpath(&gitdir, path, 1);
>  

Also this one.

>  	if (strbuf_read_file(&dotgit, gitdir.buf, 0) < 0)
>  		goto done;
> @@ -680,6 +691,7 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
>  done:
>  	strbuf_release(&gitdir);
>  	strbuf_release(&dotgit);
> +	free(path);
>  }
>  
>  void repair_worktrees_after_gitdir_move(const char *old_path)
> @@ -871,7 +883,11 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
>  	ssize_t read_result;
>  
>  	*wtpath = NULL;
> -	strbuf_realpath(&repo, git_common_path("worktrees/%s", id), 1);
> +
> +	path = repo_common_path(the_repository, "worktrees/%s", id);
> +	strbuf_realpath(&repo, path, 1);
> +	FREE_AND_NULL(path);
> +

I somehow agree that we could use `repo_common_path` in this way where
we want to reuse "path" variable.

Thanks,
Jialuo
