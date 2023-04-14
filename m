Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08655C77B6F
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 09:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDNJlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNJle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 05:41:34 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2595260
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 02:41:33 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id op30so5618779qvb.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681465292; x=1684057292;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5UNntYhIBz0yJX2J0ep9b0OnrIqKcfQ63mvoOLLWO6E=;
        b=G3Vmz5gHI3OrOxRJvbQQu2TC8821IcY5LYIn3PJ2oWY+zZ5cyX6Fkta08S1eyiCYz5
         fiI2m5r4JSeW/Tp8TcxAJs6ZnxvCLrrp0TnHWJeyqwM0bnMLqF9ermHSSSOeYtmlReZk
         HMXuj8y15T2orP0D4+aMUh+wD9psPZbWbZx9yLPKWkpj52eZVl4FtX2dxeGSHnYmLRVh
         Pqm5t68iYNWIB2WTBV5pEvtxT5+N+9wK7iaofzzQO7J5Qe84pUxl2tgm9awZvBajA0PJ
         rNmdU9EOgk6QZWumyGKX9PR+le8TTfNhjApJSuQJ32TInt/+reme5nu2Dnkj8PjE5CBt
         LTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681465292; x=1684057292;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UNntYhIBz0yJX2J0ep9b0OnrIqKcfQ63mvoOLLWO6E=;
        b=NH30r1AQWEJqMk5HxkqvJPvxbaJkVmgzm8Xdcn7OMuocx6kwRKJB9UmvrRPo6P8psv
         AgdDLGa7LFzmzxfXJrshmdbsR0bCaoBtuczyu9KItYcDDecNeLbVnPPR54/u2WoJ9L1c
         GUfnHGeG6q6BI4f2FVfDzluw8wXn5hoZ3OS9yOny4xNczSHjMBv36YvjEuw5WWT/fJPc
         OHy2vGyzhSFEciKGULZgbTpCXm3mAe91te59QeQ3MpBQq8zCmiRXVfPHEl6nzu3LiC3j
         HK7jY8AOuIjW2NbCFfNCxYFR/4L3XvZSx7ExhB5vEPZ4I+sib7/DXvhKmxjrFvy7HZ3m
         GuAw==
X-Gm-Message-State: AAQBX9e5vMAlz5JuEqwJqgQjLdVdDK5ZXyhQX1WvLsoeIMeGAdfpkYFg
        sWDiuDYeUNoGDY3IOXOSpLPqR+dfQX1VlibdSvgW1eqIz2sCUg==
X-Google-Smtp-Source: AKy350ZDXgdz4XKohRKIrVWrldWQERoUZ2lV86OGgnvnMGZ/s7bp0L0z46sgu5AKJMk7tg0acBpvNj/HvcuzIFIUtpY=
X-Received: by 2002:a05:6214:e43:b0:5a2:5e4c:4f55 with SMTP id
 o3-20020a0562140e4300b005a25e4c4f55mr2200677qvc.16.1681465292352; Fri, 14 Apr
 2023 02:41:32 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel Furstenheim Milerud <furstenheim@gmail.com>
Date:   Fri, 14 Apr 2023 11:41:21 +0200
Message-ID: <CAJN3DWriXWYKyf+hJL+wZDCgwOZZsWRah=E8_HnKEWh1wcy4Ww@mail.gmail.com>
Subject: Git bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
> repository in branch A
git name-rev $(git rev-parse HEAD) --name-only
> returns A
git checkout B
git name-rev $(git rev-parse HEAD) --name-only



What did you expect to happen? (Expected behavior)
It should return B

What happened instead? (Actual behavior)
It returns A

What's different between what you expected and what actually happened?
git rev-parse does not seem to update. Same is happenning with git
rev-parse @{-1}

Anything else you want to add:
git version 2.34.1

I recently migrated to ubuntu 22. In ubuntu 18 with previous git
version is was working as expected.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.19.0-38-generic #39~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Fri Mar 17 21:16:15 UTC 2 x86_64
compiler info: gnuc: 11.3
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
