Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2C3C53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 10:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjAHKDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 05:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHKDD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 05:03:03 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF4A2B3
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 02:03:02 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-4c15c4fc8ccso78118567b3.4
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 02:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kOS2ChLOw0YUkQS1WSlwR3eCNWjrrrrllWvq3OxBUIY=;
        b=AtcuP70rpYCItRPpeGNgjT4deXYLVl50+Ka+SoFyVJy60y65noef7vGqcl7ou9sJvr
         TL/J431MNMgKSyJrgkekOVTyUGHq4Qqn806Lv3yTdc7EK9WS5e807fK5YXVzKLzsPdun
         xCfslj8huJrIiE4JRdG/Neg0b5uJAr89MJy9kADp3QdwQJOC1rctPCtMj8ZlmCM4shMk
         Jmh5yJVnzcP/O+n86kzlhCsK5NmNOH/Uk4EIy7JTayiP+NZylNLaDgxeEKCoMeh88D5l
         q2P6gGVPb1C2o6sEZRk4g099c2xq7mwWFBs1MQelCSH3zGTj8tgWsuU8jxHvgf1xJBq6
         8e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOS2ChLOw0YUkQS1WSlwR3eCNWjrrrrllWvq3OxBUIY=;
        b=grao4Azhgl67z6UJi1WB6WE8tb3fQ8t0T56ZaUGgzcz1+XupiY4E+Z4WH19MF59FY3
         2Jtvo+7yTlCHVBF1JSr+U0Dmw2Yr8DLQ20VkPyQlit3+2UEnAC5YEwOiZl/PREnPauS1
         CtW/gkW/yuhR+//ryvjyT3SpJ7pYiBkEnHT9sfGv6d/P6oYmk9IK1rrun9MBXceKNy9K
         /NLL+Ayb0Sx+21vyS7ouW9Frej2yOcSpdV/IOediyjb9RhsaqUiLCtCjGwfrB5Og3+Xv
         9Eeqz8NzfbD7gbSYwo5N3VlAg+VSpkq7yVmm/8oz0nbFLVe7ZgGX6weXanRlmUAxdp6F
         d46Q==
X-Gm-Message-State: AFqh2krzKgwEyY4BSgK3TKzvbgXc2N0Lt2eEHVw/4MqWyl7G5VnP8Sms
        g0kZAkrmDzYl9aLxhUVdGAK6PEJBHH/G4ZOEk5d5CVSax5Q=
X-Google-Smtp-Source: AMrXdXt09L1NDpTrbzz2f4GyYS28lR07UcC9t1mjTUcteNC0+WzxcT7VzYvjFiO+KS91+eBp+VRn/Ft9qiR9XkxRcpk=
X-Received: by 2002:a05:690c:fc6:b0:4b5:e0bc:19cb with SMTP id
 dg6-20020a05690c0fc600b004b5e0bc19cbmr2727406ywb.454.1673172181626; Sun, 08
 Jan 2023 02:03:01 -0800 (PST)
MIME-Version: 1.0
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sun, 8 Jan 2023 13:02:50 +0300
Message-ID: <CA+PPyiG=+rs_bOQbaNB311_DVdSc2g44SkLzpaqOER7rfxykrQ@mail.gmail.com>
Subject: Github actions failing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
So I wanted to send the next patch after review.  All the tests pass
when I run them on my PC but I get something like the following error
when I test from my git branch
>
> + git checkout -b signed
> 2283 Switched to a new branch 'signed'
> 2284 + echo 1
> 2285 + git add file
> 2286 + test_tick
> 2287 + test -z set
> 2288 + test_tick=1112912113
> 2289 + GIT_COMMITTER_DATE='1112912113 -0700'
> 2290 + GIT_AUTHOR_DATE='1112912113 -0700'
> 2291 + export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> 2292 + git commit -S -m initial
> 2293 error: cannot run gpg: No such file or directory
> 2294 error: gpg failed to sign the data
> 2295 fatal: failed to write commit object
> 2296 error: last command exited with $?=128
> 2297 not ok 338 - test bare signature atom
What could be wrong?
