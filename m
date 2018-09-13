Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B131F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeIMK0R (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:26:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54460 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMK0R (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:26:17 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A31B26075D;
        Thu, 13 Sep 2018 05:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815905;
        bh=Y2NrRKJEQKltaHb7O82w75UnZtrHvW4M8xwPHQly+uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HEVWKkQK5/xK3Xz3vPCFhpVIGPHn06Xk26LiR6+cM6WOE7Q7/LLlYXCf9TyQuaeOI
         20miplDqIdDNgLtUs4+gRlqu1n8eN6uBQOPki1dBkzz+C1syER54iAQIARXp9At9po
         k4eQS+9/h8l6I8ermiiBBEmtZ8tgss3Q2JWyCI2fpuqbGolmXMX0bDkh/TQojWq2q8
         X+S4liPxkpZqdkQ0NkwO2upW7PVBvr6877VZF68TGB39wnoGeUO0Jrf/U8YBBdq6S2
         piVyrIe384JtKucfgMzNvPRDxOjL23XGGfEmCbIoFG2Fe7l2DabcqEczId1WvGhXxa
         jpS00jP7nO0EYCeFVUMvz3XgezZPF1KH6J0upyc4ALseWfNOleXZhK5x5Up+eY3cVd
         GKOsHCVqeEFB3J3GZu3CkYWOrj1QEucVcPrVLP0hIu5/a+JGEZA9Sij4/0enV1+NRP
         0ukPp2md43dBEmMPOPX1XN57OhWjF2E40cKYLNR2Znf7xgngAuI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 08/12] t1400: switch hard-coded object ID to variable
Date:   Thu, 13 Sep 2018 05:17:38 +0000
Message-Id: <20180913051742.252276-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a
In-Reply-To: <20180913051742.252276-1-sandals@crustytoothpaste.net>
References: <20180913051742.252276-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch a hard-coded all-zeros object ID to use a variable instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1400-update-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7c8df20955..6072650686 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -346,7 +346,7 @@ test_expect_success "verifying $m's log (logged by config)" '
 
 git update-ref $m $D
 cat >.git/logs/$m <<EOF
-0000000000000000000000000000000000000000 $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
+$Z $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
 $C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150350 -0500
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
 $F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
