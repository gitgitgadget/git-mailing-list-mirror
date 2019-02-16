Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742BF1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 03:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfBPDLa (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 22:11:30 -0500
Received: from [193.29.56.124] ([193.29.56.124]:36908 "EHLO iodev.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfBPDLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 22:11:30 -0500
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH v2] git-gui: Handle Ctrl + BS/Del in the commit msg
Date:   Sat, 16 Feb 2019 04:10:52 +0100
Message-Id: <20190216031051.8859-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Control+BackSpace: Delete word to the left of the cursor.
- Control+Delete   : Delete word to the right of the cursor.

Originally introduced by BRIEF and Turbo Vision between 1985 and 1992,
they were adopted by most CUA-Compliant UIs, including those of: OS/2,
Windows, Mac OS, Qt, GTK, Open/Libre Office, Gecko, and GNU Emacs.

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---

Notes:
    Changes since v1:
    - Improved commit message.

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

