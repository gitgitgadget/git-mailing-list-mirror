Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49AFC20248
	for <e@80x24.org>; Tue, 12 Mar 2019 12:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfCLMTl (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 08:19:41 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53115 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCLMTk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 08:19:40 -0400
Received: by mail-it1-f195.google.com with SMTP id g17so4001992ita.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYMsTbtP6NeCgrVD8QshM21eBtxJUc3oCaOr2a3X8UM=;
        b=BaGkldgTUsri/FbNFBr1Pecwh4K5sczRGajh1/KlN9basWb4U5XO0has7D0gPDSw2T
         sRvksteWAqvtT+MCgZkjj62xKGA/k54zaj1ysjsqx1pnRfji/GEJYx+DvOPFZuM1wHXY
         D5m+b+tx8PvuhG+tb27TGxudnHNoH9vxOLbhL1dO94bxgPSkNyL2DePe+iLKCkBmrQYf
         D//awnB29uKrmVx+hS1N6784C7/CN4mAZ6IULm/JA38QfHgWWIXW4gnbmfV7O0OVo7vf
         740hejrhTdbp3DqidBTPUX1UEdouXGVCel3ezG/Bvn9Cp9wUj3ovQq/Fqjyn9r6zqUos
         oVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYMsTbtP6NeCgrVD8QshM21eBtxJUc3oCaOr2a3X8UM=;
        b=Stq5X3b1nNQJVMTcd8gb7Yqlra3hU2bkHeQIIfsY2E9OjyQ//4fM7zJ+vQJH7/SEQv
         SwGjpgt+pdxJJ12KF9ENdEPMYZL0D4METKh1FM4kIRKx4Sy0ElTtyn3GAtSeUtMbccUr
         hxPdF6tWUFORfwxgCGpNfQD18+rBWl4fO2VqdDUS/xZZqn2ZrRoApoMqzdMnlyUbRlo+
         2NHrmXqwFZlDnzbqtXy17D77AWIIwkDyb1rykdpMO23ByJjtxJngaDhyuceXfVSD/aNh
         TjbSzgZpoPiiQceVSt15P/o627f/ZJuu3VHYgg9CTZVqENIPt9HX8hma8hSMTUYAH+yK
         LOnA==
X-Gm-Message-State: APjAAAUxpXH4ZWXFJ0zhGWchP75aKB6w6XWNiDs52oaKQgQrv0HvwIDk
        XODY5GePdYnk5HZXSMOJpUIdaTeuLDBHqov2Wfw=
X-Google-Smtp-Source: APXvYqwNZyp9ql8vwqOcoSI43eIU/dGPsxj89KUDohhSDudUayjF5VZ9sbePGhr9L2zF6N+c0oJIy3DeuInn6YsXggE=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr1817234itf.123.1552393179498;
 Tue, 12 Mar 2019 05:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com> <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
In-Reply-To: <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 12 Mar 2019 19:19:13 +0700
Message-ID: <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 3:51 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > then it'd make sense to use --recreate instead.  But if you
> > think some might adopt a workflow where they just use -C without first
> > trying -c ("create this branch, and I don't care if I made it before
> > just create it here"), then --force-create makes sense.
> >
> > Another option, possibly showing my lack of understanding why this
> > flag was useful in the first place: just drop this set of flags from
> > this command.  People can switch to the branch and then use reset
> > --hard <startpoint>, right?  Or (if they don't care about the reflog,
> > which they probably don't) delete the branch first and then recreate
> > it?  Not sure why we need to give another way to do these operations.
> > (In contrast, I see -c as being used frequently enough to have merit
> > even if it could be implemented as two separate commands.)
>
> I tend to agree with this but that's probably because I don't really use
> checkout -B. I'm not sure if it's widely used or not. I do find checkout
> -b convenient though.

Yeah I think both -b and -B are about convenience.

Another point is multiple steps of switching and resetting could be
really painful for people with large worktrees. Doing everything in
one go is probably preferable because it generates less I/O.

The mention of "git reset --hard" triggers me because I secretly want
to replace that command ("git reset", all modes), and in the last
"promotion" patch, "reset --hard" is replaced with "switch -C" three
times. We get really close to replacing git-reset if we have something
to say "-C <current branch>". Whether this operation fits in the
"switching things" mentality, I'm still not sure.

But I would not mind dropping -C for now, if people think it's not
that useful. We can bring it back in incremental updates if we realize
we miss it so much. I'll keep it unless somebody says something.

PS. The same probably goes for --orphan too. Wait and see if people
complain, then we know how they actually use it.
-- 
Duy
