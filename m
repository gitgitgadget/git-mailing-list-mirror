Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC1C1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 09:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbdFJJHr (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 05:07:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35194 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbdFJJHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 05:07:46 -0400
Received: by mail-wr0-f194.google.com with SMTP id g76so11255899wrd.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 02:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CSq5/6OMpY7r9RmlXWBBz1uIU5Jam/YiO6ORaFxi2ZE=;
        b=XiMKr9ehLG4DR52OyWLVcdyK1NUq+oLWg84gjZEUJ8hCeP6XYUjCQP/HQPCN1PT0FN
         KFPnkvA6IL5y4fbn4yorXuOSl955OXmsktMVZJwuLor8UzHRceTL1vFdQv3J+IPoZUt1
         dAHC+5D4MxjxFwnDaiWk8i3I+gdapvqUC5JusXs+/BUBkKb6qxfrszG9qdfVUnGdRizr
         VcgIDq+YqBW7H/nP25tUaAByNjaL/T4w6qg6N3nNuxf/rRo0ySsnpBAey6Pvyp2tGZ5G
         tu3gCvumSbTHxsfCIuFMJYGi1j7GdRay+phWXwCsCPVwSp4ALdcRA5BpQp2iJ/ZshraQ
         Bljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CSq5/6OMpY7r9RmlXWBBz1uIU5Jam/YiO6ORaFxi2ZE=;
        b=g1GcZfZkaZZpLBJB/soOVaQ+2/tN7KfjLX0VmVxrmDmWnrOBnai5KjrMGM21+aESxM
         lTOqITdpyCP6jmnnzrnr+zu10ryRvqArhXcy+I7HH06DLtS2ryNfVWukS7kDEQgU0KIX
         sqZNpYHvaI7ZnIXaczW89WO4on6FdhalMhB6siCVMS3EIt0oxB2zdIsyPW7ifiD0jfJn
         /oaena+EWkOHl2wVF0qok8zdQWk9yf/ZaEoa+eO6FftrsMFVfokUF1lhcvujvUtMEmuO
         pWoh4CY1OVymiSWgDU6Zhzi8HAwBYV0GeJKenNEQYANr239mtvXDoifVnCaJoE9L9/BU
         pnrA==
X-Gm-Message-State: AODbwcCBMXJzdHY2a/qAqCGDq5yDCy+DTyh4u+R3vzmlk3Y1Wo1qa2tk
        /6LeEAIo56twM4cDFO4=
X-Received: by 10.223.171.83 with SMTP id r19mr1567856wrc.7.1497085664565;
        Sat, 10 Jun 2017 02:07:44 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3439:7300:99fb:6818:11d2:739])
        by smtp.gmail.com with ESMTPSA id 29sm5115788wrv.23.2017.06.10.02.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 02:07:43 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] doc: fix location of index in worktree scenatio
Date:   Sat, 10 Jun 2017 11:07:19 +0200
Message-Id: <20170610090719.8429-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When setting `.gitattributes` in a second worktree, a plain `rm .git/index`
does not actually delete the index.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 473648386..4c6b74fa6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -229,7 +229,7 @@ From a clean working directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >.gitattributes
-$ rm .git/index     # Remove the index to re-scan the working directory
+$ rm "$(git rev-parse --git-path index)"  # Remove the index to re-scan the working directory
 $ git add .
 $ git status        # Show files that will be normalized
 $ git commit -m "Introduce end-of-line normalization"
-- 
2.13.0

