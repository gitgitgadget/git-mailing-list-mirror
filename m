Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1FB1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 16:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbcJKQPs (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 12:15:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:52821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753492AbcJKQPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 12:15:47 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MBmvH-1bkOgt1lh9-00AnkM; Tue, 11 Oct 2016 18:09:08
 +0200
Date:   Tue, 11 Oct 2016 18:09:03 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] reset: fix usage
In-Reply-To: <cover.1476202100.git.johannes.schindelin@gmx.de>
Message-ID: <6b6defb4164b07f4722c7e3cfa21648f7d4c0e87.1476202100.git.johannes.schindelin@gmx.de>
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UFrl1UL2yxUnP8kHTXQdbAROD4saJ+ROoGAq7Vzs+nggZBRLgSR
 xhMdeui5dGUV1L7M8oy12oq4hxn4sSDHI37AioVD/0OHRIvYX059zFGwOOza2szrlk2sNw1
 bO/Fr+42Z3pl5E8zBkuwLWebhM8KtZkd9iS/W9N6Cq0PcS1FQu8YYeolOQ/ssqTSO7EKwBX
 I/f/bd3Yb0WclKtfSnXCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aiQ0jWhtrxg=:tMTEaFD3h4rix9NCqxEGsl
 6Cw6Vum7SKMjwn+LtqLiP6zpiVSpNKC2KWJT0CTdZRhQncXS+LjrpSr/Ulxq+gW3/IjFcpQIQ
 LzPor9V6eh70TDw/QJia38y9MgOZUUlO5iXXQKC1t1OHnexonI3n9Z6rzlZvjjXdzZn74kvq5
 MstWAVKCHKMjESB5COI82gnySt5rDV0nbmg0pJYpR+wyYDAFMgZsykg5Zw6ei8rDRiNJC46Pw
 ZjhQu1f3ZltbdzZ1PvW4xPMOrnrFJv84B8LegnojIXcd57ziK+64thCnshzsTcIJ34c0uCF2U
 KqbN3E7qjPVH0Zb+IkFhp0g+myqsBAJsgrtrewJnDibE6NtT8pJhCq1apy7zD+wqaa6xHUG3L
 mlVGxfCbqFbxe1Sn1TL/rVlu61HXiVfgt6Br6J+fnK0wewGMn4xZzaROzDO89S2fatDa4cpN0
 MrwcAfpxoqr9/o21zLxDqKnQYniwc78OBMOUD6C42t6nHdG3v035lDO3kJP0bZi3Wdjim1aA5
 rlM6djR4K+CsL3g3A7Z44Z4DpOOCZ0oEc8lCJ7maFI7HCrvSc+hCOH0kF63np0nSeUNciLHCR
 u21u7adieKAE8z+nVl5n899gmMEMFR799jq/Va7AXNQAP3OrfPtM8n9suydpaFYp5PZOoe6mz
 EzRYX7kJa8Z5a6jXLQu4W7qmpmrpJIahq29AjRLN1AWnkN5uJJ5mzwzzGoQU+xx/DCkOFndvV
 vjcMNMcSxGBnt5hx0a3ISRBtDTlefD0azRxMvNfoLi5cVKiyAB2WJSuqKhhOTcodZ5FLxLgON
 UQlDUkt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The <tree-ish> parameter is actually optional (see man page).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 5aa8607..c04ac07 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -24,7 +24,7 @@
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
-	N_("git reset [-q] <tree-ish> [--] <paths>..."),
+	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
 	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
 	NULL
 };
-- 
2.10.1.513.g00ef6dd


