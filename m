Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE9B1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 11:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeIYSBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 14:01:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50855 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbeIYSBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 14:01:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so13101013wmc.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 04:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utcEQkLTMiEtKiW/tm+AQXYhpj5a+7iQ7z+RB055oGA=;
        b=bMhuVY3dHPUUDZ6n6+qF0oCkfFOUiQ8/sxkfjJ7mra0VA8pfbBt5xSBf57sLBCV1/k
         abWBTHGcqNrdqcgoSlDNer620yG9zkvaQbeFXHw2Sn0R5LDNayW1qbYR+7tWC2ynBV6r
         txzfyfd9EP93F9c2U9BxE7C/6knJ5KHynb6VqrReR7IFB1qQtJ9VUAYkZQr/oI9wJA2F
         q3HBWEqjVV5OxqndBZy6meH+6wjy2TChWE7/oV7Xw9cUe88KviSEneVbXCIW//bQj1tN
         E8u485qMDrKvG7jNTglomZZgU+5NK+0OT+e/ICzEMo38ueG3ce0fO9Fbm41T+Mu+hKS9
         WiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utcEQkLTMiEtKiW/tm+AQXYhpj5a+7iQ7z+RB055oGA=;
        b=rLpRZjCmpP7bl7LowXvByd143a8MCsI0rbC8cpB3uRzsWhWXRYnQt7olfSsT1+FXYa
         +JjuDy0bfc8zTwhMNqnbpVXO43XWb/7FxA1bWuWUehKHUQbI9zVqhVx/nKgC3QWDfh7K
         Cswathj5CjvYZcOrF0moBL3tIQrnAK/3P+cVwIdQpn44xZtrvXQcc6nlA3r0v6ir3gqz
         jL3plukqXzn+lHeJIK183kuLPcnZ0SIixJC0QWJav8eoH9OoOQ0y3CBRH5HHh+0gx4+x
         JQ4nOZyPmK8UGMTGLnCFVBCeuFVJ1+irWVXNytNJmllPUBewPwjMhoKIPSIHqH3V3lxT
         En4g==
X-Gm-Message-State: ABuFfogWQWHZY+MVR6XPHyqC5ndk1ZitNmyHIyicAlKc6fCYQsVgHlmO
        uBC3lBhjH8xH8vjUD9RZAGqhhI5g
X-Google-Smtp-Source: ACcGV63s09atQAAFjEVplt6w+wtVHxH/oPjG0rvGdJtdG2bZb1mzI3iKUpTUDsLxsemtP7yvYmfPug==
X-Received: by 2002:a1c:e289:: with SMTP id z131-v6mr426986wmg.32.1537876451024;
        Tue, 25 Sep 2018 04:54:11 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1998628wrr.91.2018.09.25.04.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:54:10 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 7/8] t0410: test fetching from many promisor remotes
Date:   Tue, 25 Sep 2018 13:53:40 +0200
Message-Id: <20180925115341.19248-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.19.0.278.gca5b891cac
In-Reply-To: <20180925115341.19248-1-chriscool@tuxfamily.org>
References: <20180925115341.19248-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0410-partial-clone.sh | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 8b32be6417..3fbd8d919e 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -170,6 +170,28 @@ test_expect_success 'fetching of missing objects' '
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
 test_expect_success 'fetching of missing objects works with ref-in-want enabled' '
 	# ref-in-want requires protocol version 2
 	git -C server config protocol.version 2 &&
@@ -183,7 +205,7 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
 '
 
 test_expect_success 'rev-list stops traversal at missing and promised commit' '
-	rm -rf repo &&
+	rm -rf repo server server2 &&
 	test_create_repo repo &&
 	test_commit -C repo foo &&
 	test_commit -C repo bar &&
-- 
2.19.0.278.gca5b891cac

