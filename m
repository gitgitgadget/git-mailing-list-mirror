Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49622C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 21:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2149161C2F
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 21:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhF0VOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhF0VOh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 17:14:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1520DC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 14:12:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nd37so25869987ejc.3
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EFpBEbIqSmZq2ufq7+NJJ2bkE05/juXa5tZLSHyOE/g=;
        b=Zy0fxcSuxABSWid1pFgw56fHVOnWoC3HqxEUp/wuDkEM6Qs2cnc7IB/V/cEfCqR/kg
         3wn8RIc1wx3qhqtSfDg5RD8FBtO+zS5wVHOo8O5nQR4TOJ9S2oOOHs2lFeDzLhDEvKvm
         C32wKGH5TnZUg8MmDBUyg950HuLvwKDDmAtT/kCAh6gVDNwcgwlZJ5+a6lv12FLfCiBq
         3lXY4d3vwir5vVybm6KfAtHxtF9xO2pDXLQOqa/RGwk1PFBF7F4rZfNj8e7LXewW3Lip
         TywvwTaVjv+SA/FTYCcq/sCkK80lubq6zmTvdYmiKu5aeMSqNc3j2h8yAMsEYFzMTM7O
         IeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EFpBEbIqSmZq2ufq7+NJJ2bkE05/juXa5tZLSHyOE/g=;
        b=p2dmpO4quww5SUm1cFxWbOLiUo8dr2Xupbs9klb00YcEyvMwuqhLUsA9iIQigRrHEq
         MhQxpyUFkTuw+8AB/DFWZ47IV8oTasm8EA6KSgpt46RPl/HZLRuiGLE80D8tGH/3IURz
         Wv56GhKoSkyhUnAHnwSuxRMuRioGpoKCOWMjZ1K4o+GT/ciu2Wb1iam2bqN6pdFh5mPn
         gUwX41zO82/XYSdaedSBvmVyYlqahRRbwO7Xqw2RgG53G4g6lrKThk7/MJMJ2xYNSz/K
         yjC3PPEouOzOUJ/+rV7Wt19B5zEvu5XbIKEKdAYGaRGxtFIRsfSsdIlpmh33N34uYO+w
         2UsQ==
X-Gm-Message-State: AOAM530lk6CSG31m/NpQM+aPJSiTwBgXL1xcvowAuGMttc64Z9TMweSE
        05AoJym6a+93MWKsOfuzBjD9ZzfTUTMnCYoCri4OcyTsAVc6vw==
X-Google-Smtp-Source: ABdhPJwemvFjaWyt1urkzIMkmgnnNVGBVn1Bqn8Mr1pxPbPZUBQV4K4XA9mFsn76873mNOCP8j2xMMGmkruiSMg3ZtE=
X-Received: by 2002:a17:906:244d:: with SMTP id a13mr21463728ejb.551.1624828329733;
 Sun, 27 Jun 2021 14:12:09 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 27 Jun 2021 23:11:58 +0200
Message-ID: <CAP8UFD0i6PGOrS5MS4dmb0Hq_DAGs-6YSEF+FGrBFaYb-BtEgA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 76
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff Palmer <jeff@jeffandjackie.com>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 76th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/06/27/edition-76/

Thanks a lot to Han-Wen Nienhuys, Luca Milanesio and Jeffrey Palmer
who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/517
