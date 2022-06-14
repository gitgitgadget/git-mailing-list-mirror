Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A8CCA47E
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 16:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiFNQPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243905AbiFNQOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 12:14:25 -0400
Received: from mailproxy03.manitu.net (mailproxy03.manitu.net [217.11.48.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAFB37A0E
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 09:14:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a4a:4a00:84a5:f961:bada:889e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id 94FE712A010C;
        Tue, 14 Jun 2022 18:14:22 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH] config: correct log.showRoot description
Date:   Tue, 14 Jun 2022 18:14:22 +0200
Message-Id: <b7aa801c3995fffdce37d90adba9253485b616e3.1655223201.git.git@grubix.eu>
X-Mailer: git-send-email 2.37.0.rc0.107.g7a7be657e7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current description is misleading because it fits a "default false"
setting whereas the default is "true" (as mentioned).

Instead, craft the wording in `config/log.txt` analogous to the one in
`git-log.txt`.

Note that the wording is not exactly the same, e.g. because
`config/log.txt` wants to link to man pages and man pages want to refer
to command options. Otherwise, includes would be the easy route to
consistency here.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 Documentation/config/log.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 456eb07800..b210f24cca 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -40,10 +40,10 @@ log.graphColors::
 	history lines in `git log --graph`.
 
 log.showRoot::
-	If true, the initial commit will be shown as a big creation event.
-	This is equivalent to a diff against an empty tree.
-	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
-	normally hide the root commit will now show it. True by default.
+	If `false`, tools like linkgit:git-log[1] or linkgit:git-whatchanged[1]
+	will not treat the initial commit as a big creation event.  Any root
+	commits in `git log -p` output would be shown without a diff attached.
+	The default is `true`.
 
 log.showSignature::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-- 
2.37.0.rc0.107.g7a7be657e7

