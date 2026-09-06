Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25826296
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712974; cv=none; b=XBBJjekH0uR7KJkjAcOan0GQbGvOlJtyEfSV5F6kHXKLz2WHEJZeZ3WYfSyET2M+y61UmIn88iypvdHT6iAvRx679WK/lGkBpZJVsTib3aVpfUtbDxK+iYUWuE9yOTmLRJbkSWMjt/DBI5qhQjgF4sTbt5KATfb0n6WzgYQroN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712974; c=relaxed/simple;
	bh=DHQwrTpqhKudnuhSypeZSizVU9vzV82BpWEuVhuL88U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTgdtBMbDp3UxbNkdUhD2Q84HxLv+BsGMSSm++BxrT5RFLzGQJUexj1J+J0ez3g9xKPTUTp0Lt/Xh0Wf8mj0+n6+N1i44Pp+x9iu4eAlyEz4BQhgNiL9V8Jvyxej8VB1Un5HiPX0j1VrXsgYZ74ML4UGlkgu+dM/QwOtJpD7rdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0xFU2ll; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0xFU2ll"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b28db31b89so1681436b6e.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788712972; x=1789317772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Q3rcZqFVDvCrRBK3Fq+cDG0qhueaUTo33nhSftLuRM=;
        b=K0xFU2llkmTO+FCB2kHrhUUjwXyNEt90o4/7+pC6mxgTFqRBTcJD3yNvQ9+Oo2H+I4
         v5fnIfkB3BGFDQsezicgfIAl48DjcKWJNF3RsyJvUxITzFLoRi0XhsPyqcQLTv+nPMC0
         Wzv21AY/Ub5s6ck6b4mysbDlu/l1WwQBVcc1kvW7nyY0mz85a41aNmcofKVUoI0thbp7
         rpUC5fEvA9GUOxZKCYXaHLFSbIq+qORZ/JyqADZhQmlRu5j3jf9GO7ZBGkJggiUg0Heq
         5bCrAooCu0uhokbKYePQn2TbnP7GIiVBE9ntbC1GNjSZ3YxUPJJSAo+zI5VkOGjXXA67
         Ks1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788712972; x=1789317772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Q3rcZqFVDvCrRBK3Fq+cDG0qhueaUTo33nhSftLuRM=;
        b=eGJpEfXhhwiBEmHKnyKq8GJ7MB/P8f+wgCwWWpm5vUp0pcSkm9oP5/a5dxO+ecSM3U
         JZ3+oSZCrye2kOrAmWfC76lse1kcmfYGwhtND1F60licNULWVTKuNr9nxkpD66WBApxq
         /rox4Rj73Y+VHY+M/gpFd8LV5L2gBu+x3rkgY5FCcK363sBV2AOiH8vQpJT7ekPzSkjn
         n1OKxU6dTIJnBaCswI5gSei4qkDxiFnH8h0/4yaroWVWW6B5HA6SDOaf6sXd+Yevu1yU
         VAmob8orlp3+v4sr6ug3FXpF0gs2fwuVXj/ckqxoVXZ2YPZOBW+D5N8ddohk0aGoItOB
         X88A==
X-Gm-Message-State: AFuF++kuZU6SP7gBCsdNt/M78fYiEBvoIgA8fGv4SOXauEkFJ+XY0UNb
	7tg8NYWbSfhIVpGG72ccHV8TieJO596GvoQfPNZkE8WwlKju8TCTd3GL
X-Gm-Gg: AYBFou0+3vPSRooHf+Z84JJJF588fFCgMRjwK1NTmVq0HQdIn5ZnRlIF6XcdPNofGmw
	m8MBfRKKcBALNg9NHk4eFXE51CAl3k8zkucuy96JbLyeMh+3W0izZ28zctW+RYeVe3RjOr14Ka7
	8D5Vd/WrbHzLZiH/mSr4UMl6giX35mTApgQlMlFTIewC9f3hEWcRqoAq7qvmjdBi/6/BBDW6FAv
	6eWncmETC2vFrD/w5Jh7f13h4D56LISqe67E6MFlNG2xyDKaWeihLtvs2+o+u1sgFo76ts6SxVk
	qSGlkcAbLOzPlOpgdAELzBipXgxFuaNFBQUBiT9dTU3BEtER7XNEqFIkYNduurfZ0Ql/hLrYEek
	K8YyvqHAnPbfnLkX4OCBPRY1JfTuobxd0Qc+/otloPPzei3t8qvmcTVO+98HKvmeOYPN60agIfg
	YQCJIfdCn0TlP1YeFVg6vaSCUs1XBsldb4PvSgNLZxVP957hkl0cunTzSXqQcnHnf7zFIrd25u7
	wAuxRCdI6p/hQ==
X-Received: by 2002:a05:6808:1907:b0:4b3:77da:2b9c with SMTP id 5614622812f47-4b961a7ba19mr13937521b6e.12.1788712972145;
        Sun, 06 Sep 2026 09:42:52 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b96babc2c3sm9382166b6e.0.2026.09.06.09.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:42:51 -0700 (PDT)
Date: Sun, 6 Sep 2026 11:42:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] builtin/clone: defer setup of the object database
Message-ID: <ap2URrS4i-nHV5cB@denethor>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
 <20260831-pks-odb-write-alternates-at-creation-time-v2-1-aecd2382ba1c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-1-aecd2382ba1c@pks.im>

On 26/08/31 12:02PM, Patrick Steinhardt wrote:
> When cloning a repository we defer initialization of the reference
> database. This is because we don't yet know all details required for us
> to initialize the refdb in the first place. Most importantly, what we
> are missing is information about the object hash.
> 
> We don't do the same thing for the object database yet, but here we
> essentially have the same problem. While the "files" database does not
> need any information about the object format at creation time, alternate
> backends are likely to require that information so that they can
> properly set up their data structures.

Ok, so if we want to move the writing of alternates to happen at ODB
creation time, this information will be needed ahead of time.

> Besides this forward-looking future proofing though, we also have a
> second use case for deferring initialization of the object database,
> namely alternates. When initializing the object database we do not yet
> know whether we'll need alternates or not because this depends on the
> repository we're about to clone from. If it is a local repository and
> the user has passed "--refernce{,-if-able}", then we will end up writing
> alternates into the object database.
> 
> The ugly part though is that we cannot determine where the repository is
> getting cloned from before it has been initialized. While we of course
> already have access to the user-provided URI, that URI can be very well
> rewritten via "url.<base>.insteadOf". We can of course read the global-
> and system-level configuration to resolve it. But we explicitly resolve
> the URI a second time after we have initialized the repository because
> it can happen that we copy a ".git/config" over from our templates, and
> that file may cause us to rewrite the path.
> 
> In a subsequent commit though we'll start to write alternates as part of
> the repository initialization, so we'll need to have the URI properly
> resolved before we can initialize the object database. This is ugly, but
> as mentioned above it makes sense for us to defer its initialization
> anyway so that we also know about the object hash already.

Ok.

> Introduce a new flag that makes `init_db()` skip initializing the object
> database. Expose `create_object_database()` and make use of it after we
> have resolved the URI.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c | 12 ++++++++----
>  setup.c         |  8 +++++---
>  setup.h         | 15 ++++++++++-----
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5b25cca510..0a67492ebd 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1184,11 +1184,14 @@ int cmd_clone(int argc,
>  	 * database. We do not yet know about the object format of the
>  	 * repository, and reference backends may persist that information into
>  	 * their on-disk data structures.
> +	 *
> +	 * Furthermore, we skip initializing the object database so that we can
> +	 * first resolve potential alternates before creating it.
>  	 */
>  	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
>  		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
>  		do_not_override_repo_unix_permissions,
> -		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
> +		INIT_DB_QUIET | INIT_DB_SKIP_REFDB | INIT_DB_SKIP_ODB);

Ok, now we skip the initializing the ODB during init_db in favor of
delaying it to after we have the required config info. This makes sense
to me, but IMO the `init_db()` interface has grown quite awkward with
these "skip" flags. It appears that there are only two callers of
`init_db()` which makes me wonder if it would be simpler to just require
them to explicitly set up the ref DB and ODB.

>  	if (real_git_dir) {
>  		free((char *)git_dir);
> @@ -1311,9 +1314,6 @@ int cmd_clone(int argc,
>  		strbuf_reset(&key);
>  	}
>  
> -	if (option_required_reference.nr || option_optional_reference.nr)
> -		setup_reference();
> -
>  	remote = remote_get_early(remote_name);
>  
>  	if (!option_rev)
> @@ -1342,6 +1342,10 @@ int cmd_clone(int argc,
>  	if (option_local > 0 && !is_local)
>  		warning(_("--local is ignored"));
>  
> +	create_object_database(the_repository);

We now explicitly create the object database here.

> +	if (option_required_reference.nr || option_optional_reference.nr)
> +		setup_reference();

Any reason the reference setup is also further deferred here?

-Justin
