Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAEFB1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 15:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfAUPMW (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 10:12:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34830 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbfAUPMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 10:12:21 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so16876279edx.2
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8KGbtnc+OexHLyY5Tmm3rrgjImG08hLVfecai6iHifQ=;
        b=rtSav5USVF+7PBYm41y3PlT2zLFVMzDA5IxK1Nwsl8pb87uctPT8gE35r41Ir50lB+
         IvPqUyXTfM31q98PmsLJtXdQ9RdAeTcTkUVLuzvT9vowMW43gzG+PsfexlRp3b+4Smyk
         nlSsI+BLPs5DQrT3zaPfJwD/OOuULeR+k/+kMAMaaCSNtTrtaVPDozc2ixSYGiA64QCf
         voZnoiEwRi9A6iTIHGvINzr+BfuK9ppGkfwsMbtPdIxC7sPvyff2IP0wlOMRq2d+OiQu
         x7N+xOAcKQanj1TyDUXEYVLtIYaBxEK+CuUgNY6CspMo67WWTMW/9GswpxlgWo6sA4K8
         BSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8KGbtnc+OexHLyY5Tmm3rrgjImG08hLVfecai6iHifQ=;
        b=ZXNfUd40TbtN40Jn70zeTuan17UOX8hvR0WbNp8PZkJiXahYqxd3nrKW7f00IW6Mvi
         pqGRTfXgPieiES5FDYlahD4HhZRiXqp6OZt139Gs908IfPz0y6FGLUGSh8F8/uRVvWg6
         yzytso/enYFAiZ8DhrqcyUz5w6T7njsK7s4lpKQG1LSOz+TVZgw613Bme1OGraTTacPv
         +lU0RZQxUeRF8VDKm12stA1MOGaiQt1BRHSYMq9ivC2/5NeHSiHj4TnoXbYdqaxpI2YW
         sHgD0REFak1kR5NJlwKhY5qdQqbdonfS3+imlJ99/hIrnaTXmHw+lbYcFZcha27K8WFS
         rDFg==
X-Gm-Message-State: AJcUukfnyIrA2s+fjHxV4C47OPZAW8A9Ivy6c3w4jgEmbgfIYxLIM0mN
        Vmem0kDxYHTlZqc7S6DbvWUFnn7f
X-Google-Smtp-Source: ALg8bN4xrgHAYz3wLX5MWwgz4xzoJL2F1jYFJ7OrfEOg2Mk2HftZXHfX6m20KaXVWRSnjIQCPIofcA==
X-Received: by 2002:a17:906:5202:: with SMTP id g2-v6mr24681086ejm.139.1548083540078;
        Mon, 21 Jan 2019 07:12:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm9313646edd.4.2019.01.21.07.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 07:12:19 -0800 (PST)
Date:   Mon, 21 Jan 2019 07:12:19 -0800 (PST)
X-Google-Original-Date: Mon, 21 Jan 2019 15:12:18 GMT
Message-Id: <f396aa113ac3c50ca6a2402cedc71a37cdf63504.1548083538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.111.git.gitgitgadget@gmail.com>
References: <pull.111.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] tests: explicitly use `test-tool.exe` on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 8abfdf44c882 (tests: explicitly use `git.exe` on Windows,
2018-11-14), we made sure to use the `.exe` file extension when
using an absolute path to `git.exe`, to avoid getting confused with a
file or directory in the same place that lacks said file extension.

For the same reason, we need to handle test-tool.exe the same way.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a1abb1177a..9876b4bab0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1154,7 +1154,7 @@ test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
-if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool
+if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool$X
 then
 	echo >&2 'You need to build test-tool:'
 	echo >&2 'Run "make t/helper/test-tool" in the source (toplevel) directory'
-- 
gitgitgadget
