Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0998DC67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 22:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiJXWAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 18:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiJXWAb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 18:00:31 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2B6335
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:14:23 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id k8so9162548wrh.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlQSiLtbi0RlDaWNAPZHvTvJPixAwsGGjeelhDvJ/C4=;
        b=fYhAxvCQkxcOtCraqh/Ulp6witp8Fcp/R5PwKipB93HjPBKBOrljeWGlMv2L3w70pD
         AWlFG+lJdGPCCj+KVsDlOAYlTur5zabUl4BjphjRNLFnRqS1x6a8ng1ne4Yt55oxO0dx
         pYr8vP9+KNyHs63zLFrVQ/YBp5ki9YXrFa1qf37dyClKuB4MHRyJHZka8BvP5g2Z6f5f
         BI8QQhSvtGwqDSKym0dX6dH6uP0wnWwdXcG0iX/XPaLhoDCF7PCVgcxhs3ExzCroEc4H
         t0tP3R8NgRs4GBez4PNwR8M9U85tknwRuSacWUe19ODTL7zt/MctXkFUn8tkwh14OLl8
         eI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlQSiLtbi0RlDaWNAPZHvTvJPixAwsGGjeelhDvJ/C4=;
        b=ggzk4KrL2jQ9tr0+OErAoq+KM/V4Ly/c9xhEsnG+GEcXtvZZK4byd/h++Rq+xYUgi2
         nHyj/nuQaG6kWzppiM92KXyqj83IADI863zhdIbCpc7bRWejXnYZekVuzeEO/BHE+qNP
         23F0AefsYbT3BlT9zb1nb0zEC77sj5PobCDQTy9wK6S1v8+o13VY6w9LGZhzSIujbYKO
         LgEgHC7/BXv/T3WmYgJKYTeZJIl1g4bkRRA/A8pT96F9/YFezXWJkrPLEkb8//idTNFG
         6PPDkoQ1nnHKFgGwojIgsFOCoqmN7FV2hsdHLaFFkEsXhdry4xpJZVufcTnStNe1IbVd
         1Lqg==
X-Gm-Message-State: ACrzQf0RniIevq07JgIM7PJNRsGTJ6hAEM/DRSqHvKidKFCTKzdstiV6
        GcqIPUD+UEbgl4pvoIagF6z4LalGt9w=
X-Google-Smtp-Source: AMsMyM4vVxZ+0+hzGniPwTX+lU2r5Juqko8U7V5RuTGUmPQ9l1AZrEBMIfRcr41HDciSHrTafNRgXg==
X-Received: by 2002:a05:6000:144d:b0:231:5786:f763 with SMTP id v13-20020a056000144d00b002315786f763mr22605034wrx.313.1666642066734;
        Mon, 24 Oct 2022 13:07:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003b4ff30e566sm20970wms.3.2022.10.24.13.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:07:46 -0700 (PDT)
Message-Id: <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
References: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 20:07:38 +0000
Subject: [PATCH v5 0/6] patch-id fixes and improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches add fixes and features to the "git patch-id" command, mostly
discovered through our usage of patch-id in the revup project
(https://github.com/Skydio/revup). On top of that I've tried to make general
cleanup changes where I can.

Summary:

1: Fixed a bug in the combination of --stable with binary files and
header-only, and expanded the test to cover both binary and non-binary
files.

2: Switch internal usage of patch-id in rebase / cherry-pick to use the
stable variant to reduce the number of code paths and improve testing for
bugs like above.

3: Fixed bugs with patch-id and binary diffs. Previously patch-id did not
behave correctly for binary diffs regardless of whether "--binary" was given
to "diff".

4: Fixed bugs with patch-id and mode changes. Previously mode changes were
incorrectly excluded from the patch-id.

5: Add a new "--include-whitespace" mode to patch-id that prevents
whitespace from being stripped during id calculation. Also add a config
option for the same behavior.

6: Remove unused prefix from patch-id logic.

V1->V2: Fixed comment style V2->V3: The ---/+++ lines no longer get added to
the patch-id of binary diffs. Also added patches 3-7 in the series. V3->V4:
Dropped patch7. Updated flag name to --verbatim. Updated commit message
descriptions. V4->V5: Updated commit message for patch 6.

Signed-off-by: Jerry Zhang jerry@skydio.com

Jerry Zhang (6):
  patch-id: fix stable patch id for binary / header-only
  patch-id: use stable patch-id for rebases
  builtin: patch-id: fix patch-id with binary diffs
  patch-id: fix patch-id for mode changes
  builtin: patch-id: add --verbatim as a command mode
  builtin: patch-id: remove unused diff-tree prefix

 Documentation/git-patch-id.txt |  24 ++++---
 builtin/log.c                  |   2 +-
 builtin/patch-id.c             | 113 ++++++++++++++++++++++++---------
 diff.c                         |  75 +++++++++++-----------
 diff.h                         |   2 +-
 patch-ids.c                    |  10 +--
 patch-ids.h                    |   2 +-
 t/t3419-rebase-patch-id.sh     |  63 +++++++++++++++---
 t/t4204-patch-id.sh            |  95 +++++++++++++++++++++++++--
 9 files changed, 287 insertions(+), 99 deletions(-)


base-commit: 45c9f05c44b1cb6bd2d6cb95a22cf5e3d21d5b63
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1359%2Fjerry-skydio%2Fjerry%2Frevup%2Fmaster%2Fpatch_ids-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1359/jerry-skydio/jerry/revup/master/patch_ids-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1359

Range-diff vs v4:

 1:  321757ef919 = 1:  321757ef919 patch-id: fix stable patch id for binary / header-only
 2:  ec4a2422d5b = 2:  ec4a2422d5b patch-id: use stable patch-id for rebases
 3:  81501355313 = 3:  81501355313 builtin: patch-id: fix patch-id with binary diffs
 4:  bb0b4add03c = 4:  bb0b4add03c patch-id: fix patch-id for mode changes
 5:  b160f2ae49f = 5:  b160f2ae49f builtin: patch-id: add --verbatim as a command mode
 6:  dcdfac7a153 ! 6:  eef2a32f008 builtin: patch-id: remove unused diff-tree prefix
     @@ Metadata
       ## Commit message ##
          builtin: patch-id: remove unused diff-tree prefix
      
     -    From a "git grep" of the repo, no command, including diff-tree itself,
     -    produces diff output with "diff-tree " prefixed in the header.
     +    The last git version that had "diff-tree" in the header text
     +    of "git diff-tree" output was v1.3.0 from 2006. The header text
     +    was changed from "diff-tree" to "commit" in 91539833
     +    ("Log message printout cleanups").
      
     -    Thus remove its handling in "patch-id".
     +    Given how long ago this change was made, it is highly unlikely that
     +    anyone is still feeding in outputs from that git version.
     +
     +    Remove the handling of the "diff-tree" prefix and document the
     +    source of the other prefixes so that the overall functionality
     +    is more clear.
      
          Signed-off-by: Jerry Zhang <Jerry@skydio.com>
      

-- 
gitgitgadget
