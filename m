Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38A181F453
	for <e@80x24.org>; Mon, 11 Feb 2019 21:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfBKVvG (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 16:51:06 -0500
Received: from [193.29.56.124] ([193.29.56.124]:56846 "EHLO iodev.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfBKVvG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 16:51:06 -0500
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] git-gui: Handle Ctrl+BS & Ctrl+Del in the commit msg
Date:   Mon, 11 Feb 2019 22:42:03 +0100
Message-Id: <20190211214203.32444-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 git-gui.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b878d41..e00d9a345294 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3788,6 +3788,8 @@ bind $ui_comm <$M1B-Key-KP_Subtract> {show_less_context;break}
 bind $ui_comm <$M1B-Key-equal> {show_more_context;break}
 bind $ui_comm <$M1B-Key-plus> {show_more_context;break}
 bind $ui_comm <$M1B-Key-KP_Add> {show_more_context;break}
+bind $ui_comm <Control-Key-BackSpace> {%W delete {insert -1 chars wordstart} insert;break}
+bind $ui_comm <Control-Key-Delete> {%W delete insert {insert wordend};break}
 
 bind $ui_diff <$M1B-Key-x> {tk_textCopy %W;break}
 bind $ui_diff <$M1B-Key-X> {tk_textCopy %W;break}
-- 
2.20.1

