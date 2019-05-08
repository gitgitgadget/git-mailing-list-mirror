Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725601F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEHANM (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38389 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfEHANL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so4529942wru.5
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egxeRZ0jBIHNCIEs98FZxVkqchu8J9mt89jBuwoOlXg=;
        b=lzyRMos4lfY9peqr2vjlQewXuNHnz3BOqB21suOeox8bLkblDB1KPql2RtwJyo9C8e
         jDYkU+QIMwXPyh5WSe/SJ3N3N/spRulSCUb1AMJGlQCJhK5O+1qtHB0PnASqQBZxvfwg
         R5CDfPsYnVMTh6dYGGMEJI9OeGg6qDhJ3r2U8Wdp1PP6gO4bXc3wv/MzJmMQA9Sgou/w
         7R3FbM+g3TYaVgvsh2FIoFTWTkhpV0O6U9yquIsTyKUVeH3gsFLX5iF347luhaa8wAtx
         GyVmZ92cduc8K65bmxyyKft1RAAxmeZ2iSlbZ8c1MgmSaxeEu7rnQMKvKcKY3Y+nKvu/
         Czyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egxeRZ0jBIHNCIEs98FZxVkqchu8J9mt89jBuwoOlXg=;
        b=jidLVNNhCUcfpKnH8cUmNzwt3+qbvif9qT/+vDGFhWwnZ6VbVz9iyZxj67nR7ai5Ux
         Qxp+DWohULxYzDql+H7CExzQJr9f6hoFt3ECU8693kZdx3597OgGy4G6YSJbPajmubW4
         wYkjnOYiRk9ZF07gU3UA1Q3/iI468QINEkPJmaha2qUJ0G7nQYMknT/V0oYfsD89FW/u
         a0yhdyiwdbN/Ia2bNdUCoZp0UUqNGDmYMKvrnQsjLi0EEEyXS9tIW5xeEW3L5LgfrSn8
         xm4lj6W2IuG0d2onnf8baoPrRe3bNvzdZ3l+S7MTouL4TjiOhtC+6yFQpO/KenqNyN7r
         Y9dg==
X-Gm-Message-State: APjAAAXy9r5m0xe9bVe8jtetAuADyydIlt4u5pDZEDJ2F7kvY9mUUy77
        3wLT5BTqBT7OZqKhNr1FmlI/CJnkjHU=
X-Google-Smtp-Source: APXvYqwVlSa7mNPxeyrK4PJSFQnOa2g0nGRoTXr5nIF6O6gipkN6w+EzN/tQK0/7YUBkUEy0P7htkQ==
X-Received: by 2002:adf:b446:: with SMTP id v6mr9024775wrd.30.1557274389319;
        Tue, 07 May 2019 17:13:09 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC WIP PATCH v8 02/13] t3432: test rebase fast-forward behavior
Date:   Wed,  8 May 2019 02:12:41 +0200
Message-Id: <20190508001252.15752-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

When rebase is run on a branch that can be fast-forwarded, this should
automatically be done. Create test to ensure this behavior happens.

There are some cases that currently don't pass. The first case is where
a feature and master have diverged, running
"git rebase master... master" causes a full rebase to happen even though
a fast-forward should happen.

The second case is when we are doing "git rebase --fork-point" and a
fork-point commit is found. Once again, a full rebase happens even
though a fast-forward should happen.

Mark these cases as failure so we can fix it later.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3432-rebase-fast-forward.sh | 72 ++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100755 t/t3432-rebase-fast-forward.sh

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
new file mode 100755
index 0000000000..f49af274e0
--- /dev/null
+++ b/t/t3432-rebase-fast-forward.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Denton Liu
+#
+
+test_description='ensure rebase fast-forwards commits when possible'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C &&
+	test_commit D &&
+	git checkout -t -b side
+'
+
+test_rebase_same_head () {
+	status="$1" &&
+	shift &&
+	test_expect_$status "git rebase $* with $changes is no-op" "
+		oldhead=\$(git rev-parse HEAD) &&
+		test_when_finished 'git reset --hard \$oldhead' &&
+		git rebase $* &&
+		newhead=\$(git rev-parse HEAD) &&
+		test_cmp_rev \$oldhead \$newhead
+	"
+}
+
+changes='no changes'
+test_rebase_same_head success
+test_rebase_same_head success master
+test_rebase_same_head success --onto B B
+test_rebase_same_head success --onto B... B
+test_rebase_same_head success --onto master... master
+test_rebase_same_head success --no-fork-point
+test_rebase_same_head success --fork-point master
+test_rebase_same_head failure --fork-point --onto B B
+test_rebase_same_head failure --fork-point --onto B... B
+test_rebase_same_head success --fork-point --onto master... master
+
+test_expect_success 'add work to side' '
+	test_commit E
+'
+
+changes='our changes'
+test_rebase_same_head success
+test_rebase_same_head success master
+test_rebase_same_head success --onto B B
+test_rebase_same_head success --onto B... B
+test_rebase_same_head success --onto master... master
+test_rebase_same_head success --no-fork-point
+test_rebase_same_head success --fork-point master
+test_rebase_same_head failure --fork-point --onto B B
+test_rebase_same_head failure --fork-point --onto B... B
+test_rebase_same_head success --fork-point --onto master... master
+
+test_expect_success 'add work to upstream' '
+	git checkout master &&
+	test_commit F &&
+	git checkout side
+'
+
+changes='our and their changes'
+test_rebase_same_head success --onto B B
+test_rebase_same_head success --onto B... B
+test_rebase_same_head failure --onto master... master
+test_rebase_same_head failure --fork-point --onto B B
+test_rebase_same_head failure --fork-point --onto B... B
+test_rebase_same_head failure --fork-point --onto master... master
+
+test_done
-- 
2.21.0.1020.gf2820cf01a

