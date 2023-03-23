Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74868C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjCWQrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjCWQrA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:00 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02A2B466
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:29 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 09E182420D
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhy-AyU-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:34 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] sequencer: actually translate report in do_exec()
Date:   Thu, 23 Mar 2023 17:22:33 +0100
Message-Id: <20230323162234.995485-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

N_() is meant to be used on strings that are subsequently _()'d, which
isn't the case here.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index fda68cd33d..21748bbfb0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3628,7 +3628,7 @@ static int do_exec(struct repository *r, const char *command_line)
 			  "  git rebase --continue\n"
 			  "\n"),
 			command_line,
-			dirty ? N_("and made changes to the index and/or the "
+			dirty ? _("and made changes to the index and/or the "
 				"working tree.\n") : "");
 		if (status == 127)
 			/* command not found */
-- 
2.40.0.152.g15d061e6df

