Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296F820248
	for <e@80x24.org>; Mon, 18 Mar 2019 17:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCRRHX (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 13:07:23 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:35673 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfCRRHW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 13:07:22 -0400
Received: by mail-vs1-f53.google.com with SMTP id e1so8940237vsp.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ny83X+LGUA5y7kL5BrWtCvZ0I62uwFzR+c7KUEVuUrk=;
        b=d+UI+nPIB5bll6MECzufg+OlluV02nz6Hbt4LLRe4+p0A9cCFeR/OH72so7aBvOHE+
         TXA8wW5Vu4LKSRACo4gbvAFocojx8FG5zst7qDRa1mHaA4nFgzVKLMcXUVuQYpjoC/gW
         Add6pPgCJfg0IF6yYQykoVJHe8YwbagokoH0BClJgkCzMxK5NZ7KKdlo+VvzBSlAaxIj
         4fucqsA6x7WlDN8V7e5cb4x7vB+2Ho4IUe6Zo7wQXsXGLmg3vveqbk8UUbnsAuqM9YLi
         c7QP8sGb/o1EhX9zCPHaNXJEiL+0IMjLXWcEnEVQikpyp1v0ux/txAiWFvoh6pRaBuYj
         TZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ny83X+LGUA5y7kL5BrWtCvZ0I62uwFzR+c7KUEVuUrk=;
        b=mbUZhf/6JhW14kSkAVEI5ENmNhQbkHXTXXJZ8OSojwtXucWSWXVON0HqRXC12rx9ow
         R9FIBNUxjD2OqpxltZ00cWo33yiqlXgZB9jULsobES5F/8jn7LVPjP3j5lsVCGzxu72Q
         Z9Cf2cwffqnpa8Q/ZwFjWOWC5c1gMCdcQVPOoe+Ut23JYeC2teQnHrwAJSKg64Ln/npG
         CRJVZntbdra4w0bNX4hv+Gs/ZqOpbrNMAbUEfy2XULjCWNWNPiMcq8pzvUIosYDG45JX
         68L12tnGWdxgn3USekCTqIf80NzkLBQDHU1/joMDeQEDe2C/3wY/AFKWMj6UNbbgD2ub
         YY2A==
X-Gm-Message-State: APjAAAU7WYAUonvXsrtq2znc2P5h5OmfXMOTh4YDI4EvxEIP1bIti3B3
        Vctba8/Z6Db3/nA5eiKHjobcwppVI3dMVkAdVVg=
X-Google-Smtp-Source: APXvYqwD3oQwIGvrKrzRMwlxyb+To/fUrkHME07qMD6LhGChPtTJQ3iuX6++rW52Tx7GntoAjcXc9CXyvphUo4R7Lng=
X-Received: by 2002:a67:eb97:: with SMTP id e23mr9969819vso.175.1552928840780;
 Mon, 18 Mar 2019 10:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190311093751.GA31092@archbookpro.localdomain>
 <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com> <87va0orop4.fsf@igel.home> <87wol3bydp.fsf@evledraar.gmail.com>
In-Reply-To: <87wol3bydp.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Mar 2019 10:07:08 -0700
Message-ID: <CABPp-BHMi=RTWAVjuORdTWY3ijp4EKhy2QAH0=WrviCiotJtyw@mail.gmail.com>
Subject: Re: Deprecating git diff ..; dealing with other ranges
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 2:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Mar 12 2019, Andreas Schwab wrote:
> > On M=C3=A4r 12 2019, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> I however think it may be worth making sure that our docs do not
> >> encourage "diff A..B" and teach "diff A B" when comparing two
> >> endpoints.  That can be done without changing anything in the code.
> >
> > The nice thing about "diff A..B" is that you can c&p the output from th=
e
> > fetch run without the need to edit it.
>
> Not to shoot down this effort, just to add another similar thing I do
> regularly for ff-branches:
>
>  1. Copy/paste A..B fetch output
>  2. git log A..B
>  3. ^log^diff
>
> I.e. I just need to tell my terminal to re-run the same "log" command
> with "diff" instead of "log".
>
> Of course as covered in the linked thread it doesn't work for some
> (non-ff) cases, and I'll sometimes end up cursing it and swapping around
> ".." for "..." with log/diff.

Doesn't this somewhat imply that although you use diff A..B here for
convenience, that it's actually wrong since what you really want is
A...B?  Or said another way, the end goal of deprecating "diff "A..B"
then later reinstating "diff A..B" to mean the same thing as "diff
A...B" would actually be better even for your usecase?

Of course, switching to the removal period may just be too painful for
too many folks since there are obviously people that use it, but I
just want to see if I'm understanding correctly here.
