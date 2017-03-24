Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA521FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965008AbdCXSlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:50 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36850 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964821AbdCXSls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id u1so1658113wra.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwDYwYqzL9attduLRhabFp5q+qQsLdNvkblQK4x5SlU=;
        b=cMpsvA9GFRbVnLcqLPOzo34ku3PlxYlxW6m8PEVimypD8fIK+ZgXXQxR3ah2OYdxvd
         FuJrgqZipCTEEzw/cC/GH23dsnC8TuW6hqbKhdKfKiGaBrgKew+r6pl6AfxpF4zBk52H
         SaumiLvF24eXgi+uXklVE5GG14wASx/DHExiL3TeM6tBxF2XfGoP4af+U4ZznprPOw1B
         wGXguGk9/Uc8+TJmMlEFCzzPEem1BojTq2D6gFyI0hzmqSQnGI7KdAyWLXjlPhkzNkR0
         lrGlZ3zXdzfjRqDVBCVTLOH3I1wQO6ht8wPrQRwAhNAuGlmWhPon6MmkxIX4QK7xo/qY
         5N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwDYwYqzL9attduLRhabFp5q+qQsLdNvkblQK4x5SlU=;
        b=JUlMmudgTAWoYClkOBEtGdD9z6O+M5GOYx2OVCzEXmtVSYNXWQtZbl4j+DU0Knmj5o
         3K9vHsQ3kZgT+VulM5E3ZO39T2mBvI0Zu4a7Fwz8Zf1i9s46OXXFkeyXuaFEOvPSTsFD
         Y9cOrxelG62f3XpzOgshcnIjZYbYoZ3mxpM2Ao/ZbN/dnAyBmFkqhwZ2fUvaKnJA9BLr
         CZOgt+bIu9nw//b4RfXlZJJ2lJABqTU5BfPXiFQWxS6UNPyewceZnDTDmAB2IPjW/YdV
         jIQD+fnBrmzZ9EUXj4NvpAoMGLzl7y5mEOXIwBDgSLkZlzKNMDlrDSu79mKCm19RnLej
         Edag==
X-Gm-Message-State: AFeK/H3fQhBPHGW32mvwhtMCG/YikYJIP/lNMfIGJ3BPDXIQ0CcQpwL8GUYSGWqNg0S/IQ==
X-Received: by 10.223.168.120 with SMTP id l111mr6191470wrc.173.1490380900790;
        Fri, 24 Mar 2017 11:41:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/16] for-each-ref: partly change <object> to <commit> in help
Date:   Fri, 24 Mar 2017 18:40:51 +0000
Message-Id: <20170324184059.5374-9-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change mentions of <object> to <commit> in the help output of
for-each-ref as appropriate.

Both --[no-]merged and --contains only take commits, but --points-at
can take any object, such as a tag pointing to a tree or blob.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-ref.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index df41fa0350..1a5ed20f59 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,8 +8,8 @@
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
-	N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
-	N_("git for-each-ref [--contains [<object>]]"),
+	N_("git for-each-ref [(--merged | --no-merged) [<commit>]]"),
+	N_("git for-each-ref [--contains [<commit>]]"),
 	NULL
 };
 
-- 
2.11.0

