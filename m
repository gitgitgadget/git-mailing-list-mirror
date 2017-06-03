Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B785820D09
	for <e@80x24.org>; Sat,  3 Jun 2017 10:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbdFCKSM (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 06:18:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36740 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdFCKSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 06:18:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id e23so2048469wre.3
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vKxtTPwQ6eK5TxT2SKRXhY8vbh8Ye0pMBwF3U1Y9VzY=;
        b=ankAu0n0EJPjvfRdITtQxJRi2HwUgNcsDO0/fNPtWs7C4Vp9rLly/lFF2+O6Ivq8qx
         hIxW3nAFuoe7k6Yz5qCjKTvPACsn0HzFp2rlxxuwWPON2K3Z9c1CdLbfKIJtDc1JVXYG
         IqWEz/XStDX7w5RiW7G2hidWTjCH36ABVLQTWj/fGNbEC+6rA5oht6mXYlWTfqdvfeoJ
         eNGWFNPofce46LJWU047nMIbJwzfbAGke/Va4rMr0uzLzcM1JiNo2OiYBStl4CyiwbfL
         +DGpVRl/r+XqdS2I7mPp+5yiKKpET+qKSS0N5C8ltt8qFp8di78AcL3t21M3/To+R6Bu
         fk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vKxtTPwQ6eK5TxT2SKRXhY8vbh8Ye0pMBwF3U1Y9VzY=;
        b=QKuLCBAL5ePZPDfotSOIre50A7lKNdWu1M+IBKo4JDAEvSx73oquDPZ94IUwlRKgER
         vXI4WMHdsGQd7yQLd1JZx3W24fWjdRtRlG6DlzuNcR36DHm8sYla0yxcSzsenTeCVJAX
         m7oxTzPnCtUIflkh3rU19uBV2PeacXWRze5EjXAw2gX28hmvcUlcNHdMiqH5Xg+8rOa2
         2jIniCGl74opU9AdMnTdx+dp77/Xc4cWxxfIdzPXScZLY+jh5eRdB7UiXxS8yDxNhv+e
         ThpeSlWDgXfrADxFzXum2ebixcvMoC75QARv1n6U0oVF5n3n5S7l92b8dd59GEMIRL1M
         jLIw==
X-Gm-Message-State: AODbwcDb+aqwzh+69WY+0HsemL+sfmizhltb6NHuBhObueNfuZBiteIV
        ou8EEv7uS3bQ4A==
X-Received: by 10.223.139.152 with SMTP id o24mr9262267wra.20.1496485090066;
        Sat, 03 Jun 2017 03:18:10 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3405:6400:b08b:b890:381e:abd8])
        by smtp.gmail.com with ESMTPSA id z23sm14696819wrz.0.2017.06.03.03.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Jun 2017 03:18:09 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 2/2] add [--] to usage of filter-branch
Date:   Sat,  3 Jun 2017 12:17:55 +0200
Message-Id: <20170603101755.13619-2-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170603101755.13619-1-asheiduk@gmail.com>
References: <20170603101755.13619-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-filter-branch.txt | 3 ++-
 git-filter-branch.sh                | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 45c849d8c..1efdda804 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -86,7 +86,8 @@ OPTIONS
 	This is not a real filter executed for each commit but a one
 	time setup just before the loop. Therefore no commit-specific
 	variables are defined yet.  Functions or variables defined here
-	can be used or modified in the following filter steps.
+	can be used or modified in the following filter steps except
+	the commit filter, for technical reasons.
 
 --env-filter <command>::
 	This filter may be used if you only need to modify the environment
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 2758ae5eb..3a74602ef 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -87,7 +87,7 @@ USAGE="[--setup <command>] [--env-filter <command>]
 	[--commit-filter <command>] [--tag-name-filter <command>]
 	[--subdirectory-filter <directory>] [--original <namespace>]
 	[-d <directory>] [-f | --force]
-	[<rev-list options>...]"
+	[--] [<rev-list options>...]"
 
 OPTIONS_SPEC=
 . git-sh-setup
-- 
2.13.0

