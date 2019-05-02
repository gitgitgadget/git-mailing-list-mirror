Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68E21F453
	for <e@80x24.org>; Thu,  2 May 2019 13:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEBNtg (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 09:49:36 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:42355 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBNtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 09:49:36 -0400
Received: by mail-io1-f45.google.com with SMTP id c24so2101285iom.9
        for <git@vger.kernel.org>; Thu, 02 May 2019 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V51zcTSrrjKkTOSB/CtTjABNTJd1BIhJfwmbv+rrFgc=;
        b=oAwSKRA6jVkNxtg+okuh9BmSEtbqEL/CC+UJqxbDbdT43NX+sOx9nrmbkrMOu6tGVA
         khDibrS4tf5V7weduYHP7tU0+eZASSZMvqZHPSmfUpi/EQ5NW5Wisbz8zaaDRrAhT/Fw
         mOstLoyXd12ucmD7u3cHSZ6FvkawqA46UDOfzQ+EtBkdlfpb9hoiGQ15/G951RsSOvEd
         DmYY7a1PKbMLiMPuiOSNh3TnWbcTnUCyIlJaiCnTNSzNDYffMoezp2FzWIotf1J6eUor
         vOpQcpV+KNsMV4vbCYaj49yBaff+Fqy0y09XVBl+W2D2i4sV0Cn/a1GRVUFxRMn6EPJY
         +7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V51zcTSrrjKkTOSB/CtTjABNTJd1BIhJfwmbv+rrFgc=;
        b=BjJ9QCe2uEaOLcoFWRZ13UCJrmBaDROv36zeN4c5LUi6JcY7n9LMwVvNCJvUJR2/IE
         d7hO9IB/CqZyBFwxNcF9FUt2R33pae53oke6IFWIKBwqOKwgYHSSx8RuWgRVpU2w6Yil
         RQw/qQjysdnI0+Sc+5kF/L/O8b/4t7jkkR/mvsQRj4Ue56rX3x18xLAWSKCPKRS0esYE
         yRQ5vZpQsy12oEsjmrtIb8M8hYrnFXG/UzbODlEXwl3wGnzW2u/vEdIzK5GOC9Ffj1EY
         QHUt2HDAIDpAsvneefXE/C3CUlbct3kDEjpB6Get6l+DjEpf4nWp0DGz0wxMJ7iUs0UP
         WmUg==
X-Gm-Message-State: APjAAAU8gAHXIF3Ps1hdQ81b63YNWwjNX1CSw0OUbuDmZQJxhwQasRqR
        If9fSUXlrIO/Ylbdct5hI2cUkcGBDNbm003pqDI=
X-Google-Smtp-Source: APXvYqykNWeSYydtoHos7BbTFxirE91mOWuB+oBIesRJakhOTOksII/PUs8UeQQOXY7ZJWv07ruSM6SFtaru6sc6FB0=
X-Received: by 2002:a05:6602:2042:: with SMTP id z2mr2275105iod.282.1556804975035;
 Thu, 02 May 2019 06:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAA2qrhBmbSe5R0xQPBZiRcz0MGG=JcF4BjxHqmyeTFNR19FKbg@mail.gmail.com>
 <CACsJy8CJ_PB+QKp-T-yTHNPYgjEEVN39QbnAu4kKzGGcEQ0ezA@mail.gmail.com>
 <87d0l1qat5.fsf@evledraar.gmail.com> <CACsJy8A67x5wtbTe9Zk6URLZOqMNUFaLuNyZSVdYkZ1Z3y=6+A@mail.gmail.com>
In-Reply-To: <CACsJy8A67x5wtbTe9Zk6URLZOqMNUFaLuNyZSVdYkZ1Z3y=6+A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 May 2019 20:49:08 +0700
Message-ID: <CACsJy8CzakrDS8qW5DTbkG_SNaVQ7Y6Ps-vT91zRPKGgvUUQeA@mail.gmail.com>
Subject: Re: "git branch -f" corrupt other worktree
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     frank kulow <kulow.f@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 2, 2019 at 8:05 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > Part of this is "doctor, it hurts when I stab my eye" :) but I wonder in
> > general whether users are more likely to expect different worktrees to
> > have different views of the refstore, since they way they're created is
> > "I want just this branch over there".
> >
> > I.e. whether they want something closer to another directory with
> > "alternates" pointing to the "main" repo, and whether that should be
> > promoted to UI that's easier to set up than it is now.
> >
> > Or maybe something in-between, where they'd expect remote tracking refs
> > to update for everything, but a worktree's "master" branch not to be
> > touchable by a worktree on "topic".
>
> I think it's a minefield to go with different views on refs. They can
> already have per-worktree refs now. Granted it's long to type (e.g.
> worktrees/foo/something) but it does help remind it's per-worktree.

Correction (apparently I'm not using per-worktree refs enough to remember).

s,worktrees/foo/something,worktree/something,

worktrees/<name>/<ref> is to access per-worktree refs of other
worktrees. worktree/<ref> is about the current one.

> And we can probably improve the ref resolution rules to resolve
> "foo/something" (or "something" even) to worktrees/foo/something for
> example. But going totally custom, I think it's hard to even manage as
> a user.
>
> With that said, I think we can technically support per-worktree refs
> even outside worktrees/, or the whole refeference space per-worktree,
> now. The difficulty will be coming up with some sane UI that can
> handle that and not leave too many traps behind. I can't see that UI.
> --
> Duy



-- 
Duy
