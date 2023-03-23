Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74941C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjCWQrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjCWQq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:46:59 -0400
X-Greylist: delayed 1432 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Mar 2023 09:46:27 PDT
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765109773
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:27 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 1032C24211
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhy-Aya-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:34 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] advice: translate all actions in error_resolve_conflict()
Date:   Thu, 23 Mar 2023 17:22:34 +0100
Message-Id: <20230323162234.995485-3-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

action_name() returns a N_()'d string (for good reasons), so we still
need to _() it.

In practice, this affects 'rebase'.

Whether this is actually useful is debatable ...

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 advice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index d6232439c3..f75f3df582 100644
--- a/advice.c
+++ b/advice.c
@@ -192,7 +192,7 @@ int error_resolve_conflict(const char *me)
 		error(_("Reverting is not possible because you have unmerged files."));
 	else
 		error(_("It is not possible to %s because you have unmerged files."),
-			me);
+			_(me));
 
 	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 		/*
-- 
2.40.0.152.g15d061e6df

