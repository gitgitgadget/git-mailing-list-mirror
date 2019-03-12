Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1FB20374
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfCLNa3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40238 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfCLNa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id r23so2285151edm.7
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMxtXHPYeEAsRXbsaHEyWhDNJtC66wNT+1EoAbigC1s=;
        b=G9na3Fl5QLsD8F1kgHr/qvkzacQeT+rPOMduvxOIp2s6VZua8U3MkXOy8XGM0jnt7B
         iKsqhxVh76DrKSfEuMQ9K4Uh1a+ijxSw3oW1STgDxyBz5ZE5l3cNOSl7hSinTy5F473A
         HloZkWy8LmRrIEE8PNFFQc5hj3w3emydcUy/pmXLXYiPtNyl9wRD/1HhmM1uZogKRHQB
         uS9hSAiSF8NL744QZBE0njNQRSJEXtpOu/8OAoSauo0r4yCcQjDY4tAxYvcsKcYg0i4C
         0vIfGYW8Pnz4ajqr+mokYBputVLJRIYfXLoDr0oOw4vKggAVORDxygAfmHdJVtH7X2iq
         iaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMxtXHPYeEAsRXbsaHEyWhDNJtC66wNT+1EoAbigC1s=;
        b=g8dUQJ4VweJl+MABMHy3BV6IaQGHT0hLNM+Fjh5tfcv9XwM7zG2lqlo6jDs+c7StRC
         /RQRz2y1OsImw4iz45UZp2PYJH0vX7ryzGFQVlImXMHvzqj5gI8yg2UdVewKFTjJ2R81
         2gmJZFT0iRt2QtJ21TOo/FkL7c3bUPDHdotph64U+PnryQpYQSUjq1HSau6U1XmdrxAQ
         8E/aY40K9o9M9LwUVVa4dn+lmamy49vEdXrwjNjwAV/n/XBIPB676yIE7Ptz/2dT4EZM
         kP0hbNkbupSWXqfttxzZhA4Hdrte/aemhYJidnuKNuwJINO8p3Y56RLr3Akna/oKJGbq
         CqGQ==
X-Gm-Message-State: APjAAAWIkgWDr4MJlrKFyXlXzJQ89oJPOPweVA9hKoCgXISWMtNFEKTK
        3o7+sxdgLJrgIhe1M5VH0uxiidqv
X-Google-Smtp-Source: APXvYqyuYk7lbP+6MzM6B/vBcQw5Oidi2HO9vyy+F9mfmAoB5B8Iok/ZuV3i6o5xwAyfQWzIW+5XrA==
X-Received: by 2002:a17:906:1156:: with SMTP id i22mr25719654eja.13.1552397425182;
        Tue, 12 Mar 2019 06:30:25 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:24 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 09/11] t0410: test fetching from many promisor remotes
Date:   Tue, 12 Mar 2019 14:29:57 +0100
Message-Id: <20190312132959.11764-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This shows that it is now possible to fetch objects from more
than one promisor remote, and that fetching from a new
promisor remote can configure it as one.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-partial-clone.sh | 47 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 9266037714..146b0a1e03 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -182,8 +182,53 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
 	grep "git< fetch=.*ref-in-want" trace
 '
 
+test_expect_success 'fetching of missing objects from another promisor remote' '
+	git clone "file://$(pwd)/server" server2 &&
+	test_commit -C server2 bar &&
+	git -C server2 repack -a -d --write-bitmap-index &&
+	HASH2=$(git -C server2 rev-parse bar) &&
+
+	git -C repo remote add server2 "file://$(pwd)/server2" &&
+	git -C repo config remote.server2.promisor true &&
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
+test_expect_success 'fetching of missing objects configures a promisor remote' '
+	git clone "file://$(pwd)/server" server3 &&
+	test_commit -C server3 baz &&
+	git -C server3 repack -a -d --write-bitmap-index &&
+	HASH3=$(git -C server3 rev-parse baz) &&
+	git -C server3 config uploadpack.allowfilter 1 &&
+
+	rm repo/.git/objects/pack/pack-*.promisor &&
+
+	git -C repo remote add server3 "file://$(pwd)/server3" &&
+	git -C repo fetch --filter="blob:none" server3 $HASH3 &&
+
+	test "$(git -C repo config remote.server3.promisor)" = "true" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH3"
+'
+
 test_expect_success 'fetching of missing blobs works' '
-	rm -rf server repo &&
+	rm -rf server server2 repo &&
+	rm -rf server server3 repo &&
 	test_create_repo server &&
 	test_commit -C server foo &&
 	git -C server repack -a -d --write-bitmap-index &&
-- 
2.21.0.166.gb5e4dbcfd3

