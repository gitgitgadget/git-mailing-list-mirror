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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5E6C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DC864D99
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBPVWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 16:22:36 -0500
Received: from mail-40137.protonmail.ch ([185.70.40.137]:23534 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhBPVWf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 16:22:35 -0500
Date:   Tue, 16 Feb 2021 21:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613510512;
        bh=/1RwM4r7e1d7O1XtE68irI0JiGslnp6pG2OtbcOVVZ8=;
        h=Date:To:From:Reply-To:Subject:From;
        b=Bdn0I+nIUOMvjugW4NOPi6JJYOskZTizuXKF/atfaTyh0QNgSttsGNFhd6WuEZqwc
         O7FfRqsPZBqysUy01u7eCL+evZV+IloIPJSCVkFK8wbbveBFZBl9TYR9MTW1OtBy4M
         NVl5YFxyQfGPxGjQ0S3as+HYXe37LadcIY6951mg=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Joey Salazar <jgsal@protonmail.com>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: [OUTREACHY][PATCH v1] doc: fix naming of response-end-pkt
Message-ID: <5qGT6uzPLUGN2DXCMTzhixEhKHwaT6hODaOHQ485sfCROycrTDPx6P2Nd5dOy4J-gnhb_lKpxW4jJqhut-4gmoeIyuhpqbA5fXCeHoKHrK8=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git Protocol version 2[1] defines 0002 as a Message Packet that indicates
the end of a response for stateless connections.

Change the naming of the 0002 Packet to 'Response end' to match the
parsing introduced in Wireshark's MR !1922 for consistency.

[1] kernel.org/pub/software/scm/git/docs/technical/protocol-v2.html
[2] gitlab.com/wireshark/wireshark/-/merge_requests/1922

Signed-off-by: Joey Salazar <jgsal@protonmail.com>
---
 Documentation/technical/protocol-v2.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/techni=
cal/protocol-v2.txt
index e597b74da39..6c55d566d8b 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -33,8 +33,8 @@ In protocol v2 these special packets will have the follow=
ing semantics:

   * '0000' Flush Packet (flush-pkt) - indicates the end of a message
   * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
-  * '0002' Message Packet (response-end-pkt) - indicates the end of a resp=
onse
-    for stateless connections
+  * '0002' Response end Packet (response_end-pkt) - indicates the end of a
+    response for stateless connections

 Initial Client Request
 ----------------------
--
2.29.0.rc2

