Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA339C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 23:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiEBXLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 19:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiEBXLf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 19:11:35 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C82ED65
        for <git@vger.kernel.org>; Mon,  2 May 2022 16:08:05 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id ay15so3375862uab.9
        for <git@vger.kernel.org>; Mon, 02 May 2022 16:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cX89tGhnywbkLFdbGAJSePjilzzsxv6u+gRf8BbwYMk=;
        b=KILn4E/NZivOrasPFtWzDq8gk39tlCg0djuer5KHOyJ/keJAIKTFK5GsiBmEFY6tpZ
         3p8ABV+4nJZGHRT/KxG3cpjguJiHsDrE0x65vXX93qjBEZQXWRmarxuMz5+/T+KGTW6N
         0cfrpDCbeTwu3StQYuSAUlEALYE3WY8Kn6fJ88TxXNYHQTyy1+8eadAZJC3Q+TVIqMZO
         Bxa96Lk4HIczxj8L6X02EzIR0DZTYfMoCh3eUchwo0GfSR/xbp2bxCs9MgFNeXIZKCr3
         9ULCpGthrbYEAKzmzxDuvbk2uRqhv2h+yvP/pigUg6uQ1A95qu9P87RQOT3VILWmKsvP
         ZF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cX89tGhnywbkLFdbGAJSePjilzzsxv6u+gRf8BbwYMk=;
        b=Vt8ostntcfEtx9WsVp3OHDeJbt9Yanl+PezveOhoVfpIoJ4pXauglv2fWaXPwyZVdn
         m1BWylhpJmehakF3pPeeSCVklehIMs5BIF1slEsAmzy82XSt4X1RjsVacFY+F0kbFjtX
         399F9RYfS4bxIWrM5wkhopVKz+p+UKnGGJCEGRv5RrmP56VERm1dcfANioyO0TuLtOds
         5bP5gkaToy9+7l4RP7sdRyo/tybAcgBAgk0URty0AYKTYMVGL0w1YF3++gAzWxP4HfJQ
         PRQ48cP1l08k16EoQu8Bf9xQTXvjMQPm2ccgvHIqXaKRpg7l/NkD16flG30SdtiYj/Jw
         d4yQ==
X-Gm-Message-State: AOAM533FXCKiraA65HBkxZFSQ5Ta8WoRWOiacVm2/y1SWggkbYULRWTR
        GBSRjI4aJFXS/IdP0AEp5LWPRlo4g3tvS6rwDN0=
X-Google-Smtp-Source: ABdhPJxBp9OkKHlXkVyBBOC51Ga4jfrKMkS9EkUsZB3iiI7NYPbR1a7ej2O7P4ewDMfyedlNVgo5plD3D34ACTI6oJ0=
X-Received: by 2002:a9f:3084:0:b0:360:1fa1:6aca with SMTP id
 j4-20020a9f3084000000b003601fa16acamr3716867uab.57.1651532884152; Mon, 02 May
 2022 16:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220502183920.88982-1-carenas@gmail.com>
 <20220502183920.88982-2-carenas@gmail.com> <xmqqy1zjwrbu.fsf@gitster.g>
In-Reply-To: <xmqqy1zjwrbu.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 2 May 2022 16:07:53 -0700
Message-ID: <CAPUEspj9YPFttgf+W604PAUuabDCSOOaOdik9Z+cPbQRDk7e2g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 2, 2022 at 2:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > +     command -v git >u &&
> > +     sudo command -v git >r &&
> > +     test_cmp u r
>
> While this is not as thorough as the "make sure we see the
> environment intact" that I alluded to during the previous review, it
> at least makes sure PATH (which our test framework tweaks) is
> propagated down to "sudo" environment intact, which should be good
> enough to run just "init" and "status".  Keeping things simple is
> good.

Sorry, I should have mentioned that explicitly in my response.

That is not possible.  sudo by design will try to minimize the
environment that root is running on, so the only way to make sure git
still works as expected there, is to add to that environment
everything else we might need.

That is why I have to invent that ugly looking "env" file and the
function to import variables with it, and I was assuming that for it
to be useful in the end we might need to maybe import everything
"GIT*" too, but obviously I didn't want to do that now, and that is
why I only did the branch name (more as an example, than as something
that was strictly needed) since you mentioned that in your review and
I could see how it was related to `git init` being added to the tests
in the next commit.

Guess I botched it in my refactoring anyway, since it also makes sense
for it to be added in the next commit together with `git init`instead
of here.

> may have to exclude this from tests that require specialized
> environment like valgrind tests, but that is not of immediate
> concern.

I didn't test valgrind, but I would assume it is probably broken now,
as well as anything else that relies on extra environmental things.

Carlo
