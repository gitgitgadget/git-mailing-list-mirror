Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5060E1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 22:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfHTWlr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 18:41:47 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:44602 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTWlr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 18:41:47 -0400
Received: by mail-io1-f49.google.com with SMTP id j4so627925iop.11
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AaQYNA1tnQPZ8/zQ1D64Cf/gvgDhUuNsAbTIp+8pDjc=;
        b=opFBN2ZT6v/hBBRgSJFnHPw3YqeZXmUiV1wJmw5yn5v0NDXCdhjCB+Yd/rkws4rlrw
         gcU6GghmmshyoonXRs7gaOOpshW6FMjJwFErtN1LnHGKHdhrwzMY/lg4ttOzoFHE8nnJ
         bV52QtmMCp1SEJMo8XP5AowNQIoqm7+mNUheCDOSHGZDluWZP4sYiWEb8gJZsfdqMPdv
         2j1XDywQuaBxpNoCIfOWBvxxthFXfv0vAtTf/HemAq0ZvbTw9Bba2pk509/i98GNAxXS
         2D5HPMcKqcc7pEes25VVm5GCNkJ038eX7gn5czwTABgdUAwltq6YmDuSj+tnqD9Crd8g
         l3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AaQYNA1tnQPZ8/zQ1D64Cf/gvgDhUuNsAbTIp+8pDjc=;
        b=rU9ujADxzoBekBFUbF/oA9mX47ul6q8OD4YUHr0QSWsmUXp1F/agXUX15Q/GBuNBCY
         M6Fo9VesQEQXQNFlEQFLXyMEaacrk31dLLrrDnFIqNu61GHYZVHDm63zt+cAvQKwTYqw
         3i7b1876wcB9egnGBYEPlIvg+aO80Z9HACm8Ud5VTesnXTYjnSUatjDGL2OqVKUhg1eg
         7b8XYVn6pALJO5aRf9KltkDud/0ZzFCEYdl1cShGdgNvWHthBxhS6nWRKEA+nS07/MFq
         YaaUN3wsMKvYG31GFYPhj4wORjrNRjMQv+HF76VMlDjcfDcWWbomItOYhW6ppuMVkXqf
         FR7Q==
X-Gm-Message-State: APjAAAUMlWFT6RBXdeO5e7LB5pBzq4lA+oAylu0rhaPpWMR7pJTGnids
        r4JBSOds6ucCXlJ/i2F4wCWylLHFQWb+tf0Qf9bNeQ==
X-Google-Smtp-Source: APXvYqwTsKqupZQI/7aNUE5qFLSlSBqN7mvXEZTY34BQK1P6/xHTIu7ysipJV0wQNzBi5hCAx0myBn6tIPDufcCTTqs=
X-Received: by 2002:a6b:b2d6:: with SMTP id b205mr3962846iof.86.1566340906140;
 Tue, 20 Aug 2019 15:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
 <CAHd-oW5xHv-gC2gQE8_5w6nv8gq5fcLcypqe2bca63HTSaVtAg@mail.gmail.com>
 <CAL21BmmBBBg+LboTmToem-zitg8UMLaH8eM2Q+ZmEPOMFGcggA@mail.gmail.com> <CAP8UFD2NEM2YWfKr2hz2vs-xBZ0qo96QbdyMDUu7PePm7RnfRw@mail.gmail.com>
In-Reply-To: <CAP8UFD2NEM2YWfKr2hz2vs-xBZ0qo96QbdyMDUu7PePm7RnfRw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 20 Aug 2019 19:41:34 -0300
Message-ID: <CAHd-oW6j1-XuPA8XcwmBKhuAeGMEB23NMd1h1KDmn_Z+VJpu1w@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     Christian Couder <christian.couder@gmail.com>
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

On Tue, Aug 20, 2019 at 9:16 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Matheus,
>
> On Tue, Aug 20, 2019 at 1:28 PM Olga Telezhnaya
> <olyatelezhnaya@gmail.com> wrote:
> >
> > =D0=B2=D1=82, 20 =D0=B0=D0=B2=D0=B3. 2019 =D0=B3. =D0=B2 07:59, Matheus=
 Tavares Bernardino
> > <matheus.bernardino@usp.br>:
> > >
> > > I just posted the penultimate report on my project:
> > > https://matheustavares.gitlab.io/posts/going-for-a-too-big-step This
> > > week I=E2=80=99ve been working on a v2 of threaded git-grep w/ parall=
el
> > > inflation, to allow threads when grepping submodules. I also tried
> > > some more optimizations along the way.
> >
> > Thank you for great blog post! You have done so many things, it is impr=
essive.
>
> Yeah, great blog post again!

Thank you both for the always encouraging comments :)

> > I absolutely agree with your plans to structure the job and split it
> > to smaller pieces, it should definitely help. Moreover, if you want,
> > you can make something like a documentation and delegate some parts.
>
> I also agree with the above. I think it would be really nice for
> example if we could have something in Documentation/technical/
> describing how multi-threading in `git grep` works and how it could be
> improved. (You can of course copy paste from your blog.)

Hm, good idea! I would have to revisit the important points and better
formulate them, but that could hopefully help in future optimizations
to git-grep.

> About static function-scope variables I wonder if we could have one
> day some .h and .c files with only thread safe functions in them.

Yes, that would probably require quite some work but would definitely
be very helpful!

> > I hope you enjoyed this summer :) Thank you for your readiness to
> > continue contributing after GSoC. It is not mandatory, you do not have
> > to finish the project, but if you want - all the community will be so
> > glad to see you as the contributor.
>
> Thank you for your work and for considering continuing after the GSoC,

Thank you both, again. It's been a great summer of code! (although
it's winter here haha) I do hope to finish the project and keep
contributing with whatever I can :)

Best,
Matheus
