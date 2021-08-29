Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDCCC432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 10:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1355A60E73
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 10:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhH2KWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhH2KWm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 06:22:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7F8C061575
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 03:21:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u19so196557edb.3
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=J5wgkAi+ZEFPWOMQ6aLRcv47krFPAHj5N8P0C9ND8rc=;
        b=prBEz6Lw46B0NvXWiwfFXqxYXxICluj/gD9N8mkyc9pBvOpV/Mt0Gk95BMtaUCV434
         QpEd0jUEgEtCr/qU7jMegqjqU5IH+ASVyw/cD5XZZ3YqS33VRc9/iKPyFjgCYKLrakRP
         tsZ9LJft6lUkPknIYsP8xnuwcZopwNeBhLhYgvOoyxjada76QqMhOcKh7kpUe5CRPghS
         5ByvsHCiaLhn+ByRGE4MY28UKCYYLdkGx80/V7kThfSm5oAIX9+mOv5S2vTpofVK+Wo+
         uzLX6CKK1igrXBRNEwCdc0NO+k/0XCF1R4zvwM6vGNC0zcIL4crQDbpRgWTwaNoMIhNp
         cT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J5wgkAi+ZEFPWOMQ6aLRcv47krFPAHj5N8P0C9ND8rc=;
        b=JTa/rXEUE8oYJHqldlDouex72xnrApM9+fjEod7N4Ahk8h1caeeS7d4lTX1lLDfO0X
         t/nd0k/21PPfAHQ3b0SKbEQxrtiLGG8UMJ7efBwJxYs3O9cQYWH6kl6GfeBmR6UkYoMn
         BqT7EULWZyxMQHSdkvjF0w9nRjtTcmXDAPkUADS/EaevQdLuMZE5oeehH8Mg+3p2lI33
         1TGYZM1cgerelriOA2By0ifY1K0Li4C/VRrbECbGlsqrK/LieUUjTz9NNxpQvRsHflg1
         vdKqddMk4+qBzw/CIegYI39y9iJjXbT9ddh6s+oX4Y2b25Rt3Nm0YutLqZYbvkRv/oR4
         X9cQ==
X-Gm-Message-State: AOAM530RsOqGvGSW1Rv8sVFcmQQxH70NMpZPG644J2KIQy0RyHAskU9o
        7PH5UDU521UaVkoziMnzupExKhXLPbWjSkDr3Qngec+1om0=
X-Google-Smtp-Source: ABdhPJwuevUA4ajkmHe0F0vM9JHBMepH4jTgS8bhfLSD5MmKsRSJc9CCDkdgEvYv/mgk3bfCrrvJee2UIT/emX1bvHQ=
X-Received: by 2002:aa7:db8b:: with SMTP id u11mr18447953edt.362.1630232508548;
 Sun, 29 Aug 2021 03:21:48 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 29 Aug 2021 12:21:36 +0200
Message-ID: <CAP8UFD197_XdFZ--khJa_E7bkG4VCsD0dPVP60AD=AfQU6Sz1w@mail.gmail.com>
Subject: Draft of Git Rev News edition 78
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        German Lashevich <german.lashevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-78.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/518

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Saturday July 31st.

Thanks,
Christian.
