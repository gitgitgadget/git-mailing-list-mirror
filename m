Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB29C20451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbcLMXoR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:44:17 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:56378 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751913AbcLMXn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:43:56 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 6CC71C344F;
        Wed, 14 Dec 2016 00:31:52 +0100 (CET)
Received: from drbeat.li (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 4CA5DC3447;
        Wed, 14 Dec 2016 00:31:52 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 0C55D216DE; Wed, 14 Dec 2016 00:31:52 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 3/6] update_unicode.sh: pin the uniset repo to a known good commit
Date:   Wed, 14 Dec 2016 00:31:41 +0100
Message-Id: <1481671904-1143-4-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
References: <1481671904-1143-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The uniset upstream has added more commits that for example change the
hexadecimal output in '--32' mode to decimal. Let's pin the repo to a
commit that still outputs the width tables in the format we want.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 contrib/update-unicode/update_unicode.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/update-unicode/update_unicode.sh b/contrib/update-unicode/update_unicode.sh
index ff664ec..9f1bf31 100755
--- a/contrib/update-unicode/update_unicode.sh
+++ b/contrib/update-unicode/update_unicode.sh
@@ -15,7 +15,8 @@ if ! test -f EastAsianWidth.txt; then
 	wget http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
 fi &&
 if ! test -d uniset; then
-	git clone https://github.com/depp/uniset.git
+	git clone https://github.com/depp/uniset.git &&
+	( cd uniset && git checkout 4b186196dd )
 fi &&
 (
 	cd uniset &&
-- 
2.7.2
