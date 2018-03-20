Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44DA1F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 10:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeCTKDc (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 06:03:32 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:14047 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeCTKD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 06:03:28 -0400
Received: from lindisfarne.localdomain ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yE6xeoWARwheayE74epmBI; Tue, 20 Mar 2018 10:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521540207;
        bh=M4zWhaxudfhaVu6iuSeY1EDuRSodX4saRzsHTSg+rNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=BCT4+aBVBpqVXupmDWOeafPfhCa8GI4mYLDvLYAEwQHC0rqejmMt5qdzupTKDL7cU
         HXEz+SdW0pxZjIwYvDwjEEbKwUaLRI0YIK658pRllPc61WC4KVOVuZiScEmoPy1Zpu
         G7Y/AJHxADZn2Wnzlqpcdbp6gigIibh8obczxPkE=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=evINK-nbAAAA:8 a=HG7MIjCWz1BSLuqdSQQA:9
 a=JOpf-eMWwQtdPOWe:21 a=f8ZNNBkSgMVkuchn:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/3] rebase: respect --no-keep-empty
Date:   Tue, 20 Mar 2018 10:03:15 +0000
Message-Id: <20180320100315.15261-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320100315.15261-1-phillip.wood@talktalk.net>
References: <20180320100315.15261-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfDkKhgeVK+ddhF82Qb0wo3zwdT9N1fhObOo8ayQYCPWGPo+wmELpRdCGZTU71XRL16IwjdqHw6XMzrr3FnrWGlwJr1zhlmEEaGbHzCg9yhwLu2sJNyxj
 f5Gq9JnntMKiXRKk7caboviMc6QY5oCRP/LkLnKTKfNeUtV+zOpruXkSpyLDajtX5c5v2+/Q+FAhr+7dqvX1nzrW4A4wm3b4gCw3gaMVKq2Y1PaH+omYL0/o
 tqq3tS4zjjiQ89eY01cA9bTnhhM7bKaxvrs0dRUQlWrx7pqcw47yn4Nkf48idyVp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

$OPT_SPEC has always allowed --no-keep-empty so lets start handling
it.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8b1b892d72..37b8f13971 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -263,6 +263,9 @@ do
 	--keep-empty)
 		keep_empty=yes
 		;;
+	--no-keep-empty)
+		keep_empty=
+		;;
 	--preserve-merges)
 		preserve_merges=t
 		test -z "$interactive_rebase" && interactive_rebase=implied
-- 
2.16.2

