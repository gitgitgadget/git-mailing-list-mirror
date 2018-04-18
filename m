Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94AB1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeDRWhG (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:37:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeDRWhB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:37:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 526896025C; Wed, 18 Apr 2018 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091021;
        bh=BaN5UI6KGOKCYwnwSPJtfoG4xyRZj2ihD8lCYFnbe4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=P7tsf/et40O034ogLfBJObrQUcj771TpZV2ITxiW/ecmV4xe4bWAartw+N/Up5K1Z
         u7U6aXbM1UNJekk1r8vtXIsmMxwL+EYW62dR/44N2xqbLPbm2AvYH4w5YdSF8j692l
         4QWCt0URkzi/U0GWSRJ2AeQV2NrRgOqQhbmT0zuI=
Received: from localhost.localdomain (unknown [188.27.164.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eddy.petrisor@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D5016025C;
        Wed, 18 Apr 2018 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091020;
        bh=BaN5UI6KGOKCYwnwSPJtfoG4xyRZj2ihD8lCYFnbe4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=MgPYqeTGq5I9tPrHYQCHQE89Zwuaeh3VzsGXRK2ZUsTIyjq5p9MRWt7SPNpXG9Fyk
         7yMs/ZkRN+dyRo6vWrz1VQf9n4D5tTe01U7Ph03+Znsq5KRcNaPNu4zoZUgmh7V15g
         si4z5YuxD0fEaJw2XA/PljsuVBleUHROZoXNV3QI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D5016025C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eddy.petrisor@codeaurora.org
From:   =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
To:     sbeller@google.com, jrnieder@gmail.com
Cc:     =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        git@vger.kernel.org
Subject: [RFC PATCH v4 8/9] fixup:t7406:use super_w instead of the existing super
Date:   Thu, 19 Apr 2018 01:35:51 +0300
Message-Id: <20180418223552.18345-8-eddy.petrisor@codeaurora.org>
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
 t/t7406-submodule-update.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 18328be73..f44872143 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -286,10 +286,11 @@ test_expect_success 'submodule update --remote --recursive --init should fetch m
 	test_tick &&
 	git commit -m "add l1 module with branch b1 in super5" &&
 	git submodule init submodl1b1 &&
-	git clone super5 super &&
-	git -C super submodule update --recursive --init &&
+	cd .. &&
+	git clone super5 super_w &&
+	git -C super_w submodule update --recursive --init &&
 	(
-		cd submodl1b1 &&
+		cd super_w/submodl1b1 &&
 		git rev-parse --verify HEAD >../../actuall1 &&
 		test_cmp ../../expectl1 ../../actuall1
 	) &&
@@ -298,6 +299,7 @@ test_expect_success 'submodule update --remote --recursive --init should fetch m
 		git rev-parse --verify HEAD >../../../actuall2 &&
 		test_cmp ../../../expectl2 ../../../actuall2
 	) &&
+	test_when_finished "rm super_w" &&
 	test_when_finished "rm submodl2b2" &&
 	test_when_finished "rm submodl1b1"
 '
-- 
2.16.2

