Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5FDB1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 13:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfARNg5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 08:36:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:36665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfARNg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 08:36:56 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0ur-1glJH538Kb-001R2g; Fri, 18
 Jan 2019 14:36:50 +0100
Date:   Fri, 18 Jan 2019 14:36:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive
 machinery
In-Reply-To: <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901181434520.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com> <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com> <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com> <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OwhyfJUqnyAci7i+QQRW+r4yDJw12AAgaPZsKjkJUxIzOWhajLa
 cYyXDV5xXjNT/U0ipXbJFGu9C4u5KfRnNto6P4PiWbRxqSeEaLHj9/dYXuW3Cn79WujPhfw
 seltMR1JlGJFch9BRJKSvkmwmB9HG8WeHX5Zq5mBvp/GOyqEGG94gNLjKSEjEiDD6WgPaXA
 27ANrxror6ivoCeehQrXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j+CehxlENVU=:GROqVm5GiTdQNBb0YmxEOa
 Rk9lapupjx8FKXl7980QvrTix4qLh5i5ofW9I7TZY87xNYIkpzai/oQSX/amqnKJZh16lskGj
 du491abNd/ftq+y3rP3EKpSZxoioGtV9cMR0AyGQeLza+qlkjFY8wg4yBsf98lEyIQ4mD8uIz
 V4qaTLePE/GnIjmoQG6UbSTiqse2CwHvnPZk29M4Lz/Rs/m/yH5/qwjpFY894CLV6f2c7cy8j
 uMCSnBR4jak0/UUlBlTr2EXwvPiHoCkDNuq5rXIaCJfPiwM9nQljFJvvKIjLp0sOkSTSO4Yh2
 VXoNiHVSvR6pNKMu4xFrxHy88a/rvSrRfzUVcEsvE4WuoBKqEwE1ZKfuIM/KOsVWK8uWNPsOE
 ARV0wVCcgtoh6nBufxf3im0itoW7JLoFdmou0ftD0jFDXzQajXWmuxi3W54bYg+wIN6vxehWa
 lfQiy+KwLXkiqEMvWc/U8RUxU6wVb5KrsH+9kZkjbrOqEN83zS4I5a3r47BWnAcLUaVtNtOUE
 XxwECps6W+yrhJQDW3fl0QZWzfhOCHkm5XD5VAALNphAnvwaD4fdJ5HUJEjFTDOe0RyyMQ1kB
 m2z6CRcWBuDCwlheLiyFE2lLudXPXLi1jQSzhbhJNxclVR7FKkBXhOry8qnrrZBVzrRGakN4a
 LyILqdGMXlzNpnANO7NGDVcUHPkgNXHAS6bG5HQuy+1uDVj8E7Ki2fg1EUuP8lOVn6aLc7FxM
 L0RxyvSIw1RdCnq2WRWKcBCdiKpzi1pUejr4fuJJeKhdiy0eLhF8nmT25FgOF8lpSXoZieVRY
 vITAhwH3+QVirgxQDdgp40Rx29u1yUhxAGCOlqDERkYkxB1LKr5pL+ouaWUcNQOFI5xyGl/d5
 L1+jhBFvcmp2208DkCFCVFBPUL1CONNP9qsuEGrhEQDuQ6GnXeyVUJtjlO9OgJ/gcMy8X6vdb
 ugz7Wa55cBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 7 Jan 2019, Elijah Newren wrote:

> On Mon, Jan 7, 2019 at 12:11 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Elijah Newren <newren@gmail.com> writes:
> > >
> > >> On Tue, Dec 11, 2018 at 8:11 AM Elijah Newren <newren@gmail.com> wrote:
> > >>>
> > >>> This series continues the work of making rebase more self-consistent
> > >>> by removing inconsistencies between different backends.  In
> > >>> particular, this series focuses on making the merge machinery behave
> > >>> like the interactive machinery (though a few differences between the am
> > >>> and interactive backends are also fixed along the way), and ultimately
> > >>> removes the merge backend in favor of reimplementing the relevant
> > >>> options on top of the interactive machinery.
> > >>
> > >> Friendly ping...let me know if you want me to simply resend v4.
> > >>
> > >
> > > If you have anything newer than 90673135 ("rebase: Implement --merge
> > > via the interactive machinery", 2018-12-11), then yeah, I haven't
> > > seen it.
> > >
> > > Thanks.
> > >
> > > P.S. even if that one is latest, I would need to downcase Implement
> > > before it hits 'next' ;-)
> >
> > Ah, one thing I forgot to mention.  Some of the tests updated in
> > this series are unhappy with Dscho's "drive 'am' directly from the
> > built-in code, bypassing git-rebase--am.sh scriptlet" topic.
> 
> 2018-12-11 is the newest (and is almost the same as the version from
> mid November); it's just been waiting for review.  I'll fix up the
> casing of 'Implement' along with any other feedback, if any...maybe
> including rebasing on Dscho's series depending on how he wants to take
> it.
> 
> 
> Dscho: Looks like our series conflicts slightly.  Would you like me to
> rebase mine on top of yours and squash the following change into
> commit c91c944a068e ("rebase: define linearization ordering and
> enforce it", 2018-12-11), or do you want to rebase your series on mine
> and either make a new commit out of this change or squash it in
> somewhere?
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 0317280f83..54023547ff 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -578,7 +578,8 @@ static int run_am(struct rebase_options *opts)
>         argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
>                          "--full-index", "--cherry-pick", "--right-only",
>                          "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
> -                        "--no-cover-letter", "--pretty=mboxrd", NULL);
> +                        "--no-cover-letter", "--pretty=mboxrd",
> +                        "--topo-order", NULL);
>         if (opts->git_format_patch_opt.len)
>                 argv_array_split(&format_patch.args,
>                                  opts->git_format_patch_opt.buf);

I can easily squash that in. Thank you!
Dscho

> 
> 
> Elijah
> 
> 
