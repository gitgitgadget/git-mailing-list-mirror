Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1BE20248
	for <e@80x24.org>; Tue,  9 Apr 2019 16:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDIQMD (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:12:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40691 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfDIQMB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:12:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so21652201wre.7
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWcY89VksHxR3/rRZ++6PngRyphA2/XUIErvpM92YNQ=;
        b=lN6L3Il2WtzDFIa/ifYj8CZfmvaJGBd1OmajObzml+GdsZDgB6PJS/C2oiUTrcL+Mr
         fWcUn8ZC1UBsh1Xx7nKP8lK0DmV2+AdiOUnw8iIkL3TvRf0wTuZLDy4+HM2Ijvzyk9YM
         nFniudIb5eY+0Ve1Gusg8C1ljnTq3d56w27ARR5qU8Luc14aZwu7ydJQB8Rrm2ZwsuXy
         fl2Q5Q8wDhgg8ookDQIF9/3Ib6lzZTPKmxVfU2eiEYYoC6q5q2V+aY9N3GAuZtMvQby+
         r4/pOzRrrG0zSasZMalsYDhMEwn2lw2LIBdk59/6BQGlYmKl85hXN9T20zXkTKX7fHuh
         Fq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWcY89VksHxR3/rRZ++6PngRyphA2/XUIErvpM92YNQ=;
        b=Wk44aEbochRF4YLmMH4avVUjwmf5K4dphBHMeNJzV+lxC0rAo9Egf6IAvtFfcH7r2L
         7Bq3T4ANFBZKurITlI0bzJLnOuBMde/8hq4U8FOTa/6GyYsXCp4SYHv8BIc09azr/UbW
         /yvOPaAufp2KJzrGL/TnR3FFEJGwCLMfNmHBa0VrCWkfxDOHQV+DYRMVd5Ui6ftqvPtd
         rKV7Q1kCAG27j7FLGmBsPYF3XiAxrJTt7rNFFOsBobfRI5Xkzfgy3mFBQ05bDbAhtF0A
         +jK4gjeG7Ng9mo6GxE+izPWA7eUBH/8SdQbQ4sqyCiVKgJP/RExIMLRZndnaP8ntsVsm
         xbnQ==
X-Gm-Message-State: APjAAAVoe4sl0Oz7Y0lHhMRRwMv5/soshbzfZoIP/XExIBNjhUTHTM+O
        KMnjKdPcUipX0zgoV+wPkMhaUoKp
X-Google-Smtp-Source: APXvYqwqGGUXANx+3ru3mupTU1eD0gd5ejV21N/iGhMhV1slcvIjRwE0S8gX2OKTgqzqN8bee0I/Gw==
X-Received: by 2002:a05:6000:1250:: with SMTP id j16mr23520858wrx.135.1554826318530;
        Tue, 09 Apr 2019 09:11:58 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:57 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 11/16] t0410: test fetching from many promisor remotes
Date:   Tue,  9 Apr 2019 18:11:11 +0200
Message-Id: <20190409161116.30256-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
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
2.21.0.750.g68c8ebb2ac

