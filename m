Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A97C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 15:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F16661DD9
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 15:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhF2PbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:31:22 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:42376 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbhF2PbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 11:31:17 -0400
Received: from [79.233.236.111] (helo=[192.168.2.202])
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1lyFf3-0001sj-Vm
        for git@vger.kernel.org; Tue, 29 Jun 2021 17:28:30 +0200
From:   Martin <git@mfriebe.de>
To:     git@vger.kernel.org
Subject: PATCH: improve git switch documentation
Message-ID: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
Date:   Tue, 29 Jun 2021 17:28:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Below is a patch, that I believe would improve the documentation of git 
switch.

The exact new wording is of course open for debate.

Reasoning for the change.

The current doc does not explain why the option is a "forceful" option.
Nor does explain the consequences.

Instead it leaves it to the user to lookup the alternate command, and 
find the meaning of
     git branch -f newbranch

Only if the user does that successfully, the user may learn about the 
full consequences of their actions.

I believe this info should be part of the "git switch" doc, itself. 
(Especially due to the severity that the action may have).



 From 46580d07f95a18c94925afd141ba55e52a82c8e1 Mon Sep 17 00:00:00 2001
From: Martin <User4martin@users.noreply.github.com>
Date: Tue, 29 Jun 2021 17:22:25 +0200
Subject: [PATCH] Update git-switch.txt

---
  Documentation/git-switch.txt | 8 ++++++--
  1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 5c438cd5058758..80acafad1f4a46 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -70,8 +70,12 @@ $ git switch <new-branch>
  -C <new-branch>::
  --force-create <new-branch>::
  	Similar to `--create` except that if `<new-branch>` already
-	exists, it will be reset to `<start-point>`. This is a
-	convenient shortcut for:
+	exists, it will be reset to `<start-point>`.
+	This forces the branch to the new location. It also forces
+	any commit hold by the branch to be dropped, unless the
+	commit is also part of any other branch too. You may
+	therefore loose some of your data.
+	This is a convenient shortcut for:
  +
  ------------
  $ git branch -f <new-branch>

