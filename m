Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FB346E43
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764946; cv=pass; b=p/CpZrKZRV/LSdBf1pM12EvUNwFk9BFpzEkBLVBsbfGoUq4GVraGlCQCidrpqagAVvzKkXVIhLBVoptmj2AyQysOTN0IVsTeMWW90NX3RZBfMTxk3yuhxQTl0UX9TkbqweR+27yBxrM0gQU7R/7nkeF1BlKmFxdloGkkuFfLpK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764946; c=relaxed/simple;
	bh=wKJVyT5sdGY095sQL2wHg/5rfYgAIb+HWZ/6rXGC2TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZA68zCD099+c+aqSXGMjCDDuZJ7eeHPaYfRniKWdMX9PdvGLwbk4iWB7OBUsd4mXFPmPxT1e5SsZSnLLf27Q9dIKVcQErYzEn10JjjiPjhr1stpt8glo2dho3lYLz8DkDtHmQHAtvDdkDNC0ibYGAwQ1aI3tHsJQ8YbsBxcPYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDOQPdup; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDOQPdup"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56638fca064so615454e0c.3
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 01:22:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769764943; cv=none;
        d=google.com; s=arc-20240605;
        b=I/tFVrfKP1R7gvYQ9M+M8dhsm+ctkD1zn+4uDiI8bJyRM7PWBptQjW/eUsoPSeiykx
         XYnsNMbzaB9pbZbUDZuhWN9KPEcwVppZXvGa/b64lpfWPWUPsAXJBhy+xWjjQ/Xnii1L
         c8qNWkcG7q34TzWZ2Ueehd8CXUYpBBV1NRJj2PJJ18QlASz/rcda8vLr/3BNdroznsUW
         66u3DL01bnutEQpPgPmSL2I/jy1IHQ9iwEZCfdO0gSKNzMgBpZOZpQgCmDvjgRtw3yYk
         MD4w7fzEK34zIrNWK8USTSPnTRKPNbAYVJawyuzAF7EaYEyQQ0E6SDcm9ur87x2roldI
         G+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m4pTyBIsjhoUN4/Jgx86qurHDUbpAtwz5rRsNWv0/SY=;
        fh=shWxNb8qA0DxLN80W7Sz7Tg64EW8RLYpEjyr7bUBFds=;
        b=kzGtnoFwQ38PUTWu2wkGLhUDOgW1iwbKbRdl9XDzJAo1ZTJEFGCVsl060CTK0fK3ea
         gVXqdhEv4ju+d4ZFgv4hFU/d/d0tvrWuWzxKHCTf3HWJIr21RkmCoppyf/9RbC/aNM6I
         7T7lrYV5yDIUaHsZpLk145iXx5+HfgQxeeUHeHgIPl5FVJHTtefh2nu1JiSham5ju/1J
         QLQzV6RLDJdawCEfyQ9wBg234Vf1uy/Gt1aYWwtuk4WiAUUcSih6mnwHz1UIr6460BTw
         btecdBum038Y0vMaBYmUHgzoHdPMBeslsdtAYYYOH7ME5Z2Lz/pt5InWGIw7gum/SyWH
         RzCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769764943; x=1770369743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4pTyBIsjhoUN4/Jgx86qurHDUbpAtwz5rRsNWv0/SY=;
        b=DDOQPdupTam4RVqG9DzhD88y9Y7AmgzpSnAXWARaoVNsH2Ui+Hr5x2+3Gvfj0tV0VA
         xPbCI7+ASf1kNUTQRPARJaRiYka7RVX0uDVhD/if99Y74re6yPRQYYxkpHItpa6tj80c
         yICg85IowUIpTRX8iX/OFskGGsOgj5k5AdvoxaY91Uuw8pwlIRsyJObK2esfpUz0vOwf
         JXGjABqxJNyceEKpixZJFJ7cd61+J9X4kAAradqaDZTdx4g+ZcwlcvoGN62yPHo7W9Cz
         cylcVjIUXhJ7VB1Qi8Ge89uKwOwYE3uIfF542DG3OB9qIxLpfv8/v/yEqYnIEqwW40oT
         1wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769764943; x=1770369743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4pTyBIsjhoUN4/Jgx86qurHDUbpAtwz5rRsNWv0/SY=;
        b=EUqgxjeYAsW5Ic4kiI/965ZCNkeMxa4mIJrQUJ0U8EnCZpbH5OePOzyRl7YgX36mJi
         WXHptK6B8b/hY5vKk2feUtye2iPmxg86xYQWnBcz9okIGhabcK0Dq4qS3S9roVTPZ7cD
         Lx4pTPWDRs4BH1aT9+yT647y3+CmrbCtwhZyrlLYubE3cMgJml9KCOZoAFu03samRwem
         oNelbHw+rDJlUXw+13uvJGoF9fWyTQVqdCRUuHfyOIGDq8O4f+tmTafa1qisjrsj61eq
         J/0ocZVenC+XqH8e4hOw+JtxI2B2wT/39XdIkvO7WIhTiE1xptYOaX1Y5c/BmT9iRePA
         Zu6Q==
X-Gm-Message-State: AOJu0YwVPKoHm4COoMtuY3HM8OHwa/IzZ9Jbb0NZsMNAOewJFZajEDp2
	f0rP83zkkFHDcrqG9T7RfOPlTBQ+6mS66UC2nd2JboEdewgxGzhOhY2HUGcKydqvYruWeQL8NV0
	4XfUiy94+fLhRN1eDkPbKjA4SXyw4uHY=
X-Gm-Gg: AZuq6aKiH5ENcwCW+RbuwAp6XllQuPhxC/PIK90BkTuj6mzfsEC5CDSiIz2y0hAmJNR
	SzLSiblIWSboldLlG6zdAOlY0E2utMav0KnFeRESgHaoiHCY8b+n3lQ0q/pGiL3XsEj1TfDUbTC
	JRUpCn8/1KqNFV8pMCrxiffdCQ11TSWVOcZozq08N0vKjY+pONdDsWxXEHnSaAKBQleMVqa/7zq
	vTf4V7EgCoguBhfp+C58UhylBt50gRveScO1VW1ik7B+fPHbITh/6MnvjRAIrE2bpIokdw7
X-Received: by 2002:a05:6122:4905:b0:563:4a88:6ecb with SMTP id
 71dfb90a1353d-566a01ab93cmr625649e0c.18.1769764943332; Fri, 30 Jan 2026
 01:22:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
 <9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
 <xmqq7bt2g4tl.fsf@gitster.g> <CADYq+fYeWh0tLEepOGVa=1i9tXZfWaGfyi6H+xUB7rbdQ=t5aQ@mail.gmail.com>
In-Reply-To: <CADYq+fYeWh0tLEepOGVa=1i9tXZfWaGfyi6H+xUB7rbdQ=t5aQ@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 30 Jan 2026 10:22:25 +0100
X-Gm-Features: AZwV_QitmULM1EP6VsVywpl0bY7uxwUqLM13OygGOLr9ZinKk-GUgn4X3VvgRNE
Message-ID: <CADYq+fbt7zHO=gAsRp=b5MTb=2aFfifCjWnW6u+58iv4dk6bMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Allow reworking with a file after deciding on all
 its hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 12:26=E2=80=AFPM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> On Tue, Jan 27, 2026 at 9:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
> >
> > > diff --git a/add-patch.c b/add-patch.c
> > > index 173a53241e..edb2fab3fd 100644
> > > --- a/add-patch.c
> > > +++ b/add-patch.c
> > > @@ -1418,6 +1418,8 @@ N_("j - go to the next undecided hunk, roll ove=
r at the bottom\n"
> > >     "e - manually edit the current hunk\n"
> > >     "p - print the current hunk\n"
> > >     "P - print the current hunk using the pager\n"
> > > +   "> - go to the next file\n"
> > > +   "< - go to the previous file\n"
> > >     "? - print help\n");
> >
> > As I said earlier, these may have to be optional.  It may give
> > existing users a jarring experience to be given a prompt after
> > deciding on all the hunks in a file, when they expect to be on
> > the next file already.
>
> Yes I agree.
> I will work on making it an optional feature.
>
> >
> > > @@ -1441,6 +1443,17 @@ static bool get_first_undecided(const struct f=
ile_diff *file_diff, size_t *idx)
> > >       return false;
> > >  }
> > >
> > > +static size_t get_file_diff_index(struct add_p_state *s, struct file=
_diff *file_diff) {
> > > +     size_t idx =3D 0;
> > > +     for (size_t i =3D 0; i < s->file_diff_nr; i++) {
> > > +             if (s->file_diff + i =3D=3D file_diff) {
> > > +                     idx =3D i;
> > > +                     break;
> > > +             }
> > > +     }
> > > +     return idx;
> > > +}
> >
> > Yuck.  Can't we lose the need for this function if we change the
> > interface into patch_update_file so that it takes the index of the
> > file (i.e., instead of "&s.file_diff[i]", pass "i")?  There is only
> > one caller to patch_update_file() which is run_add_p(), so such a
> > clean-up should be trivial.
>
> Ah yes this is definitely a sweet and better option.
>
> >
> > >  static int patch_update_file(struct add_p_state *s,
> > >                            struct file_diff *file_diff)
> > >  {
> > > @@ -1448,9 +1461,10 @@ static int patch_update_file(struct add_p_stat=
e *s,
> > >       ssize_t i, undecided_previous, undecided_next, rendered_hunk_in=
dex =3D -1;
> > >       struct hunk *hunk;
> > >       char ch;
> > > -     struct child_process cp =3D CHILD_PROCESS_INIT;
> >
> > This is related to the hoisting of the actual patch application to
> > the caller, but it is not explained why such a change is needed, and
> > it byitself, even without the "jump to the next file before deciding
> > on all the hunks" feature.  What problem is it solving???
>
> I explained this below
>
> >
> > If it is necessary to move the code to run "git apply" to the
> > caller, would it make sense to split this patch into at least two
> > patches, one to do such a move, possibly another patch to change the
> > function signature of patch_update_file() so that it takes the file
> > index instead of file_diff struct, and finally another patch to
> > allow jumping around the files?
>
> Okay yes it would make much sense.
>
> >
> > >       int colored =3D !!s->colored.len, quit =3D 0, use_pager =3D 0;
> > >       enum prompt_mode_type prompt_mode_type;
> > > +     size_t file_diff_index =3D get_file_diff_index(s, file_diff);
> > > +     int all_decided =3D 0;
> > >
> > >       /* Empty added files have no hunks */
> > >       if (!file_diff->hunk_nr && !file_diff->added)
> > > @@ -1467,7 +1481,9 @@ static int patch_update_file(struct add_p_state=
 *s,
> > >                       ALLOW_GOTO_NEXT_UNDECIDED_HUNK =3D 1 << 3,
> > >                       ALLOW_SEARCH_AND_GOTO =3D 1 << 4,
> > >                       ALLOW_SPLIT =3D 1 << 5,
> > > -                     ALLOW_EDIT =3D 1 << 6
> > > +                     ALLOW_EDIT =3D 1 << 6,
> > > +                     ALLOW_GOTO_PREVIOUS_FILE =3D 1 << 7,
> > > +                     ALLOW_GOTO_NEXT_FILE =3D 1 << 8
> > >               } permitted =3D 0;
> > >
> > >               if (hunk_index >=3D file_diff->hunk_nr)
> > > @@ -1499,8 +1515,7 @@ static int patch_update_file(struct add_p_state=
 *s,
> > >               /* Everything decided? */
> > >               if (undecided_previous < 0 && undecided_next < 0 &&
> > >                   hunk->use !=3D UNDECIDED_HUNK)
> > > -                     break;
> > > -
> > > +                             all_decided =3D 1;
> > >               strbuf_reset(&s->buf);
> > >               if (file_diff->hunk_nr) {
> > >                       if (rendered_hunk_index !=3D hunk_index) {
> > > @@ -1548,6 +1563,16 @@ static int patch_update_file(struct add_p_stat=
e *s,
> > >                               permitted |=3D ALLOW_EDIT;
> > >                               strbuf_addstr(&s->buf, ",e");
> > >                       }
> > > +                     if (file_diff_index >=3D 0 &&
> > > +                             file_diff_index < s->file_diff_nr - 1) =
{
> > > +                             permitted |=3D ALLOW_GOTO_NEXT_FILE;
> > > +                             strbuf_addstr(&s->buf, ",>");
> > > +                     }
> > > +                     if (file_diff_index > 0 &&
> > > +                             file_diff_index <=3D s->file_diff_nr - =
1) {
> > > +                             permitted |=3D ALLOW_GOTO_PREVIOUS_FILE=
;
> > > +                             strbuf_addstr(&s->buf, ",<");
> > > +                     }
> >
> > As can be seen in what patch_update_file() does when the user says
> > 'J' or 'K', hunks in a file are treated as a ring, and these
> > commands are enabled as long as there are more than one hunks.
> >
> > Perhaps that is more familiar than "when we hit the floor, we cannot
> > sink deeper, and when we hit the ceiling, we cannot float more",
> > which seems to be what the above implements.
>
> Yes I understand this now.
> It does make sense this way.
>
> >
> > >                       strbuf_addstr(&s->buf, ",p,P");
> > >               }
> > >               if (file_diff->deleted)
> > > @@ -1566,6 +1591,9 @@ static int patch_update_file(struct add_p_state=
 *s,
> > >                                               : 1));
> > >               printf(_(s->mode->prompt_mode[prompt_mode_type]),
> > >                      s->buf.buf);
> > > +             if (all_decided)
> > > +                     printf(_("\n%s All hunks decided. What now? "),
> > > +                             s->s.prompt_color);
> > >               if (*s->s.reset_color_interactive)
> > >                       fputs(s->s.reset_color_interactive, stdout);
> > >               fflush(stdout);
> > > @@ -1618,7 +1646,24 @@ static int patch_update_file(struct add_p_stat=
e *s,
> > >               } else if (ch =3D=3D 'q') {
> > >                       quit =3D 1;
> > >                       break;
> > > -             } else if (s->answer.buf[0] =3D=3D 'K') {
> > > +             } else if (s->answer.buf[0] =3D=3D '>') {
> > > +                     if (permitted & ALLOW_GOTO_NEXT_FILE) {
> > > +                             quit =3D 0;
> > > +                             break;
> > > +                     } else {
> > > +                             err(s, _("No next file"));
> > > +                             continue;
> > > +                     }
> > > +             } else if (s->answer.buf[0] =3D=3D '<') {
> > > +                     if (permitted & ALLOW_GOTO_PREVIOUS_FILE) {
> > > +                             quit =3D 2;
> > > +                             break;
> >
> > What's the magic number "2"?  Should "quit" become an enum with
> > elements that are more meaningfully named?
>
> Okay, yes an enum would be better.
>
> >
> > > +                     } else {
> > > +                             err(s, _("No previous file"));
> > > +                             continue;
> > > +                     }
> > > +             }
> > > +             else if (s->answer.buf[0] =3D=3D 'K') {
> > >                       if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
> > >                               hunk_index =3D dec_mod(hunk_index,
> > >                                                    file_diff->hunk_nr=
);
> > > @@ -1775,33 +1820,6 @@ static int patch_update_file(struct add_p_stat=
e *s,
> > >               }
> > >       }
> > >
> > > -     /* Any hunk to be used? */
> > > -     for (i =3D 0; i < file_diff->hunk_nr; i++)
> > > -             if (file_diff->hunk[i].use =3D=3D USE_HUNK)
> > > -                     break;
> > > -
> > > -     if (i < file_diff->hunk_nr ||
> > > -         (!file_diff->hunk_nr && file_diff->head.use =3D=3D USE_HUNK=
)) {
> > > -             /* At least one hunk selected: apply */
> > > -             strbuf_reset(&s->buf);
> > > -             reassemble_patch(s, file_diff, 0, &s->buf);
> > > -
> > > -             discard_index(s->s.r->index);
> > > -             if (s->mode->apply_for_checkout)
> > > -                     apply_for_checkout(s, &s->buf,
> > > -                                        s->mode->is_reverse);
> > > -             else {
> > > -                     setup_child_process(s, &cp, "apply", NULL);
> > > -                     strvec_pushv(&cp.args, s->mode->apply_args);
> > > -                     if (pipe_command(&cp, s->buf.buf, s->buf.len,
> > > -                                      NULL, 0, NULL, 0))
> > > -                             error(_("'git apply' failed"));
> > > -             }
> > > -             if (repo_read_index(s->s.r) >=3D 0)
> > > -                     repo_refresh_and_write_index(s->s.r, REFRESH_QU=
IET, 0,
> > > -                                                  1, NULL, NULL, NUL=
L);
> > > -     }
> >
> > It is not obvious why the above code needs to be hoisted to the
> > caller.
>
> I explained this below.
>
> >
> > >       putchar('\n');
> > >       return quit;
> > >  }
> > > @@ -1813,7 +1831,9 @@ int run_add_p(struct repository *r, enum add_p_=
mode mode,
> > >       struct add_p_state s =3D {
> > >               { r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_IN=
IT
> > >       };
> > > -     size_t i, binary_count =3D 0;
> > > +     size_t i, j, binary_count =3D 0;
> > > +     size_t patch_update_result =3D 0;
> >
> > Hmph, I think patch_update_file() returns "int quit".  Why do we
> > want overly wide type to store the result, which cannot even express
> > negative number to potentially signal a failure?
>
> Sorry, this is a mistake on my part
>
> >
> > > +     struct child_process cp =3D CHILD_PROCESS_INIT;
> > >
> > >       init_add_i_state(&s.s, r, o);
> > >
> > > @@ -1852,11 +1872,56 @@ int run_add_p(struct repository *r, enum add_=
p_mode mode,
> > >               return -1;
> > >       }
> > >
> > > -     for (i =3D 0; i < s.file_diff_nr; i++)
> > > -             if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
> > > +     for (i =3D 0; i < s.file_diff_nr;) {
> > > +             if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr) {
> > >                       binary_count++;
> > > -             else if (patch_update_file(&s, s.file_diff + i))
> > > -                     break;
> > > +                     i++;
> > > +                     continue;
> > > +             }
> > > +             else {
> > > +                     patch_update_result =3D patch_update_file(&s, s=
.file_diff + i);
> > > +                     if (patch_update_result =3D=3D 0) {
> > > +                             i++;
> > > +                             continue;
> > > +                     }
> > > +                     if (patch_update_result =3D=3D 1)
> > > +                             break;
> > > +                     if (patch_update_result =3D=3D 2) {
> > > +                             i--;
> > > +                             continue;
> > > +                     }
> > > +             }
> > > +     }
> > > +     for (i =3D 0; i < s.file_diff_nr; i++) {
> > > +
> > > +                     /* Any hunk to be used? */
> > > +             for (j =3D 0; j < s.file_diff[i].hunk_nr; j++)
> > > +                     if (s.file_diff[i].hunk[j].use =3D=3D USE_HUNK)
> > > +                             break;
> > > +
> > > +             if (j < s.file_diff[i].hunk_nr ||
> > > +         (!s.file_diff[i].hunk_nr && s.file_diff[i].head.use =3D=3D =
USE_HUNK)) {
> > > +                     /* At least one hunk selected: apply */
> > > +                     strbuf_reset(&s.buf);
> > > +                     reassemble_patch(&s, s.file_diff + i, 0, &s.buf=
);
> > > +
> > > +                     discard_index(s.s.r->index);
> > > +                     if (s.mode->apply_for_checkout)
> > > +                             apply_for_checkout(&s, &s.buf,
> > > +                                             s.mode->is_reverse);
> > > +                     else {
> > > +                             setup_child_process(&s, &cp, "apply", N=
ULL);
> > > +                             strvec_pushv(&cp.args, s.mode->apply_ar=
gs);
> > > +                             if (pipe_command(&cp, s.buf.buf, s.buf.=
len,
> > > +                                             NULL, 0, NULL, 0))
> > > +                                     error(_("'git apply' failed"));
> > > +                     }
> > > +                     if (repo_read_index(s.s.r) >=3D 0)
> > > +                             repo_refresh_and_write_index(s.s.r, REF=
RESH_QUIET, 0,
> > > +                                                             1, NULL=
, NULL, NULL);
> > > +             }
> > > +
> > > +     }
> >
> > One upside of having "git apply" at the end of patch_update_file()
> > is that you can "^C" out of "git add -p" or your terminal connection
> > can be cut off, after dealing with hunks in a few early files, and
> > these early part of your work that you have already done are already
> > reflected to the working tree files.  By hoisting the logic to the
> > caller, this is making the update all-or-none, which is good in
> > transactional systems, but can make a horrible experience for an
> > interactive use where you make progress while thinking.
> >
> > So I am not yet convinced if this change makes sense---it could be
> > because of the lack of justification for this change.
>
> What I observed after adding the '>' and '<' options is that if a user ch=
ooses
> to use a hunk A in file 1, and then goes to file 2 with '>', comes back t=
o
> file 1 with '<', and decides on hunk A to skip it instead, because
> patch_update_file() has
> applied the file with the hunk the user initially decided to use
> before proceeding to file
> 2 with '>', coming back to redecide and say skip does not apply the
> latest decision
> and when you check the index, the file with the hunks which the user
> initially decided to
> use but changed to skip is present in the index.
>
> But if the user initially decided to skip a hunk in a file, goes to
> the next file with '>'
> and back to the first file, changes the decision on the hunk to use,
> it applies the patch
> with the hunk because the hunk was not initially selected when the
> patch was applied.
> But if he now goes away and comes back to the file a third time and
> chooses to skip the
> hunk, then quits with 'q', because he had selected to use the hunk the
> second time,
> choosing skip again will not work.
>
> So basically, initially choosing to use a hunk in a file, going to
> another file and coming
> back to this file then choosing to skip it does not register the
> latest skip decision
> on that hunk.
>
> That was why I decided to do it this way.
> I will appreciate a better suggestion from you
>
> Thanks
> Abraham.

Hello Junio, thank you for your review.
Here I explain my decision to move the "git apply" in patch_update_file()
to the caller.

Does it sound like a valid reason to make the move?
Thanks

Abraham
