Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1318A1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 14:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeHXSWY (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:22:24 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38686 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXSWY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:22:24 -0400
Received: by mail-it0-f44.google.com with SMTP id p129-v6so2269750ite.3
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3pLWI+/3PbHUzXdW0FMlJGRVm73UkjYP/57RwpNqGA=;
        b=ok6HKCjGCyD0syJWULwKM9Xz+Xr5STqFzoMCxfF8f7Bs69zBlswfWKG4HC84NWJu86
         eNNlBCJ+/WADv31CfLROpC74S8XEb+z0PoX+czmAstjSvwBdA8p5+myvr5AVZm3U5pDe
         HXVivEqVtZgNYnAFMP66ZmhaAV+4FUYSO+fyPqNEdGj7UY4k1827mPyFP6Vesc142Nfa
         ERMgKO/W9J6xRxAKabsMgZeE7IcbcwrYAvVvQpaOJ8dzT8z+Bc4/o3+7oNmCdpkE+Lbj
         c0vuai7YHYOFrhJC2xqRe9RyegDdEAwuj6db1ARsnNRdXtQCBypSlD4AXzEj2KLcwnyZ
         1Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3pLWI+/3PbHUzXdW0FMlJGRVm73UkjYP/57RwpNqGA=;
        b=f7Jh5q926oXVOlZVMM5/t4eEacbBXooqC3ZkBblx1xDIEacbn9G4HY+eO8X30z1dyO
         nxWcF7GFmAjGsYtdJ224SO4VNkUgT92WhuttSVE7d+rVXXPnkJa4DB/flFcHiA0uBIMG
         nU3C8XQNgb4fH6xASqMeSi93B1thnPhyyh0zbhc0egIQs05hqhkUFAs4R/GgrV9FAgbq
         wZ1m4J543VKJxU22sq81hfXOGXmYVCPbyFdTLPKDJJNUWLV6C+atgxRMQx/HKW1D0F+Q
         3Rpnx0FCJiRU3OYbHuZQutEAuJhxlmV0jgIaKfKp+ChTPa9k2gGI1U3nqOF1yjGLM0b/
         BO9Q==
X-Gm-Message-State: APzg51A4HuzoCG9JXRY7pWDf+HFhaluST+F1xjt0BBWD96RZqUDHfBOy
        t+ga1d6pMEpag7ycCjnL0/7Lacmnd3sGUh1JVnTOPw==
X-Google-Smtp-Source: ANB0VdaODLwh0zeMRTfvOD3AFFghF/LopRzOMYb15KDjK7Uj2fxiT1JP9guIsdeDFW2AQ7iCQwHUjr9Ijc85iVUvfpk=
X-Received: by 2002:a02:604b:: with SMTP id d11-v6mr1524644jaf.61.1535122045433;
 Fri, 24 Aug 2018 07:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180821192321.GA720@sigill.intra.peff.net> <20180821193556.GA859@sigill.intra.peff.net>
 <CAPig+cT+LBSJHoR1kUi+S2h96y_qmVEpK0xAy6sRUGQj6GQEyg@mail.gmail.com>
 <20180821204341.GA24431@sigill.intra.peff.net> <CAPig+cTghgbBo5VfZN+VP2VM00nPkhUqm0dOUqO37arxraxBKw@mail.gmail.com>
In-Reply-To: <CAPig+cTghgbBo5VfZN+VP2VM00nPkhUqm0dOUqO37arxraxBKw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 Aug 2018 16:46:58 +0200
Message-ID: <CACsJy8BxxyRxqCj5ZoOmPaiwmFRKHU72yTxyC_eHXS+cEa94zw@mail.gmail.com>
Subject: Re: worktree duplicates, was: [PATCH] SubmittingPatches: mention doc-diff
To:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff, you're doing crazy things beyond my (admittedly very limited)
imagination :P I did not see this at all when I implemented the
worktree stuff.

On Thu, Aug 23, 2018 at 8:21 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > In this case, it might make sense for "git worktree add" to refuse to
> > > operate if an existing worktree entry still points at the directory
> > > that you're trying to add. That should prevent those duplicate
> > > worktree entries you saw.
> >
> > Yes, but then what's the next step for my script? I can't "remove" since
> > the worktree isn't there. I can't blow away any directory that I know
> > about, since there isn't one.
>
> I was thinking that "worktree add" could start respecting the --force
> option as an escape hatch.
>
> > I need to somehow know that an existing
> > "$GIT_DIR/worktrees/foo" is the problem. But "foo" is not even
> > deterministic. Looking at the duplicates, it seems to be the basename of
> > the working tree, but then mutated to avoid collisions with other
> > worktrees.
>
> If the worktree directory still existed, "git -C rev-parse --git-dir"
> inside the worktree would give you the proper path of
> $GIT_DIR/worktrees/foo, but the directory doesn't exist, so...
> nothing.
>
> > What about refusing by default, but forcing an overwrite with "-f"?
>
> My thought, also.

Sounds good. Eric are you going to implement this? Just checking so
that I can (hopefully) cross this off my backlog ;-)
-- 
Duy
