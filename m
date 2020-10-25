Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4BC5517A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C42222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420321AbgJYWmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420311AbgJYWmM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:12 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD92C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:12 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXp-0007u5-77; Sun, 25 Oct 2020 22:27:17 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 05/21] trailer: rename 'free_all' to 'free_all_trailer_items'
Date:   Sun, 25 Oct 2020 22:26:36 +0100
Message-Id: <20201025212652.3003036-6-anders@0x63.nu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on st.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXp-0007u5-77; Sun, 25 Oct 2020 22:27:17 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 8c0687a529..227df1c0ef 100644
--- a/trailer.c
+++ b/trailer.c
@@ -990,7 +990,7 @@ static size_t process_input_file(FILE *outfile,
 	return info.trailer_end - str;
 }
 
-static void free_all(struct list_head *head)
+static void free_all_trailer_items(struct list_head *head)
 {
 	struct list_head *pos, *p;
 	list_for_each_safe(pos, p, head) {
@@ -1057,7 +1057,7 @@ void process_trailers(const char *file,
 
 	print_all(outfile, &head, opts);
 
-	free_all(&head);
+	free_all_trailer_items(&head);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
-- 
2.25.1

