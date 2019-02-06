Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6AC1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBFAVi (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:21:38 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:55405 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBFAVh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:21:37 -0500
Received: by mail-yw1-f73.google.com with SMTP id q82so3445805ywg.22
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6dB7isPigwx3PmBaNbvlCFttHsejMNGlq2l8QBjFnoo=;
        b=fggDVKWNodS06VdFgR/pKCMB5yvf4Ln3NMmiij6djNQ5DOXXVzHYeOT//1RggJuNOy
         S4XLKH2SpPBKQY4wo5eu+Kpj/Fy4bpzC7g3bp2BiONvp6ln2g0PnQ/nBrKnVczrbfl3v
         864xgpsm9P3FZKXYYI5y+srBMxiF80/303qAFw/jnOxI/s56syhUtkZqmzCUGc5vDase
         zsIUj55FWWCw1XECReT7RQNfF/Q5jvbbdZMovvIU9LPholuea6v6qiCbB646FBqV9tRH
         ylTLj3XClTtln1kQ7KTacNjc+mCYQcXz9cAkKBy4RtQm63Q8TmpQoMFmhUHHChEcrmyR
         MGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6dB7isPigwx3PmBaNbvlCFttHsejMNGlq2l8QBjFnoo=;
        b=mG8cR/3SkEteNZ1gDRDxPcGalVwTpQCUeuzc3ClnB4BV3Z02u0dkFHUYqs/V5+COGD
         SeBzBSfcAO9kMm4QpA8m/wKaLynf8d4s/8Ky3ZkCtQVXJsf8SJYEeY38nGK+weYFRT8E
         oGFb2FC4qK7ZKaYlcHqhdHRuEI6rhz+AbWsNO9tRBeuu2vEsz6pkv3KWst9Xl+wWw01g
         LvTnz+ODf3WDspf53SAomwCTv9xSpX0KwZw84e1RxEBt+LoER6dBy8EbZSP1XxPScwcG
         xfJyDzHNUPx6Sq9e+qb5amrhB0KBIlW1N4p0YiONplK7E5ueTATXesjQ4B7y4DISbEjV
         AhmQ==
X-Gm-Message-State: AHQUAubJlZTtzdepQbAMgvqZIX0E9ZqZU2QUVb9pinsTJ40wY61PtMUZ
        bhakyQm7CJzha6cSnIwajWxBSlnubGkReNt3x6cKvgwJbJOPqV8d4M7nttfVq6L+Lz6bVvWz4b2
        KTqBgKpSRlzWomcIKmFlg5K7kgwhaQnvcs1caVRxwJ/mByLanjvPGYmTEQcZbibU38e5oC/tzrN
        5D
X-Google-Smtp-Source: AHgI3IZkDdVERL72m+FKF8Pv6ZRzEm/uX/hejgP91KStthDeJF7xGX4qiAUk59Jlf7hbN5cZCi6gnucKEu+NKOX36zLw
X-Received: by 2002:a25:4646:: with SMTP id t67mr3349918yba.72.1549412496595;
 Tue, 05 Feb 2019 16:21:36 -0800 (PST)
Date:   Tue,  5 Feb 2019 16:21:18 -0800
In-Reply-To: <cover.1549411880.git.jonathantanmy@google.com>
Message-Id: <05b1b94c479760c17d38beafc3d45ad9a5a08d0d.1549411880.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1549411880.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 4/8] t5512: compensate for v0 only sending HEAD symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
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
index ced15ae122..e3c4a48c85 100755
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

