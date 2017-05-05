Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6611F207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbdEFSte (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33807 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdEFSta (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:30 -0400
Received: by mail-qt0-f193.google.com with SMTP id l39so4886221qtb.1
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Q9/tsByvuEHDT6PGtrf7hezmnNUp44w/qCxmotA7XYo=;
        b=hFegQwjGwlAYasANhI0sxGHN8O/zJMIhPWBRupr5Bz3klv5ibNphlApHGppQQZ5KRD
         DKoiFL8FjrnSBYWQPELwGC5csHKF8NWYoHmchimLghnXjHq7hAwms4TiQqXchviqtAks
         xL6NQ9y3RvnECMWa4BPRZmYDj6jXSIP4v0fOaFIbdgHqKDIzBrKycnF+j+47bGmwMn3G
         OnonD3MvdEdToIfVF0wnz51UJieyFa7qNGAvs6LuTXL/8Yf4kqoPrKdJHDZqGwo6ULyo
         4Oo+dZf6WkSjsb/Nw+x9RbEbCS5dkiszU46uLvzmLoYk1knU4yvUilk+yTqh43T36+9z
         4sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Q9/tsByvuEHDT6PGtrf7hezmnNUp44w/qCxmotA7XYo=;
        b=hYhLweuNDyRltFc/+/XwtmHB5Nl+yBj2PESXi850I9Ir4JTKS5dm/lwGHrMHJ567vE
         O+2RvmGYN/slqKnIPlGDZreXiQmDVbqENAMejCenUr/CsNDVeS9jmSKsYGYbwjN+XY68
         WmuoING1avL9/6fB4Z8HeGguv9nujcAbXZmgfPvj8kMZ+ZvyPdGx8BLgsw8L2GXiiRoO
         1tCejc1rrSUzX6p+qRZDy0vXLEuQi6pTnd5sc9VFBAcSDE4j1C9kAEj4oNeNa8Q1NMt2
         35DnwOiL27bE9cKPerTy4VusHpQ/skemyJ3uywdj1J2KOwe4lWmhmRpfadbIQ7xuIR2E
         zYUw==
X-Gm-Message-State: AN3rC/6/bsVPn6ZvuV7hbjHYpWLjIoL1+RnnWQmiSrwwjXUMpAmeDipC
        ffnj+fZSgadqdw==
X-Received: by 10.237.37.100 with SMTP id w33mr13904140qtc.14.1494096569710;
        Sat, 06 May 2017 11:49:29 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:29 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 2/9] t7061: expect failure where expected behavior will change
Date:   Fri,  5 May 2017 05:46:04 -0500
Message-Id: <20170505104611.17845-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This changes tests for `status --ignored` from test_expect_success to
test_expect_failure in preparation for a change in its expected behavior
(namely, that ignored files in untracked dirs will be reported).

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7061-wtstatus-ignore.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index cdc0747bf..dc3be92a2 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -11,7 +11,7 @@ cat >expected <<\EOF
 ?? untracked/
 EOF
 
-test_expect_success 'status untracked directory with --ignored' '
+test_expect_failure 'status untracked directory with --ignored' '
 	echo "ignored" >.gitignore &&
 	mkdir untracked &&
 	: >untracked/ignored &&
@@ -20,7 +20,7 @@ test_expect_success 'status untracked directory with --ignored' '
 	test_cmp expected actual
 '
 
-test_expect_success 'same with gitignore starting with BOM' '
+test_expect_failure 'same with gitignore starting with BOM' '
 	printf "\357\273\277ignored\n" >.gitignore &&
 	mkdir -p untracked &&
 	: >untracked/ignored &&
-- 
2.12.2

