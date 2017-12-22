Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715911F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756953AbdLVX4D (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:56:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:50771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756948AbdLVX4C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:56:02 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcFTN-1erSOm3mWz-00jdLE; Sat, 23
 Dec 2017 00:55:58 +0100
Date:   Sat, 23 Dec 2017 00:55:57 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 4/5] sequencer: report when noop has an argument
In-Reply-To: <cover.1513986836.git.johannes.schindelin@gmx.de>
Message-ID: <5fe76040e25993662002c421a5fbcb3ea2d00c96.1513986836.git.johannes.schindelin@gmx.de>
References: <cover.1513986836.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FsxOo2Fndv/Nmslwm8VxPoUNWsyhE5UsEpHgS4NIU+27G3CLyvp
 BeQcSy8H5YfMqKTlI5t9F+xgrJJryB1TYFGfOU9z1vXAreVc6KQqDz2KccgIq6+Iv8hmQGx
 2YqYgtdIruNMVA5o5UqpsSL5yzAXKNpavbvSC/t7So789SVNJCg3+iVfko7qW4W+NIVsOF4
 laf01GVBknBXfcDHPlkHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bns7O5u3lgI=:nXzkjAzwSBCj/g5PNV/7iz
 IrcHBi87Ssuxkz81gK6FaSqnyUJLqA02LaQE+zbf1EfoCAoqFJa5mXfzvi07J9ZZ/AOANwYti
 GAkdp8rjhrtloXaQyqIrFf86jUPugOrHLDDPuq15JmOF0Ga3n+xgJvWja3zJClk3WEnBzXcEu
 /0IYy/PQuEN9v8pl+KRxOZwLVX71R2C9IKe9RKPLBezZ6hdqjWJlSQDcQ/xnk8AvGJ/5BCQ/Z
 Mq9sPaOnx0fx1ECsXEEnVt78Vk4LECGxetwSbLvjn83uoKM9andJFF81MIodJIY4EqOCLmW+g
 wVhpY4WImAF07i5e6mzozKRwTrfKsCj7tpK3oh6taA5L5HW4W/96SawYUBxBGZ9WgF6UOr2aO
 9MtScB1PkzdHofwna1c22C4LWQbN1q9CQXpyQt0PAbOmmhzeDf1CiiKpIafVtk+Q+CJtgOGKZ
 0RcpgBvi95TQHFLynVzsLoRYN5Lv8tHsy+79qn7wiUY32FZJ5Kk5Y+pxmFZPucrx/2kto1dIN
 Z5zcZXVztSchXGAFOxucOjvw9ipUaKOqHvQPqRY3cSEW3YwDHjhRbd0DJngRtT5pg2L/kVPXT
 y0fnuG8SkfBlWaPhnFbBuK6AcvW4Byy9CyCfrPGJDCzw9T3CWCaVKac3q3LrejjTaDVVgnH2I
 HAkCKycbF1KqgKT9B/csNNGZAiDjneJiBaOb6nxayAurghTP/IvGkaZcG+9WjGOaQDC8uUNzc
 zuoyOWOKnuCBVdNfs30hOuJF1WOfRoHSr1z3ByO4i2M4f/nb+p9bZRNZkN9WUDfkOcvBzUIj8
 B9Q5EPf36oto1xC7Tv35msgB3FVv/Tk+gXFRb/mR9L1f2t8hL8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The noop command cannot accept any argument, but we never told the user
about any bogus argument. Fix that.

while at it, mention clearly when an argument is required but missing
(for commands *other* than noop).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 38266c3c228..5632415ea2d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1259,18 +1259,23 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	if (i >= TODO_COMMENT)
 		return -1;
 
+	/* Eat up extra spaces/ tabs before object name */
+	padding = strspn(bol, " \t");
+	bol += padding;
+
 	if (item->command == TODO_NOOP) {
+		if (bol != eol)
+			return error(_("%s does not accept arguments: '%s'"),
+				     command_to_string(item->command), bol);
 		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = eol - bol;
 		return 0;
 	}
 
-	/* Eat up extra spaces/ tabs before object name */
-	padding = strspn(bol, " \t");
 	if (!padding)
-		return -1;
-	bol += padding;
+		return error(_("missing arguments for %s"),
+			     command_to_string(item->command));
 
 	if (item->command == TODO_EXEC) {
 		item->commit = NULL;
-- 
2.15.1.windows.2


