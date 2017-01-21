Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85EF1F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 21:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdAUV7j (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 16:59:39 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38704 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751404AbdAUV7j (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 16:59:39 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 08DFF280AD;
        Sat, 21 Jan 2017 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485035965;
        bh=0YQwAAN8e+vqEVs9t6nGQf+U51dKtsjVNS3oQirmCcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fD3EKBr08GPnkjL/8JoqdwrEKf6r6I5odFTfwnPz3kPCHG/FpUyOViqg977VRVVkZ
         R5oX02rytc3yBhZMLmpGMr7XdqooyoP9rOyXOHdt2lA9ros8pt4yhkQJveo8jHKrQZ
         6sR9mYp5XhClWBefz5/bwit29gUpkAhVu1g0ReumCfFCY0EYUXrIuBb41R9Wr3z8Mw
         mbbpUJpeZLaKlVQlqaSQi20Tlgumihx2wcVffHSqNANly6wzVRpoveeT9Zwpa9OGqe
         N3UW0KXdxyM4il7vFZ7MUdSPB+2L0BG2e1mhdUe/zxGlr6n4ckG6TqdP8GuQV2OIug
         y98kH+OEE5az53JVr/ES00Wj59P+fm10g5eEcI9THZXZstoCLxnmBi2kcL+OxH5Ai6
         4XyF/Cvo6mcaN0K7VjAhY2+AIMWGspAVVFwEQjsB6gZYSoTDxE9ohN26Xcf95HK6UG
         1OPuOvA2FdqxRkErbvxYx76fYuftl17vt+bpuzxjav+oXtTrUdI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH 1/7] Documentation: fix warning in cat-texi.perl
Date:   Sat, 21 Jan 2017 21:59:06 +0000
Message-Id: <20170121215912.246691-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170121215912.246691-1-sandals@crustytoothpaste.net>
References: <20170121215912.246691-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Newer versions of Perl produce the warning "Unescaped left brace in
regex is deprecated, passed through in regex" when an unescaped left
brace occurs in a regex.  Escape the brace to avoid this warning.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/cat-texi.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index 87437f8a9..b1fe52e8b 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -11,7 +11,7 @@ while (<STDIN>) {
 	if (s/^\@top (.*)/\@node $1,,,Top/) {
 		push @menu, $1;
 	}
-	s/\(\@pxref{\[(URLS|REMOTES)\]}\)//;
+	s/\(\@pxref\{\[(URLS|REMOTES)\]}\)//;
 	s/\@anchor\{[^{}]*\}//g;
 	print TMP;
 }
