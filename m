Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87126C00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbiGaUn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 16:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbiGaUns (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 16:43:48 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A89F12609
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 13:43:47 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i62so14342141yba.5
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dAmtizyzqOwHLqTjpctOm+C+QgcsHuDnk28WANytIvI=;
        b=Gn4qrc4UcXckMrY6jU4K4vKI11qiJyRDK5KJKup7UVEdHfprIuq+q0WbLircCh2Zct
         GcNFjaaeGoa0SPWHW2iV60kyTeBI8Pq//9OgNq/r0Mwd400xPBDsbGodbhu5gZRlzR1H
         LKkO9ZzChh3/8J4HTJcA55XFfvqzIqqrrH8fScw9bXIZst39mnaBzoA4iwfJIjU19r3c
         5zoSP3OIb+xMqYvG/IT6fNJiIOfIgafAEoFkk01AMYB9JOsZaPgrWHP7c55576kFdzpa
         VQ7SeWvW69rgfTSpVvCKfHQlOuLjP4TqYaMKvrsKf7Y0z3ZXdcuHI+FcpUzykJKzxQBK
         T7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dAmtizyzqOwHLqTjpctOm+C+QgcsHuDnk28WANytIvI=;
        b=wRPa+8PSk+q8qOhR9vg0PrYlG8+VlzzaR3SSaIuT8yOv/7skzrbADE3XRHfwK7b52F
         HGIsZA9TrNW8RJd1y46rcG1cwoOBhAuK2Usu5lid4DujcSuLvSQJ+dOWipq78PAjUpXA
         DF/cNYgwa87VR73ZT+tR7+t8wWylFUcIFiJ3pVIzj1KdTgeGn6T/Gk+Kmzl24XBmbAOY
         8Tp3UK7pDX3jQxx6jtBkhlCTipPs3ujHCIyYgE3dEtZw3YqaiL0SFbWBffxPmjof3BKe
         oBOGYE/r6Jen5S1vmmcsOFQXNgJqfdO1xgmmCQS2xRj3GGZaniPupPWSP+PuvpHC8GsD
         4D1w==
X-Gm-Message-State: ACgBeo0Ojq20Dpj3p6zNPSC5lBFp8JcpC/nIc5GBhWqJpSJjbGvMCPFu
        7dfHFGfGciWsW5w7fOvNZWi2DwcqC/z3NvHCLBGFfb5Y7qs=
X-Google-Smtp-Source: AA6agR5wpbCIUA85WsLNKX3K0BjNhL9B/u/UFzi42b+UR8/AV7NdYu3WIuBdRLWzxg9HAUiqFP7WHoDkLsCncqPRt4U=
X-Received: by 2002:a25:20a:0:b0:673:c2bc:ab with SMTP id 10-20020a25020a000000b00673c2bc00abmr8875409ybc.447.1659300226325;
 Sun, 31 Jul 2022 13:43:46 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 31 Jul 2022 22:43:35 +0200
Message-ID: <CAP8UFD2nn134W+4a1vk+Ge-ARncM+sSUv-2gSObu7tni7mX4VA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 89
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        lwn@lwn.net, Elijah Newren <newren@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Tao Klerks <tao@klerks.biz>, Tassilo Horn <tsdh@gnu.org>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 89th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/07/31/edition-89/

Thanks a lot to Junio Hamano, Philip Oakley and Bruno Brito who helped
this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/596
