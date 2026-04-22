Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EA2AE8D
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817955; cv=pass; b=CgE5+c6+s8tSxgR8pPsFGdrrPTMSVV2wUH4YPeoAPzXH1INiTBT1Fyp/o5CEl7wiuExdjODLAbLnl3LZoKtsgpLua49xgpJXBYqJNFFXIbF441oo2xYcx1TaE85cWqdC9xeMkktCs1OmB0AFCeX3MTbP+aPOhvX/WYAQR6KQvV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817955; c=relaxed/simple;
	bh=+Z9bqLTRuw56e/AmzxURXgdSIu6nxXKPK/Gmm9GYxmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmu7Kseb6SUJYmSpzAkcWCNsalRj4VXseocFjQimAe7LiefkmKcvmHeTeatlKvd7PodLS2rvxsbFwnPz6DICteWCTMllnmfEqHRPiCfKbJEQw0nlU+ayZOLK4FJYhLB+Ra4NYCw1u7Y+aLdQuyq4iQD6bLPcw0pGQwt8jUh7Vl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkGkTmoF; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkGkTmoF"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69486849137so1350662eaf.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 17:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776817953; cv=none;
        d=google.com; s=arc-20240605;
        b=VQ/TDXymE5rhXenMcODDEMWd5J3w/WCYihgYb6Yjy1EMw+G4TBl9WVI/J566FNXbs7
         K2R5iFg3lM2PV3tEDV8zPTE6Aqgbb9+SddwZYw6kpsw8zwtmNzHXHjm+v9zn/7ybETgB
         8HDoaWbQbVz1gmrao6HlgPiWajm1An5v89Hp7LTmJRJ0T+sNbvpcd9QLcaFrK5mEtlvi
         hQ+yIEEXSoYeoHTpm/N3Rv5nmtLdqUpX/jm/yybXdmzwR8INzk4KhP7Sz4wMQDvjH8BZ
         hQ5tNMvJTI1/NTKELGj7u+YpSkiNSPaHOaAebfptlk3gLRHz1RmPGZU9DbnJsL3xLid7
         MzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=20r6yTkgSgzNiBziY2hSS2+a751Z++Jk84VwcCZ6LPo=;
        fh=SA66t81nxC4XQU/4vrl+WCXkowt3lMvgIejciFJn/Lw=;
        b=cJN3JqlsXF+8dCUW0hv1pUiehjBpc/U7v3AXEJ6rFYKya1P62AZRPKSux10LmUuGjl
         fgRThEmaSIdg6c0XFugxPzJEAcxngiYybbEHU+Nmejw5FExeZe/9VV1teLugDIiIVdbF
         dF1sVflNzbQIwZos8o81z8RiviH/uhghHUe4Zh/bMwHcu9fJ0hOpYTZR6B34Hp30Lamw
         i0naCYR5QYJ2NPVxXf5JBMqjzdBGn/1VCCHdaYJIsLn0q3DOmgg3ZN2LftmthkVUuxKO
         LgfwQ8MhWmEriztbyCnkbhdPQfvZP1ItbEiwkdKmNTuugj5EIB958aGrqdN0OBtmhc2u
         v/ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776817953; x=1777422753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20r6yTkgSgzNiBziY2hSS2+a751Z++Jk84VwcCZ6LPo=;
        b=WkGkTmoFIBgABsN30A4VukJtmTz6MQXCimnbLi0OUmW3xYIUAeBIq16kLW+XS5M7W4
         JZZdlb4nleaxttPD+OyLmOrtxqMmps1uynALYSeOqpiapXVcL2EHPq0EzI4NdbocMt++
         KyxrFdBe5c5wK+4ZZu1I79JSIYiIuVJkmug4TrxyEptnh/3LLyyq4N/U1Z6Nu1zsSz9d
         m5ipiueDZQnpfj5A13c8fI2oOihGKET2qsdm/u1c7LacLg1xwdj2Emc/0SQ4wZZDIfcs
         HGpyNc0HQDuxiaBesOzIb24MT/ZePxjtp591kT75GMwWMWP4urB00+ISyFJhcAX7D+Ql
         FVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776817953; x=1777422753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=20r6yTkgSgzNiBziY2hSS2+a751Z++Jk84VwcCZ6LPo=;
        b=e+V2FDwS/NjAHKRQI/fyt+m+shHs3yEVKThNgPJxpdIWGoXr+BsF/HElfqfZj64bms
         8ecp2O7iyUOPYWAF1Sa0V2NrA/hcZMr4hFpC+nnzMrtXt1KvqfjxvhNPz5NgP6vVIqte
         uZnxsG2xN1Tu+/N2DpVaqUKsmpUfRo88nM5p+H6tyiBIvZRK+0Cv1N9P5/sNkAUGV+ln
         o4RYV2W2bn3QMRpVmbzCkKhGdVwyTAvducN2Mg4LYx5gCRCSyvuNCZvACECwHXrbWZTQ
         6918wWO+7xvwywjyrgU65NS1MiXo7FF9hdAMpK+ExZuv5eieYkM0IW4RlFUPFlfgxiwF
         M6Zg==
X-Gm-Message-State: AOJu0YwfK/pQ/CBbBcaDQW113/LlcmVUdJFzg2sMmWiCM3BWXr4km2kF
	0aD/S0TPKb3SHZ0kXCzKYP3J86DoEK4D07JjpjA7QjmKix7ikjkNMlDGuCieFDIWqEu01/0IzlH
	f4UektZz259nRXNP9tsxH69eQZM13wqA=
X-Gm-Gg: AeBDievfe9ijTQBfAZykRSZP2tSc+aipZcPIdgLoD32KKTjTZB01huWSMYFBsiSvwUa
	2SPbhAwK5S2XuCDLGQL9MXfrKLHAWIZAwPX/FtN1g7cB/5aA+62Uv0pODhgA1OO48S+X0SeKu1F
	VPCyC6ndxV08SDOvW/NXHNMpIAKEfkHB1U7+L6UXnYGHADZZGSVz/wT5lwPsvDNGAlkRcOfvFzl
	cFVTGshAm48QjHyAra+6dlCVwcKSXpoWDytCJvTgpdN1aez9o0vWcdlx/vNC2kjto48pJaq5071
	bA9x8vYHHd8KOQJ05vJjC9vHZ9jcWOILOTMhYALdd+1rCsiHn4sgOCvGUYWdKXE+cK3xlwOhyaG
	5D0mTvEcV9Vn3E1Bwh1Yv5evrQp+knUJykKrXSo+sDfjXzhWW
X-Received: by 2002:a05:6820:210e:b0:684:dd1d:5b8f with SMTP id
 006d021491bc7-69462bcecb3mr12002724eaf.0.1776817952892; Tue, 21 Apr 2026
 17:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk> <d20dc1f6550078883995ae963b91faaa00984c6e.1776697483.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <d20dc1f6550078883995ae963b91faaa00984c6e.1776697483.git.phillip.wood@dunelm.org.uk>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 21 Apr 2026 17:32:21 -0700
X-Gm-Features: AQROBzDWCDAzvBXiR8AxfvhmJi7OJl-ATyiPfuRw-MdCFMLEatRQ8E8dTF7MytY
Message-ID: <CABPp-BFziRXjuMKqf=RHgCwuCcujXSSrz0f+BS4pvE6EUbk-WQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] status: improve rebase todo list parsing
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:25=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When there is rebase in progress "git status" displays the last couple
> of completed and the next couple of pending commands from the todo
> list. When it does this is tries to abbreviate the object ids of

is tries =3D> it tries ?

[...]
> @@ -1363,6 +1363,51 @@ static int split_commit_in_progress(struct wt_stat=
us *s)
>         free(rebase_orig_head);
>
>         return split_in_progress;
> +}
> +
> +static void abbrev_oid_in_line(struct repository *r,
> +                              struct strbuf *line, char **pp)
> +{
> +       char *p =3D *pp;
> +       char *end_of_object_name, saved;
> +       const char *abbrev;
> +       struct object_id oid;
> +       bool have_oid;

I'll put "thinking out loud" text in square brackets below...

> +
> +       p +=3D strspn(p, " \t");
> +       end_of_object_name =3D p + strcspn(p, " \t");

[Advances p after whitespace, marks the end of the object with the
next whitespace after that.]

> +       /*
> +        * The for "merge" and "reset" the object name may be a label or

The for =3D> For ?

> +        * ref rather than a hex object id. Only abbreviate the object
> +        * name if it is a hex object id.
> +        */
> +       for (const char *q =3D p; q < end_of_object_name; q++) {
> +               if (!isxdigit(*q))
> +                       goto out;
> +       }



> +       saved =3D *end_of_object_name;
> +       *end_of_object_name =3D '\0';
> +       have_oid =3D !repo_get_oid(r, p, &oid);
> +       *end_of_object_name =3D saved;

[Tries to resolve the token, doing NUL-termination and restore dance.]

> +       if (!have_oid)
> +               goto out; /* object name was a label */


> +       abbrev =3D repo_find_unique_abbrev(r, &oid, DEFAULT_ABBREV);
> +       if (!starts_with(p, abbrev))
> +               goto out; /* object name was a refname containing only xd=
igits */

[Ensures what we have is an oid rather than a branch name that can be
resolved to an oid]

> +       p +=3D strlen(abbrev);
> +       strbuf_remove(line, p - line->buf, end_of_object_name - p);
> +       end_of_object_name =3D p;

[Splice out a bunch of characters in the middle?]

> +out:
> +       *pp =3D end_of_object_name;
> +}

I had a hard time following the logic in the function and trying to
figure out what it was doing.  I went line by line but had no mental
model to follow.  When I got to the comment that is now above
format_todo_line(), I suddenly understood, but without it, all the
code was hard to follow.  Maybe a small comment at the beginning of
the function along the lines of

 /*
  * If the whitespace-delimited token starting at or just after *pp is a
  * full hex object id that resolves uniquely, rewrite it in place to
  * its default abbreviation, shrinking `line` accordingly. On return
  * *pp points one past the (possibly abbreviated) token. Leaves both
  * `line` and *pp-advanced-past-the-token unchanged in all other cases
  * (non-hex token, unresolvable, or a refname that happens to consist
  * only of hex digits).
  */

?  (Assuming I'm understanding correctly, of course.)

> +
> +static void skip_dash_c(char **pp) {

Move the brace to the next line?

> +       char *p =3D *pp;
> +
> +       p +=3D strspn(p, " \t");
> +       /* The (void) cast is required to silence -Wunused_value */

-Wunused_value =3D> -Wunused-value ?

> +       (void)(skip_prefix(p, "-C", &p) || skip_prefix(p, "-c", &p));
> +       *pp =3D p;
>  }
>
>  /*
> @@ -1371,29 +1416,57 @@ static int split_commit_in_progress(struct wt_sta=
tus *s)
>   * into
>   * "pick d6a2f03 some message"
>   *
> - * The function assumes that the line does not contain useless spaces
> - * before or after the command.
> + * Returns false on comment lines, true otherwise
>   */
> -static void abbrev_oid_in_line(struct repository *r, struct strbuf *line=
)
> +static bool format_todo_line(struct repository *r, struct strbuf *line)
>  {
> -       struct string_list split =3D STRING_LIST_INIT_DUP;
> -       struct object_id oid;
> -
> -       if (starts_with(line->buf, "exec ") ||
> -           starts_with(line->buf, "x ") ||
> -           starts_with(line->buf, "label ") ||
> -           starts_with(line->buf, "l "))
> -               return;
> -
> -       if ((2 <=3D string_list_split(&split, line->buf, " ", 2)) &&
> -           !repo_get_oid(r, split.items[1].string, &oid)) {
> -               strbuf_reset(line);
> -               strbuf_addf(line, "%s ", split.items[0].string);
> -               strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
> -               for (size_t i =3D 2; i < split.nr; i++)
> -                       strbuf_addf(line, " %s", split.items[i].string);
> +       enum todo_command cmd;
> +       char *p =3D line->buf;
> +
> +       if (!sequencer_parse_todo_command((const char**)&p, &cmd))
> +               return true; /* keep invalid lines */
> +
> +       switch (cmd) {
> +       case TODO_COMMENT:
> +               return false;
> +
> +       case TODO_MERGE:
> +               skip_dash_c(&p);
> +               while (true) {
> +                       p +=3D strspn(p, " \t");
> +                       if (!p[0] || (p[0] =3D=3D '#' && (!p[1] || isspac=
e(p[1]))))
> +                               break;
> +                       abbrev_oid_in_line(r, line, &p);
> +               }
> +               break;
> +
> +       case TODO_FIXUP:
> +               skip_dash_c(&p);
> +               /* fallthrough */
> +       case TODO_DROP:
> +       case TODO_EDIT:
> +       case TODO_PICK:
> +       case TODO_RESET:
> +       case TODO_REVERT:
> +       case TODO_REWORD:
> +       case TODO_SQUASH:
> +               abbrev_oid_in_line(r, line, &p);
> +               break;
> +
> +       /*
> +        * Avoid "default" and instead list all the other commands so
> +        * that -Wswitch warns if a new command is added without handling
> +        * it in this function.
> +        */

Nice. :-)

> +       case TODO_BREAK:
> +       case TODO_EXEC:
> +       case TODO_LABEL:
> +       case TODO_NOOP:
> +       case TODO_UPDATE_REF:
> +               break;
>         }
> -       string_list_clear(&split, 0);
> +
> +       return true;
>  }
>
>  static int read_rebase_todolist(struct repository *r, const char *fname,=
 struct string_list *lines)
> @@ -1411,13 +1484,9 @@ static int read_rebase_todolist(struct repository =
*r, const char *fname, struct
>                           repo_git_path_replace(r, &buf, "%s", fname));
>         }
>         while (!strbuf_getline_lf(&buf, f)) {
> -               if (starts_with(buf.buf, comment_line_str))
> -                       continue;
>                 strbuf_trim(&buf);
> -               if (!buf.len)
> -                       continue;
> -               abbrev_oid_in_line(r, &buf);
> -               string_list_append(lines, buf.buf);
> +               if (format_todo_line(r, &buf))
> +                       string_list_append(lines, buf.buf);
>         }
>         fclose(f);
>
> --
> 2.54.0.rc1.174.gd833f386ac5.dirty

Other than the minor comments above, this looks like a nice cleanup.
