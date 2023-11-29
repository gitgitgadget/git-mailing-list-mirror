Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UAKdEPiz"
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC3170E
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 13:45:02 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-423f4a6144fso1590671cf.0
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 13:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701294302; x=1701899102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3FXFMCGgMc4SEBFo9pGF14PMf9ubfdNKpSimFPvbUw=;
        b=UAKdEPiz4Ky0SgC4W5xqRIZGHYmvO5Ip1FEMwu53Xk7oTG0IrU6ROyi9ClXF4T2xeC
         xWmPMrwSu8Zt62xFISgM3nOHTkxconCFf80m29Ir1wtbTcChEQm5Xx6ofLWZc61a2ErB
         hbQFH0a19/snj78wxP7z5vDAp2kxyT1GkVJTwEv+onC28bTRkLezk9uECxUJaZ+YMswM
         4WMw2jaMkgcU8N4wlozA5tfRZBxAXIuJbFMVmgE3P7OWp33bRTFC8L4tYAOLCFl//71x
         Ci49mNggl/UrMe49jWT/T4TNKJLx1OZASn9M5/6ZI1AtDQjbtuaOGNANQbDdjOuXrab7
         ft8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294302; x=1701899102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3FXFMCGgMc4SEBFo9pGF14PMf9ubfdNKpSimFPvbUw=;
        b=QfqluDXtgxATK/YDJzaIcUwsAOzDvFbx0WtatmAaH8ZjaVFKewdwCaszB7tAb9sDDl
         Zud+jtPEdijMgH6tTJbE9XDSX7PSWWnZo42ALuhIUIjz0CoiY7JPrTZQowBvjuQ1mO/u
         ZSnLNSr6YFtCgRVy9awCz1WOTOfbtAsBoeY4004uZhjW9Fm0HyLqKhcYr9YmAkA2R16f
         GWLCrzvYFXW/xGoyKkn5FV6WsV7Xzd0dnK21P4D9PbDbv7MyzmBkVraHKZYp5g4EHxV6
         olZHD8i1t2tsAvU9SOknjJT1T9xIOv0RrHfsKzfRY4Kwudnr0LgxKz/1kh09Yexn+5Rk
         T/FA==
X-Gm-Message-State: AOJu0Yyy+RzHIKWLgLszPAJtAt+pkpv66tM6YcpOU7bTBfTKpE6GsbXW
	tkFF9WRw9+qEReAey5ysvX67HjjYc1bLJfP3WE0=
X-Google-Smtp-Source: AGHT+IF0mD2KbhbUXOtUmCEtrtfX+xkDKPK+1LEDAo1aSRI8/5NuEzYkXotyIlngVfEGRZVfYk1jUQ==
X-Received: by 2002:ac8:5e47:0:b0:412:395c:e794 with SMTP id i7-20020ac85e47000000b00412395ce794mr24703181qtx.50.1701294301769;
        Wed, 29 Nov 2023 13:45:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id gc4-20020a05622a59c400b00423f08bf12bsm691592qtb.63.2023.11.29.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:45:01 -0800 (PST)
Date: Wed, 29 Nov 2023 16:45:00 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
Message-ID: <ZWew3CP4QJ4XDnHj@nand.local>
References: <cover.1701243201.git.ps@pks.im>
 <35b74eb972eed7e08190e826fabcf6b7a241f285.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35b74eb972eed7e08190e826fabcf6b7a241f285.1701243201.git.ps@pks.im>

On Wed, Nov 29, 2023 at 09:14:12AM +0100, Patrick Steinhardt wrote:
> We read both the HEAD and ORIG_HEAD references directly from the
> filesystem in order to figure out whether we're currently splitting a
> commit. If both of the following are true:
>
>   - HEAD points to the same object as "rebase-merge/amend".
>
>   - ORIG_HEAD points to the same object as "rebase-merge/orig-head".
>
> Then we are currently splitting commits.
>
> The current code only works by chance because we only have a single
> reference backend implementation. Refactor it to instead read both refs
> via the refdb layer so that we'll also be compatible with alternate
> reference backends.
>
> Note that we pass `RESOLVE_REF_NO_RECURSE` to `read_ref_full()`. This is
> because we didn't resolve symrefs before either, and in practice none of
> the refs in "rebase-merge/" would be symbolic. We thus don't want to
> resolve symrefs with the new code either to retain the old behaviour.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  wt-status.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 9f45bf6949..fe9e590b80 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1295,26 +1295,27 @@ static char *read_line_from_git_path(const char *filename)
>  static int split_commit_in_progress(struct wt_status *s)
>  {
>  	int split_in_progress = 0;
> -	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
> +	struct object_id head_oid, orig_head_oid;
> +	char *rebase_amend, *rebase_orig_head;
>
>  	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
>  	    !s->branch || strcmp(s->branch, "HEAD"))
>  		return 0;
>
> -	head = read_line_from_git_path("HEAD");
> -	orig_head = read_line_from_git_path("ORIG_HEAD");
> +	if (read_ref_full("HEAD", RESOLVE_REF_NO_RECURSE, &head_oid, NULL) ||
> +	    read_ref_full("ORIG_HEAD", RESOLVE_REF_NO_RECURSE, &orig_head_oid, NULL))

Switching to read_ref_full() here is going to have some slightly
different behavior than just reading out the contents of
"$GIT_DIR/HEAD", but I think that it should be OK.

Before we would not have complained, if, for example, the contents of
"$GIT_DIR/HEAD" were malformed, but now we will. I think that's OK,
especially given that if that file is bogus, we'll have other problems
before we get here ;-).

Are there any other gotchas that we should be thinking about?

> +		return 0;
> +
>  	rebase_amend = read_line_from_git_path("rebase-merge/amend");
>  	rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
>
> -	if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
> +	if (!rebase_amend || !rebase_orig_head)
>  		; /* fall through, no split in progress */
>  	else if (!strcmp(rebase_amend, rebase_orig_head))
> -		split_in_progress = !!strcmp(head, rebase_amend);
> -	else if (strcmp(orig_head, rebase_orig_head))
> +		split_in_progress = !!strcmp(oid_to_hex(&head_oid), rebase_amend);
> +	else if (strcmp(oid_to_hex(&orig_head_oid), rebase_orig_head))

I did a double take at these strcmp(oid_to_hex(...)) calls, but I think
that they are the best that we can do given that we're still reading the
contents of "rebase-merge/amend" and "rebase-merge/orig-head" directly.

I suppose we could go the other way and turn their contents into
object_ids and then use oidcmp(), but it doesn't seem worth it IMHO.

Thanks,
Taylor
