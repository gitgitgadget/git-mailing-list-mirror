Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3647C2141C
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfAVOmq (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfAVOml (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so27651679wrw.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdPS5vfZkOgxh/503xS90GmTxksvsOwVKoDyalky5hU=;
        b=gtAfK2JX+uJtuYRBBbN2xq80XX9VJdaHOwYg2MgZpPZC5jO2yfAEf+VtN/V9NVpKpo
         dugt9LRymjUR4oCbhs43iJiGvZ/l/YflczMa9kyJtauDVsjAIj9sNxau4IQ+uOo9cU4d
         Ww/6mznmAsTI+Xqo8PWREM/SOpbj92QncGqg2AagVWxLlMur174parHbxV/pWid99ZfX
         O2ub4aHMCWKQcNnRr5PTcY+O60zuVqcJDLm6rEK1CoWtnBr0D7dgbvvzEP0eEjEiv+/C
         AUtgIXVhtpsHCzBFXmx2e9rnGN9oZj0r64l+7TC14roXZ50LDlFLG08DnIf/RpRPw0Eb
         s+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdPS5vfZkOgxh/503xS90GmTxksvsOwVKoDyalky5hU=;
        b=T98VN6bXvWlKHxuknDRljwtWmLEXZLlnqA23aLWy7yHMu4Ga4pn779IBU/BtYoRu6f
         tUEme0IE5asHASkHwDe6npZPScHLVOGBMLSphDwle4jZVbDXBJud74s09wcbiI5AW/XN
         657lxQkG51ZxnEu7HrlrpuqEd30XfwjwhEIJ7zHmYaxy3HxgFOgpiv+c2bXZ1V0swCAF
         8pq/k0B+WTYl5T6XayZfUu9TUA5VzSk3ITvfXrwqKXIy89zy0nqCJFgJU8ar/wDIF3bm
         YRL2rbn7dP1z4PzQmy0egeOAWSvBERzqdXAR/zZBlf8ZcQK1dVn5HrarvOLQ0eY+aOpx
         GTWg==
X-Gm-Message-State: AJcUukeQLF6PtAhJBWA6elWunmdKEpbiwERE+LhLAxPsQf6uRThGrkMv
        MI4coIbL46eV6x5v41JmIjZj5NBH
X-Google-Smtp-Source: ALg8bN7gn6rNBZYDb8bKF6nmuKKDSWCN7I38fUj5ZBV0Nhi0GL5ahvuUAvHiUA1ww097eTx0kw1I+Q==
X-Received: by 2002:adf:d146:: with SMTP id b6mr33373445wri.156.1548168158984;
        Tue, 22 Jan 2019 06:42:38 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:37 -0800 (PST)
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
Subject: [PATCH v2 11/13] t0410: test fetching from many promisor remotes
Date:   Tue, 22 Jan 2019 15:42:10 +0100
Message-Id: <20190122144212.15119-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
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
2.20.1.322.gd6b9ae60d4

