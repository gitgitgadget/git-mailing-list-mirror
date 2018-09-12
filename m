Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F081F404
	for <e@80x24.org>; Wed, 12 Sep 2018 06:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeILLYS (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 07:24:18 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36373 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeILLYS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 07:24:18 -0400
Received: by mail-ua1-f66.google.com with SMTP id c12-v6so760803uan.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DToCHqemvvCHsAvpp19z350ScIM2dDRL7BwqFQ6zlqU=;
        b=ZBvoK1/jUGBebIJt1zx926I1nPTHpbNwGTj4NAJ5yP/b2u5PUrqkRe30xz7UHdP4Ts
         dKTZe/In2HR7YFeL7g/+o5JWnUa/l8SAb3ZlRRkhRNzUfWOonyIq8WT8zqtV8rW6oWyX
         7EirV1ZQQBoxLJR3Zmjumyxn8YZ9uaKk/e4Lvb8zNl81JvvngK+2ILZa5PSEpEiwYz2L
         zUee88FpctfMtpkm+gAADZnnKtKuQ9fcZWqxX5kvmqg+ktxPGlinA3NJobbytcBFtSbs
         KJh6z24j/bU3h7jINa273ugVLRB3qrpEN7AhPTc0JgzCFKx2lyKGOHiD6VC36vk2dyxh
         dboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DToCHqemvvCHsAvpp19z350ScIM2dDRL7BwqFQ6zlqU=;
        b=Q/t0a5gCLNUiDZMBikB7w3xDN70uSffTlzDizU8E5PRWjNnKnLF8szACVd+IiMZK/p
         BHEQ8IZ1pc2wRdsUuahT5JJU8Jgf/6C0HKg0vHmdQ3yzyyRWtzeor2yPl0u/TxchfcUC
         WPHk7obdoic6aejM63QEw3nTuIXvYv6fJmg6co5CN+gq0OERRZy/BssmO/eqhSDB3Z/h
         YghQDjBAbZvvXNRd24QVqG17iXv1hPpMPuv4wuRgG3KMQ/nP/2Ikpo4QLmSz20Ba2/tR
         YswxNmHcyLCxuJ8lThv76n2soHa4vbKJdemfi7SL81tkur8iDiNmATkjMXdT8MXHrMfu
         Ycqw==
X-Gm-Message-State: APzg51DWGfgLcyprFd8blLQ5HMtJBgS9TF5NdvFODOHJnnTLzsQfebPh
        AYMt78HTokGjdrkwHoZtuT0BaedADKD5z28yty9uBQ==
X-Google-Smtp-Source: ANB0VdbjPrya2fofkgcr+EMMGk5JjgwNlg2Lq5qL1ihiKhKTGtmg6ACnhyzrz2HM00ovoNu99LVeej104Y2RQmImecs=
X-Received: by 2002:ab0:5339:: with SMTP id x54-v6mr113689uax.187.1536733278626;
 Tue, 11 Sep 2018 23:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180625161300.26060-1-newren@gmail.com> <20180627072319.31356-1-newren@gmail.com>
 <20180627072319.31356-10-newren@gmail.com> <20180912024241.GA27036@localhost>
In-Reply-To: <20180912024241.GA27036@localhost>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Sep 2018 23:21:07 -0700
Message-ID: <CABPp-BEe=NCXhaCcbNQv6vxcuD2oWMvMfMMPv5+RVKfqarc0hA@mail.gmail.com>
Subject: Re: 2.19.0 regression: leaving editor with empty commit message
 doesn't stop rebase [was: Re: [RFC PATCH v5 9/9] git-rebase: make
 --allow-empty-message the default]
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Sep 11, 2018 at 7:42 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> Lately I noticed that occasionally I ended up with an empty commit
> message after an interactive rebase...those empty commit messages are the
> consequence of a regression in v2.19.0, which bisects down to this
> patch.
>
> To reproduce the issue, just start an interactive rebase, choose a
> commit to reword, save, delete all the commit message, save, and BAM!
> there is the commit with the empty message.
>
>
> On Wed, Jun 27, 2018 at 12:23:19AM -0700, Elijah Newren wrote:
> > rebase backends currently behave differently with empty commit messages=
,
> > largely as a side-effect of the different underlying commands on which
> > they are based.  am-based rebases apply commits with an empty commit
...
> I agree that this is an issue that should be addressed, and also agree
> that it's reasonable to accept an empty commit message, if the
> original commit already had an empty commit message.  (Though perhaps
> not completely silently, but with a warning?  Dunno.)
>
> However, this should only be the case for existing commit messages
> that are taken verbatim, but never in the case when the user is asked
> for a commit message.
...
>   # Please enter the commit message for your changes. Lines starting
>   # with '#' will be ignored, and an empty message aborts the commit.
...
> Let's suppose you start an interactive rebase, choose a commit to
> squash, save the instruction sheet, rebase fires up your editor, and
> then you notice that you mistakenly chose the wrong commit to squash.
> What do you do, how do you abort?

All sound like reasonable arguments to me to differentiate between
commit messages that started empty (which I admit was what I had in
mind) vs. ones where we asked for user input and it came out empty.

Are you cooking up a patch?  I might be able to find a little time to
dig into this tomorrow if no one else is working on it already by
then.  It'll probably conflict a bunch with all the
rewrite-rebase-in-C topics in flight in pu.  :-(
