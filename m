Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01A1C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 15:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiBPPkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:40:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiBPPkR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 10:40:17 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B730B28F97F
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:40:04 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id j17so1103449vkd.12
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdbOHaHMLooD/aIC6TvgsjyzyqxfS38KCAX64e9n3FM=;
        b=Qo1oP2BjTntGKnyhfHdHmnA61QOdpqd0LmbnhmFmPnB+KSWprCYZNHCaLMaWmItKTo
         fTVWJ8uvR8QVIcZHsFubHjt5+tvWYgRUm8Hd8U4HMisqphjOmHM+XYXw8b6EcSEZfYAh
         KTUMkFFHz9lqt3Ed/mgpKdn9ZaMMSo9hkwraWL7aZg2RymnHTlcpIw0Vmc2xsPG1NS6C
         IbGpzwxtsDt3aKvvSrmEbuMXYfWSwCMN7/szQmiQJsX9gGEQ7JJSK2W9sbqRtpMVwbaN
         li1i2EexQSzMcc2TIW3M/VoBMGjIuxPSusO51G3HUc/CmDIJpXWqfVJZN3v5x08TNS0G
         DB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdbOHaHMLooD/aIC6TvgsjyzyqxfS38KCAX64e9n3FM=;
        b=gw0udOJVU6LM/rCeEq7KypgK36TTXegW2o2hBM7N5HgkEn4mmMGXWsrZdeVUFVgRrd
         aC1PuK61qmY/tg5ZsVu7B6T9KeENxCZxzasAvPAz8DypnCf53vR2veXi34h+E2xPx9VL
         66oYLq2/AEZiXC/t3UiPzay/Ib84Q06F0yGTKEApBwyJneCcMKXlt6yg9Jyupx5v8pty
         tqBcOv0Yc0xm5Qv1BGRVB96I/lzShYjjT2Ih4yNGG1hxyxjP7bvjvvSJ2pdnS+UDOrjl
         iBgv8JQyrZYJXMmePzM5dq10ZTd8oJQmXCyXx4eF1peft8sw7fbKoShp+gK1gaB+MAAK
         4+Iw==
X-Gm-Message-State: AOAM530aDS6PhXOCozj31oS45N4pGD7FN7nnv7Opg8x1mORmyfUHIBGe
        SJon0v8JMu4PHNDFfDOP4uTa41Ya+Iz9+gqMXxtsqN+QokHfbp9e
X-Google-Smtp-Source: ABdhPJwI/stXI7S73TW5GM/89iViBqZ1TFLkLxNF5AgYNZjGW4f/xEChXx1pGzWrhHO+Zzt+sZghFcEA+FcQnoMc9pQ=
X-Received: by 2002:a05:6122:90b:b0:321:1905:7121 with SMTP id
 j11-20020a056122090b00b0032119057121mr1260450vka.5.1645026003793; Wed, 16 Feb
 2022 07:40:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com> <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
In-Reply-To: <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Wed, 16 Feb 2022 15:39:47 +0000
Message-ID: <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

On Wed, 9 Feb 2022 at 02:41, John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This patch series makes partial clone more useful by making it possible to
> run repack to remove objects from a repository (replacing it with promisor
> objects). This is useful when we want to offload large blobs from a git
> server onto another git server, or even use an http server through a remote
> helper.
>
> In [A], a --refilter option on fetch and fetch-pack is being discussed where
> either a less restrictive or more restrictive filter can be used. In the
> more restrictive case, the objects that already exist will not be deleted.
> But, one can imagine that users might want the ability to delete objects
> when they apply a more restrictive filter in order to save space, and this
> patch series would also allow that.

This all makes sense to me, and the implementation is remarkably short -
gluing together capabilities that are already there, and writing tests.

*But*, running `repack --filter` drops objects from the object db.
That seems like
a capability Git shouldn't idly expose without people understanding the
consequences - mostly that they really have another copy elsewhere or they
will lose data, and it won't necessarily be obvious for a long time. Otherwise
it is a footgun.

I don't know whether that is just around naming (--delete-filter /
--drop-filter /
--expire-filter ?), and/or making the documentation very explicit that
this isn't so
much "omitting certain objects from a packfile" as irretrievably
deleting objects.

Rob :)
