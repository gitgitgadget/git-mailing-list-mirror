Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0BF1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDRWhD (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:37:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbeDRWg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:36:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C824160C65; Wed, 18 Apr 2018 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091017;
        bh=aur+3KEXUUn50kBAADsUZZC3aMsM8hnEe3PMPgCnNYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=A9e+iJfFahSu2iGRiXYp9kT5cSy07Cfvw/SSaZUmmnswOuwhN5HNSTNgVNvWqeL1c
         psqkxxFqVS6LAJSf3FjYaWwOyZ+o9xctVteSJe7iG9cdXHqA0QCuQuFExv+ykd+JHm
         sgP96V5TVi993G/kSsMqCGwuGnUrCyHxjgqyjhEY=
Received: from localhost.localdomain (unknown [188.27.164.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eddy.petrisor@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2E9060500;
        Wed, 18 Apr 2018 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091017;
        bh=aur+3KEXUUn50kBAADsUZZC3aMsM8hnEe3PMPgCnNYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=A9e+iJfFahSu2iGRiXYp9kT5cSy07Cfvw/SSaZUmmnswOuwhN5HNSTNgVNvWqeL1c
         psqkxxFqVS6LAJSf3FjYaWwOyZ+o9xctVteSJe7iG9cdXHqA0QCuQuFExv+ykd+JHm
         sgP96V5TVi993G/kSsMqCGwuGnUrCyHxjgqyjhEY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2E9060500
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eddy.petrisor@codeaurora.org
From:   =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
To:     sbeller@google.com, jrnieder@gmail.com
Cc:     =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        git@vger.kernel.org
Subject: [RFC PATCH v4 6/9] fixup:t7406:don't call init after add, is redundant
Date:   Thu, 19 Apr 2018 01:35:49 +0300
Message-Id: <20180418223552.18345-6-eddy.petrisor@codeaurora.org>
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
 t/t7406-submodule-update.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c5b412c46..32995e272 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -275,8 +275,7 @@ test_expect_success 'submodule update --remote --recursive --init should fetch m
 	git config -f .gitmodules submodule."submodl2b2".branch b2 &&
 	git add .gitmodules &&
 	test_tick &&
-	git commit -m "add l2 module with branch b2 in l1 module in branch b1" &&
-	git submodule init submodl2b2 &&
+	git commit -m "add l2 (on b2) in l1 (on b1)" &&
 	git rev-parse --verify HEAD >../expectl1 &&
 	git checkout master &&
 	cd ../super5 &&
-- 
2.16.2

