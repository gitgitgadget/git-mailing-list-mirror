Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342751F404
	for <e@80x24.org>; Mon, 11 Dec 2017 14:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbdLKOOK (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 09:14:10 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:7040 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753052AbdLKONv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 09:13:51 -0500
Received: from lindisfarne.localdomain ([92.22.30.250])
        by smtp.talktalk.net with SMTP
        id OOpteDPs4CbAZOOq5eBiwL; Mon, 11 Dec 2017 14:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513001630;
        bh=i5DitntfPcvvuFsxUFb6j+9C0Xh3UepDqBetI9ITnLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=jYkt32JDjeiHRJd8+RM1YDR37dmXs6wk2oMs7XjBesaTbS1rZvZKEJd/O7OJ8so+y
         MIZ4aqzl3OHz+VeLfnr6JWkKtpLus9/u4s9uv+Z750pfAtdPs4KloZ8RLjPg+or6NI
         D2WTlQuAfTxWL0DWL3iSF1x8cIoye1gEEiiewcBk=
X-Originating-IP: [92.22.30.250]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=hCO86xb6nvxPok+3LE1svw==:117
 a=hCO86xb6nvxPok+3LE1svw==:17 a=evINK-nbAAAA:8 a=1XWaLZrsAAAA:8
 a=bFKVfzvudV62lQPiLrgA:9 a=BDUmtqLCItfToRpD:21 a=sX8ezErjqDGhiyDX:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 9/9] t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
Date:   Mon, 11 Dec 2017 14:13:30 +0000
Message-Id: <20171211141330.23566-10-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171211141330.23566-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNU+AJWSHwI1RBGtZueKFDH3xD9y2uODUj/CS2oy1TQZP8ba3gUxyEFSeI7JZk5Jnff/QY5CcBUTHX9VyJunGg2IZzCp5kiahQ8EZXLSFANm34HKNsn0
 cifxsrih4U0697+O15hjKMa4VHl225H6YqguwyWVbZ+RglmTwqoXVAjEuGbu5Dw9c86Ux8E0ac2+J4M++UK71fUmiVxz4AXUCyxHQXABiC898GHUl3ENwXhe
 1EugiTL3yQ429nX/2h3VasVVBHbM9Qth+roEQ5LMlhecgSh+ek0S5tp88A3MI4Ox6Fq2Z0BW58OVVAUPvxA0bFt+3TH0IMtMbP6bECHEa8bNYoOhdntSAni+
 6c5NbMQfC80+A+1lgWrid5HCSPBXxAQbakyxRUqd8GLLia6lya4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that the sequencer creates commits without forking 'git commit' it
does not see an empty commit in these tests which fixes the known
breakage. Note that logic for handling
KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1 is not removed from
lib-submodule-update.sh as it is still used by other tests.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    Changes since v4
     - Added reviewed-by trailer

 t/t3512-cherry-pick-submodule.sh | 1 -
 t/t3513-revert-submodule.sh      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index ce48c4fcca80b183927292cc1e5902cfe286f994..bd78287841ee053fd56a44a268f8077a222cc266 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -5,7 +5,6 @@ test_description='cherry-pick can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "git cherry-pick"
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index db9378142a93338d2988f40e2748bc476490bcd5..5e39fcdb66c0c7c4b112c1bbe941d886db237693 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -25,7 +25,6 @@ git_revert () {
 	git revert HEAD
 }
 
-KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 test_submodule_switch "git_revert"
 
-- 
2.15.1

