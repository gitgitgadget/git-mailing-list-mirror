Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63A6C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37D7206C3
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbgEYVow (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 17:44:52 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:34888 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387942AbgEYVow (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 17:44:52 -0400
Received: from localhost.localdomain ([89.243.191.101])
        by smtp.talktalk.net with SMTP
        id dKm0jC4AIIndsdKm1jhP2p; Mon, 25 May 2020 22:36:41 +0100
X-Originating-IP: [89.243.191.101]
X-Spam: 0
X-OAuthority: v=2.3 cv=QYIYQfTv c=1 sm=1 tr=0 a=5KGm1Kp77X3djDixdaHiLg==:117
 a=5KGm1Kp77X3djDixdaHiLg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=5ImqxrIEn9Xfnd--PGYA:9
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Philip Oakley <philipoakley@iee.email>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] doc: fixup/squash: clarify use of <oid-hash> in subject line
Date:   Mon, 25 May 2020 22:36:31 +0100
Message-Id: <20200525213632.1626-2-philipoakley@iee.email>
X-Mailer: git-send-email 2.26.2.windows.1.13.g9dddff6983
In-Reply-To: <20200525213632.1626-1-philipoakley@iee.email>
References: <9a9e7432-7a74-f46e-9a77-b8acaa9a974f@iee.email>
 <20200525213632.1626-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPvfo84edlVVru6jFcucucps12gYOMusUar0/MVu2kqoF30RAgAMcv/RwYnsfF+3r4zSEYapKQPr7E+Sr/Hvk0JsdCjv9d+Iih0AoMhj3hJpHT0C/Q4/
 KU/g3bi+uObfGMaL1Nxslsc46nOkpJ0YGYXkSblxj3J0Q5P9FnTlJUXx26T0SOwm/sLYqFgh6w35nw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option to use the oid hash is buried deep within the fixup/squash
documenation. Split the paragraph so that the option choice is
more obvious.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
The use of ellision `...` isn't great, as it gives no hint or clue,
leaving the subsequent test with a difficult explanation.

Clarify if a full oid has is required, or a unique abbreviation within
the respository, or just uniques within the rebase instruction?

This is a minimal change that sidesteps the chance to rewrite/clarify
the potential wider confusions over specifying the <commit> being
referred to in the fixup/squash process.
---
 Documentation/git-rebase.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607..dfd3d6d0ef 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -539,11 +539,13 @@ See also INCOMPATIBLE OPTIONS below.
 	matches the same `...`, automatically modify the todo list of rebase
 	-i so that the commit marked for squashing comes right after the
 	commit to be modified, and change the action of the moved commit
-	from `pick` to `squash` (or `fixup`).  A commit matches the `...` if
-	the commit subject matches, or if the `...` refers to the commit's
-	hash. As a fall-back, partial matches of the commit subject work,
-	too.  The recommended way to create fixup/squash commits is by using
-	the `--fixup`/`--squash` options of linkgit:git-commit[1].
+	from `pick` to `squash` (or `fixup`).
++
+A commit matches the `...` if
+the commit subject matches, or if the `...` refers to the commit's
+hash. As a fall-back, partial matches of the commit subject work,
+too.  The recommended way to create fixup/squash commits is by using
+the `--fixup`/`--squash` options of linkgit:git-commit[1].
 +
 If the `--autosquash` option is enabled by default using the
 configuration variable `rebase.autoSquash`, this option can be
-- 
2.26.2.windows.1.13.g9dddff6983

