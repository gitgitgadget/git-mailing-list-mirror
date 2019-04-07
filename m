Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D225D20248
	for <e@80x24.org>; Sun,  7 Apr 2019 23:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDGXlE (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 19:41:04 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46092 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfDGXlE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 19:41:04 -0400
Received: by mail-ed1-f45.google.com with SMTP id d1so9974416edd.13
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFNaGXSPJUxCiRUQk2d0R1Zbt5Q9tzr1XDkOlBM7L6w=;
        b=oWOTDeRaWAWXN6mWK3jBJvzJ7U8hajATn3RVuSbk///B2cbplFk3dNn6MvubxRA84G
         K+H2zGHGVG67fMJDe7S2yCaRwKjzQ/q9An0D1UctXja05i8eC/BfCVAL8YxbCFbapLg6
         k/4W6SJCmrV3rs/qIiTNRDDVXF/2tgG4KwRT3qHrRk/mPlRza2gZKggWV3ri0LDFMfPX
         ZSvgIzlxmzpWLHZSI/LXWGO5KbkWYqY5R7TmamWcRYq32oqNX5l2IcCV0hihN/E78cKA
         oXVSkwpsAxiIPOciIIfcZHJUqY3A2L2RW2CVapfAdlCZDusGMi1QjCKssJLJZ6BAMNZY
         Hk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFNaGXSPJUxCiRUQk2d0R1Zbt5Q9tzr1XDkOlBM7L6w=;
        b=HBa/ltD4hyzMmpjDDiCiK2X70k6U+6vXBD4p582QkxC5OktKnPTaQDGMRa0qsq/jdc
         qxOxr3EDF0w11+v6Y1iEHiAMYrZx6t0YsucayEnlZh0pFKmzco0ZWivLpZyvj1zVsxaF
         yk770xoHfvlg51ijOdjd1Ex9RFxrcYA/jHk03sNXnyv/H88hR6X5S1CWAPXOH8Elbpsh
         RCwy4sMM4FqPlbNks5bUpixcs+c+Ot/G8xMtIRgEkonBC2bI2JVRE11plz0VDCXbABeq
         2Vezh8qiFm/VAVnHKLocoY5c/3l2NCZXRJ4t3R2M6lrKBXfu+47C142Q8K8zvzdzW3PN
         Ur9A==
X-Gm-Message-State: APjAAAVUJJD5KfEZkkBlRAVMT66w6h7sDugb0MhiOjdXn4QV94pxvn/O
        q6Yhfif5PGpT28c+SSyYMH9JJ/VbJnlCLPUJsklESw==
X-Google-Smtp-Source: APXvYqwdkbfJ4R+AZ/o07myfq9K0jY8ZpJZCFAQAlHTO7GeR3o6Ts6WvjDMAGaJVBO+dFB2YD9q9+CZNG8MPxIyUPfc=
X-Received: by 2002:a17:906:4d85:: with SMTP id s5mr15002429eju.18.1554680462468;
 Sun, 07 Apr 2019 16:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
 <20190305045140.GH19800@sigill.intra.peff.net> <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
 <CAHd-oW4LsyZOgHYgKaACX8AtzbA8pBpFUPWSF3GF6XxA_HKfjA@mail.gmail.com>
 <CACsJy8Bit46VatYZNB-ZsMBL043_GYDLqZ3fAZ8HzXZ9Kv1Z0g@mail.gmail.com>
 <CAHd-oW4e6CtcaKXbowqZM-pDAEGJxupHwBvFk2veaaYswt0hmQ@mail.gmail.com>
 <20190312100237.GA20471@ash> <CACsJy8C=1dj-1T=5dt92LK5_Ario_YL2hkQWpi2dkhXyYY=_Hw@mail.gmail.com>
 <CAHd-oW7fXbJyxesgCoiTOWGLH9Tpk5FUN7VsaBrqU842BJpT3Q@mail.gmail.com>
 <CAP8UFD33xf8FMuVNakzaUhYXo3A2fnvBAoFgoDQUOKgqnWYQBw@mail.gmail.com> <CAHd-oW6iBQJ_SCTbRtDdWrg=NftqcMhyZ=SFkj7Am==OpG3bTA@mail.gmail.com>
In-Reply-To: <CAHd-oW6iBQJ_SCTbRtDdWrg=NftqcMhyZ=SFkj7Am==OpG3bTA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 Apr 2019 01:40:51 +0200
Message-ID: <CAP8UFD0h6kgSFCp8QsT--LPNNneiFAXOzNY2zxouBc0jBqeN9g@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        David Kastrup <dak@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 5, 2019 at 6:29 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Thu, Apr 4, 2019 at 4:56 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > Nice investigation. About git status I wonder though if they have
> > tried the possible optimizations, like untracked cache or
> > core.fsmonitor.
>
> I don't know if they did, but I suggested them to check
> core.commitGraph, pack.useBitmaps and core.untrackedCache (which Duy
> suggested me in another thread).

Thanks! It would be nice to know if it has improved things for them.

> > I can't really tell as I haven't studied this, but from the links in
> > your email I think it kind of makes sense.
> >
> > Instead of doing assign_blame()'s main loop in parallel though, if my
> > focus was only making git blame faster, I think I would first try to
> > cache xdl_hash_record() results and then if possible to compute
> > xdl_hash_record() in parallel as it seems to be a big bottleneck and a
> > quite low hanging fruit.
>
> Hm, I see. But although it would take more effort to add threading at
> assign_blame(), wouldn't it be better because more work could be done
> in parallel? I think it could be implemented in the same fashion git
> grep does.

Yeah, I agree that it seems to be worth the effort.

> > I don't think you need to study everything yet, and I think you
> > already did a lot of studying, so I would suggest you first try to
> > send soon a proposal with the information you have right now, and then
> > depending on the feedback you get and the time left (likely not
> > much!!!), you might study some parts of the code a bit more later.
>
> Thanks a lot, Christian. I'm writing my proposal and will try to send it today.

Great!
