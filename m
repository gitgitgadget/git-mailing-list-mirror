Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119C11F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 20:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405871AbfJRU7n (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 16:59:43 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:4692 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbfJRU7n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 16:59:43 -0400
Received: from localhost.localdomain ([92.30.121.54])
        by smtp.talktalk.net with SMTP
        id LZLZijkPcnuQZLZLZirrs6; Fri, 18 Oct 2019 21:59:42 +0100
X-Originating-IP: [92.30.121.54]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=/cLN2YrzNMz5fcHgWq8JfQ==:117
 a=/cLN2YrzNMz5fcHgWq8JfQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10
 a=Y_rLTfa585dEHHUE3isA:9 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2] config/branch: state that <name>.merge is the remote ref
Date:   Fri, 18 Oct 2019 21:59:35 +0100
Message-Id: <20191018205935.2529-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.23.0.windows.1.21.g947f504ebe8.dirty
In-Reply-To: <c96f4dbd-ebc6-b743-716e-e1e17333c06b@iee.email>
References: <c96f4dbd-ebc6-b743-716e-e1e17333c06b@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfItmO0SYBQu/L0HOmPyiFrWNMWaV+csGpAw/wMA/6n896l43L71qfvtMbTUr9wHxs+BcCZuTsQvHkkOWK8l54lUMcl/rA2uuHDO34Mg9+aHLZ7dRpynS
 QATwqLV86tGg2jp0u6ByKvr9Gu5nzFsuznUm43lMb84ABMEPQRRQKKHQGqQaWTDcgd8QtKAY595uoynI5y0zezRl96k61a689IfSqXMZN3I8uivwiDKsIWAs
 kRqxY2dZRv+0ejAczClGaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The branch.<name>.merge value typically looks just like a
local ref. Tell the reader it is the ref name at the remote,
which may be different.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/config/branch.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index a592d522a7..cdc19edaaf 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -52,8 +52,10 @@ branch.<name>.pushRemote::
 	option to override it for a specific branch.
 
 branch.<name>.merge::
-	Defines, together with branch.<name>.remote, the upstream branch
-	for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
+	The name of the branch ref at the remote `branch.<name>.remote`
+	that is used as the upstream branch for the given branch <name>.
++
+	It tells 'git fetch'/'git pull'/'git rebase' which
 	branch to merge and can also affect 'git push' (see push.default).
 	When in branch <name>, it tells 'git fetch' the default
 	refspec to be marked for merging in FETCH_HEAD. The value is
-- 
2.23.0.windows.1.21.g947f504ebe8.dirty

