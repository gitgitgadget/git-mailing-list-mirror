Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1A520179
	for <e@80x24.org>; Fri, 17 Jun 2016 16:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbcFQQmD (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 12:42:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36002 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcFQQmB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 12:42:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id m124so983383wme.3
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 09:42:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eWV5KBgVI6e4UXzQo0ZIn3bhySS30/GxHI/RzdpK+yw=;
        b=T8P51wNRwpLZ4FDbxlxIsNI3CQ8uh0tnCwUEMvDFHU/F+inpyOaOcanM49iwlh1orb
         0Ccowz3DxDE9Yjwmx+M28l5P/gPKYKKcdExWxT11I8iKSvzObZ15Gk7AAp7ni2mnLzhS
         2EJsVgneoakQbHAUaOZGgB0dV8ptF8uKRkq2pTcWHpP/DL81z76GKX18tj+e2BZ3A32f
         u1ij1mBNIHy0JsLMCWENj9xnUTHD+myrYp8vYwCZXijJuTKCXw1H2yyngt7zrO5blDLL
         IqQw+TbWHo/sCmDnBaWKB258Dx2Yqb8ydkDj+a/3rhhV04QUNvlljByU5VGXxtPliYz2
         Mbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eWV5KBgVI6e4UXzQo0ZIn3bhySS30/GxHI/RzdpK+yw=;
        b=SkXBeiNAPO/M7Jyi3A5WJDMJLHMetCvCNNkmJejk8Zf/Hnuqia5X+7/HSFa/mlOnqQ
         vS5s1gQURo72ieY6TGxCK/L14K0X7IYAd5tjBW3HBSSyR5c89W2upZ0dpiYy2g1KLuVf
         w6hft7YNHQpOITXY1hgl9M7Ao3mCFZw2+oD+gG54weHm/v2wL3+nY2hPPfs/SabIKsUC
         Yq1b1uRjPZPWug0qil7Q/XIWdOkCRWNM4J8dgiUh1heJJXgh76dj3UO842+X4+feCo1c
         y+7tx+0r5DhmpT4Yme4eOXCHKmFokxugvpZx/fCEEpET/YL0kYNIFi1dtP1p6wDMJRaz
         gVYg==
X-Gm-Message-State: ALyK8tLOa7VSXH3ISWsAdegf2bRRvRnrVhVEhKgipWbOyMmn8TwQ/Az8dTXTWAl+h1FrDQ==
X-Received: by 10.28.165.5 with SMTP id o5mr3366916wme.87.1466181719625;
        Fri, 17 Jun 2016 09:41:59 -0700 (PDT)
Received: from localhost.localdomain ([90.154.137.66])
        by smtp.gmail.com with ESMTPSA id kp9sm49537147wjb.28.2016.06.17.09.41.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 17 Jun 2016 09:41:59 -0700 (PDT)
From:	Martin Vladev <martinvladev@gmail.com>
X-Google-Original-From:	Martin Vladev <martin.vladev@gmail.com>
To:	git@vger.kernel.org
Cc:	szeder@ira.uka.de, spearce@spearce.org, felipe.contreras@gmail.com,
	lee.marlow@gmail.com, Martin Vladev <martin.vladev@gmail.com>
Subject: [PATCH] completion: add "diff.compactionHeuristic" to git config
Date:	Fri, 17 Jun 2016 19:42:23 +0300
Message-Id: <20160617164223.79500-1-martin.vladev@gmail.com>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Martin Vladev <martin.vladev@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3402475..55862d6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2066,6 +2066,7 @@ _git_config ()
 		core.whitespace
 		core.worktree
 		diff.autorefreshindex
+		diff.compactionHeuristic
 		diff.external
 		diff.ignoreSubmodules
 		diff.mnemonicprefix
-- 
2.9.0

