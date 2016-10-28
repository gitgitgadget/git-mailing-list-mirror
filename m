Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7BD2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034383AbcJ1S4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:41 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34537 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034358AbcJ1S4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:31 -0400
Received: by mail-pf0-f180.google.com with SMTP id n85so41599100pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e8nQhfKk2tBOh031nDghn6hbW0AyKYITE4nQhkCJiqg=;
        b=BliptIlhur/DsQh/vy9et9dRhhyrO6OpZXIGpT2pTq+tTA6rG//58pADs7RaU2XB8E
         v3DyC8TGKW9fMVPTaVzZjwG2WdLZmkIoDFm0M5E9GOwfpUBs9jzUe6KgQ9cI9CkPWCx3
         BR3bre7pSHNNxfotb15pPX6xwx48qqsjtmtTgn0hhHxlUeNt8qt1FXRuuK9eIeZ4uc06
         I5OEt/qD1bZabEwxTVp7wbsNHrm5PNyytRjxG8cvRz0UwCP3WxYR1BFe1PBdHPDCt1Ag
         VkHaANCHiEgjE1l5KQ8FWzSWg9FObgrDsLeYAuSK19lwSYY1XhynOzj54C4YB+G0JgmJ
         BkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e8nQhfKk2tBOh031nDghn6hbW0AyKYITE4nQhkCJiqg=;
        b=WKSCYPI3b88q3clzPaOOyA8mbtOtou6LWGtoMlf6BhlsEzXgbAHgPTPjDno+aMD5KY
         2jYnnVh08+dTAOi2CPTGWhgJ/U8adyy5IYlwx4/aCBmW/953k25F5oNbE8XLRnGlZ8//
         xx3YnEUJr8LiZNH5abiOPaOrxJ+8PirJpyQaw+099v9qopaJkiNwixDAWdiB0K/QlFS5
         Ovl7MgiGiqXyOJTYtHkiY9RwBKAf85O6teBrvoci5HZx9NKUaHd7Kyc3JCvuAG/wDgOy
         BB3myV85psguPvZCjE4c8ao4LUOvTiSQJS7g5IJ0DLeZaR1vB2T+bi1ZE+0SeEt8k121
         F19Q==
X-Gm-Message-State: ABUngvfbRpJ4SiAzftcU92MAW6kFf+co5/OGK0sMWVv5HoMKy8BHg4OcC8ElNL/G2MQhheGT
X-Received: by 10.99.120.203 with SMTP id t194mr23011440pgc.17.1477680991175;
        Fri, 28 Oct 2016 11:56:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id u17sm20527961pfa.83.2016.10.28.11.56.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 36/36] completion: clone can initialize specific submodules
Date:   Fri, 28 Oct 2016 11:55:02 -0700
Message-Id: <20161028185502.8789-37-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf8df..90eb772652 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1138,6 +1138,7 @@ _git_clone ()
 			--single-branch
 			--branch
 			--recurse-submodules
+			--init-submodule
 			"
 		return
 		;;
-- 
2.10.1.714.ge3da0db

