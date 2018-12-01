Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856CA211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 02:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLAODm (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 09:03:42 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:39735 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeLAODm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 09:03:42 -0500
Received: by mail-it1-f175.google.com with SMTP id a6so1362747itl.4
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 18:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2Ws7S2eYwxkB+4I7nzqp8Cn5FswuRnhbXNauTMfEjM=;
        b=bray9SAcITqTBDUOsdy/ZDjuGL94nWjWJN7ASaANBGrFI+plrmM37OMV1tmzETIvOL
         dodzIjnjR7N55AXmH7/5ydQVjg8MF842U5cEWR8ebN+5I6aya2AgSppwgW+ihfKY+d9X
         XKqyHR/0di58ocwCIlp35Rx39Cj7+n/KgAVX4kxP2byZSeTInVFqQgz9nK1wwON3zUyx
         6q8QfWkyt8mBwBJtEJzV53NCc666eCkaivTI+vaBfFCKwTFCMQJKNdvkkaMgs3jwQf2m
         jdMEM8VkDGMxu8OBEuhl17q6Q0Hrty0TEat17RvyQbJGCqrAKE+VFURDwZxNvYmotnor
         v1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R2Ws7S2eYwxkB+4I7nzqp8Cn5FswuRnhbXNauTMfEjM=;
        b=jjNnOX9nytYblwuRNYPDZ+CkXa1wdwGCAoOl++h0dARn/ZJi+gyzCdCKqqxF7DrcD1
         NDojRBpc226n2ZVaEr4qx2QotvASiM7BNteH8/hjl6ctKSNZ8gTaQ9OyaZX1XZoPieKw
         vHYihrnRp/HS7/qlcra84TExTGhPbVdFQQAlg3gD7a70KhpwayblPA3kFkazzCKKWXvy
         ZKrxEfekj2KmNaC7/JOjx41KAwaZhtYd332yR4KWe0eb8otkyAQJqSjaSlanOhYsDAkw
         pvAOFg2ozPh2NNoI6zd6NqHqRYWg/ACkbs8Q2csWcNMdy39yRSz18RSAzrrflNm353o6
         otLA==
X-Gm-Message-State: AA+aEWYvrn5EmXFtyIBFax1QOozuav/2uSWEPiGHUM/Hsyz5FDNGGS0q
        7SvoVFzbI+sSQnHi8as6XE+yd9HV
X-Google-Smtp-Source: AFSGD/UUUMU8Syw9hrB+/N+7pUXPwthudd9LFWtu3fDt37uORWafFgrgFqFd/5GVwxoamFB3RVvdbg==
X-Received: by 2002:a24:414c:: with SMTP id x73mr1055623ita.129.1543632736018;
        Fri, 30 Nov 2018 18:52:16 -0800 (PST)
Received: from Carlos-MBP-2.sf.stch.co (50-207-95-178-static.hfc.comcastbusiness.net. [50.207.95.178])
        by smtp.gmail.com with ESMTPSA id d128sm3282059iof.37.2018.11.30.18.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 18:52:15 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com
Subject: [PATCH] t6036: avoid "cp -a"
Date:   Fri, 30 Nov 2018 18:52:12 -0800
Message-Id: <20181201025212.54244-1-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.6.ga1598010f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b8cd1bb713 ("t6036, t6043: increase code coverage for file collision handling", 2018-11-07) uses this GNU extension that is not available in a POSIX complaint
cp; use cp -R instead

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
to be applied on top of en/merge-path-collision for next

 t/t6036-recursive-corner-cases.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b7488b00c0..fdb120d0dc 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1631,7 +1631,7 @@ test_expect_success 'check nested conflicts' '
 
 		# Compare m to expected contents
 		>empty &&
-		cp -a m_stage_2 expected_final_m &&
+		cp -R m_stage_2 expected_final_m &&
 		test_must_fail git merge-file --diff3 \
 			-L "HEAD"                     \
 			-L "merged common ancestors"  \
-- 
2.20.0.rc1.6.ga1598010f

