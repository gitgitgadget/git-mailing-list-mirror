Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3277C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 01:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7236611EE
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 01:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhKDBaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 21:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhKDBaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 21:30:20 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50336C061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 18:27:43 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t127so10699467ybf.13
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 18:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c44BmN8oo64wOLUdLmooq5TeSJLZf+y4Y0mLuyhFVSs=;
        b=EIOGM/mQ9pgdDbxGWykwYt03g3gmKNBs3MorDHLmJxaSzGIQre5YztiYEIxFb+mh/7
         AfkoT6rgimcfxfJ12EHXRJ7+H/CyOGkzXB3aPo1zsQf8pCqSAMI8MNuVfKVt4O+kxnhq
         cY511odQj6cAHJP6pYjo3cYL5GLS6KOgbCpZgYc8ruiawJyyZJNYV6icMF/qWhj47Z5p
         +LyAyO3OZbvjhjKWNYN6zLIQULASBDbTRZgJM71HgRvcYjDmRi/yQTA4yDR6JTgpolrS
         PaKF7/bI9YU5jwYgLmI5Qy4ZWlUGgyASDqoO7jWQTZAwwGlDCsY3ktazywGdsbJ9xTSj
         tWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c44BmN8oo64wOLUdLmooq5TeSJLZf+y4Y0mLuyhFVSs=;
        b=PdttI/0kdsuHct2S4LLkaU9nTyqyksQy39PWPjJ+dgaNUsI+miQQWa6AiNoLrlxA+w
         naEmbE9QveVsuMFwU3XVmwB5sHkh0DixpqdkNCJm1JLiwZwD4NpoYKngn9oeny2DXjqn
         XKPt2UyAQqFGPlisK1BHN5EAfm1992v7OCXI7MPgsKjcudN6vKD28Z9Wso6eYxqK6Thv
         Ip3o3ccSjas+GAnJsZJd4jpwGgb0gVBeqcLAVT5NQ00IRXn21xEON+iMO06Bo9/bWW5h
         lexqb7j7xW7m8w7wxBhXXqQhEXWBUBebkc4H7AukZhiLmg74mnL0nXG4zVWb8zygFRWK
         zpAw==
X-Gm-Message-State: AOAM531g09YTaBsDcniiQBN+7loH3sqK1tHR/llz63q7mpgyAeZyYb9V
        41X4smJ8P3x8YLCqV8kH7iGzqhTeVd+EDWFQiT8=
X-Google-Smtp-Source: ABdhPJz6BYE2jnOennfXH504iAyp60HBu/8ch1clMHHopmJY7ySSIo3OAdDofDsbSnhbH4kryrT6qAt3yu2pLZLRd6Y=
X-Received: by 2002:a25:d6d4:: with SMTP id n203mr51832193ybg.80.1635989262466;
 Wed, 03 Nov 2021 18:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211031052156.5237-1-worldhello.net@gmail.com>
 <20211101021417.9549-1-worldhello.net@gmail.com> <7d9a893e-5dad-bd21-4ef7-6d47303abdc1@gmail.com>
 <xmqqpmrh8atl.fsf@gitster.g>
In-Reply-To: <xmqqpmrh8atl.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 4 Nov 2021 09:27:31 +0800
Message-ID: <CANYiYbE9=HZk2wD0u4uPGT9Mv2nZZis-s31fvG0QzhM7HmRisg@mail.gmail.com>
Subject: Re: [PATCH v2] i18n: fix typos found during l10n for git 2.34.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Fabian Stelzer <fs@gigacodes.de>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 4, 2021 at 12:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>
> >> diff --git a/ref-filter.c b/ref-filter.c
> >> index 282cdad103..08a3f839c9 100644
> >> --- a/ref-filter.c
> >> +++ b/ref-filter.c
> >> @@ -1037,7 +1037,7 @@ int verify_ref_format(struct ref_format *format)
> >>                   format->quote_style == QUOTE_TCL) &&
> >>                   used_atom[at].atom_type == ATOM_RAW &&
> >>                   used_atom[at].u.raw_data.option == RAW_BARE)
> >> -                    die(_("--format=%.*s cannot be used with"
> >> +                    die(_("--format=%.*s cannot be used with "
> >>                            "--python, --shell, --tcl"), (int)(ep - sp - 2), sp + 2);
> >>              cp = ep + 1;
> >>
> >
> > Why not using \n?
>
> It is not quite clear to me why it should.
>
> Among the possible string that is (ep - sp - 2) bytes long (i.e.
> --python, --shell, --tcl, --raw), even with the longest, the
> resulting message would become
>
>     fatal: --format=--python cannot be used with
>     --python, --shell, --tcl.
>
> that is unusually short with such a newline in the middle.

In order to detect typos in new i18n messages added upstream in time,
a new CI workflow has been added in the "pot/CI" branch. See:

    https://github.com/git-l10n/git-po/blob/pot/CI/.github/workflows/git-pot.yml

This workflow will be triggered several times a day, and changes of
i18n messages will be saved as "YYYY-mm-dd.diff" in the following
branches:

* https://github.com/git-l10n/git-po/tree/pot/master
* https://github.com/git-l10n/git-po/tree/pot/next
* https://github.com/git-l10n/git-po/tree/pot/seen

L10n contributors can also refer to the "po/git.pot" file in the
"pot/master" branch to prepare translations in advance.

--
Jiang Xin
