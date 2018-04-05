Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63F3C1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 19:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeDETQC (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 15:16:02 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:38315 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbeDETQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 15:16:01 -0400
Received: by mail-vk0-f47.google.com with SMTP id b16so15161225vka.5
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wlX81Pfk9YRCt/CufXFFSugpLzdoL9NvX+ymfBKyZOY=;
        b=jaD9SqDrGGONrmaxXjuxvTX1fAT85saXzml62bWS2nZB1B3aeqcO6l016ECd2wD+ta
         MgWrEPmbJeixMnl3Kfl1eQWph/uEXQM+K+kOcC6FjHwdzWa3frySan9PwxTn2CHb+Sd5
         YM+hOPpSif9GxeE4gYjutctU88EO2ZjrVt4Zn3IR+sWZbqlbNwHLt6jR/VCb9/BiLuGd
         AZC/3klrodaounO7d7t1STfS6TehmMA+rWCGkk9MoXDUPutLUUUUW/AcVcNSVMJBT3N4
         glbjpq5LVrF+t6AutFZG13iQPqs/cnoMu0KI57uZ+ZOM1dcGLwH786fNf2HqNioiWhTF
         YJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wlX81Pfk9YRCt/CufXFFSugpLzdoL9NvX+ymfBKyZOY=;
        b=qksFa9AFEPKLpV21HDjZbS8GjbK6OsxjNTlfGXXfFoLGsHhrsiQvTOZ29bm6XsY02E
         Kxh/LwTWGr6YYuXyZgmMijaKgXv7NbXrmnIh29njlXT2FxCRSNoB3cFNztxTTAFHK63H
         fIOYeIM1OKZwvGelLg44vpgVfoOYgo3V1XVSZi288bqQGuWE5P7C6Bf9Bupn/1iGsVSg
         8PzhF14Kd4f8+5n3OkkjYcYTsmxkvRzMiNRA1EnbnQLqOVrN16iTwJF884zWWHi2q7VC
         F+zf75/fCA2kUzz+L/XOTPTj2jU1oT/KHdYSb5mrKEnG/VrEnK0Y2uOw5bS4auBOVE/B
         JW/Q==
X-Gm-Message-State: ALQs6tDnPZVh67T8fQcjRpzBrEKpMMyExxE404Dzuc3W+JQALfHZbruk
        ghgkrq+oZGmZNQM8tclnVuoJ068JdP9zY25btq65gQ==
X-Google-Smtp-Source: AIpwx48z48rwt+aDyG6ngtl/mWXnHCr3AKrxJ7IalegokEH4Ny+hOkK2Q4Ft2Fvqp6vOv+WZzLydifBdc6WgjzUrqQM=
X-Received: by 10.31.192.146 with SMTP id q140mr14261807vkf.7.1522955760812;
 Thu, 05 Apr 2018 12:16:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Thu, 5 Apr 2018 12:15:59 -0700 (PDT)
In-Reply-To: <20180405185805.GA21164@sigill.intra.peff.net>
References: <20180405173446.32372-1-newren@gmail.com> <20180405173446.32372-5-newren@gmail.com>
 <20180405185805.GA21164@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 Apr 2018 12:15:59 -0700
Message-ID: <CABPp-BEnFiEnao0NqU3GerYkpxO9fJadQLHo6_PZ-hXLZfbbdg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] dir: Directories should be checked for matching
 pathspecs too
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 11:58 AM, Jeff King <peff@peff.net> wrote:

> It sounds like correct_untracked_entries() is doing the wrong thing, and
> it should be aware of the pathspec-matching when culling entries. In
> other words, my understanding was that read_directory() does not
> necessarily promise to cull fully (which is what led to cf424f5fd in the
> first place), and callers are forced to apply their own pathspecs.
>
> The distinction is academic for this particular bug, but it makes me
> wonder if there are other cases where "clean" needs to be more careful
> with what comes out of dir.c.

Interesting, I read things very differently.  Looking back at commit
6b1db43109ab ("clean: teach clean -d to preserve ignored paths",
2017-05-23), which introduced correct_untracked_entries(), I thought
that correct_untracked_entries() wasn't there to correct pathspec
issues with fill_directory(), but instead to special case the handling
of files which are both untracked and ignored.  Did I mis-read or were
there other commits that changed the semantics?

Also, it would just seem odd to me that fill_directory() requires
pathspecs, and it uses those pathspecs, but it doesn't guarantee that
the files it returns matches them.  That seems like an API ripe for
mis-use, especially since I don't see any comment in the code about
such an assumption.  Is that really the expectation?
