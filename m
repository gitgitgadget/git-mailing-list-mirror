Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518D324703
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535325; cv=none; b=PzBQzjqCM8cKWbH00XvdinhibB1dIJmcZiHfEbzE9Jr6Tqr+v07lh9u68CC9hW+vBpjHaln80GoUe9oVDFuOrL2MFD6Kr1iOxeMNYwXLHenXzFJZlWwwWsd9kjfJ3dOfi7GIeiOV+1LchaibpBqYx2bOI42olTqo7BOHg+vbwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535325; c=relaxed/simple;
	bh=ZVVa6hEt8FLz2ojBcxonq3NAWRsb2KUNNH7rxW3Cy84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlzhFqyvBCO51IkixgOJGS8ZfQkIPjOk+hcHhvemW1JuIDiiJCjdvw5HB6L9P4yHZM+JCuFvnbj8dCch71JUR/ANFs01VFz00D2QQKKbJA2ZtVmfE/JZps+h13jyAEktq9kQCtjX5QYzLuMOD/60K4VSTurG70xmHC1atJldYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2e2500517so81142285a.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535322; x=1764140122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bj0fV0GYOY61GA1/3ogYeQ3M7+CfLFUpTTDVfZmfxfY=;
        b=Pmw5YSiStqQgRlCKuajOTRyzLzXqwgQaZNGDyzUmSQx8/duYfpyHDNsRrMyC5lKQUP
         F64TFjy6I6hir1exbuSHQy7JKRJaIDpPUZq0UzfKMCdZlF1ZqZOK7hO6mUzZ5tJASqua
         JSeP+wkWbjh5EYUauBiw3Yunj81FFM9EktOiskGTHlaUx7kG5eZvU/RRxievMjlSvGTO
         0xFk2Qp/bqEZHQ0PBKc7CCWkeW63puB9EYYCGRIgDyLnIL+ZaiIlqAN+muF+8n5mQIGU
         I1F7XHc8uofkjxOj7SCb1xA5FXNw/83v0+qviiF+QWyKHNWxU18VI9OUx3KBHfN+44WG
         nrlQ==
X-Gm-Message-State: AOJu0YwaK5E90NFVrFX0qW0rsaspXBOIkPXj6d47ejSPvlXNzDp3if8P
	Csm9oo8/prudLNG3Dlx1qsdM0xtrIIu7hgEjsuixcwCPBhyn6GT1CykAJPswIVU52MruE+TGunF
	TgQuK5buXa3HjlkgxJtlI2TJ0zNuPI3BP5YB9
X-Gm-Gg: ASbGncuh7a6m2oBCt1L6pyKkx0adhxYvr/yUOGsZTPNAmZwoVYWFhHP+VP9F3bBP5UD
	Et7PB0FOA3kjYK05SZZe5i9+90CYquDgqk06EmdqwYCdkI8lYMs+23fMB8690o9K1/t84vhDTJh
	cH3HvR/3NvB3QFsKL/An529TaAqhTVyPyq2dbH2B7BkIwXSdINegxraWEwgK0gvVSVMPCkINGJL
	rUwME7IQxjLspb/sL3AQMDM1fdZODpGnmVJcoJW8ewmxN04xQ11KyVUMP+DAgHb5f4u59Y9FChD
	3FKDeJzRjhff1VeEVOZUSGcYS25QR9vbN9z67BC4EPRhZL/aVdX4qHHZlVg=
X-Google-Smtp-Source: AGHT+IFbaizQk0YmKTndDoo8NCOXn4eVWUyAZEB9/HLgWZAYpvQ8inZB4SbEOkRLVl2ANyxNp25ujNCJTtUvtJ7wAhI=
X-Received: by 2002:a05:620a:29d6:b0:8a4:8825:bc6c with SMTP id
 af79cd13be357-8b305e60e10mr483351385a.4.1763535322586; Tue, 18 Nov 2025
 22:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763482051.git.phillip.wood@dunelm.org.uk> <9417c73b3c4b89ed7c4cb823f3f68e994a968021.1763482051.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <9417c73b3c4b89ed7c4cb823f3f68e994a968021.1763482051.git.phillip.wood@dunelm.org.uk>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 19 Nov 2025 01:55:11 -0500
X-Gm-Features: AWmQ_bmR1hZCS02Sd2bm7WytJd0CutwzupP3DahRbnTev2FnT9KP87ofSbItj4s
Message-ID: <CAPig+cQaOx7yptQT=eDfVcsv_NbRseR+5Dvpm4E95z2HMpEKag@mail.gmail.com>
Subject: Re: [PATCH 1/2] worktree list: fix column spacing
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:07=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> The output of "git worktree list" displays a table containing the
> worktree path, HEAD OID and branch name for each worktree. The code
> aligns the columns by measuring the visual width of the worktree path
> when it is printed. Unfortunately it fails to use the visual width
> when calculating the width of the column so, if any of the paths
> contain a multibyte character, we can end up with excess padding
> between columns. The simplest fix would be to replace strlen() with
> utf8_strwidth() in measure_widths(). However that leaves us measuring
> the visual width twice and the byte length once. By caching the visual
> width and printing the padding separately to the worktree path, we only
> need to calculate the visual width once and do not need the byte length
> at all. The visual widths are stored in an arrays of structs rather
> than an array of ints as the next commit will add more struct members.
> [...]
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -1020,20 +1023,24 @@ static void show_worktree(struct worktree *wt, in=
t path_maxlen, int abbrev_len)
> +static void measure_widths(struct worktree **wt, int *abbrev,
> +                          struct worktree_display **d, int *maxwidth)
>  {
> -       int i;
> +       int i, display_alloc =3D 0;
> +       struct worktree_display *display =3D NULL;
>
>         for (i =3D 0; wt[i]; i++) {
>                 int sha1_len;
> -               int path_len =3D strlen(wt[i]->path);
> +               ALLOC_GROW(display, i + 1, display_alloc);
> +               display[i].width =3D utf8_strwidth(wt[i]->path);
>
> -               if (path_len > *maxlen)
> -                       *maxlen =3D path_len;
> +               if (display[i].width > *maxwidth)
> +                       *maxwidth =3D display[i].width;
>                 sha1_len =3D strlen(repo_find_unique_abbrev(the_repositor=
y, &wt[i]->head_oid, *abbrev));
>                 if (sha1_len > *abbrev)
>                         *abbrev =3D sha1_len;
>         }
> +       *d =3D display;
>  }

The reason you're using ALLOC_GROW() rather than simply allocating the
entire `display` array at the start is that `wt` is a NULL-terminated
array, thus you don't know its length ahead of time. Makes sense.

> @@ -1079,21 +1086,25 @@ static int list(int ac, const char **av, const ch=
ar *prefix,
> +               struct worktree_display *display =3D NULL;
>                 if (!porcelain)
> +                       measure_widths(worktrees, &abbrev,
> +                                      &display, &path_maxwidth);
> [...]
> +               free(display);
>                 free_worktrees(worktrees);

`display` is correctly freed. Good.
