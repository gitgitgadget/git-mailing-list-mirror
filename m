Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945B8C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B261278
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350176AbhI3NOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350172AbhI3NOC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:14:02 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B76C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:12:18 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id m132so13040734ybf.8
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rUo7L5clOKjZJ3YIGWwAkw53gww0NttGWJoyYQyaoeg=;
        b=Vc4eHIOfp0UWoPmglGRu/Gm2lOAf3oXJTgMxfpa8e0m29uDukBWYFCZeWY1XcQ1/cQ
         9jIQQp0xpI7D8nOZPaVgzHzqFz9utATnGCxOOFTi+u63arvhWVqOSIElABjvjO1lJ22s
         TxEkaeri32la462b7L8WeL7zNA8KayVMQ72Y5Uem0ehTmZXMst0MpFiu25o1gXPP1r0v
         CicXX5/TS5fuUqynR1kcHKkV/vY+JN7VDGscqlXh+B5U28jumTr+bl7oVuwgfKqByyNT
         4M3AMusfhBrhTuK/o/6YRthv5Cx4Pw8tPMluCRE15/S85RdsAhEcqKnQre+pm3sH4mxj
         Ftqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rUo7L5clOKjZJ3YIGWwAkw53gww0NttGWJoyYQyaoeg=;
        b=ZGQSqm1cjYmiTiRgL2M8qA0fyjVnoowevck+0DSRJAh47M+l4C/TEOTCh8ub4zelwT
         R8h9txnRjeoeeGYdRj6r04+ud0BBwWbOHZQgUAAPZBEVBn4wgfnIEstXP1DPdzklrowL
         Fs5CT5jfgRScUMX9DmEOP7GZBGzs1Cq1aS+H4rxyYiaEagpn8XuEsvtQHxION0uZLfsp
         KnzcLlGWaWnTyG0m+zDj9hGQ75L3fnb6sgNYkm2l+dBQV9xopGH1VXltnMjJ/n58pZVN
         S0sZTVATe00sPPv5u3WlNJdE+I3bSbXuAFzRWJTGFfijyiTw2+WNT1YP7gISlCzvE1/J
         6XWA==
X-Gm-Message-State: AOAM530oT9mUQWt3QxLyUAP9N6ATBwcPRM/KC7nsLPgCamnYAVxB5y6D
        h5CERTfEqMlYtLN0Yd1ZJHXFm5huUXYazxfF7w+einOffh0=
X-Google-Smtp-Source: ABdhPJx3xu+7TXjqFBM51yzBNYuvmW/VFdrLy9ZUa/PzkCtxxLmwOj58aoqK7pgStYy52Ihqu2tH9Z91mc/cdWvD2ZI=
X-Received: by 2002:a25:4ed4:: with SMTP id c203mr6236963ybb.249.1633007537813;
 Thu, 30 Sep 2021 06:12:17 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 30 Sep 2021 15:12:06 +0200
Message-ID: <CAP8UFD3Tzwc5c=JeT2sOtRsmkBBRuSzm0YacUKro6GMpRRtL-A@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 79
To:     git <git@vger.kernel.org>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 79th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/09/30/edition-79/

Thanks a lot to Josh Steadmon, Elijah Newren and Philip Oakley who
helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/524
