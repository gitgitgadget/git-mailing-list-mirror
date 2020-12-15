Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE96AC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 19:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4C722ADC
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 19:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbgLOTJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 14:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbgLOTJF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 14:09:05 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7A5C0617A6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 11:08:24 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 15so24538566oix.8
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dE+u60FsHYhTZPFh6BdjXeqvy9+X7y0niyTox9ZzvG4=;
        b=Uc/Z5FitC9NR4SGb/rNG6PpuQVJLXG8TNtD+U/VGIs5w6gB3FYKl2CDXTQ6DeVU8ew
         c9zD8Mj1JUa0rsW3F7R6pIOrAUX1NywDg/triuU9ILkZTzq/YvKV6VCI1Vr+uJgohSyZ
         8C2vg772RNt0BXXvEXVJKXQbVugBXrsGtb+iKPbGkM/WFXZD9JTc20lOtVHeBl2c7PtW
         DlLoQVev5CKbhjvkTIGaYEOdR0Q6fjtwV0iZ1pOlbVmQL/+votzRdG0nZhu1V8j5mRxO
         bq0/SVXwk16SIpqLjmOPov7I3tk3kodo54X6l1qGd+xoH0Yr972o6l3kSO/pgMOiTouA
         CKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dE+u60FsHYhTZPFh6BdjXeqvy9+X7y0niyTox9ZzvG4=;
        b=jZpMW5nuC/4CQgAghfiQyBLbMOynDWDx6EW7y/7iTBkDtfQSmWhHooXP490qjDUjwG
         nHX6zkwB8SYwJ2cwNHTzjamS1Vt++8Tvzo92F2dZpIuH2Y1yWuSObrHR8mzi0rdaipJm
         i/qBM9R02LbjxeS+Ww5TM6HnEZka93OT37GCLA2Dk4tpOmWXY+V2fSAdvj7ybgnY/ULH
         5WaSWX1aqSe02Xnt3hmIaN5TyskMTfux4+/7UGOKNOZIfTA81FJwk+tnYofJT8wu8ZEs
         HdX4o7TurtGus8hkMrgtg9FZtbUHjo1S/pYtA4HUm25q52vsup2lHdDJZAd6+JWTbOBp
         C+ug==
X-Gm-Message-State: AOAM532QaSwUCMvDExf0kctQQBBKcBnI1heZGmh8GXXcg3VGzSkaBv1q
        xdhzT/KyRYOh/q+AR7tyPyt5gqXXXn9Y0jFNTTVle77PY3yUpQ==
X-Google-Smtp-Source: ABdhPJxkZdLU8piTqCPrV6wm/uIxpfk08R32F3akxSrlhwaLRiverg9fAumLhhpWmoGaerSUZEjdpu0VN5HxxTsJvw0=
X-Received: by 2002:aca:c592:: with SMTP id v140mr248101oif.10.1608059303904;
 Tue, 15 Dec 2020 11:08:23 -0800 (PST)
MIME-Version: 1.0
From:   Sangeeta <sangunb09@gmail.com>
Date:   Wed, 16 Dec 2020 00:38:12 +0530
Message-ID: <CAHjREB6QrR-FQzwOphgw1z1Rba=o7gNvEwomHc60aNH3EkQg5A@mail.gmail.com>
Subject: Perf lib sanity tests fail on OSX
To:     Git List <git@vger.kernel.org>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

The performance test, p0000-perf-lib-sanity.sh[1], is failing on my
local OSX machine due to an error in the test_export of the foo
variable. I think the test is failing because it is not able to export
the `foo` variable using `test_export`.
[1] https://github.com/git/git/blob/master/t/perf/p0000-perf-lib-sanity.sh#L26

There is also a mail[2] from Lars mentioning this that dates back to
2016. Is there someone else who has encountered this issue or knows
how to fix this?
[2] https://public-inbox.org/git/9A11C3D1-3DAC-489F-BDF9-F4D409E8D3F7@gmail.com/

Thanks and Regards,
Sangeeta
