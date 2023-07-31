Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E932EC001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 18:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGaSxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjGaSxg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 14:53:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3950116
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 11:53:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so2313851a12.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690829613; x=1691434413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMNsHEUde5ACyMcamkXaDJoehBiqKLxJPSm49rJl1QI=;
        b=B2V+E7gJjdMspe9kyD4bu7RLCpcQeaqkt88+fkwHfmxUSu+UrAVAIixNWeqH066Q/G
         hwn/uTqqC/31ZOCsqlQRFpXw6wprdK9NwlCXfEKjiND0nY4koS34WHJiBVLfNbVRayjp
         kCv9GqfW0Sz9iflekI2sLV4u/pG6/ulO/DYJ8txRDN4OHvDSWytxRu8RFUHBCtoQb2Jk
         Eu+5lSqCml4aIjyuwpcidhJ6ujZTUw2Nb+LgHKjsrTd3P8Ntud4de6+Qm98vTqeP9fon
         lrczdUuPmLUJVi9Q0pSZpPiY8dVwgiSGBpAmgTW7py0zC/4f7kiUfuqa51w6jUxaWN3m
         Jbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690829613; x=1691434413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMNsHEUde5ACyMcamkXaDJoehBiqKLxJPSm49rJl1QI=;
        b=HAmhRFSWR6FlGfLKXUD4e4icJl05h/Vistv/3gDNsTjCmZjamryo7xQCliNQrt8iuX
         pbbjeVIymlYVTtCNC7rOFL8yz43eMmbuEf/cLXxK3TSkoXOPrGsHxlP35zRMxrbBwuxD
         3ACT34Cl+O14P73JJfhCDps4Nk30xAtKNofDdQDHisk8ZxOKG+RqHoZiYvk/9BL7Sz+E
         WOLFoVq14kfJJ121lJ7zqrB/zKgqEWSOw5NoRiHqrYyWAgChwXKMtZxMF13dwd6aNMnG
         i75wuauT+XwkqBiY2Q7NZO1QEYnCt6sLCYF3ZIs8EC8bov7e0S6PgIWF/s72luOlN1e8
         nkKg==
X-Gm-Message-State: ABy/qLbisJZhm+u+FNE4EEUCYLQBw/JHVWO7d9UXXr9fFDK+758Slqdp
        l74Qn7hpkGkuUID886IV/RP5eiLnUrKDJrrhFlFDrRGJYhE=
X-Google-Smtp-Source: APBJJlGyxhRkn9W7iz3BuUci/McFl4EnM18cKBxOIM41bMWPL/fe0QoFnEmU/qj2IdCmbb5x/+F6wozX4wQ2qIHtk8Q=
X-Received: by 2002:a17:906:7789:b0:99b:4ce9:c27e with SMTP id
 s9-20020a170906778900b0099b4ce9c27emr513800ejm.44.1690829612620; Mon, 31 Jul
 2023 11:53:32 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 Jul 2023 20:53:21 +0200
Message-ID: <CAP8UFD19S7i9iu-m_sRsCb_c-mbChWvk23vdWLX+iuUarH5RpA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 101
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Canpolat <eren.canpolat@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Linus Arver <linusa@google.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 101st edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/07/31/edition-101/

Thanks a lot to Eren Canpolat, Bruno Brito, Kristoffer Haugsbakk,
Junio Hamano and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/656
