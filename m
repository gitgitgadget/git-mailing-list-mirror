Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372381FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 14:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbcLDOls (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 09:41:48 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33965 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbcLDOls (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 09:41:48 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so35883265wjc.1
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 06:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ARG3Gn/AtRtoPMxvy/oacR0niNet7pD+MfTFsUuHlyo=;
        b=ce4QJmXReDD+GjYwQbrumfmfUFNQgVVt4urE2jIEEXGcDOSVr7kFbMiADuV3Z1mKXv
         9wzynmXTj4d2Em9ALPRwHLvLpVQMJQyyJ5/7lDanjs7MnaukG/aZr38gZ2vVOT61hSqA
         KAJ4jyJTkowtoM+PEzhHJGsvus2pDpqtGV98O4vCx2dr531lAKiUuBX8Z7ppo/L79laC
         Ydz3k6X4NC8Zy+aHX/yLbCyXJBD0Li1XgQ783FtGXgaMWXri5GlTk/gZODmzi1+6f6I3
         uR1PmwHwDo6OrgYjAaHfZqCcQKHyDCCZ4jc+zRr8RoSQdlhjulDKw+2iiTzRcjnjk7e1
         WiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ARG3Gn/AtRtoPMxvy/oacR0niNet7pD+MfTFsUuHlyo=;
        b=JTM0jI4hv8KK51d96y8kFCjvubycRV9L8AmxRTC+insdrYLUqQqKbMh79bPX2c03Fd
         Q8mMt7F0dgA1rCn6NRtvEGb58C5SPW5Ld0eYQX1EAFSmP5f5dXZjWMAUahgvX1T6+jxS
         nxLcoAFRDpSn2kcdH5S65cBY7SJ5gb3x3CObd5fCKIqCVOEzeKsi7ffMNnFHCAXU6MG3
         RQXWbf1Bixkl6eHc73KedpyTETdIJFsMfHpB6OkLj0ra2e2rTnPRME40aEQtyNi8tMEk
         jplmcE2xWuJZ39WrFVZDyhmAzUfDGWPPj//m4nADjOIWCV6eWZ+baNorhHfRD2d0d4CL
         rocA==
X-Gm-Message-State: AKaTC02C1MQvxpqi0GxxwPQxhpc/7qMOEkJsAYTo9c1OYIJPcPsP1+/kXR/gFlYrGAof2w==
X-Received: by 10.194.138.111 with SMTP id qp15mr28176278wjb.3.1480862506549;
        Sun, 04 Dec 2016 06:41:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:c7d:da04:500:99bf:7eb6:5cb9:d484])
        by smtp.gmail.com with ESMTPSA id g73sm13311529wme.16.2016.12.04.06.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Dec 2016 06:41:45 -0800 (PST)
From:   peterjclaw@gmail.com
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, szeder@ira.uka.de,
        Peter Law <PeterJCLaw@gmail.com>
Subject: [PATCH] Completion: Add support for --submodule=diff
Date:   Sun,  4 Dec 2016 14:41:27 +0000
Message-Id: <20161204144127.28452-1-peterjclaw@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Peter Law <PeterJCLaw@gmail.com>

Teach git-completion.bash about the 'diff' option to 'git diff
--submodule=', which was added in Git 2.11.

Signed-off-by: Peter Law <PeterJCLaw@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf8d..ab11e7371 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1206,7 +1206,7 @@ _git_describe ()
 
 __git_diff_algorithms="myers minimal patience histogram"
 
-__git_diff_submodule_formats="log short"
+__git_diff_submodule_formats="diff log short"
 
 __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
-- 
2.11.0

