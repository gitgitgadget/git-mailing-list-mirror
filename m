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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AFEC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 12:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE70613D8
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 12:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhD3Mh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhD3Mh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 08:37:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36786C06138B
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 05:36:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id q6so23163835edr.3
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GzdyuqLKtumAbP84pI3ttnQptlCkB1pBaMZpiyvVed4=;
        b=h004Wd+8qL9akdmGL3e2yAjn+7MOkwKP36MvjwNdjbu8+o5ZSnKT/DZ4Pevs4qLx0y
         qY79bVIWIPK0ludxRB4uZcv4hzTio+tdOfZgQ8Fz2SaDHmMrOTsqBEH/JL8UQHlmu3yV
         kH171uhKKrsBE9/Cwm3aQYh2jSnK+qcspypI2T39oouPxjXQc/cBlt+QnN8EXTz+qcsq
         PcDpRwInlHxGSEmZJsqrdBbbsQUVMxyGF1KJHZBU7+exZSmj6yfWUqFjiMiX1Z8uO48O
         SqV/zQjkvDo5iXcyfjnyINF7kDTwgVwu/FN/kNlWW1jpNMbMj32CRkJl/ZNOS4qtDkwU
         NEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GzdyuqLKtumAbP84pI3ttnQptlCkB1pBaMZpiyvVed4=;
        b=UwF3xb31GUgtSjI0WMqcxjmwLj/m5IXrO/T1XBjzoxxBBWftsGLrPSPAqUh2U0JwOC
         /9KUyv+XIk3fum/9KUkIj/+0+nLOEQrWS/+9TZnwvsqsd270TfM2kb+hnTsuuVGdvaeW
         MbRCtYjo0zfOOvciMY7eWgBTdvhhAcLhanLD6vPsB2rFCAr/BmE52zHJ55hJfoMDtipT
         eGzNbwov1AywW6vhv1Mb4dPBvM0qZad88Yj/Dh6ktRv5K8Q+Ux37WoxnRWFX6bLpix2y
         PT+rjdrWVr3dH/lJVFRHb0acCrZ+T6OM8p9HZcD1+xZu7cSwdUHGUZcmQYFSKYq0IBQW
         tpRA==
X-Gm-Message-State: AOAM532RLkPlAeVMT845pRHMNiHtY/qIhIdyUp9JD8szmXJ9E3UICCQO
        9NtIORV44/fTsa2gSfuCqpHkhrND0s3+GG5wthz8blJxDEPnfQ==
X-Google-Smtp-Source: ABdhPJwf5F4CtKqwjPwGwThSmFX3N4UIq4gyqMYMWa+7JsNuyohootL1PYWU50rHrKneIOmrEkN7Ohiy3E4URaNcPpk=
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr5748411edv.87.1619786196740;
 Fri, 30 Apr 2021 05:36:36 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 30 Apr 2021 14:36:25 +0200
Message-ID: <CAP8UFD0h0xsXOF28wc8gi4Q8ivMBmbwoN_vzG=UwEbt7--+13g@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 74
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sven Strickroth <email@cs-ware.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Yann Dirson <ydirson@free.fr>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Joey Salazar <jgsal@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 74th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/04/30/edition-74/

Thanks a lot to Yann Dirson, Elijah Newren and Sven Strickroth who
helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/500
