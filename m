Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A744AC27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjAYEEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjAYEEG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48A49436
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t18so2959911wro.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HIysfdBGbaJ/TZH6tgJAnmrhdRdwbDIiLBz1fX6tjU=;
        b=FoSkjOpDViWgi/7R0IagNa6lWxdWxQMBWTlrWjYGU5GiPw7L1h7WwsPQOSbRQp5MLa
         wY6kaI+/ry8k1Uq4dAjol5p42yjTU7/YaqIetKJqrLc16cpg6QuHyKQGeyhYbxhITouF
         IMVnEAW2+bTvQZSt0Zx/k+mCrkJ8+Nz/qBBDDHqjR7KyOIHNqX5wWK0vyiIQw+qlOHd3
         JLJVmbLKkpOUkS511GqChTGE+Y4h/UrxHb8J4MNiPQS67inQ5YWFfndwv1Q2u857a9a+
         qOcjU8zZxr8ZcSE0V7uPONMmnbRFelG95TT5WuDLBqnRcqfQgNa9JWwW0vi7Bx0747kp
         YqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HIysfdBGbaJ/TZH6tgJAnmrhdRdwbDIiLBz1fX6tjU=;
        b=BEZneBCmoSPvYedvi/6GCpJAvcie31/cXbHhyOqFQKEToZOuvpWISEDvweEsOVOZEy
         BKYGoZ62l70qU65FhIg+aYc0VNeI+VqGOrzAvENPZ3kv1PsuUEe1pRdHtbvDSgRTMFBt
         axihSQQNX27+nx5GaCrl1G9s1nngUyipiPaOL230ux8rmAN0Tu9kpf88d04UHBxNyYEh
         YsfO7Nw08qPIHmSFYNqVbszB80gCjixJQn3Vh2yv3Fs4Z/IPIT/FVZ0hhsjTX1huzIJk
         sulNeJxWWjMk6K1uJ8NaJ1H7A05DGR7TfW2HRcJfeGFig0JJfj5ajJ93k/82qP/KIjU1
         9DTg==
X-Gm-Message-State: AFqh2kpS2ablITsiJkNvcywNSvJ4yoyYHduGFDuLewF96AsrUxYiuy5q
        +rZe2qeDYWqFNX/iLcpen6EnBdhibsI=
X-Google-Smtp-Source: AMrXdXuMpHIRZUbuvBkCdnbf/K2txRWrCV3HLMyRydjrWDL7NgKlXPi5hQmdPHC4eg/icg8UOLaKmA==
X-Received: by 2002:adf:ee8d:0:b0:2bf:95cc:744f with SMTP id b13-20020adfee8d000000b002bf95cc744fmr15037170wro.56.1674619444177;
        Tue, 24 Jan 2023 20:04:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4c46000000b002bbb2d43f65sm3240143wrt.14.2023.01.24.20.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:04:03 -0800 (PST)
Message-Id: <01808cf84a887b8ec3cb7e3fd01e7ea363a1d0c9.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:52 +0000
Subject: [PATCH v5 08/10] rebase: fix formatting of rebase
 --reapply-cherry-picks option in docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit ce5238a690 ("rebase --keep-base: imply --reapply-cherry-picks",
2022-10-17) accidentally added some blank lines that cause extra
paragraphs about --reapply-cherry-picks to be considered not part of
the documentation of that option.  Remove the blank lines to make it
clear we are still discussing --reapply-cherry-picks.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d2b731bd605..99aadac28ef 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -338,7 +338,6 @@ See also INCOMPATIBLE OPTIONS below.
 	upstream changes, the behavior towards them is controlled by
 	the `--empty` flag.)
 +
-
 In the absence of `--keep-base` (or if `--no-reapply-cherry-picks` is
 given), these commits will be automatically dropped.  Because this
 necessitates reading all upstream commits, this can be expensive in
@@ -347,7 +346,6 @@ read. When using the 'merge' backend, warnings will be issued for each
 dropped commit (unless `--quiet` is given). Advice will also be issued
 unless `advice.skippedCherryPicks` is set to false (see
 linkgit:git-config[1]).
-
 +
 `--reapply-cherry-picks` allows rebase to forgo reading all upstream
 commits, potentially improving performance.
-- 
gitgitgadget

