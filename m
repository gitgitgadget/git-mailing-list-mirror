Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053CF1F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeFDXwx (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:52:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33226 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751232AbeFDXwu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:52:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AD47F60748;
        Mon,  4 Jun 2018 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156369;
        bh=b/NrHdduxujh5ZtkJlhR15HikLJcvavZXa8eFfoJhmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CwWwxhVna1kAvmMygZu/wU6M74NPRfLjldfTCrDsXhKez52Ei9Nvg1AEA/pWgIjJW
         SYpcQkEdI63j2pJUoF0P6idd1TMZDTZnJGYwuRFIz11KKuYKHtV1i7BDLhxIE2Oru/
         jD+36qFYGspZYg2pacsr0oSngvFCSh+AXBSd1roJLROVgRjuGSuCefXMhjBD8XBJFs
         KFlnU5Zi1BD2XXuBqoYPOumX+m14LsfreDI+XcxvfRCC0mfQbJkjBRNjj7KJdA+pyx
         Yf52N2vEyFlOAFQCsxxWdm/aG26OJLX50g2nUFVuAEzqQLsbhdLawW/fWzNbVmNsAo
         yd3FTeJxdGNifooskkQq9ZnTqlffQ/MkXT+DYL7kU2aLHNDkWN6gVWJMHYBNm8HHdW
         b9gtQr1Gy3FtyexxPDK1qdjCLTOYLj+2vbmE3+KWmtl34jY2bQFDQt2xu1tQq/Et8I
         hBBHZqzYQYA5d523Jt/LBdyRe2MuYX1aFseknFYqY0EoqWIfQMG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 07/10] t1400: switch hard-coded object ID to variable
Date:   Mon,  4 Jun 2018 23:52:26 +0000
Message-Id: <20180604235229.279814-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
In-Reply-To: <20180604235229.279814-1-sandals@crustytoothpaste.net>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
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
index e1fd0f0ca8..ffaadf5f2d 100755
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
