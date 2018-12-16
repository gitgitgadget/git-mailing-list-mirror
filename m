Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,UNPARSEABLE_RELAY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34261F405
	for <e@80x24.org>; Sun, 16 Dec 2018 18:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbeLPSIJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 13:08:09 -0500
Received: from zombieland.mr.itd.umich.edu ([141.211.12.96]:40299 "EHLO
        zombieland.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730449AbeLPSIJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Dec 2018 13:08:09 -0500
X-Greylist: delayed 735 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Dec 2018 13:08:09 EST
Received: FROM tombraider.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.12.86])
        By zombieland.mr.itd.umich.edu ID 5C1691AA.3DB00.1836;
        Sun, 16 Dec 2018 12:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2016-05-12; t=1544982951;
        bh=gPyl6/mSmGijSX+mLXBr+DVMEa+5C4KUdHN7mRO6UvY=;
        h=From:To:Cc:Subject:Date;
        b=gMNKvRCfEBrYf9Vy8thlM4WkZqdpnn8FVYEsmNTTp3NOPpGhoMVtVRRvzeRqXn/U5
         IwUDuYL+VnBzIkB4OGGNBxI1dDtDg0m3Twge5c1yXQakCj9c52OnM9TxxivIJVmlpx
         DaYqP/ZWcqAW6huHEtt64VEz4KSFhlDH1to2S3jgTRKivGsuu/dr4u7Vu3uhX/MmPH
         NM/8ijBTvV6FqApzQvDoQxIl0XpsOvWXYm+xxm3KT5McHkRcA+twVR15orJmXY8B/0
         eQKFPrghY/zV/rdcrfsYgC8v0oueGRz8T95ClgDoVbMG+m9eksnkusHOCdChSdOTE5
         xSiMDhDZHe2BA==
Authentication-Results: tombraider.mr.itd.umich.edu;
        iprev=pass policy.iprev=67.180.238.167 (c-67-180-238-167.hsd1.ca.comcast.net);
        auth=pass smtp.auth=asottile
Received: FROM localhost.localdomain (c-67-180-238-167.hsd1.ca.comcast.net [67.180.238.167])
        By tombraider.mr.itd.umich.edu ID 5C1691A7.35D3B.21749;
        Authuser asottile;
        Sun, 16 Dec 2018 12:55:51 -0500
From:   Anthony Sottile <asottile@umich.edu>
To:     git@vger.kernel.org
Cc:     Anthony Sottile <asottile@umich.edu>
Subject: [PATCH] doc: short status for delete + intent-to-add
Date:   Sun, 16 Dec 2018 09:55:36 -0800
Message-Id: <20181216175536.5535-1-asottile@umich.edu>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git rm foo
rm 'foo'
$ touch foo
$ git add --intent-to-add foo
$ git status --short
DA foo

Signed-off-by: Anthony Sottile <asottile@umich.edu>
---
 Documentation/git-status.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d9f422d56..4af7424e5 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -202,7 +202,7 @@ in which case `XY` are `!!`.
 	     [AMD]   not updated
     M        [ MD]   updated in index
     A        [ MD]   added to index
-    D                deleted from index
+    D         [ A]   deleted from index
     R        [ MD]   renamed in index
     C        [ MD]   copied in index
     [MARC]           index and work tree matches
-- 
2.17.1

