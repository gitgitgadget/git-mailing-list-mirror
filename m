Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20562C54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 19:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjAGTjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjAGTjX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 14:39:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B62D40C23
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 11:39:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so5918973wmb.2
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 11:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=APht9A2qEu0VSGqvKdc/0uuDuE7XSpZZhogf4Srq0jk=;
        b=V0sr2+5jX5F26RlUgJrjUNOXRZ64Mq8zmRrR9HqJFJSAm+yPCUMQxinj9sJkoJNuMB
         pKiAcNBTOIUZXs559q0o9BzLXwn1WEMut/V+Pn/YNcqjF5pKeXLbh7khe6xgExvh18BV
         +s82v0S43whrTw2IrPDkVJtAyrNP/Aqk5V3VEmnctMT27Yd/8JUbymAhXgQTv+L+pgrM
         t993ed7agIwaoWUWGx9Pl+QaPDoKrCU3y0Qrd2MMNRD8Pfg0uFqJ4e4+w16z/AQeksdR
         l/LBWHmgwBUrO5aDcGbSPjDIBL7uYdslM1mVHBbUiIklOhgFGBJQkqa8Y+uOcVRVgd8E
         /uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APht9A2qEu0VSGqvKdc/0uuDuE7XSpZZhogf4Srq0jk=;
        b=KcIcaGq8CiUfIvgWptkjWE2x1VeCNWd1dc1I/wiFBW9weOwhlkcSGxZJCo79BC6Vn9
         seY5uEcOGkA5Vue5TmhaCPVpPsFaDb8dycocqAjIE2u8bbIWkdkhAz4I8b4bXSKzjB20
         rt7o3chmkBj2/86YVy2jGkv9IGIJmGdv8OL+OYS0Pg0oyVpdE4TYvsVJR2bU0oo0nyqb
         inOBEYulyVz8C33rjoU1npjpnJg/cB9LWyQVsEHBaUMwaZSbia0tqS9QuQcmIhKyOeCt
         e9i7GMDpbURR4CWoyNbuBASC71++nQHgevub/tbSjpFlR3LLnuDrp/v3UZkS8jRQjpoC
         UXqw==
X-Gm-Message-State: AFqh2kpCCK7t3MSS7lHbBF1XHUFs0GDhihiCEU03tBBD8+P8PxNsT053
        ceVk/6/AGXs1h1itOt96EDM8jQF7rKo=
X-Google-Smtp-Source: AMrXdXuJ/zDjjtuJSPJFqxS0rs2In9xYKzKynwOaOXam/95nPllTNXtY3SkxOHQT+BDer6I0RuyHWQ==
X-Received: by 2002:a05:600c:4e08:b0:3d3:5c21:dd9d with SMTP id b8-20020a05600c4e0800b003d35c21dd9dmr42195880wmq.19.1673120360576;
        Sat, 07 Jan 2023 11:39:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003d1f3e9df3csm11520391wmo.7.2023.01.07.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:39:20 -0800 (PST)
Message-Id: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Jan 2023 19:39:14 +0000
Subject: [PATCH 0/5] Documentation: updates and a correction around 'ORIG_HEAD'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series' initial motivation was to clear up a confusion that arose in
[1] where it was noticed that 'ORIG_HEAD' is not guaranteed to point to the
original branch tip at the end of the rebase if 'git reset' is used during
the rebase.

Patch 5/5 adds a note to 'git rebase's documentation to make that explicit.
When taking a look at the existing documentation mentioning 'ORIG_HEAD', I
also found an error in an example (patch 1/5), other small inconsistencies
(patch 2-3/5), and a potential improvement (patch 4/5).

Cheers,

Philippe.

[1]
https://lore.kernel.org/git/1b2b8e98-5506-a1e6-6059-a967757b3bb8@gmail.com/T/#m827179c5adcfb504d67f76d03c8e6942b55e5ed0

Philippe Blain (5):
  git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
  git-reset.txt: mention 'ORIG_HEAD' in the Description
  git-merge.txt: mention 'ORIG_HEAD' in the Description
  revisions.txt: be explicit about commands writing 'ORIG_HEAD'
  git-rebase.txt: add a note about 'ORIG_HEAD' being overwritten

 Documentation/git-cherry-pick.txt | 2 +-
 Documentation/git-merge.txt       | 3 ++-
 Documentation/git-rebase.txt      | 7 +++++++
 Documentation/git-reset.txt       | 3 ++-
 Documentation/revisions.txt       | 3 ++-
 5 files changed, 14 insertions(+), 4 deletions(-)


base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1456%2Fphil-blain%2Fdoc-orig-head-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1456/phil-blain/doc-orig-head-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1456
-- 
gitgitgadget
