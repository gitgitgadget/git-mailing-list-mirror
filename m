Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342B01F461
	for <e@80x24.org>; Thu, 16 May 2019 06:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEPGKa (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 02:10:30 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:35200 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfEPGKa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 02:10:30 -0400
Received: by mail-qk1-f177.google.com with SMTP id c15so1575350qkl.2
        for <git@vger.kernel.org>; Wed, 15 May 2019 23:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oJZ1IW1nREVFJQ39olytnEQ3BnnjJbGGA6fW5zplmHQ=;
        b=DnuQX63tWbz1q4nPAvfmw3F44Bd+Po1Zes/BoD7ZbAI8hxkGJ6EErShPYb02j8OjtG
         qaB4yQkXlY/2pp5k+z+yvAy1yEcIvkzIN8hmIGUh4pk+xg42vgqRwethiILMv2+kceEn
         7SmrIkZScJg8QR5nwTX0oO9qa4c0pKzcYLjPBuhe5xkIZi5sM5R2Icdk+iot1Rh6deMQ
         IdNYDtb9LTr0gB/3w/DRt84ul0xPAzQ4ezHZ7u2JPwDihMcuWnSLabbo4yYx82OcDbnO
         unb6ubwMh0YMxGemv4MecIAt+w+gQUP/gejmJbee001VBO8mLZJELcun6cTlxaRzccpA
         CTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oJZ1IW1nREVFJQ39olytnEQ3BnnjJbGGA6fW5zplmHQ=;
        b=RTXvxpSw1qla/GjCIbjhSfAK34R6bHOVb9Or75TIhAh1L1+YWNNnwXIWLai2gxxEET
         1NAfbJDOXOiGwJnBMIdnpEOjJM+KRg9tDysTpGxLB7l9gWBznbOIEVtGuqvLotcQUI5H
         9lWTjQtorYtVFZDGmTapYULmyIUCsRB3p1a0V0UmUlPGryax4AbRscxgIzwIUjPy0Umr
         0WdtXkXEtYs7JjTcsWvRDAzKSLIee5P9NNEugzsWzcB1mWJVL07S28dBiGPJmdxc46Tc
         3T0E3SV6jLMsKJrzE7dhaJBB3cQ0GMpl+jQV6VKjUvV0RghsNRZtW5W1j+Cp744gCWNq
         vEtQ==
X-Gm-Message-State: APjAAAXZkGYBxXqtbMFmkDO0hZ/J7/9vx/CiOzTXGnKCQgHAlNl4Fb9K
        mzdlDyz3iX7oV81kzu+cqG8Aj5ImMflQ+doKwf4=
X-Google-Smtp-Source: APXvYqxeuLM6DTj5oIS2hXbD0672VWZXOP/XmcLi+Y2RbNWG0op2+MhYMU+g+oI1p/4AjcOhrbgHLw7yc4VynYUHHck=
X-Received: by 2002:a05:620a:16b4:: with SMTP id s20mr37283366qkj.34.1557987029391;
 Wed, 15 May 2019 23:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01CsoJf+_-iowdm0EFWd52vOWE1Uo0GGZ55d3RyPJzg6gwgQ@mail.gmail.com>
 <874l5vwxhw.fsf@evledraar.gmail.com>
In-Reply-To: <874l5vwxhw.fsf@evledraar.gmail.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Thu, 16 May 2019 08:10:07 +0200
Message-ID: <CAA01CsrAPfE+hMwNMEF7epRcFQyhdeBxm9qSH=eF6v3kyyMu2w@mail.gmail.com>
Subject: Re: Merging (joining/stiching/rewriting) history of "unrelated" git repositories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 5:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, May 15 2019, Piotr Krukowiecki wrote:
>
> > Hello,
> >
> > I'm migrating two repositories from svn. I already did svn->git
> > migration (git-svn clone) and now have two git repositories.
> >
> > I would like to merge them into 1 git repository, but to merge also
> > history - branches and tags.
> >
[...]
> > There's additional difficulty of handling merges...
> >
> You might be able to use https://github.com/newren/git-filter-repo
>
> But I'd say try something even more stupid first:
>
>  1. Migrate repo A to Git
>  2. Migrate repo B to Git
>  3. "git subtree add" B's history to A
>  4. "git rebase" the history to linear-ize it
>
> At this point you'll have A's history first, then B. Then run some
> script to date order the commits, and just "git cherry-pick" those in
> the order desired in a loop to a fresh history.
>
> Maybe that sort of stupidity will wreck your merges etc., so you might
> need less stupid methods :)

I think both git-filter-repo and the subtree+rebase do not handle
branches/merges well :(


--=20
Piotr Krukowiecki
