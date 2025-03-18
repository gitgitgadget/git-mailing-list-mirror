Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06B4A07
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271239; cv=none; b=MOqxaJ7XdLfkRv7OlTLPxpKjTzZP14X2HvPUlMpTO3Pr/Kg27LtOBJVUPnrUjJsUfM9lm0mQSicy3cfbJVAhToUQBxm3egxk4OZneqOUGPBqTBu8hV4khBduOemFT5JiVhi5DKnMTTx4gRdMN0/OCCR+z7JH0bO834AJaO1N9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271239; c=relaxed/simple;
	bh=4C58WKZXTHZCo2SEQpzIrNzkjIV3+aMRp/fZzRVKCWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEYNg99oaVOJY1bNOQFi9FzFbEQCbZXz3FdJHSVZHElyfDIXwzd4dbw5PcqyoFoPh6Ww907tqiNRUL5RDdH2ceGDbnSomiAHevmhScG9j/xkvXAgG2wB3DnF08Smqwu9f+9I5auYzmyN28acYje9E0FfHntBXEeLQyJ3rMSXzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCKYnDBU; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCKYnDBU"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85da5a36679so494271739f.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 21:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742271237; x=1742876037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX6I0PasuSz60lnD+Mb30lkhH/7DVI5oWRc5MMYkGFU=;
        b=TCKYnDBUCGgX9kmioQ6/fDMnZ6+Y6ygi/p1wsReWvlveJCYORHgJpXV58yLtxAE7p5
         nu7KF5B2jtAFWbQxiYJ0kVACSEdhRmZlHgEY++yK7ordp75mlhBpIPN5uQqj9Gq93Q3A
         eM/7KK3EvstQjOkgVfzpFGDJmTJBGn5JR0yNeNOp3aFmrQcMf4+9HsT+RsBDIbe5svBT
         f6jp1zaqVWcfnCQU9ScYIW+u/TZzrDjP1HY52cI/9L+0PG2dC3GoJGqRqaWr9tJJAWC5
         MUrq474kWO8hJPd4JBa8Jxp4tK/9tcb+kZxofmX5h8a0wuRiaq1MVAdNmjOHErmJX3XF
         a3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271237; x=1742876037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX6I0PasuSz60lnD+Mb30lkhH/7DVI5oWRc5MMYkGFU=;
        b=pkTtR+GSvWgTlS/H8+TlPpSZ9u+bIK45hatuOxk9ofTeooLbY/5Ef0gy27qisCNegp
         mvz5sciQDR0lLbaxqE1MNiF+fhRznC8n5qjNfHbokzutijYukQgNr8iZcDdohPgkf3qU
         tePqIuWAcs0uKXiYsVxtlMaMBVqD69o+sW1QtOvBjjR+DlEvUr2/Pq2Js5rjpOn5MXAi
         LeBs57vuzcJAwa7sYq0yoI8ghLWj1XQgva4PL2uZIeH5LtVTCfFaNwJvd80r9Mu7fCMr
         cLeKKwq/frR/EsnIMvMJl6YnUd0y/FH+c1qMhKY9R2GCoCdaz/19/j5D2kH7uSgW15bl
         JUfw==
X-Gm-Message-State: AOJu0YyxTBcezI2h1uTPanKJfPZtPxHN97XZk8rBDcSC8jXTDyZHNKx8
	Ooq0DDJW/G0XiQQ3jnNRDDVNJRppo5IUpUZMAY3CpQlXqxCLk0yH+vjKA5fPQyTmzY2LmlwdtvA
	xGYPbMTEWirCFsYs6jsRLLLcLc7RWVA==
X-Gm-Gg: ASbGnctLYHkPo5E30LF6R3gACfSIZYeDfuxEyBoT02KIw7fRTerfzLl8dA0NZn0alip
	wsgxwr+tJpUlDDZ69GjhIul3i5P/M5vo7iuJbB3hdXcpgTd2wO2hLpkHOKX7pA9n1pXmqdG3boU
	4qrs8lSe64+RfyJvY/eGFY5ILl0i07rHroYNgDJGru4rk+dkSl4jNcGaLLrMs=
X-Google-Smtp-Source: AGHT+IEwnNctolKlc3hewKM8yUSra/682e4PnD0IB//Sp+iblTvAqNGPCLsGk8WAfDlGIoXA1zfJZmFewMqRHWog+oo=
X-Received: by 2002:a92:c263:0:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d483a09d10mr168175205ab.7.1742271236646; Mon, 17 Mar 2025
 21:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723755667.git.me@ttaylorr.com> <cover.1741983492.git.me@ttaylorr.com>
 <aca0318fb12499ea810d03e66cc3145d682f5098.1741983492.git.me@ttaylorr.com>
In-Reply-To: <aca0318fb12499ea810d03e66cc3145d682f5098.1741983492.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Mar 2025 21:13:45 -0700
X-Gm-Features: AQ5f1JqvPXXux5OS1wQ_elXKHW56s4-XkG2uq49muYhCPzm-HkfQZQEBHJeX0Ec
Message-ID: <CABPp-BHXYzMR61C=aX4yNn4QdgZ8uMtivg33oAN_eC3=J1U8kw@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] pack-bitmap.c: open and store incremental bitmap layers
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Prepare the pack-bitmap machinery to work with incremental MIDXs by
> adding a new "base" field to keep track of the bitmap index associated
> with the previous MIDX layer.
>
> The changes in this commit are mostly boilerplate to open the correct
> bitmap(s), add them to the chain bitmap layers along the "base" pointer,

s/chain/chain of/ ?

> ensures that the correct packs and their reverse indexes are loaded

s/ensures/ensure/ ?


> across MIDX layers, etc.
>
> While we're at it, keep track of a base_nr field to indicate how many
> bitmap layers (including the current bitmap) exist. This will be used in
> a future commit to allocate an array of 'struct ewah_bitmap' pointers to
> collect all of the respective type bitmaps among all layers to
> initialize a multi-EWAH iterator.
>
> Subsequent commits will teach the functions within the pack-bitmap
> machinery how to interact with these new fields.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap.c | 62 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 14 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index c26d85b5db..72fb11d014 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -54,6 +54,16 @@ struct bitmap_index {
>         struct packed_git *pack;
>         struct multi_pack_index *midx;
>
> +       /*
> +        * If using a multi-pack index chain, 'base' points to the
> +        * bitmap index corresponding to this bitmap's midx->base_midx.
> +        *
> +        * base_nr indicates how many layers precede this one, and is
> +        * zero when base is NULL.
> +        */
> +       struct bitmap_index *base;
> +       uint32_t base_nr;
> +
>         /* mmapped buffer of the whole bitmap index */
>         unsigned char *map;
>         size_t map_size; /* size of the mmaped buffer */
> @@ -386,8 +396,15 @@ static int load_bitmap_entries_v1(struct bitmap_inde=
x *index)
>  char *midx_bitmap_filename(struct multi_pack_index *midx)
>  {
>         struct strbuf buf =3D STRBUF_INIT;
> -       get_midx_filename_ext(midx->repo->hash_algo, &buf, midx->object_d=
ir,
> -                             get_midx_checksum(midx), MIDX_EXT_BITMAP);
> +       if (midx->has_chain)
> +               get_split_midx_filename_ext(midx->repo->hash_algo, &buf,
> +                                           midx->object_dir,
> +                                           get_midx_checksum(midx),
> +                                           MIDX_EXT_BITMAP);
> +       else
> +               get_midx_filename_ext(midx->repo->hash_algo, &buf,
> +                                     midx->object_dir, get_midx_checksum=
(midx),
> +                                     MIDX_EXT_BITMAP);
>
>         return strbuf_detach(&buf, NULL);
>  }
> @@ -454,16 +471,21 @@ static int open_midx_bitmap_1(struct bitmap_index *=
bitmap_git,
>                 goto cleanup;
>         }
>
> -       for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
> -               if (prepare_midx_pack(bitmap_repo(bitmap_git),
> -                                     bitmap_git->midx,
> -                                     i)) {
> +       for (i =3D 0; i < bitmap_git->midx->num_packs + bitmap_git->midx-=
>num_packs_in_base; i++) {
> +               if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git=
->midx, i)) {
>                         warning(_("could not open pack %s"),
>                                 bitmap_git->midx->pack_names[i]);
>                         goto cleanup;
>                 }
>         }
>
> +       if (midx->base_midx) {
> +               bitmap_git->base =3D prepare_midx_bitmap_git(midx->base_m=
idx);
> +               bitmap_git->base_nr =3D bitmap_git->base->base_nr + 1;
> +       } else {
> +               bitmap_git->base_nr =3D 0;
> +       }
> +
>         return 0;
>
>  cleanup:
> @@ -515,6 +537,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bi=
tmap_git, struct packed_git
>         bitmap_git->map_size =3D xsize_t(st.st_size);
>         bitmap_git->map =3D xmmap(NULL, bitmap_git->map_size, PROT_READ, =
MAP_PRIVATE, fd, 0);
>         bitmap_git->map_pos =3D 0;
> +       bitmap_git->base_nr =3D 0;
>         close(fd);
>
>         if (load_bitmap_header(bitmap_git) < 0) {
> @@ -534,8 +557,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bi=
tmap_git, struct packed_git
>  static int load_reverse_index(struct repository *r, struct bitmap_index =
*bitmap_git)
>  {
>         if (bitmap_is_midx(bitmap_git)) {
> -               uint32_t i;
> -               int ret;
> +               struct multi_pack_index *m;
>
>                 /*
>                  * The multi-pack-index's .rev file is already loaded via
> @@ -544,10 +566,15 @@ static int load_reverse_index(struct repository *r,=
 struct bitmap_index *bitmap_
>                  * But we still need to open the individual pack .rev fil=
es,
>                  * since we will need to make use of them in pack-objects=
.
>                  */
> -               for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
> -                       ret =3D load_pack_revindex(r, bitmap_git->midx->p=
acks[i]);
> -                       if (ret)
> -                               return ret;
> +               for (m =3D bitmap_git->midx; m; m =3D m->base_midx) {
> +                       uint32_t i;
> +                       int ret;
> +
> +                       for (i =3D 0; i < m->num_packs; i++) {
> +                               ret =3D load_pack_revindex(r, m->packs[i]=
);
> +                               if (ret)
> +                                       return ret;
> +                       }
>                 }
>                 return 0;
>         }
> @@ -573,6 +600,13 @@ static int load_bitmap(struct repository *r, struct =
bitmap_index *bitmap_git)
>         if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_gi=
t) < 0)
>                 goto failed;
>
> +       if (bitmap_git->base) {
> +               if (!bitmap_is_midx(bitmap_git))
> +                       BUG("non-MIDX bitmap has non-NULL base bitmap ind=
ex");
> +               if (load_bitmap(r, bitmap_git->base) < 0)
> +                       goto failed;
> +       }
> +
>         return 0;
>
>  failed:
> @@ -657,10 +691,9 @@ struct bitmap_index *prepare_bitmap_git(struct repos=
itory *r)
>
>  struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *mi=
dx)
>  {
> -       struct repository *r =3D midx->repo;
>         struct bitmap_index *bitmap_git =3D xcalloc(1, sizeof(*bitmap_git=
));
>
> -       if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitm=
ap_git))
> +       if (!open_midx_bitmap_1(bitmap_git, midx))
>                 return bitmap_git;
>
>         free_bitmap_index(bitmap_git);
> @@ -2899,6 +2932,7 @@ void free_bitmap_index(struct bitmap_index *b)
>                 close_midx_revindex(b->midx);
>         }
>         free_pseudo_merge_map(&b->pseudo_merges);
> +       free_bitmap_index(b->base);
>         free(b);
>  }
>
> --
> 2.49.0.13.gd0d564685b
>
