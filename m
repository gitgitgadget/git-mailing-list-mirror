Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D2F1F454
	for <e@80x24.org>; Wed, 17 Oct 2018 20:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbeJREah (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 00:30:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37995 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 00:30:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so13753811pff.5
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 13:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MEhIprplF/YIphVS7Qo1bdiNFM2usbmX1lAqHBqE7t8=;
        b=s09XqYrhzFMRjI0M5ml5GRgxburC6HfzoFUR9rXwgs9yZbNOX1tWtscMuvloGf2y/X
         3ArhdrcF0bvyic0oqEyvLcPR3jawRKU0wueaHHy2qFBvkikldNqizq11dgmVUKo96ZER
         0mFj5pqhfNknoAImeTw0WCrnIYb1g6wDBXfSefvmzfHdT2O0bXRctL80zElWB8MLkVJe
         It0PfBi5ODVYUvD8QB3S5xkh1v3fQmG+GTClLumvLloNL4RGOP4hWhcmaRCPVEnafSkT
         2uvwgpUhDm9hNT95o/qMbEjwwhZvsfiMTUYak3PP2eLJi+kGr+uqTUPwmFa+G1grOqkn
         +iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MEhIprplF/YIphVS7Qo1bdiNFM2usbmX1lAqHBqE7t8=;
        b=jdMKr9mwXYwd0NhZBYGMjoVl4CvV0bFzJ6Qnmzmmma+owE3XZvOrBBNml1eN69MuYK
         0Smn/WSr9opO/Y+geOkV1ZA8SapErQQjK7xIlZB+ew27n+Dlevz4Wci/RBwzBPUIEtEv
         TiDPJaWP+BzoVZLWIARrZcuGCRicC82o8AaQ2xCxjEx8NY7j524PGLwQ/BL9MSmRQ0Kx
         7KYs7GoEhhIFclTpdw+kiBEWs1Dw3GKZsFNAUeFVzdCEmFaHkSY5xiPbMRoTGCPqsFEu
         5BwqeJpRKgJ0JEbkqqoT14EfLpQpRp/l51ue+WW9+tL8fp2Zh8Cdv6QBgAzGXwbWi34+
         IuzQ==
X-Gm-Message-State: ABuFfohFmPZTtOKr9J5jfEBMbQTxZ+r5eK9N25uBd5v73S/G+6iMMNL3
        OgjfePAmUyGiXHh5CMD+jbf/uoir
X-Google-Smtp-Source: ACcGV60/RyRjKmNmUuu76d//mvI9IlVfZIATfXTsEBVxf/pn8enIniyYmEWM3EENQBFE7bPHgPnFhg==
X-Received: by 2002:a63:3e06:: with SMTP id l6-v6mr24313798pga.96.1539808393335;
        Wed, 17 Oct 2018 13:33:13 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id o7-v6sm33144650pgq.14.2018.10.17.13.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 13:33:12 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:33:12 -0700 (PDT)
X-Google-Original-Date: Wed, 17 Oct 2018 20:33:06 GMT
Message-Id: <ab118e60e9988076edf43d0ed8c1924e6569a9d0.1539808389.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.50.git.gitgitgadget@gmail.com>
References: <pull.50.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] t6501: use --quiet when testing gc stderr
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The test script t6501-freshen-objects.sh has some tests that care
if 'git gc' has any output to stderr. This is intended to say that
no warnings occurred related to broken links. However, when we
have operations that output progress (like writing the commit-graph)
this causes the test to fail.

Use 'git gc --quiet' to avoid these progress indicators from causing
a test failure.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t6501-freshen-objects.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 033871ee5f..0973130f06 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -137,7 +137,7 @@ test_expect_success 'do not complain about existing broken links (commit)' '
 	some message
 	EOF
 	commit=$(git hash-object -t commit -w broken-commit) &&
-	git gc 2>stderr &&
+	git gc --quiet 2>stderr &&
 	verbose git cat-file -e $commit &&
 	test_must_be_empty stderr
 '
@@ -147,7 +147,7 @@ test_expect_success 'do not complain about existing broken links (tree)' '
 	100644 blob 0000000000000000000000000000000000000003	foo
 	EOF
 	tree=$(git mktree --missing <broken-tree) &&
-	git gc 2>stderr &&
+	git gc --quiet 2>stderr &&
 	git cat-file -e $tree &&
 	test_must_be_empty stderr
 '
@@ -162,7 +162,7 @@ test_expect_success 'do not complain about existing broken links (tag)' '
 	this is a broken tag
 	EOF
 	tag=$(git hash-object -t tag -w broken-tag) &&
-	git gc 2>stderr &&
+	git gc --quiet 2>stderr &&
 	git cat-file -e $tag &&
 	test_must_be_empty stderr
 '
-- 
gitgitgadget

