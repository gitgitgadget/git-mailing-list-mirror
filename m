Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C591F453
	for <e@80x24.org>; Wed, 24 Oct 2018 08:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeJXQb6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:31:58 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:51996 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJXQb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:31:58 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id F074242D6D4; Wed, 24 Oct 2018 10:04:54 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] howto/using-merge-subtree: mention --allow-unrelated-histories
Date:   Wed, 24 Oct 2018 10:04:52 +0200
Message-Id: <20181024080452.11876-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without passing --allow-unrelated-histories the command sequence
fails as intended since commit e379fdf34fee ("merge: refuse to create
too cool a merge by default"). To setup a subtree merging unrelated
histories is normal, so add the option to the howto document.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 Documentation/howto/using-merge-subtree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/howto/using-merge-subtree.txt b/Documentation/howto/using-merge-subtree.txt
index 1ae8d1214ec0..a499a94ac228 100644
--- a/Documentation/howto/using-merge-subtree.txt
+++ b/Documentation/howto/using-merge-subtree.txt
@@ -33,7 +33,7 @@ Here is the command sequence you need:
 
 ----------------
 $ git remote add -f Bproject /path/to/B <1>
-$ git merge -s ours --no-commit Bproject/master <2>
+$ git merge -s ours --no-commit --allow-unrelated-histories Bproject/master <2>
 $ git read-tree --prefix=dir-B/ -u Bproject/master <3>
 $ git commit -m "Merge B project as our subdirectory" <4>
 
-- 
2.19.1

