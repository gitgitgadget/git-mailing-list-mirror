Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0EDD1FF40
	for <e@80x24.org>; Sun, 11 Dec 2016 23:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbcLKXej (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 18:34:39 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:51979 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753930AbcLKXei (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 18:34:38 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id B6F94C3448;
        Mon, 12 Dec 2016 00:34:34 +0100 (CET)
Received: from drbeat.li (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 9556EC3444;
        Mon, 12 Dec 2016 00:34:34 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 5403720A5A; Mon, 12 Dec 2016 00:34:34 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 1/3] update_unicode.sh: update the uniset repo if it exists
Date:   Mon, 12 Dec 2016 00:34:23 +0100
Message-Id: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to track the new commits in uniset, otherwise their and our code
get out of sync.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---

Junio, these go on top of my bb/unicode-9.0 branch, please.

Thanks!

 update_unicode.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/update_unicode.sh b/update_unicode.sh
index 4c1ec8d..9ca7d8b 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -14,6 +14,11 @@ fi &&
 		http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
 	if ! test -d uniset; then
 		git clone https://github.com/depp/uniset.git
+	else
+	(
+		cd uniset &&
+		git pull
+	)
 	fi &&
 	(
 		cd uniset &&
-- 
2.7.2
