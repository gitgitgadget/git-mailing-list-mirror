Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519034CFDE
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465177; cv=pass; b=O4RfhIzU7/Mr+d7/CdfEXqO/ZT03NxQwskDH5XhfpElJsCHoh0nhB1AYcDuJd1WC2zDKAEH+K+PpKUPoh7JutcxItyi56pyhppo3rwAhkSIgfSFaT5nZ5dk1R2lCl0nnXP0Xa2CKndFLkjcNXNgUzc9YdSdRjZ6a9FW/V/HbTR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465177; c=relaxed/simple;
	bh=8pPHBBUqaYVdSs+qnr7vyMd0bzhgZWikvz21tLUatb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9VKj1f+64A+C7afozaHBmZ7RXFKyZt0vLEExnzqyMqu4IwYTUrip6LZUB/CIgttQK1sihE1T4UuPcbwzF9cmA9acj/V3PfnJFtYi/RD4HkO//hnPIDjo93Pny3XFztzyLhvosF0mbb6rZ2VxfoMI7qe/M4o5B4CypjXVmVNha4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWJKfhFp; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWJKfhFp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66a87eb232bso187446a12.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774465173; cv=none;
        d=google.com; s=arc-20240605;
        b=lfRPjzt4ZOt0Tr0bmG5IpuOUFLg89sqZUu6QzTavIwqsKgyx1JQpm7A0Rk7noNoPKa
         o3z+SWd3268SyJdDgF/V9jGtB6WHSYJNLjME9O1cnIB8jpJcpcbvFf/fTvZ7Y4f5LRMn
         MMhUeqwoTRMpk5Qqy1yNi3gmTPLwIkXuIubxkR9tikE1bvoMht2jr8+gY0CI3NTAt5B5
         5pyYDTaXEeid615MncieRmFM/vffZ/Q5Doniy1VoFQuAV8CYjcvVrym13wdjCPVm/8Uf
         h2rRELtX26iuk4rCLllTpZBafKL80jT3nu0F7f3/RjPSHRAs3NdKiraogSEp4p4m/DIV
         NwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tYSbLsVwQCrezue8YJ9bCgX6xhjQHZyflOsc5X5hlsc=;
        fh=g/XWdCTF7KcYezcq936vtuk4WrtkI+WeNGpzChYlTOY=;
        b=aLKNY2E9kAGWwdrwRdRGwE32D2X0SEz0qsX8Q4pskSRBi22qc4F5tV2BxzxPWLIFiJ
         XezJIbTj6gyRHu0DD7wMva1Yefg1LxuIJfDpulI8Ce33EG3emG4+4MQsZbGmXnXt/luU
         7Ak27PyQpFnQiJXkdmOizEO7YRKThjcknPZftkLqng4L0tIwgaNxTRPDIaKZwUm7cV0R
         TsshIoM269JbAnRggiZP0OLqC6geCeSmwexh3VCZgRNQFfWkU0q9G64v8A3jPPBp9TOi
         TOn8bhfQEJeeAqNjCwYc4+RRBd6WXO6bcld4TJescEvRmJDcQ7e+kO0Ot5/5Qn46jtqk
         QbLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774465173; x=1775069973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYSbLsVwQCrezue8YJ9bCgX6xhjQHZyflOsc5X5hlsc=;
        b=hWJKfhFpbhawziu+aL/rsMfwH2dtus1i5dRzpk5nb6xplioJXnwFGIs97E+7p9Htng
         ilgx72c+/KJ1+atqyXhRcTTepZ3Wh3x8Le9YmPHnWzAifb6ciT98umqQQ+fJNuA6yuVq
         OogrDOiUB714DfqfuICoMeD6c1z6y4utwluP+UQicT4kxqqg+kypa/OASAPTscl57Wh7
         3er+EE1pF5xS4M6s4Pm3tp6n8V9ysaaWkhWjIXgqPhcK1Uv6aP7dFUhandD+5aCPKQfA
         MiYMrEzOsuODFHQGx898nZaNL3B+d43H7YAHdrcfWKQseBGq2ouORCDQ5Cd67j8a+M4d
         NEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774465173; x=1775069973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tYSbLsVwQCrezue8YJ9bCgX6xhjQHZyflOsc5X5hlsc=;
        b=aVO8qaifMIfjsN8ezeFB2xUhpuaFTN3gtsHRp6VGL2clc9V7sAi8gw5PTjGu9nRvKv
         SSlCyve2Clo4N4gjEyv/mJYu+CvsKvTydhFO6cZCEBdT7FVdgKoVmskMeOpJ0ixnwTNK
         69WCTk+LqbwAN06AhCY8+GeIhq/FsjhDtwOK0yQ0byVgWKmg31kR/UQSBvLdja7U54KD
         l5WjK4kS13y/pn1MO+sGn/PckmzsIeHWBysmiMH21r5JzNIAJ3Hlwwtca0R7GcTtVEPa
         lmeJPhEBwWh+d56tJITwN1FaB57YBSemCzOgEDByqPBfnRfrQQ2qYXqBSwz3ucdmO6yN
         SL4A==
X-Gm-Message-State: AOJu0YyOSaR/jyU4D2mJ35tl86JLGUG08BEz9cfXn1UWxTqZPy7Ps3US
	tgOFkMe4b0wBpN++Q/SZ0q3erCp4l/54qHTMvxzzgQzkcrCeOcAA+RYPx/amg9x9FAMN+EG2JT9
	Mq1vFcYZJEow2iJthvlYAgdQEeWTygaU=
X-Gm-Gg: ATEYQzxHqtL2/C2w2MMTCkdwYfColyboKV9UMGHVGsuvPwlYz8PoW5qDFmeXBslaUJ2
	erLYcxRsnpRmNvLg0ZMkK0KjTIgdmlx2C9pdnEVROLr7Q5oi+5Dmj9P/SUn5GIaAZQ8gd321zVr
	l4zG4eohs1qyQFVe8tHSyCTddc7cGwIXz8Z4xS8j4XqmPESD8yEK7nr3ss4LLz6NHeXf1q1l7Oc
	7bxmarxL4xeaoBZ01fadL8OcaqObRh0vI6zegqu629pbtEbVMzm+rPLqpskM6CW5BoJLYl/GMaI
	sG8hNJjv2O2sBUb0FC2K7eQjJ0S5supmy8Cv18Gcia2aWIIVh5+IqWsSkzzNrDQcID4KK6QW5Q=
	=
X-Received: by 2002:a05:6402:52c7:b0:66a:5c2:51cc with SMTP id
 4fb4d7f45d1cf-66a82618054mr3059887a12.4.1774465172938; Wed, 25 Mar 2026
 11:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325075055.354709-1-luizedc1@gmail.com> <20260325075055.354709-2-luizedc1@gmail.com>
 <a4305ef7-50ff-4a68-ab42-fe2fa73e8f37@gmx.de>
In-Reply-To: <a4305ef7-50ff-4a68-ab42-fe2fa73e8f37@gmx.de>
From: Luiz Eduardo Campos <luizedc1@gmail.com>
Date: Wed, 25 Mar 2026 15:58:13 -0300
X-Gm-Features: AQROBzDF1eosJg_pAe9tHBRIiPoDrkZgJh_gf0AdIFsAJAcqsA-lJDGWxjQ7NUQ
Message-ID: <CAN+A6Tsmc9zo+jYCurEjG+oz+FtNJv1CbVGBrJaRKY27N-=pTA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] add -p: support discarding hunks with 'x'
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, peff@peff.net, sagotsky@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

Thank you for taking the time to review this!

> This hunk is quite hard to read because of the `if ... else ...` -> `if {
> ... continue; } ...` change that de-indents a large chunk of code.

You are right. Even though you marked it as "not really actionable",
I think it is worth fixing: I can keep the original if/else structure
and just replace the condition with the should_merge_hunk() call.
That avoids the indentation churn and keeps the diff focused on what
actually changes.

> If you detect an empty patch here and indicate this via an early return
> value, then...
> ... then this loop is no longer necessary.

Good idea. I will have apply_discard_hunks() check whether any hunk
is marked DISCARD_HUNK before going through the apply machinery, and
use the return value to distinguish "nothing to do" from "applied" and
"error". With that in place the pre-scan loop in apply_patch() can be
dropped, and needs_refresh can just be set based on whether
apply_discard_hunks() actually applied something.

I will address this in v2; the implementation might still live in add -p,
or I may fold it into a shared path that fits better (suggestions are
welcome!)

Thanks,
Luiz

Em qua., 25 de mar. de 2026 =C3=A0s 13:49, Johannes Schindelin
<Johannes.Schindelin@gmx.de> escreveu:
>
> Hi Luiz,
>
> On Wed, 25 Mar 2026, Luiz Campos wrote:
>
> > When using `git add -p`, users can stage or skip hunks,
> > but cannot discard unwanted changes from the working tree.
> >
> > Introduce a new 'x' action to discard the current hunk by
> > reverse-applying it.
> >
> > This idea was suggested in a previous mailing list discussion:
> > https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.ne=
t/t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0
>
> Sounds good!
>
> Just two minor comments (not really actionable, I think):
>
> > @@ -1026,25 +1046,26 @@ static void reassemble_patch(struct add_p_state=
 *s,
> >               struct hunk merged =3D { 0 };
> >
> >               hunk =3D file_diff->hunk + i;
> > -             if (!use_all && hunk->use !=3D USE_HUNK)
> > +             if (!should_merge_hunk(file_diff, i, use_all, merge_for_d=
iscard)) {
> >                       delta +=3D hunk->header.old_count
> >                               - hunk->header.new_count;
> > -             else {
> > -                     /* merge overlapping hunks into a temporary hunk =
*/
> > -                     if (merge_hunks(s, file_diff, &i, use_all, &merge=
d))
> > -                             hunk =3D &merged;
> > +                     continue;
> > +             }
> >
> > -                     render_hunk(s, hunk, delta, 0, out);
> > +             if (merge_hunks(s, file_diff, &i, use_all, &merged,
> > +                             merge_for_discard))
> > +                     hunk =3D &merged;
> >
> > -                     /*
> > -                      * In case `merge_hunks()` used `plain` as a scra=
tch
> > -                      * pad (this happens when an edited hunk had to b=
e
> > -                      * coalesced with another hunk).
> > -                      */
> > -                     strbuf_setlen(&s->plain, save_len);
> > +             render_hunk(s, hunk, delta, 0, out);
> >
> > -                     delta +=3D hunk->delta;
> > -             }
> > +             /*
> > +              * In case `merge_hunks()` used `plain` as a scratch
> > +              * pad (this happens when an edited hunk had to be
> > +              * coalesced with another hunk).
> > +              */
> > +             strbuf_setlen(&s->plain, save_len);
> > +
> > +             delta +=3D hunk->delta;
>
> This hunk is quite hard to read because of the `if ... else ...` -> `if {
> ... continue; } ...` change that de-indents a large chunk of code.
>
> After pouring over the diff for a bit, I was able to convince myself that
> the diff is correct.
>
> > @@ -1547,21 +1570,57 @@ N_("j - go to the next undecided hunk, roll ove=
r at the bottom\n"
> >     "? - print help\n"
> >     "HUNKS SUMMARY - Hunks: %d, USE: %d, SKIP: %d\n");
> >
> > +static int apply_discard_hunks(struct add_p_state *s,
> > +                            struct file_diff *file_diff)
> > +{
> > +     struct child_process check_cp =3D CHILD_PROCESS_INIT;
> > +     struct child_process apply_cp =3D CHILD_PROCESS_INIT;
> > +
> > +     strbuf_reset(&s->buf);
> > +     reassemble_patch(s, file_diff, 0, REASSEMBLE_DISCARD, &s->buf);
>
> If you detect an empty patch here and indicate this via an early return
> value, then...
>
> > +
> > +     discard_index(s->index);
> > +
> > +     setup_child_process(s, &check_cp, "apply", "-R", "--check", NULL)=
;
> > +     if (pipe_command(&check_cp, s->buf.buf, s->buf.len, NULL, 0, NULL=
, 0)) {
> > +             error(_("'git apply -R --check' failed"));
> > +             return -1;
> > +     }
> > +
> > +     setup_child_process(s, &apply_cp, "apply", "-R", NULL);
> > +     if (pipe_command(&apply_cp, s->buf.buf, s->buf.len, NULL, 0, NULL=
, 0)) {
> > +             error(_("'git apply -R' failed"));
> > +             return -1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static void apply_patch(struct add_p_state *s, struct file_diff *file_=
diff)
> >  {
> >       struct child_process cp =3D CHILD_PROCESS_INIT;
> >       size_t j;
> > +     int needs_refresh =3D 0;
> > +
> > +     if (s->mode =3D=3D &patch_mode_add) {
> > +             for (j =3D 0; j < file_diff->hunk_nr; j++) {
> > +                     if (file_diff->hunk[j].use =3D=3D DISCARD_HUNK)
> > +                             break;
> > +             }
> > +             if (j < file_diff->hunk_nr && apply_discard_hunks(s, file=
_diff))
> > +                     return;
> > +             if (j < file_diff->hunk_nr)
> > +                     needs_refresh =3D 1;
> > +     }
>
> ... then this loop is no longer necessary.
>
> Other than that, looks good to me!
>
> Ciao,
> Johannes
