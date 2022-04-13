Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DC5C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 03:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiDMDNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 23:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiDMDMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 23:12:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6235524F09
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 20:10:23 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id e10so462068qka.6
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 20:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ExW216xp9vV1ZNaWtLTzFJu5rGcPB4XR7OOds4Gqxaw=;
        b=pLIvQR+6UodGLb5jZFsacwRP3Nj7vCi1v1W7wPXFGti5qRPURtntGkArsoaLf/BXF0
         rod5Vuk5Bc5RWxq4mFam8YyNg+Gb1Px0bq1lzl1PSOxpDTYTQZwEhBKtLn5qW9OdmbDW
         7s6ju7deG0bl7PpjxJ0cA+gsh1elKL+phIupqtRo3mbgmJCclfH9+4P3EbQJQghWD0N0
         MMdEfMd0ztV5v9x/nWIaNJgTgJHA+GquCf4mWX9KPZqjdNPyxID3FfLV42K1YeSNFNjc
         glo/xQIqF45ViRSIDCfABLlE+aWCnQFVmkeHxIXmY9f+jNE6n6iSvzXImT/QEgELVQz9
         LZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ExW216xp9vV1ZNaWtLTzFJu5rGcPB4XR7OOds4Gqxaw=;
        b=kKypT3BYjenXOYF3fLpBgdXNB2rRknWnbzPmaWjrPDZMXqmFEtXCrRHspbD/cs5z8X
         qmRkWjjIdotctYt+Nbg4g4Uhxpdl7KTGHg454IO8w4gSpgPzBxjx7FJNn4iyeIQyK801
         46dv4sRvuSlLe8jeKBX+6MiEzUQXaw+9nhOWfJ+Ccm72w8S1LUhO22DrypFHbMtkuvUT
         kdIgz/bqiW6yaZmWsdmeiqaxqfytsgAfQVTChhb6uyUMaR58jgKcOrMaQ5xsLyhIeeel
         bp6BYM20J/GtfkkR+gsTcGUxUF9YL2oWZcxEGP//MkFOhLROR7HjpErxTao1nOucwcyB
         qb0w==
X-Gm-Message-State: AOAM530Wj0D43VKVdM7YnhiZ51sSAiX4HmBmFJmjxnzDdI7cJRrRBRSb
        NHeFp8eEyA7aSLCG6s8d3BssdFkA5/LCdebqI8w=
X-Google-Smtp-Source: ABdhPJwVGq7s1GNEUKetze9B5muvc78omY4OGslqhOzmqDbnv8/oMW5UoK34vkh0iyqjboEtgVn4TM8uzdYqWWJxWMA=
X-Received: by 2002:a05:620a:3196:b0:69c:188c:a702 with SMTP id
 bi22-20020a05620a319600b0069c188ca702mr5347796qkb.702.1649819422568; Tue, 12
 Apr 2022 20:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rsab5do.fsf@gitster.g> <8698e468-5552-77a3-10c7-933affd98832@gmail.com>
 <220412.86h76yglfe.gmgdl@evledraar.gmail.com>
In-Reply-To: <220412.86h76yglfe.gmgdl@evledraar.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 13 Apr 2022 05:10:11 +0200
Message-ID: <CANgJU+XU_j2Ge-c34qqKMZRjM5k4OBYMiJa4t7WJcPsdABWHiQ@mail.gmail.com>
Subject: Re: CVE-2022-24765 and core.sharedRepository (was: What's cooking in
 git.git (Apr 2022, #03; Tue, 12))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 12 Apr 2022 at 21:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
>
> On Tue, Apr 12 2022, Philippe Blain wrote:
>
> [A change of $subject seems in order]
>
> > Le 2022-04-12 =C3=A0 13:04, Junio C Hamano a =C3=A9crit :
> >>
> >>
> >> Security releases for the 2.30-2.35 maintenance tracks have been
> >> tagged to address CVE-2022-24765, which allows a user to trick other
> >> users into running a command of their choice easily on multi-user
> >> machines with a shared "mob" directory.  The fix has been also
> >> merged to Git 2.36-rc2 and to all integration branches.
> >>
> >
> > This is quite a big behaviour change for some environments [1], so I wo=
uld think maybe it
> > deserves to be fully spelled out in the release notes for 2.36.0,
> > instead of just referring readers to the release notes for the maintena=
nce
> > release, where they can read a full description only in the release not=
es
> > for 2.30.3 ?
>
> Yes, I think it deserves to be noted very prominently, and also that we
> had some mechanism for publishing relevant git-security@ discussions
> (possibly with some parts redacted) after the issues become public.
>
> Non knowing if others involved are OK with being quoted I'll just say
> that this issue was discussed at some length on the list, in particular
> that it'll severely hinder some core.sharedRepository workflows.
>
> Quoting (part of) my own reply from one of those exchanges (this is in
> reply to Johannes Schindelin):
>
>         But I don't understand why we need to immediately die() when we d=
etect
>         this situation in setup.c.

Would I be right in thinking this explains new breakage we are seeing
in CI jobs we (the Perl project) have hosted on GitHub:

https://github.com/Perl/perl5/runs/6000831257?check_suite_focus=3Dtrue#step=
:5:1

Run git remote set-url origin "***github.com/$GITHUB_REPOSITORY"
fatal: unsafe repository ('/__w/perl5/perl5' is owned by someone else)
To add an exception for this directory, call:

git config --global --add safe.directory /__w/perl5/perl5
Process completed with exit code 128.

Cheers,
Yves
