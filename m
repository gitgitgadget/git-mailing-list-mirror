Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D12207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 08:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754920AbcIKIDC (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 04:03:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:52708 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753808AbcIKIDA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 04:03:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lo2EO-1b7k6507lQ-00g155; Sun, 11 Sep 2016 10:02:57
 +0200
Date:   Sun, 11 Sep 2016 10:02:54 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] Export also the has_un{staged,committed}_changed()
 functions
In-Reply-To: <cover.1473580914.git.johannes.schindelin@gmx.de>
Message-ID: <185205f01e339e4f87284b2c59a9def38fdb26b9.1473580914.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de> <cover.1473580914.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qom3996iV7p5syZsETqaUK5nd5kBi8k9f6/KnClhtFAKPfEoKYh
 0MUmGZT+IYMbnnRZymMymUiiDPGGrDlSoZIHReBlXbtzAHGhSBKGiINX2MZHYc2geQ/U9tj
 ZHuWAbRgFpXVtLnp3g8AhGpaKooWjZeivTOpo5/QSUSD4U2Mm8LciQhSzNuCGRl8/1OLRn2
 eLoCaQXGyvEv2VLRI8CEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cmT3gCXLx4U=:Zcv76wquCWmnl82xZQrQsm
 tCq6qoUqNwDnbGzfiH76LrzjqdL642KMJSl9kc2ipZegGKtba6Y3EN1vZz3xERcEEIYnmUeLw
 se37LfdgKT+65NUDoX3abHET2O79e/2Y1+tsegBTzJ+HwS6uMp0OlgiyvKaJLHZnX1GgTHxbj
 WoiOp10sfOJC1A+nGka2vJM29agkOsCj3UI8+BKKVRTIwus4kJGTbykD6M6zoUCXzfTMFmalE
 Ac0GHIVxRM+0YjBb2bhGGRZiDwH0j6IeyJlagkU17OiAw2EnHaH4BzOBkWG9ZbAmD8mvs3zxC
 yNIbxE/jusq6m87cRc7Vh/2WnzfMIPQJ/nOp9GVRmyAgUvK8LNaPLwrasWImcntBh1b486Nx1
 VXmCDom3RXsPA3h1sA52MBmfj79tGBsEdrWZcQudMct9IaLDo5dq4VkIuRBnhe5EVzqFjbzhM
 LNoZ8LLp1D5hPRPvxHeFY0khvhABHRzzpp6Ffq181n1puJ7rLw7icGj2RnmIv7rFcbOvUjalG
 juvBUHoFqiE5GxER1nbgNj4QkNSXn5lyizbGRlKiDO863tI3c+bTIJx9u2Vy5rQHBckzJBOXe
 GeLsKoVEbxlLjFyCOf1eXd1P/2XulBztdoKIi2lPbY1stRtTiVqa+IxpKBlc9Yc3hpETYWSL1
 s1c/NFSW9utHL5cP5S7/IlDvCI9fGX7aZvzAsz+MqcVRNLJHq3WQNzjjonEfqB7mTaQkqo7Mh
 fLqEmKtCw9JQp4zvmskpX2xpdbcYSURUkJM2buFwORQpWW50Jm3wILcqqZWaOLXf1lGMLbVYb
 fqQdGcZ
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
index 9ab9adc..f1120e6 100644
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
2.10.0.windows.1.10.g803177d


