Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952431F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGHXhL (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54392 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933201AbeGHXhF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:37:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2617260746;
        Sun,  8 Jul 2018 23:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093024;
        bh=Ap+QAgdEkJmXFt0TtB6P1WeQ+zavQ2lVgwmsqY/u/Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Q8+H77rBL+wN4jI/HsaBWfJX57ODJ7nYxb9vHI9163kcqOSvc7DhohBm7lFvpFqzN
         qykFdp3nsyKG5CSxNsFZb+l/bC0dw2GfAjqgxW5t01XWFDFV9QGdQIr9WsG4a0PpFu
         OphMCNA/CDeNa0PYtFy8TL1cu36Oz66PF6tAI+N9GVIOkDKcpkB+FSCbirI289NfkL
         WGWiwtZlnKKqhF3QYFPDXe8JlaWa6U1dqWVjMjNLeBIkgoT3LVlGeWJHs07V9Oe8z/
         QQNBCoYxNDrVadops4kYvJmg6f/Y73P45P6YB0BoWIEUzuIZkiySB5XTdz6NUFSgi6
         lzipJ4s/HuNmnu5byBEvegPu/7sDY3/zK0Z/HN1CcYwDheXiG/fYGJwSjrbkuIyLyi
         Srk05/G4t6oDF+lr4O/SF/JjzgiZzzKYQhptG/g2+Os9ojTycZEz/ldNkTwC+3rcVZ
         fxKUVFHuHaR+yRSWCXEIPWTNJk02c9lR8hWumgKeCEQi1QAtm1S
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 15/17] log-tree: switch GIT_SHA1_HEXSZ to the_hash_algo->hexsz
Date:   Sun,  8 Jul 2018 23:36:36 +0000
Message-Id: <20180708233638.520172-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 log-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index d3a43e29cd..9655de8ad7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -545,7 +545,7 @@ void show_log(struct rev_info *opt)
 	struct strbuf msgbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
-	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : GIT_SHA1_HEXSZ;
+	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : the_hash_algo->hexsz;
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
 
