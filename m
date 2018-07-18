Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748521F597
	for <e@80x24.org>; Wed, 18 Jul 2018 18:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeGRS4E (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:56:04 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41758 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeGRS4E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:56:04 -0400
Received: by mail-yw0-f196.google.com with SMTP id q129-v6so2072025ywg.8
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06DiB+YzSh9i/f/MHnVOF+rJ6Xs/EipcoJO7qnl7GCY=;
        b=uF3gqr8sXRLtHrEM1HOTxCJMJcWAPQZMUFoeQ69BTYopW4ftp7icV/0hAuaaVPS2OY
         A6YPc/9WSfSVS8UmLT1SiYbhYjGzEcAx5VVXzaR8AFhwuZWyjoHzPm6IEwhFSXtkBs8Y
         i2AhhIMgfoTakTBg0oRLyVoOsJM+dwKJYV5y9GrglfaJEY/phNQ5nfnyqsyUwTALAxJa
         52S3c1Cv+zBgZlC01ZfwMu4rGpuyMFrlPgFuGFzeN7oFS+UwA0Z9pc+Noch+KMQlsdHo
         lywrqLwtvJ3mXrE2KysKx/9JxhBwQPHytpgyeF55yBXgfSlUuwKBee+wxyRNNu46bTq2
         b8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06DiB+YzSh9i/f/MHnVOF+rJ6Xs/EipcoJO7qnl7GCY=;
        b=LLJFjdBaE8zZspLrQVm6cz8NixPWCdPPxxUqRRqChBA2wx+LntBywOWM414loVLgZb
         jRAjqQHdwnm2jxeVgElR7s7qLmm2LNK+bey+qLdkBXnLrO/q/aezb1Le0edttOzQmBdp
         3naHKqCE9XfZP2Ku/mNnhqnFHGIq7BVPQaCPoNDPen0wmk1weWLXv7BpPj1QixnEVpdz
         Y+BZIVkHxZdNa4GNfy/WtggfbijoipK3FVlDe95bMLaS9UJ8PlaXpo8u1Z4dI07FWiTc
         9zBx+s2um6JosqdOdXvjdU6xV7ZmBGRYRlA7AS5ob0eh5CRqaMTNBD/VP/AmA6DiSHex
         V/FQ==
X-Gm-Message-State: AOUpUlEv830+sLmQvl+5EDZzITftj3pcLPqghoI5nKfll2+0rONc0x8e
        2+DzF6UphNXFOvWR/qA7iAw1ddVroMhvJktskHJymw==
X-Google-Smtp-Source: AAOMgpfikIis5k1pw1mzbd0SVLO0+Toasx9rcIkwRZ1pOfzOv5G4E6hSrqETxKYatjj8iDoVMDv4AOdm/k780hcC8+k=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr3600023ywh.238.1531937818503;
 Wed, 18 Jul 2018 11:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180718005311.136329-1-sbeller@google.com> <xmqqy3e8jv4x.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy3e8jv4x.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 11:16:47 -0700
Message-ID: <CAGZ79kbOxD-GomEYGkOPe9bPT8sgik77hLaTHK1xN9Hk=g+BvA@mail.gmail.com>
Subject: Re: [PATCH] diff.c: offer config option to control ws handling in
 move detection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 10:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> > index 143acd9417e..8da7fed4e22 100644
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -294,8 +294,11 @@ dimmed_zebra::
> >
> >  --color-moved-ws=<modes>::
> >       This configures how white spaces are ignored when performing the
> > -     move detection for `--color-moved`. These modes can be given
> > -     as a comma separated list:
> > +     move detection for `--color-moved`.
> > +ifdef::git-diff[]
> > +     It can be set by the `diff.colorMovedWS` configuration setting.
> > +endif::git-diff[]
>
> The patch to diff.c::git_diff_ui_config() we see below does not seem
> to make any effort to make sure that this new configuration applies
> only to "git diff" and that other commands like "git log" that call
> git_diff_ui_config() are not affected.

That is as intended. (We want to have it in git-log)

> And I do not see a strong reason why "git log --color-moved" should
> not honor this setting, either, so I am not quite sure why we want
> this ifdef/endif pair to hide it from "git log --help".
>
> Or am I totally misunderstanding the reason why we want ifdef/endif
> here?
>
> Puzzled...

I am somewhat puzzled, too, by the use of ifdefs in
Documentation/diff-options.txt, but I rationalized it as
"man git diff" has all the details, whereas the other pages are
a bit shorter and concise:

$ git grep -A 2 "ifdef::git-diff" Documentation/diff-options.txt
ifdef::git-diff[]
     This is the default.
endif::git-diff[]

ifdef::git-diff-core[]
     This is the default.
endif::git-diff-core[]

ifdef::git-diff[]
     It can be changed by the `color.ui` and `color.diff`
     configuration settings.

ifdef::git-diff[]
     This can be used to override configuration settings.
endif::git-diff[]

ifdef::git-diff[]
     It can be changed by the `diff.colorMoved` configuration setting.
endif::git-diff[]

ifdef::git-diff[]
     It can be set by the `diff.colorMovedWS` configuration setting.
endif::git-diff[]

So I followed the style that was already there, specifically
61e89eaae88 (diff: document the new --color-moved setting, 2017-06-30)
which followed the style of
6999c54029b (config.txt,diff-options.txt: porcelain vs. plumbing for
color.diff, 2011-04-27)

So I might have picked up a bad habit there or misunderstood the original?

Stefan
