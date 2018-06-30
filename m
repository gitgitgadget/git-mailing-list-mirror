Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BF91F516
	for <e@80x24.org>; Sat, 30 Jun 2018 08:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934151AbeF3Igi (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:36:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33409 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbeF3IgN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:36:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id k7-v6so7363597wrq.0
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8agyIMOarhBnYeGpJpbVqsPnhAHsoYj8D4DX1Sj94Jc=;
        b=DOHJsglIOlh0CUhtxS4Qddkog7zVZhuGACpBiCxyugTOz7NWGtA+YDZJla3YXhQU5W
         +ENCX9gOlrwfmPeX9Ig3WLeFpSCHWfq+rdEaEO7mvLNTQ/EWKT/PDwCNEvbH2RGe/KkE
         ucDMe0JQrWwyNs3Xa92YBdUSs8pVnkYEdP6wgw/3Tojsso+3lUwKtWcnxclTeqm7rgmi
         rFRb8O6Eo4FBsKU2n2i0anyRT4xFw2hnFSrGn9AZFHQRFdUBIQAWrmMYGgeSul0rOSo4
         MudUr4GhDaKeM3VLMwZghrlWj6Dc1VPI01oS51QIS3GvPfnBaP0IE4B4see7bLeQWFII
         TgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8agyIMOarhBnYeGpJpbVqsPnhAHsoYj8D4DX1Sj94Jc=;
        b=ci5aWDhqKZWjIsV+aFmVQIarCN38PI4jUZAukMEMiBYM7AYR0sZJgBItZi4jHNqdXw
         iyXlJ5mljJia9ADLKSOj41HfU2zaAZ5DKrgKSTqF5t7dWJ6SkUiW9KkypcxvBaMqsn13
         4EYUXHy+NzxevBciBU743yV75vi9LInPSLRHGpB6k4OHZGe4xKPe7Ny0+UhLhVrV9wSR
         aa21tlmtt47k89rc+oH+iHmZDvtZhUGtCm0/sGL6qq8G/Tcp4Q2J6h8vr5tMbibPvpKR
         MyjwTyLk5za1tA6zbl778MNFtCjE13XxvCQ5y9BqDZ41qOTBrNfl5bZjQKJYeHUyLzLf
         G9ug==
X-Gm-Message-State: APt69E2cQ4Xfledh4zr0tIik514vSRxPD6vR3cK0hztZQRo92s0+bKy2
        H8ZvSBTPjAmYsD43MArgjjJ7RC98
X-Google-Smtp-Source: AAOMgpeUQU9B9h+ueHAtJnYwkgr88gS6NlgLyTSUHu6uTAN50TipaWrkrrJhB+PyVaHTc65XT2Mq8Q==
X-Received: by 2002:adf:9485:: with SMTP id 5-v6mr9157688wrr.82.1530347771752;
        Sat, 30 Jun 2018 01:36:11 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u70-v6sm5338356wmd.3.2018.06.30.01.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:36:11 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 8/9] t0410: test fetching from many promisor remotes
Date:   Sat, 30 Jun 2018 10:35:41 +0200
Message-Id: <20180630083542.20347-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g8117677157
In-Reply-To: <20180630083542.20347-1-chriscool@tuxfamily.org>
References: <20180630083542.20347-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-partial-clone.sh | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 71a9b9a3e8..9d513ebf57 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -170,8 +170,30 @@ test_expect_success 'fetching of missing objects' '
 	git verify-pack --verbose "$IDX" | grep "$HASH"
 '
 
+test_expect_success 'fetching of missing objects from another odb remote' '
+	git clone "file://$(pwd)/server" server2 &&
+	test_commit -C server2 bar &&
+	git -C server2 repack -a -d --write-bitmap-index &&
+	HASH2=$(git -C server2 rev-parse bar) &&
+
+	git -C repo remote add server2 "file://$(pwd)/server2" &&
+	git -C repo config odb.magic2.promisorRemote server2 &&
+	git -C repo cat-file -p "$HASH2" &&
+
+	git -C repo fetch server2 &&
+	rm -rf repo/.git/objects/* &&
+	git -C repo cat-file -p "$HASH2" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH2"
+'
+
 test_expect_success 'rev-list stops traversal at missing and promised commit' '
-	rm -rf repo &&
+	rm -rf repo server server2 &&
 	test_create_repo repo &&
 	test_commit -C repo foo &&
 	test_commit -C repo bar &&
-- 
2.18.0.138.gac082779dc

