Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91E2F1F932
	for <e@80x24.org>; Sat, 29 Dec 2018 21:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeL2Vbl (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 16:31:41 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37330 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeL2Vbl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 16:31:41 -0500
Received: by mail-ua1-f67.google.com with SMTP id u19so7789440uae.4
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 13:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qu1145HJ1AuNVJ+eB9n3FZ0ZPwBEdBKgWkJX7We4T8A=;
        b=om8KSymajpZA4MIPnKdgtlZZ9I/5VRcqtUNF583G1vDr2ffXYr25BtAcacsn26bf8c
         QY7w6PnoZq8ZjbomWX+GV8M3PH6AeroyKJ2pNdXWexDgeHTpk4AXuk1qY+MHC2htuSUE
         PSPGUlvyBoBJYq3BaiW9dBvV+3q/QzdgHGQuCipv3cm+J6je9Ml/CA+uoMLTmmngJL5o
         B1/UitD3CHg+r/lOIkx6DyPlsuLaLuLWXiMfxjGuaz15RCPKygbOMsMMRgZuFaI7naCe
         0Sy0j/Uy+Y3qEjqz0lCwJ5F4STkdZlN0Q3TTwszST3q7y9nT9zbAveUcjwksgEIdjm4E
         MaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qu1145HJ1AuNVJ+eB9n3FZ0ZPwBEdBKgWkJX7We4T8A=;
        b=c5KW1+qAWIDKf4mp0h6+suzniYzTpe+5cco0s9k8vzXPafkd+tffxqhXYJYqs0pBmO
         HZMnzcDpWJZbOLQdWbiE+Mt6rkRZa+RhMaanGj/NBTHzJeDK0UvXHu0VSNfLdb5IKdFL
         W4SqYyjgLCpfLJ3mibhilRNfOFUvICsKUnA49HnfFljN0AxJu6YVf15tg6KaJFQFihTJ
         rvMl3ghFSIRv7OSFNeJw+FiA/i+BuV0Cd2aB6NkxzHWPysnhZjlvV6KscjSTlC1JScaT
         /+Uw6gYUwPlofZwgzpXBsyfei4Um3Min7WLkPhdiEpyyq9dJ3WqDNiBkHGrjNqwSgdrw
         bLcw==
X-Gm-Message-State: AJcUukfn8fGLL9RvBDxkZoCSFAZQFhxVHDC4mp+P/8lPle/ZhUzrRdWS
        zT0hD3HmQMTlz/HmFbsasX/HCxbi5Hte0LBXBvTEm7qn
X-Google-Smtp-Source: ALg8bN5of9KF3lpSWQQChkv7xN9x1Jpl+kBB2zBtWCa5Y+ALKztVb4JhERT+yXjL3FJtBVKTkMnj6j+HAYy1POpT3m0=
X-Received: by 2002:ab0:430:: with SMTP id 45mr12180322uav.117.1546119099524;
 Sat, 29 Dec 2018 13:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20181224212425.16596-1-orgads@gmail.com> <20181224212425.16596-3-orgads@gmail.com>
 <xmqqimzdl0v4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimzdl0v4.fsf@gitster-ct.c.googlers.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sat, 29 Dec 2018 23:31:28 +0200
Message-ID: <CAGHpTBK+1JxhqGDNsjY4Qevd65gSYYeVMBVpHxa0=0OrKbbrEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 29, 2018 at 12:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> orgads@gmail.com writes:
>
> > From: Orgad Shaneh <orgads@gmail.com>
>
> > Re: [PATCH 2/2] Rebase: Run post-checkout hook on checkout
>
> There is no explanation here?
>
> Is this a regression fix (i.e. scripted version of "rebase" used to
> run the hook)?  Or a new feature (i.e. no earlier version of
> "rebase" run the hook but you think it ought to run it)?

Added an explanation.

[snip]
>
> > +#define RESET_HEAD_RUN_HOOK (1<<2)
>
> Would it be plausible that the only possible hook that can be run by
> reset_head() function will always be post-checkout and nothing else,
> I wonder?  Shouldn't this bit be called *_RUN_POST_CHECKOUT to make
> sure it is specific enough?

Done

[snip]
>
> > +test_expect_success 'post-checkout is triggered on rebase' '
> > +     git checkout -b rebase-test master &&
> > +     rm -f .git/post-checkout.args &&
>
> Read the title of this whole test script file; it should verify what
> is in the file before removing it.

Why? Other tests already do it. This test is meant for rebase, not
plain checkout.

>
> > +     git rebase rebase-on-me &&
> > +     read old new flag < .git/post-checkout.args &&
>
> No SP between "<" and ".git/post-checkout.args".

Done

> > +     test $old != $new && test $flag = 1 &&
> > +     rm -f .git/post-checkout.args
> > +'
>
> Regarding the clean-up of this file, see my review on the previous
> one.

Done

> > +test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
>
> The same comment as above applies to this.

Done

Thanks,
- Orgad
