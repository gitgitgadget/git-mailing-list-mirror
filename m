Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A1D1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 16:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbfHAQJ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 12:09:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37331 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHAQJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 12:09:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so34329954pfa.4
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxMHfMow3CKPhsfNq/a2tMzuSeMpYXJx60NuOMXBlaI=;
        b=ZvWspOYYqaHIW4Ne1Vn4Y+6nw+uZDxlFXyTVCdK/nM8vcKIhFP2f9x02EqNdm/fPmS
         PFI1WFcGMZmOoAcBbJ4eCXXrgn463YlvnIwKsCekTw8vGubYF4k/T+V6+r7+cKghimHh
         xM2LTcyoJvzYrC24ClvDyBphnKyd3gSxzwms+lzBopLrzAmJouEN0ysOnSLbrwyk/NCq
         Y7R5k7XaOUicXnjU1ode9Jc3Pr70rRJ6v+yVtTWstMxw9Q+oO1W3KQA9O334qlq+n8Iy
         OGTyOCAnjoTKzgXXUMXvcs1kOI4vrlfyYQAh24JccPOc9Y3qJ/yME1hhWtMQU6OzvNEq
         j8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxMHfMow3CKPhsfNq/a2tMzuSeMpYXJx60NuOMXBlaI=;
        b=W5olC6SFX4RopojpLan6+Yo5s/0nRtk9ETJ2qVZbgKU/AHBYiZxmqltJMXS490udZy
         pSKdClWCnS1R7EB9qjsv3YDhwYcAXQhovxY46CHwenQG3oDCyIRT0jD7J8oZThF7ljrr
         aeusOguyB2RL14PAQe1IrKezwIm9mhlf5EWqcoE/DZnVkKjEm2KEdbyKtEDzB6t4MxQ8
         udWk5BZw2v1qqa6bPw4OcysulSoNw8ysdKZsWLTG9LidLAHhAKybJIRCBPz5E6Uh6Fjb
         DPidELH9/RjP4Sg2uYCGqp8agqgFSJPNp5q0cQGQMZvjYfEe2OoRrJJ9FBWe9/K902Qq
         UwWA==
X-Gm-Message-State: APjAAAVzLy5CMe2t0dlNyp9rgAmbIkqDc9V1yixIveuFfUidCuPM0ono
        3ZVPFGFxlDdywSpxf6yAynI=
X-Google-Smtp-Source: APXvYqw8sM90E2tQenroEt7iRGdLFYP/B41mkcTQL1TtltVYE1EPlLgR/HWq2eWvL8Nb2TifHacNSw==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr9528975pjb.19.1564675767484;
        Thu, 01 Aug 2019 09:09:27 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id b68sm88723167pfb.149.2019.08.01.09.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 09:09:27 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     vcnaik94@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: [PATCH] restore: add test for deleted ita files
Date:   Thu,  1 Aug 2019 09:09:10 -0700
Message-Id: <20190801160910.12652-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726045645.2437-1-vcnaik94@gmail.com>
References: <20190726045645.2437-1-vcnaik94@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git restore --staged` uses the same machinery as `git checkout HEAD`,
so there should be a similar test case for "restore" as the existing
test case for "checkout" with deleted ita files.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
This is the "restore" patch based on the merge of the "checkout" patch
into master.

 t/t2070-restore.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 2650df1966..21c3f84459 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -95,4 +95,15 @@ test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
 	)
 '
 
+test_expect_success 'restore --staged adds deleted intent-to-add file back to index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git restore --staged nonempty empty &&
+	git diff --cached --exit-code
+'
+
 test_done
-- 
2.22.0

