Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E7C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4363920BED
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbgJMTCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:02:53 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:59738 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJMTCx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:02:53 -0400
Received: from client3368.fritz.box (i5C747545.versanet.de [92.116.117.69])
        by dd36226.kasserver.com (Postfix) with ESMTPA id AE6EE3C0808;
        Tue, 13 Oct 2020 21:02:51 +0200 (CEST)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com
Subject: [PATCH] git-gui: Make usettk off by default on Mac OS X
Date:   Tue, 13 Oct 2020 21:02:43 +0200
Message-Id: <20201013190243.62313-1-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is supposed to make a Tcl/Tk app look more like a native app
for the respective platform. This doesn't seem to work on Mac, it looks
worse than the non-ttk appearance (for instance, the colored pane
headers are grey).

Users who really prefer the ttk look can still turn it on with the
gui.usettk config.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 git-gui.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 867b8ce..f7e13ca 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -897,7 +897,7 @@ set default_config(gui.fontui) [font configure font_ui]
 set default_config(gui.fontdiff) [font configure font_diff]
 # TODO: this option should be added to the git-config documentation
 set default_config(gui.maxfilesdisplayed) 5000
-set default_config(gui.usettk) 1
+set default_config(gui.usettk) [expr ![is_MacOSX]]
 set default_config(gui.warndetachedcommit) 1
 set default_config(gui.tabsize) 8
 set font_descs {
-- 
2.29.0.rc1

