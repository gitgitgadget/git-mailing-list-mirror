Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE721F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbfAPWmd (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:42:33 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:51620 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbfAPWmd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:42:33 -0500
Received: by mail-qt1-f202.google.com with SMTP id n39so7078802qtn.18
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yFMbKxObszIPvCbm2y8O4EHUtLdZ+flEYXrnKhT19U0=;
        b=Evh73L7Hv5N1qHuijWvTn8/OE6M67U6ZjEQujyuCBdI1nT+5G3OrdrZLxCFRLf+8C9
         5Oa8pPRfkiWx5/oEUME/b/kc7wMHkgYqUNVjOeUdaEGX0IRMvPwwHvMHElDBi5siNuXJ
         Z8EUalUnG4ZJTj9c8x+JGqDC+IlKMBs+B1WgZX2ybsttDAH9uHQzI3O00oE2RfY7x5zj
         JUMCqYs98FOAd9VEhAkc/SdVWYNa7eO6p1KLqoW/Rz18LkuNpZcp663zIy2Nd4pKBmRt
         6mvQ4iXIeEPpTEgfy8/5kUdr4wA6jCPnqaENABEjimQFLdJo/KcGW4Pp74kSzwWYWnqU
         e3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yFMbKxObszIPvCbm2y8O4EHUtLdZ+flEYXrnKhT19U0=;
        b=kPxiGVK3Mq56o66zZPqRLzTBuuXsPBvxOxiBUEyQeu2Gn7JtaAFfTjnO6NNtW/kEV3
         iG6tTZy274B0dJRY+NmRBBttcsrFC3ssjgfL+kR8g9xxiQ+u0MpAGumQplGyxEJ21V7H
         f7AMo7tNYM3qbQnmuPRJnrgSXpsxKk4X4clwQo6Jol470um0REvTq8sGyt8rresiyDsP
         oA0LmYPk9+gmtetvvsK4h3q1Cn8DsrIHte4syBFy2SE1PQ5jwX4AQ+4E2knCnyTxL+az
         pJRNuTgup4mYAUSOP12b3VfU0Mru8pAGuBj2BctIdOu0kjpLAqrxenEVbfrcmii+7TYx
         tXEw==
X-Gm-Message-State: AJcUukcUZkoi74fk8WoadxoQnjtyBQeN3Hs5qNFNRfYlaxu+RTjW2W95
        ISmIGi2YCit/BWfTftVpizIV7R9FPS2QDROI8KbTHALuBuK7tzLhZPmW9WNUOQQoxggEIFQC0U4
        MVEYpJlCTZqz9Q+zahuVdGo9JpvA9xVzg+pHkxJJ4tXZCGlfO+txEoxEyHrv8qSJk3Ql3k27b4v
        RV
X-Google-Smtp-Source: ALg8bN4KpegASwHK/R3SU/uAYZhieYaZDjAHA9dvsmoGlCtRAj6SrTQJHUPOMe87CUTlMJyZ0Ndp3VsCEI9KBfs8+CRo
X-Received: by 2002:ae9:c210:: with SMTP id j16mr6082801qkg.22.1547678552141;
 Wed, 16 Jan 2019 14:42:32 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:42:12 -0800
In-Reply-To: <cover.1547677183.git.jonathantanmy@google.com>
Message-Id: <db88da6ca2e684f157a1f6ce3498f13d4bee4ab6.1547677183.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547677183.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 4/8] t5512: compensate for v0 only sending HEAD symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Protocol v2 supports sending non-HEAD symrefs, but this is not true of
protocol v0. Some tests expect protocol v0 behavior, so fix them to use
protocol v0.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5512-ls-remote.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index ca69636fd5..d3bac6f2ee 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -223,7 +223,9 @@ test_expect_success 'ls-remote --symref' '
 	$(git rev-parse refs/tags/mark1.10)	refs/tags/mark1.10
 	$(git rev-parse refs/tags/mark1.2)	refs/tags/mark1.2
 	EOF
-	git ls-remote --symref >actual &&
+	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
+	# protocol v0 here.
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref >actual &&
 	test_cmp expect actual
 '
 
@@ -232,7 +234,9 @@ test_expect_success 'ls-remote with filtered symref (refname)' '
 	ref: refs/heads/master	HEAD
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
 	EOF
-	git ls-remote --symref . HEAD >actual &&
+	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
+	# protocol v0 here.
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref . HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -243,7 +247,9 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
 	EOF
-	git ls-remote --symref --heads . >actual &&
+	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
+	# protocol v0 here.
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual
 '
 
@@ -252,9 +258,11 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
 	EOF
-	git ls-remote --symref --heads . >actual &&
+	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
+	# protocol v0 here.
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref --heads . >actual &&
 	test_cmp expect actual &&
-	git ls-remote --symref . "refs/heads/*" >actual &&
+	GIT_TEST_PROTOCOL_VERSION= git ls-remote --symref . "refs/heads/*" >actual &&
 	test_cmp expect actual
 '
 
-- 
2.19.0.271.gfe8321ec05.dirty

