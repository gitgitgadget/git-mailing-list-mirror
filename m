Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7902C08C8
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599611; cv=pass; b=MQAwb5/qMcUwtubvRVmldJA6NmTNlqahKiBtA2T//uZMahCLVLGmEqk2OQuQCtjU5sKw2AkhzkZAKPbtg+wToB92TDro6t77O4ct9DnmNX3LQDImeCrvrJfx9l/LtPYK/yAsQGDqYddqL8vOOpNOGkYthIluEhA7iCL7IYBacdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599611; c=relaxed/simple;
	bh=TvOYEDTZlRzBojGMpfIgWiD4+/wWktFLhqWCYmfI+9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlClkMAOK80EAWEKfnnTqPilA8RKtCOnoPe6FEz2j55UtL2TG5aieDunZFD8SDW5lKfWhKYyijbHogZ0FpKJ5EJ58hrM9zAUc6tVEl/+8V2iGpnZedy9Axn6aqMEFQlNOjPxS3t/dDG3x2dQmPuKHt0FVL86NZc3O7MWpUrSvws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP7U9kd3; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP7U9kd3"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5664393d409so1398526e0c.0
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 03:26:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769599607; cv=none;
        d=google.com; s=arc-20240605;
        b=SzpyH86J1aFE8qBOLjAqQUFQsxSjbYwj23sgWSy46yj50Wm0j5A/mNDsT28QRqB5Mb
         iyRBVXy83jwEVbWGII8rAn8EQQ0haHfaY7e6bplMwKqAO7p2T2ePKLBwhCeB4+eY3hvo
         4vcvXHl4LzA4nUYB6qQ2ZRrd90+9yzmV0X2s5iB7pk5Ou0J0csOxVroTA+FUw9PMPdOd
         fhwI349+nCmMA20q/2vY1LDI8dut4fak9br9ssVC+k6OqmV1N52q0z1jpAKFOswUpQsS
         rbQqX21pbhTL/ihtj4EqQghvwGJZch7HqOiLbtBlkNeafCvltP4Gi1TcH4TQjDLQO5h1
         9Uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kqQcwUABnwwnrUYXgY0cV9O+EOugGp8W/MtY5wluAR4=;
        fh=shWxNb8qA0DxLN80W7Sz7Tg64EW8RLYpEjyr7bUBFds=;
        b=ZwuUALbXdVeGiQ0yaIgJdDIfpLONujaZtjXwgm0b5Nor2Yo6aPFWG41IWBldvI0WA5
         M6a8jSW27wV2e9dDf8H9E7NqwkPXmIVpVPH240JGxZebhXXQns1u3uXw6l/D6FYxSjRC
         ISugmpEQ4yMwYFisU1eNCXdh9cMS6e9dqXskj5pvfWriIJabw/DCmsUAFF2FOK3SEDK+
         MGKy9ZJxQdI7x770FMZDXYP8fW3MlPeMm9D6OgbsapvJfvgHwIxlQx6Qz+M9hlcfdmY+
         qq+80Rw3HlEdvZtBPkBAl19G94GwC0gr1yagdfafeplCBAG/cAfCulJgy2Fpu2l4rbPp
         JLXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599607; x=1770204407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqQcwUABnwwnrUYXgY0cV9O+EOugGp8W/MtY5wluAR4=;
        b=QP7U9kd3CKQvcr8DMKdk/+kzlPnt4iHpa8j6v1xs8P9EZQGlK1UhndT9aA73DIgIlV
         mo+PeUVMs7J3hyzeYKOR0w2uEjgEqR5A9F6qHRCcTTIh0aOtcoxY87IMH7GjPDKntR9O
         MfrX8nuQVAvxYu9o9mK18uC7U//9FFzJ2BFqrPD3RG8HxBU8ME/wK46oIbm+gC1Bq/0m
         bPSJ8XCeY3cpX6QhXPP1l+6Fd/yv2eCeBZzyTgAspPCQMkGJSiNvjVdYYIGU7xgls8d1
         qI5bHomI4HYRzIELzsQNGLpDN42srRNJ/qhHWrEB+N4t83c0h7IBmFcs0lqQkJiyctLl
         rEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599607; x=1770204407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqQcwUABnwwnrUYXgY0cV9O+EOugGp8W/MtY5wluAR4=;
        b=oE5jtrcYvOfPTWUz9aCVXaadGrKGpKKRh4DsCvTZwSmdjCflcUr+vhmaZxwp86oogW
         79K/dAtyCUPK0MpNB7G3HiySZi/8hLp4u0+jo70o3J0G/oxS8TLFj2j7vvL3n+mOMKUj
         PzHz+IjWmdJvo7+EabIjjWfhsnnr+/47PcBK2WEmxRsB5s2AwhkwpfgcoCzyQuT2zQBi
         3brkb+b+/C7L52hj0Cpa7jv8aBCJ7vFBJMoayba0f/aw5/SkBnMdWlio8Ks6OGjex861
         kZCx16wqL+a/PFmJPUG315/iS7ttGyOI/29bH+c1jngaUb57luUGr7JFNfZFBcbnV/rV
         sp4Q==
X-Gm-Message-State: AOJu0YyplrzGwZiGO8GmQlRHxtmd82EtH71GeRJrnmKkP+q49W644rce
	bH7PCyNJVFjHiOjYu8HL7If+JThavOJxocpQLCNGjiJBCfUhiLTCkQnU+OdHtEw9j+9TulbLCcD
	PCmZUgS46kDWm7UKOaiur8cnHMOTmnLs=
X-Gm-Gg: AZuq6aITNa/9tm81iuVDkVVMrobWVy4kHeIVIWHOLNSJLptYPF+uZGA+bgFAQgQCLJu
	3Cm+uSEBmShLPMkbDy8DGwJanr7AnZ3sJktCLyMSRhMFfZSHix9P3aJ28CGbP13h5qvU0SNo8bj
	ImJm4bIL8aTo2i8JUFfl8/Lf7nSLUp7jtGf7IW7WSlzJt1ufL7uXVwSlFatYb+jZZAyUeH/o2mR
	UYccYer9mgxhkYFF8CfqbEDvmq+hcq4KCmKPTQCjcVoXxObgfOWQJKQuZK8xZKnE2TZYA==
X-Received: by 2002:a05:6122:82a9:b0:566:3c6d:b597 with SMTP id
 71dfb90a1353d-5667959e000mr1418482e0c.11.1769599607382; Wed, 28 Jan 2026
 03:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
 <9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
 <xmqq7bt2g4tl.fsf@gitster.g>
In-Reply-To: <xmqq7bt2g4tl.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 28 Jan 2026 12:26:48 +0100
X-Gm-Features: AZwV_QjbxF38HkKYs7bU35d5vKtXnVg1PYBiopQXrKMwV2H8QRScLZ-96w-4lJ4
Message-ID: <CADYq+fYeWh0tLEepOGVa=1i9tXZfWaGfyi6H+xUB7rbdQ=t5aQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Allow reworking with a file after deciding on all
 its hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 9:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > diff --git a/add-patch.c b/add-patch.c
> > index 173a53241e..edb2fab3fd 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -1418,6 +1418,8 @@ N_("j - go to the next undecided hunk, roll over =
at the bottom\n"
> >     "e - manually edit the current hunk\n"
> >     "p - print the current hunk\n"
> >     "P - print the current hunk using the pager\n"
> > +   "> - go to the next file\n"
> > +   "< - go to the previous file\n"
> >     "? - print help\n");
>
> As I said earlier, these may have to be optional.  It may give
> existing users a jarring experience to be given a prompt after
> deciding on all the hunks in a file, when they expect to be on
> the next file already.

Yes I agree.
I will work on making it an optional feature.

>
> > @@ -1441,6 +1443,17 @@ static bool get_first_undecided(const struct fil=
e_diff *file_diff, size_t *idx)
> >       return false;
> >  }
> >
> > +static size_t get_file_diff_index(struct add_p_state *s, struct file_d=
iff *file_diff) {
> > +     size_t idx =3D 0;
> > +     for (size_t i =3D 0; i < s->file_diff_nr; i++) {
> > +             if (s->file_diff + i =3D=3D file_diff) {
> > +                     idx =3D i;
> > +                     break;
> > +             }
> > +     }
> > +     return idx;
> > +}
>
> Yuck.  Can't we lose the need for this function if we change the
> interface into patch_update_file so that it takes the index of the
> file (i.e., instead of "&s.file_diff[i]", pass "i")?  There is only
> one caller to patch_update_file() which is run_add_p(), so such a
> clean-up should be trivial.

Ah yes this is definitely a sweet and better option.

>
> >  static int patch_update_file(struct add_p_state *s,
> >                            struct file_diff *file_diff)
> >  {
> > @@ -1448,9 +1461,10 @@ static int patch_update_file(struct add_p_state =
*s,
> >       ssize_t i, undecided_previous, undecided_next, rendered_hunk_inde=
x =3D -1;
> >       struct hunk *hunk;
> >       char ch;
> > -     struct child_process cp =3D CHILD_PROCESS_INIT;
>
> This is related to the hoisting of the actual patch application to
> the caller, but it is not explained why such a change is needed, and
> it byitself, even without the "jump to the next file before deciding
> on all the hunks" feature.  What problem is it solving???

I explained this below

>
> If it is necessary to move the code to run "git apply" to the
> caller, would it make sense to split this patch into at least two
> patches, one to do such a move, possibly another patch to change the
> function signature of patch_update_file() so that it takes the file
> index instead of file_diff struct, and finally another patch to
> allow jumping around the files?

Okay yes it would make much sense.

>
> >       int colored =3D !!s->colored.len, quit =3D 0, use_pager =3D 0;
> >       enum prompt_mode_type prompt_mode_type;
> > +     size_t file_diff_index =3D get_file_diff_index(s, file_diff);
> > +     int all_decided =3D 0;
> >
> >       /* Empty added files have no hunks */
> >       if (!file_diff->hunk_nr && !file_diff->added)
> > @@ -1467,7 +1481,9 @@ static int patch_update_file(struct add_p_state *=
s,
> >                       ALLOW_GOTO_NEXT_UNDECIDED_HUNK =3D 1 << 3,
> >                       ALLOW_SEARCH_AND_GOTO =3D 1 << 4,
> >                       ALLOW_SPLIT =3D 1 << 5,
> > -                     ALLOW_EDIT =3D 1 << 6
> > +                     ALLOW_EDIT =3D 1 << 6,
> > +                     ALLOW_GOTO_PREVIOUS_FILE =3D 1 << 7,
> > +                     ALLOW_GOTO_NEXT_FILE =3D 1 << 8
> >               } permitted =3D 0;
> >
> >               if (hunk_index >=3D file_diff->hunk_nr)
> > @@ -1499,8 +1515,7 @@ static int patch_update_file(struct add_p_state *=
s,
> >               /* Everything decided? */
> >               if (undecided_previous < 0 && undecided_next < 0 &&
> >                   hunk->use !=3D UNDECIDED_HUNK)
> > -                     break;
> > -
> > +                             all_decided =3D 1;
> >               strbuf_reset(&s->buf);
> >               if (file_diff->hunk_nr) {
> >                       if (rendered_hunk_index !=3D hunk_index) {
> > @@ -1548,6 +1563,16 @@ static int patch_update_file(struct add_p_state =
*s,
> >                               permitted |=3D ALLOW_EDIT;
> >                               strbuf_addstr(&s->buf, ",e");
> >                       }
> > +                     if (file_diff_index >=3D 0 &&
> > +                             file_diff_index < s->file_diff_nr - 1) {
> > +                             permitted |=3D ALLOW_GOTO_NEXT_FILE;
> > +                             strbuf_addstr(&s->buf, ",>");
> > +                     }
> > +                     if (file_diff_index > 0 &&
> > +                             file_diff_index <=3D s->file_diff_nr - 1)=
 {
> > +                             permitted |=3D ALLOW_GOTO_PREVIOUS_FILE;
> > +                             strbuf_addstr(&s->buf, ",<");
> > +                     }
>
> As can be seen in what patch_update_file() does when the user says
> 'J' or 'K', hunks in a file are treated as a ring, and these
> commands are enabled as long as there are more than one hunks.
>
> Perhaps that is more familiar than "when we hit the floor, we cannot
> sink deeper, and when we hit the ceiling, we cannot float more",
> which seems to be what the above implements.

Yes I understand this now.
It does make sense this way.

>
> >                       strbuf_addstr(&s->buf, ",p,P");
> >               }
> >               if (file_diff->deleted)
> > @@ -1566,6 +1591,9 @@ static int patch_update_file(struct add_p_state *=
s,
> >                                               : 1));
> >               printf(_(s->mode->prompt_mode[prompt_mode_type]),
> >                      s->buf.buf);
> > +             if (all_decided)
> > +                     printf(_("\n%s All hunks decided. What now? "),
> > +                             s->s.prompt_color);
> >               if (*s->s.reset_color_interactive)
> >                       fputs(s->s.reset_color_interactive, stdout);
> >               fflush(stdout);
> > @@ -1618,7 +1646,24 @@ static int patch_update_file(struct add_p_state =
*s,
> >               } else if (ch =3D=3D 'q') {
> >                       quit =3D 1;
> >                       break;
> > -             } else if (s->answer.buf[0] =3D=3D 'K') {
> > +             } else if (s->answer.buf[0] =3D=3D '>') {
> > +                     if (permitted & ALLOW_GOTO_NEXT_FILE) {
> > +                             quit =3D 0;
> > +                             break;
> > +                     } else {
> > +                             err(s, _("No next file"));
> > +                             continue;
> > +                     }
> > +             } else if (s->answer.buf[0] =3D=3D '<') {
> > +                     if (permitted & ALLOW_GOTO_PREVIOUS_FILE) {
> > +                             quit =3D 2;
> > +                             break;
>
> What's the magic number "2"?  Should "quit" become an enum with
> elements that are more meaningfully named?

Okay, yes an enum would be better.

>
> > +                     } else {
> > +                             err(s, _("No previous file"));
> > +                             continue;
> > +                     }
> > +             }
> > +             else if (s->answer.buf[0] =3D=3D 'K') {
> >                       if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
> >                               hunk_index =3D dec_mod(hunk_index,
> >                                                    file_diff->hunk_nr);
> > @@ -1775,33 +1820,6 @@ static int patch_update_file(struct add_p_state =
*s,
> >               }
> >       }
> >
> > -     /* Any hunk to be used? */
> > -     for (i =3D 0; i < file_diff->hunk_nr; i++)
> > -             if (file_diff->hunk[i].use =3D=3D USE_HUNK)
> > -                     break;
> > -
> > -     if (i < file_diff->hunk_nr ||
> > -         (!file_diff->hunk_nr && file_diff->head.use =3D=3D USE_HUNK))=
 {
> > -             /* At least one hunk selected: apply */
> > -             strbuf_reset(&s->buf);
> > -             reassemble_patch(s, file_diff, 0, &s->buf);
> > -
> > -             discard_index(s->s.r->index);
> > -             if (s->mode->apply_for_checkout)
> > -                     apply_for_checkout(s, &s->buf,
> > -                                        s->mode->is_reverse);
> > -             else {
> > -                     setup_child_process(s, &cp, "apply", NULL);
> > -                     strvec_pushv(&cp.args, s->mode->apply_args);
> > -                     if (pipe_command(&cp, s->buf.buf, s->buf.len,
> > -                                      NULL, 0, NULL, 0))
> > -                             error(_("'git apply' failed"));
> > -             }
> > -             if (repo_read_index(s->s.r) >=3D 0)
> > -                     repo_refresh_and_write_index(s->s.r, REFRESH_QUIE=
T, 0,
> > -                                                  1, NULL, NULL, NULL)=
;
> > -     }
>
> It is not obvious why the above code needs to be hoisted to the
> caller.

I explained this below.

>
> >       putchar('\n');
> >       return quit;
> >  }
> > @@ -1813,7 +1831,9 @@ int run_add_p(struct repository *r, enum add_p_mo=
de mode,
> >       struct add_p_state s =3D {
> >               { r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
> >       };
> > -     size_t i, binary_count =3D 0;
> > +     size_t i, j, binary_count =3D 0;
> > +     size_t patch_update_result =3D 0;
>
> Hmph, I think patch_update_file() returns "int quit".  Why do we
> want overly wide type to store the result, which cannot even express
> negative number to potentially signal a failure?

Sorry, this is a mistake on my part

>
> > +     struct child_process cp =3D CHILD_PROCESS_INIT;
> >
> >       init_add_i_state(&s.s, r, o);
> >
> > @@ -1852,11 +1872,56 @@ int run_add_p(struct repository *r, enum add_p_=
mode mode,
> >               return -1;
> >       }
> >
> > -     for (i =3D 0; i < s.file_diff_nr; i++)
> > -             if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
> > +     for (i =3D 0; i < s.file_diff_nr;) {
> > +             if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr) {
> >                       binary_count++;
> > -             else if (patch_update_file(&s, s.file_diff + i))
> > -                     break;
> > +                     i++;
> > +                     continue;
> > +             }
> > +             else {
> > +                     patch_update_result =3D patch_update_file(&s, s.f=
ile_diff + i);
> > +                     if (patch_update_result =3D=3D 0) {
> > +                             i++;
> > +                             continue;
> > +                     }
> > +                     if (patch_update_result =3D=3D 1)
> > +                             break;
> > +                     if (patch_update_result =3D=3D 2) {
> > +                             i--;
> > +                             continue;
> > +                     }
> > +             }
> > +     }
> > +     for (i =3D 0; i < s.file_diff_nr; i++) {
> > +
> > +                     /* Any hunk to be used? */
> > +             for (j =3D 0; j < s.file_diff[i].hunk_nr; j++)
> > +                     if (s.file_diff[i].hunk[j].use =3D=3D USE_HUNK)
> > +                             break;
> > +
> > +             if (j < s.file_diff[i].hunk_nr ||
> > +         (!s.file_diff[i].hunk_nr && s.file_diff[i].head.use =3D=3D US=
E_HUNK)) {
> > +                     /* At least one hunk selected: apply */
> > +                     strbuf_reset(&s.buf);
> > +                     reassemble_patch(&s, s.file_diff + i, 0, &s.buf);
> > +
> > +                     discard_index(s.s.r->index);
> > +                     if (s.mode->apply_for_checkout)
> > +                             apply_for_checkout(&s, &s.buf,
> > +                                             s.mode->is_reverse);
> > +                     else {
> > +                             setup_child_process(&s, &cp, "apply", NUL=
L);
> > +                             strvec_pushv(&cp.args, s.mode->apply_args=
);
> > +                             if (pipe_command(&cp, s.buf.buf, s.buf.le=
n,
> > +                                             NULL, 0, NULL, 0))
> > +                                     error(_("'git apply' failed"));
> > +                     }
> > +                     if (repo_read_index(s.s.r) >=3D 0)
> > +                             repo_refresh_and_write_index(s.s.r, REFRE=
SH_QUIET, 0,
> > +                                                             1, NULL, =
NULL, NULL);
> > +             }
> > +
> > +     }
>
> One upside of having "git apply" at the end of patch_update_file()
> is that you can "^C" out of "git add -p" or your terminal connection
> can be cut off, after dealing with hunks in a few early files, and
> these early part of your work that you have already done are already
> reflected to the working tree files.  By hoisting the logic to the
> caller, this is making the update all-or-none, which is good in
> transactional systems, but can make a horrible experience for an
> interactive use where you make progress while thinking.
>
> So I am not yet convinced if this change makes sense---it could be
> because of the lack of justification for this change.

What I observed after adding the '>' and '<' options is that if a user choo=
ses
to use a hunk A in file 1, and then goes to file 2 with '>', comes back to
file 1 with '<', and decides on hunk A to skip it instead, because
patch_update_file() has
applied the file with the hunk the user initially decided to use
before proceeding to file
2 with '>', coming back to redecide and say skip does not apply the
latest decision
and when you check the index, the file with the hunks which the user
initially decided to
use but changed to skip is present in the index.

But if the user initially decided to skip a hunk in a file, goes to
the next file with '>'
and back to the first file, changes the decision on the hunk to use,
it applies the patch
with the hunk because the hunk was not initially selected when the
patch was applied.
But if he now goes away and comes back to the file a third time and
chooses to skip the
hunk, then quits with 'q', because he had selected to use the hunk the
second time,
choosing skip again will not work.

So basically, initially choosing to use a hunk in a file, going to
another file and coming
back to this file then choosing to skip it does not register the
latest skip decision
on that hunk.

That was why I decided to do it this way.
I will appreciate a better suggestion from you

Thanks
Abraham.
