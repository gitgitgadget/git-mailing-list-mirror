Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C93920248
	for <e@80x24.org>; Sat, 16 Mar 2019 09:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfCPJ3w (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 05:29:52 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:43052 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfCPJ3w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 05:29:52 -0400
X-Greylist: delayed 1960 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Mar 2019 05:29:51 EDT
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <glandium@glandium.org>)
        id 1h557r-00015e-CC; Sat, 16 Mar 2019 17:57:07 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] fix pack protocol example client/server communication
Date:   Sat, 16 Mar 2019 17:57:07 +0900
Message-Id: <20190316085707.4151-1-mh@glandium.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pkt-line formatted lines contained the wrong pkt-len.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 Documentation/technical/pack-protocol.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 7a2375a55d..c73e72de0e 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -657,14 +657,14 @@ can be rejected.
 An example client/server communication might look like this:
 
 ----
-   S: 007c74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/local\0report-status delete-refs ofs-delta\n
+   S: 006274730d410fcb6603ace96f1dc55ea6196122532d refs/heads/local\0report-status delete-refs ofs-delta\n
    S: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe refs/heads/debug\n
    S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/master\n
-   S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/team\n
+   S: 003d74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/team\n
    S: 0000
 
-   C: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug\n
-   C: 003e74730d410fcb6603ace96f1dc55ea6196122532d 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master\n
+   C: 00677d1665144a3a975c05f1f43902ddaf084e784dbe 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug\n
+   C: 006874730d410fcb6603ace96f1dc55ea6196122532d 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master\n
    C: 0000
    C: [PACKDATA]
 
-- 
2.21.0

