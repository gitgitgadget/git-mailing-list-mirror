Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1430AC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDAPAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDAPAm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:00:42 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9421EFDF
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:00:28 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id n125so30356935ybg.7
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361226;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LLaA8FN20BlkS6GycB36fxrszeX/YBilQyVMBQg65/Q=;
        b=BwMTsFzhSZqtoneE470oeolvw4lVAuMSpgGNN0brSmT0ty0k83nf/XwGD7vIwDx1YH
         s1+CILudgl6PivRCUtcd6MehKXY+Mn0KsLJw7FzPlF4WbU3ULaVOv7+PTNIfVY8UdX57
         3rKESeks7h+IHpMfPAXf4OT0oCYpdlyuBZO/kHH/1YlOA2i3CyLS3wgKlvDE1wva0Be1
         JysFzSh2lH4cIuIIknT1JQ4RwXEGZdMQh01pMKJvScfNnI80+/OGFMFz29yc67cLkBUX
         wfYPFQU07hpaKbvukloafsl2yDmFgLj726H3VPKITemO/R0J2ewN92dwYBs6L3tkR5Dq
         u0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361226;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLaA8FN20BlkS6GycB36fxrszeX/YBilQyVMBQg65/Q=;
        b=L00vtCnd/ngdnLMnwkxraq5kKI86RH1aGR8f9UY2UamJDqyCXCyGZwYSoUectKvriT
         fxTtImOC796Bzkl55Uqr9eHIcVDWczy5hkDpepZXEVroYTgtHsftcG/+qMT7/jGgqtaz
         eBtlrV4v13h4eAfeRNUkPThbVDygvH69tpNX70rcOOMbDC6/Y1PngnEUvYh6Zuv4EzG8
         8oJp2QJHmB6R51bVlKlqx21fQGHFEae0+bxnJg6jir3bJgPPb/5Z6yoJzuAe7Dk9ao21
         8UEwPhXUInyOuaemrafHJneFPkVZbW36IPQKgWvSWhRhh7R4vXddXw/OayNV0vi3XWIj
         lHhw==
X-Gm-Message-State: AAQBX9cHa5M6W6r4vngqTN7ZstM+8/ML5NpaewMhgo1/4HJ/zphl9Cse
        BiV4cpyq50Sn0mlkJUf/PaId/jZWjsjAhIKee2pkVUmOJKxGLQ==
X-Google-Smtp-Source: AKy350bbsTmjzohuJLwRXX8cDkt2cwmmFN/6NSFzk+qzMpTBkRnGeuSmhh9asdPhy8TpCuReLoPHIMDrAyWNVxjDm4o=
X-Received: by 2002:a05:6902:1586:b0:b77:676c:773c with SMTP id
 k6-20020a056902158600b00b77676c773cmr20190395ybu.2.1680361226676; Sat, 01 Apr
 2023 08:00:26 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 Apr 2023 17:00:15 +0200
Message-ID: <CAP8UFD3adabbwdvaCmEXW9fQ88s6Zniim42vR3cT7VMobxFoQg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 97
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 97th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/03/29/edition-97/

Thanks a lot to Bruno Brito who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/639
