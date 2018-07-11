Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9691F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbeGKQCX (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 12:02:23 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:44691 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeGKQCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 12:02:23 -0400
Received: by mail-oi0-f43.google.com with SMTP id s198-v6so50150211oih.11
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rcUpPefkzlmOQq2mblAJnBhdPeE8FODSWHZb7LZsLZs=;
        b=rbu8E7epEmS2/QEFIz8hyYt7xT8az0f66ue427QwH9X+TxEeyMyIUO4CHzqJ3zquB1
         jw7nOfI1Ct2nEm8qdfp2mBPwrRzhl4Wu6B+LpXoMRrKLuNBlL7/PGbvN5q8mzpozs/dv
         ++FBXqNmu/3kVA5EXDenAvxh++vwGodfb1JUE54KSkwSo7sEEpkg1n7EZEHsG9TdpYQ8
         NCfnCj3NVWli3BOAGMZri3AGjOj2oIPBBOODd/eV5qmj1TUUm7/10A0mSFyRBYVQSkhq
         e0/dv1X6ugq9LaUhI5boGomquCWTjbkDs9UO2jNVPiXTZJxBxBCgx/fLCacEqqX2JKD5
         cUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rcUpPefkzlmOQq2mblAJnBhdPeE8FODSWHZb7LZsLZs=;
        b=ib/z4tNKTrc6f1PP9/6nXRlf2+7jKbC5wTvb4Rwg04PIlmk471CDiGEnyrGkceUBo0
         /7e0XRu/BGS8bzjM0BdTQXRL2AS0Vy9I2iILAFDO347IReMRaIJ4o8huXc9+FrNxABHW
         woNWZ4d2z7qS5gujd+Ynrfywrkoik1+QyfXVrxp4P9Wh/pOy2AR7ygFX4d1flmeOZB8u
         mxECpgzED/KefHuO7YjdVqEsO93fnyAjdJfJDOg5NRaYPZnvklXso8CR/shwTO8ykvo8
         PYT9YkaiU/HSAUizi3ocoxsT6+z1pWgWsrMdGPqbhEp14lQoSYkblr7LtcNiZPk0IN2l
         WaNg==
X-Gm-Message-State: APt69E3649IZ7YvgGEnhQ+xmoMtO8Z5+rsEqd+r9CavEj9rPtzsXsCmh
        iME0sMoGWQKRCN4eQB7kDkeImR7NlrQM2dBUwLc=
X-Google-Smtp-Source: AAOMgpeaW1DTwHi2Wm1WCFTsGfG3fbtH3e9l/e0EoxqRszOhMwg5IClYVBOK7o8ATIRr0l4mHB1WkTpV0cpiq4roDoY=
X-Received: by 2002:a54:4406:: with SMTP id k6-v6mr22749887oiw.34.1531324644272;
 Wed, 11 Jul 2018 08:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <87k1q2c9zq.fsf@evledraar.gmail.com>
In-Reply-To: <87k1q2c9zq.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 11 Jul 2018 17:56:56 +0200
Message-ID: <CACsJy8BM7zJxgeM37YQ4Yh4bH=4iS5CJ2P_-4Vm3oA+cuQYkJA@mail.gmail.com>
Subject: Re: BUG: Segfault on "git pull" on "bad object HEAD"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 1:02 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This segfaults, but should print an error instead, have a repo with a
> corrupt HEAD:
>
>     (
>         rm -rf /tmp/git &&
>         git clone --single-branch --branch todo git@github.com:git/git.gi=
t /tmp/git &&
>         echo 1111111111111111111111111111111111111111 >/tmp/git/.git/refs=
/heads/todo &&
>         git -C /tmp/git pull
>     )
>
> On this repository e.g. "git log" will print "fatal: bad object HEAD",
> but for some reason "git pull" makes it this far:
>
>     $ git pull
>     Segmentation fault
>
> The immediate reason is that in run_diff_index() we have this:
>
>         ent =3D revs->pending.objects;
>
> And that in this case that's NULL:

Probably because add_head_to_pending() in has_uncommitted_change()
does not add anything to the "pending" list because HEAD is broken.

I think if we make add_head_to_pending() return a boolean, then we can
check that if no HEAD is added, there's no point to run_diff_index and
has_uncommitted_changes() can return 0 immediately.

A new BUG() could still be added in run_diff_index() though, to check
if revs->pending.nr is non-zero before attempting to access
revs->pending.objects.

>
>     (gdb) bt
>     #0  0x000055555565993f in run_diff_index (revs=3D0x7fffffffcb90, cach=
ed=3D1) at diff-lib.c:524
>     #1  0x00005555557633da in has_uncommitted_changes (ignore_submodules=
=3D1) at wt-status.c:2345
>     #2  0x00005555557634c9 in require_clean_work_tree (action=3D0x5555557=
98f18 "pull with rebase", hint=3D0x555555798efb "please commit or stash the=
m.", ignore_submodules=3D1, gently=3D0) at wt-status.c:2370
>     #3  0x00005555555dbdee in cmd_pull (argc=3D0, argv=3D0x7fffffffd868, =
prefix=3D0x0) at builtin/pull.c:885
>     #4  0x000055555556c9da in run_builtin (p=3D0x555555a2de50 <commands+1=
872>, argc=3D1, argv=3D0x7fffffffd868) at git.c:417
>     #5  0x000055555556cce2 in handle_builtin (argc=3D1, argv=3D0x7fffffff=
d868) at git.c:633
>     #6  0x000055555556ce8a in run_argv (argcp=3D0x7fffffffd71c, argv=3D0x=
7fffffffd710) at git.c:685
>     #7  0x000055555556d03f in cmd_main (argc=3D1, argv=3D0x7fffffffd868) =
at git.c:762
>     #8  0x0000555555611786 in main (argc=3D3, argv=3D0x7fffffffd858) at c=
ommon-main.c:45
>     (gdb) p revs
>     $4 =3D (struct rev_info *) 0x7fffffffcb90
>     (gdb) p revs->pending
>     $5 =3D {nr =3D 0, alloc =3D 0, objects =3D 0x0}
>     (gdb)
>
> This has been an issue since at least v2.8.0 (didn't test back
> further). I'm not familiar with the status / diff code, so I'm not sure
> where the assertion should be added.
>
> This came up in the wild due to a user with a corrupt repo (don't know
> how it got corrupt) trying "git pull" and seeing git segfault.



--=20
Duy
