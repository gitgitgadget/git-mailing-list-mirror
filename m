Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A895C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C57E222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419786AbgJYWlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418775AbgJYWlp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:41:45 -0400
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Oct 2020 15:41:45 PDT
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A630C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:41:45 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXo-0007u5-T4; Sun, 25 Oct 2020 22:27:16 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 03/21] doc: mention canonicalization in git i-t manual
Date:   Sun, 25 Oct 2020 22:26:34 +0100
Message-Id: <20201025212652.3003036-4-anders@0x63.nu>
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
        id 1kWnXo-0007u5-T4; Sun, 25 Oct 2020 22:27:16 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/git-interpret-trailers.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f0..a4be8aed66 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -25,6 +25,11 @@ Otherwise, this command applies the arguments passed using the
 `--trailer` option, if any, to the commit message part of each input
 file. The result is emitted on the standard output.
 
+When trailers read from input they will be changed into "canonical"
+form if the trailer has a corresponding 'trailer.<token>.key'
+configuration value. This means that it will use the exact spelling
+(upper case vs lower case and separator) defined in configuration.
+
 Some configuration variables control the way the `--trailer` arguments
 are applied to each commit message and the way any existing trailer in
 the commit message is changed. They also make it possible to
-- 
2.25.1

