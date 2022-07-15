Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF69C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 09:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiGOJ0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiGOJZw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 05:25:52 -0400
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83C7CB7C
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 02:25:46 -0700 (PDT)
Received: (qmail 15544 invoked by uid 989); 15 Jul 2022 09:25:45 -0000
Authentication-Results: cressida.uberspace.de;
        auth=pass (plain)
From:   Matthias Beyer <mail@beyermatthias.de>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Matthias Beyer <mail@beyermatthias.de>,
        Konstantin Khomoutov <kostix@bswap.ru>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] Add note that conflict resolution is still performed
Date:   Fri, 15 Jul 2022 11:25:27 +0200
Message-Id: <20220715092527.1567837-1-mail@beyermatthias.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <xmqq35f6fe0j.fsf@gitster.g>
References: <xmqq35f6fe0j.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) BAYES_HAM(-2.181716)
X-Rspamd-Score: -0.781716
Received: from unknown (HELO unkown) (::1)
        by cressida.uberspace.de (Haraka/2.8.28) with ESMTPSA; Fri, 15 Jul 2022 11:25:45 +0200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We should note that conflict resolution is still performed, even if
`--no-rerere-autoupdate` is specified, to make sure users do not get
confused by the setting and assume this disables rerere conflict
resultion altogether.

CC: Phillip Wood <phillip.wood@dunelm.org.uk>
CC: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthias Beyer <mail@beyermatthias.de>
---
 Documentation/git-cherry-pick.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 78dcc9171f..b92aa1f9da 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -160,6 +160,10 @@ effect to your index in a row.
 --no-rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
+	The `--no-rerere-autoupdate` option does not prevent the conflict
+	resolution, but prevents the index from being updated. This gives the
+	user a chance for a final sanity check before using linkgit:git-add[1]
+	to add the result.
 
 SEQUENCER SUBCOMMANDS
 ---------------------
-- 
2.36.0

