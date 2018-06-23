Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF421F516
	for <e@80x24.org>; Sat, 23 Jun 2018 12:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeFWMT0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:19:26 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37611 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeFWMTN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:13 -0400
Received: by mail-wm0-f43.google.com with SMTP id r125-v6so5297713wmg.2
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FPi7MLMj4HPMpBBgdBSUSlOk4/PkMUttn/zmFOA/UAQ=;
        b=OmR+FW0EsM3gAUzBo/Uf1q/YNO4Z8fa3+EresUUutzTlmI+7a3Zhh7mGkyOxxQO+OK
         wkOcD4pf6ScRRC5Na5ivLAKVLXddtMc4I0XuYbp4rd3a414ypYHfvSJMps+A+xQBSR+p
         A9S+HFogSM/plaUXQjrqoPF8dOLfXtgqUa8k9dzZAXP55C0A5XIu2of2Fw6Ot7OS71er
         /HxnozIJa/PUhsBVk5RBEg6Lbyi5qvlFomVcUhn/bPEw9cfUygDxgS/YkedrrXHcbpau
         pa/vEyggf30h/NrHIC1/3UFl2raL6N5njgo8ZgMeatLfr36QbHaHGc0ZFttQR0tDATLh
         XQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FPi7MLMj4HPMpBBgdBSUSlOk4/PkMUttn/zmFOA/UAQ=;
        b=sA4dv3olrPLZtoExefF7qlxPPKcCKs0quumU6HG/dpWpVIjjedeOkOd9g91THd/GNM
         BMsaiHT4f/7d7KmoMJ4Rz/bx5qumd+Y+PrH0ZQ53xk0TU12QoeatPwDuHJ2rtYBp2CE7
         Y7Ly6bqZpujmLKtRrJf5G+vRcHyG5jJplSYpIWCHI9NpSGSd3E+x4VM07KCdbVP2xLN9
         TygGbg6kgiGXw7ohl3vf6BAUs1r3GtXXSHkowWlk1pHUj2rwXlGsif7rTZBeM5pF2TlO
         af0LYoupM/qFO90JPUtipVzuurEUZ+VmMNK3ewCkulmhLyIWVmRybo9J9KzMLxhilLKt
         w3cw==
X-Gm-Message-State: APt69E099vI6LVBqo73cc2dMiuswo12we00+n7G43BxfA97HxStK7nyq
        JMoASjNsRNyeOHBWRzIIDN2PCaCN
X-Google-Smtp-Source: ADUXVKL0DhgTVRhE94p6kuPnLtFb4MwGuSpzcmwEXZH14KMEKJdSw+hsd6S9zs9dJCtBNEzT+R/Nyw==
X-Received: by 2002:a1c:a8a:: with SMTP id 132-v6mr4642587wmk.44.1529756352079;
        Sat, 23 Jun 2018 05:19:12 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5527731wmd.20.2018.06.23.05.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 05:19:11 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 08/11] t0410: test fetching from many promisor remotes
Date:   Sat, 23 Jun 2018 14:18:45 +0200
Message-Id: <20180623121846.19750-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.762.g886f54ea46
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-partial-clone.sh | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 6af4712da8..4a7a662512 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -162,8 +162,30 @@ test_expect_success 'fetching of missing objects' '
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
2.17.0.762.g886f54ea46

