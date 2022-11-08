Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A5C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 10:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiKHKNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiKHKNd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 05:13:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE0F62EC
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 02:13:32 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j15so20169003wrq.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 02:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M3Ao1UJnlYWMdcNZLT54KHSEIjsAu7+lJ82ENGoeHYo=;
        b=MIaWk2v/lY1mBFavT4PWR3fXoalNlWll+B6JYe8QN27M4dF9XBUZBn96pNHGLe5J1G
         Isyb2rZBxesoQtgDlLSajeYVgqalvM4kmOLd+2PfF7GQ3FBRZCaRphsY+Lu7BkTyxszt
         xm8wss+UqLIhJrc4TmYluPTOmK+m1jhKw/f0De8HXTF0rQhnXHQ9tTTEfibn0ZK94cQX
         BboLGdfo85cyCAoyTUdTygBADrsESgpsDkk0NQQUInu9mu2LT/p0JXDeX8kEjcmGhQNt
         kifpYKNaaphFHyhn3rkMpZrBDHU39w2gSOeYRHDh8xf4u0zAI9n0glmMfByCcl/oiUrw
         1cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3Ao1UJnlYWMdcNZLT54KHSEIjsAu7+lJ82ENGoeHYo=;
        b=GYZek815GmUSpC/i2O7p8aIeUUgjtITVjDdcfOi+yRMJSOJAHocIfBBNVgNI84VJ/X
         41UPxhEssdDr02ul55ovK2JxQ6s8t20Woqll6DgHCSTB0AC1BQapcntUCEdKOuhXVoj9
         g/OC8P+0QveY7n0yxc0DQ1KhUEt0o6p3VadGvMZx7vfHi4Y6pb4ih3f3ZNcOwF5g8XIn
         uwlV5RaGQnruOX7keK4l57vjj4ktwE1YhOu7/atpBuoZuiXsKmiLejXjFZ9yRM7hd0WL
         idzDD/buDpT0l3nGejimEnjrjh9t5u+Eso8ZSzl0adDlgyUyJT1uws9t4MAleT7pQiNQ
         EpTg==
X-Gm-Message-State: ACrzQf3Sp6ixSSs07fs5UQ00eaz+EwF9AOTyYqx2tryaOpDKhN74q62V
        5T44OYXRWOx2dk8e0jCgqTRWHKAUlrY=
X-Google-Smtp-Source: AMsMyM6J2LxoFufi4WpT7rnhqH3fE5m+xy9y3Sp2pfg4q6y3EbQ7a8mosOZU5Z3EvmCQfk3zo41G9A==
X-Received: by 2002:adf:ec8b:0:b0:236:6f30:924f with SMTP id z11-20020adfec8b000000b002366f30924fmr35009785wrn.230.1667902410617;
        Tue, 08 Nov 2022 02:13:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2-20020a7bce82000000b003cf7292c553sm10665223wmj.13.2022.11.08.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 02:13:29 -0800 (PST)
Message-Id: <pull.1387.git.1667902408921.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 10:13:28 +0000
Subject: [PATCH] ci: use a newer `github-script` version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The old version we currently use runs in node.js v12.x, which is being
deprecated in GitHub Actions. The new version uses node.js v16.x.

Incidentally, this also avoids the warning about the deprecated
`::set-output::` workflow command because the newer version of the
`github-script` Action uses the recommended new way to specify outputs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: use a newer github-script version
    
    I had a look at the CI run of seen a couple of weeks ago and saw not
    only quite a number of failures but also quite a number of warnings.
    
    This patch addresses a few of them, including the ones about using the
    deprecated ::set-output:: workflow command
    [https://github.com/gitgitgadget/git/actions/runs/3412982102/jobs/5679166059#step:4:46].
    
    Similar warnings will be addressed by
    od/ci-use-checkout-v3-when-applicable.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1387%2Fdscho%2Fupgrade-github-script-version-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1387/dscho/upgrade-github-script-version-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1387

 .github/workflows/main.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 831f4df56c5..cdfb777a699 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -37,14 +37,14 @@ jobs:
           echo "::set-output name=enabled::$enabled"
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
-        uses: actions/github-script@v3
+        uses: actions/github-script@v6
         if: steps.check-ref.outputs.enabled == 'yes'
         with:
           github-token: ${{secrets.GITHUB_TOKEN}}
           script: |
             try {
               // Figure out workflow ID, commit and tree
-              const { data: run } = await github.actions.getWorkflowRun({
+              const { data: run } = await github.rest.actions.getWorkflowRun({
                 owner: context.repo.owner,
                 repo: context.repo.repo,
                 run_id: context.runId,
@@ -54,7 +54,7 @@ jobs:
               const tree_id = run.head_commit.tree_id;
 
               // See whether there is a successful run for that commit or tree
-              const { data: runs } = await github.actions.listWorkflowRuns({
+              const { data: runs } = await github.rest.actions.listWorkflowRuns({
                 owner: context.repo.owner,
                 repo: context.repo.repo,
                 per_page: 500,

base-commit: 4732897cf0a255a23dca9e97b65cea40cd06c5a8
-- 
gitgitgadget
