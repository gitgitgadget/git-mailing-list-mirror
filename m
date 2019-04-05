Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A8420248
	for <e@80x24.org>; Fri,  5 Apr 2019 21:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDEVkF (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 17:40:05 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:43769 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVkF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 17:40:05 -0400
Received: by mail-pl1-f178.google.com with SMTP id m10so3685736plt.10
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 14:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LaPE813OSFjQBw1zOOsUNEQycqq0NtMPOwUU7Ez2dxs=;
        b=g9s32rHYY4Hu5SYhnPL22P1L/chEoLdENAtZoV93QSUJnBU/ZMpQLOLKI8VADnoj2G
         xo2OXtnTFWrPswJESEuecf1Uz3cp73LUUdsQcHdT+8fY1Ex9eg+fQxYRu9oo4KbWYEA0
         Vwc147G0SE1txktKldtqc7Xkquksj+2SL8OJRbmUq5lurRgGctsfBj5fs8gwJVLhACpk
         tpSoYlyVGw4xykBzN++Qo9i55Dyt7TkkOb2KQhfZod46ihcFaOTJsleGusdAniSlv3nw
         lmBQ6tsLpNz9htGIeWc8v5JLWzg68ljFdU9w4RNLGlH2RcQUbPFoEm+sJBY8SGhd0Fvx
         6maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LaPE813OSFjQBw1zOOsUNEQycqq0NtMPOwUU7Ez2dxs=;
        b=tkUi5Ao+Y9db6w5KK5s0CcoeCfwrzaHqqLBpr3hwJAlQY1VWYQQu3VM+Z7x3SC/V5r
         7An6bZxwJaFFdNXqhRaNBxNe+o2ZI40C13j20dWqUkBe15waX4AqkhC9RyT4aelnW/2q
         GhF+JtI1/Q+nOJNLogb+XxV4DjNTNUzatWWhO8xud4COCY6vwCPSuhmI63tiI4SPcALj
         z3LNooDdoiOYgLkHlelP1MGnMmRrrXWoHJq7l30njJ/KclLAFLHFVLst6IhgQQqJzWdA
         Qz1bwY9iDYmzXZI3cioDPe9u1EOAnR3uDrIeHaxwEeKu/r0uXWsUUoAjJpFTX2N8glCU
         Wzyg==
X-Gm-Message-State: APjAAAU/rKcCE/vSs6gTiMUuRkTIp9kEHNitwPaHNyC/z6tbe7wPkAEN
        wevOlKGROinMq3geLhu4XjRoTsA5
X-Google-Smtp-Source: APXvYqwuH5TA4ZM5lG3pqx0tk8SlOgx36bQcAfKUzCyyzA+CwDF6TKZLgS0E9xhk4TisBd9caEIaKA==
X-Received: by 2002:a17:902:241:: with SMTP id 59mr15599388plc.79.1554500403865;
        Fri, 05 Apr 2019 14:40:03 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id b7sm67662321pfj.67.2019.04.05.14.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 14:40:01 -0700 (PDT)
Date:   Fri, 5 Apr 2019 14:40:00 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 1/4] t3431: add rebase --fork-point tests
Message-ID: <0f1e9ac5c8b88649a378f676ee924a966ce0693c.1554500051.git.liu.denton@gmail.com>
References: <cover.1554151449.git.liu.denton@gmail.com>
 <cover.1554500051.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554500051.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
index 0000000000..6d523123d0
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
+# A---B---D---E       (master)
+#     \
+#      C*---F---G (side)
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
2.21.0.843.gd0ae0373aa

