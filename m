Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F271F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 02:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeJIJay (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 05:30:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39161 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeJIJay (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 05:30:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id p1-v6so31285ljg.6
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 19:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0O9ZWLgQsXblipWmzZ3DhYEc6qSfo5eLQVrfKCj7maA=;
        b=F6xmg7zLvtw+Z/kZ8xVbT3CWZL/Q6doYfpTGzPaOmMUPRO/Im4UC7hwQahR977ZeCz
         j5VVt/50G1v8Q2nqbSkVT3Prz4lBSYIddzYdnTrLZ1Uo+m6pJDsdCNFfeVTHr1XdVxdG
         +pH9hwbnQLBJz7p5qVWhgMP0fTa5BCI+RL48Jh+CIIewfgzwzvmihD+oE7Mref4nhukY
         Ej9oyhL0nrcBq6kG2PBR8PSxoOusRo/GHrvky2l5Li+YGcnkL3U4FuPmgUdgaKVngR9D
         PjI9lFkVBR1+TZq0jifij+tjFRJ9jn15rJ+IpxUuwW/HJvhVMy7nn1Am/s1oy7ewzDGW
         /M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0O9ZWLgQsXblipWmzZ3DhYEc6qSfo5eLQVrfKCj7maA=;
        b=qb8UVhPuF0Gow7DmCQWAY5Q2ICf2Bf9T35BKBDrXZ5Tg6P3QJEiolTrSzg3cHnZbwx
         z6hc+9LYePnj4AM3PzWrkU/SGklTy6EF75ZKp5GQ02NvYzr9fb60CQdDFJpBc1bQXiZV
         5cr/gCBYUZ0VFakaPYw8iIyhm3oTSvts+acjdC2IhftF2F8Hvg/Fe+CUNrOqf6cxjIW0
         ZcLM/WD5zQ6NgyhdeJLgvEW0dAoAbiEiTq9/1fTXM1SsMvDhp6GmNjk5jAO6WUcGygKN
         MPm6yLskxy4hwOudOwhcUjeqAibL1HAZcJ3uENzf3Z0oi/6+vqL9iIvO7F4ahlT4y3QI
         FlQg==
X-Gm-Message-State: ABuFfojJfVxSZ65R9LWtjif3Pqt5D10Eg6k5JQDaxnbvMYJkNM78BOX3
        g5XPoL8EUPJ7md9T6OceW3okH2qhqpCKK6g5tLQ=
X-Google-Smtp-Source: ACcGV63S/A8z7ifqVT0Jq6fuT2WqUNeeIRXmnArQxhoxc7lkvoYepmgYOe16gi0sEkFy6TCl8RYUOUUANdtOhAufSXk=
X-Received: by 2002:a2e:9047:: with SMTP id n7-v6mr14139507ljg.10.1539051376606;
 Mon, 08 Oct 2018 19:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181008170505.GA13134@manohar-ssh> <b1824db3-1c0d-6851-2f5a-800cc88ee50f@gmail.com>
In-Reply-To: <b1824db3-1c0d-6851-2f5a-800cc88ee50f@gmail.com>
From:   Ananya Krishna Maram <ananyakittu1997@gmail.com>
Date:   Tue, 9 Oct 2018 07:46:05 +0530
Message-ID: <CA+=o6KHNyj2FymzGEwt6=tTHF=Eqy=OPz_Z1KD+Ryi6kdFemJQ@mail.gmail.com>
Subject: Re: [PATCH][Outreachy] remove all the inclusions of git-compat-util.h
 in header files
To:     stolee@gmail.com
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 8 Oct 2018 at 22:43, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/8/2018 1:05 PM, Ananya Krishna Maram wrote:
> > Hi All,
> Hello, Ananya! Welcome.
>
> > I was searching through #leftovers and found this.
> > https://public-inbox.org/git/CABPp-BGVVXcbZX44er6TO-PUsfEN_6GNYJ1U5cuoN9deaA48OQ@mail.gmail.com/
> >
> > This patch address the task discussed in the above link.
> The discussion above seems to not be intended for your commit message,
> but it does show up when I run `git am` and provide your email as input.
> The typical way to avoid this is to place all commentary below the "---"

Sorry, I didn't know that. Shall I re submit the patch with proper commentary.

> that signifies the commit message is over.
> > From: Ananya Krishan Maram <ananyakittu1997@gmail.com>
> >
> > skip the #include of git-compat-util.h since all .c files include it.
> >
> > Signed-off-by: Ananya Krishna Maram <ananyakittu1997@gmail.com>
> > ---
> >   advice.h             | 1 -
> >   commit-graph.h       | 1 -
> >   hash.h               | 1 -
> >   pkt-line.h           | 1 -
> >   t/helper/test-tool.h | 1 -
> >   5 files changed, 5 deletions(-)
> >
> > diff --git a/advice.h b/advice.h
> > index ab24df0fd..09148baa6 100644
> > --- a/advice.h
> > +++ b/advice.h
> > @@ -1,7 +1,6 @@
> >   #ifndef ADVICE_H
> >   #define ADVICE_H
> >
> > -#include "git-compat-util.h"
> >
> >   extern int advice_push_update_rejected;
> >   extern int advice_push_non_ff_current;
> > diff --git a/commit-graph.h b/commit-graph.h
> > index b05047676..0e93c2bed 100644
> > --- a/commit-graph.h
> > +++ b/commit-graph.h
> > @@ -1,7 +1,6 @@
> >   #ifndef COMMIT_GRAPH_H
> >   #define COMMIT_GRAPH_H
> >
> > -#include "git-compat-util.h"
> >   #include "repository.h"
> >   #include "string-list.h"
> >   #include "cache.h"
> > diff --git a/hash.h b/hash.h
> > index 7c8238bc2..9a4334c5d 100644
> > --- a/hash.h
> > +++ b/hash.h
> > @@ -1,7 +1,6 @@
> >   #ifndef HASH_H
> >   #define HASH_H
> >
> > -#include "git-compat-util.h"
> >
> >   #if defined(SHA1_PPC)
> >   #include "ppc/sha1.h"
> > diff --git a/pkt-line.h b/pkt-line.h
> > index 5b28d4347..fdd316494 100644
> > --- a/pkt-line.h
> > +++ b/pkt-line.h
> > @@ -1,7 +1,6 @@
> >   #ifndef PKTLINE_H
> >   #define PKTLINE_H
> >
> > -#include "git-compat-util.h"
> >   #include "strbuf.h"
> >
> >   /*
> > diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> > index e07495727..24e0a1589 100644
> > --- a/t/helper/test-tool.h
> > +++ b/t/helper/test-tool.h
> > @@ -1,7 +1,6 @@
> >   #ifndef __TEST_TOOL_H__
> >   #define __TEST_TOOL_H__
> >
> > -#include "git-compat-util.h"
> >
> >   int cmd__chmtime(int argc, const char **argv);
> >   int cmd__config(int argc, const char **argv);
> I applied these changes locally and confirmed the code compiles, so all
> .c files including these _do_ include git-compat-util.h properly.
>
> Thanks,
> -Stolee
>
