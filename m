Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09961F453
	for <e@80x24.org>; Mon, 11 Feb 2019 23:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfBKX6x (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:58:53 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40615 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfBKX6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 18:58:52 -0500
Received: by mail-ed1-f46.google.com with SMTP id 10so625863eds.7
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 15:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8lLnUnhMjgiRLu0Igj7p3QhG9P4jM/h0hzCFMTUIlY=;
        b=naCMTRiOO/cWjIWBYiDe/r8rCXa4N/1Lc1F2B29m/uXnbnf6K5BY2DIC310GR7ws/u
         vCUka1GXebsmIKPAisy3ZZsjbC815i7iOtKm6zbwWMl5N4LL/wMsdXDvFynxZvGiGkqH
         l42UueIEQdmm8vA4Ab/C35NrmjXpz+eMEQcU1+A/GmzZK8/LBZCxYSZXs6dUjDoGfYMU
         buBE8LeaMbTEHl4ERx4zJV9llVrKl37KT1CURklw5mfLMM1accSWO1cU3/EktQ/SJOsr
         nl0iDKFURu86zg268wPMEicpVfg0WT+6fA7zFbLarkSC/ZMIWiQQ8q1jelb6XvcCSFwY
         lSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8lLnUnhMjgiRLu0Igj7p3QhG9P4jM/h0hzCFMTUIlY=;
        b=HCyfL4hKQLgfZP1fx+h8iOea27rYr8tXMOeRGqW29udxvZQxi/prMh1SWJRdYHgdHY
         jtGoLfRhhHVVQyPt7l9fRESfhC6E+JmfG2Mbf+PCbaB+CT3QCIht76kZ5LsoYl7n6Vlw
         IJI9u+P3JvAXLhV9hNi5pjRTXQYSqZifysqMhT2K6/RdxheyDVhZoHSnBmXKIEZTorXb
         kcCEIwBlFqnwaD6QL0kph9bnGRcMehGIsx0fBeuaWyTUt6AGTlz4gtqMe64wK5/n6nLj
         7gkH6eC929LWGuDFiiODYx/q/G0+9gP90ougGi+zrH1CZptEMZS0CpwLBiHGJIJ/XceS
         2qCA==
X-Gm-Message-State: AHQUAuaZnOugu3oCgcO17ZWI+4bvECGnXrepIXDvgb7S5p3XfzhrFUvW
        K4z9Id1coJwFnhNH8JL7mrwtoFk2j4F4cY2W+rleN1I1IWU=
X-Google-Smtp-Source: AHgI3IZHc8W3HdMboHEFWY4OL+dQQ8NcaatDH/wW2N2mo8Sn+rabtQqI2E5Edh6Cp7P44Ojb/MGFxuxrobit/LbSW9E=
X-Received: by 2002:a17:906:11c7:: with SMTP id o7mr494871eja.196.1549929530358;
 Mon, 11 Feb 2019 15:58:50 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com> <CAP8UFD1Rv+nFqDYf33rRw-kWnfqokSG6=tG8XPFyBoVCU6Te=w@mail.gmail.com>
 <20190211221827.GG6085@hank.intra.tgummerer.com>
In-Reply-To: <20190211221827.GG6085@hank.intra.tgummerer.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 12 Feb 2019 00:58:38 +0100
Message-ID: <CAP8UFD3s3-mR528FqV3yuMEZBqT0uP+Mp5hGDcN_a1LfAsR0bg@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 11:18 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 02/11, Christian Couder wrote:

> > Historically though we have always been very optimistic in what we
> > thought a student could accomplish in a GSoC. And we are very likely
> > to find more ideas for improvements during the GSoC, in case
> > everything is "finished" before the end. I actually think that it has
> > never happened that a student both "finished" the project before the
> > end, and that no idea for improvement on top of the work was found.
>
> Fair enough.  I think there's still a number of things that could do
> with some refactoring in 'builtin/stash.c', e.g. use more of the
> libgit.a API, instead of using the run_command API, or potentially
> other improvements that could be made.
>
> Another thing that may be useful to do is to write down some actual
> technical documentation on the format of what a stash commit looks
> like.

Yeah, using more of the libgit.a API, instead of the run_command API,
and writing technical documentation on the stash commit format look
like good ideas to me. I think I will add those items to the project
description if you don't mind.

> > So after all if you are willing to co-mentor such a project, I would
> > be ok to co-mentor it with you, and we should add it to the list.
>
> Ok, I'll submit a PR to add it to the list.

Great! I merged your PR.

I also resurrected the "Convert scripts to builtins" idea as I think
there might still be shell scripts that could be converted, like
perhaps git-merge-octopus.sh, git-merge-one-file.sh and
git-merge-resolve.sh.

So I think we should be good regarding Google requirements.

Thanks,
Christian.
