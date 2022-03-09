Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD9C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 07:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiCIH64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 02:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiCIH5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 02:57:36 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BACB1688F7
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 23:55:56 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so1869923oot.11
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 23:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/4zf8tr8r2ndNxrHg3YadfgWOE9LNq7nqqBNm3yzpuc=;
        b=k+BRfjRbVlCQlk7NDU3v/0R0gPGv4R4DVbWX14n9Ys/lz2ZohGcyFjWA4YzJ/5RKB6
         OE7svpjJV6awTQHPCoPo7KD5YQmjwNSEZfBRlTDx7D7rIpz78GulrNXtDtIMrOAZH2Be
         APQtXGpeWE+bOKyLuVxL9V0zqFbeVqi5kC4v1iZfOWOZf6gTgE2jBqzArUQPLWAjEh+R
         sfmUW/dpwoH7beZddu1ZxSDMskvtTy1/RqaSfnMe1Vdqfph4tIFNOfRTwP4rY6nU68Ko
         po6oAqScobtRvRjGBsDX73JaP/eU/HI/Ma2AaL+07Tod4Rm1tCbjoh0S3tVsW7kgAIxn
         PyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/4zf8tr8r2ndNxrHg3YadfgWOE9LNq7nqqBNm3yzpuc=;
        b=MSgMpQofwiZkVR1ypMFxXbEeYG0YR9iPrylWxp0atIa5DiDfuShFLO+Ejp3niFIVtq
         lsdpLRk+TZPewQTaXjidT9bm+W7+wv3iZ7PJJVZKx1E5qijgUDOsaJ9du3QQaB199/V6
         gEBDcFyiHLgnMuxVuZKubr65yGArP+LjPDQpz1QADjYiW2JMGJb0jo32LJ28WQsi0AhM
         rcJ44fRwesPBfvgA/WMtwexg6y4lFHjeODegFwtk3vcVE+e0XpVNH6zGWKcSU2YckpD4
         Ai3M8m0l3or8MWTrIm0KWNSA2cFU8F/Zh1TAycz5w4kEXzCXrEriNdEzoqTwF/7+3mhU
         lYCw==
X-Gm-Message-State: AOAM531m6K34gMsn24LVc39s2oVIYW+kwQWG59yIYNNoJPe2y7bWyRQY
        4TBY+KknhoeoI1PrxHkxXYcHJmVV5BbgpPft/jXp1g5GBEo=
X-Google-Smtp-Source: ABdhPJwwg5yNjGvp1hsknyH61MnC6omllqxFwmTKxjgy4sXbl3v3Y6NRaqSgXooyKRbnS7AsTg9zuijk593Yyuv9FoY=
X-Received: by 2002:a05:6870:f713:b0:d2:8adb:aaeb with SMTP id
 ej19-20020a056870f71300b000d28adbaaebmr4635140oab.111.1646812555424; Tue, 08
 Mar 2022 23:55:55 -0800 (PST)
MIME-Version: 1.0
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 9 Mar 2022 15:55:44 +0800
Message-ID: <CAJyCBOTKq3t=QtynBMrHvP5__FfNpoeUJ7t8xMv-3zTbv4yU7Q@mail.gmail.com>
Subject: Add an OPTIONS chunk to Documentation/git-sparse-checkout.txt
To:     Derrick Stolee <stolee@gmail.com>, vdye@github.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm wondering if we could add an OPTIONS chunk to
Documentation/git-sparse-checkout.txt?

Cause when I was skimming through the SYNOPSIS
and it says "git sparse-checkout <subcommand> [<options>]"
but I didn't quite see the options until I read into the COMMANDS.

Perhaps something like this:

OPTIONS

    --[no-]cone

    --[no-]sparse-index

    --stdin

If this is okay to do then I will try to submit a patch later :)
-- 
Thanks & Regards,
Shaoxuan
