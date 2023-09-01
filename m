Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA68CA0FEF
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbjIAS3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjIAS3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 14:29:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478B19E
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 11:29:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so2997805a12.2
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693592948; x=1694197748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rpDJEp4R14obCnHWK/mty8pp3ixCZkFOyGNWePnj9Jo=;
        b=r1FmB9BdDdLljbFO2gBjOKTLKc9hy5vSoeKqae+mXzxgsun2QNc/vCiCVi77AyEGFb
         tAST9ubmfajA6xAUQGSIe0GLr4v+bYmHx1T4TVK+pUE06MVt6FbXHbMFGZosYFDve3oC
         h4YlWdHkzoZjqdw1u/sXlW/xFvoOJXBkcJyPchIarI/jur8I2ps2mxMSJde7xOlZbaEe
         IFiZYN6KnuHpQ2Pxv830VjQIugd/sUKAeIoeBnnc4V+rPvKqUhLS954fSwTVTRIDP3jM
         YGPmPVLKBzu3uV07c61xtRJm0wYFZKI3s/qFsRHqqKTJfQRF13fS4wW4QIJyKZYlZBbE
         rkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693592948; x=1694197748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpDJEp4R14obCnHWK/mty8pp3ixCZkFOyGNWePnj9Jo=;
        b=KPb8VXwGu4l8SADQYen0bfqmyE7pnN2t7s+6gIadPLNbjc0hf4tsPwziVkxdTxt0kZ
         idzqX9+zHltt2YJU08REmxnkxJ9iAcC0LelEEOcUcXtjAp5vJ+xkf2R84oGlATT1fg7F
         IYm78kG5pg2gn31TYHAfYM8L9kSEVPAmRbB3tQ9rGczfqxhnRYb8QfVqyzrLrQig3eVk
         bZi9pL3cmyP5Nm8shko0Lk/upAcGjH8pYsJt9mBTnDoT2RVqVgOOr7pnPtSnIzga6dAn
         xMExBdHAZbWx9nfkVOxf+yXDIlBibdi70oUYcWh5BdFtN0wVK0yalu+wHmvjsj8K35TT
         DgvA==
X-Gm-Message-State: AOJu0Yxibl4lGbZSYm6jN6Uj+jhgxkwWZx+METRNtt/UHNooh8XuJSDG
        t370oSQu2tSZiJeLTjqv7Kf4m9JR1zysJRH1stP18JhHooo=
X-Google-Smtp-Source: AGHT+IHnzVLhIaEeNf94XQpj/k9rHjiC06Ngh7Qv8uTxC3FPEAgR5HObZvZvBWGkSTnkHuUpLUuhq1emqCjxDgmYf1g=
X-Received: by 2002:a05:6402:3459:b0:522:bae5:282a with SMTP id
 l25-20020a056402345900b00522bae5282amr2644544edc.1.1693592947979; Fri, 01 Sep
 2023 11:29:07 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 1 Sep 2023 20:28:55 +0200
Message-ID: <CAP8UFD3Q985DZy233PnuWu=GT0Qy6+Xh9a9MdmLk_WgwZ+Sb7w@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 102
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
        nick <nick@nicholasjohnson.ch>, Jason Pyeron <jpyeron@pdinc.us>,
        "Theodore Ts'o" <tytso@mit.edu>,
        =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
        lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 101st edition of Git Rev News is now published:

  https://git.github.io/rev_news/2023/08/31/edition-102/

Thanks a lot to Calvin Wan and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped =
this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/660
