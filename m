Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096851F406
	for <e@80x24.org>; Wed,  3 Jan 2018 18:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeACS0I (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 13:26:08 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43202 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeACS0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 13:26:07 -0500
Received: by mail-pf0-f196.google.com with SMTP id e3so1062136pfi.10
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P2pCKrwDPFKOK32oREx+weimd/ctvN2Zdf6lvX+U/8I=;
        b=qKmQi7Vt0idNnDb6kYqAnHS+8fSjLZTYBEeQSkYe+1g/F9IZd2FsLob1OC0k+08Bnb
         NXl1pjdef/KhEj+7L4HuA0mHZQrefomuUug4LUMwz7r0jnsOX2a1+WyZtx26zSUHLkT4
         qNGRn7ZJ8JbWK1JTkceZM07XeDrJRM1yKuMGmnV3KEC9RA9LXCcpdW8txKJRNsxN2QoQ
         hxfPmr5qvILG7ZNZbH87+27q0soIaIO1Q5crF8V0yENX2MrUBNRcXOPS1LdpTPUPXqyE
         JBbSBElkBvqJyYCSE73o93GJGhtWZNM+I3keUSuEXUmsfaMFscrrL92plH+RKZX/Oc4X
         QXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P2pCKrwDPFKOK32oREx+weimd/ctvN2Zdf6lvX+U/8I=;
        b=sYQPpXP15qj/9sV37XcnzOtQjbGaKakw02eaQL/QACG2kmx88/Kc0L5pyzr2ILvv+H
         2ptjtNvzvYutFou9rcSgZ0FkxO4aK8ZxSOmJYjROaM4t7iL4KUJasINZH0dHvKgrMT5d
         tetnzRAxlAGOD41YJ4iOlBmYB6ZFkSg7MWXPqVcVjxBnT/33QZWAmU6rVTMz5Fr4ejeK
         OmNPFiDKdt3Z4tf8Ufkbv0OJk2sRfTyo1N85nk3riRK0wpnG9rDoxryAPkkHVSxX9yNa
         aPY4YHp77KsA7GpGKQBvRV6mVuGvE03ISjG0QcMTEmYwdMasW+PfsSQ7nlqlAvBB44TA
         ljvA==
X-Gm-Message-State: AKGB3mL+z1Zef7qeYNxBbuFL4iaQFQAMmuqI6qbzkTS1Bu6F7pQYW6x5
        ZhnTrm8sKklB9LCIicNd1mrkLoJS0GV1QyHg7rs=
X-Google-Smtp-Source: ACJfBoseNU3g/xJsI+CgJvBb/9NH7xv8c/Qpf2dyUE5m4U1lTF/cb0HwzIdZDFL1x+cLac/R/5Xq6bro9Nbz8gSSgAM=
X-Received: by 10.101.65.205 with SMTP id b13mr1995597pgq.30.1515003967108;
 Wed, 03 Jan 2018 10:26:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.179.136 with HTTP; Wed, 3 Jan 2018 10:26:06 -0800 (PST)
In-Reply-To: <87fu7nc9a2.fsf@evledraar.gmail.com>
References: <CAELBRWKYZK2tVhGZSExXRXrRB94jFN-4N3d=iKARzEsqLu7k1g@mail.gmail.com>
 <87fu7nc9a2.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 3 Jan 2018 19:26:06 +0100
Message-ID: <CAN0heSrZ4dEFqNX69PgtGCERJKabokz88v-vnNZkUBXfK118mg@mail.gmail.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Yasushi SHOJI <yasushi.shoji@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 January 2018 at 15:21, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com> wrote:
>
> On Wed, Jan 03 2018, Yasushi SHOJI jotted:
>
>> Hi,
>>
>> git version 2.16.0.rc0 seg faults on my machine when I
>> [...]
>> Program terminated with signal SIGSEGV, Segmentation fault.
>> #0  0x000055a73107f900 in best_bisection_sorted (list=3D0x0, nr=3D0) at =
bisect.c:232
>> 232 free_commit_list(p->next);
>> (gdb) bt
>> #0  0x000055a73107f900 in best_bisection_sorted (list=3D0x0, nr=3D0) at =
bisect.c:232
>> #1  0x000055a73107fc0f in do_find_bisection (list=3D0x0, nr=3D0,
>> weights=3D0x55a731b6ffd0, find_all=3D1) at bisect.c:361
>> #2  0x000055a73107fcf4 in find_bisection (commit_list=3D0x7ffe8750d4d0,
>> reaches=3D0x7ffe8750d4c4, all=3D0x7ffe8750d4c0, find_all=3D1) at
>> bisect.c:400
>> #3  0x000055a73108128d in bisect_next_all (prefix=3D0x0, no_checkout=3D0=
)
>> at bisect.c:969
>> #4  0x000055a730fd5238 in cmd_bisect__helper (argc=3D0,
>> argv=3D0x7ffe8750e230, prefix=3D0x0) at builtin/bisect--helper.c:140
>> #5  0x000055a730fcbc76 in run_builtin (p=3D0x55a73145c778
>> <commands+120>, argc=3D2, argv=3D0x7ffe8750e230) at git.c:346
>> #6  0x000055a730fcbf40 in handle_builtin (argc=3D2, argv=3D0x7ffe8750e23=
0)
>> at git.c:554
>> #7  0x000055a730fcc0e8 in run_argv (argcp=3D0x7ffe8750e0ec,
>> argv=3D0x7ffe8750e0e0) at git.c:606
>> #8  0x000055a730fcc29b in cmd_main (argc=3D2, argv=3D0x7ffe8750e230) at =
git.c:683
>> #9  0x000055a731068d9e in main (argc=3D3, argv=3D0x7ffe8750e228) at comm=
on-main.c:43
>> (gdb) p p
>> $1 =3D (struct commit_list *) 0x0
>>
>> As you can see, the code dereferences to the 'next' while 'p' is NULL.
>>
>> I'm sure I did 'git bisect good' after git _found_ bad commit.  Then I
>> typed 'git bisect skip' on the commit 726804874 of guile repository.
>> If that matters at all.
>>
>> I haven't touched guile repo to preserve the current state.
>
> I can't reproduce this myself, but looking at the backtrace it seems
> pretty obvious that 7c117184d7 ("bisect: fix off-by-one error in
> `best_bisection_sorted()`", 2017-11-05) is the culprit.
>
> That changed more careful code added by Christian in 50e62a8e70
> ("rev-list: implement --bisect-all", 2007-10-22) to free a pointer which
> as you can see can be NULL.
>
> If you can test a patch to see if it works this should fix it:
>
> diff --git a/bisect.c b/bisect.c
> index 0fca17c02b..2f3008b078 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -229,8 +229,10 @@ static struct commit_list *best_bisection_sorted(str=
uct commit_list *list, int n
>                 if (i < cnt - 1)
>                         p =3D p->next;
>         }
> -       free_commit_list(p->next);
> -       p->next =3D NULL;
> +       if (p) {
> +               free_commit_list(p->next);
> +               p->next =3D NULL;
> +       }
>         strbuf_release(&buf);
>         free(array);
>         return list;
>
> But given the commit message by Martin maybe there's some deeper bug here=
.

I haven't tried to reproduce, or tested the patch, but from the looks of
it, your analysis and fix are both spot on. The special case that yashi
has hit is that `list` is NULL. The old code handled that very well, the
code after my patch ... not so well. The loop-sort-loop pattern reduces
to a no-op, both before and after my patch. But what I failed to realize
was that `list` could be NULL.

This could be fixed by an early return if `list` is NULL, but that would
also need some memory-handling. So I think your patch is just as good or
better, since it can be seen as restoring what was lost in 7c117184d7.

Thanks both, and sorry for this.
Martin
