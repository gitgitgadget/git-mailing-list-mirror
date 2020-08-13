Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628F2C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E8E20771
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GDVT01Hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgHMWtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:49:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbgHMWtl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Aug 2020 18:49:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5846260456;
        Thu, 13 Aug 2020 22:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597358950;
        bh=/UWyIRPeHOgBS3CbUFCOvh0owZtZCPfwxn1QHiDMcKA=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GDVT01HhxLF6pJx2argjTbnj1j6eD2wKkslpCFKzV5S1Jlu2/Htmp4iMcMdKs5G/J
         xOjHeWasEuLHifuFBcJUzyrgV9aSfZYpUwwqnV7zovnAUainqLxyjF7UfP1mt4oNKL
         2VDK7L3zOFegd7HW2cWpDeIa7lkKRaKqKMU0OWphny/MK2xCtJStWr9sx3OAlrw9wn
         rV7WJVEemfmMJbWDsGlrwo4DtLE5OFl4GMGeic69Am3eqXsmtiAGoHqNFjSIdZFHzp
         ho23ZUrmNElZH6oZX03zWjR0YlX+gqL2c4HtO++Q5PpLagRw57W/lKGz1xRZD81M2w
         fez67mpwLC/kENypPD9Ku98gZoLygYY/ge/ywUF9uNz5O4cPFar6s7jFBb9lYfpJxV
         BN2noO2LG9P8LImu6gOy+gyxAP6AirX8BUFvcbv7RxvzUql6NotE4CoZsIE29nJbWQ
         ZVMXLJU+XxCfT+FXd7Yd0givWeOs7mB0GxyCNYDRThwSMxChQ+C
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 0/2] Documentation updates for SHA-256
Date:   Thu, 13 Aug 2020 22:48:59 +0000
Message-Id: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.220.ged08abb693
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As was pointed out recently, some of our documentation doesn't properly
reflect the new support for SHA-256.  This series updates the pack and
index documentation to reflect that these formats can handle SHA-256,
and updates the transition plan to reflect what we've implemented and
what the next steps are.

brian m. carlson (2):
  docs: document SHA-256 pack and indices
  docs: fix step in transition plan

 .../technical/hash-function-transition.txt    |  2 +-
 Documentation/technical/pack-format.txt       | 36 +++++++++++--------
 2 files changed, 22 insertions(+), 16 deletions(-)

