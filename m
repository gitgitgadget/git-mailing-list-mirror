Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A6E211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 18:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbfAKSgx (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 13:36:53 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33401 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfAKSgx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 13:36:53 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so9839295vsc.0
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7lltdHxJ+7hMxaHgw/pkrWetITJLDDwTLAr1H6spcw=;
        b=hliKyX4YzS5F+Ppn5ZFVK2ELvRKxcAr0RvyqcEtlk+Puzj7E8dxSFTp1w97shJD/qr
         i9uoNOs0zM4FwqaHfCXbXE1dcQSFED3iXf6g/sGdQIXnG+jpCYD11mwCXa7c7sQw69Wc
         vfyMsU6gMnFnnGNm6eQVLiUPkQIWogh6cRj+BMRXrwKfNNVCaa447kEeSKyG6ongGFrL
         jqAuLv4yAjGhSgNfLVl89L0cOE2zyzEaO6jXmF/CX/7USm1ihbX8nLO3UtOs4O2v6vlY
         LpOKYXhD346/vmrkE76BKZa3srwlzlr/rjnoWo/0jkVxLllO93Y0p5rGjcdcmCmVnn/l
         BCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7lltdHxJ+7hMxaHgw/pkrWetITJLDDwTLAr1H6spcw=;
        b=kEsEQkruaFhmDejD88shM8mh9ylf/FLf+vjGrH4rOSq8ADYPRmiv+Y9OwI2pVYAmNH
         bnxslWksZln2uZ6D5jpNxvOIaXmddCbKJ1s+EdTIDSRNAxr1b38IcoNRhojvrSFX5RE1
         vx9whmpkHL4I2qHRQyXL0diwUDztveKe0I+3JJsOsnOHR9HKgXaB+GlzSL/EKJjGWA+l
         XqqIPdhrTIZVHOCFRvOZ5z73mJd0PHRUrv/kEgktCNJyVgPCluMgVK1NZu7Ds7mQPmUz
         3yGWvjbJ7j2XQKbD7y7lsWL8kSw6Nbsh5xbKDhP9nbFq49cJj4cWjmS0hR67dVagGAqx
         mjHA==
X-Gm-Message-State: AJcUukeRAvfgKUADbL3Usa98Ip2QDxUg2XVUeW08JQ0xExfQlOVAV8FO
        k864qOTF30zikPyoTyvUEdUXcK4ckKevX9sHMdo=
X-Google-Smtp-Source: ALg8bN44UMFSSk+5Ke0oill97R1A5ghtAux1TGMUfDmv+TM0PyMblgA+ZAeKN3t5IZd66uxkUse4l6tjOkRSrmdNSMY=
X-Received: by 2002:a67:3e12:: with SMTP id l18mr6629411vsa.53.1547231811220;
 Fri, 11 Jan 2019 10:36:51 -0800 (PST)
MIME-Version: 1.0
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com>
 <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>
 <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com> <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
In-Reply-To: <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Jan 2019 10:36:38 -0800
Message-ID: <CABPp-BHbCnhLypi0Ov_dVUWwqzW7Yho4-G7w=eHVLkJvT6kELg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

A small update...

On Mon, Jan 7, 2019 at 12:39 PM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Jan 7, 2019 at 12:11 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Elijah Newren <newren@gmail.com> writes:
> > >
> > >> On Tue, Dec 11, 2018 at 8:11 AM Elijah Newren <newren@gmail.com> wrote:
> > >>>
> > >>> This series continues the work of making rebase more self-consistent
> > >>> by removing inconsistencies between different backends.  In
....
> > > P.S. even if that one is latest, I would need to downcase Implement
> > > before it hits 'next' ;-)
...
> > Ah, one thing I forgot to mention.  Some of the tests updated in
> > this series are unhappy with Dscho's "drive 'am' directly from the
> > built-in code, bypassing git-rebase--am.sh scriptlet" topic.

It looks like you've already done the downcasing in pu; thanks.  Also,
Dscho told me in private email that:

    "FWIW I am fine with your patches going in first, and I would rebase mine
on top. It will take me probably until next week to get to my patch
series and Junio's comments, anyway."

So, I'm guessing that means he'll apply my patch below to his series.
As such, other than maybe wait for folks to review my updated series,
I'm not aware of any further changes I need to make to the
en/rebase-merge-on-sequencer topic.

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
>
>
> Elijah
