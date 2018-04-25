Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C941F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbeDYM30 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:29:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:53215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753142AbeDYM3X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:29:23 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M6wWn-1eQL9t0mCj-00wlvT; Wed, 25 Apr 2018 14:29:16 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 11/17] rebase --rebase-merges: add test for --keep-empty
Date:   Wed, 25 Apr 2018 14:29:14 +0200
Message-Id: <23a1e05c64edc54c15f6d22c5fd6120b3711fd2a.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:N0vmB5H1nezbv33S4qA7lMA4dHOKYyOX7s7So3uDESvl6K/fmPO
 2/p7QTRQQTqs5OVeZgDzjZPWh+PmRu7AJq60ipOJwGsUhROYC+MaJS1+GlDQOt9LvRmkSzM
 wWtVbIcr/pOpwxaFXNXAKqOb8oogYsq2S9W/8tbHUHMvPJHPtbbfWChNe7ZAtWnKqo8xD/j
 1fyq+LSI6n5inUwmUQiTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5Nm70tsE6YI=:oIC2pmSQlpJhEXktbdxFWS
 HJUGbulUxZucc0tgTy7EbwT54Me/07nnPUYEZNbafnQ7xmcH3hoOesnWjTiaoY+FWq2BIEr4A
 lBhr2ITeJRJt2pes/D22atq9qdQ4f3mH6A15zF3zj5htpwrCwiyMXKRn0CSWqRUaBJ5D5VQLl
 1bWZY2M65aWEK4KUXVCLp22w8eaSawZnyQKGkXcS5MIovxMy0hJc4at3u91+/525UhPt89W4L
 MMEokPW8mz4NXVCmB4wvIr7Swf0f8vLkAq6F6VjM1Zp8CLbU69Z2owLNxLEwi9AsoT30zoOL+
 0TxBjQY02YgdKdPVhFcPZSw3lK5Fx57PfliER8G98DBdsYm1i743a0it5Bn5Xms7nimIhWmVv
 vsEMPct6/S9LMKxgicS5qTF64EaAfNON0IQ9KpLtK5tvofe/oFmILF/8ZTJARhYhubJdLS4/s
 C+G/UsQSqE/1QrGByMLFY1eyYG7V27NySvsKuXfY+bBmN4HQC794NCmE2h3OkNpi+fjSoI/WZ
 y3k7e6gLZL5p14S98zkmvPaVBRrNmv4ZwQmLv0+HEWaKeB5VWuve+s3mhs4bGw2fKoGGXJCJP
 mkaLkvfxo/lKixao+Kfwq7YVW30XHs2XZMvcSeKKUcQ6+3fOnkRPrzdgoxlWeX2XJomX5J++v
 nh2cgYkgrAbf2vZneT4K5SqH8FbJi0PMhxpsztpk7AueVycZu/Y2Ebq+V2NRoZSVEnKX7SWx0
 UAm+pdHeCKiN5OoJwfBsIqOd/ZQ+wJIeoXJwOJH1+nYTJY4+k2stUlM9mH5I3gixUuLyfuPaM
 IKoaE3LzhLgQESAa0D7ZCEukyrXzHJbuZMPLlq4nDOjume2ZSugCsZdzekhqhwPNzZXFURS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are empty commits on the left hand side of $upstream...HEAD
then the empty commits on the right hand side that we want to keep are
being pruned.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3421-rebase-topology-linear.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index b078f930462..e7438ad06ac 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -217,6 +217,7 @@ test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase failure -p
+test_run_rebase success --rebase-merges
 
 #       m
 #      /
-- 
2.17.0.windows.1.33.gfcbb1fa0445


