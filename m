Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15858C77B73
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 19:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjD3TS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 15:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjD3TSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 15:18:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46554170A
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 12:18:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-95316faa3a8so361611566b.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 12:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682882331; x=1685474331;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1+b0/o42qE+i7/55SH4S0jz0jmHhlhqrnQSwvvg9qYA=;
        b=I1gjbG52h4Htrro3GUH618d8iNYI88dt240hXiaVslsgX9Qh1wtDpP5IGZcvM6Flx5
         09cfCyeqTOHEx7X+5rzmEv8jW50b6NsEYuRQXnq5uAwfx6qoD4GnCVuSoEOKhukF2y+n
         59OFxGBuyxHQis43ioBPJePqjyEVgbhNGcj9lC2lMYN4/NbB7PLj2TXN+S5DUCPWkcV3
         BRVqvSzBxrnhnymMgF/HntWracHkXkRaOLmCVQxe2FJ3uYLKgSj/aWGRFSA0aY+unoVh
         87AuZHOvwPCGHQS1yuX0gZYKzXJfniDqgUy8zjGYMigWC+SDxdpxT/0I/cgfNR1TYRHD
         Pmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682882331; x=1685474331;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+b0/o42qE+i7/55SH4S0jz0jmHhlhqrnQSwvvg9qYA=;
        b=clq/ToOUpUf2dxuBV4kQjOxh2YVBZypBj4w3OIVOyYYEOaqmZ9yhJZQOrqGmqATJ6g
         FTNFoWdNhr2lV0E+iCqAZoYjDS8tvag3gL8slBqUaa0CJL2cuO7F4PkSN8dSALAr6kKH
         TP469PKjXkJyandvsRLBg21OaL4q+9e4Fenzw+zfI4WfTVJlzenPqcvB8rs99zV9PJUT
         0NRvCmEpuPGWqsR1Ni4jgIhLQzDIyoy+I//KeR8tmiLDuV1hXzPkr0frr3XIidRqDOFy
         Ouc4sszK/Mk0dcCqUBvsKzywXUq+xg06GIaOLvU4QS+RMOg/LXx/Lih38+Uh1xaFHvZA
         97BQ==
X-Gm-Message-State: AC+VfDyOJw54YyreStbNIFvecft0dCZ0UcZVYLHFMrq+uCfo9b1ZXxYy
        ziV6nDydX4SXjTw1zQ3ac1WbPimx+8ijoyUBqWhl0p0OH5rmzw==
X-Google-Smtp-Source: ACHHUZ79LxQfq8XGjerALOfky7SWwVyh32Eo320ASxWKDYZVdwXgI8wRoGEPJe3B7feQ83Wcs8ncTpnpr+Q0FAaEoUM=
X-Received: by 2002:a17:906:9744:b0:94f:247d:44d2 with SMTP id
 o4-20020a170906974400b0094f247d44d2mr13429987ejy.5.1682882330452; Sun, 30 Apr
 2023 12:18:50 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Apr 2023 21:18:38 +0200
Message-ID: <CAP8UFD13nBVpRs_N=fjYk=aCoDtFRoAmwZz9_H98e4mb-wWiYA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 98
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Mathias Krause <minipli@grsecurity.net>,
        Stephane Odul <stephane@clumio.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 98th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/04/30/edition-98/

Thanks a lot to Bruno Brito who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/643
