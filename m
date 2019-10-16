Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898311F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 11:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfJPL2a (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 07:28:30 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:19338 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfJPL2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 07:28:30 -0400
Received: from localhost.localdomain ([92.7.169.237])
        by smtp.talktalk.net with SMTP
        id KhTfiFvJsdraxKhTfi45u2; Wed, 16 Oct 2019 12:28:28 +0100
X-Originating-IP: [92.7.169.237]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=tcYJKHXJF8zWhnf8ZoLugA==:117
 a=tcYJKHXJF8zWhnf8ZoLugA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=Z_IrU8mHsci_puoOYxEA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v1] config/branch: state that <name>.merge is the remote ref
Date:   Wed, 16 Oct 2019 12:28:22 +0100
Message-Id: <20191016112822.1701-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.23.0.windows.1.21.g947f504ebe8.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNDgbmPJbXx9r1HM6ZmnuP222iCvuQkNg8PpbyqH12Ied8UImTEDEvi1UHIdUZZmpe+Y7GqFiyTkQT+35El+CdbxYsUhtNw+V/r1BFrFTnUI6iGyyRKC
 6NvtKdNzghehyk21O0N8mJkhLeYGILM9qO+mQr+BgyOtfef6PqO0hlsLZkpXjnmZatk9bGcYXLG+EaEm+9OCQaVlQGANGS3WpA4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The branch.<name>.merge value typically looks just like a
local ref. Tell the reader it is the ref name at the remote,
which may be different.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---

This confusion had me scratching my head for many minutes recently.
A simple clarification would avoid such mental model errors.

 Documentation/config/branch.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index a592d522a7..3bfe4f81d3 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -53,7 +53,9 @@ branch.<name>.pushRemote::
 
 branch.<name>.merge::
 	Defines, together with branch.<name>.remote, the upstream branch
-	for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
+	for the given branch. It defines the branch name _on the remote_,
+	which may be different from the local branch name.
+	It tells 'git fetch'/'git pull'/'git rebase' which
 	branch to merge and can also affect 'git push' (see push.default).
 	When in branch <name>, it tells 'git fetch' the default
 	refspec to be marked for merging in FETCH_HEAD. The value is
-- 
2.23.0.windows.1.21.g947f504ebe8.dirty

