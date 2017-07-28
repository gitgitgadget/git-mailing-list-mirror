Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA432089D
	for <e@80x24.org>; Fri, 28 Jul 2017 21:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbdG1VkT (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 17:40:19 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38880 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbdG1VkS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 17:40:18 -0400
Received: by mail-pg0-f52.google.com with SMTP id k190so50200445pgk.5
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P3glVYO1QMwKZP52QJNFbJDNedKTi2TsVqNg31uhCRs=;
        b=OKCX3EPCrvVuVOlDpMlS65sml/KgBwCmZuDmi3tOWeVxX1V0e83k1Aq2WuU7AZmaL4
         4C9u2RcbWs8LbXrPDcGm8dliK+vrk1Fsz1kV/cF/ObzXtkAa+1j3RYTK6gQFqGPDzjce
         Ko1BKJBVUm55sJOe8/Z1WJ+ki29SX/VubcLucg+bl0vj/xldEqXlmtE0EVyLNI0epwtH
         R5tQYMZlT4PCkTGdD9VTksRkKC4DATwb8+OI7sb/SJSr7hLFvx98yudaN+8HyrCgu0ac
         QqHvMXOwQcHGvr95TXWOWDJ2UdM25+PDrOe7scPcos9eRA+SCJpQzrzbQHPT/wgtJKfn
         L+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P3glVYO1QMwKZP52QJNFbJDNedKTi2TsVqNg31uhCRs=;
        b=HaqdiAlZWffCjlFmGcL061MQIK4FD/9z0iWdERJ0b02BV0kKqVLBwO6N7zSxE6ogkF
         de9BUNQ1N4DQV2HjbUFv/v1tIsXiG2E8GZxdYryPWeo02Z9WsEJCXrUqeug13MC4fwr0
         ZeePrJOoUaEcSQkYmrvPWOlCnawgoUPXBcUTJaUWKaz0Ga+9j/fbih/qW2tMGAbBdDJB
         YYUQSXIcdeSxLNWiysJKbZJBaCmB1l1YNTX3P54hsLgyiSKql3jVbUxGKMyrTM3VmRNs
         +jHduLYo4uKBzZwqui8YUcmfKgywZ8wlU5wDIrgDU3v1gp4iXnk8pk61gjJk+KfJrcyl
         /C4A==
X-Gm-Message-State: AIVw1125dCYaByxMrwyhqrtWCLtpUkcKVpPRzF3HBlKITCvSAwdPExI8
        uAAA7JDgXRFGiLJA
X-Received: by 10.84.176.131 with SMTP id v3mr9427697plb.142.1501278017970;
        Fri, 28 Jul 2017 14:40:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:d18e:f3d2:e247:1569])
        by smtp.gmail.com with ESMTPSA id f3sm10520931pfd.115.2017.07.28.14.40.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Jul 2017 14:40:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation/checkout: clarify submodule HEADs to be detached
Date:   Fri, 28 Jul 2017 14:40:11 -0700
Message-Id: <20170728214011.6184-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  On top of sb/submodule-recursive-checkout-detach-head
  
  I also checked other man pages such as read-tree, which
  already mentions the behavior as the fix implements:
  
       --[no-]recurse-submodules
           Using --recurse-submodules will update the content of all
           initialized submodules according to the commit recorded in the
           superproject by calling read-tree recursively, also setting the
           submodules HEAD to be detached at that commit.

 Documentation/git-checkout.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d6399c0af8..84bd323a00 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -262,6 +262,8 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	local modifications in a submodule would be overwritten the checkout
 	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
 	is used, the work trees of submodules will not be updated.
+	Just like linkgit:git-submodule[1], this will detach the
+	submodules HEAD.
 
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
-- 
2.14.0.rc0.3.g6c2e499285

