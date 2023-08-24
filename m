Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F59C3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 22:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbjHXWJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 18:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbjHXWIc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 18:08:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E6010F
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:08:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so4498281fa.0
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692914909; x=1693519709;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a/ZJMq7ftE/nn0+jpSF5qBTmT3JWpquYk83761itMQ0=;
        b=F5tFvy0y2S0wXktmNoYTPKtdkyNobvEn83/ku62OVV3+JfZr8Bz53fw0ZsGbTRJJvT
         LBRxqQ/4cJ5NQHOE0PCwobpiYhd16O4+4c5WOuKoiZW+3mKO6SIeTfujft2bFN/NXDP6
         O7ZkNrouTZYKNJ0jlr4BxzQeu9LY0RvozQCPf2s25TtIXWvxRoqok7KeHsID+ieQU3VE
         WTUM+0hD/Zw5ginekQyrI1weQqXXsA4rm64/0IQJnbYIT2mEiKvLNDXBLlBZTfB/oCmD
         8RaW4M9xQWdYo7+AqSMbo3nmWZJjt6wo1vq7Rao9xgzpYrQImcSlL0kaLOBzGS9lEYl3
         fi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692914909; x=1693519709;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/ZJMq7ftE/nn0+jpSF5qBTmT3JWpquYk83761itMQ0=;
        b=Xrm4B5FX5vEktSxsZzfDAO+fdFzrtXC986JdL8uxGy4XqFvhXnlK/9MbewCbctay1H
         RL2leiBFNO79RDedAPwyVMayIcpLyTaTmIAR2kqfjGqUdAHhXciWMTUMx32Bg79yk6lb
         405ZA6wSXpMhrxYCTGTXDJET3xEjHKEcL125zqd2S58SFagSzGKv3O6CPnGK/JFADBeB
         3PKxmYqbJOcs+s4619F71NkAIKOPd4BiRKia6jp6YOkzwJeiz8eiK7gx0KpGOok9dGml
         vsRDIjrfTEXuwCQeP5KXvxVDUg2p6L9/1K5IZD2OQ8+aI5dQZfFaLl6cmXFuuhwfl6Hp
         8Zuw==
X-Gm-Message-State: AOJu0YzyLBvTBRFZhpv9khEF8M5a30Yra9VlBAGFP7qLFRIB3Go3ZiLk
        Ibl4FgxpnCTE7i/ChqglfhclfVZZBuePtL1x4jkz2txq0Ic=
X-Google-Smtp-Source: AGHT+IGaWdCseByAoWTk190L3xkTwNsKrEQ+DbDOG3bw3R0b1462digLT4hzFT88C6P5D/pMarpDID+4o1mOJu4Hrxg=
X-Received: by 2002:a2e:a310:0:b0:2b7:3656:c594 with SMTP id
 l16-20020a2ea310000000b002b73656c594mr13622983lje.3.1692914908667; Thu, 24
 Aug 2023 15:08:28 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Podtelezhnikov <apodtele@gmail.com>
Date:   Thu, 24 Aug 2023 18:08:18 -0400
Message-ID: <CAJU=AjWatV6A5Vx-yqRfG=yeUWxMvKocc4nTsdq58WHjaYFEzw@mail.gmail.com>
Subject: confused git diff -G
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I find this sections of the docs confusing:

git diff -G (https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/diff-options.txt#n656)

 I do not follow why the example talks about `git log -G` and commits.
I see that thai file is included in git-log .txt but I do not
understand how to use git  diff -G.

A.
