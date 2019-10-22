Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71B9C1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfJVKUF (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:05 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:36067 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:05 -0400
Received: by mail-pg1-f178.google.com with SMTP id 23so9672548pgk.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DCwWFgLOJ3+S9zGCzbTDi2aejRqoLZ25HtDbmBmhWME=;
        b=TXqty6y2mdUaMpQPbCS3UuWiLs1xutwRsezJYSQUdvlwunu8t7Q42aCa9aq9I7Vdtd
         GDLFEqZDfAvvPtTdg0Xi2po2smWsoM4ONpuYGMPbDwhQoKLcqF6OqmgK3/xnCwz5N/Os
         /etTQuLVQN8lkgNcyNwfN6qKhr37XuWBYdjyRdRc/8ZaRHCL1cdI7eD12mpEU0thTGnl
         ZfzwMJSPr8ffBjDo7iq/WirmzA2EDGANQY0GRB45rJdxeyxhSfj6n/WyxWnl8I+x3Skm
         AzKoj9IA3pbqJX31r4sQ9f8G4R8AvZu9/o6Kvosk6jMWrVOTA0RFlH+44p9QHLqDN5x7
         hv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCwWFgLOJ3+S9zGCzbTDi2aejRqoLZ25HtDbmBmhWME=;
        b=P1nxoRizoupeW8/c0RORT2t6FwrXupJM8LUDs6xyUVJUuy6ETtH/ZyJfXxlH4wzeMz
         w55llwhKcljBDpCoUVNm5tAPpvItnPuQetoryom+EjKBNZPlod4pbq9FPZ39Htqo+pq9
         1eaTeii37wwoGhxnOCstj6rgD24cQ57aEaWpVAZRCmieZqjMhsMBKhJiUg4DtJTeY5WP
         r/XR6XATVLMm7CB+5ZkEVi+IqDa8ivCbE0qShYHYCjbN5gdvTTsY7ykNLnSX1tgUJkU1
         O/8ykqIo43e8+9ty3dJ0j26c1UOlyVGfkvETdaxQYkDttzYTQG97TxY57IHCqAZ8DlBm
         OKYg==
X-Gm-Message-State: APjAAAXAxkCvB3j0pWsMf0AgVU9smDX71vhJ2+wtFK7E9wLXU4V4UUWb
        d1xG1q+PG1qmqE0EGT8UQhbxY+00
X-Google-Smtp-Source: APXvYqxmRq6Nt/7aP7jQfXA58/5C2bjkBctwQ3Ssi6nPc5g/LxXSf3IhQDZAQmSW+vFz8EsYuCh0+Q==
X-Received: by 2002:a63:f844:: with SMTP id v4mr3026766pgj.248.1571739602339;
        Tue, 22 Oct 2019 03:20:02 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id g7sm1597759pfq.143.2019.10.22.03.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:01 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:19:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 03/14] t5520: use sq for test case names
Message-ID: <a1071038f5c68d3b51a9d71d44bfeed369c5b610.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual convention is for test case names to be written between
single-quotes. Change all double-quoted test case names to single-quotes
except for two test case names that use variables within.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 51d6ce8aec..a3de2e19b6 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -408,7 +408,7 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
-test_expect_success "pull --rebase warns on --verify-signatures" '
+test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
@@ -416,7 +416,7 @@ test_expect_success "pull --rebase warns on --verify-signatures" '
 	test_i18ngrep "ignoring --verify-signatures for rebase" err
 '
 
-test_expect_success "pull --rebase does not warn on --no-verify-signatures" '
+test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --no-verify-signatures . copy 2>err &&
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
-- 
2.24.0.rc0.197.g0926ab8072

