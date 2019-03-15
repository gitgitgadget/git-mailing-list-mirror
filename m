Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7BA20248
	for <e@80x24.org>; Fri, 15 Mar 2019 06:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfCOGLv (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 02:11:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37985 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfCOGLu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 02:11:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id e10so2718061edy.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34qR8aLOZzoKrKAn9htalaRoI/34wuipCRvbR1mfBVE=;
        b=GycphY6W68FE1HwvmWuo3jy9R0ed5Fer4fvsN4MHk1pavmXGYOqdlnhiFIZZU3uMLs
         zjxmdEI+cwRbeTAC+LQpbGHq85+pbG8k4MDAuY1hGGkJ59JfyE2DVW63XPscf1Fc8Is7
         K+H5ua3XMYYgNw+980khf6AuDX3MzmZ0bzD6VToL24IocmGpHITE3jrp5av9YgDapUuK
         wQKoLgmHb3sHLoMTzxDyZNysq8mX8WQeRmTIbJEFBWTEqp3nj2glfORil9WMivfaeCqZ
         mMV3CxMuC42uMiH//mja0EbhA02yHiVIuZyr8yQ2ptrNLY6yyT6YL600oLk1YjHuGhrr
         DCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34qR8aLOZzoKrKAn9htalaRoI/34wuipCRvbR1mfBVE=;
        b=WYqTwM8rdx+aL/3mlDymo54/TIWDLlxS+vRJpLKOOFGm+7Qdj/D3mXdtjo+czbd5Pp
         /8riyyt5+jD2xS3gCIfKd6fMjgIG3DB2Jikp1edMG0T2AM7AH+OTxsCTBSBKS1EvCxzf
         Jq9rmw9+aRv6mGh+QH8HLwRjhPx5LDrYwqU8afrjiuZlMxeKD1iAAB8OMkF6E5oo8/9/
         CIcwqywPZDQ4OwznLoC/Z09wBMPlxW6m37F4I1+SunKqlRySOx3Dlj2URrEXCiEJex2h
         tBJ9a3sxtywWGhIae6PzySfhB84OCCeQtfOXEpSzKtbff2+gun0/8Xq01Iak92tvsSW5
         aAMA==
X-Gm-Message-State: APjAAAVhPyH+PQGvXBnorvy305CcWLLH90n0MRsB7KuSoO5N7dLn1lEE
        ustczqh4mW0d2hiCqrQ05pWzgluz6ZSRb/DNE90=
X-Google-Smtp-Source: APXvYqzXI2nm+shOM0C6+0UIclHV33WmNoK2VQKzORcKh5vk4HBCab1qP01kdaMo85GDOpGVfRp968ueIDuVZvij1wo=
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr1118331ejj.4.1552630308938;
 Thu, 14 Mar 2019 23:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com> <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com> <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
In-Reply-To: <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 14 Mar 2019 23:11:37 -0700
Message-ID: <CA+P7+xpotm+W-4RRhchWvZ_mkr=eVKC4B8fKp8_gxBNGn+wrQA@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 9:52 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Mar 12, 2019 at 8:37 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >
> > On Tue, Mar 12, 2019 at 8:19 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > > On Tue, Mar 12, 2019 at 3:51 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > > > I tend to agree with this but that's probably because I don't really use
> > > > checkout -B. I'm not sure if it's widely used or not. I do find checkout
> > > > -b convenient though.
> > >
> > > Yeah I think both -b and -B are about convenience.
> > >
> > > But I would not mind dropping -C for now, if people think it's not
> > > that useful. We can bring it back in incremental updates if we realize
> > > we miss it so much. I'll keep it unless somebody says something.
> >
> > It's not much of a datapoint, but I do use "git checkout -B" (and
> > therefore would use "git switch -C") periodically (in addition to
> > -b/-c, which I use all the time). And, convenience is important,
> > especially considering that "git switch" is already more painful in
> > some ways than "git checkout", due to having to trigger and spell out
> > certain things explicitly (such as detaching).
>
> Ooh, interesting.  I haven't used it and didn't know who did, but
> since you do you can probably answer the question surrounding the
> long-name for the -C option from earlier in the thread:
>
> Do you use checkout -B only when checkout -b fails, or do you use it
> pre-emptively?  The former would suggest we should use a name like
> --recreate, while the latter would suggest a name more like
> --force-create.

I use it periodically sometimes like this:

git checkout -B master origin/master

Essentially, I use it as a way to quickly and forcefully re-create a
branch that tracks the remote branch.

For example, I might have made a commit or two on master, and realized
I should be doing a separate branch, and I want to quickly make that a
branch by doing

git checkout -b some-branch.

Then, later I want to switch back to master, and I really just want
master to be exactly what the remote had. Sure I can do that in a lot
of ways, but it's nice to have a somewhat convenient shortcut to do it
in one command.

So, for me, it's natural to think of this as a "--force-create", but
use of either --recreate or --force- create work with my setup.

Basically, for *me*, I almost always use it when I know there's a
branch that I want to re-setup there, and rarely verify that fact
using a "oh, -b failed, I guess I need -B"

Regards,
Jake
