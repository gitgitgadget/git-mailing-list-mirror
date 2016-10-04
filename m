Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD0220986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbcJDNFu (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:05:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:56579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753807AbcJDNFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:05:50 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lm7MT-1bHnY11gBt-00ZhOK; Tue, 04 Oct 2016 15:05:44
 +0200
Date:   Tue, 4 Oct 2016 15:05:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/6] Export also the has_un{staged,committed}_changed()
 functions
In-Reply-To: <cover.1475586229.git.johannes.schindelin@gmx.de>
Message-ID: <017586232230ad87dd7cde5801e011cce9255bc0.1475586229.git.johannes.schindelin@gmx.de>
References: <cover.1473580914.git.johannes.schindelin@gmx.de> <cover.1475586229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1FgjfPblTeIBAzKbd8w5FeMRjnk2pPkYWloSnNBZOYegKbJC+Lz
 vuxz1cufalj64J6VIPklX4w6NZ5Acq78FegL4TlHb2ePZkn/874W9aHXFj3uA8QQccsWf0+
 mi1qSxL+kTDk1d6cbFQe0j6ethOnudGMTcHTw4XxwlI3CqCMuhqvOViQiolgIClRrCTTEL9
 tcJGL9ZnapvAyyfuqL3aA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6ZfeP0jpER4=:1p9Hl0aItRKBjB2/P1QOcP
 VKDOwUYIMZC8W634w7bVZzp0ayyykAkm6lKL+SyATmWpBzx1cdLbaZbw6zy0WUwRb2fuDTFj4
 ov/P1F6JwBBGXUMdOEc+3v3pmo5g6BuK29ZaR2qe7+jJsHP49h4TgwORaqUvjvIGEZQdlqffd
 8BT7TM9VvGTA1xqi5dsq7oHCG6A8hQOqXc0/rgd8kK0ibhEtH3S6QzDD+UlazyIpj3jgdV2NG
 dgeS/kZTRAPZEDIKu5kvy0Xs6Ock+spFDlQ9wOA3toZwVq/7dB4Eb5cikUmadKZEz8d+yfslS
 otRKGVruJVWurMgANu7CPduMVOQUxIojJsOcxvShHLYE9L0LwIiTMDfrdbczKQ2sZKu/ceM13
 BqCbxMFCtkxa+24W35UPCz9N8Xd4Mmlc7l6lCrpDdoQMLEijoP4taPb1xRZKVXZ9h21rPgtUv
 eOqxgsaYhddjd4bxt4/U2ezuDVfmFKnXz79/F6Kq+Bz9gyBtX4q9R3Ql9/bIYzdkeP6ado3cM
 10jvLOGheFG664/Ce5KUa6ThWUl4iF+QpvRQUVYmNYr6a/AGnuCpTmnjYCIaqANIS2HR7rnUP
 nFCloqxs6pgIlKGRusiIqoeW4Zatszy1Mko39ol13KmgR1J1nZD/7pVVFU4z2KopEUJD4jBOX
 9TkBDXsLNJVo97yx6Xl61IHwWGA7H7J816uwX6QiyoLlqJCIZIVdEAS2W+d2cPxuoKfQtVZ7F
 KjEo1GuYYZLQnZLJP2FDT3OWS9k5yauTQERiojjuJu6QzpwmxoFNawk8R2cw23SggqWZ1cdgq
 PYGdLKC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They will be used in the upcoming rebase helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 4 ++--
 wt-status.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index b92c54d..f4103e4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2214,7 +2214,7 @@ void wt_status_print(struct wt_status *s)
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
-static int has_unstaged_changes(void)
+int has_unstaged_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
@@ -2230,7 +2230,7 @@ static int has_unstaged_changes(void)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-static int has_uncommitted_changes(void)
+int has_uncommitted_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
diff --git a/wt-status.h b/wt-status.h
index 03ecf53..68e367a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -128,7 +128,9 @@ void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, .
 __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
-/* The following function expect that the caller took care of reading the index. */
+/* The following functions expect that the caller took care of reading the index. */
+int has_unstaged_changes(void);
+int has_uncommitted_changes(void);
 int require_clean_work_tree(const char *action, const char *hint, int gently);
 
 #endif /* STATUS_H */
-- 
2.10.0.windows.1.325.ge6089c1


