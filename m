Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F4B420248
	for <e@80x24.org>; Mon, 15 Apr 2019 22:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfDOW30 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 18:29:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39142 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDOW3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 18:29:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id a96so9276244pla.6
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IQRgsrbz2ztUyDBhoaPa2jT2qJ3wAPV7lKCssfGs++Y=;
        b=fNHj8kATadJof/sTVX6MNL67x4fMzAoWdC2kkkwCyWJmMYBnHty4m3YvJVfzrE1tLB
         NUj7pQI1Gps9OkrI6RBY7B2jtXXGOOGuxqX3pOOttSThZGORu3YgHSHDc6zo/UdxfgMl
         L+ZYCGJ0ZiScpe4/pl3c5aHhaFuNj+7w2qRmP081882VkUoT3TorPttccSrXdbwUmVc7
         OmmHlmDUXTKR7Ypd1EIXlk7LnPB7kguo84Du2QV3rSQ+S6EKbhbtaHRJT5BMNg8obGV7
         VL+MSjz678kIObFrv++i1KLRYBiZK/rQOhoDi1Caj6n5TNd1h2DeQ/c7+j9oFDPfZPch
         WU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IQRgsrbz2ztUyDBhoaPa2jT2qJ3wAPV7lKCssfGs++Y=;
        b=I9wFr5eKmBBzpO2MeI33nr/URg7pQHTa7yJe3fp6oDOhWjlPhGIxv/pnc9/6z/ROOY
         fdFCtRtfozqFOnR7Gm2dc/Y2b02ehSz7GNIEGUL1ltBnGz3MYeQ5cIdM/crInv28ZvXb
         +w7JdwZRHK3AnqS42Ti1p/3mLlhc0oWLB6dRMV4V/WS7cB32PKEbHctWmDq0VjRZ+ob9
         7GMObmWAD7fFmACXVAKuS5EIytAhhVkPf6qIRx9NLrHnmcaO5xypgCr/FspsxbqKSwhR
         VaqjOXJU7ahfQqS5mYejqfrVT0srgbiB9ypNPiyRlIcMlQ8ieP6bjGeB00/iABNHm4Zy
         kNOA==
X-Gm-Message-State: APjAAAVD+QaZtPq+KWy5+1qySQe8vxINuOob45dCd1c2+GksRzN6wvWG
        P68WDxgd9xKL76G/60fr+TW0N1fg
X-Google-Smtp-Source: APXvYqw23Tlcf086kdw5w3/yAMPg9xKO38/EXu0ETNP3UTpy4qafylAAKlJxYrXQeJw2HuzCpxfMGQ==
X-Received: by 2002:a17:902:f089:: with SMTP id go9mr75480866plb.309.1555367364448;
        Mon, 15 Apr 2019 15:29:24 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id i135sm66748143pgd.41.2019.04.15.15.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 15:29:23 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:29:23 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 2/5] t3432: test rebase fast-forward behavior
Message-ID: <148027a14be9b0ee5dde741e4528255f2ca3577a.1555366891.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555366891.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555366891.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 t/t3432-rebase-fast-forward.sh | 72 ++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100755 t/t3432-rebase-fast-forward.sh

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
new file mode 100755
index 0000000000..4f04d67fd7
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
+test_rebase_same_head() {
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
2.21.0.921.gb27c68c4e9

