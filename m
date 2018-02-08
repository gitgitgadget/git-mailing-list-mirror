Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D8C1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 02:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeBHCtH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 21:49:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58760 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751175AbeBHCtG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Feb 2018 21:49:06 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 778056042C;
        Thu,  8 Feb 2018 02:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1518058145;
        bh=WjmYWtU30Lfe502nbJVnQuyn8LBaas+uGl0Qz4FYaKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uo97bFZoc5uZ4tdNujUSRGPFOI1QAtIGmW9mJvyMyPmR749tJ2bIwbRARdpKB+20a
         dEBKi8PvUt8QDhuOfw15WBGiGld5uhuMZ7qMEBwAdcN4bb21wtUz56PCcbn0fUPTOP
         OGe0rl+kQuOf4KY1aFDmhny5Lj1VYxq1NmXV9VFKMIlMtTgrs68AwnMg4V6LUFAvZW
         RNurc1Xnc23EwOkB6a1SzfDEzr5lYPay5eMGQUc+vS7ceRxJLznYlL+9t9oHqKnNVL
         RhUGCQUa62Ug7VfmNB4nNT65AMMpbG0IiXaDoGo2Lcy9i316lo8a/yL6LDO0P3yPBK
         uDTmTJk9GeG5JODeuAmkvXJWPk3b7ccL1i7rdTXj5KZgzjgobmXWDEzjixAQ7N3hVx
         Tyei8GqoNaoU6FEuID+84jQEmT0PXP80veTKQf0dwIJx/mY4pGtwYGvQoGfOmTD8mK
         +7RDDs2t45UhXvcUerDwgVTof8CnkjhGUSigtMfYYl8e0PMF12w
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] hash: update obsolete reference to SHA1_HEADER
Date:   Thu,  8 Feb 2018 02:48:58 +0000
Message-Id: <20180208024858.872624-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.101.gde0f0111ea
In-Reply-To: <xmqqinbfcgzo.fsf@gitster-ct.c.googlers.com>
References: <xmqqinbfcgzo.fsf@gitster-ct.c.googlers.com>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We moved away from SHA1_HEADER to a preprocessor if chain, but didn't
update the comment discussing the platform defines.  Update this comment
so it reflects the current state of our codebase.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hash.h b/hash.h
index eb30f59be3..7c8238bc2e 100644
--- a/hash.h
+++ b/hash.h
@@ -18,8 +18,8 @@
 #ifndef platform_SHA_CTX
 /*
  * platform's underlying implementation of SHA-1; could be OpenSSL,
- * blk_SHA, Apple CommonCrypto, etc...  Note that including
- * SHA1_HEADER may have already defined platform_SHA_CTX for our
+ * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
+ * SHA-1 header may have already defined platform_SHA_CTX for our
  * own implementations like block-sha1 and ppc-sha1, so we list
  * the default for OpenSSL compatible SHA-1 implementations here.
  */
