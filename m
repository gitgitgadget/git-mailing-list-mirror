Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF84D20986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938957AbcJGQJD (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:09:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:55928 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936461AbcJGQJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:09:01 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MEtba-1bh2Rs0Nr8-00FxZY; Fri, 07 Oct 2016 18:08:58
 +0200
Date:   Fri, 7 Oct 2016 18:08:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/6] wt-status: export also the has_un{staged,committed}_changes()
 functions
In-Reply-To: <cover.1475856491.git.johannes.schindelin@gmx.de>
Message-ID: <190c3b874ba671240df0a7d5f71c0a611357be3f.1475856491.git.johannes.schindelin@gmx.de>
References: <cover.1475586229.git.johannes.schindelin@gmx.de> <cover.1475856491.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VoAGApdhgH8JAwT8as+KzI6/ra0tAaUNMVxDixAOVKMiP/Rq6Xs
 inPraBoqFutCKtT/UJn+7BTtWeEPBmGXu8lR4a5Bb97HrQ6p0z9v8V2435R1T2PRPWBTfCb
 L32zsXGWrWiYec3yb/9He19bteDiH3AYcy6bCH7CgxvRQQ6AHIRJdpj+6jkDp1fr2p2KO03
 BB9iTdkBzWjq5g3tRF2Tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HtdVrCFEHMI=:HBSr9jeuU3xzIIDzqCcFyu
 DUDgfeKxDWFSUNMH/DtTdl9gZsGyWqwQrA0AtTcdNuZ/tbiGSlEtcizlM69JGh1kTWQGF7OMd
 vMeD4QK2u0CVgaaoGFWM0kc+9tb4K60wfDngma/Jej8qI2a1/ehlp0lYkzkWlUqW8qqfR8Ca/
 7/kYj1hiKjc/dXIG31hbNZcWrxTewKhG1vlpFpVjNi7g4ie7fMCXXw1Wb/vmMEIUBCusXDywI
 JGQmFUtA0Wr9rgaQK3vVFutYA6E18KSU64aDjnVM4oxtnkHV0iOg7iKgJf5OLJPka/cBS2hNX
 CDQaC0QUuQu42aRXnPDtW9uTfduhhWAQjd7HYu9JXbxk7MYqI6AUmR2DooGuKMpZOfzRnbJtR
 EiPiKsUCU+ZuyXhlc7v9RzINvtuwtXChLxgMuOSDtotumnx4UIJdqWvIPf6zwUSkR1+tWhCwe
 kZyvm35BgoJ2cigu7u3z9VeYpvJ1X/rLcW3nl+EFDmu/AXcuVncJgHqYaEW1LbFyLdrt01uDF
 zu995DIspMR6PabdEl7rxtCQuvp52LZ80ZdVQiIfzEfqfmYTfA5n/8NUc8zbb9VefUyrIwSfu
 hflts5lpi9BT2ZeR3jbwXrrMEdXowyqky9svJLr50yi/t2gUhXbvuvX1YG/Nxmf7UxReewqXj
 Bqk2fw5+ESSrl0sFlwXooZTvT2u7i6X4BMWTfvoQE9pGkh9T5W40L1G0T1196RmvzdINcShRN
 TmCoQxtpnAh/Br3vujR7cn5VImeALFPcZZHBskau4DZwLuDJ4dQsJGfDwxBtfcfVY2vsHgiJ9
 kNRLs66
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
index 89475f1..8fe7d0a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2213,7 +2213,7 @@ void wt_status_print(struct wt_status *s)
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
-static int has_unstaged_changes(void)
+int has_unstaged_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
@@ -2229,7 +2229,7 @@ static int has_unstaged_changes(void)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-static int has_uncommitted_changes(void)
+int has_uncommitted_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
diff --git a/wt-status.h b/wt-status.h
index 68b4709..68e367a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -128,7 +128,9 @@ void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, .
 __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
-/* The following function expects that the caller took care of reading the index. */
+/* The following functions expect that the caller took care of reading the index. */
+int has_unstaged_changes(void);
+int has_uncommitted_changes(void);
 int require_clean_work_tree(const char *action, const char *hint, int gently);
 
 #endif /* STATUS_H */
-- 
2.10.0.windows.1.325.ge6089c1


