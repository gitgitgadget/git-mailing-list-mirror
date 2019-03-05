Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC5020248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfCEM5q (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:57:46 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:55379 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfCEM5p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:57:45 -0500
Received: by mail-it1-f169.google.com with SMTP id z131so3910050itf.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bFEYfeJGX1DVKMx1u7tJT8s42+/eUmywnUz5Kv00tE=;
        b=amtfh3MWT4p2ofO8+ZuUgaNkxxvz8T4LvWyTawe1agOPJK3GTLt2ThW2jhZhOrxfxX
         8G7efTGIudDABHpKf8A1GV7EDgmwJKSDER+oJSBTHheNHxHJqgfejpqEUEFmZkQjiLZR
         KZgT+HuxwSD6TWgx+Txctn9KF1qHOmRe+bwGXK+l0JfD8IkZbXMxVdoU8Gj1iYATb0NK
         5d51nQB0MtHTo9NpbYMR1dZ6SWuTcATisqvwYRVXDKXwXIizUqC4fMG7LqadaHpeZMOL
         4T792woY2QTxzshUK5WQP2xXQRjXD8lvuw5ANNUcrzdrC+TwmiTiQGtOMX4YpNvBTgFL
         HKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bFEYfeJGX1DVKMx1u7tJT8s42+/eUmywnUz5Kv00tE=;
        b=tQ7lhu03XKGGGOy5zl4Lo5aXKjR02Hb/sJYIVGLWgw09KgszgvRSjf5GTQcGQ6LcCN
         nRz5Btj4XILgWusKny2O/T6pljJ4mD7ePGrtyhAXJEhLNhqC/w9/6WJXiasq1SA4VUa6
         rlMAx24JJm4OFEzphm4FuPNBTEEFlDmB6fZPZNThHDztXwJIj6bQimGjkI/sGP5g84JS
         FYccf+ALw+YzDXmx+3GTlyiyoSTeyDMHFx50rF/F8JK+vY0MW9bn17G6Ja/Popq4P7gz
         nNoMSFbZT2Gm4HVPC6f2S+aX+sEMscBgIfvBeNRqn5YMymp4odAgyg/EgYrTD0uc75uo
         or7Q==
X-Gm-Message-State: APjAAAVBsJFUg2vjSYQ0lCEzfEq+Pz8RFuWSH3t6C7ZzA+eLuJWBAj9t
        m3s65Zwj/8vLbMNunRWmTYB5bxX1GMmlS2WOy6U=
X-Google-Smtp-Source: APXvYqx2KslmGxUu5RqcKL7xNVlXvtdWPwcgTmCYwlzCYAWfpN2YE6cleCoZ9BGgrsnJs1W3g3o8Zn26ISN/aOv2BCc=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr2167504ita.10.1551790665143;
 Tue, 05 Mar 2019 04:57:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com> <20190305045140.GH19800@sigill.intra.peff.net>
In-Reply-To: <20190305045140.GH19800@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 5 Mar 2019 19:57:18 +0700
Message-ID: <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 5, 2019 at 11:51 AM Jeff King <peff@peff.net> wrote:
> > processing power from multiple cores, but about _not_ blocking. I
> > think one example use case here is parallel checkout. While one thread
> > is blocked by pack access code for whatever reason, the others can
> > still continue doing other stuff (e.g. write the checked out file to
> > disk) or even access the pack again to check more things out.
>
> I'm not sure if it would help much for packs, because they're organized
> to have pretty good cold-cache read-ahead behavior. But who knows until
> we measure it.
>
> I do suspect that inflating (and delta reconstruction) done in parallel
> could be a win for git-grep, especially if you have a really simple
> regex that is quick to search.

Maybe git-blame too. But this is based purely on me watching CPU
utilization of one command with hot cache. For git-blame though, diff
code as to be thread safe too but that's another story.
-- 
Duy
