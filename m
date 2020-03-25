Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42375C2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169FA206F8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPd3xbsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYSXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:23:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33206 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCYSXW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 14:23:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so3820536ede.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qsGY9fiK6SGfz6kLOO0SHAhaJmps/tNCJNiVNS/jfVk=;
        b=cPd3xbsEBuC/+3/KTjNWJozhaI9edFADks/Kjh9SzRcHHBKjgZLEmvNi1vcXEwxdbY
         9P2jxH6ZJU5OQCBzD+4q4qZuhBtNogadV3wEDT8+pNhG0sOITK0caYprmHvQ9hmGtV3d
         uGKdZj7ZhIP6iKCRjtR+iUKXDGYTfzK5SfyG/3EZUFSL+/jNyYaJrZwZOaDZDu/nvqPB
         YRyOW5j8fWTayGaGhyyxZeSiBsaqDmFpCqv1drk6018P8sdPczkx+0wxECaQ85QBHDIA
         BMbx0g2+PcBcACr/RhkN33DY5P8PN9d5gyP/vjKXAd+RERba+TSPFDj9KYDECwPm2fmm
         fEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qsGY9fiK6SGfz6kLOO0SHAhaJmps/tNCJNiVNS/jfVk=;
        b=QCvlU3s6ioDgX160jSiHGAwSMkIIVUKdn6tWp5xdI2928jWl/QBKZkJqvtCi6KAY7j
         Djms42FD9L71/YfbywNMuH9ljXAgSrw1fCp4TOgsd8RdixVo02XYBySdZtTAi1ufuqpC
         oki0YkD0USc06n0yA4S871l2lhlsa/ehAMnjqdgfL4NFvmJN6V5b/Y42eORq+sZv2t9m
         6kDpPiKI0tRgjhfSKuVunj5SMAuVnTGQPJHWH95vf+Y8yoxeuKV7xdCoIkPOlVuWzOdy
         0qAkmW9jSGl4jZaqvK1Nv053x49yptxOnXXsAaVtU+DdEM6cC/eA7pTfeF3Sd/fOI/Fd
         V9qw==
X-Gm-Message-State: ANhLgQ1SSXaOrc+CbFUZQ1a/j3hMPNC6z3t7M1nlC9/LEbXrAmZ89H12
        R293Jw50+C/jjh+CZxdkF7j34+xwUElnW1TlQdn6AlIu11Q=
X-Google-Smtp-Source: ADFU+vveobf7+jKpGdB1ayENWRY0RgRi8IHsaBPw9GXb+EY6D9GeNkVtNnPWluEywN61eRGM118IYt5P1K7xHrujXvs=
X-Received: by 2002:a17:906:1e87:: with SMTP id e7mr4426714ejj.320.1585160599536;
 Wed, 25 Mar 2020 11:23:19 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 25 Mar 2020 19:23:07 +0100
Message-ID: <CAP8UFD0UDkwWZN7SEuzP1NCA_CuBDR7wH23WxNjwckK9r5CWDw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 60
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        "Miriam R." <mirucam@gmail.com>,
        Nuritzi Sanchez <nsanchez@gitlab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 61st edition of Git Rev News (5 years of Git Rev News!) is now published:

  https://git.github.io/rev_news/2020/03/25/edition-61/

Thanks a lot to Jiang Xin and Nuritzi Sanchez who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/427
