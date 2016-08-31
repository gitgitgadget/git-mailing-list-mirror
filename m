Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B9F1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933784AbcHaIzM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:53963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933734AbcHaIzC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:02 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MY86C-1bahow1Lo8-00UuDY; Wed, 31 Aug 2016 10:54:58
 +0200
Date:   Wed, 31 Aug 2016 10:54:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/34] sequencer (rebase -i): remove CHERRY_PICK_HEAD when
 no longer needed
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <df4d48f33ff31ef2ae445be18674ec3f58540d08.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:n9gjdO3gne1equ7vZvmrwt3tGyvxHyy/BVdr+suwgYSWDcaIyjY
 Dt0Tt0a3CrqpVYx796qC/YqYTQhIMF50Lh25WXMuo59UoNr6CoPF9fD4+D8UXrnTK6At9fL
 lFDfvfEweCeIygFxLbvwgKMvgK5XKleJIMJefCmSpasoTHxLZi67xJOEmwb618pnZ5Zxqmb
 aiOrgHwdAwE/VR0QgcaKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VsWyror9/vo=:fAu6Asp1Ozuc6nydHMOccj
 CQI1J4HqesStMQS8ErjAa6VZGhHrqRMOa6fSf4gOf0uz5HUYxmIuAXivkCxNSSYqXdzRUguPM
 Ag6FNEYEO0JErWIjOYxdR487CNZB+NQeT5xw1PSmWcfMrvPQuZSz3ZnTDZZtTWr0FsZyF2wLw
 SUEmlQxSLHiKr5jkUVmrzQM4DmSqI3iUKU8vGpXg/4DEP+GylZ2qEhomhQRe2v3Po8BX9+Oo7
 xy0Gj2X68NK3aEd7g8PgHspeJ3Tbwqr6bn4CiiVKBXAC8FAGMDvBA+lqmpSVMyJ0fVUYdc83v
 yZ195xgqHdx+ZgBoT1VQgNY7JWen2sIS8u6LiC9CnsYnhcuGn0yx+Q95tbGlsGzrPMsaGn5s+
 1Ar1YNt6nOLGx0ZlABXJaB791HrAhLuhXq23R2O/AROHAPiHhAAcRHI+/6mB0jDiCryWOKNip
 xlAms4/Gor49at1hx0rZxf2MOkFVOriM0U3aS0pMckBTjn8deGykwFw01whxWXBbCGJmiCu3A
 B06zbcOH+1UjPhPX8Nh17m8yWfkyGHYweMJsY7DqKlVN9AiTn+YnKaxjQM0+301EhRmydyqjL
 hXAGo3t4U9l21s6UDr2+JVI0T/xRExZO6XKmAkeBLSBiqshRz++N3R3MNBmMPCsPWXN2CTjYM
 +CW6Zd+Sb0zzMFkgmPmnpUw07HEe+4xBYrrX4bmM0YbdVRn+xZRDvhTDrmUgkEe2n7+rlTeP4
 hujI7kYlhZd9YQxPDc2MRPvODsE/VJ4fEnSEeh8cUuZp/lIZ2yJJlV8o5xTCID6LZZ8K9TACZ
 F2HhlcO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The scripted version of the interactive rebase already does that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 4ddb12e..683b89f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1813,8 +1813,13 @@ static int commit_staged_changes(struct replay_opts *opts)
 
 	if (has_unstaged_changes(1))
 		return error(_("Cannot rebase: You have unstaged changes."));
-	if (!has_uncommitted_changes(0))
+	if (!has_uncommitted_changes(0)) {
+		const char *cherry_pick_head = git_path("CHERRY_PICK_HEAD");
+
+		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
+			return error("Could not remove CHERRY_PICK_HEAD");
 		return 0;
+	}
 
 	if (file_exists(rebase_path_amend())) {
 		struct strbuf rev = STRBUF_INIT;
-- 
2.10.0.rc2.102.g5c102ec


