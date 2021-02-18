Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F387C433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEA664E15
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBRAMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:12:17 -0500
Received: from mail-40140.protonmail.ch ([185.70.40.140]:29958 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBRAMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:12:09 -0500
Date:   Thu, 18 Feb 2021 00:11:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613607087;
        bh=3LxAYXJps4izcEiX9Xp9AhbKrsL8hMkHZR8QN7ltnkU=;
        h=Date:To:From:Reply-To:Subject:From;
        b=UTqz21IqmpHmV5ljYuqWeibg+lVWrABneYOdz1Vyy9ztND4FU/CFYRXsQDlNBlOpX
         W0MPen9B+yeTCqXER2DVsnT4rl9M6x11JR11gUbwaqx1agcLYDHj4Volhx6p+rg/Zz
         hoD6d1xtaItnj9KxMoI8ARSefWhONZvsYwIWcks4=
To:     Denton Liu <liu.denton@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Joey Salazar <jgsal@protonmail.com>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: [OUTREACHY][PATCH v2] doc: fix naming of response-end-pkt
Message-ID: <k1OL_yTjmhqRPUI_3wZNi4FpD0yadrwMKu1CaOXO07YyMBQG5hYoUKFtndt6mlNBKMxyCgm3JGf2YcENx-vRasj1W8keEI6ITVvkaqOi2_Q=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git Protocol version 2[1] defines 0002 as a Message Packet that indicates
the end of a response for stateless connections.

Change the naming of the 0002 Packet to 'Response End' to match the
parsing introduced in Wireshark's MR !1922 for consistency. A subsequent
MR in Wireshark will address additional mismatches.

[1] kernel.org/pub/software/scm/git/docs/technical/protocol-v2.html
[2] gitlab.com/wireshark/wireshark/-/merge_requests/1922

Signed-off-by: Joey Salazar <jgsal@protonmail.com>
---
 Documentation/technical/protocol-v2.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/techni=
cal/protocol-v2.txt
index e597b74da39..fc163ca605c 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -33,8 +33,8 @@ In protocol v2 these special packets will have the follow=
ing semantics:

   * '0000' Flush Packet (flush-pkt) - indicates the end of a message
   * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
-  * '0002' Message Packet (response-end-pkt) - indicates the end of a resp=
onse
-    for stateless connections
+  * '0002' Response End Packet (response-end-pkt) - indicates the end of a
+    response for stateless connections

 Initial Client Request
 ----------------------
--
2.29.0.rc2

