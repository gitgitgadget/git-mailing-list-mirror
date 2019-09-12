Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB9B1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfILWM6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45683 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfILWM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id x3so12345551plr.12
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlWj364C5MMPXXkhDN0K0cb5eWZpc+asn3Q1cJaUPW4=;
        b=oTMhiWo1PolHXJPqMUTnCToi15mk8CBmbamIONzTlRjer6HbNbUTpyTFnZ8nasduHr
         B9ix1UYlaU7tO4xC+PR5OLIlhCVlyv+mJnzVT0qLwD0kcWY04EpSQw6TAeI1ZO7vIqgD
         LEo6+EGaIscyByW+018aKLMczvrBY3YkOfA4JgdeaPF+cr5tpkcR7WLgeGpMKclwnqmq
         7Lnx8LxmrGLiDipjFyvrsnToxxTBFdMerRceJi4bMzMECcdguE0PtLYLjstj2lo4UHfm
         vLHCDDsHIKMty1abvGzgO+Qs0F6G0VxDEsMOVwmL4SAwiLghU67peBsiWzpdnImlIpi6
         R4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlWj364C5MMPXXkhDN0K0cb5eWZpc+asn3Q1cJaUPW4=;
        b=JR+WYGiPQV5vKw/mABmy1toNruSpCLi1q4g9+HcuWzN4bpmiNHm51peW93heF0Aqzk
         lFgTxGabrdYgYCbcVISjSvrShbwQC8KKS7Si5lnahlvmkMSH7FPo8fGKibX8VWBvFFMa
         lrlPwBl/4AfGk+ZF+y55TOUYHUKRjc4FHjhR2BYYCbEVrJi39NVnit3XJT0/fkZfOhMI
         nkYId/4/fo6VBp3YiNHIRHM92gd2gve8iJ/pY/2Jd5ZnzcFuMTNwk91avmrdH3IWcZVa
         MQ/yGsd7l8lD5KzY0rnU5x1RQnaXHfoap4vB4hhdb3YozqKFlBPG5xNa5h8/C8aD8c6b
         eusw==
X-Gm-Message-State: APjAAAVjjm2TpXrqB9JmCQa99gz0QwfQOx6QPGvwZq/z0r3Iis24V5qv
        zUFnJh/pnuEpLqFYw5mJ5qIbHdheVRo=
X-Google-Smtp-Source: APXvYqzDZOWckKv7yjIyzV41L9+DdK+DveAo//dL0UnxzSr52Rvu1hHnqiP89R2LpWVa4aqG+OV2JA==
X-Received: by 2002:a17:902:d898:: with SMTP id b24mr47127711plz.7.1568326374570;
        Thu, 12 Sep 2019 15:12:54 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:53 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 08/12] git-clean.txt: do not claim we will delete files with -n/--dry-run
Date:   Thu, 12 Sep 2019 15:12:36 -0700
Message-Id: <20190912221240.18057-9-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears that the wrong option got included in the list of what will
cause git-clean to actually take action.  Correct the list.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-clean.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index db876f7dde..e84ffc9396 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -35,7 +35,7 @@ OPTIONS
 --force::
 	If the Git configuration variable clean.requireForce is not set
 	to false, 'git clean' will refuse to delete files or directories
-	unless given -f, -n or -i. Git will refuse to delete directories
+	unless given -f or -i. Git will refuse to delete directories
 	with .git sub directory or file unless a second -f
 	is given.
 
-- 
2.23.0.173.gad11b3a635.dirty

