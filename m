Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC621F991
	for <e@80x24.org>; Wed,  2 Aug 2017 10:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbdHBKow (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 06:44:52 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:19419 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbdHBKou (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 06:44:50 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id cr8nd8nSUiSHacr8ydwino; Wed, 02 Aug 2017 11:44:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501670688; bh=bX8q6PDoW2QAkpFXEl75y4utgpEwYZqb4YxTrUQrNCc=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=unMeFn6NmRxwIXObLNeBjwJHTIIyVDUIOEEBVTfWu+2dbTZCrryHGYl0ok95mhKKI
         xZRmeZnCt6K1XakwS23ZBnw73AH08NmgVydEWVCua1bhyFncsY8dHzUTRpg137R2Kd
         DcNBHrzsuneau952xPWci30pr9KZtip8ABeouXss=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=A-NU1cmfx21BdHVZRq4A:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/6] am/cherry-pick/rebase/revert --rerere-autoupdate fixes
Date:   Wed,  2 Aug 2017 11:44:14 +0100
Message-Id: <20170802104420.12809-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfF+ptsATgJ95onYHytqrUAGVjBV4XroCTi0zCG1yq9a5eqJF9pjRISC74lTqhOpipq8Ipt5f93jqBSaPJX+6+l47pfo6btFvzhAakgGMorr1Gl22xvbq
 hSKS8cazKuLuL0RupvYyILxILYqa/0034QTCCyAwDHoK1HRwkiqrdCJ/nNVegJHGULfqI3lRoxAvAq94K1eooKbYOfI9+agQhY9W6VKZTJyAqFu+2a5YFmgu
 C/vFBrFS0l7QEXy2vBqv8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

With the exception of 'rebase -m' when continuing after stopping for
the user to resolve conflicts, they all forget the setting of
--rerere-autoupdate.

Phillip Wood (6):
  am: remember --rerere-autoupdate setting
  rebase: honor --rerere-autoupdate
  rebase -i: honor --rerere-autoupdate
  t3504: use test_commit
  cherry-pick/revert: remember --rerere-autoupdate
  cherry-pick/revert: reject --rerere-autoupdate when continuing

 builtin/am.c                  | 12 ++++++
 builtin/revert.c              |  2 +
 git-rebase--am.sh             |  3 +-
 git-rebase--interactive.sh    |  7 ++--
 sequencer.c                   | 20 +++++++++-
 t/t3418-rebase-continue.sh    | 85 +++++++++++++++++++++++++++-------------
 t/t3504-cherry-pick-rerere.sh | 90 +++++++++++++++++++++++++++++++++++--------
 7 files changed, 170 insertions(+), 49 deletions(-)

-- 
2.13.3

