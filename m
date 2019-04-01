Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826F720374
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfDAQla (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55498 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfDAQla (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so76610wmf.5
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwY4YQ9CmNMFl8SEZH8ZEdg5yuh6M1j0CxuCRDDi3SQ=;
        b=XHYdlNOrKMI1jqbV8CKiv7kY+dUdBi0uPSGC3C+VIp4k4toA8h7k/pJu2wkXu9w8O0
         rpSyMDan2O22JAvXcRhFLDn4mdkYcoxdX+eRX/mA66UaNSQVwm7cyvIHCB4Ox5NhsYIF
         mjW2uAzBQwco5AD0xXYMMLQMT+aa4ub0huFrRg0fnMDnEplEfEoHdjijf5lfWvP/qa4m
         upDixf4gLUaj3iHz/a5nshuHE1Qp4wW3TSXePEMQyvvVxYXrntHEh3yK0Xqj4RUh5IuH
         UL7kWGaPXskP4ghHCFS1YsVx1z3+bkF3mwEUDPvmGIutjc3Ck778KfvLvrnEPMoDfJwC
         F4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwY4YQ9CmNMFl8SEZH8ZEdg5yuh6M1j0CxuCRDDi3SQ=;
        b=JDDoDZmZuZmbzhUt9z6Qpk8O9tjXJJIq1B36q+/iD80qgTUNR54Li5EfpbOKmzHC0C
         pJzs/qZmQTf1FEEJiPiYUWb52Y3b6MmwwW8Tg0c/IkKXwGQNHmBAJSvlkjou51fXi08L
         VAuTFF9pPsgTJaMVfbvw8HAzxtvUtx9Xbr3t2kByEdk/rNs8QsZdPmagPGoUjbtD3oDc
         omX/n2fYnbGfTCwVbjDwBZEodJ0jyqdJuu5ClLzAa9GTYJsLL5DM6eB3/6ZJgx9qovZ2
         GPolyB530dmAGqxYW/gHZtvufhZv46vRNzWhQgO0deRrmvKlkF3IP2UFXoyP4EjjoERq
         USbQ==
X-Gm-Message-State: APjAAAWf7YsseokEcbsidai2EE0hHNT4PffUi6XPMzqIRwdXOy2yuOTf
        YnS93GnbocEtAlZihkfbAdyE41kp
X-Google-Smtp-Source: APXvYqyINGwJEjAbn7rR/jmfJrqV5j2NlYqVfYMF60A4lArU4r3o8RydLwd1FU6yqYGHIj/RRuKzLw==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr354130wml.34.1554136887640;
        Mon, 01 Apr 2019 09:41:27 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:26 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 09/11] t0410: test fetching from many promisor remotes
Date:   Mon,  1 Apr 2019 18:40:43 +0200
Message-Id: <20190401164045.17328-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
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
2.21.0.203.gd44fa53258

