Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE152416D1B
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191997; cv=none; b=L92BwAJPlSSDJCaK0fgEpN02VQ1TeeAOLEzNRGBaxBE4yK3OF5Cjn8CMd2vHPHsAufjKCD0v1LuYzpnmOAytVqrZKBETnuvnR/247ezDz0wnDtlEu41H5hyDNl97TGC2Qioskuwylo9MAyHkm+Yri+r5KE/yt7QR92t1Bac6hko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191997; c=relaxed/simple;
	bh=9uJPiZgkkq49TYh62zLP9Hv1psmujNezT8yDQY3L0Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJOF+4tV5irL/oAtEYXA/dj5qHoJzBqB0C6qpN0X7BkZIEqUDklG/RdrDD93fTBKGJNu5ig3mHH+MdBlp+urM8JsXZNbOyaE2q4PFu7gNxuHeXNXsaCqixR6RBsUYzL0rC/Gkaw0gaHBDrRXKjp9RZr5N9disDT4+6zHopGiMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUzyeBXA; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUzyeBXA"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43d23173511so30592fac.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781191988; x=1781796788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0V7SGdVBMmu1KqeMBmODxPrfAhG7U0mkKXFzVSOdvEE=;
        b=cUzyeBXAfkauhecEIARO7I4DglJHd2xvAMIv3ZkPlzQjlzU7SE/6rQzzAvQomWnL7g
         TIp1Q+KDQRLs8lR0ksjk34/txwWgJAOxSvBChRTDgpO5qmxScjI7dIaGt+NBLktXu6iV
         2AJ+DoEYU8o2xtCa377vUd2NJrzdqMyQdcdIz05op25jL4varUMjenxWmbrMv2+kO4t6
         x3zE5SMfYD/35lfujmcRut6Jp3h2FPE0lsUwuCVvie3/tRZgi+bdYSDEgaNjWQd203V5
         CJMvma3GiMRaE1cZ2TwVwJ3RRPASx+JqhNBkZmrvqLQsCGE7ws6rfRImGU7pspsU9nUp
         jcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781191988; x=1781796788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V7SGdVBMmu1KqeMBmODxPrfAhG7U0mkKXFzVSOdvEE=;
        b=FnZo8e/w4DEHBsovYPIn/o98ePCjnhItfWZQZQc5gNtk+v7NPQe1taRLZGXimQ3Spd
         6coodUY7+5rt4kA0PdT5iGxz89QAgomBPhzyq0HcR+9t9wuqXsnDzL22Y9lOx3AiISIJ
         FAxCTfHmKkQx5dn3pxL8WrzDyY2tDEbpuY6HTmedq4CGHNslBCgjzKbWkx/4TJrVUKrn
         vzCHMCkekPeHeuiHx4rC2zY4sfaOogz9lscjGotNc2h9/1gPbTpnS0La6LUVT5IMi2vK
         XPXcnUlJ5Y8lg2ZhG2Qm63iGuXPCftlOYjI7xO0RbjGnTMDjsU8IqAKYGtwcK5qm0fNN
         RnKQ==
X-Gm-Message-State: AOJu0YzySB3IXk6Klt00b2K0BN/mNOxXGJgcrWVw/hsXvoCIUlkqAey8
	qTkmIb2Jn7//ZMHKMxJKdKBde5lhqSufBFXmvJbmK+irLdte94CkKPIhE6WN6g==
X-Gm-Gg: Acq92OHSxbfLYJ+ZqUfMpPSqVr5i8A9XHOfnWR8Qz8zAJUBJdlEXOWfhmxoElvY9aOD
	9iRX6+9cOqzyoCbP/MiH1Vxkz1LGsdBsE+vLKRKJZOzggwwweyc3ekNs+20NH6emaPX6bSGTgJY
	eFYFUVMQPEey6AbJndynfhI0iXp7ArS02JBP581GmSog91bQct77kMTn64gENfI8W8WKjzw4SDW
	h5RF7X4ZWfpH4+niQOTmYTFITiEZ4jJcpIiITE69Ib1TyMNxc0yL3rkIx+2v7F3tk59DWex31qX
	DucI5dcOMmg0s2zNERIeEHV86AS98mknKvArkZhwQ5pJh1WDiLNRiuP6jT2AnFmu1VJ/v4EC4WS
	zurALHD+ybiywfkZVXCBou2LGJQ2OCTI1r45pL7qM4eI5td7edOa9f7QFz0O/Q3IUayTapYbSTV
	CJqkHBLW6XufwPNXtml/R+JGsjrhU=
X-Received: by 2002:a05:6870:d294:b0:43d:a174:b8d0 with SMTP id 586e51a60fabf-442419ca021mr1969763fac.14.1781191988403;
        Thu, 11 Jun 2026 08:33:08 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44244a8af29sm1414751fac.12.2026.06.11.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:33:07 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:33:04 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] environment: split up concerns of
 `is_bare_repository_cfg`
Message-ID: <airTpB8Pm6TYoMhx@denethor>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260610-b4-pks-setup-drop-global-state-v1-5-5dff3eec8f06@pks.im>
 <ainesoUOuhspKxHF@denethor>
 <aip9irJ7WBaICxDa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aip9irJ7WBaICxDa@pks.im>

On 26/06/11 11:19AM, Patrick Steinhardt wrote:
> On Wed, Jun 10, 2026 at 05:22:04PM -0500, Justin Tobler wrote:
> > On 26/06/10 08:56AM, Patrick Steinhardt wrote:
> > > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > > index 52aa92fb0a..566732c9f4 100644
> > > --- a/builtin/init-db.c
> > > +++ b/builtin/init-db.c
> > > @@ -81,7 +81,7 @@ int cmd_init_db(int argc,
> > >  	const char *template_dir = NULL;
> > >  	char *template_dir_to_free = NULL;
> > >  	unsigned int flags = 0;
> > > -	int bare = is_bare_repository_cfg;
> > > +	int bare = startup_info->force_bare_repository ? 1 : -1;
> > 
> > Any particular reason to continue mapping `force_bare_repository=false`
> > to -1? Or was this to just minimize changes?
> 
> The `-1` value doesn't mean "false", but it rather means "undecided".
> The effect of this is that "core.bare" will eventually override this.

Ok, so `bare` here is still ultimately a combination of
`force_bare_repository` and `bare_cfg`.

> > > diff --git a/setup.c b/setup.c
> > > index 71fc6b33da..2b690da8ca 100644
> > > --- a/setup.c
> > > +++ b/setup.c
> > > @@ -795,10 +795,16 @@ static int check_repository_format_gently(const char *gitdir,
> > >  		has_common = 0;
> > >  	}
> > >  
> > > -	if (!has_common) {
> > > -		if (candidate->is_bare != -1)
> > > -			is_bare_repository_cfg = candidate->is_bare;
> > > -	} else {
> > > +	if (startup_info->force_bare_repository) {
> > > +		candidate->is_bare = 1;
> > > +		FREE_AND_NULL(candidate->work_tree);
> > > +	} else if (has_common) {
> > > +		/*
> > > +		 * When sharing a common dir with another repository (e.g. a
> > > +		 * linked worktree), do not let this repository's config
> > > +		 * dictate bareness; it is inherited from the main worktree.
> > > +		 */
> > > +		candidate->is_bare = -1;
> > >  		FREE_AND_NULL(candidate->work_tree);
> > 
> > Previously, when there was a common dir, `candidate->work_tree` was left
> > untouched, but now we are expclicitly setting it. I'm not sure I fully
> > understand this change.
> 
> I cannot blame you. All of this logic is so unbelievably tangled and
> hard to follow.
> 
> In any case, I think you might have missed the fact that we `else if`
> branch is now `has_common` as compared to `!has_common`? To explain the
> different cases a bit:
> 
>   - When we have `force_bare_repository` we are being told that the
>     repository should be treated as bare. So we set `is_bare` and also
>     clear the work tree that may have been discovered.
> 
>   - When we have a commondir we know that we're in a worktree.
>     Previously we did nothing in this case, and that had the implicit
>     effect that `is_bare_repository_cfg` would remain at `-1`. So to
>     match that behaviour we have to also reset the candidate's bareness
>     to `-1`, so that we parse it via the repository's configuration at a
>     later point in time.
> 
>     The other part here is that we also reset `candidate->work_tree`.
>     This is because the expectation is that `$GIT_DIR/common` should
>     override any "core.worktree" settings. Quoting git-config(1):
> 
>         If GIT_COMMON_DIR environment variable is set, core.worktree is
>         ignored and not used for determining the root of working tree.
> 
>   - When we don't have a commondir we previosuly had to also adapt the
>     global `is_bare_repository_cfg` variable. This part is not necessary
>     anymore, so we basically just drop this case altogether.

Thanks for explaination. This make more sense now.

-Justin
