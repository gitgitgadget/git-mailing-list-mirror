Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03232C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 06:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJ3Gsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 02:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJ3GsS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 02:48:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F6B273D
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 23:37:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d26so22216824eje.10
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 23:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIR8h35mvF6Cg7PnWw8tsGB5mhKXNygFup/ve1SSGbQ=;
        b=WvAukPysEvqY9U4eqc7LU0aJVsyfQ3vMoaCpQFCPNRxn7hZh2FmtqhigTKg14cvdec
         WSXbky0JcSq28S5TeCWbHyscsBa2JY8dC+tUK0JGiE2SFCjnRhPMiFaETg3mSMxeEPJm
         gzFjIAC+NgwI5M9Al8+/9NPas2eOfownDwlYI+X/uwdxNM4uUGw5UIzPwdWvU8jXBLae
         b7DVtReIhqIcHz4460S8qunLpDTFuuqy7wwoowEOSKD9EDFSq4lzrvmEwirLpOVWLD5F
         Cz3BQS4UHhoGHabbcLOTN+QlV7Mp/khahLIVofDl+bhdEWJUoF9G1h8yZfZninLbrvS7
         jm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIR8h35mvF6Cg7PnWw8tsGB5mhKXNygFup/ve1SSGbQ=;
        b=UXw4uyMlMpL4q8VtT0WVH/GTX71FQY8xCFpJ7NKjLabyttSQaMZCcz7Aw81W9jvjC+
         BaXu1RSYfc9mOZu/jwZbEVJZ4m2Kx9AFxlkpJIKkmE9Gly4WmCERa11Hxph905q8T6Yz
         oe557NzcgXWsXUX5cv35Jd31JHFJulk3n4b3ffRaZg1rwa2VxWY/U4VFV7zMmr89uyTI
         zpHLYkKpsdrizqz5urrsEL9DoCym9Z4h2KbJhwUOPaQIf4vfz9LP2Bws98AXmwjaPNDA
         KsXZ4f7zMqJoumA6XTST6M7dXnMwlGRaZE5lgDikxt6qMbMYl7o1Bs5pU+XbzCjRwC8T
         sSaA==
X-Gm-Message-State: ACrzQf0Eo5PEMp8LfAx2QncFYxz4dNefYWYgnqQ6g8ztNfRB3mYDokqz
        hiRYJSMgwKzcNEDoRWn6Gq7i6Y89/TrHoy9mosQ=
X-Google-Smtp-Source: AMsMyM6tFADyaXYnyRnSwbBP+mlwIS+DNLKCsakAjkS8SvI7OwSTaxYPGh9aOrWzxWIL0ZlmB1Kf+f75En1dTvL2TU4=
X-Received: by 2002:a17:906:cc0f:b0:7a0:b91c:855f with SMTP id
 ml15-20020a170906cc0f00b007a0b91c855fmr7200425ejb.26.1667111757239; Sat, 29
 Oct 2022 23:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
 <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>
 <xmqqczbdl6wl.fsf@gitster.g> <CAPOJW5yxRETdVk014gQYFud9_Nrt+OQGSVNQ8Pw2wDEMMFMm1Q@mail.gmail.com>
In-Reply-To: <CAPOJW5yxRETdVk014gQYFud9_Nrt+OQGSVNQ8Pw2wDEMMFMm1Q@mail.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sun, 30 Oct 2022 12:05:45 +0530
Message-ID: <CAPOJW5z_ZRChNo8PGBmJu=vvjTL2cYL8oTdVwoDRh-UHt2Dy4w@mail.gmail.com>
Subject: Re: [PATCH 3/5] roaring: teach Git to write roaring bitmaps
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

It has been a month since I didn't get involved in any open source
contributions (including Git). This is due to the fact that I was
focusing more on mastering theories and also that it was a festive
month. So, I am now resuming my work. There are many things I have to
cover (including this patch series).
But before that I want to ask you a question - As you have noticed
already, the Roaring library has a lot of styling issues (Moreover it
is using C11). So Should I fix all these issues? or Should I make a
new library (using Git's compatibility library "git-compat-util.h") by
taking CRoaring as a reference? The pros are that it would be easier
to format the bitmap library specific files and it can use Git
compatible functions.

I would love to hear your opinions. Thanks :)
