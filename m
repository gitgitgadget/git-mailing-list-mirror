Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CBA31FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 23:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbcHNXpS (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 19:45:18 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34164 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751772AbcHNXpR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2016 19:45:17 -0400
X-Greylist: delayed 958 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Aug 2016 19:45:17 EDT
Received: from x590e090a.dyn.telefonica.de ([89.14.9.10] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1bZ4qA-000557-Sw; Mon, 15 Aug 2016 01:29:16 +0200
From:	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] t1410: remove superfluous 'git reflog' from the 'walk past root' test
Date:	Mon, 15 Aug 2016 01:28:53 +0200
Message-Id: <20160814232853.22909-1-szeder@ira.uka.de>
X-Mailer: git-send-email 2.9.3.674.gc254b9d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1471217356.
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1471218314.
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The test added in 71abeb753fa8 (reflog: continue walking the reflog
past root commits, 2016-06-03) contains an unnecessary 'git reflog'
execution, which was part of my debug/tracing instrumentation that I
somehow didn't manage to remove before submitting.

Signed-off-by: SZEDER Gábor <szeder@ira.uka.de>
---
 t/t1410-reflog.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index dd2be049ecf6..553e26d9ceb8 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -359,7 +359,6 @@ test_expect_success 'continue walking past root commits' '
 		HEAD@{3} commit (initial): initial
 		EOF
 		test_commit initial &&
-		git reflog &&
 		git checkout --orphan orphan1 &&
 		test_commit orphan1-1 &&
 		test_commit orphan1-2 &&
-- 
2.9.2.583.g6f6b5ef

