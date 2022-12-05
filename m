Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE22C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 21:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiLEVdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiLEVdP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 16:33:15 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FEE2C655
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 13:33:15 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j18-20020a170902da9200b00189b3b16addso14429170plx.23
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 13:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5W+Oi+I8mBzq15WCu+X3WYoHkgMFuUGAxO0a/lT4NTI=;
        b=m+5JawxrhKlmMlBuyLJDEK/DkPt7SbCyhwm36jEZH2UPTPP7DQ3aJm3at+J5Y7MjAT
         2l4qddlN/nHAYWOh1/meQpd+2OIPiinYd271WxQm8t6BBS1OMqTwO8a54e49UcHEB+uF
         kFxEuIiT4Qyb18wizEtF1rQomNAWrPzbTKh2pMQV7TltrjryWTbX02GPvUBbmtSXH0gy
         JUuAl4isGEBPB1nVNvLO2wGzfEMqjExQn7FSgURJIsxAIYTGFbdcoDJl7IYsmnlEbtt1
         cg98JkMN+6p8wTEx6fkJJZixdXwNgK4kx3sIAZz+uG6WL5cAMNHYSXE0gf3Ger8y/RT7
         U3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5W+Oi+I8mBzq15WCu+X3WYoHkgMFuUGAxO0a/lT4NTI=;
        b=SoVll5VlAexe9JmbOdzq6q9aqNv+D0tQOCk9NSHwwvEj4ohT+nqGOFWhxpg2WDc9D6
         Y0XG0+NZxAR/X6O5d7ZagQiOvi13Wv52NALBSzwBEVbz+eVsG7dM7GubRWlm4/w5B41F
         T0WxjrCdq1QacPcKJoRHvdc33kmUa8C5Sc9lwd+7jT4EOYjrli6bGevMqJIXf+aP4pij
         KQkU6TvdMm5fYfNMKfa2uVxUM2YT5UDHRfKe540GHu09B8Q/F38DouPx2S6M23bn4HS2
         OyXC2B/fczg77wxEXNWNNzyyiblynKlhQu7PbBu+2OMSyWgcnfCWEl26MYJdkDk3aQJI
         SJ5A==
X-Gm-Message-State: ANoB5pmXpADPUJONO9ow77K9OiYqibotY2ieXao9SHwnRBWvbfkcr72u
        hyvgNiLmhJ4py5HA2jU1bwDlgZEtUcoU/vfEgiz2/5AN9kz6uuKi+C1dYNsK036/yfc4uVxowEt
        l1UHBSEcjEzf+/sOf/ysdKIAIjTWIR5HoNyFjyAcWZ1EFqwCTHvGki5+FV+e02NA=
X-Google-Smtp-Source: AA0mqf4+dMI8m585KbcMDnXpK1+5s1dzjCdIW9giFosnCXYyXrhGalHXOsTUCXScE5Ps0gQbTxfl9kiuANirjg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:ff0b:0:b0:477:362d:85d3 with SMTP id
 k11-20020a63ff0b000000b00477362d85d3mr58321020pgi.395.1670275994696; Mon, 05
 Dec 2022 13:33:14 -0800 (PST)
Date:   Mon, 05 Dec 2022 13:33:03 -0800
Mime-Version: 1.0
Message-ID: <kl6lpmcxedtc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone :)

Review Club is happening this Wednesday at 14:00 Pacific time (UTC-8).
You can find more info at [1] and on gitcal [2]. We run a session every
other week, and you can find the full schedule on gitcal.

This week, we'll be discussing Sergey Organov's improvements to the
"--diff-merges" flag. [3]. Let me know if you're interested and would
like to join (off-list is fine), and I'll send you an invite :) If
you're interested but can't make that time, let me know too!

See you there!

[1] https://lore.kernel.org/git/Yfl1%2FZN%2FtaYwfGD0@google.com/
[2] http://tinyurl.com/gitcal 
[3] https://lore.kernel.org/git/20221127093721.31012-1-sorganov@gmail.com/

