Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858871F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeJOHo4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:44:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbeJOHo4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:44:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E716061B75;
        Mon, 15 Oct 2018 00:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561732;
        bh=3ufzL2dvoDhezUvsC3PyqOHnnjXuRzJci8Fscz5KibY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZHKqvsOxNinAND2EBd0eg/+9g5KRxF2RQvzJzTOwpBDNThuwOoyTxO1QCD0XsN/hG
         Fr3fAUHbKlbTdib8fVI3Y7HUeBNh7tB5g/PXQ0iBWsnlNDVFLxQUNdRmJxBthcdcds
         MePZGITJt0pmshrRdi4Oe+1Cd4cQTP40AtsiE4RUpyjv02o1yz5pjiG9B22KKLdbQw
         +dEO6lNZ9N9bmKgOMc1v8UTiY14gLGnHl+bKqQvDK3tEA9YjocceEA5I0CW8tGK8OK
         fWLma4xlKG12ivZoiSOPh/7u6ad5o3p5v+dVChh/MLRDuaPbmzc2TbhRqWWOM7Lb3u
         ZThgOtCr1pKNI7TcssqPwYXoLpeyhdjiyX92qznkTtiMvIHcjsCfvYs8W3xzbNhctu
         OqqpAfuRQ8zfWh9j1BZdzAGN/tIOffpLtcNQ/zxoRVufapIKqIyz8DZdoCGa6Ii5wl
         HqRp1vY+qJm+8YMDedk07knYc4hDdIQno87wriEpQNx6pUE6Ddg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 02/15] pack-bitmap-write: use GIT_MAX_RAWSZ for allocation
Date:   Mon, 15 Oct 2018 00:01:49 +0000
Message-Id: <20181015000202.951965-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-bitmap-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index fc82f37a02..6f0c78d6aa 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -37,7 +37,7 @@ struct bitmap_writer {
 
 	struct progress *progress;
 	int show_progress;
-	unsigned char pack_checksum[20];
+	unsigned char pack_checksum[GIT_MAX_RAWSZ];
 };
 
 static struct bitmap_writer writer;
