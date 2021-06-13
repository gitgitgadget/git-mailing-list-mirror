Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C514CC48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889DA610C8
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 10:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhFMKPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 06:15:09 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:41977 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhFMKPI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 06:15:08 -0400
Received: by mail-il1-f181.google.com with SMTP id t6so9621569iln.8
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MNfyEFX51ZcrRM84mS8BAdX+sGQZFOOudz3zZIb1lqc=;
        b=QfsJ4c16O+yjmoKDQ2h69r1LWDll752zZyKpNxsyxHz4KKo9Ueh2rm1qmDnrvH9AkL
         DXscIM5rzg2mGwu+iCangq92MdTW4fHzRu0j7pBz64ZkNfhjTMvvKgP18g4T7a6YrMju
         X+YeBr6HdoCm01oUa8KAI0meycCk4kWdQC5xVamA6MvKkdkOE/5YHB/7BPY14ejfOumF
         nBXXrDYDjaN54YqOakR52BzyXweT5DafV4qxPh49vq/5iipfz4Och185/RHSslp1mQsd
         UOiEp9Fy1+40Rlj8jMbnmtyf4Mm2skgkXpblGACdazX/WAzXtMUoB2yePM7dlSBO7k0H
         1s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MNfyEFX51ZcrRM84mS8BAdX+sGQZFOOudz3zZIb1lqc=;
        b=Ovo8mjhZsmX2VKgBx4aATxwLASmY+/Ni4A/8IxEgL2zOfCqJ/Vh2oJbHZL7wU5nmjU
         NgS4tBN9t1W975V+rNRaFUgljuCzVeN2lG6rirKPJDMP8jbztTlCnXc54m669BDpYZmz
         DcD76stNZTJ4k5ZAhHyEfqLUIgWBjpUSdmEGYbukyqFinhmiURsL9OWn7Ij8R2t9P5GY
         eaED18a/59Y6IhZphfIifA+zTpQqlqZNJ2KCOh31JHj0JsGUMcmKHn23xE2IhujPe/5t
         S+JrlwhZo6/7vGYOKM16RcMnFnQzD1/0hrCItKHJ4G1SyUGiD6/cTvFyGJST2kzF9KC9
         QQRw==
X-Gm-Message-State: AOAM531ERbejmULwcKRiLS5Z06bQ/Zdl+UpdhVlX+M6Iu9d5PSFL+vJE
        crYrUYHsj69zQ7H6vxNQj21uuVs51jrawktL4m8=
X-Google-Smtp-Source: ABdhPJwy7oXk6rTYuBM17IjWxnnQdF9MpSpsN8ErJWgHDr6z+D2MGCcAlbrXnPhBaM5P9VHCLLUj56gw5tOxuaXrZK0=
X-Received: by 2002:a05:6e02:1486:: with SMTP id n6mr9897030ilk.174.1623579106986;
 Sun, 13 Jun 2021 03:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <c208b8a45d66556a3f905063bc7c5026ac4f1e82.1623496458.git.gitgitgadget@gmail.com>
 <CAP8UFD0zVLF4ZKorv-8TaEh16-5K1e-=tFafGknucQGU14ZYGg@mail.gmail.com>
In-Reply-To: <CAP8UFD0zVLF4ZKorv-8TaEh16-5K1e-=tFafGknucQGU14ZYGg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 13 Jun 2021 18:11:36 +0800
Message-ID: <CAOLTT8QJh==+ji3dvb4VpTKfuWp5CC9fbNSdWTvux7gk0-Hvhw@mail.gmail.com>
Subject: Re: [PATCH 5/8] [GSOC] ref-filter: teach get_object() return useful value
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=8813=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=884:09=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Sat, Jun 12, 2021 at 1:14 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Let `populate_value()`, `get_ref_atom_value()` and
> > `format_ref_array_item()` get the return value of `get_value()`
> > correctly. This can help us later let `cat-file --batch` get the
> > correct error message and return value of `get_value()`.
>
> Is it get_object() or get_value()?

Oh, it's get_object().

Thanks for pointing out:)
--
ZheNing Hu
