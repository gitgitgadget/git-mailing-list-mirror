Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8489E20248
	for <e@80x24.org>; Wed, 17 Apr 2019 18:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfDQSB3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 14:01:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37341 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbfDQSB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 14:01:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so12390674ply.4
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s6mCxr6PGltFjwNoWk/s4dm40wr6oDRyNZVJ+5whTFA=;
        b=PFJXUFpDARiDaUa7/hdAKpPtqJVCWdtm/Oc9CqCvLWRYDbe6eLmBpt8iK3GP36xKh4
         HfrafnhwkXwVt5+tmWKxkhKkH29vnZmHMko3BGXhwP/neOgKyBEHFlakfogbS2J7YQzv
         wBLGv5BnsLneiQaJ81t7s5pDtqawEh+if50RnaaOuBJypbRYVqtThEegW1qOO67SIG6r
         lgktoD0vwSFjxZl8wfjvqmr3xdscY8LJJZRSHITo3BhZqVHRt0xOXvrjTY4tN9SjehMn
         GHI6ai0TlXAza0DUaxWsqGLyjrwudtrtev02kD/IJQ/nl2jQh3nckz3yPIUE6aoUCIHL
         5raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s6mCxr6PGltFjwNoWk/s4dm40wr6oDRyNZVJ+5whTFA=;
        b=rbyfUXQ1tefm2CgfbR8NChabr0uX/9s7/5+xWfH+ewvmE8rR+c1AsTEno1oMz1N5po
         AAgACMpbOoeYmOuloW3LT4JSn+uxzsSnEJ2NucJY0EzUhkOg3f7jH88WwNLgduONBDt2
         QYXVjz0hmg4GAiv5Zzjczx4IJhBlpR66Fz403l9Oiy6cCgZHJG+gIVZB70BkerrdxjKo
         tbqcyyi6OBlsRyqu+sLt9NKzBOHSZf0ROAnmWqMs9V8tyVlxmd0g12dVn6phwgI6O0t3
         AT2utfBuFExVtGotIsII77w5D6FQL3bZlwYYI3wk1o3MRr4tlmLMNEkMkLtYsqS0+yVs
         58mg==
X-Gm-Message-State: APjAAAUo+S3o+TmoxWQpTalaZz3Hk/rTzZxpPVYLwcsX9AK7MmEyJuEb
        WapQMaSdcrp1b2x6Ym1BoTl2SlQqNsE=
X-Google-Smtp-Source: APXvYqyuFKhdeG73V/tZKEXgIipNhhzV41LQHc+rTyHClOSpQjwMDpqJznhqE0Q6iilFuN24W477nw==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr71705682plb.203.1555524088077;
        Wed, 17 Apr 2019 11:01:28 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id b15sm76834377pgg.90.2019.04.17.11.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:01:27 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:01:26 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 2/6] t3432: test rebase fast-forward behavior
Message-ID: <4c087ec0413880e1d3e6cbba95ff62224a4d95e6.1555523176.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555523176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555523176.git.liu.denton@gmail.com>
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
2.21.0.944.gce45564dfd

