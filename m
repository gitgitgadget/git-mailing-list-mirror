Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A83FC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 19:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjAITrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbjAITqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 14:46:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659FB7A39C
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 11:45:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ja17so7074142wmb.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 11:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3sKx5yZ33BnAB2CYC+z9WaSCCvzxjl3M1AwV9eL9io=;
        b=EH7cWK7g9aVfJjuuX0zz6g/H9leDTUG3O1sltB3LeLgvK5l+ad00uWCKn+eDawjyKA
         JZrV4ww/YzbMgWw3yWWGGvdsYz//xPkRTjObp+ehLHV10Wgch8jYmX6m534SN6JGX8mQ
         ztU4qvAqwleX49Lq73v6MGA915dLRwucDPTUNdVPdPsDvJmBn5Z7F1ZXNr2DPBJP1bkd
         vhvnpwZZ/vWR/FEe8Bgy8xSz5fuCE3iDrgH4v6+jiQMuGkLcSP3PS/J2yl4b8/HPR0Tw
         mpqZ+V1RPieLwp43OjkdD6dH8tMhwStTB1F601z2ifzsidvdfH8Rd4QzXx7sVcwVsi+P
         e88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3sKx5yZ33BnAB2CYC+z9WaSCCvzxjl3M1AwV9eL9io=;
        b=l2ycSwHya5td6BuFS0Z2cSh7PEbirN9wUQ6kBkFGtRHLazS07joIM2BMLvm6g+N16Q
         maJ68lTcWCC8vsvmphVv0iHowwJmeGUMIktynJFukR7hCNG5wftv9RguwcUV0VkYGAzV
         XjAMZJKhMXAB90kMBeED53G6RC6/CIixuiMvnPi7dToeKMydgNRaGxqPItmWBcdJvHTm
         I5AnvLKqVRqsty9/X9Mj2mwQunr2RYfq3EpCSNRhi3Q83S5ZPqKJE6Qojn77QRVnLmO9
         KfmdUtbCv27e4IbPShRLDiKh+XmA1jstmrTxzxYKdrb9L2l9YeP6YBRHuhUMU5LyK1Tf
         Nq4w==
X-Gm-Message-State: AFqh2krX/bZRH7iMXtmcDxyWyMLsM80PvdY7vmKZplUJ300EHyHeCoKI
        9sfkMVtAbkIeUcurRIf9GMq+wwaZTNE=
X-Google-Smtp-Source: AMrXdXseW2ecPaUmyZH5eyDjOcjJ52AsbBdpmDk5t/N18a62jleI9bRI8O2DVGnq7V4Bc7v+hVbzeA==
X-Received: by 2002:a05:600c:44c9:b0:3d1:f6b3:2ce3 with SMTP id f9-20020a05600c44c900b003d1f6b32ce3mr57015987wmo.35.1673293509676;
        Mon, 09 Jan 2023 11:45:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003d998412db6sm18228714wmn.28.2023.01.09.11.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:45:09 -0800 (PST)
Message-Id: <pull.1457.v2.git.1673293508399.gitgitgadget@gmail.com>
In-Reply-To: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 19:45:08 +0000
Subject: [PATCH v2] githooks: discuss Git operations in foreign repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Preston Tunnell Wilson <prestontunnellwilson@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Hook authors are periodically caught off-guard by difficult-to-diagnose
errors when their hook invokes Git commands in a repository other than
the local one. In particular, Git environment variables, such as GIT_DIR
and GIT_WORK_TREE, which reference the local repository cause the Git
commands to operate on the local repository rather than on the
repository which the author intended. This is true whether the
environment variables have been set manually by the user or
automatically by Git itself. The same problem crops up when a hook
invokes Git commands in a different worktree of the same repository, as
well.

Recommended best-practice[1,2,3,4,5,6] for avoiding this problem is for
the hook to ensure that Git variables are unset before invoking Git
commands in foreign repositories or other worktrees:

    unset $(git rev-parse --local-env-vars)

However, this advice is not documented anywhere. Rectify this
shortcoming by mentioning it in githooks.txt documentation.

[1]: https://lore.kernel.org/git/YFuHd1MMlJAvtdzb@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/20200228190218.GC1408759@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/20190516221702.GA11784@sigill.intra.peff.net/
[4]: https://lore.kernel.org/git/20190422162127.GC9680@sigill.intra.peff.net/
[5]: https://lore.kernel.org/git/20180716183942.GB22298@sigill.intra.peff.net/
[6]: https://lore.kernel.org/git/20150203163235.GA9325@peff.net/

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
    githooks: discuss Git operations in foreign repositories
    
    This is a re-roll of [1]. It incorporates a refined version of Junio's
    suggested improvement[2].
    
    [1]
    https://lore.kernel.org/git/pull.1457.git.1673171924727.gitgitgadget@gmail.com/
    [2] https://lore.kernel.org/git/xmqqwn5wuwvs.fsf@gitster.g/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1457%2Fsunshineco%2Fhookenv-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1457/sunshineco/hookenv-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1457

Range-diff vs v1:

 1:  b9a2e23359a ! 1:  d58694a4137 githooks: discuss Git operations in foreign repositories
     @@ Commit message
          Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
      
       ## Documentation/githooks.txt ##
     -@@ Documentation/githooks.txt: Hooks can get their arguments via the environment, command-line
     - arguments, and stdin. See the documentation for each hook below for
     - details.
     +@@ Documentation/githooks.txt: repository. An exception are hooks triggered during a push ('pre-receive',
     + 'update', 'post-receive', 'post-update', 'push-to-checkout') which are always
     + executed in $GIT_DIR.
       
     -+If your hook needs to invoke Git commands in a foreign repository or in a
     -+different working tree of the same repository, then it should clear local Git
     -+environment variables, such as `GIT_DIR`, `GIT_WORK_TREE`, etc., which could
     -+interfere with Git operations in the foreign repository since those variables
     -+will be referencing the local repository and working tree. For example:
     ++Environment variables, such as `GIT_DIR`, `GIT_WORK_TREE`, etc., are exported
     ++so that Git commands run by the hook can correctly locate the repository.  If
     ++your hook needs to invoke Git commands in a foreign repository or in a
     ++different working tree of the same repository, then it should clear these
     ++environment variables so they do not interfere with Git operations at the
     ++foreign location.  For example:
      +
      +------------
      +local_desc=$(git describe)
      +foreign_desc=$(unset $(git rev-parse --local-env-vars); git -C ../foreign-repo describe)
      +------------
      +
     - `git init` may copy hooks to the new repository, depending on its
     - configuration. See the "TEMPLATE DIRECTORY" section in
     - linkgit:git-init[1] for details. When the rest of this document refers
     + Hooks can get their arguments via the environment, command-line
     + arguments, and stdin. See the documentation for each hook below for
     + details.


 Documentation/githooks.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c8..62908602e7b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -27,6 +27,18 @@ repository. An exception are hooks triggered during a push ('pre-receive',
 'update', 'post-receive', 'post-update', 'push-to-checkout') which are always
 executed in $GIT_DIR.
 
+Environment variables, such as `GIT_DIR`, `GIT_WORK_TREE`, etc., are exported
+so that Git commands run by the hook can correctly locate the repository.  If
+your hook needs to invoke Git commands in a foreign repository or in a
+different working tree of the same repository, then it should clear these
+environment variables so they do not interfere with Git operations at the
+foreign location.  For example:
+
+------------
+local_desc=$(git describe)
+foreign_desc=$(unset $(git rev-parse --local-env-vars); git -C ../foreign-repo describe)
+------------
+
 Hooks can get their arguments via the environment, command-line
 arguments, and stdin. See the documentation for each hook below for
 details.

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
