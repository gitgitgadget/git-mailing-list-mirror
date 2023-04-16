Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41360C77B61
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 10:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjDPK1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 06:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDPK1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 06:27:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33473A7
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 03:27:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-505934ccc35so3278074a12.2
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640822; x=1684232822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6yX2Hxl4cfwDto3EsjYlX/d6tla5hQBr8f98F6vcFDc=;
        b=GrdivUUsiQA+MllNB6+Ekl7PTQ/KwgupWjPO82OPDtfUNCpBWtWmQOujnNuMVpksDs
         uHo06qT4sYj4bMfTr4Gif13h2pDwGcI75ZkUVIA7k2fIjclUEckiKIWewh2ds9dsjlHW
         5DbsRAc6+kbY88T5H0RwU4QdmcQ46NAzLnYb1N/uWC7dq8QcE9dAtz7R0Yb24If5Vgk4
         OO8HiiGz0oesu4ibTrVDoyL6OnofmSjIDRUpJay62BW2SECHxEqbXb8vTkzMOEaGL1BK
         d02erizoP601wmzn+zQPXB7rSjerOixyrPuTe/1B8Gtmj70hM7aIlJ35fYf8E5qghFdc
         LnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640822; x=1684232822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yX2Hxl4cfwDto3EsjYlX/d6tla5hQBr8f98F6vcFDc=;
        b=MjmgbCLMJjpFY15f/vQfMPhkdfk8UYbcm83iU+oxh7eSC69/UAP1uo10MNC3C2gu91
         q2XybZfsc4vwL8o3yPb6bNxaoylTXbdDWbXc0lG9VvpwTYaYjpjk3saDluMHXJm1AAC0
         fwKqHnnmjr6U0emy+Jayhrh+N0OTxgpGxIriY52I6ZuguDc7ieT9w9Y+KUzZf4qaVRok
         L7EhjNZ/ZHdR5wsJf/Q2eUk9eh8w5wcqyoH74LVRVNv3fDqKO2vIOvhDxQmtrDPouRIG
         UYodXPY2a42B9dzjAc5hOtSSnU+vDZ7ugTGcefPQmPaVuVKA/d/s/vrCLGAoRrASeF76
         R2og==
X-Gm-Message-State: AAQBX9cDQvfrKrgQjVdcYjtO+6UyqlxX5s9IumKYmH2rLyU5rI+pap9A
        lypX/Fjio1ayYWb78zjK4lT+m7a0nbn8+SsnQoERUF61
X-Google-Smtp-Source: AKy350YV5EPAjnxZGTzTmHP+P1qn7jdwnEBXO4jysMJwvlhJtjUIU++UVJHfpUk9g/RFs5SdZ4OMUNBqIyWFwK2ZZu0=
X-Received: by 2002:a50:9ee7:0:b0:505:842:37b0 with SMTP id
 a94-20020a509ee7000000b00505084237b0mr5724348edf.3.1681640822502; Sun, 16 Apr
 2023 03:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com> <CABPp-BFCv4rk6Z3jhqCSs0p59vVdhSvdmc2kSBFUnwsCuj5rng@mail.gmail.com>
In-Reply-To: <CABPp-BFCv4rk6Z3jhqCSs0p59vVdhSvdmc2kSBFUnwsCuj5rng@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 16 Apr 2023 03:26:51 -0700
Message-ID: <CAPx1GveGz5h3xJ=603SY7G8yBFobPEY+uvLka9ykM5Z9QA_-uw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Document 'AUTO_MERGE' and more special refs
To:     Elijah Newren <newren@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wonder if it's worth mentioning that these pseudo-refs
are really per-work-tree. A few too many add-ons to Git
forget to take this into consideration...

Chris
