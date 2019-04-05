Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AACFB20248
	for <e@80x24.org>; Fri,  5 Apr 2019 21:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDEVkG (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 17:40:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41897 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVkG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 17:40:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so3959657pfd.8
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XEOmxnriC0OeXVKk6BAYWmbr88SMr+orHNjL9HyedGk=;
        b=rlEGw22U8P5MT+/VXp9whGNLUBxSv9VhNSa5kL4L2Ri7P3G870TolmkqcUs0cLMlI4
         hPIjvHBfVQviqGF+KgX0SatkBcFPI+7E3nAjgHsOPMAZYIaf2oCNg/yu9Vg6gUyIPOOM
         nHXQDbl5tsNJqYdFy874PE4LLP6bzh32XhXxYRNh1t3GS6IIRlweqNupz41c6ligYBMV
         Vy7d1YYVKY7wFvqumvZCizpNPwQK+wYx/C9QcSu/GK9aq6j6LJ2QKKQ3kCJrUN1da6GY
         s9s10cAG0M5fAA9zZVbTRzWU19IluJyfGutH9/t3KKQ4rQWSxuHY/5ijbB1PJQ4/yfj3
         3Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XEOmxnriC0OeXVKk6BAYWmbr88SMr+orHNjL9HyedGk=;
        b=RRh9fh9ICTb3bGbHmLMidTIEQl57e2xB9gfLL2OKoH+Vjq2p7OT2sN62ZuiNzhr6e4
         HU7A4DyPTbC0K3fASpBRgjG4kxmQUragXSlKNssJ+wxnglT3/NVg0AnPxA3JXI7zWrhc
         /QT317OeWWLoQX0ewVQ8jJFitrHss7JRbW3sygp9BNjzuhojBr4dREj2N5qyYh0C5hYf
         kY8WrJw1AxUyRVM1FWvEbkFFlinjMJiPifF1oziJ44zUrHyA/nIllK73CmFHgpDDQjx7
         YwijZ+sbipo1AkWjrCdQQHykM+ufgw2yewB0EQ57NiydvO7Ep+YC6QsAYKpaLMD0Vn+s
         xmbw==
X-Gm-Message-State: APjAAAUI+z8iM/MTRjVb9sV6AQdf+yu+D5FGQLDnV35E+2VwABs6Zr/u
        qBtW8NqDbteHc0buerzsYjdVSNdz
X-Google-Smtp-Source: APXvYqyByezWhXOzHr3FWxDvODr+i+QHM81nEijWSN421i0rqgYiKldhLRXQLfu2TLd1XyEOTahLUQ==
X-Received: by 2002:a63:ed4f:: with SMTP id m15mr13951530pgk.387.1554500405109;
        Fri, 05 Apr 2019 14:40:05 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id w189sm30088167pfw.147.2019.04.05.14.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 14:40:04 -0700 (PDT)
Date:   Fri, 5 Apr 2019 14:40:03 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 2/4] t3432: test rebase fast-forward behavior
Message-ID: <963b600c79d3d59c5a359e87fb413fec88ed8aaa.1554500051.git.liu.denton@gmail.com>
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

When rebase is run on a branch that can be fast-forwarded, this should
automatically be done. Create test to ensure this behavior happens.

There is one case that currently does not pass. In the case where a
feature and master have diverged, running "git rebase master... master"
causes a full rebase to happen even though a fast-forward should happen.
Mark this case as failure so we can fix it later.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3432-rebase-fast-forward.sh | 59 ++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 t/t3432-rebase-fast-forward.sh

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
new file mode 100755
index 0000000000..b7c9af17c3
--- /dev/null
+++ b/t/t3432-rebase-fast-forward.sh
@@ -0,0 +1,59 @@
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
+
+test_done
-- 
2.21.0.843.gd0ae0373aa

