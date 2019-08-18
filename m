Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D744A1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfHRUFk (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57972 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727127AbfHRUFj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E4E166075D;
        Sun, 18 Aug 2019 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158738;
        bh=bgbXKTiJM2m/x6P3P/dWn8KaL5uLExsrWPeawxx3dzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hIibQfkSMqUsD2HdraGMGVMH3oXA6SrarQ13wd6KpDhEvBRyRSJ0eGoJUZvKan1ZZ
         vJNc4qZf496g75ogDNLXmUVHCt55vP9eeF0DYUjZo9NjCEpDoMT6UHL2u0GpttaX9r
         /hNRDcwsVONU6a3FJ+VQJMUnGDavivrdPTExyGPhmAI5R5PSkHENTcyaiEBCwiaqLG
         OXlnndV/ez9S6a+tqyzWJuAEHG0CKNq6U+A6pP7gt5oPHDZUcrIOwoP+5Og9RyrTwC
         L5AXzmJh6ljz0fkGnxMGhXlEqtTpd639mufPNk1R41JcI/ILLIHJPVxIMm9g4ziXaZ
         eFokh00Krkd/fGDErQMBb0/7cxkypanojpIFRPFTtcws3syC1ABj5B/pw0cUt3xCsR
         yrZlE+yNrNB05ylflkqswGrGLR5WFHTQ/M8Fc4Kzl5Qew81bNqVJrdRo2pw2DGoEem
         q/YyYf4yINnwX2Wo9LusVFRlMtiA5ZtUmP9eDvs9V5Zmng+r6Pl
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 11/26] combine-diff: replace GIT_SHA1_HEXSZ with the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:12 +0000
Message-Id: <20190818200427.870753-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 combine-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index 3e49f3bda8..d5c4d839dc 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -930,7 +930,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 				 int show_file_header)
 {
 	struct diff_options *opt = &rev->diffopt;
-	int abbrev = opt->flags.full_index ? GIT_SHA1_HEXSZ : DEFAULT_ABBREV;
+	int abbrev = opt->flags.full_index ? the_hash_algo->hexsz : DEFAULT_ABBREV;
 	const char *a_prefix = opt->a_prefix ? opt->a_prefix : "a/";
 	const char *b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
 	const char *c_meta = diff_get_color_opt(opt, DIFF_METAINFO);
