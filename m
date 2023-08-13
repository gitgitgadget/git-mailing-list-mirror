Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F36EB64DD
	for <git@archiver.kernel.org>; Sun, 13 Aug 2023 10:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjHMKqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Aug 2023 06:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjHMKqr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2023 06:46:47 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB41709
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 03:46:50 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 5D9EA24054;
        Sun, 13 Aug 2023 06:46:49 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qV8cT-FTS-00; Sun, 13 Aug 2023 12:46:49 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t9001: fix indentation in test_no_confirm()
Date:   Sun, 13 Aug 2023 12:46:49 +0200
Message-Id: <20230813104649.2919412-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <xmqq350sm21v.fsf@gitster.g>
References: <xmqq350sm21v.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The continuations of the compound command were indented as if they were
continuations of the embedded pipe, which was misleading.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v2:
- reduced to what seems to be welcome.
  fwiw, this is actually v0.

Cc: Junio C Hamano <gitster@pobox.com>
---
 t/t9001-send-email.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 48bf0af2ee..542f524f04 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -61,8 +61,8 @@ test_no_confirm () {
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$@ \
 		$patches >stdout &&
-		! grep "Send this email" stdout &&
-		>no_confirm_okay
+	! grep "Send this email" stdout &&
+	>no_confirm_okay
 }
 
 # Exit immediately to prevent hang if a no-confirm test fails
-- 
2.40.0.152.g15d061e6df

