Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494E52027B
	for <e@80x24.org>; Sat, 20 May 2017 20:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdETUgv (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 16:36:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53638 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbdETUgu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 16:36:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E645A201A7;
        Sat, 20 May 2017 20:36:49 +0000 (UTC)
Date:   Sat, 20 May 2017 20:36:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: [PATCH] name-rev: use larger timestamp for is_better_name
Message-ID: <20170520203649.GA13079@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes t4202 for me at "44 - log --graph with full output"
on 32-bit x86.

Signed-off-by: Eric Wong <e@80x24.org>
---
 This is for pu, I'm still using the machine I used git with in 2005 :)

 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f06498524..35409c03b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -27,7 +27,7 @@ static const char *prio_names[] = {
 
 static int is_better_name(struct rev_name *name,
 			  const char *tip_name,
-			  unsigned long taggerdate,
+			  timestamp_t taggerdate,
 			  int generation,
 			  int distance,
 			  int from_tag)
-- 
EW
