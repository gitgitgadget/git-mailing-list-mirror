Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF9F1F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 05:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfH0Fhu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:37:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45978 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0Fhu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:37:50 -0400
Received: by mail-io1-f67.google.com with SMTP id t3so43339932ioj.12
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TKDvTqZf80fYls4LhhS3c/qR/fiLjGqIWXxPJZwt39s=;
        b=uotU31z8UwgdiS3W436p8V3hwA6lpAOxOTEjp0uWaX5OW3eonvbupmxwXe1+MwV2ZO
         nACx8oDqcqtM2lcjoHDEA9pXDqjVKFWGR4fPAUTlTD5a+I0kuJ9HdFEMSHvqpH0ORC9w
         3UIPUGzNbQjIxFWjx6nRxBxNlzHkl9Y9h1BxJ6X7+FkUU9EaOgJPny9/5vWA51euw2RZ
         xoPsoyZiAStbJGhFC9RccUI7DEH6H+BwtjQ0+ox+rh2MDzGWIwGD4ZDp1KCHqdRY8Fad
         cv0qbBkTvB8L9/HofzsiAoWhJYUIm72CtDm82fJvk5OcYUqzlbSOJfCpz27zWlfeFu6r
         NC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TKDvTqZf80fYls4LhhS3c/qR/fiLjGqIWXxPJZwt39s=;
        b=kfVyQ8PGNck2FqNRZ7mN3z46KDUvRFpPZzzTzO5eXYCuSOjFBwpk2ATtgn0vnavIok
         kwu66WSFy3iaSukLvXL3Uk8yErK4NrGlZB7I5iLJwNceuIrBp9KxoALa8/oXfbpbpT0j
         Bh00+tHN9H2LVcTdhkpQ/NhsEmqntj5Nk2hquq2co3aDi9SZbSSpZv3aLIMR3E+ElDlt
         5mO/qb5G5vrMOulFjwN6BXkFqTnudMGLPQXqcjAz+P6NofXYjGOtgwuJHvU4XfAvmORq
         uH3hcBlCKoX2NkqWi+M9+lIgpG0oRHS6m3cxKmhtlk7Zk5/hNdfgPLcImj4Kq6FSDw5q
         47Cw==
X-Gm-Message-State: APjAAAUXg/pJQOchR4SXSVITGuv6nGdJuEcpkrHF2K+icVzHPEtK6uuU
        TCNZ0Dm96UTjAtxl8uL+qh2nebH0
X-Google-Smtp-Source: APXvYqyId5SPCB2icsCVkaHbV1JbRr3GxyyGzMRNubzGkFea5YTUZ0ZOqgMOH4ob4y9+40uesfnZtg==
X-Received: by 2002:a5d:8196:: with SMTP id u22mr2000426ion.280.1566884268928;
        Mon, 26 Aug 2019 22:37:48 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id a9sm11644858iod.76.2019.08.26.22.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:37:48 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:37:46 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v10 1/9] t3431: add rebase --fork-point tests
Message-ID: <03f769d410447fc2db3b6dd18cdcc5f6eb160f62.1566884063.git.liu.denton@gmail.com>
References: <cover.1566724236.git.liu.denton@gmail.com>
 <cover.1566884063.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566884063.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3431-rebase-fork-point.sh | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 t/t3431-rebase-fork-point.sh

diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
new file mode 100755
index 0000000000..2d5c6e641e
--- /dev/null
+++ b/t/t3431-rebase-fork-point.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Denton Liu
+#
+
+test_description='git rebase --fork-point test'
+
+. ./test-lib.sh
+
+# A---B---D---E    (master)
+#      \
+#       C*---F---G (side)
+#
+# C was formerly part of master but master was rewound to remove C
+#
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C &&
+	git branch -t side &&
+	git reset --hard HEAD^ &&
+	test_commit D &&
+	test_commit E &&
+	git checkout side &&
+	test_commit F &&
+	test_commit G
+'
+
+test_rebase () {
+	expected="$1" &&
+	shift &&
+	test_expect_success "git rebase $*" "
+		git checkout master &&
+		git reset --hard E &&
+		git checkout side &&
+		git reset --hard G &&
+		git rebase $* &&
+		test_write_lines $expected >expect &&
+		git log --pretty=%s >actual &&
+		test_cmp expect actual
+	"
+}
+
+test_rebase 'G F E D B A'
+test_rebase 'G F D B A' --onto D
+test_rebase 'G F C E D B A' --no-fork-point
+test_rebase 'G F C D B A' --no-fork-point --onto D
+test_rebase 'G F E D B A' --fork-point refs/heads/master
+test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F C E D B A' refs/heads/master
+test_rebase 'G F C D B A' --onto D refs/heads/master
+
+test_done
-- 
2.23.0.248.g3a9dd8fb08

