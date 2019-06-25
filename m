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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6131D1F4B7
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfFYNlV (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46290 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbfFYNlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so27162663edr.13
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w32hNmpnCQv0SjxcKVptiQUzm2FTMKi1ZOMuwrEJ9WE=;
        b=ayTeTGVr7L4UekjGXs1bkBfxfg3QPeeGCr8IdEKLZ7JYBnfI+fz3NSeC8Oq9GaZQbX
         aq1F3p95SYMK1dVNJt6YHq2c1MppPra7ytcP/NyNqc8lxMQYEvnEPQR1CKpDL9rIHqQZ
         Rfp0Qg/t9lGU0oXjQZX2usz0DWOv/DtD2qNmSQPNxuSIJ/HANUKr4q8NRhHNo9WJYjlv
         M+TIkI3bMcT7pxHleoKW9CXdcG9S77ryL0mCZ8Fk7RETZ8YWYeEu3R8pMcYwaWBAJlYl
         vZu4E7vp36pDySjB2pwnjKREWuKu92GyPVYxecWkEVdVKraIJku5Tq/fKkh8xbum6t7S
         Lztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w32hNmpnCQv0SjxcKVptiQUzm2FTMKi1ZOMuwrEJ9WE=;
        b=SZr83WRdDrxiGl+34EQb3H/NUn7oIPMyIlO9Tq7FsfZK0pkNDL+lgKnrztCoHWqTex
         RLdfxzCSj6IpwStwhvG75JXP671etMguQZ2qwxluY8eHiyG7rjtsRYWHlQhO/DeO933i
         gSJ5WjpnOpD9NXVP/ayJEmbcrLJ9ZwhmSSds0qv042952L8jkCRDdXDV3SJw432yrHCy
         2bJ9QBNcfnRL4WP1xRIKLGdbIopxN7/zaMHoSHRuu+CDsROP0NFuycRQXdhfQKXK3TGQ
         PQjE1QbwyQLO9bhqFNlT/k3+8l0woSLIeJSdo9rdqI0JB5VWbRJZx3jeLyq1GT6B+eUP
         C17g==
X-Gm-Message-State: APjAAAVkPrZ7XhBaHP7XMELVI+g5vvlpTnqCasQBqgdWTwLp0ogG7Xlu
        cQwHo36lFTNMrmMq581vqlG6O8EvXTg=
X-Google-Smtp-Source: APXvYqyaa1Yks33swrhCbSfRnG5lFf0UYhEeU0kR0GzQWy4ve2KJucLIWB+Bl3q+xGNVPDSLlFWoYg==
X-Received: by 2002:a17:906:2191:: with SMTP id 17mr29047317eju.280.1561470077195;
        Tue, 25 Jun 2019 06:41:17 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:16 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 10/15] t0410: test fetching from many promisor remotes
Date:   Tue, 25 Jun 2019 15:40:34 +0200
Message-Id: <20190625134039.21707-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This shows that it is now possible to fetch objects from more
than one promisor remote, and that fetching from a new
promisor remote can configure it as one.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-partial-clone.sh | 49 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 3082eff2bf..2498e72a34 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -183,8 +183,55 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
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
+	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
+	git verify-pack --verbose "$IDX" >out &&
+	grep "$HASH2" out
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
+	test_cmp_config -C repo true remote.server3.promisor &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
+	git verify-pack --verbose "$IDX" >out &&
+	grep "$HASH3" out
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
2.22.0.229.ga13d9ffdf7.dirty

