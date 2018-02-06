Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8EE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 23:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeBFXNV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 18:13:21 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38535 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbeBFXNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 18:13:20 -0500
Received: by mail-wr0-f195.google.com with SMTP id t94so3711343wrc.5
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 15:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKUBocbIF1OPhPnyD9NeB9vJQZoF/lQjVoRI44prOyo=;
        b=oNMtCPAAKK9n4iybeNwxgrI4fLr4dIYVCRWDyxvoj5nxF7Znh9NYlvbjEOnOv28OaM
         YW0FEIAMZ0qqddIzZUJjkI6FOF/ai2L3cPq8zAZ9RO/gtAjYCM7KDMUecXTD7QWxTVtY
         ClQrjbU/6XCWu0CRy6kt+AwfFF5q542LotLBnd+BGbDyUoJ+bTOJXqvuzOuH2vFAHF0q
         rTrxW9airFGSCaIeDCz9SDJC55rOfxy7W6xPhar0tB1Y2kU9bvkl+27R/cS8OWR+EVuX
         VkQEtlO1PtS9u8aa1UZ9/CaeBsIlvNTcln+AfPEcbLBUtsrqiniUdWcwkKsJBcZSRA5i
         0JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aKUBocbIF1OPhPnyD9NeB9vJQZoF/lQjVoRI44prOyo=;
        b=oxQPzS/zHL1LIaFQDJaDotd8Gq574QBvwig6bWrO/b6/zoI8G3P9UK36r1nmUPqMqp
         OdkLYZBz31ypceJXhtfzLN57+AOpnTyuw9mlSHo/0Nmkpj3wF1jJBcw4EG/pTCLKuJVP
         iwGDZwqiwMd3x6Szzsvcp+z5GcBlF4dbN4UEfJ7UjgNanMS1CxC35YxQPvapPyTwQv8/
         pVetjtcCLhNXgHS3dQpBItA/101hlqzvBxVbX9gROKpMn1h5Et6PgLBgaoBsNVf62NDP
         w/FEjhOSX8P5bHiDlOT79Xi4m2cuuSPwr9OqVT7seNHEn5zPAeC3gPs8t2gjzzmId4cC
         eSJA==
X-Gm-Message-State: APf1xPAIk4VsVuNZXXVC3POwwKjFtY5aqCxHLa71TtBBcwPLnJDSvOFF
        0CF2Z8oUb2UVFjL8Gmc3urRirrU9
X-Google-Smtp-Source: AH8x225WPEOOKOueRjoPzumfC9VtX68xnOp1mFE5/p9qp9GRteiQfeVeLXX/wX3tE76/fA/SdgTSew==
X-Received: by 10.223.128.104 with SMTP id 95mr3916159wrk.139.1517958799001;
        Tue, 06 Feb 2018 15:13:19 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 1sm136000wru.19.2018.02.06.15.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2018 15:13:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t0050: remove the unused $test_case variable
Date:   Tue,  6 Feb 2018 23:13:03 +0000
Message-Id: <20180206231303.8483-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The $test_case variable hasn't been used since
decd3c0c28 ("t0050-*.sh: mark the rename (case change) test as
passing", 2014-11-28) when its last user went away.

Let's remove the "say" as well, since it's obvious from subsequent
output that we're testing on a case sensitive filesystem.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0050-filesystem.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index b29d749bb7..606ffddd92 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -7,14 +7,6 @@ test_description='Various filesystem issues'
 auml=$(printf '\303\244')
 aumlcdiar=$(printf '\141\314\210')
 
-if test_have_prereq CASE_INSENSITIVE_FS
-then
-	say "will test on a case insensitive filesystem"
-	test_case=test_expect_failure
-else
-	test_case=test_expect_success
-fi
-
 if test_have_prereq UTF8_NFD_TO_NFC
 then
 	say "will test on a unicode corrupting filesystem"
-- 
2.15.1.424.g9478a66081

