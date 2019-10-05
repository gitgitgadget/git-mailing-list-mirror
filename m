Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF681F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfJEVMS (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36296 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbfJEVMR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6588A61C62;
        Sat,  5 Oct 2019 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309936;
        bh=kTsu/KkPU5uz+yUbxqOEEb5PQfKnr0zRi+ykxEt3e/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xkZywuwlv5uAsu4e9+PUQD8YEm4RDcILFa9B23VV957blwvMGfpX5S4EIqRcvtjth
         8eYs1YRsxiWR+Q8G7eqW1T5UFuR/Zqxlqhpp5KngdEpMprodr89fu1RjmSMp7RcyKo
         6cT49u380tOijRak24N5D+h2c/EPH2qjl6mTPBvKFVqfDNytxe/kU3bOfS+KhlXGXK
         vOv0+iFvyoEelUE0lR1w7qPmV8fWHcypez1ovkd7SxNlTNPAyJKlpGZiyvYZOdrtsK
         MZAQ6FA9GzYXgpiUm8BiqBTp6EbbOKS9ko7FtYFF0UneWeM31h+KgdFxc8WGglULTb
         98ifjBurYnAYXLNdbapYO6CfOoQKGNZ97c7+xXI42AP/XF2e43WtJGvoGRikLCvKfe
         5VuVi+lzNrhikdACjulaueBuY7uFCuLyWeH4vUjBi3e5MhNfD/JULVcGkO0UxJ2BAN
         KxPfU4ldWBlvn/K0xI7wO7VeI42peO6mxrX1YKVJ1sRk/iSD2DN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 02/15] t/oid-info: add empty tree and empty blob values
Date:   Sat,  5 Oct 2019 21:11:56 +0000
Message-Id: <20191005211209.18237-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The testsuite will eventually learn how to run using an algorithm other
than SHA-1. In preparation for this, teach the test_oid family of
functions how to look up the empty blob and empty tree values so they
can be used.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/oid-info/hash-info | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/oid-info/hash-info b/t/oid-info/hash-info
index 6b5ded0b34..d0736dd1a0 100644
--- a/t/oid-info/hash-info
+++ b/t/oid-info/hash-info
@@ -9,3 +9,9 @@ zero sha256:0000000000000000000000000000000000000000000000000000000000000000
 
 algo sha1:sha1
 algo sha256:sha256
+
+empty_blob sha1:e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+empty_blob sha256:473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813
+
+empty_tree sha1:4b825dc642cb6eb9a060e54bf8d69288fbee4904
+empty_tree sha256:6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321
