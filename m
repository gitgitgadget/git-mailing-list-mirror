Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8864CC4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A065611AF
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 14:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhHVOU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 10:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhHVOU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 10:20:28 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925BCC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 07:19:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s3so26316439ljp.11
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bdU/pF9nELlGne8urTm2u3eB8QqqBzKlvB0+iIssvJ8=;
        b=RjV7kjeXMdU/7uygU5QLcDdjyhdu52Ovjwuc7JUAy7m3qfheVS2sMl92+5Zhmo+6vH
         3sAbNJ4hkQt9lPvNa/XwtIbbX2Jp1KfxmRRtQdQqyJafw5d7bgCEndti0Q1H8NYRl2q2
         z+b/sBa/l2ZiEewvMf1yHvgZjkitHjswazlxRNT7OcK8PReiGzuBIWmtf9OW3qYe/kAt
         Ucm+FTJeWFohdDZoAfVSlsDOJ/SH/WycYp5J76R4z24Bl1vxFTeixfLjUd9o6Ru/FLoN
         pfukGduLrhkyXo5Daxcx1WGas4M/JZNNfoX4IE5v5al7HbiyE5vyP3fKLPL4Chn0qhMd
         8hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bdU/pF9nELlGne8urTm2u3eB8QqqBzKlvB0+iIssvJ8=;
        b=L4+Nald+ueqOUyj8ElxBY32jYfCtmS458Ja9Dnj80b2yhFrE/xROPBfPzOsF5BWRwn
         ILFcXkeGXYO2J4jz9bMuCp5WB3NhClqwDy3BAPB5eOzuz7JQwxOUSc5Ej+zt5mU6SdJi
         lV1a2ppq1iEv5nVcWlBbjVSH1KxZ7LWxsiuBBc/y1cfVh0gcGrwVAAcGDxKS2y2VEn80
         iqtFf1rVXJXSdyxZOYsoleo5zhhvjLDWntMurARkoYfqO0KpxePliddwoQ6y+qDAyUqm
         CE92+pG5GjgPynBA4Z4s2GnmISSrkx601r/4BQUhx2Nct5t/iC2TJ5oCV+2woj8iYHV/
         X3dA==
X-Gm-Message-State: AOAM533Th65PFpsFyOrNq9ZWIhBlIaVDiDRlKbUWX6Viz2hn9GSf6DKb
        +urKAIdxTT/qX4hH/PWeyi7zBhq/Nt+sfPIBO8tZQ7orgCk=
X-Google-Smtp-Source: ABdhPJwO5gWco2lFvkeOM44iy7yxeR4h8UgJlcMvo2VH+278qiC9zluJ7mnIJ7USZeG4IYs/WjN5LE4d57k1BzqfMuk=
X-Received: by 2002:a05:651c:1143:: with SMTP id h3mr23496445ljo.300.1629641985684;
 Sun, 22 Aug 2021 07:19:45 -0700 (PDT)
MIME-Version: 1.0
From:   "Daniel P." <danpltile@gmail.com>
Date:   Sun, 22 Aug 2021 20:19:33 +0600
Message-ID: <CAL-s8C7makcRT_ufsv4THSrKeDkXfhFoAXSBKSiK5w0anMvZag@mail.gmail.com>
Subject: Git is removing . from the last part of user.name
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If user.name's  value has a . as the last character of the last part
of the name, git is removing it from commit operations. But git-config
shows the .

example:

in .gitconfig:

[user]
    name = Daniel P.


`git config user.name`:

user.name=Daniel P.


from `git show`:

Author: Daniel P <danpltile@gmail.com>
