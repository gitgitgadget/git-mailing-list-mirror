Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D621BC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 22:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiITWA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITWAX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 18:00:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9343F24F03
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 15:00:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id rt12so2038396pjb.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=51X/YsUiUO+JyI7XodNJaKFUyMBiuW86+F6Je/u6C6E=;
        b=NRGCmLsmX75M5ZPUXJeLyFXUCjlVPI9Dybef7LOTDFNVe5WXTdtA0yTYScS4L0UjCZ
         Uo3zLuETQ2OVBC29yaGB5+5l3hPu3NH/8Ia+PJLeoZ/9bzg0Ze9CoFtcR9RLSTeX/kX0
         fRbXyndUnbN30wRYC06THgp0TxTNVbyhvmcuk2OjsJ1P5kY6gqHfHcNJ7PzluBBvp+92
         0qXw9dP+G97p2hLtE/fNMUkK9YdeYSap+JWAV6E+dTgZi5hMrPYNiH/XqRe7RQ+4rOVa
         TuCSvYT+Nu0ahHVrapamLhl6tjCkQmoydA6MgDxQdcckAnMr2lYZLECsnbElH989w+VT
         uydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=51X/YsUiUO+JyI7XodNJaKFUyMBiuW86+F6Je/u6C6E=;
        b=pTzRC0dl1DhVJzk8tw2DpRPFxe5xf6mg/+YdM7esogpJm+zqtdvT+OEHLch+ZXBoMA
         B48GB0QLYZ8NF0avxrMT04LzfLowOGLfzvL0DRaPVemoNJSW18go+5D0v194VhfzhF3i
         QZQDbrIccCANcWY1ACGgUOCyIt/vUGFSIi4Ur3PHm202W4ZmjL0QOoRBnyFMtzLRXQ1A
         3fwH6xUDKgmD352+KxAmJjfLJUuSnZ9PHTP0BHjugX7mbI4p/LdlFQfmxPpGZclBla0q
         ZPVrZdG5rX5rYHR/EpFdzIoYhi+exw803OT4LDMJwWZad3vvzYy7mD1yrFm1Hvu/klxN
         b91w==
X-Gm-Message-State: ACrzQf3NbZ/iZCH8/oyDsh2AId6F/bJcv6+eWsg1DZrbO8zYi0oO9du9
        3xyIR/7i26nGpD7E43zGaPdco+of+Z8x/NNU9RJ0PmQ3B8s=
X-Google-Smtp-Source: AMsMyM4fz2Yiow/jUnKOnIydrYgcyqGkTcdEhBoDK+F7oUyvMyXm9DIW8BDoRwWXy4KZJJ7qCH0DrZMK3fz+hQiLfAQ=
X-Received: by 2002:a17:90a:13c8:b0:200:17ca:f183 with SMTP id
 s8-20020a17090a13c800b0020017caf183mr5934963pjf.104.1663711221469; Tue, 20
 Sep 2022 15:00:21 -0700 (PDT)
MIME-Version: 1.0
From:   Marcin Wisnicki <mwisnicki@gmail.com>
Date:   Tue, 20 Sep 2022 18:00:11 -0400
Message-ID: <CAC9GOO8Y+5pXWPSPhxFdugT66MZj1rKkZ1Td=frPTF8vo73Nhw@mail.gmail.com>
Subject: Support SSL_CERT_DIR
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there any good reason why git ignores well established SSL_CERT_DIR
and uses only git-specific GIT_SSL_CAPATH?
Why not fallback to the standard variable if git one isn't set?
IMHO current behavior is bad UX.

Please CC, I'm not subscribed.
