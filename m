Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C66520323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbdCVWTP (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:19:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35452 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdCVWTM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:19:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id u108so28765599wrb.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvllkpysJNVhbR5KeEAG3KPQ7kOhlkiJ2Usd1LQVYSY=;
        b=ZX0yi/SBlrOb178Hm8i/+zYiMaK0oJKuj89kMuNyf2yMgPmXP7lRWIh7LSzTN6c5rq
         pTqhMw8XTBXzxwBuYlJ1ldM1nSGvzkiECpUzMUmxV0avShJXw73TD10+Ajl6JRZpjCN4
         oVu+Km1FGpH+Uo7rsnkJ6gvieNwz1ec0QxY3NwZOYzgJjU/Sro+rsMKMSSq2slNw0ZDa
         S2UIxQZOsbvDZNT1LRFJb74gD4IRRGOi0l1RicucIRi7t6uEGNtUeN3nS7gvT130ognw
         TsN/zEqnIhFZU6W4p4XpNRkMVOytMxYc+trYZmZgf2+7TaRRJ8lguQnA2gBFDOmiW32C
         u+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvllkpysJNVhbR5KeEAG3KPQ7kOhlkiJ2Usd1LQVYSY=;
        b=nUhYuVhx7PZ5QFn44zHFPkMzmnX0icEsWOyAAfE6v3LZKVQZq8Ckyl1oy6CmpNAXd7
         c01rwBPpDfkD+BZUwDoLy5H91h/rPdEwJo3j83NdLNuz30IHANcQJo+kyAohah7md6kY
         OBGmEasy6a9VwJnYQXX8Mn0VNtQc35f5ksx6Sq9xzJBSXCEYPmmDJFraUlL/lYIrIay2
         Y5I+94YcJWPkJ9evzNg8qJ7aLMBaN6Ms6HqSStiEZ5hasTsZlYs/QBbvXxbuWp5ELffV
         cuGq/u6iXTEs7BpN735HsqZxGwORCpWHihYJq2Uhm2+aVbX9J8eL6xl2vnbRf7wN8zHI
         gsCA==
X-Gm-Message-State: AFeK/H1DMzLKs3DFkQ+gbEiLVxCnfSDPPeMAobGY0elZZwC1WdIN5wOTBP0RIZhrqku1lg==
X-Received: by 10.223.150.81 with SMTP id c17mr5606216wra.85.1490221150067;
        Wed, 22 Mar 2017 15:19:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 190sm1916706wmk.17.2017.03.22.15.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 15:19:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] t/README: clarify the test_have_prereq documentation
Date:   Wed, 22 Mar 2017 22:18:54 +0000
Message-Id: <20170322221854.10791-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170322221854.10791-1-avarab@gmail.com>
References: <20170322221854.10791-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify the test_have_prereq documentation so that it's clear in the
reader's mind when the text says "most common use of this directly"
what the answer to "as opposed to what?" is.

Usually this function isn't used in lieu of using the prerequisite
support built into test_expect_*, mention that explicitly.

This changes documentation that I added in commit
9a897893a7 ("t/README: Document the prereq functions, and 3-arg
test_*", 2010-07-02).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index 89512e23d4..36813cef94 100644
--- a/t/README
+++ b/t/README
@@ -612,8 +612,10 @@ library for your script to use.
  - test_have_prereq <prereq>
 
    Check if we have a prerequisite previously set with
-   test_set_prereq. The most common use of this directly is to skip
-   all the tests if we don't have some essential prerequisite:
+   test_set_prereq. The most common use-case for using this directly,
+   as opposed to as an argument to test_expect_*, is to skip all the
+   tests at the start of the test script if we don't have some
+   essential prerequisite:
 
 	if ! test_have_prereq PERL
 	then
-- 
2.11.0

