Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618ED1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 21:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeKJHB5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 02:01:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33793 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJHBz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 02:01:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so4578289wmg.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 13:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iajtfgWfMVtLQmBXLinSbp4mqPm58jc3l+UB5TJ03SI=;
        b=KwUkZ6zyzkr9+zy/SxugOsuVpUqUDwf+3aPftCDzWpirEoHpwzYmxfdEEIJfsb6jWd
         jrisMSFPqb+e2D2SpM6kJao4yibE77rGqoJ6PQA7cBzbYjvw92TG09uIHlcTsROBEWxe
         pNmJtRUFt6fhtJETucrgdnMOo+mCWxfET3d54oQF3chewe384XtouE0tIoanfdUpA2kz
         fc1woPCJPDle70V3JusqDXGp7q8B16y7zsRS+T/5danyOP9ldh6QwCgoPb8nCSGSzlH0
         ffSayQDgNOYxkC9qYY5rfeQevzJ4HRBEdI4RlBWM8kWmko9DJAdFMMMcrKl5Z8KfD5+E
         6VcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iajtfgWfMVtLQmBXLinSbp4mqPm58jc3l+UB5TJ03SI=;
        b=pUf7S8RDRyo8x8YFd43t29q+VMSpEQiKWLJwRPYZG/2ihX0UarVSyyERxuHHk9j0H2
         3mlUJgJib1WGfZHXm3P1ULVow5gmAM9EWwJPlCySaeB7fOc1aSt9DZ4gPmfRfHSYzSGe
         s45G3qsstKCMYoW3tnzv6k/wmynF5RItaPEHYY9WzibymyuRUI6BiIbSvi9RhzEbbiQt
         ooP9TSukEXMQJQkoWmtWNNMa1kRpkEyCpzVMq0d8IBzUDmeGO2/SMnFfAIqPuariqqUn
         1t8IU14+7UrkpX0s22+5wmjF5YeeLFYlEw0uwvgGOk+JBnsm5qSji5OIFpJp0K1HJLhs
         tNmQ==
X-Gm-Message-State: AGRZ1gL95CADNi5iuJJ+Wo2k1q3M1VtZABtAvNtsd2O3zY1BHFfrDbFq
        sHXp4/BHQYZJlnDpW8vmyPlxZGLx
X-Google-Smtp-Source: AJdET5f3EtlEjHnC5NPeFUKzv+Oa43ACpmrvphM2l9uLqMl/FvGLVrL+qZ8d1/hqAd/Pr+O5ezCxnQ==
X-Received: by 2002:a1c:2345:: with SMTP id j66-v6mr738956wmj.79.1541798371833;
        Fri, 09 Nov 2018 13:19:31 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id v9-v6sm9636585wrm.6.2018.11.09.13.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 13:19:31 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH] p3400: replace calls to `git checkout -b' by `git checkout -B'
Date:   Fri,  9 Nov 2018 22:19:23 +0100
Message-Id: <20181109211923.6425-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

p3400 makes a copy of the current repository to test git-rebase
performance, and creates new branches in the copy with `git checkout
-b'.  If the original repository has branches with the same name as the
script is trying to create, this operation will fail.

This replaces these calls by `git checkout -B' to force the creation and
update of these branches.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/perf/p3400-rebase.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index ce271ca4c1..d202aaed06 100755
--- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -6,9 +6,9 @@ test_description='Tests rebase performance'
 test_perf_default_repo
 
 test_expect_success 'setup rebasing on top of a lot of changes' '
-	git checkout -f -b base &&
-	git checkout -b to-rebase &&
-	git checkout -b upstream &&
+	git checkout -f -B base &&
+	git checkout -B to-rebase &&
+	git checkout -B upstream &&
 	for i in $(seq 100)
 	do
 		# simulate huge diffs
@@ -35,8 +35,8 @@ test_perf 'rebase on top of a lot of unrelated changes' '
 
 test_expect_success 'setup rebasing many changes without split-index' '
 	git config core.splitIndex false &&
-	git checkout -b upstream2 to-rebase &&
-	git checkout -b to-rebase2 upstream
+	git checkout -B upstream2 to-rebase &&
+	git checkout -B to-rebase2 upstream
 '
 
 test_perf 'rebase a lot of unrelated changes without split-index' '
-- 
2.19.1

