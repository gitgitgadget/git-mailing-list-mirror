Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58EFF1F667
	for <e@80x24.org>; Thu, 17 Aug 2017 02:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdHQCxo (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 22:53:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33530 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdHQCxn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 22:53:43 -0400
Received: by mail-pg0-f67.google.com with SMTP id u185so7483767pgb.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 19:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QK+nFPSxVXdrBiVHQWIW5qD7JuOtBrDJ8azkVmbACpQ=;
        b=P9vJHcYwFr7BgFtAVKqZd+/nE6BaN+Q/qaoq3dicPmr7kbtl9xE1CaLbDHPwAuckZ8
         wUmvLjSPRkjDwFk4MxKfteN5gyWroFPhPq/3HVMNVWsa3zSjYpOc6OGB8QU4xn1kqkjQ
         /bAlZ9bKmMfQj2S6YOne/Alo2yzKs+Z9ihPAZns0SzHb7DDCizvDcvrVqU7I/L0RRd+I
         Li9N5yvhUWdQMFt/V27dJgp2EeU4FXMeg3lHH+Yd2L71T5tPQO5mx8qs182I4CZ17XL6
         Zhj6iwJgojCuyh/UHqwracRSxO/wA2PO5/kJblC0qZMG8sDY6oXDtQlcYAByugG96lTs
         559g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QK+nFPSxVXdrBiVHQWIW5qD7JuOtBrDJ8azkVmbACpQ=;
        b=E34uYLQ9jBA7ZP+YMKTA8HEa13TNUcY5xXYc97vaduS+qas/fGRXdnH5S803IDdOo+
         rSzwyN3hWvjrIGrOIva7z1+EenmP3oNYXPvUpR2h/hE1inP4cps4KKPmzKnllYscfL3R
         kV8B8EijX2IgjCcJnqtygKBv2wdAkX1HcTdcnOlf2B7sgmSLCAuRgy3yMNyRzQnDJBpm
         RO0mcp/34JOWFoEJKiuweOUtqW/36nvuP+3AKyWfi+fuN/cJ3R8fYHHW6muLsKSNlDnT
         cyEO+1bwszyQ513AT6J49Mbk6PO/f8QueL+8gaa7HvoqmVLrYNd5VxoRpgXUoM2sYuvq
         jHlg==
X-Gm-Message-State: AHYfb5iN7EgBaeRY6mBI7dk0LGCBzyJw9LxugkdmvKXk1Mz99Jj2Ly9k
        Xd+95wuPErPoWVRXvtRZCQ==
X-Received: by 10.99.103.129 with SMTP id b123mr3548267pgc.14.1502938422748;
        Wed, 16 Aug 2017 19:53:42 -0700 (PDT)
Received: from localhost.localdomain ([157.50.14.209])
        by smtp.gmail.com with ESMTPSA id 66sm4373696pfq.20.2017.08.16.19.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 19:53:42 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com, martin.agren@gmail.com
Cc:     git@vger.kernel.org
Subject: [PATCH v4 1/3] test: cleanup cruft of a test
Date:   Thu, 17 Aug 2017 08:24:23 +0530
Message-Id: <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoiding the clean up step of tests may help in some cases but in other
cases they cause the other unrelated tests to fail for unobvious reasons.
It's better to cleanup a few things to keep other tests from failing
as a result of it.

So, cleanup a cruft left behind by an old test in order for the changes that
are to be introduced to be independent of it.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 This was part of [PATCH v3 1/2] and has been separated as it seemed to be
 a "logically separate" change.

 t/t3200-branch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd37ac47c..b54b3ebf3 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -560,6 +560,7 @@ test_expect_success 'use --set-upstream-to modify HEAD' '
 test_expect_success 'use --set-upstream-to modify a particular branch' '
 	git branch my13 &&
 	git branch --set-upstream-to master my13 &&
+	test_when_finished "git branch --unset-upstream my13" &&
 	test "$(git config branch.my13.remote)" = "." &&
 	test "$(git config branch.my13.merge)" = "refs/heads/master"
 '
-- 
2.14.1.534.g641031ecb

