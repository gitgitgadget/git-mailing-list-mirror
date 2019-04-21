Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61FD420248
	for <e@80x24.org>; Sun, 21 Apr 2019 08:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfDUILZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 04:11:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45241 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDUILY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 04:11:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so4471639pgk.12
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1W03mRQJZnatbdyKXVZnSz5/NReI+zKNW2yofV3vAII=;
        b=ACT8XyARbi1cF9GWYidAIysnNI0oF/EQ3BucOiZbKtnFLaPgw+IjkuJlMAqx2YuHxY
         cb1uHAObCwi7MYUM4olFK2clhH7MeaInt+0dA1swJrykdyfw689ESBa7KkY8fLgNZzOn
         8rW7vwPLwo/lueB6rJnzBiT6w5PK48qL2hV1qms3CGebCCP+b4XtcA8X8rXliA8+Eza9
         RQo2/gtVQxfQDc5vFFwFYzAOm+NsDybmz4vYpPPR0CauVGZOfwuQuwiwBE3pJBdrwSr7
         xLryFL005WABjWxpdZk58eF8cNJOELyTjoULzcgIS/dYIgYVZPf8azwNc7kOhI0ji77F
         gwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1W03mRQJZnatbdyKXVZnSz5/NReI+zKNW2yofV3vAII=;
        b=GO1rikEVCyRydUyrJUdffQxIc5pC4JXjj7J4g/VTV3ssva3fnvA29CTwmo9BAvvb0Y
         rldWMQrIsSP7jOQMR9MKqNWABk9hzrghem44E4imLtEYpXoSMmu6zn6pE3AKxeFbMx37
         VXVf1QJnDToN8yJV3hZzzSHLICBe+iyNd/mEKoJnEZ8Bhe8R3eoV3sV5xJ00PdZwazcI
         uXLxTw3lKnUD0S3A8P9jN62flC8oYOOlbJFujdAwnVQDTjJtReJyjGp5Ah40kwKNrUOG
         hNK6oESYtyS4IBu2ufdw0mOJiGX+jSE5eB4CBGZYvgJwUrMrQ4uFpdFGtswQPIjnU2OO
         dWxA==
X-Gm-Message-State: APjAAAV+tjk1kInFxsKIxxSnuQ1R51e85U1FQNsrwyE1X7qtHg1nfzQ/
        KqSSA1tSj8ASw54qhIfA/5knnutC
X-Google-Smtp-Source: APXvYqxlkg4dgcpvexEO3gG30ltiHxGZDpI7CUYzGZZ6m8bFKZ/j9QLToEF2mx2K2We1ksoZYeL1IQ==
X-Received: by 2002:a63:5149:: with SMTP id r9mr12970111pgl.177.1555834283835;
        Sun, 21 Apr 2019 01:11:23 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:647:4b00:5d::661d])
        by smtp.gmail.com with ESMTPSA id b7sm16769125pfj.67.2019.04.21.01.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 01:11:23 -0700 (PDT)
Date:   Sun, 21 Apr 2019 01:11:21 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v7 2/6] t3432: test rebase fast-forward behavior
Message-ID: <4c087ec0413880e1d3e6cbba95ff62224a4d95e6.1555832783.git.liu.denton@gmail.com>
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
2.21.0.967.gf85e14fd49

