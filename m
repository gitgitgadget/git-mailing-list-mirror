Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89B2DFA41
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686665; cv=none; b=bEQlvo6+qM5PrhEOOrAk8fVA7LWLoUOi+0+/B8JtqVIp3i8xBCz+UjzxO+OkbYeBhgxozSbGhJ9EKJO3qKo/kvhthC2lTlWu4IInyfTRQR+Cn08ZsCmZtooISNqq7JrFvBNDx5fxqRTwihDiI+67TqPMCi0UhW+hmn6U+XmNwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686665; c=relaxed/simple;
	bh=XrjfMkNHTvg6QfXwgXDEv0lrsFRHk4ZATRPW0iZRzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGHApSeaQvCSmC0tWRHEVqcpQlFEaOZ201bDQQtYm6giNbjWF7tNli26+4dEjICJ+LjNA6o5pH6sDG9QLm8exOn4+7s5IHMXr80ytxtY6IZ5xPaCjR/pw4NfhlvtlQWqe6ohF9NwuNCXiGwH9mcTY2sFg7Vca8CJWg5kIUm22JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgEE2s8b; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgEE2s8b"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d5e2606a1bso44032275ab.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744686663; x=1745291463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0xNzskNSmzGdK+JXcgGG6Cbx0y1bDW+EANK7NdY53M=;
        b=GgEE2s8bR4mlBUnLWanAInpgIJUyT3Kg1U1kODnV8Dw8dR2gfp/bSci+KTpQcyXeAd
         4qmHIHwVnwU2zYSNJOMZ1EBT417PWJRH+vRXgMzrl4yFv7d1JIJ+CzL11xOdaQzCpg6z
         TQYDllwTbyKcp8H4OaxLa04av/P8Nbh/NnTrrRrSVrwXHVSXdT9hhEsdz7GIuzRIhHOF
         qWr9GT+HXqYIM8pTbRQUL7qT5juhLxsupVVO23hmC7WnPJnaW0dOHg3O+fdy9xjTK9xx
         /KU8pm3PVu6aBhylHwi+S/YtNH3oO+PAPiLrAaGybdDFW1Q8WxRFobMRIyt37sRcdwW6
         9d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744686663; x=1745291463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0xNzskNSmzGdK+JXcgGG6Cbx0y1bDW+EANK7NdY53M=;
        b=sV7KLCJSP9gygj2rS5hYUmG0qNYWzAJAJB4mOGaJj7cYw2XCXINS895uzIyzL0ryEh
         +S4/8ZGEE5PGjokArjbkaMNfl910shn/P47YcYhxsAwUIoQugG40fm6f0xEb1ntVW/vg
         etvxYYdRCUEzwR8Kk25XdIp+fCY329Qk5jCXT+CInL66VYM7QSUwXhd1HS+sUEotxe6y
         +MW2Icm/rnNSaIDeIjHsM5Md3l+jdJ5CnVoytdTYdNC6a0km0EB1efltpFwbPNc2BdjF
         DEYJEtUBTmidpRMTAnJZmzT9iCx5sJ0yFS8g8ZY4wml+5jguG25cd5urkIut179gsxYy
         bjKQ==
X-Gm-Message-State: AOJu0Yzv51n71afhmbvuA2zJDu7RNglgTbJe3rXodPRgIeduUviKQwcs
	23DNncjLYW4E61CYBN6V1Z0+6g+sdZID/FF7F+UCE9d6r5gDEDko03sxo3XIQAcOaCs4HXdCv2v
	lGSb1cU0jMvc5ELauopDDe9fTw3w=
X-Gm-Gg: ASbGncvQqxThrOQUmff73bgU3IDQcJtVP8rZDgS+dnA3+VMxxePpJN1d+W3+oIfiXIm
	O03cRlPjaHNd0phfSfKcyYYITGnyHTcFDifoSOqnyQnEOSbeEDchiKHlmN89q2Bcx9EilSFv2Lk
	cEwuEXT1zGTTP4+cdyv2iNQRnN/VCn7SLsNRI07PpKuAZLxV9Bbr3IMGo=
X-Google-Smtp-Source: AGHT+IG8rvgOV0nc5VqDghp2Dx7NLeefxS399AWw9zZg5bit5nJpBmDXwRd1W5GW93wpRhLrZPuT0r0tVKL19rbk3SU=
X-Received: by 2002:a05:6e02:1a44:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3d7ec26c3a9mr128032345ab.14.1744686662660; Mon, 14 Apr 2025
 20:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744661167.git.me@ttaylorr.com>
 <0bc2183dc39a949d7eef08d282994231543d4c26.1744661167.git.me@ttaylorr.com>
In-Reply-To: <0bc2183dc39a949d7eef08d282994231543d4c26.1744661167.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 14 Apr 2025 20:10:51 -0700
X-Gm-Features: ATxdqUEZ3P_sKHQLdEZdunPgZ7nlWbK_UZI9x0C1kOSNnEXvbIpMUSQoy-lIttI
Message-ID: <CABPp-BG-XeOCtKd-LvUNGsBGyk6rLecm=BYbUDn-6rGwi=ROzg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] pack-objects: perform name-hash traversal for
 unpacked objects
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:06=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> With '--unpacked', pack-objects adds loose objects (which don't appear
> in any of the excluded packs from '--stdin-packs') to the output pack
> without considering them as reachability tips for the name-hash
> traversal.
>
> This was an oversight in the original implementation of '--stdin-packs',
> since the code which enumerates and adds loose objects to the output
> pack (`add_unreachable_loose_objects()`) did not have access to the
> 'rev_info' struct found in `read_packs_list_from_stdin()`.
>
> Excluding unpacked objects from that traversal doesn't effect the

s/effect/affect/ ?

> correctness of the resulting pack, but it does make it harder to
> discover good deltas for loose objects.
>
> Now that the 'rev_info' struct is declared outside of
> `read_packs_list_from_stdin()`, we can pass it to
> `add_objects_in_unpacked_packs()` and add any loose objects as tips to
> the above-mentioned traversal, in theory producing slightly tighter
> packs as a result.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 1689cddd3a..2aa12da4af 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3642,7 +3642,7 @@ static void read_packs_list_from_stdin(struct rev_i=
nfo *revs)
>         string_list_clear(&exclude_packs, 0);
>  }
>
> -static void add_unreachable_loose_objects(void);
> +static void add_unreachable_loose_objects(struct rev_info *revs);
>
>  static void read_stdin_packs(int rev_list_unpacked)
>  {
> @@ -3669,7 +3669,7 @@ static void read_stdin_packs(int rev_list_unpacked)
>         ignore_packed_keep_in_core =3D 1;
>         read_packs_list_from_stdin(&revs);
>         if (rev_list_unpacked)
> -               add_unreachable_loose_objects();
> +               add_unreachable_loose_objects(&revs);
>
>         if (prepare_revision_walk(&revs))
>                 die(_("revision walk setup failed"));
> @@ -3788,7 +3788,7 @@ static void enumerate_cruft_objects(void)
>                                                 _("Enumerating cruft obje=
cts"), 0);
>
>         add_objects_in_unpacked_packs();
> -       add_unreachable_loose_objects();
> +       add_unreachable_loose_objects(NULL);
>
>         stop_progress(&progress_state);
>  }
> @@ -4066,8 +4066,9 @@ static void add_objects_in_unpacked_packs(void)
>  }
>
>  static int add_loose_object(const struct object_id *oid, const char *pat=
h,
> -                           void *data UNUSED)
> +                           void *data)
>  {
> +       struct rev_info *revs =3D data;
>         enum object_type type =3D oid_object_info(the_repository, oid, NU=
LL);
>
>         if (type < 0) {
> @@ -4088,6 +4089,10 @@ static int add_loose_object(const struct object_id=
 *oid, const char *path,
>         } else {
>                 add_object_entry(oid, type, "", 0);
>         }
> +
> +       if (revs && type =3D=3D OBJ_COMMIT)
> +               add_pending_oid(revs, NULL, oid, 0);
> +
>         return 0;
>  }
>
> @@ -4096,11 +4101,10 @@ static int add_loose_object(const struct object_i=
d *oid, const char *path,
>   * add_object_entry will weed out duplicates, so we just add every
>   * loose object we find.
>   */
> -static void add_unreachable_loose_objects(void)
> +static void add_unreachable_loose_objects(struct rev_info *revs)
>  {
>         for_each_loose_file_in_objdir(repo_get_object_directory(the_repos=
itory),
> -                                     add_loose_object,
> -                                     NULL, NULL, NULL);
> +                                     add_loose_object, NULL, NULL, revs)=
;
>  }
>
>  static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
> @@ -4356,7 +4360,7 @@ static void get_object_list(struct rev_info *revs, =
int ac, const char **av)
>         if (keep_unreachable)
>                 add_objects_in_unpacked_packs();
>         if (pack_loose_unreachable)
> -               add_unreachable_loose_objects();
> +               add_unreachable_loose_objects(NULL);
>         if (unpack_unreachable)
>                 loosen_unused_packed_objects();
>
> --
> 2.49.0.229.gc267761125.dirty

Should this patch have some tests demonstrating the difference in
which objects are included?
