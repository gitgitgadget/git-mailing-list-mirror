Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C9BC35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D3D2080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgBIN0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:26:36 -0500
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:39011 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727626AbgBIN0f (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Feb 2020 08:26:35 -0500
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com [198.54.127.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id DF48A8020C
        for <git@vger.kernel.org>; Sun,  9 Feb 2020 08:19:27 -0500 (EST)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
        by MTA-07.privateemail.com (Postfix) with ESMTP id BEFF160034;
        Sun,  9 Feb 2020 08:19:26 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.209])
        by MTA-07.privateemail.com (Postfix) with ESMTPA id D66D560043;
        Sun,  9 Feb 2020 13:19:25 +0000 (UTC)
From:   "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
To:     git@vger.kernel.org
Cc:     "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Subject: [RFC PATCH 3/3] Enable merge commit message type autoselect logic by default
Date:   Sun,  9 Feb 2020 16:16:23 +0300
Message-Id: <20200209131623.5827-4-darktemplar@dark-templar-archives.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200209131623.5827-1-darktemplar@dark-templar-archives.net>
References: <20200209131623.5827-1-darktemplar@dark-templar-archives.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: i.Dark_Templar <darktemplar@dark-templar-archives.net>
---
 Documentation/config/fmt-merge-msg.txt | 2 +-
 builtin/fmt-merge-msg.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/fmt-merge-msg.txt b/Documentation/config/fmt-merge-msg.txt
index 3829095222..acd998cca8 100644
--- a/Documentation/config/fmt-merge-msg.txt
+++ b/Documentation/config/fmt-merge-msg.txt
@@ -10,7 +10,7 @@ merge.log::
 	true is a synonym for 20.
 
 merge.messageType::
-	Configure default merge commit message type. `original` is used
+	Configure default merge commit message type. `autoselect` is used
 	if no value or an invalid value is set.
 	+
 	* `original` keeps old merge commit message format which takes only one line.
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 0bc6ce5b05..8fa39030d3 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -18,7 +18,7 @@ enum message_format {
 	MESSAGE_FORMAT_ORIGINAL = 0,
 	MESSAGE_FORMAT_MULTILINE = 1,
 	MESSAGE_FORMAT_AUTOSELECT = 2,
-	MESSAGE_FORMAT_DEFAULT = MESSAGE_FORMAT_ORIGINAL
+	MESSAGE_FORMAT_DEFAULT = MESSAGE_FORMAT_AUTOSELECT
 };
 
 static const char * const fmt_merge_msg_usage[] = {
-- 
2.24.1

