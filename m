Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707E4C433DB
	for <git@archiver.kernel.org>; Sat, 26 Dec 2020 22:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EDA2054F
	for <git@archiver.kernel.org>; Sat, 26 Dec 2020 22:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgLZWFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Dec 2020 17:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLZWFB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Dec 2020 17:05:01 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B14AC061757
        for <git@vger.kernel.org>; Sat, 26 Dec 2020 14:04:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r5so6547095eda.12
        for <git@vger.kernel.org>; Sat, 26 Dec 2020 14:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mognBMX1kAEd/ZU21RceCkqycezbL9VLXDExHmXCGgk=;
        b=oPr1rXY9QRc9mDPGcTBePb9A6wpU3gSWmML21R+Djs7Lfmphv9nyBRLkQ9rKaEwib3
         zOG2p5+EiNvXCpSMRKTCduYium/0BfI6V9oLsa4b8cvxEdodUeXST7Dos8MZIh3oPRYg
         avssxV8LgwRlBoT4MW6o9MqxSDG+6CBC1lJr/aseOc8duVP/1IOu6MeH/9XPACto/tRu
         irna4LdrRWFc+fwze5CzkFTDdaY93mv9/9Vs9HUvsz1tC3pmTsuOEkPDnWjOY8kSPRQB
         VzNychBZYudfnm5FUC1rzIJsF/2lle5Xe0P2TYoQbWjfmfku0vTz8JLiM8wW1J7PofWB
         +47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mognBMX1kAEd/ZU21RceCkqycezbL9VLXDExHmXCGgk=;
        b=nocQF66Y+CWcqx694Jjdkrcvn1SK2DrevXPAUAjVlFBpxkXqFiwYFVmUPFTk6V+RaA
         eV2gFtFysK2UyIXXN9wMcPqm+37p59+3WjjLp6VgSmDpIODdo8FW6RLc8GN7C41jytS0
         b1GtvRszTzHvyXvMNw84q83QyLbe7FwvMemPwxiwPyskAG1nH3yQrEeSRrkXgWCRfROH
         cLsGxkDBnX1OJslYQZJvPHiDLkBFfjufJ9OmFz9q3OOW+dknjuUkEkewLLIfHptAPqM3
         7f9bmtqGpJT/jr+DXUleQxMpbwacA5pr0jdbiiTwlQgf96/5A6sAp4z459a/6k/FsaIg
         qQuQ==
X-Gm-Message-State: AOAM5331CTLb60pSx531bBqXh46h+X9vHt87uEjBsz8ZtLU9+4PYVSB0
        kZdTjcBZe+fHjkSVKR8AXeT8nwj8MLKkkakvCSg7O6wyPZTARQ==
X-Google-Smtp-Source: ABdhPJyJXc50BoM0TQu8C9bmUFep1RxRLVU/9Ywtke0moaLR1UtXuqSsUUaz0CNEt8Nrt4106cSHFuBRqWzcdc0wabI=
X-Received: by 2002:aa7:ca03:: with SMTP id y3mr37244750eds.87.1609020259260;
 Sat, 26 Dec 2020 14:04:19 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 26 Dec 2020 23:04:08 +0100
Message-ID: <CAP8UFD2V5EdY2VBgP0Ah7BNri_znrGCMQ7LLwhATzJ5PaEymqQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 70
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, lwn@lwn.net,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Sangeeta NB <sangunb09@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Joey Salazar <jgsal@protonmail.com>,
        Sangeeta Bhandari <bhandarisangeeta0909@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 70th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/12/26/edition-70/

Thanks a lot to Felipe Contreras and Philip Oakley who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/475
