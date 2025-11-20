Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D42E8B6C
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622285; cv=none; b=GC+WBKKxviRjHPMuQ6wJXbTQbmZ7VPTz61Ow2ZcSi8qOYs9FOxGDo79qcoW4tSOmGOO4B5a3PYhroKUWiQ+/x89fe4cXQW2pK/jxkw32B2MCYcMCcZd9Ri7xqRG/esCZxTuNcvpWoZOcDzVxIAsYhu0iuPgOiR9q2lQLWzb+CEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622285; c=relaxed/simple;
	bh=fvSCnibZeyhEZGqsyVwm/7kocgD/ixZ2LlJvy+omKc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiFTbnaWqZlPb6a+x8/j+/+Za14YifVEOoJ0nnsH+N8GBqcvGdjRB5nn/UKnn2KhotksXFtg6YxUSphCQ9niUyDkbR73hzeBSa603HbalxFfb1UHX5L/aK9kxdTXrb7csePKDEVkQ0K3XVtUvwLtBQHT3dMHrIU92rIsH7rVW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4zyEW4D; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4zyEW4D"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-948fbdbc79fso12327939f.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622283; x=1764227083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PesfxbLBMRrYOvT7rSkqKuI6jcM5sf/FXabhvlursDo=;
        b=b4zyEW4DHqbbNuLOUKJjWzGCuYUDfnQ27aGDTZGoFwFrsQY04B3PBdySEJuhIHkrUr
         4FMkjkzn3CUmgHrbrPU2Aj5X/7vDvaD6/Q60+ZeNu2B+4o0v1WLxsme6K8zbQxbQGqav
         HjMpyd7ZDus74sqjFrt0uh/Xa1cXr0JlccxOcOngBGyw5gXxqxprKnQRZt5gJ6eBPhh2
         LZOoFMliX5WaHurmbyWXTW+Kv66UF0yHiVz75559bK7tpAKSMwCm4YwAb161D/IZPaPE
         LOTQLk3vxARC5997uT9G8/wN+ohjOUXC5cqnpyR14FHqnW7hzp+k4ALwr65fK2ea2a7/
         rvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622283; x=1764227083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PesfxbLBMRrYOvT7rSkqKuI6jcM5sf/FXabhvlursDo=;
        b=ce2QoOSHxuoLj5FCjynPNI0cqGMmVXli5hD21f0WDqT6kf45w37YMu57QB15TR79s9
         44nhU2QKObrgqLppzmKfXzy/i/u98RQIlz6bT1xSlJ0p1UYeF/VRcUR2qwxkPkeYPxIp
         2CYOTGLGWREK9kzb7zqamtqBc6AbmGJYIo3OFKDGwM4dsWlbE0gmhd/Z4dCyAjkFTIj9
         FARQ06zf0UJpIZvNudKR8f7hVWHQHzUTNELRcF0piFEWTde2SgE/mrvz4nu3VRdeYuok
         hbRPKzKLzIZWCEm9snxq3noJ8DIJq3DChufHTD/A7L5aD5YwFlBaKDC8KgTwFILvWIkB
         chNA==
X-Gm-Message-State: AOJu0YwiP53Sh54Sggx8+0RuOHnO2l2ZWQh8McXsP7xtJcuidIZ7iJlt
	ZT2gY5bbSCihsarcfeetMsYQnHA3aWnR5ecE6pdKrFMJui62l3tbHT5mTvTROXHEWQpaTu9ryJ2
	AVZyaM5QhSfEvFrcBx8jG2sj65q0j0zc=
X-Gm-Gg: ASbGncv8vPp8EhyecdEEvJ4sYeHcygIoSruGl6w3fYRqe6pEvWXBbj9NWnooH52j6Yk
	ib6J30hpDzRYQ+wLuqVnRNvqNVCYxVcxnTF81WRlmv+yEq4gYSLyCICUoOlOOuDhKs5cr83qWWt
	m5hlZ+TKkh7ebP90PWjY3UxNQ0UBA4tZd5BflrKkFLjTdwLktzI5ZaZoYzwFIPNzM7SztitwoAw
	3ekUGKvsEnJIQoMo+xUlzZaYueHY7rNRHHIy+WKdj7vxlJ33AtNCSK02jPvRsM4ye5wnbSdNN0R
	ZApVK9/jkTP/MNkZvQDA4IFz5liLxPIql6LXh6k=
X-Google-Smtp-Source: AGHT+IHoJvHQNytVDczzpLLQeqUtrI/vc9DsXorJkrffjvt+jgQFKbVRAlJJqxSlR158kTVtPtb6GmxcqfkE4XZCzdU=
X-Received: by 2002:a05:6638:8505:b0:5b7:b9bb:e71 with SMTP id
 8926c6da1cb9f-5b954154346mr1714801173.15.1763622282911; Wed, 19 Nov 2025
 23:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im> <20251027-b4-pks-history-builtin-v6-10-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-10-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:04:31 -0800
X-Gm-Features: AWmQ_bkkOoj2IES0GsFEmazjZ8vmvIpQcX0JDQEAmzx5W9ZMRRalpUa-xpM0F3A
Message-ID: <CABPp-BGLbOiT6X=U7KK2nusdmvYmWgfrN1W2Df8uNqB3+hg7mQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/11] cache-tree: allow writing in-memory index as tree
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> The function `write_in_core_index_as_tree()` takes a repository and
> writes its index into a tree object. What this function cannot do though
> is to take an _arbitrary_ in-memory index.
>
> Introduce a new `struct index_state` parameter so that the caller can
> pass a different index than the one belonging to the repository. This
> will be used in a subsequent commit.

Make sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/checkout.c | 3 ++-
>  cache-tree.c       | 5 ++---
>  cache-tree.h       | 3 ++-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index d230b1f8995..0b90f398feb 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -902,7 +902,8 @@ static int merge_working_tree(const struct checkout_o=
pts *opts,
>                                            0);
>                         init_ui_merge_options(&o, the_repository);
>                         o.verbosity =3D 0;
> -                       work =3D write_in_core_index_as_tree(the_reposito=
ry);
> +                       work =3D write_in_core_index_as_tree(the_reposito=
ry,
> +                                                          the_repository=
->index);
>
>                         ret =3D reset_tree(new_tree,
>                                          opts, 1,
> diff --git a/cache-tree.c b/cache-tree.c
> index 2aba47060e9..b67d0d703d2 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -699,11 +699,11 @@ static int write_index_as_tree_internal(struct obje=
ct_id *oid,
>         return 0;
>  }
>
> -struct tree* write_in_core_index_as_tree(struct repository *repo) {
> +struct tree *write_in_core_index_as_tree(struct repository *repo,
> +                                        struct index_state *index_state)=
 {
>         struct object_id o;
>         int was_valid, ret;
>
> -       struct index_state *index_state =3D repo->index;
>         was_valid =3D index_state->cache_tree &&
>                     cache_tree_fully_valid(index_state->cache_tree);
>
> @@ -723,7 +723,6 @@ struct tree* write_in_core_index_as_tree(struct repos=
itory *repo) {
>         return lookup_tree(repo, &index_state->cache_tree->oid);
>  }
>
> -

Why the random whitespace change?

>  int write_index_as_tree(struct object_id *oid, struct index_state *index=
_state, const char *index_path, int flags, const char *prefix)
>  {
>         int entries, was_valid;
> diff --git a/cache-tree.h b/cache-tree.h
> index b82c4963e7c..f8bddae5235 100644
> --- a/cache-tree.h
> +++ b/cache-tree.h
> @@ -47,7 +47,8 @@ int cache_tree_verify(struct repository *, struct index=
_state *);
>  #define WRITE_TREE_UNMERGED_INDEX (-2)
>  #define WRITE_TREE_PREFIX_ERROR (-3)
>
> -struct tree* write_in_core_index_as_tree(struct repository *repo);
> +struct tree *write_in_core_index_as_tree(struct repository *repo,
> +                                        struct index_state *index_state)=
;
>  int write_index_as_tree(struct object_id *oid, struct index_state *index=
_state, const char *index_path, int flags, const char *prefix);
>  void prime_cache_tree(struct repository *, struct index_state *, struct =
tree *);
>
>
> --
> 2.51.1.930.gacf6e81ea2.dirty

Looks good other than the random whitespace change.
