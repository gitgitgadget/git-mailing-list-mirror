Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B82C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 04:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B3F64DE0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 04:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhBQEO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 23:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhBQENE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 23:13:04 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B1FC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 20:12:21 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d7so10954625otq.6
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 20:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D/ARwm/xczHOmOuxzobm7Fk5zsmI657OdhUseAS3puE=;
        b=Xwn0kJhp+BFmu/jUNHtCPiTBeRcyzUgiu2fyG27x7s69h8bCBikeu7PFcKBZv2NvCk
         M3asOOHCMhrFpRutBtrv79Bdtbfdcx7GZab6ok6ZpC/e2lXnW8klKach22eoYK0yg5of
         8uOFF7PksZLQuA6opTK/ws3X4Wl8iMVu/LYV3np59mfP8RZEH1U40fY8lT1pvtaWTz/C
         RXRY3il0wFHLwgSVYjd6KzfpPCkaFxlaZiRrXFO4+YFFtevbXMT/jAp5xBHsQrIOjpfV
         FlpX24LNJKMPwS3TkGj/evSDOjj/+2Mkuv3ww1oMHMaKcJg3lBUjS96OIE8JyEYg4i5G
         5C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D/ARwm/xczHOmOuxzobm7Fk5zsmI657OdhUseAS3puE=;
        b=ClCCxdxYZ+c4QkWdIdo55hXMvP91g78a24V2kGMrcmBseHG9dU9+PnZIlOWIqgglSb
         6DKwYsE5JTFdo/YMqCIDfxPPE/U00+6m2JA/hGGBXwCIQDxxes7qsAApKi1m/kbsvlzF
         eJjAY9LU50dY62tC25iLuE9mT0wtFvTkri6P8IFvchFktdD3B5IFqDq3YHmgPUXV+ah2
         DHxIDPzoTyOWb87dBLeD3VYWqmqWG9/GT3kRM1NgrETP8mEE3tmj08iapwMprURcNFCs
         xSm8/1stq6E0q19AEqCsXIs7i11vNI1jHm/L2UR0hP9QNkqRl43dnFfKSahUasl1MznI
         uKDw==
X-Gm-Message-State: AOAM532kWY9zjpuCuF+/pKMy0sqoXoOMrs9ESjMh8wmCLLfJQeOyOka/
        +dSIKjp8zIUiZm+G7elJUtKj8VO9jNXowJmWTmY=
X-Google-Smtp-Source: ABdhPJwUz5EgVQREpGURrhpd4jGoCVknhP87NR/CdhU0+WcsyQOxVweKvyEWiT/Llu30oJPzQ+MQ+hCFr0fJmWQibo0=
X-Received: by 2002:a9d:3ec:: with SMTP id f99mr16937227otf.299.1613535140989;
 Tue, 16 Feb 2021 20:12:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
 <pull.870.v5.git.1613480198.gitgitgadget@gmail.com> <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 17 Feb 2021 12:12:10 +0800
Message-ID: <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh, I am sorry.
Then I only need to squash the two commit, right?

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:45=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Junio C Hamano (1):
> >   diff: --{rotate,skip}-to=3D<path>
>
> That's not part of your series (didn't I ask you not to include it)?
>
> > ZheNing Hu (1):
> >   difftool.c: learn a new way start at specified file
>
> Will see what I find, but I may not be able to get to it today.
>
> Thanks.
