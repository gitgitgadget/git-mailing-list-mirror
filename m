Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001331FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdAMADZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:03:25 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34068 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdAMADY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:03:24 -0500
Received: by mail-pf0-f179.google.com with SMTP id 127so20517742pfg.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ve2LvAo4Itc62fXCXGuP5hprYWtBFs8M/Tv0YMU9HUQ=;
        b=KFM7LWmPIFxBq2GGEJVdkkKhQUhLU4LjltlePlRW4PJUrjmmKMifZY8Nb5/d/Xv/CZ
         s230aDZnWpnb9HJR+PImU/0+3hm0qisCdSUecSxX9EdigKB8YfI8amFW1yK/2x943t9g
         Nb4ZDalvkijlgQMSUL9FFWtz9hY5haFc63oWJV+RyauPyJWSmiDUZJh1tvWRdi6e5Qvo
         0spbecYhKnPSHmrs57nUT8n3qpUgmcEUnfIlaSmL2Tr2KNzCng+SY1Nbuc9yZobcSkFo
         tWs4wQxG4V4JBOxhKpHlteKXVO078abou9Te4H5V3d+jKNjKj8zgnj7daKl+i9GTLFd2
         LFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ve2LvAo4Itc62fXCXGuP5hprYWtBFs8M/Tv0YMU9HUQ=;
        b=EXwy/y8TVAdCoGB49uRjgxNUyn1QkN1iNbUdg2SdgfhYRjE5irCQQoo6AC77+wz7Sp
         BvyrC0/7bO++ntd6NgPkGx0WrN7CfqqgK7Xs0lqd91M/R3Olf7skbf+nIvmN87guXH0s
         SSy9DRKSWkz/Qvm2n0RoC6mPUYEz8ZkuMR14SYMZANMJTF2PwcIhaf1VLZmmEHEu+ja1
         bpOCvFVFSpIJFWBvPt4A/E4pGAcHshOmnmZ7JEDCzUB/f1MUr8xEWlVGJ+fQVp5zz3kY
         qj4y/1IpENmHm0WRegVAmvNn4fNROAZeWQmvMQ+En4ir1qtwhE4jydBWwti4JmgF3Hns
         nkCA==
X-Gm-Message-State: AIkVDXLgc5uSpdpSa6W+adt7rcuGStWAJ5IioDQOHTrxPdRSPh7DzP9+jJJRafKcha5otuah
X-Received: by 10.98.87.142 with SMTP id i14mr19326446pfj.85.1484265246719;
        Thu, 12 Jan 2017 15:54:06 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:05 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 03/27] attr.c: update a stale comment on "struct match_attr"
Date:   Thu, 12 Jan 2017 15:53:30 -0800
Message-Id: <20170112235354.153403-4-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When 82dce998 (attr: more matching optimizations from .gitignore,
2012-10-15) changed a pointer to a string "*pattern" into an
embedded "struct pattern" in struct match_attr, it forgot to update
the comment that describes the structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 04d24334e..007f1a299 100644
--- a/attr.c
+++ b/attr.c
@@ -131,9 +131,8 @@ struct pattern {
  * If is_macro is true, then u.attr is a pointer to the git_attr being
  * defined.
  *
- * If is_macro is false, then u.pattern points at the filename pattern
- * to which the rule applies.  (The memory pointed to is part of the
- * memory block allocated for the match_attr instance.)
+ * If is_macro is false, then u.pat is the filename pattern to which the
+ * rule applies.
  *
  * In either case, num_attr is the number of attributes affected by
  * this rule, and state is an array listing them.  The attributes are
-- 
2.11.0.390.gc69c2f50cf-goog

