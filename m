Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A4C1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeDRWg6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:36:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDRWg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:36:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E57C860AE0; Wed, 18 Apr 2018 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091015;
        bh=+7oluQOzCimjZbZ+BOZIsrANIUopLlD8Bk8LkB/cxB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=FY/cGWmBWMfK4HJjFyxn6KB4x+rnrrkMAJ8ph8rEfTcgUuG4nN/m8nbzdNG5p7HZu
         DJgvKhIztLaspu7tG/DE6kbgqJ3CejYo9m0v1R3CGgwZJxRdVvyAEi0u/s4rmo9nbQ
         2+rx3XDapN+4OjCv7/0q1U8HJ0jlFk61u0ZrsEBM=
Received: from localhost.localdomain (unknown [188.27.164.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eddy.petrisor@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F4796081C;
        Wed, 18 Apr 2018 22:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091015;
        bh=+7oluQOzCimjZbZ+BOZIsrANIUopLlD8Bk8LkB/cxB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=FY/cGWmBWMfK4HJjFyxn6KB4x+rnrrkMAJ8ph8rEfTcgUuG4nN/m8nbzdNG5p7HZu
         DJgvKhIztLaspu7tG/DE6kbgqJ3CejYo9m0v1R3CGgwZJxRdVvyAEi0u/s4rmo9nbQ
         2+rx3XDapN+4OjCv7/0q1U8HJ0jlFk61u0ZrsEBM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F4796081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eddy.petrisor@codeaurora.org
From:   =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
To:     sbeller@google.com, jrnieder@gmail.com
Cc:     =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        git@vger.kernel.org
Subject: [RFC PATCH v4 5/9] fixup:t7406:cleanup chained submodules after test is done
Date:   Thu, 19 Apr 2018 01:35:48 +0300
Message-Id: <20180418223552.18345-5-eddy.petrisor@codeaurora.org>
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
 t/t7406-submodule-update.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 974f949df..c5b412c46 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -298,7 +298,9 @@ test_expect_success 'submodule update --remote --recursive --init should fetch m
 		cd submodl2b2 &&
 		git rev-parse --verify HEAD >../../../actuall2 &&
 		test_cmp ../../../expectl2 ../../../actuall2
-	)
+	) &&
+	test_when_finished "rm submodl2b2" &&
+	test_when_finished "rm submodl1b1"
 '
 
 test_expect_success 'local config should override .gitmodules branch' '
-- 
2.16.2

