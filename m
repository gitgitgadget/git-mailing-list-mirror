Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199A61F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeJQG3O (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:29:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42747 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQG3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:29:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so12144392pfn.9
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DIlKSMnygAmhqJbkFGN9kloLOOTraPA2YoTYIEIHZic=;
        b=ZpAYruApCQqyqrhNj0SzoYDRVjgyRcqkhmRl9/Cjo2QvUwxhSqFomHgwqdiIWxWSqx
         OmKwhiF85Hb+XGPEDB71ujhJlDqeUbJTEYNyZTvtwGCwSGWiYJ387LWQvdkOm5SGbLqR
         apbgvFWLJ5aP8t9bQgNF4S3SCyFWhkpH14bsflSKKz5tENuti/fqmeARhicGB7UuGSPd
         6LklvmZClGLvsC4LhTlI3g7MTmudj8JGYz2E1fbUwd8k06vuJsG29T0EWqyAqnn6hVV0
         hE7nECn5EmUQ6BQmdEDRAXYZBIhxzJ0iUDd4mGOxhZsgRtfozhzp1V2/bA/HeIsWw7SK
         US1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DIlKSMnygAmhqJbkFGN9kloLOOTraPA2YoTYIEIHZic=;
        b=QsBDS+XIw2X3t4y+tUkOOWwmHQmCXUElllGvGAfHwMO9ExPfaNA+IvSwUrp2tMEmaB
         U17fGCXmcOOc+SJ/wLmQ++sC9lKBROTNLjM1LTD2sLrpwTLq1rwCa4b2/OtHKCROdb3J
         SNbroyP08cE/XQQVJ211AgIfT3AF0aFOKzwtgTO56pDSDNfJ5gpewcN2/nUUpPGSSuY5
         KcaEtUYveaRpppmqUdv2XB0IfYfOG866oV88zWv47YX2E6gdXLDy1NttKQeYnL87GKRG
         bUsDOEDKNJkrWJ8HzkzLVD3AmjVrNmUYo4OJS55vGQdeaN6nQjO8QfslSh6ZRcNWpz5n
         7AwA==
X-Gm-Message-State: ABuFfoggfkCrVuYbnDODr2NR9mFatSBvwzP0m6ikyV424JDrzPOliUPV
        y3h845Rco36HDiGz/sbmpkQ0yGNI
X-Google-Smtp-Source: ACcGV63kQx0W/yxvKBnJgLlK2/VMOT5iLUWv6edLsnP/RQdGLXSctzSSPdSyPX4EFfqsxWSuAQUGKg==
X-Received: by 2002:a62:5441:: with SMTP id i62-v6mr24108494pfb.155.1539729400453;
        Tue, 16 Oct 2018 15:36:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l10-v6sm22691578pgs.45.2018.10.16.15.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:36:39 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:36:39 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 22:36:27 GMT
Message-Id: <3a4b68e479aa6c270ef1af3aae3222c3310c2935.1539729393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v4.git.gitgitgadget@gmail.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 2/7] test-reach: add run_three_modes method
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'test_three_modes' method assumes we are using the 'test-tool
reach' command for our test. However, we may want to use the data
shape of our commit graph and the three modes (no commit-graph,
full commit-graph, partial commit-graph) for other git commands.

Split test_three_modes to be a simple translation on a more general
run_three_modes method that executes the given command and tests
the actual output to the expected output.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6600-test-reach.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index d139a00d1d..9d65b8b946 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -53,18 +53,22 @@ test_expect_success 'setup' '
 	git config core.commitGraph true
 '
 
-test_three_modes () {
+run_three_modes () {
 	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-full .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual &&
 	cp commit-graph-half .git/objects/info/commit-graph &&
-	test-tool reach $1 <input >actual &&
+	"$@" <input >actual &&
 	test_cmp expect actual
 }
 
+test_three_modes () {
+	run_three_modes test-tool reach "$@"
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
-- 
gitgitgadget

