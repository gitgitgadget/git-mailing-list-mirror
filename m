Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD8A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeLKF2T (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:28:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51318 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbeLKF2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:28:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so832308wmh.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3umXdJ+Ln8CzJMCaZWJfXKN8IWYylfS6R0N4y4oLY78=;
        b=qkePJPsXRZ2oaQZ0TxMq98aF2qisIDJ+Fvp7bqf61oajVOUcMSA+SSVlBJhrP0Y1/Q
         CvnKFr4hy3/7DIq+4NZTwKZkhX8IMhwwelasnxlg56dJ0gqBBrShtzZyleYJaF0oV2ih
         reZ2V870apafn7ciN7mMVjZbySaZhouewKYQk1NMEMm+QkRqiUNI5VQlNy/nA2KB6NlW
         H21m9jVQDDkJ/dXuJ+WhzSCczDhjggpmn/aSPVpJZxdtpBVtO5SLEeh/1PSQ4Ir9yUIw
         yumpXCCBqitD4aK0SvYNdsJXkHVtF+OIQcbEhjLMpVtid6uEPc4NjMSvbVHueQMYyV8p
         AkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3umXdJ+Ln8CzJMCaZWJfXKN8IWYylfS6R0N4y4oLY78=;
        b=ryCyAuXG/3dIcIAQm4NqJJZGHfItKKm1Y6wOlyAkhJjXfrkFhdsF+N8mKc5EfiD7iw
         zVDgae4lpjgfeMWN/vU+UiDihX7imWA8PI97px9aEXSfcgVdRJNL5fvfVV9Q8rdVTbOq
         GP0gU0b+wfcdszMoezyv3EYgVWz9n3iBvvwyU4PG+zktGbW9DLcxb8g8OHTJl2N8MUnp
         GAbT/YBXAKsd9wfbznMPiQ/VoVXXR6sZLvfseFLi/a05vRn+tFj3mozCziw5lwMh/u4O
         eQzxNZ3kouxS8vH4ib143OOvImZAruzXx1Iig2YA2tmUA3gxtyZVvFrbEPR+uxkoXIvX
         dPdw==
X-Gm-Message-State: AA+aEWZJV5tANrmNdwDiGz7xRU3uu+OVLTkUQZgfcfOp0k7EqGoWXK1L
        DBrPiqqQxy8byR4tCWZeCKmFx8/J
X-Google-Smtp-Source: AFSGD/UfOEsSdeYxFCaDB2JHa1FGEZrXHraF6Pd1zwhh7GZUhZff4prn6z6vhdWrXF7S3E+y2Lxy8w==
X-Received: by 2002:a1c:d08b:: with SMTP id h133mr942472wmg.8.1544506096296;
        Mon, 10 Dec 2018 21:28:16 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l197sm3708185wma.44.2018.12.10.21.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:28:15 -0800 (PST)
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
Subject: [PATCH v1 8/8] t0410: test fetching from many promisor remotes
Date:   Tue, 11 Dec 2018 06:27:46 +0100
Message-Id: <20181211052746.16218-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.0.rc2.14.g1379de12fa.dirty
In-Reply-To: <20181211052746.16218-1-chriscool@tuxfamily.org>
References: <20181211052746.16218-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This shows that it is now possible to fetch objects from more
than one promisor remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-partial-clone.sh | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 462229e445..a09a53ab0d 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -182,8 +182,30 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
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
 test_expect_success 'fetching of missing blobs works' '
-	rm -rf server repo &&
+	rm -rf server server2 repo &&
 	test_create_repo server &&
 	test_commit -C server foo &&
 	git -C server repack -a -d --write-bitmap-index &&
-- 
2.20.0.rc2.14.g1379de12fa.dirty

