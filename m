Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E759220D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdFAVlt (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:41:49 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35815 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFAVls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:41:48 -0400
Received: by mail-lf0-f66.google.com with SMTP id v20so312257lfa.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZEMlw8I+sh3Ng+wMQCklNAtk6EuVuYv9EDKw8dPA19o=;
        b=BxI77N5eiyNH6xrqaw6jIuUsQqm8NS/9RMbjOHv8YWIkJ/VcCSUOpM88pYPSROmdSO
         sozyW/YT+11HYRrRruvQVPHpCOry4u8gmKjHIOtSG3ffR8/mYXTa0pVEW8YP8aqx457C
         iI5mzV/sr7brEf77JywgguMqd9r8t+krsE2W68G8NAr9lcqsV1wM+BgT/2I4kX0iVsdH
         qyh9ODzMRERSQsJYTOL0bCUbwoCcDZ9BR0x0lDdefe+1HnCZLfXmozPDfas9yZpYuWOk
         k47RqnMOmVCztRILqIiW4tuSx0mYMqs1KtrpX9U/mbdAmxvukv16VdnuobVDQ0StjZM8
         I4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZEMlw8I+sh3Ng+wMQCklNAtk6EuVuYv9EDKw8dPA19o=;
        b=LdbWcDVSGy24S5Xn+d9BB84rbVY/zsQGOItri9F5eXxmEj1IGqfC16Qna3x6uqczAP
         psCTT5oygJGZEEuLStWBrbCpLRybLxjYX8jeMZextJxxAqZWM8h3e9YhycuJmah+fttp
         OIWy73hMdRkCTZE/kX8pCWmZgpsiMU0SvyMFFGfIYt78BFqbxIubOSz3eijQAoRKqs3U
         RhVng0dUC9S4uq1TXgmFmkkpgdqY2GAG18xUl0qHxbm0tVmJV+loyuDigMkONP2GR6T1
         vmmygTx4DtrhnMCfNhViZY5Yqm+C6LiXbHbo6WwBXvngsLplN31Cy1Q8qb/rzmfiVwoO
         da/A==
X-Gm-Message-State: AODbwcDKx+v6LaXinwblhKvhRWMSJiIJedUI0NLpLyqEnqsTFOV3Hhz/
        Jsh8V+A/ucZxc7NY9Ew=
X-Received: by 10.46.22.20 with SMTP id w20mr1232634ljd.49.1496353306216;
        Thu, 01 Jun 2017 14:41:46 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-95.na.cust.bahnhof.se. [155.4.133.95])
        by smtp.gmail.com with ESMTPSA id u6sm4482419ljd.42.2017.06.01.14.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 14:41:45 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     git@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/6] completion: Add git config gc completions
Date:   Sat, 27 May 2017 08:25:47 +0200
Message-Id: <20170527062552.13996-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
References: <20170527062552.13996-1-rikard.falkeborn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing completion for git config gc options:

* gc.aggressiveDepth
* gc.autoDetach
* gc.logExpiry
* gc.worktreePruneExpire

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 45a78a095..4e5e2eaae 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2464,15 +2464,19 @@ _git_config ()
 		format.thread
 		format.to
 		gc.
+		gc.aggressiveDepth
 		gc.aggressiveWindow
 		gc.auto
+		gc.autoDetach
 		gc.autopacklimit
+		gc.logExpiry
 		gc.packrefs
 		gc.pruneexpire
 		gc.reflogexpire
 		gc.reflogexpireunreachable
 		gc.rerereresolved
 		gc.rerereunresolved
+		gc.worktreePruneExpire
 		gitcvs.allbinary
 		gitcvs.commitmsgannotation
 		gitcvs.dbTableNamePrefix
-- 
2.13.0

