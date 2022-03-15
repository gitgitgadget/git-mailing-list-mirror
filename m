Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FF2C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 11:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiCOLEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347789AbiCOLEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 07:04:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDED3B3
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 04:02:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b28so20586649lfc.4
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 04:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o09+jaLrAA83Pkx6ige6DKgsz7SIre5lAgU+tMWCzg8=;
        b=LBfWdd90sMJloa7UbSZYbRf35Kg5xbPC7eVzqPcFhr+Z2ZiPB4sY3+XFxeDJ6ZnsHv
         9EpNoitv5s/vNi5s0PT2/UqByNamvLrEkPMI+Yut1FTA0UOx+8Mz1bIxEmEtt37zkgWA
         IPn+zDhqnwSXFML2wpJfpWcVxnX3R0TxUcD8QYHaEZaDx+RRIduwIPfdcDnSAvjshRfQ
         5E3VHuWrYPhEgwawS2zoVuIXJ19Zy/sVIsa6Xw6OE1ezDUe4gbm1xAqUOhHFVPK+23ad
         2zT2/t1CFDZ/xR8EHiK3vEW7aUYg+Sa6ZRf/3xzWQuRivvUx6YsGkvxd4X+RDcglH7Zw
         ci/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o09+jaLrAA83Pkx6ige6DKgsz7SIre5lAgU+tMWCzg8=;
        b=M/bpNqq3eTBVKL9UYO1Z/Qngmr52EUyka4+UD89Z4A5sDHORyBSuPLKynDSXpW5n+0
         0nBrRij1uEKcGGXQ415eChkunPHp70v4pOjzdYPt50RhpJ5BshPKp249tm1+LYC+w2Ay
         Lcs34YwuLjb4X60I4WPCaprV4aCaT6XcODT96UcQPgWwNlDvaJsQku0SU4azbMj2yxbS
         vZDG3vuY/jsG9CR2QhLbghVMs/RmMv9uO2o/3ZON2zCRvXdoXkFK9Ui5NxpmgKu4Bmq8
         qZ6D4/MGGUhe3fGmKCRfwTb++3BMkFsmhOxRd0tkoHSclt1BoZhWVSWfp/R7lF5r606V
         HJPQ==
X-Gm-Message-State: AOAM533BGsxRZq96gGItMc2P65PKxefHiJBZLFFfBIeM0F9Lp5BXeSVc
        4ehUJ+lzMGuzlvvNe30mWju7SOJqPy5N0ed2EkUZoA==
X-Google-Smtp-Source: ABdhPJw2zsryQvcreTbFHPuev/x4Z9vE2d395MKbdw4RhfRIUQgkdvcNG+/AlhuO5v2HKtiQkrnLUunhZQNnuZ2L29M=
X-Received: by 2002:a05:6512:3e14:b0:448:7d8e:aba with SMTP id
 i20-20020a0565123e1400b004487d8e0abamr10310952lfv.532.1647342172080; Tue, 15
 Mar 2022 04:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5yogp6xo.fsf@gitster.g>
In-Reply-To: <xmqq5yogp6xo.fsf@gitster.g>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Tue, 15 Mar 2022 11:02:35 +0000
Message-ID: <CAFLLRpLiCLiXkHNe2u4TKk-FjDy4LVZZR4qqxG+MamZYEFNUGg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2022, #03; Mon, 14)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 14 Mar 2022 at 21:20, Junio C Hamano <gitster@pobox.com> wrote:
>
> * rc/fetch-refetch (2022-03-04) 7 commits
...
>  "git fetch --refetch" learned to fetch everything without telling
>  the other side what we already have, which is useful when you
>  cannot trust what you have in the local object store.
>
>  Waiting for discussion to settle.
>  cf. <20220309002729.3581315-1-calvinwan@google.com>
>  source: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>

I am planning a re-roll for the boolean cli option, and I'll add some
more documentation as I proposed after Calvin's review.

It would be ace if Jonathan Tan can give it another once-over too,
though the key aspects of the implementation haven't changed since his
review of v1.

Thanks,
Rob :)
