Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B744C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 02:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiGZCO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiGZCOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 22:14:25 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEF828715
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 19:14:24 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id mz20so9751971qvb.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 19:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YVv+MMlQwoZdv9v5lS5XWMkly+m+wbrTM9W/gHx5ai0=;
        b=YCnrGERXdF8jzg9R6qsvkTRnd+1oiwZkhIlATC5TKJMIh8vt+hgSKrbiyWXX/jZWtn
         Ay8FbD+Tk0sMdI6Z16KbmhVHrrmPPZ2g08DtKIJe/vcJyfY4q6vfagJqh4UkNa48Rtjx
         qGexwM5f5eXekcAPe5Wm+GNI7yOa+6WeEmzjVvzKmlcUgUiJ1r1dB68xIRC66Raj00sk
         Tg5/m4KVbfyWsgAUMiENjPfIWvJ9i0CQR79qtAIn9BJw1h5GfkaDqBNzBPlb5GGj4fXL
         bj5NHWyRHbpzlNkP/7fJ3XW34XHvTJwgDi1RS/5+mcTlonvwMbt0Dvzl4p/eRe5+B/sX
         PaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YVv+MMlQwoZdv9v5lS5XWMkly+m+wbrTM9W/gHx5ai0=;
        b=0uqrXgELLbxZbGSByFG7UiUX2PM/b/vFrpHq9GEK7XLlab5l5nCPzQKWJUe5mkiB9A
         g/tsP4TZEbAYM7ZShzaRJ0eE+IvY8mD6DZnwyaVaDBFGwdLT+igV35km8ZMS//Ddn3bi
         8PF8tsX0hKMG0SbNcDGsypjLwExFepa2USzyQidwM7ZQWRDdYFNcYo/1tGD8CC31/QIS
         P/sFs2zbV0we3FKtvvRAeKH4bWHXdv2OmVWfoOR0iEH8XXgp/8gpgK6cHd2HpFYq7ZE9
         aOUGnld2TCUMZbp6LbhkLZ08Y8XjPrVTkPDkeTCLYynIE7MZmWYF/r9CrzoWgvFn0N5k
         fA3g==
X-Gm-Message-State: AJIora/hoPLuO4IXzh+m5ISCem4zJEjms4slYOA4U8m/h0dSSA3E88er
        nvoWJplT7z7h9s6BIUe5RAM+8+yQ/JfrugouUAI=
X-Google-Smtp-Source: AGRyM1snHaVGmnfs5UOz3gr6WNAyDDCGYuGn98hgJ6B2EApmsQkjBLAR8o/N+AgXCPzsf8kv+B+Q8P7Jl/ETDppgl/o=
X-Received: by 2002:a05:6214:21ec:b0:473:951b:5203 with SMTP id
 p12-20020a05621421ec00b00473951b5203mr12626363qvj.65.1658801663545; Mon, 25
 Jul 2022 19:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
 <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com> <d3eac3d0bf6539d81751813d89ec5158dcb57338.1656653000.git.gitgitgadget@gmail.com>
 <220701.86o7y9b2ys.gmgdl@evledraar.gmail.com> <220725.86zggxpfed.gmgdl@evledraar.gmail.com>
In-Reply-To: <220725.86zggxpfed.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 25 Jul 2022 19:14:12 -0700
Message-ID: <CABPp-BHvQwct2WRRYGyzm=YVkjmwBqoe1DUtCicuQW=jrQ2hdA@mail.gmail.com>
Subject: Re: C99 "for (int ..." form on "master" (was: [PATCH v3 4/5]
 merge-ort: shuffle the computation and cleanup of potential collisions)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 5:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jul 01 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > On Fri, Jul 01 2022, Elijah Newren via GitGitGadget wrote:
> > [...]
> >> @@ -3106,6 +3105,7 @@ static int detect_and_process_renames(struct mer=
ge_options *opt,
> >>  {
> >>      struct diff_queue_struct combined =3D { 0 };
> >>      struct rename_info *renames =3D &opt->priv->renames;
> >> +    struct strmap collisions[3];
> >>      int need_dir_renames, s, i, clean =3D 1;
> >>      unsigned detection_run =3D 0;
> >>
> >> @@ -3155,12 +3155,22 @@ static int detect_and_process_renames(struct m=
erge_options *opt,
> >>      ALLOC_GROW(combined.queue,
> >>                 renames->pairs[1].nr + renames->pairs[2].nr,
> >>                 combined.alloc);
> >> +    for (int i =3D MERGE_SIDE1; i <=3D MERGE_SIDE2; i++) {
> >
> > The "int i" here will need to be pre-declared earlier, per: 6563706568b
> > (CodingGuidelines: give deadline for "for (int i =3D 0; ...", 2022-03-3=
0)
> >
> > I also don't mind us just saying "we've waited enough". Junio?
>
> This case got fixed, but per the changed $subject others have snuck
> through.
>
> Since be733e12001 (Merge branch 'en/merge-tree', 2022-07-14) we've had
> these forms on "master", see 6debb7527b0 (merge-ort: store messages in a
> list, not in a single strbuf, 2022-06-18) and cb2607759e2 (merge-ort:
> store more specific conflict information, 2022-06-18).
>
> We could "fix" those, but per the above I think it's just as valid to
> just move up the deadline & say that 2.38.0 will have a hard dependency
> on this C99 feature...

Thanks for catching this and bringing it up; sorry for missing it earlier.

6563706568b says we should "revisit this *around* November 2022"
(emphasis added).  2.38 will be released in October 2022.  So, maybe
it's fine as-is.

But if others prefer these be fixed over moving up the deadline, I'll
go ahead and submit a patch.

I guess we just need a call.  Junio?
