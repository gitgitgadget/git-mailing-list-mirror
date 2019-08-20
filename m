Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D26B1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 12:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfHTMQu (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 08:16:50 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:42084 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfHTMQt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 08:16:49 -0400
Received: by mail-ed1-f44.google.com with SMTP id m44so6070396edd.9
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AdbQPcE2Vr0d6qQzSlkykgFLWGq+n3CxjBKq473hP8g=;
        b=bMxk9fOocvnRwKKAdO3Zwa8q5e6j+Vf2jGTGDsQciuDr4DGB9+LAZISnYrymUXnLVl
         e75QUOznXtWlmpiDR5czrC6LMiWDlVFNUSgonfHOU9oDYgBKYbeFGHbXt1MGK/EKEUn1
         SdX4rxoSJb/tPgfowAtWPx8gaZBTXpbSiTMr+yN+gsostHDwE6U21cxXgnEGlXrb/Bhp
         GWSYWCOKObdVKTYE3Mpfh70n7qka7J1IfUbmE049Vj5W240JOOlCKQY8wEoKwUvgoFHM
         YyAMoK9T9w8AvGFRFY2jxkgwAH9egMg1VzBe5774eyM1Bglu3wfONkAt3zvFPeFxkXIL
         KI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AdbQPcE2Vr0d6qQzSlkykgFLWGq+n3CxjBKq473hP8g=;
        b=sb+knknzi5Is455rlWxGKo3m5ozPem/pCUPyU921LIM/i6U/bmdwEl/sMtIAYRiKi1
         1N36jr5ApX/vCTraZk1WLAQL73B7fB2GAYZaMdMV25Ld5KuZNaU8yymiC2wH0UZ70ghN
         m4pLT8A++a9WTD/m/6+s1m69Cfk7aPZ43xrJzrcNSkEhFxKzt1tKEW4u1QrW881SSzMH
         LxJZ9piH1joASpu+3q7r7UizPX58EakGhiNRAI4yKIHgjBlyKn+wEVRpnvOdcDvOwvL0
         XSNG9PjrN3Ytee16MPNyW3MmtNlptrDlrAIGp3xGkZ2OqjGh4nuYxdW92BbnoIKZA0zS
         tACQ==
X-Gm-Message-State: APjAAAUhvd3ac4lrJ3bGWXTLHg7wpr25Vkfq1+i0vHx+XocGU34Jdld5
        zH6vK+5j4PRZL6OIlbTHxKpvb/lgDBPmHEEDSr0=
X-Google-Smtp-Source: APXvYqyj59/2FwT9Ut2/XCRYtxMBre6YtR5ZAGXQ4f5Mn72I7ohDImRlXuXyFvgxuZtHTmb/Km1N5nDjiER2/kggvFE=
X-Received: by 2002:a50:d0cc:: with SMTP id g12mr29735834edf.201.1566303407849;
 Tue, 20 Aug 2019 05:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
 <CAHd-oW5xHv-gC2gQE8_5w6nv8gq5fcLcypqe2bca63HTSaVtAg@mail.gmail.com> <CAL21BmmBBBg+LboTmToem-zitg8UMLaH8eM2Q+ZmEPOMFGcggA@mail.gmail.com>
In-Reply-To: <CAL21BmmBBBg+LboTmToem-zitg8UMLaH8eM2Q+ZmEPOMFGcggA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 20 Aug 2019 14:16:36 +0200
Message-ID: <CAP8UFD2NEM2YWfKr2hz2vs-xBZ0qo96QbdyMDUu7PePm7RnfRw@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Tue, Aug 20, 2019 at 1:28 PM Olga Telezhnaya
<olyatelezhnaya@gmail.com> wrote:
>
> =D0=B2=D1=82, 20 =D0=B0=D0=B2=D0=B3. 2019 =D0=B3. =D0=B2 07:59, Matheus T=
avares Bernardino
> <matheus.bernardino@usp.br>:
> >
> > I just posted the penultimate report on my project:
> > https://matheustavares.gitlab.io/posts/going-for-a-too-big-step This
> > week I=E2=80=99ve been working on a v2 of threaded git-grep w/ parallel
> > inflation, to allow threads when grepping submodules. I also tried
> > some more optimizations along the way.
>
> Thank you for great blog post! You have done so many things, it is impres=
sive.

Yeah, great blog post again!

> I absolutely agree with your plans to structure the job and split it
> to smaller pieces, it should definitely help. Moreover, if you want,
> you can make something like a documentation and delegate some parts.

I also agree with the above. I think it would be really nice for
example if we could have something in Documentation/technical/
describing how multi-threading in `git grep` works and how it could be
improved. (You can of course copy paste from your blog.)

About static function-scope variables I wonder if we could have one
day some .h and .c files with only thread safe functions in them.

> I hope you enjoyed this summer :) Thank you for your readiness to
> continue contributing after GSoC. It is not mandatory, you do not have
> to finish the project, but if you want - all the community will be so
> glad to see you as the contributor.

Thank you for your work and for considering continuing after the GSoC,
Christian.
