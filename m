Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8DC71F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeDRWg5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:36:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbeDRWgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:36:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F317D60C5F; Wed, 18 Apr 2018 22:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091014;
        bh=HD1PtYVdOmBi4g0FyBv/+mFDPIt6JFsd+FKNMzMIE4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Eji7QhFU08hIn+QQKYxinWzvKGHH5jlODtN6VjFrJdItw9B87GT6sRicv5ocJXXTI
         Sba3S5vA0YndxJxk9uNZ2wzpr4fFaFc7rwopmNXFtJY5b3utt++FJJLw0xjIJwvWl5
         /uHmtF15RG6sMXZE/lpd1SdILHR90Zt1oWVb5NWA=
Received: from localhost.localdomain (unknown [188.27.164.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eddy.petrisor@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D67260AE0;
        Wed, 18 Apr 2018 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091013;
        bh=HD1PtYVdOmBi4g0FyBv/+mFDPIt6JFsd+FKNMzMIE4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=mA1DtD1c2+vKdhhtHifFsoYUO406J3CABPfGzzA6z15g0unAFXJZOGKHjjfuu9vhk
         B6XgaR3qgz+zj9kLBo2EbnSBNntrqOQbcKZLl3A6kxO313sJ2QhlBu90hkZCsklZ3x
         U+wYi2fjxGR0KZHwwJ46VM1QD5UjKsKurZexGfcM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D67260AE0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eddy.petrisor@codeaurora.org
From:   =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
To:     sbeller@google.com, jrnieder@gmail.com
Cc:     =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        git@vger.kernel.org
Subject: [RFC PATCH v4 4/9] fixup:t7404:use 'git -C' instead of cd .. && git
Date:   Thu, 19 Apr 2018 01:35:47 +0300
Message-Id: <20180418223552.18345-4-eddy.petrisor@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180418223552.18345-1-eddy.petrisor@codeaurora.org>
References: <20180418223552.18345-1-eddy.petrisor@codeaurora.org>
In-Reply-To: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
References: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eddy Petrișor <eddy.petrisor@gmail.com>

Signed-off-by: Eddy Petrișor <eddy.petrisor@gmail.com>
---
 t/t7406-submodule-update.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 7fb370991..974f949df 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -288,10 +288,7 @@ test_expect_success 'submodule update --remote --recursive --init should fetch m
 	git commit -m "add l1 module with branch b1 in super5" &&
 	git submodule init submodl1b1 &&
 	git clone super5 super &&
-	(
-		cd super &&
-		git submodule update --recursive --init
-	) &&
+	git -C super submodule update --recursive --init &&
 	(
 		cd submodl1b1 &&
 		git rev-parse --verify HEAD >../../actuall1 &&
-- 
2.16.2

