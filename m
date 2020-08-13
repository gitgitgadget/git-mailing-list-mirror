Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECACFC433E3
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB76320855
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="K75Zhoea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMWtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:49:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41496 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgHMWtm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Aug 2020 18:49:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5F71A6081E;
        Thu, 13 Aug 2020 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597358951;
        bh=B3h++Hc4P9Hj98dIK04qBWKBYsXASrBJcG4cGEcrx90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=K75Zhoea0CdAa9gWh80chHBKd9syCKIZUOsaD0JpE+c2ADVcJUFqH0d79t7WvibMz
         lsmvbtz2OXfvS0KLQy5vWHGPUVDkIfngnZkFwVCiGaFt0g8db8Cpqa8PoGxL1HBT22
         jIPFb/Dal6DLfmGObsYq5Ljx5MyZ1sKP39mpIcEFLP/IbE3iNbhxsvlWUE/gAAveJH
         WYxvqVgsk3eRkmbZoGbZOXOVSEtGMAKLNgua3MQx0MHm69rmRW3l9FIiEZXenFqFaI
         CWP2QQ+zaJbLs9j9VhzT4Z56Q9PH6yPVUJ6sxR9ctP45Pxt/n1EXiaDmIXzErCmZXi
         JaQGO15rkt+8izjBSnrPXZi9CRlH31dHbucRRiZtZGY1+v67A6WC8pSQ2rI9M3i+Ls
         9R1pyH9XZDeBp04ZN1gdtQFaGx+5WRhLP2U5JDqMlltYUKqzIN63SfZYk7o54i57Fq
         WpjHpQ803w9i/rt0vL7Viggfnehm371jmyiGZSDSXzJfF1Ac4pW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 2/2] docs: fix step in transition plan
Date:   Thu, 13 Aug 2020 22:49:01 +0000
Message-Id: <20200813224901.2652387-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.220.ged08abb693
In-Reply-To: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the required steps for the objectFormat extension is to implement
the loose object index.  However, without support for
compatObjectFormat, we don't even know if the loose object index is
needed, so it makes sense to move that step to the compatObjectFormat
section.  Do so.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/technical/hash-function-transition.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 5b2db3be1e..6fd20ebbc2 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -650,7 +650,6 @@ Some initial steps can be implemented independently of one another:
 
 The first user-visible change is the introduction of the objectFormat
 extension (without compatObjectFormat). This requires:
-- implementing the loose-object-idx
 - teaching fsck about this mode of operation
 - using the hash function API (vtable) when computing object names
 - signing objects and verifying signatures
@@ -658,6 +657,7 @@ extension (without compatObjectFormat). This requires:
   repository
 
 Next comes introduction of compatObjectFormat:
+- implementing the loose-object-idx
 - translating object names between object formats
 - translating object content between object formats
 - generating and verifying signatures in the compat format
