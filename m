Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A451208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 08:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHHKva (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 06:51:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35844 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKva (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 06:51:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so1861949wmc.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 01:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BjgTWc9JR/cLxb+1S2y32goZIcFBcMnlNygRq7uTODA=;
        b=pksOd+G+r8gJgc6HRPWeKYrtQcXNkEfJM8H1ulDv1ihtKGnimRP2HbjpLrAat8ZVaZ
         QkxU1PmXwPiagL2hEjMMNFooPT9v41E9hj8cf7rCgFQ0DmfacGKogIoLq6WfJHsxvnp8
         yf8LZYpNO9XWRbz+k0DMapM7wHXH2rUAvMuGNwFhD+XGpfcTjeeTHS4UR/yPOk08VMQg
         kwP3DX1LAs5KLTWbkDBJfW4+k/Hf7WtDrL1P07eJINWYv22AaTM45W29KakkyS49ftCX
         Ot4T2+a6kkgKHi3bGA9w8z27lnVjPBj78+bXYYCfQjOOtNWJtTnCuA8GDGdRmQqd3sri
         ehjA==
X-Gm-Message-State: AOUpUlEWcaBqjPvCmaGfHK5ocmud9qC8hPJilxARpyChZL8d/SR8HUfT
        a3daVJEpkUxwG/yrVFUHkMP3+L6MCXLDtg==
X-Google-Smtp-Source: AA+uWPx6Sjgya4niyQVOYO0L8j3hWLrptVxDaex+e0FqoX9oYYiHz3fYkg8quV4Nl4Fd7wNlj4146w==
X-Received: by 2002:a1c:8414:: with SMTP id g20-v6mr1295155wmd.90.1533717170528;
        Wed, 08 Aug 2018 01:32:50 -0700 (PDT)
Received: from skisela-redhat.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 198-v6sm7009818wmm.0.2018.08.08.01.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 01:32:49 -0700 (PDT)
From:   Sebastian Kisela <skisela@redhat.com>
To:     git@vger.kernel.org
Cc:     skisela@redhat.com
Subject: [PATCH] git-instaweb.sh: Generate unixd module loading
Date:   Wed,  8 Aug 2018 10:32:48 +0200
Message-Id: <20180808083248.2424-1-skisela@redhat.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <1651347126dc2039>
References: <1651347126dc2039>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

AH00136: Server MUST relinquish startup privileges before accepting connections.
Please ensure mod_unixd or other system security module is loaded.

Signed-off-by: Sebastian Kisela <skisela@redhat.com>
---
 git-instaweb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 47e38f34c..dd67fbe38 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -356,7 +356,7 @@ EOF
 			break
 		fi
 	done
-	for mod in mime dir env log_config authz_core
+	for mod in mime dir env log_config authz_core unixd
 	do
 		if test -e $module_path/mod_${mod}.so
 		then
-- 
2.14.4

