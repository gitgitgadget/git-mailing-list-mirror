Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB3E20248
	for <e@80x24.org>; Sun, 21 Apr 2019 08:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfDUILW (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 04:11:22 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:33796 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDUILW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 04:11:22 -0400
Received: by mail-pf1-f170.google.com with SMTP id b3so4348108pfd.1
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YIpNgmtjm/IKU2D7Re+t7rQlv8nv59iT7Vl5eG5Yb0Y=;
        b=hVhSHkXzMuGJadlIJPt2tqGP3KcmCY4y7PTE+HchSjv4iM8ImeXVEyhrd5e/fmgPLl
         YIu/eO/wF0vA5kfIgbxdtHIImbIbIFtrj8FREKERl3mVi5EVKL0oO28BEdfcg/3T9CxV
         LYFLcMSxmQH5w1epjBM6VzrVmlLxrxVmNHWw3uhC8TmZP2ZdGxDgfHySSHyn7VaU7O4F
         0mJThl7x4Xk7iOLsKrlcD4SiuDDAWDsalE0WnChS2n6tPUih2y9u6mkxAeLndeFfFhzR
         eS1EWkepJutgSHSI08x+s/yIwP3eysxqNtUUxxqAvOX6IaDInSXKyoeY892EWa8qcY9O
         3zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YIpNgmtjm/IKU2D7Re+t7rQlv8nv59iT7Vl5eG5Yb0Y=;
        b=IlLqdQ1AaQhn7nsMgNbGXbThvjj6mS1NW5sXZl/UtaIhwUWpSc+Zpkhgn2MfKxBrp1
         QrI25YHOV4PzFmUL3r4m4rCLss58y5h9Z4FjZ5hCIr9gQhYKnakVopHCkATaYWfHXBNQ
         cjTSevK/BU5rP5RePx/4lhl7bVA4O401nFzEhfTFaVmjg7sOZPlDA/xQG7qZlsAKRyNt
         zzp6a95zi5xpCo5zje7sOrjncf6aE3y543Opr0L1KAswd6dM6NyliZ8os5bjJEqn9+CO
         86OcCVjEhkhnITH/qa/x2zrNsyNvaFERiGqn2bRtJ5Ro2p3tqRyjFLzXmn/BXAnhx1Bj
         v2kw==
X-Gm-Message-State: APjAAAXD60yd/fc5ELVh2MYosqXt52qB7QuReHsdTl3DJ25+IC6L1MOX
        8me0b8A8hj8zdKbKog6OzVV+WzLl
X-Google-Smtp-Source: APXvYqyvIEDITJkLdkti3qVXMNTwzXXfybLR6N3O2b9/E0jvlRVZNL/1DW7YBgLqI06LK/OBh54LpQ==
X-Received: by 2002:a63:c61:: with SMTP id 33mr13246497pgm.293.1555834280974;
        Sun, 21 Apr 2019 01:11:20 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:647:4b00:5d::661d])
        by smtp.gmail.com with ESMTPSA id m131sm20793967pga.3.2019.04.21.01.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 01:11:20 -0700 (PDT)
Date:   Sun, 21 Apr 2019 01:11:18 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v7 1/6] t3431: add rebase --fork-point tests
Message-ID: <eb64f6c91d27a6f9666c9829050995d9f9b52925.1555832783.git.liu.denton@gmail.com>
References: <cover.1555523176.git.liu.denton@gmail.com>
 <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
index 0000000000..9b517d87a3
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
+test_rebase() {
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
2.21.0.967.gf85e14fd49

