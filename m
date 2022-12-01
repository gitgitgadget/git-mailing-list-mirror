Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886AFC47088
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 16:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiLAQNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiLAQNk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 11:13:40 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E26F77
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 08:13:39 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id l67so2672686ybl.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2eTiA2wSq13woIosJYqgcoBUvwNQ8SlxFXyKXyiLy38=;
        b=hqP5lUH/cmJ23cMKpnsjwCz/VNrvzMnYGaUfVMlCpdGx3xGx82TeZelcnpB595vmJY
         ykl76Fw2lF4X09Fy0VVzE8sg6dL1i2ljVBgwbIt3BhrG1QAEXSsLGoR8Oy5N9+6aA/tw
         r2Ps9JiiiSJPnWwX9RY71gksGH377RQyfnESfkqiO6bxyjtQd/HzA4tJNIO9FBuy/Zzc
         +aRVGv+0aHP24Zg3WonmMLwNP7NG3BjdpJoKnWk9BwOTrtZMsmoSnZryoumJHKl72sSJ
         cbaMLTmC0E/klXC1f01B6DmyA7SCv2C/5B0S6PUCwkrkAxh4n0jYss1pdKZ5wW5nCrbl
         8HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eTiA2wSq13woIosJYqgcoBUvwNQ8SlxFXyKXyiLy38=;
        b=b3H2SlwqxINSFSjeru8c4IsdPqFvgQLx5g1qugdQ0jeF57fWGlX9KzPMk6FYcgUvXm
         wVxERaizQvw0omDahHUS3Q9Uj67AoRL5RGME4xTcTZ+AfPT86Na5rIrDrv16CkTC5uWm
         jH+a4HXou7FCPqlZ8UIwdp7HjYAcmsTkJLKSySh+vkmXNUDC+2Wh/cTLBiIwbEDti5XY
         nFqVgSHls+unxScz3I4JSpHpFExTlQzLAsKlsnr0Om+6H6zVKyxNXpcKD/tHHdIZ0/Fe
         SnN3LsFWPD/ugGYO7o9uJ6vGjVSp1EGBD0J/3wdSLHwqA+v5coaWamDANrfeGVR1jfWR
         4vvw==
X-Gm-Message-State: ANoB5plvjLmbLrdb0nhI2uCMs0XI5qhP5Eoc028a5kI5jFQEDBtutmbB
        LuBwFmFSYivPHDxJvywPFh5yaE2xiCSB2aLX84yZCvhcUVk=
X-Google-Smtp-Source: AA0mqf7Z+2fXtfpaZpseDp5lQj6LKttyl738368Ta0rWlr4bt0baT6x36drMTayY5OZXntK3/Sbsn5N5Oszod2/W43s=
X-Received: by 2002:a25:7456:0:b0:6f9:890c:6470 with SMTP id
 p83-20020a257456000000b006f9890c6470mr10628870ybc.13.1669911218688; Thu, 01
 Dec 2022 08:13:38 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Dec 2022 17:13:27 +0100
Message-ID: <CAP8UFD3HBaYfrEzZHjS_psFEHqX+L1FFL1S5MuR3VN6gP5OOzg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 93
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        lwn@lwn.net, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Heather Lapointe <hthralpha@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Bruno Brito <bruno@git-tower.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 93rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/11/30/edition-93/

Thanks a lot to Bagas Sanjaya, Bruno Brito, Glen Choo and Ren=C3=A9
Scharfe. who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/620
