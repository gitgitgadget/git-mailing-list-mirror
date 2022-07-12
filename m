Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE87C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 14:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiGLOZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiGLOZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 10:25:25 -0400
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676CB5D1F
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 07:25:22 -0700 (PDT)
Received: (qmail 12599 invoked by uid 989); 12 Jul 2022 14:25:19 -0000
Authentication-Results: cressida.uberspace.de;
        auth=pass (plain)
From:   Matthias Beyer <mail@beyermatthias.de>
Cc:     Matthias Beyer <mail@beyermatthias.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Add note that conflict resolution is still performed
Date:   Tue, 12 Jul 2022 16:04:50 +0200
Message-Id: <20220712140450.1288726-1-mail@beyermatthias.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <xmqq4jzvla9x.fsf@gitster.g>
References: <xmqq4jzvla9x.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Original-Authentication-Results: cressida.uberspace.de;
        auth=pass (plain)
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-2.864109) R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) FORGED_RECIPIENTS(1)
X-Rspamd-Score: -0.464109
Received: from unknown (HELO unkown) (::1)
        by cressida.uberspace.de (Haraka/2.8.28) with ESMTPSA; by cressida.uberspace.de (Haraka/2.8.28) with ESMTPSA; Tue, 12 Jul 2022 16:06:34 +0200
Apparently-To: <mail@beyermatthias.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
To:     unlisted-recipients:; (no To-header on input)

We should note that conflict resolution is still performed, even if
`--no-rerere-autoupdate` is specified, to make sure users do not get
confused by the setting and assume this disables rerere conflict
resultion all together.

CC: Phillip Wood <phillip.wood@dunelm.org.uk>
CC: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthias Beyer <mail@beyermatthias.de>
---
 Documentation/git-cherry-pick.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 78dcc9171f..730a4590af 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -160,6 +160,8 @@ effect to your index in a row.
 --no-rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
+	If `--no-rerere-autoupdate` is specified, the conflict resolution is
+	still performed, but the index is not updated.
 
 SEQUENCER SUBCOMMANDS
 ---------------------
-- 
2.36.0

