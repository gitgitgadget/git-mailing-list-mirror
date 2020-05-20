Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2D6C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B2320829
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLA0k36/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgETU5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 16:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgETU5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 16:57:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A913C061A0E;
        Wed, 20 May 2020 13:57:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s21so5979819ejd.2;
        Wed, 20 May 2020 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lTp55MKy6vAZ/fv/hLN7tIpG02v080ngf5J0yhha0VI=;
        b=TLA0k36/8EGZxLXge7s3OUphflzkrppEcWPeVf5Rx7CIvVu0wcqrPEDsNjKD0PdEqc
         mIW1y82rgz6qh3gt8/SNf2xyd48HMS0rxtwm8yNkdBt1rFazSxzdSmuWZCebt34Nq4d6
         QuA1i2x4HPk1Y3Q2u+MXA3pxToLFyy02ImoL6OV4ZS+hbP4+PKHHf1U2Qnp2m+zmPtRX
         gYfbWkFSI6yWUaHjfifJ8w4dzxQAHKdVZN0B2XMrLo+pAip4XDs7p2nAB7YM+cTaIuNu
         p+qlJqsdu9IWQOJenk/s2Ma9S5DwQkO+OKS0m7+iLRVONGV/9Fe/LHiBQ+3G4aNZoI68
         f+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lTp55MKy6vAZ/fv/hLN7tIpG02v080ngf5J0yhha0VI=;
        b=OnL2QzxTprDFINKjszoKQMHZW5D8EV+HO1cu+D5eSZHM8/AmBzKTo51AQQeTIfjp1A
         q1GD6211iogcDVU2ayoC1tcEy1pEqpSmwKI7F7HCvcI0hn8z1u/jD2/ZazMcfO4Yi3yo
         nRWWutPJyDYomp7+frf6D8p9GgGi41RFMQLX2y8QmgaAkedOBlANff1sLp/S6suAbDjS
         r2y43C+GtQS57oT4n8nEQNO4MQWyJz9pqhYo/ofIUM2UyUUS/vWuZkQCkiOxsNLeRySo
         HYJ1BNDOl0O3ig5/PHFmFJL697TEGWEyY+znXr6vflepS4Brc3Ro7k1tCappWDWayHiz
         fYUQ==
X-Gm-Message-State: AOAM533n0pejr7PQOvOnlSm7iErio7WZKRCs9oSROQTLjDZqZGIfwsWv
        t9+OGRYOgOK44QWY1NwJB3C+Nc3mNHF8gHGE6kU=
X-Google-Smtp-Source: ABdhPJzfSNiMHuhzbOL90B5qbr/xqvefiaGq/NDBvBhItbta/p2cpuzCuA9glEIKMQYshPYZiYioX+vs3Zv85ueSYdQ=
X-Received: by 2002:a17:906:f8d6:: with SMTP id lh22mr865037ejb.132.1590008233930;
 Wed, 20 May 2020 13:57:13 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Wed, 20 May 2020 22:57:04 +0200
Message-ID: <CAL3xRKcr6=YLoJZcqH-nPiVcr2sAjv+L79vC3nGAoVRHTqu7ng@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.27.0-rc1
To:     gitster@pobox.com
Cc:     git-packagers@googlegroups.com, git@vger.kernel.org,
        linux-kernel@vger.kernel.org, shouryashukla.oo@gmail.com,
        tmz@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

> Shourya Shukla (4):
>       submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
>       gitfaq: files in .gitignore are tracked
>       gitfaq: fetching and pulling a repository
>       submodule: port subcommand 'set-url' from shell to C

Could you please review the minor fix in
https://public-inbox.org/git/20200519045301.GY24220@pobox.com/
It helps the backward compatibility for packaging on CentOS6.

Thanks,
Son Luong.
