Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A691F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfJ1A7a (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54260 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728939AbfJ1A71 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 49A3C61C4E;
        Mon, 28 Oct 2019 00:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224367;
        bh=qFK1+arVRaCXFy2jGzo5wOaUlJzay7OdPUwgsfG5AeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SDLDQLyMZV8HTHHyqUYCAfi9gUmGKNQatekw+z7h4ZJguvX9MJHEAvvfUoclNX1sB
         5zM57imYWLpstjahDlSeOqjHgoR9UvvJBZ9TeYKC1gZB/VMZL7GOqXOh/SuJLygLHZ
         lZ3znvKKWSh/pEBdQskYdiG7uORT6aZdP9VEs7egYtPajZ9PkFSRY+4IfpoePjFY7v
         u4CrjxMLcxb0Aw0GxHtHAW1PDCjpRFqEY+jAapkosjA/KSDonwye6ISDysrJDzuDdJ
         8tVnmMsiiFae/YWv0c0bLrTKOY0YRTu1NcTN3p9+eFFNZfq0U0+IMf/88szM/2tzg/
         7sOB1LoRrtiy+8y+ywqurRcT7Ok9WlH97UbTo7PeC1G2y5qEXesr+C2ox5q9UsUIUA
         moerX8ypxXLVFMIt+BjaKaC2ssbB7htJKDzxhIMZjyLTxNr9s1FM1R0vPNyaj7jOnh
         SGPI1eF5mahd3VwURFVwbvYUDiCY2veyaT1BKtplAa2BkBvGerK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 05/15] t3429: remove SHA1 annotation
Date:   Mon, 28 Oct 2019 00:58:57 +0000
Message-Id: <20191028005907.24985-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test passes successfully with SHA-256, so remove the annotation
which limits it to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3429-rebase-edit-todo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 8739cb60a7..aaeac6eade 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -17,7 +17,7 @@ test_expect_success 'rebase exec modifies rebase-todo' '
 	test -e F
 '
 
-test_expect_success SHA1 'loose object cache vs re-reading todo list' '
+test_expect_success 'loose object cache vs re-reading todo list' '
 	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
 	export GIT_REBASE_TODO &&
 	write_script append-todo.sh <<-\EOS &&
