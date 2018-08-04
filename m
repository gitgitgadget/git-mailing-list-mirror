Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287831F597
	for <e@80x24.org>; Sat,  4 Aug 2018 06:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeHDIYv (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 04:24:51 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:42313 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDIYv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 04:24:51 -0400
Received: by mail-lf1-f46.google.com with SMTP id u202-v6so5564547lff.9
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 23:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2a6Zd0EJ+3fPmpVjZljvFbL5fWrPBVJ39ObXjlhSMw=;
        b=vO85D6rTEI4/u6rt9U7kJN9bv9n/f9SVolY+brVe3PKBFNG0c3afbnu5HDkIMlYhNz
         3Jl/jjqwB+eUnC9cLgo6cxq/hSW4YWGUiJz250vY+hJm8BGvXlnYQXF0a8ntXjUql2gN
         sJmJ08Hodqu698HtDr0oUM4baEgYWcYgcmPaEoBMma0kGM6p6G8UfMHuMX9W72Tmvg7n
         KWJ5PUOnbhoDPLqPLP4bKoCLkzDaHDrYd/Hl1THJ0wEgWYrujyBJlSKYXHfzKDtKvgRN
         DqmEwYPSzbSXatrYHXaqPxqeU39Am6EFSjDpTWTVWPNc3Sp48CoPxmgqSE9pN1pfAKEQ
         HKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2a6Zd0EJ+3fPmpVjZljvFbL5fWrPBVJ39ObXjlhSMw=;
        b=qdCNceBDpe6/hNji/LcL+1a5aRAfRBPc0ZssGVf2NLKrCB0b21TsAQDamfA67kk3cw
         ctPSWr2xuoHqrgT6gipkK0EH6B9ozwEnvbvgGR5q9depbaubsYnAAmmOU/PUxZFIaSbS
         5eeNuuyi9DLi2SEDftnQEyJO9sp7hsng0QRzEvXq9j+1dA/gGxXingCMSTg9P8J2QBLA
         Xy0vxmEVuyHRq+nDXQUXnjhYbrWBdS3G/XNc2YTCWfJ2sXiKFZzicTKeO4ZEp5FTLe7U
         i50xib12J0Y2gmUpmN3duWi99knKyjYNIeEPIJCYPAJGo6bnPCAwINCn29sF6AhAdkSR
         4U+w==
X-Gm-Message-State: AOUpUlEG3Ze9rgKlluEG3nj1p65kBk5z9xjCiMUPPNhFyL3XksErG0+j
        TDYLXE4hNKpWl+EwmEg9iOV3EDMw
X-Google-Smtp-Source: AAOMgpeTuhIq/iyqEEAmnOTxH8r0Q2TKjJ6/ToRCyUUMejWNnZoVQKtqhiFnqMLny/A8ihKeU2plbg==
X-Received: by 2002:a19:7403:: with SMTP id v3-v6mr6136401lfe.97.1533363917087;
        Fri, 03 Aug 2018 23:25:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k65-v6sm1190595lje.3.2018.08.03.23.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 23:25:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] config.txt: reorder blame stuff to keep config keys sorted
Date:   Sat,  4 Aug 2018 08:25:00 +0200
Message-Id: <20180804062500.20188-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.759.gbd3bccdecd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The color group in config.txt is actually sorted but changes in
sb/blame-color broke this. Reorder color.blame.* and move
blame.coloring back to the rest of blame.* (and reorder that group too
while we're there)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 68 ++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fd8d27e761..d97455057c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -995,23 +995,28 @@ apply.whitespace::
 	Tells 'git apply' how to handle whitespaces, in the same way
 	as the `--whitespace` option. See linkgit:git-apply[1].
 
-blame.showRoot::
-	Do not treat root commits as boundaries in linkgit:git-blame[1].
-	This option defaults to false.
-
 blame.blankBoundary::
 	Show blank commit object name for boundary commits in
 	linkgit:git-blame[1]. This option defaults to false.
 
-blame.showEmail::
-	Show the author email instead of author name in linkgit:git-blame[1].
-	This option defaults to false.
+blame.coloring::
+	This determines the coloring scheme to be applied to blame
+	output. It can be 'repeatedLines', 'highlightRecent',
+	or 'none' which is the default.
 
 blame.date::
 	Specifies the format used to output dates in linkgit:git-blame[1].
 	If unset the iso format is used. For supported values,
 	see the discussion of the `--date` option at linkgit:git-log[1].
 
+blame.showEmail::
+	Show the author email instead of author name in linkgit:git-blame[1].
+	This option defaults to false.
+
+blame.showRoot::
+	Do not treat root commits as boundaries in linkgit:git-blame[1].
+	This option defaults to false.
+
 branch.autoSetupMerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
@@ -1149,6 +1154,28 @@ color.advice::
 color.advice.hint::
 	Use customized color for hints.
 
+color.blame.highlightRecent::
+	This can be used to color the metadata of a blame line depending
+	on age of the line.
++
+This setting should be set to a comma-separated list of color and date settings,
+starting and ending with a color, the dates should be set from oldest to newest.
+The metadata will be colored given the colors if the the line was introduced
+before the given timestamp, overwriting older timestamped colors.
++
+Instead of an absolute timestamp relative timestamps work as well, e.g.
+2.weeks.ago is valid to address anything older than 2 weeks.
++
+It defaults to 'blue,12 month ago,white,1 month ago,red', which colors
+everything older than one year blue, recent changes between one month and
+one year old are kept white, and lines introduced within the last month are
+colored red.
+
+color.blame.repeatedLines::
+	Use the customized color for the part of git-blame output that
+	is repeated meta information per line (such as commit id,
+	author name, date and timezone). Defaults to cyan.
+
 color.branch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-branch[1]. May be set to `always`,
@@ -1296,33 +1323,6 @@ color.status.<slot>::
 	status short-format), or
 	`unmerged` (files which have unmerged changes).
 
-color.blame.repeatedLines::
-	Use the customized color for the part of git-blame output that
-	is repeated meta information per line (such as commit id,
-	author name, date and timezone). Defaults to cyan.
-
-color.blame.highlightRecent::
-	This can be used to color the metadata of a blame line depending
-	on age of the line.
-+
-This setting should be set to a comma-separated list of color and date settings,
-starting and ending with a color, the dates should be set from oldest to newest.
-The metadata will be colored given the colors if the the line was introduced
-before the given timestamp, overwriting older timestamped colors.
-+
-Instead of an absolute timestamp relative timestamps work as well, e.g.
-2.weeks.ago is valid to address anything older than 2 weeks.
-+
-It defaults to 'blue,12 month ago,white,1 month ago,red', which colors
-everything older than one year blue, recent changes between one month and
-one year old are kept white, and lines introduced within the last month are
-colored red.
-
-blame.coloring::
-	This determines the coloring scheme to be applied to blame
-	output. It can be 'repeatedLines', 'highlightRecent',
-	or 'none' which is the default.
-
 color.transport::
 	A boolean to enable/disable color when pushes are rejected. May be
 	set to `always`, `false` (or `never`) or `auto` (or `true`), in which
-- 
2.18.0.759.gbd3bccdecd

