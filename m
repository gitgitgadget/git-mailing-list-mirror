Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F251F42D
	for <e@80x24.org>; Sun, 13 May 2018 10:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeEMKdS (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 06:33:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40785 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeEMKdH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 06:33:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id j5-v6so10122967wme.5
        for <git@vger.kernel.org>; Sun, 13 May 2018 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pjb5cKtwYq3+C1SgQ81SNzcaXH9vetlqKwJdLCP2+3I=;
        b=Y/0soHyYLHIgbz1eyZdqgRUS6oHD1Xe3A1LCntbn76SF08S/bBA1bgJ0zbMKjOqZIV
         mwTtSdXBbTKW6MK3K4f/2pIrxHW3WeS4CXIIaRfYmCenW8sNuTY2yXPyYdfnVCbupJ5Z
         0duPQT/XlfDIa8SsOQYfZTGIex3kUI8QnAYthsLNb58Dbr7ruvo5qhPBJFvrYVg2gTK5
         0fW3ffsuHMdKtYxkvvFFlnTLZqLklNCKF+h4dnb1jPpQHCTne+/NMTkYup73a2fDaxzk
         tu6T2pOKph+vSnZbjlWZLuDECUAqJwJpVtR/UgtcMz6DjjnlDhBPwlrW6eHoglEbxxEj
         rF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pjb5cKtwYq3+C1SgQ81SNzcaXH9vetlqKwJdLCP2+3I=;
        b=l1HmBusW2EZi82EFdTKphGYA47vKxxOGv0AUhf4nR1lqt3RoGkQxpFZucafa5nB1lL
         E/J8Xift9CP6O8shMBcGSeadQcENMLDMBUP26Q92tHWikomk7b8Eutt4iipYmWRrBxJU
         EP26T143BgddFjRbKrbSYJOVxE66ceDXNZCZzZIjrHmP8A3B654LM2jdPlMePtAOoCoG
         9/Kqe1fjPI9Pj1ouglkAyRPuUpIahchJ2imUQf0XTS2CsUTerCzA1mI33APCr+BXi2I5
         q1IJs16kBIJOF0zroMnTF05GhZ8Dg3RJaMum8PfV9HvTzJq5TRUfB5EU7BTmf9JG8bsw
         7cGw==
X-Gm-Message-State: ALKqPwc0tntEcQrowwSAsvymos4j29PJ4SX6YFnfHLtCmw4SE3PFYIzg
        VFZY6YoskksOkG01XqC12BFkYpFu
X-Google-Smtp-Source: AB8JxZpXwx2LnOYVpsn0IeJSClyzKMM7MNUzypF4XkrTZnBXlicl3ZibpAxn4jrAqxkStxtHtlhWUg==
X-Received: by 2002:a1c:c6ca:: with SMTP id w193-v6mr2793139wmf.68.1526207586309;
        Sun, 13 May 2018 03:33:06 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t203-v6sm6886375wmt.33.2018.05.13.03.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 03:33:05 -0700 (PDT)
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
Subject: [PATCH v1 8/8] t0410: test fetching from many promisor remotes
Date:   Sun, 13 May 2018 12:32:32 +0200
Message-Id: <20180513103232.17514-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.590.gbd05bfcafd
In-Reply-To: <20180513103232.17514-1-chriscool@tuxfamily.org>
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
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
2.17.0.590.gbd05bfcafd

