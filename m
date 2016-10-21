Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0686B20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755479AbcJUMZR (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:25:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:58990 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755451AbcJUMZP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:25:15 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lxxw4-1d2v7H2tD2-015LSH; Fri, 21 Oct 2016 14:24:52
 +0200
Date:   Fri, 21 Oct 2016 14:24:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 10/27] sequencer: avoid completely different messages for
 different actions
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <72139cb119aaf28454b141572f5cb46843f5f3e9.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q0ouwYMvEat8gvEfNbOjM2aLIwIBySy0F5t5vJJsea8BMlK3J8M
 7Xl5kSY6g0tL5UHeD7wyPvZiOh5uE+X+uU8whN3AmwnmSHEqvQAvDfDEEq5cWVDbwrvfW+q
 w/D8fxwZyHVYB37t9RTSmHPXxi6xp/4EKAfhnS34x57wg3A84zCR2LScuvzoTQkvghf6tcM
 ruTgYoY1JVaabcKl/hoQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RaoAJgAuFJg=:ihDQyZFaGb8O0KmISAgZRZ
 NhPJCOalUoB0IyQLBQ29XbwJzsNriu76BNQ20bTESP/qhXXtJQD3UqtMukbRf7Zj/xHwXqU0z
 mjTXBkUQoJevPt11cp/Kesuo/GjgzZl6NudMc8u4Los0WJUIn7JI/u7+Aey2TZeyx6kjjLbr6
 wb2eGjm03F7oJRL5POTNEdFc1/jjA5yqgejn0RB2mZcx/ZMCWc1QJMFMqHruRLfPkxtDw9DwE
 YLeInWpV8Xdo8s2CMcWCt3qO0g/MbLIqvx7Gz/jpULa1WXc0ZUiiun87ZCawboew2ZHZ20Ef0
 nisztMgAI9Ue4NJ2/cchRaKW2zaHH33IBAvrtEDNhKSTqhHOe7L6tG3GcYmBed7zBItCTvVOe
 PYdN5TPr0Aa9owYg4sPpVkf26soaY9EfcOcWFncdk3rdKxkPZwZyVTty4v6zZ98Z1XkP5WQH+
 56VLkVLMRU23bPEE9hwYjnFSKQohgWDVmz3A+eCMeOqF9AZ17chXKgqxdLfPlqQHY+H0L/QFs
 /ZRrg0kBWoY3Ix82+kUEhe89UQZmWfgW/EXbRm4NRH8eqv5fVIIQgbLnBUlKMtCqpnTaHrFCL
 zs7FrJ0TK5MgVUMKP2YD8L1CxXWx8AS/sAZgr9lCZl96ZQVJMSZ4Ym2oxr0eGzq/ypRzp3bV7
 cN2QcTuTkDjvZvxLilng3CkSwR6g7gOvMzpAnEzZ8zd2KS1/KMV2Ar0llV5zvRJQtAsfGkpCF
 tsLBVg2vosdxjsPTNSqNkecp3U0SB3ard45x3K1QPVHl1aXUeA/MEKjZyt1E8SK8F9v0gKyO1
 Q7URRMV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 04fcfd8..120a8ee 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -229,11 +229,8 @@ static int error_dirty_index(struct replay_opts *opts)
 	if (read_cache_unmerged())
 		return error_resolve_conflict(action_name(opts));
 
-	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == REPLAY_PICK)
-		error(_("Your local changes would be overwritten by cherry-pick."));
-	else
-		error(_("Your local changes would be overwritten by revert."));
+	error(_("Your local changes would be overwritten by %s."),
+		action_name(opts));
 
 	if (advice_commit_before_merge)
 		advise(_("Commit your changes or stash them to proceed."));
-- 
2.10.1.583.g721a9e0


