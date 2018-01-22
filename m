Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC661F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbeAVLDp (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:03:45 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46659 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeAVLDo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:03:44 -0500
Received: by mail-pf0-f193.google.com with SMTP id y5so6796279pff.13
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7X4oHkF7H0sm9QxTnWZegmN9qLfJE6pXbVFuni/sFL0=;
        b=YJgVTbrvOfzD5ZrpFQ9nBt4RPVz3SY8L3nK8ymN7m1MGEt79yLm/I71weqtR7Uf1V+
         +QtXwL9OQt82w2v+yLi46hngI0bfb19ROcHvRczzS65AfjQ7Kr8swzkmmbXsJp8kfmvu
         8Yr70X7C4rZfx2s73F2mjaSxL64VgGy0fcoeqXVu1sCYhkn71oKkWHBIhaOFgAyJukja
         mZBgxKEBXBA2RPAvJKKa36fpxsm4ix5Nd8KQiSu8F8QuZZo1Gr3tPjbam8oXE4xhwJJB
         mKE8IqZrFtXOeuDRovLE24SStKtVKGb/d2SPcs30alQvVn6jZSbemuK3vaMF1TjsXCjE
         hEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7X4oHkF7H0sm9QxTnWZegmN9qLfJE6pXbVFuni/sFL0=;
        b=CfxiJGwt6+HGN4ZxqVJtPkFLyWJRBhJTq70B5tTSuwpWbHD5/dHorwRVqIhkowWBIx
         qfns6ECZZSr+6Q2RC1FQk4wBpfuq++6LzNnttLRm6yGbiSiYVTFUGluUEJBmkzlnyB0U
         kXHkdzCEARZLggg/ux0YSrc8Pt9FONj7HYfN91uI+qTlQraz7Qn4Xm6PZ47AfZcoDyqX
         8B1u3fgX0AOyQxBYU2oKiRevHGSwnaO5YlY/guVeBP7Q46Ne90eORxK8Q7KFrWyPJZJ4
         7df+J+NWq+vGfpEObahK11NCblSskg1lSaUlyDNXopGK9xuqBYyxVyy8zoyulmKcxids
         7eMQ==
X-Gm-Message-State: AKwxytcjCiMr6b5mICSjKxMX3ZyPuI9SYfuK/H7LaylEuy4RXs2jM3OF
        oCFbhIiZlf+Hq84O+KTspmUrTQ==
X-Google-Smtp-Source: AH8x227008VBccvoyJlLrozl09H1jUpqNiOpP+eakVJuFtTLpdKnwCcF9EMBnoIWLn/YjNeqjwT3Nw==
X-Received: by 10.98.159.139 with SMTP id v11mr7985285pfk.64.1516619023538;
        Mon, 22 Jan 2018 03:03:43 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id x4sm157693pfb.13.2018.01.22.03.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 03:03:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Jan 2018 18:03:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] nd/shared-index-fix update
Date:   Mon, 22 Jan 2018 18:03:31 +0700
Message-Id: <20180122110334.4411-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This only changes the last patch to correct the test prerequisite and
a couple minor refinements. Interdiff:

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 5494389dbb..d2a8e0312a 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -401,7 +401,7 @@ done <<\EOF
 0642 -rw-r---w-
 EOF
 
-test_expect_success POSIXPERM 'graceful handling splitting index is not allowed' '
+test_expect_success SANITY 'graceful handling when splitting index is not allowed' '
 	test_create_repo ro &&
 	(
 		cd ro &&
@@ -409,11 +409,11 @@ test_expect_success POSIXPERM 'graceful handling splitting index is not allowed'
 		git update-index --split-index &&
 		test -f .git/sharedindex.*
 	) &&
-	test_when_finished "chmod -R u+w ro" &&
-	chmod -R u-w ro &&
 	cp ro/.git/index new-index &&
+	test_when_finished "chmod u+w ro/.git" &&
+	chmod u-w ro/.git &&
 	GIT_INDEX_FILE="$(pwd)/new-index" git -C ro update-index --split-index &&
-	chmod -R u+w ro &&
+	chmod u+w ro/.git &&
 	rm ro/.git/sharedindex.* &&
 	GIT_INDEX_FILE=new-index git ls-files >actual &&
 	echo initial.t >expected &&

Nguyễn Thái Ngọc Duy (3):
  read-cache.c: change type of "temp" in write_shared_index()
  read-cache.c: move tempfile creation/cleanup out of write_shared_index
  read-cache: don't write index twice if we can't write shared index

 read-cache.c           | 40 ++++++++++++++++++++++------------------
 t/t1700-split-index.sh | 19 +++++++++++++++++++
 2 files changed, 41 insertions(+), 18 deletions(-)

-- 
2.16.0.47.g3d9b0fac3a

