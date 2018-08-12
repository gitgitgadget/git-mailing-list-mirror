Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7BE21F404
	for <e@80x24.org>; Sun, 12 Aug 2018 09:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeHLMHV (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 08:07:21 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:43433 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbeHLMHV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 08:07:21 -0400
Received: by mail-io0-f176.google.com with SMTP id y10-v6so11632422ioa.10
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Dx+wHvo3g+uAzHpTExMi4unOH+cYfynvaR2qgREQ2c=;
        b=k4EJhgKGKZEz/ymlkZZ+uLDCWMm2tIQnurP42iRWDgnWU0HadOCwj7KONagXn66Nmv
         EkobNZCAD7jgF2yFSdVx1k9zBXeYPNsGpld51/aue2RHkbkFzwEDFopHuIyk21ZOrV73
         PKkCSqbVVRHYN0Rmz7pQxzOBgyjmquD/UE+VPXJVf8qOfjBGNudDSFLtmFZGwiVV1B0b
         3y5TMddotwyDy0EBfyIZmPfNoo3c5bky/jZVTcUjnhL26DdgBoQKZ4NbZsrOse4N8D4o
         va4jnFUWvrYz///64Orq7padC+D+4c34ZfeLDTSlnrzcHh+ssC/hcKiv64/eqspQCvkO
         xnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Dx+wHvo3g+uAzHpTExMi4unOH+cYfynvaR2qgREQ2c=;
        b=J4QN/HjDuMWfS63a+kHKugMHWrQtXlOORr1+hsPdK/2Q5t0P46adySV527wz7V/IBA
         0raVj4IcLisqIJ0Lhw0Tv1wk3l3+Y39oIiw+eKU2YfNiJvxgHBofPlL0x1POXwHnfZBH
         ZMMoTaObeAYZnH023gn7N1dODGrbZ6OjRx8BwL/tLIf5T1fp6+Z4aCHjFlVVCoxyyaiB
         iE77s9cSNRm9597cd3YXhJmTPtlyQ+l5zC4mxXGbbs+ueEwo8RZFMpZPfdOdCOr0axlw
         lCxPsaehsrhFGJw965Fgto/8DRy3beygvZbZ3l0wd6LRysfqp8Er++M7sVzq86FWNpMu
         R8cQ==
X-Gm-Message-State: AOUpUlFwcwQClXOQtj9xAzKOC2yrIa5ICICnH2Hm4ySt2JUzI6PDXrRX
        I4LrYjx2zFmbGVd1Ob3eujpFf79uofATII4IH/KVXQ==
X-Google-Smtp-Source: AA+uWPygGhFcUPgJwgfOO5XLXZnt11+WEptLjMWIXKuvRyMwtaMFQkeHVantefUJfnbrPtAuMaALxbecnYVX+Ts2QZ0=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr10937273iod.118.1534066197695;
 Sun, 12 Aug 2018 02:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
 <20180808160612.GC1607@sigill.intra.peff.net> <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
 <20180808182436.GA19096@sigill.intra.peff.net> <be46349efde84f158b80e96f2fbbcf4304a71208.camel@mad-scientist.net>
 <20180811142341.GA17605@sigill.intra.peff.net>
In-Reply-To: <20180811142341.GA17605@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 12 Aug 2018 11:29:31 +0200
Message-ID: <CACsJy8DyDpgGJ4FS=KrJpchpHpUFsfUt1zaQeoWYthAiBtSqpA@mail.gmail.com>
Subject: Re: Help with "fatal: unable to read ...." error during GC?
To:     Jeff King <peff@peff.net>
Cc:     Paul Smith <paul@mad-scientist.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 4:25 PM Jeff King <peff@peff.net> wrote:
> > I do still have these warnings and no amount of git gc/git fsck/etc.
> > has reduced them in any way:
> >
> > $ git gc
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
> > warning: reflog of 'HEAD' references pruned commits
>
> I think these would go away via "reflog expire" (I'd have thought "git
> gc" would do so, though). I wonder if this is yet another tool that
> needs to be taught about worktree heads.

You would need "reflog expire --expire-unreachable=now" because the
default 30 days are probably too long for this case. And yes "reflog
expire --all" needs to be aware of other heads (and other per-worktree
refs in general). I'm pretty sure right now it only cares about the
current worktree's head.
-- 
Duy
