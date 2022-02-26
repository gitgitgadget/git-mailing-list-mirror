Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C64CC433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 09:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiBZJ73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 04:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBZJ72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 04:59:28 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD02220FC
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 01:58:54 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p14so15311460ejf.11
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 01:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZA2tmi2B9ompp2ZcirVtbzoQN8NPHDXXw4L5IfWIfn4=;
        b=o4T01Px1emIVonyUqBfelPOpfCCEw47OC1PamMcdohRWtzIrUZHjDUB83Fyk/AogZY
         rxQU6pewxPQ+TnWGlhoL4vF4OHd/0+Kdx9fVelETST8ybgedM1T9qhPpusVK/SU3A6Fz
         YOVoSLQqkOJPUeWz4fvOKme38/HRAAlD1tpWQj5piDm6xDmxN/Qfqz/LJAVBckmaivG0
         +GKn6JeLlDKF4MfmwVSw8xDVe2vd0A/90ChJvYNOO/R8zgtqastTxGfSgMvJR2dwLRLH
         yVFa20sPskccdOKNdqH/pfrRpdMVVscw0xPwtGQCv+VFRm5vBguFaK2wqQvG/JTYmzF3
         gFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZA2tmi2B9ompp2ZcirVtbzoQN8NPHDXXw4L5IfWIfn4=;
        b=bI2dgwcGvizIR8yThHg/119lpH31BuOf2Uc9Ci67q8uTCH+pYab5zM1bQmKLkorOru
         JiO8I3lv+IrYIG3et0JndugEgHKZrkw3cL+CEdyDOT9bAa9v/JF7Eou5LrLtCDH9oyGZ
         FrxjHhWswv0Hol3RlH1eXFo9zVxtAf2zb0uDADibg3pyvKLOjdAQ7wmbgc+Jb8dvIDF3
         zbIz6OJ+v2Rj6i1aEG7TXDPi7XYpZmyQrFFdHRSnNWH3PfZpZx7PgSx0iYdrvnFKOs6R
         7W36YoSn+WST/n/ROKjf1rFD1M/9z9oUNBfaUtE2tkDLTJ/hB35FTRUNKQSKQb34pLit
         3zLQ==
X-Gm-Message-State: AOAM532uQ2q6rhT63LxHXH9uPBcfYjVVHEIUWgwV85E0fy+Kw5EIrgA6
        psPAiXeiPNI2zuGr53udFNC9XwzphS91A+bUMziaajGU0IE=
X-Google-Smtp-Source: ABdhPJzpJ8BGvGGLBhHkvCOI1fLPQpNUl5DK5MuE8uGTOCHiAo2NMCTpVxEC1Mwu3RuEFAyKDAIVll9dNx4DCo8MBec=
X-Received: by 2002:a17:906:af79:b0:6ce:61d3:7e9b with SMTP id
 os25-20020a170906af7900b006ce61d37e9bmr9188478ejb.191.1645869532611; Sat, 26
 Feb 2022 01:58:52 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 26 Feb 2022 10:58:41 +0100
Message-ID: <CAP8UFD3U_XW2TvaX6EAQY41r0YXMbsy_1JjJPPwy4YHaC=TW0w@mail.gmail.com>
Subject: Draft of Git Rev News edition 84
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Steadmon <steadmon@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-84.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/544

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Monday
February 28th.

Thanks,
Christian.
