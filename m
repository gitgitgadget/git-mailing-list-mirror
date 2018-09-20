Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87A41F453
	for <e@80x24.org>; Thu, 20 Sep 2018 21:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeIUDEA (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 23:04:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53884 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeIUDEA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 23:04:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so935273wme.3
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Rk3qarqV10SV5RRWgtB/pEsrgVj504D281Z572Ezjws=;
        b=n+0BUdeHnSowfWE+3zYHWqT5G2bNU7ZSx6Mkv4NDYXT1T91GipRSQk/CXD0EkIiBy1
         LWB7rX95yyruP2bQ8LWq29rpsFFG1nJ1VbcpO4BGkBs77xcoCAg647Jys7F8jKAQ52Qp
         6efSIM9K4SveDhMbcd+E7VaReU2qmg5Jqg77aY1Vt9hzBW3he/8JtzdvfVTibWv8HcpO
         UZ7J+wIwU2CjYyLZmwRRDsJiVLV2NEInHHPDNjBA0vllPdiTky7XlPwVUlqMAAWk+W+I
         6kNvB5I3zV72GPCw3gafzToj1OmLH6RM0gj6ETYcSmlOPjWcHA8OHnfdIMvK0964rhWd
         fHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Rk3qarqV10SV5RRWgtB/pEsrgVj504D281Z572Ezjws=;
        b=bwi0Ggbxb99OgBufg5GHPnMGjcztSAe97VC289hDPQ8LhQ9C7D1E6gc+b/SKhqD7xG
         x483z3x5sTEDN1Tvsgf77vBNgNl7iKmdcbt4DkkBbAJAvRukMLajoFmk8tOHWKruSxmv
         ntIwFAnhG+b3WLZha4hAwTEj9NjpKJ0uIj0DH156ty7TIzdw3MSlQX/HmGUgM+yI0rQQ
         h2o/8mja1r0OUw5/DBxG6a9WUKi49gTV9KsqMAS6wuVwqdSVWyGSGgBYYW9OkwXrmlkt
         KfQ1SZyCJ4eXOln77ixbhxm0FYeiNsxjIi9baEt57wjmxoavV9BqESZmqZewuFJVZ7I2
         3tVw==
X-Gm-Message-State: APzg51D26y29YB1ohTZQtnUlajRLJO7TcvSssxxyI8cD86z6Urkityn8
        fi7fWnkOOXqZBKj3juqp8gNAJyTh
X-Google-Smtp-Source: ACcGV624C6KeD0gxKPWlsNhAcEFB+XTOIaW+3FgU3T1xoLh0ntQR1wKaBNAsd4WQBxWh2sxDSNaObg==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr4679821wmt.94.1537478311113;
        Thu, 20 Sep 2018 14:18:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a203-v6sm3702637wmh.31.2018.09.20.14.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 14:18:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] test-reach: add run_three_modes method
References: <pull.25.git.gitgitgadget@gmail.com>
        <pull.25.v2.git.gitgitgadget@gmail.com>
        <404c9186080ecee6c1cc39a6dcd17deaaa7a620a.1537243720.git.gitgitgadget@gmail.com>
        <20180918180200.GD27036@localhost>
        <xmqqbm8t473q.fsf@gitster-ct.c.googlers.com>
        <xmqq7ejh46rm.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 20 Sep 2018 14:18:29 -0700
In-Reply-To: <xmqq7ejh46rm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 19 Sep 2018 12:38:37 -0700")
Message-ID: <xmqq7ejfzx3u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I also noticed that 2/6 made "commti_contains --tag" enclosed in dq
> pair for one test, but the next test after it has the identical one.
>
> Here is what I queued in the meantime.
> ...

And of course, I find out that 3/6 needs a matching update after
I've almost finished day's integration cycle, and need to redo the
whole thing X-<.

Here is a squashable update for 3/6 to match the proposed change.

-- >8 --
Subject: fixup! test-reach: add rev-list tests

 t/t6600-test-reach.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 990ab56e7a..cf9179bdb8 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -252,7 +252,7 @@ test_expect_success 'rev-list: basic topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
 	>expect &&
-	run_three_modes "git rev-list --topo-order commit-6-6"
+	run_three_modes git rev-list --topo-order commit-6-6
 '
 
 test_expect_success 'rev-list: first-parent topo-order' '
@@ -264,7 +264,7 @@ test_expect_success 'rev-list: first-parent topo-order' '
 		commit-6-2 \
 		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
 	>expect &&
-	run_three_modes "git rev-list --first-parent --topo-order commit-6-6"
+	run_three_modes git rev-list --first-parent --topo-order commit-6-6
 '
 
 test_expect_success 'rev-list: range topo-order' '
@@ -276,7 +276,7 @@ test_expect_success 'rev-list: range topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes "git rev-list --topo-order commit-3-3..commit-6-6"
+	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
 '
 
 test_expect_success 'rev-list: range topo-order' '
@@ -288,7 +288,7 @@ test_expect_success 'rev-list: range topo-order' '
 		commit-6-2 commit-5-2 commit-4-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes "git rev-list --topo-order commit-3-8..commit-6-6"
+	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
 '
 
 test_expect_success 'rev-list: first-parent range topo-order' '
@@ -300,7 +300,7 @@ test_expect_success 'rev-list: first-parent range topo-order' '
 		commit-6-2 \
 		commit-6-1 commit-5-1 commit-4-1 \
 	>expect &&
-	run_three_modes "git rev-list --first-parent --topo-order commit-3-8..commit-6-6"
+	run_three_modes git rev-list --first-parent --topo-order commit-3-8..commit-6-6
 '
 
 test_expect_success 'rev-list: ancestry-path topo-order' '
@@ -310,7 +310,7 @@ test_expect_success 'rev-list: ancestry-path topo-order' '
 		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
 		commit-6-3 commit-5-3 commit-4-3 \
 	>expect &&
-	run_three_modes "git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6"
+	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..commit-6-6
 '
 
 test_expect_success 'rev-list: symmetric difference topo-order' '
@@ -324,7 +324,7 @@ test_expect_success 'rev-list: symmetric difference topo-order' '
 		commit-3-8 commit-2-8 commit-1-8 \
 		commit-3-7 commit-2-7 commit-1-7 \
 	>expect &&
-	run_three_modes "git rev-list --topo-order commit-3-8...commit-6-6"
+	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
 '
 
 test_done
