Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B8EC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 17:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbiCORnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350729AbiCORnB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 13:43:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D021758E5E
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:41:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x15so30073913wru.13
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NQkxBxlK6Vs+UvJALa6KSU2vkODNAgOY1j+VRDD2VNg=;
        b=l5xlR4BidnvIHJwna6Gm/I70OHEHsC0wfi5gOrrElR3zn7TZEc239F8e9aYXcxWs1k
         EWo8KkD/GryogieLS0+4ExH0JW0clbzbJ4hlyNeJ01M8g4xK88Px/0A2BT3/K1HLBwMs
         +CuOf9+E7h5kCMKmkSpoQo3IRIxcNbotoPJM+ddk/oVZ3VLB8tD2L4S9U1QqSHACMmL/
         dT+a37lPvgYUd/kn88v/fUeMfHSFitvPTae66F1C6o71mwVO833Gp9a7I0mBxPN2cZPM
         /9q+EWpkDX92r8qv44Z7Ub9L+RANEivIDdv8oi9RWJxIxg4uAjQJFbvduZH8h0njoeov
         RiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NQkxBxlK6Vs+UvJALa6KSU2vkODNAgOY1j+VRDD2VNg=;
        b=cglxrL2en27hjPNqGCLpTuHzOJFO9YziLKDxmmisWTjQQlJYjFVFhhNRk70ol98LR7
         2uCHYQ3BMavnLiL21mLf58+gtFJK1LrBMBdkBvgHRv95pnlX/lER9lLxOu4tx8CMEb5O
         9P4jKCJrChN/GU3vF3qhI27mOHUqjYSyI+pCecKLHtfYdA+j4ZUJjlf5W9K4Gzk1k3Ma
         BdPV7QXjB0EHvKlE8m4ckNCdvLsghcqxghdVrCALChnP6Z3Mn2ze9YVXXlFZKZOndUCv
         qKSTaomUUEJG4ieeS+UnHod+JNWasDqbBmEZGZJTx+wH398d2qiXwa1CTYAi8MfiPod8
         I8Bw==
X-Gm-Message-State: AOAM533jYOnyW3gjsSBh/twEWvXKrmzrEsVfWe6xmfrF8ssuu/5QceMo
        JLX2ri9d+uUMnTxGKiilV1c0a/Fkm+A=
X-Google-Smtp-Source: ABdhPJxvG4IGlq96WfogP9cskciCydwaPnM8fJgG3d1BsHGASXi7TLkNq2rgzK2Po3HW0wc0q+8JaQ==
X-Received: by 2002:adf:dcc2:0:b0:1f0:4c38:d6be with SMTP id x2-20020adfdcc2000000b001f04c38d6bemr20907119wrm.79.1647366106054;
        Tue, 15 Mar 2022 10:41:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d6daf000000b00203db33b2e4sm546838wrs.26.2022.03.15.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 10:41:45 -0700 (PDT)
Message-Id: <pull.1178.git.1647366104967.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 17:41:44 +0000
Subject: [PATCH] maintenance: fix synopsis in documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The synopsis for 'git maintenance' did not include the commands other
than the 'run' command. Update this to include the others. The 'start'
command is the only one of these that parses additional options, and
then only the --scheduler option.

Also move the 'register' command down after 'stop' and before
'unregister' for a logical grouping of the commands instead of an
alphabetical one. The diff makes it look as three other commands are
moved up.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    maintenance: fix synopsis in documentation
    
    This is a quick fix for an issue I noticed during another review [1].
    
    Thanks, -Stolee
    
    [1]
    https://lore.kernel.org/git/dd9413da-1b8c-2adf-c471-e5fd4230375c@github.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1178%2Fderrickstolee%2Fmaintenance-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1178/derrickstolee/maintenance-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1178

 Documentation/git-maintenance.txt | 38 ++++++++++++++++---------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index e2cfb68ab57..e56bad28c65 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -10,6 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git maintenance' run [<options>]
+'git maintenance' start [--scheduler=<scheduler>]
+'git maintenance' (stop|register|unregister)
 
 
 DESCRIPTION
@@ -29,6 +31,24 @@ Git repository.
 SUBCOMMANDS
 -----------
 
+run::
+	Run one or more maintenance tasks. If one or more `--task` options
+	are specified, then those tasks are run in that order. Otherwise,
+	the tasks are determined by which `maintenance.<task>.enabled`
+	config options are true. By default, only `maintenance.gc.enabled`
+	is true.
+
+start::
+	Start running maintenance on the current repository. This performs
+	the same config updates as the `register` subcommand, then updates
+	the background scheduler to run `git maintenance run --scheduled`
+	on an hourly basis.
+
+stop::
+	Halt the background maintenance schedule. The current repository
+	is not removed from the list of maintained repositories, in case
+	the background maintenance is restarted later.
+
 register::
 	Initialize Git config values so any scheduled maintenance will
 	start running on this repository. This adds the repository to the
@@ -55,24 +75,6 @@ task:
 setting `maintenance.auto = false` in the current repository. This config
 setting will remain after a `git maintenance unregister` command.
 
-run::
-	Run one or more maintenance tasks. If one or more `--task` options
-	are specified, then those tasks are run in that order. Otherwise,
-	the tasks are determined by which `maintenance.<task>.enabled`
-	config options are true. By default, only `maintenance.gc.enabled`
-	is true.
-
-start::
-	Start running maintenance on the current repository. This performs
-	the same config updates as the `register` subcommand, then updates
-	the background scheduler to run `git maintenance run --scheduled`
-	on an hourly basis.
-
-stop::
-	Halt the background maintenance schedule. The current repository
-	is not removed from the list of maintained repositories, in case
-	the background maintenance is restarted later.
-
 unregister::
 	Remove the current repository from background maintenance. This
 	only removes the repository from the configured list. It does not

base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
-- 
gitgitgadget
