Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844C5202BB
	for <e@80x24.org>; Tue, 12 Mar 2019 11:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCLLzG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 07:55:06 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33805 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfCLLzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 07:55:06 -0400
Received: by mail-it1-f196.google.com with SMTP id d125so2260251ith.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jaqc6f0+E2BfAGtFkBE0HWLUL+rspNcZKL7aI7c1+d0=;
        b=Dvp9snfM0gjp0wHbpl1XOsyMLz0DTQXHeS21ufvba8PdMDUqOpRg5UjtSHq16P2FWN
         bDJoyt/G+gn++DFDlgpZpomOEEZWruMuqGfgAucmY874EZGHvZKMRd4whFD6v9JsoFxI
         R8OYtsTiCfh0RgiJ+6SsDPB4zwCMW822qj8kR/5dCzOLr4MZmV9xpoRQMnQzA/FUOOKX
         VMrtAWL1HrhZ7QTd1hQwWemrU7nTFDE7LGFDNZjUB5xeHj9b9YT0QiKVjKVOlWHNPumx
         VOveefAE0rhQVxtALaXz7I3l7oVbbOomRd9HqOW9XMgeIRQ5FnJBXD7d98eDka39Rxfj
         eq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jaqc6f0+E2BfAGtFkBE0HWLUL+rspNcZKL7aI7c1+d0=;
        b=Atbc9q8rENZ7YjIoZUElUIoLIb1SmT1FHArc8KbDuJYbs9wr2ZUeJ54LXnDlUzwKKX
         rdQko88fEjOBU3c+ktvNWV5rZKNPsB5fmm0dqKSEdhald+TOVnVAtUPJn+yKEP0ibbiT
         B/YZBM/mZLcy9+aANDNnSAeaup2o7cdADwvnE1wAWq1EjI+0O7s1lB5iNKlNibk9T898
         xPrIbqMYoyNQY80YJ7kbajqTDtwUFFlKotocGa+0STU0NIbpkeLOMeoxT49F53uxCKeA
         iMuW2fvtAACh/pKfJNw7SeMMl86eLz83qGbDSrng1n/nJX23nlKTtzLfOp5qHFMUBKgI
         Lv7w==
X-Gm-Message-State: APjAAAV7nIVLlIpibJlxMSWKa/61z5LSvn1zRBslGrc2NUEcBxeHf9P+
        hkbi2UREgD0s6GkYJLH2Zi3TgqVGQGyN1QvPyP+Wng==
X-Google-Smtp-Source: APXvYqxZUYg9OdbdJc4wXA7nYBBiO83of5zirKlU2nrmGY+22dW94tAVeW+Z5VSaZtOe0A/1O30bVyU6EAW7b5VBcXM=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr1753520itf.123.1552391705199;
 Tue, 12 Mar 2019 04:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com> <f63a7ae7-0a08-02f2-23e6-4389d8fda729@gmail.com>
In-Reply-To: <f63a7ae7-0a08-02f2-23e6-4389d8fda729@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 12 Mar 2019 18:54:38 +0700
Message-ID: <CACsJy8CXX+Gk2SFGSULQ2TEzzXRdUr3vCxHxxsBOzhKCLE4YVQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 12:03 AM Phillip Wood <phillip.wood123@gmail.com> w=
rote:
>
> Hi Duy
>
> On 11/03/2019 11:47, Duy Nguyen wrote:
> > On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com=
> wrote:
> >>
> >>
> >> Hi Duy
> >>
> >> On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >>> "git checkout" doing too many things is a source of confusion for man=
y
> >>> users (and it even bites old timers sometimes). To remedy that, the
> >>> command will be split into two new ones: switch and
> >>> something-to-checkout-paths.
> >>
> >> I think this is a good idea, thanks for working on it. I wonder if it
> >> would be a good idea to have the new command refuse to checkout a new
> >> branch if there is a cherry-pick/revert/merge/rebase in progress (with
> >> an option to override the check) as switching branches in the middle o=
f
> >> one of those is likely to be confusing to users (if I do it it is
> >> normally because I've forgotten that I've not run 'git whatever
> >> --continue').
> >
> > Interesting. I think this would be a good default if we have an escape
> > hatch (which could even come later). I often wander off to some other
> > branch and go back. But then half the time I end up forgetting I'm in
> > a middle of something and just "git rebase --quit" :P
> >
> > Of course with git-stash (*) and git-worktree, I guess there's little
> > reason to just switch away from a something-in-progress worktree. I'll
> > try to implement this in the next round, unless someone objects.
> >
> > (*) I hope git-stash remembers and restores "something-in-progress"
> > status. Dunno. Never used it much.
>
> I don't think it does. For rebase it's non trivial as it needs to
> remember the refs under refs/rewritten and stop gc from collecting any
> of them or the original head (in theory the todo list can contain
> commits that the user has added from other branches as well so they'd
> also need to be protected from gc). For cherry-pick there are gc issues
> as well.

gc issues should be fixed anyway because gc could start any time (even
manually by the user). And teaching pack-objects and friends to not
delete original head and the todo list does not look so hard.
#leftovers stuff?
--=20
Duy
