Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4E31F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfJ1A7Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54236 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728837AbfJ1A7X (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1937B61C70;
        Mon, 28 Oct 2019 00:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224363;
        bh=kTsu/KkPU5uz+yUbxqOEEb5PQfKnr0zRi+ykxEt3e/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=of6jsPY0VBxUe9ooNnat7Xhc/bGAkDhm4YdU6XJdxyjd7V7IsKFau99FKtkBx9Nxd
         vUECJ7W0nXv0umNf73EQJX6N8FlkHhbKXWZdr+Z5Yi6vYI6AZxbBQiwmQYGA5wRhSI
         o0U1PoctIfTEp1I0DtulmMiwaAfOTtJyp4CXp1hbxQU+1ggK2NG+iwz7HbnvlwxUkK
         khpiTEhf9KztqXrUykYH13X8//H5HAssNnDEG/We2G/hn7M4+301LzOXwkcvJqkJE+
         p3frTRv4KUCwIsmxJHLjPEyRKqfqD5YgW9ildohIpkgUqzE4Rpllz0Tu6K6noebEm2
         xO8CAtjp5qmN0TQdrYrr5NkTR3h/Za3C0Cosy8wgL9cSPXi0w2pK2GepSqgtPIK7Uj
         slAjBJt4t3ULBTQ9ZqN5Q/KHGTULjAcKGZzlDU0n0BGs0OPdAu5Wm40Q3zjuN8PXz9
         Ru/3g33nRxIU+pt9TovZGE0gL6AKbtCbFNHi0GozpwZl/vgMf5c
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 02/15] t/oid-info: add empty tree and empty blob values
Date:   Mon, 28 Oct 2019 00:58:54 +0000
Message-Id: <20191028005907.24985-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
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
