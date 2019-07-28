Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710A71F462
	for <e@80x24.org>; Sun, 28 Jul 2019 15:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfG1PRg (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 11:17:36 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:54509 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1PRf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 11:17:35 -0400
Received: from localhost.localdomain (unknown [1.186.12.13])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2F146100005;
        Sun, 28 Jul 2019 15:17:32 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH] git-gui: Perform rescan on window focus-in
Date:   Sun, 28 Jul 2019 20:47:26 +0530
Message-Id: <20190728151726.9188-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If any changes are made to the tree while git-gui is open, the user has
to manually rescan to see those changes in the gui. With this change, a
rescan will be performed whenever the window comes in focus, removing
the need for manual rescans in most cases. A manual rescan will still be
needed when something makes changes to the tree while git-gui is still
in focus.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui/git-gui.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 6de74ce639..8ca2033dc8 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3849,6 +3849,7 @@ if {[is_enabled transport]} {
 }
 
 bind .   <Key-F5>     ui_do_rescan
+bind .   <FocusIn>    do_rescan
 bind .   <$M1B-Key-r> ui_do_rescan
 bind .   <$M1B-Key-R> ui_do_rescan
 bind .   <$M1B-Key-s> do_signoff
-- 
2.22.0

