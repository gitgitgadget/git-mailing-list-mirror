Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45401F6686
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330939; cv=none; b=of3D+C8k0HJjfd47LY7OtD9Ic/CoXgXCO1GsHjbtwjcHI+/k5UMonksh0ZcQBkkkDewGZfDLb3pUmmlIRUttjbRXETpipXYjHSiQv08bXCtGf9eVhhlVzFQ0ZVmeTC9ksu88X+gP45Sq8FUJV89IrmIBiwKocJl0u+icSW4jhu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330939; c=relaxed/simple;
	bh=R11YS9YnoMiShtKNC6wOd+h9PN+VXvytcbTNtPHeAtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgtWxyX1br2aCCWeRYml8JZzNoriB7VsL5FJ1YiOBOHiC95/sOW86XkmhWznaBxuzetnFvN1gcYmYb04ryZmvJPK4+hQ46ePoWqrRlWgDkclIFAa4j1K+dQGVJ4uVrbmxEDi/Qa+QQXNzj13DFctxm65GiWtAsLYrA4WksYK3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frh+UBQm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frh+UBQm"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so28772262a12.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 02:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736330936; x=1736935736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lezUX//kXr8AHXwl1CNXb+LTfl2nQ175U9hXfrtfL0Y=;
        b=frh+UBQmmVTOg8l00MGeNawr5DC9Lvylc+DGOJ0dPRWRFKUcwApCOBIFesC5jRgIgk
         a1vqQDPZosAqJcbjk/LM0nygWr6pnpwJcFtM7IkQkMAv4WOaO6rdbof4EBR3TS1RtAcE
         djoFmyhT3ZpA+Xh7KKuCj/+WggVoiVVhro94T+n8H5dgr5pjwwWfS9N+/KmzFtXq42LA
         PGFQOl6Y70l+XVIwCIf8ZJsi+004Xh/7jhj6W/h4HO+c3mcyzF+iTBVylr518cf9b9m+
         fbDysT/quk7Oy7LB142ikI4OvKuDvXPBTlppBdVvg6pCV15O5OjlAeDgHe7VX5eTkF1m
         3zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736330936; x=1736935736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lezUX//kXr8AHXwl1CNXb+LTfl2nQ175U9hXfrtfL0Y=;
        b=L8rat6MwJb9+zbbckxFAuMUn2+vb7ZT5gmM6J/Lkb3ulk4K/FU0g6EMkqd4q1ROnia
         j/UXh9yvZwRa7UyZGsXkBsJn8cQRE8mNIkA3Bg0GjHS4YMxNN+eEBTImqNOjIK+H+dhK
         rsev0ucfVvzZNnM4pCK1wgJsM4avevY1V1TisQjO5mxCw/aL1nrsqB21x7U0zN75IUEW
         6DkXnAmIEVHxU2oZkiUlu0jdvVhehR/XjynngXPGh6r0HL/WF97l1mZMyejtF8KZpNG0
         OciMWqoL5WHHIfetWEvpsc5t+eIZILrx/3IvH8UZIMBHWH3M8/XkFmpINqu6EHRCrKkM
         LAng==
X-Gm-Message-State: AOJu0YwEWpSoNKCHyIO+sUpVI5Cdzxfs7FRaQutl7/HW3at72guFMi8V
	35sTJvuJWzmpgEGf1mhGNqN0pHupUqeledhfqDVtwI6iwalJCMpZeNnt4Vf03AU00hCV92koBXQ
	PZcANV7FBQc709SjZH/9JpqCrRw17Tpro
X-Gm-Gg: ASbGncuC/54o4vFPGvwYf7HS/LMw0oPquqknw4Z78upnPrTjLTzue9RlBceD+hxkoMg
	e/4tz+8mZ7CbDCq9OdWkaRVjyEMxaoMYQV4hChChh
X-Google-Smtp-Source: AGHT+IHYa7n0/b4+NRoiUKmcwzfarKg95FIgKJx3p2WGlnMZDWY/bYt9piSPWU3KxAkyIdP82OhCEcM/Fzged7x1dZ4=
X-Received: by 2002:a05:6402:354c:b0:5d3:ba42:e9d6 with SMTP id
 4fb4d7f45d1cf-5d972e14828mr1971895a12.17.1736330935796; Wed, 08 Jan 2025
 02:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108034012.211043-1-jltobler@gmail.com>
In-Reply-To: <20250108034012.211043-1-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Jan 2025 11:08:44 +0100
X-Gm-Features: AbW1kvbBHeNHVC1nyGe8dxR5PP5XBg2YUXmBX2zoWotVcsaOs3PL87VsM9jvg5o
Message-ID: <CAP8UFD1Q0C22TH7V7K9QZAJmLFDp+DPus1uB1O0oiAvJnWQgig@mail.gmail.com>
Subject: Re: [PATCH] rev-list: print missing object type with --missing=print-type
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:43=E2=80=AFAM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> Handling of missing objects encounted by git-rev-list(1) can be
> configured with the `--missing=3D<action>` option and specifying the
> desired action. Of the available missing actions, none provide a way to
> print additional information about the missing object such as its type.

What kind of additional information could we also print except for the type=
?

> Add a new missing action called `print-type`. Similar to `print`, this
> action prints a list of missing objects but also includes the object
> type if available in the form: `?<oid> [type]`.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
> Instead of adding an additional missing action type for the explicit
> purpose of printing type info, I also considered a separate option
> (something like `--object-types`, or maybe a `--missing-format`) that
> could be used in combination with the `--missing=3Dprint` option to
> achieve the same result. The main intent is for the missing object type
> and I wasn't sure if type info would be useful in the general case so I
> opted to choose the former approach.

If there are many other kinds of information we could also print, then
maybe a `--missing-format=3D<format>` option would make more sense
rather than adding `print-X`, `print-Y`, `print-X-Y`, etc. Otherwise,
yeah, I would say that `print-type` makes sense.

> @@ -103,6 +109,8 @@ static off_t get_object_disk_usage(struct object *obj=
)
>
>  static inline void finish_object__ma(struct object *obj)
>  {
> +       struct missing_objects_map_entry *entry, *old;
> +
>         /*
>          * Whether or not we try to dynamically fetch missing objects
>          * from the server, we currently DO NOT have the object.  We
> @@ -119,7 +127,12 @@ static inline void finish_object__ma(struct object *=
obj)
>                 return;
>
>         case MA_PRINT:
> -               oidset_insert(&missing_objects, &obj->oid);
> +       case MA_PRINT_TYPE:
> +               CALLOC_ARRAY(entry, 1);
> +               entry->entry.oid =3D obj->oid;
> +               entry->type =3D obj->type;
> +               old =3D oidmap_put(&missing_objects, entry);
> +               free(old);
>                 return;

Maybe a function like:

static void add_missing_object_entry(struct object_id *oid, unsigned int ty=
pe)
{
    struct missing_objects_map_entry *entry, *old;

    CALLOC_ARRAY(entry, 1);
    entry->entry.oid =3D *oid;
    entry->type =3D type;
    old =3D oidmap_put(&missing_objects, entry);
    free(old);
}

and then:

    case MA_PRINT:
    case MA_PRINT_TYPE:
        add_missing_object_entry(&obj->oid, obj->type);
        return;

could help keep finish_object__ma() (which is inlined) short and also
avoid some code duplication in the code below.

>         case MA_ALLOW_PROMISOR:
> @@ -414,6 +427,12 @@ static inline int parse_missing_action_value(const c=
har *value)
>                 return 1;
>         }
>
> +       if (!strcmp(value, "print-type")) {
> +               arg_missing_action =3D MA_PRINT_TYPE;
> +               fetch_if_missing =3D 0;
> +               return 1;
> +       }
> +
>         if (!strcmp(value, "allow-promisor")) {
>                 arg_missing_action =3D MA_ALLOW_PROMISOR;
>                 fetch_if_missing =3D 0;
> @@ -781,10 +800,26 @@ int cmd_rev_list(int argc,
>
>         if (arg_print_omitted)
>                 oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
> -       if (arg_missing_action =3D=3D MA_PRINT) {
> -               oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
> -               /* Add missing tips */
> -               oidset_insert_from_set(&missing_objects, &revs.missing_co=
mmits);
> +       if (arg_missing_action =3D=3D MA_PRINT ||
> +           arg_missing_action =3D=3D MA_PRINT_TYPE) {
> +               struct oidset_iter iter;
> +               struct object_id *oid;
> +
> +               oidmap_init(&missing_objects, DEFAULT_OIDSET_SIZE);
> +               oidset_iter_init(&revs.missing_commits, &iter);
> +
> +               /*
> +                * Revisions pointing to missing objects lack the context
> +                * required to determine object type.
> +                */
> +               while ((oid =3D oidset_iter_next(&iter))) {
> +                       struct missing_objects_map_entry *entry;
> +
> +                       CALLOC_ARRAY(entry, 1);
> +                       oidcpy(&entry->entry.oid, oid);
> +                       oidmap_put(&missing_objects, entry);
> +               }

Using the function suggested above this could be:

        /*
         * Revisions pointing to missing objects lack the context
         * required to determine object type.
         */
        while ((oid =3D oidset_iter_next(&iter)))
            add_missing_object_entry(oid, 0);

> +
>                 oidset_clear(&revs.missing_commits);
>         }
>
> @@ -801,12 +836,27 @@ int cmd_rev_list(int argc,
>                 oidset_clear(&omitted_objects);
>         }
>         if (arg_missing_action =3D=3D MA_PRINT) {
> -               struct oidset_iter iter;
> -               struct object_id *oid;
> -               oidset_iter_init(&missing_objects, &iter);
> -               while ((oid =3D oidset_iter_next(&iter)))
> -                       printf("?%s\n", oid_to_hex(oid));
> -               oidset_clear(&missing_objects);
> +               struct missing_objects_map_entry *entry;
> +               struct oidmap_iter iter;
> +
> +               oidmap_iter_init(&missing_objects, &iter);
> +
> +               while ((entry =3D oidmap_iter_next(&iter)))
> +                       printf("?%s\n", oid_to_hex(&entry->entry.oid));
> +
> +               oidmap_free(&missing_objects, true);
> +       }
> +       if (arg_missing_action =3D=3D MA_PRINT_TYPE) {
> +               struct missing_objects_map_entry *entry;
> +               struct oidmap_iter iter;
> +
> +               oidmap_iter_init(&missing_objects, &iter);
> +
> +               while ((entry =3D oidmap_iter_next(&iter)))
> +                       printf("?%s %s\n", oid_to_hex(&entry->entry.oid),
> +                              entry->type ? type_name(entry->type) : "")=
;
> +
> +               oidmap_free(&missing_objects, true);
>         }

Maybe a function like:

static void print_missing_objects(unsigned int with_type)
{
    struct missing_objects_map_entry *entry;
    struct oidmap_iter iter;

    oidmap_iter_init(&missing_objects, &iter);

    while ((entry =3D oidmap_iter_next(&iter)))
        if (with_type && entry->type)
            printf("?%s %s\n", oid_to_hex(&entry->entry.oid),
                   type_name(entry->type));
        else
            printf("?%s\n", oid_to_hex(&entry->entry.oid));

    oidmap_free(&missing_objects, true);
}

could avoid some code duplication. It could also make the output a bit
cleaner as when there is no type, there would be no space after the
oid in the output.

Thanks.
