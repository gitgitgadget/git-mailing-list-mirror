Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68F5C433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C86020936
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 17:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbhACRGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 12:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbhACRGy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 12:06:54 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05227C061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 09:06:14 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id e15so13302470vsa.0
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 09:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYzVexKrObNBl/taj8E+gkRtvVSTVOHWtYb4ig7EQWg=;
        b=X2dbJrGWIbxKlL5KxaZVM85w6kxN2q7GGwgYkmepYfAgTvQtcpmtp2d+odVIMyHilA
         f59uhwFnldxIgv/u8jfKB5zMjjPThUQ8npUBSTEAUD+iewEdDbD5OEUDrsnh1yR9y38h
         EmqwxMuNWpkeDebot9uno24ZeH7qK4cGYhBiD0+x89ddXIOq0ArQlAh2/aO1JnLaiIj4
         DSEyPrmys9c4r5WcF48nao8Fq/KJ9bzLmO/Tyvru87Dumy3JfuDOOjznytpgfISXZY/T
         gYCs/SpaEQSye1Y/ZMubbgNpqcSvWIBnKf6K4Dr9Is4HAsE5bfkWw4eN+PQ8fJiIWTsl
         R4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYzVexKrObNBl/taj8E+gkRtvVSTVOHWtYb4ig7EQWg=;
        b=HO8cdtm1BFTbt548GuRimA6iRupp5Pw/DxmWD+r+SNm8vpwAbsJ7xGZOtfZU+lq5t/
         Zpsrr5Fmb4nzk7TXNTe3S0Aw2QdH9l5Vu4xwSvO85U48HQ/C4QJ/6tsyaSvxDrox1QQI
         +fsfUxdI09SnzhWn78BrpSPPaZ4EuiJ7oXpAjLgeeC269/8zdEPem+V1d9dGW5k8Tp/C
         iLtF39i0y3DEC3+c1R2hUPHallw9BmtKJreB6Y89cUX4fmDnN5Kg4m+ACkV2rKwt5Mjr
         Xn0WihgwYHQ64R3b8DgBiypBblJcYW0z2lx4RxiVSpctITrFZL4g8EJWRrw4pNv+3hQe
         DjTA==
X-Gm-Message-State: AOAM531ID6PBo76/GezwY081e3ffyk/cjTaQx9rGDxbZuoBiPkPxlJ9s
        Y8dYJ4MMuyLpsZhnhiM5HRL3FBQNdMqgy5HQasI=
X-Google-Smtp-Source: ABdhPJwmU3ddHaiESYeN5dbfD33ixrJqFtp1u7E5xCZqzzkPlwN4+EN5y6owVCm957gWTEcCA9alb7qT40SAvQXQSJk=
X-Received: by 2002:a67:e28a:: with SMTP id g10mr41465301vsf.58.1609693573150;
 Sun, 03 Jan 2021 09:06:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.831.git.1609609214040.gitgitgadget@gmail.com> <pull.831.v2.git.1609683950823.gitgitgadget@gmail.com>
In-Reply-To: <pull.831.v2.git.1609683950823.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 3 Jan 2021 18:06:02 +0100
Message-ID: <CAN0heSrxMTEzt+vCaRYAe6YeORhQb5+eBa0S=6q7Wctd__EtoA@mail.gmail.com>
Subject: Re: [PATCH v2] doc: fix some typos
To:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 3 Jan 2021 at 15:25, Thomas Ackermann via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Thomas Ackermann <th.acker@arcor.de>
>
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>     doc: fix some typos
>
>     Changed since v1:
>
>      * Removed changes in non-doc file contrib/buildsystems/CMakeLists.txt
>        from the patch. Thanks to Martin and Felipe for pointing this out.

This looks good to me.

Martin
