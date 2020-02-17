Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ECBC34024
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079A1222D9
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgBQQLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:11:00 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:54351 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgBQQLA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 11:11:00 -0500
Received: from localhost.localdomain (unknown [103.227.98.241])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 34FD3100005;
        Mon, 17 Feb 2020 16:10:57 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Jonathan Gilbert <JonathanG@iQmetrix.com>,
        Robert Luberda <robert@debian.org>
Subject: [PATCH] git-gui: add missing close bracket
Date:   Mon, 17 Feb 2020 21:40:56 +0530
Message-Id: <20200217161056.10864-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d9c6469 (git-gui: update status bar to track operations, 2019-12-01),
the status bar was refactored to allow multiple overlapping operations.

Since the refactor changed the status bar interface, all callsites had
to be refactored to use the new interface. During that refactoring, this
closing bracket was missed. This leads to an error message popping up
when doing 'Branch->Reset...'.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
Reported at https://github.com/prati0100/git-gui/issues/28

 lib/merge.tcl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/merge.tcl b/lib/merge.tcl
index 8df8ffa..664803c 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -244,7 +244,7 @@ Continue with resetting the current changes?"]
 		set status_bar_operation [$::main_status \
 			start \
 			[mc "Aborting"] \
-			[mc "files reset"]
+			[mc "files reset"]]
 		fileevent $fd readable [namespace code [list \
 			_reset_wait $fd $status_bar_operation]]
 	} else {
--
2.21.1

