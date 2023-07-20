Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C208EC0015E
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGTVwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGTVwo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:52:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA54D1719
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:52:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991ef0b464cso520212066b.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fullthrottle.ro; s=google; t=1689889961; x=1690494761;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7gIpj+sqI+G4UcXmpSu8MYjCg0F38KTdXCHhedROqmw=;
        b=fY0Hnzj3HAJoliA0p9rQPIKqzzQYUh1UECRZ+oaDSTukrGSZ9AuV5GoK4oVItic+nL
         vLD5sBSSjkbaLMUs2gLBRV0qCQrwk7fFPSHrvDuV9vvD7FVkSwxvdvOMtPOroTozwUfW
         2J20EV0m3R451BnXygoXYxI6shYQ3jEp0VcGLtCXODedcK21zi95x+RnzW02/ktrNgVG
         bB/Dxk5frnBsW47IeDMBQN4rAw29Jz/TQopO0ScUgwxam6Ia5DvQY2pvtQ5NrPgcupSz
         mkLbOpeknMKcn90Q81HORiF+4kRM0GaLw7Nbvws0p+HAcmRkT8jqqt3eBxYYEzOuU6Jd
         0b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889961; x=1690494761;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gIpj+sqI+G4UcXmpSu8MYjCg0F38KTdXCHhedROqmw=;
        b=KiGPgKM23nWMBjCtcCONIZjmZi9v8pzJfTnTNjGkw360shQTT6YTRU1IfPOdSWRphD
         ereMq0czv9lP2OvV0jRO5EEoI+qwz8ZfvBraLX79TaTk2U3nW5OUJrZJqKL7O12GQwiB
         TU0U9NBopnHwwGBCcxgkF2Jw3Yf0EyNjeBU1xpW1+uY/i7p3jiUGhlUW226AWb7SgUzd
         GImvOei/CDA/jDKVjimyBRv1FRUJQrrZHfLvnjA78JX+S7pqPv795BfWcSUmzMYl4P3Y
         q2e7aLLb3JM5OnSsbfcW0cf4EL9311asixJKmvIHSmSVuM70O5AfclU92NXoc12OZQ+u
         A+Fw==
X-Gm-Message-State: ABy/qLbLCNGosp15+/vUHa6YONSrfkKvV38RoYdFd3b7UoAu6mbmByWj
        LTzoJOPzgLYbEIGnalaM82y/5MszNy8Q8kA8QPwNTirUvcv/eMx48TU=
X-Google-Smtp-Source: APBJJlGL2kEXvHkvh2ex+iJz2uptCXrhAmmMa9vAC8rRj9kdZwjgcRQS+bJKt2yOA5JUZRupx4FcDuLHhkUef6QS3m8=
X-Received: by 2002:a17:907:9620:b0:982:a022:a540 with SMTP id
 gb32-20020a170907962000b00982a022a540mr7661391ejc.11.1689889961485; Thu, 20
 Jul 2023 14:52:41 -0700 (PDT)
MIME-Version: 1.0
From:   Radu Dan <radu@fullthrottle.ro>
Date:   Fri, 21 Jul 2023 00:52:30 +0300
Message-ID: <CAH3jj7fS3wziLfnAfKz49W+aZVPvF8Nm9UVBMWyeHLvYov7A-w@mail.gmail.com>
Subject: [bug] lots of changes including .gitignore, many rebases, can't
 legally share the repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

> What did you do before the bug happened? (Steps to reproduce your issue)

% git stash
No local changes to save

% git commit -m wtf
On branch test
Your branch is up to date with 'origin/test'.

nothing to commit, working tree clean

% git checkout main
error: Your local changes to the following files would be overwritten
by checkout:
settings/local.py
Please commit your changes or stash them before you switch branches.
Aborting

> What did you expect to happen? (Expected behavior)

Switch to `main`

> What happened instead? (Actual behavior)

Still on current branch

> What's different between what you expected and what actually happened?

Better error message

> Anything else you want to add:

First bug in 10 years of usage, great work!

> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.39.2 (Apple Git-143)
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Thu Jun  8 22:22:22
PDT 2023; root:xnu-8796.121.3~7/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
