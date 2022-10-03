Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB29C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 13:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJCNlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJCNlo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 09:41:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569043E46
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 06:41:42 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 126so13073366ybw.3
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 06:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=b1qcaRchgrUtrninTF+StwHDkxeedoXMG5LP6IO3u94=;
        b=nYtzXlgHikvjGWpHrI2vlyuVLImOgeAcTA4J24EXN4XlFF6NEOCV+gpEbnKppf3C3D
         8cmeJB3VsyKULh5mjjimwBKoxa72FgB4YGj9JNN2F2OJnaWqtRtT+EJ/GQXkXO3W0o/g
         LzUWCSM2WdUJaqLdpaL45oGXagasg1iaZ/lA8gUxebQ6CikZeevMHWohoOlTa/x98lEY
         8eEuOWftXPqEYIoI1QWDNPIynRe+hBMHGd/60M5BSKcLpmgtdGKOry0ldtKfMzs6Uj+r
         PnxiLdO0QrbYCpgdJWjEbQcHDJpRMbWWLRmTaoiJn/yE9vovLW73OUQUzN7mUO/XZ/6n
         duog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b1qcaRchgrUtrninTF+StwHDkxeedoXMG5LP6IO3u94=;
        b=IoJ3ETeO/V/+WfeHY9kGHMPV8p3jGi3bvpNflP0yJwuufscXDKzoRD6igzkqssZCzD
         aP8akhR162/whD3VU6vkrmmNkEhR8MTsl+SUijYMKd0uuYm91IV3W11gxTTTZ4MpwJk0
         GjBZeXHyjZkP1bdjO0al60l58v3IlMvpnxssf3vgVIDmub02DPeEvyb0Z1JGn7hweHoP
         UZARPMMLzoQu04hatajEO0VCH1Xz21pMrdVboEAb2KlTB58oP4JN0d6Cndn51pCRFoi2
         USXIaQTD+PZv0n0FwESKBhb6NZLbFEJNa+xOrLHvbUbfAz0NFZVB19NyeefGNJTKwj8d
         CEAg==
X-Gm-Message-State: ACrzQf2CCnUfVthK95WpQyU2MTzmNgi/GRAKKKwUI+QAhz+cG6gvRkcr
        HJNOpdVMqECU0y9GO1TFH6soZgZxWX6cnghWkZBFYX4QtA0vSQ==
X-Google-Smtp-Source: AMsMyM5MVTI9KQBTywMLdViQzMmd6O0ChnrmcPNbeamQmPyEonu6wxHarKz9TDxf8W6madRVkTqPhCqNQQZsmdV5p+s=
X-Received: by 2002:a25:dacf:0:b0:6bd:bad1:2885 with SMTP id
 n198-20020a25dacf000000b006bdbad12885mr4474648ybf.120.1664804501896; Mon, 03
 Oct 2022 06:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0_TLWTHpjwxgqAjBLpvBo5BntvpwRLqXrndYosEj7tHw@mail.gmail.com>
In-Reply-To: <CAP8UFD0_TLWTHpjwxgqAjBLpvBo5BntvpwRLqXrndYosEj7tHw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 3 Oct 2022 21:41:30 +0800
Message-ID: <CAOLTT8S+VcbnEehSo7Cinff4aC-LLu6FJ45ny+82a=FFKQVxwg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 91
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        lwn@lwn.net, Glen Choo <chooglen@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Bruno Brito <bruno@git-tower.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tim Hockin <thockin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=
=9C=882=E6=97=A5=E5=91=A8=E6=97=A5 04:45=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi everyone,
>
> The 91st edition of Git Rev News is now published:
>
>   https://git.github.io/rev_news/2022/09/30/edition-91/
>
> Thanks a lot to Peff (Jeff King), Bruno Brito and Luca Milanesio who
> helped this month!
>
> Enjoy,
> Christian, Jakub, Markus and Kaartic.
>
> PS: An issue for the next edition is already opened and contributions
> are welcome:
>
>   https://github.com/git/git.github.io/issues/602

Hi, Christian,

Is there any videos about Git Merge Meeting 2022?

Thanks,
--
ZheNing Hu
