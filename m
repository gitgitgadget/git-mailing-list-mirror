Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D460B1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfG1UHa (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 16:07:30 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:33784 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfG1UHa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 16:07:30 -0400
Received: by mail-pl1-f182.google.com with SMTP id c14so26589815plo.0
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuBzkCit4xTjAlP0bZG3qP117kKO1H+AhiJZgtFM6I8=;
        b=lM6COVB/P2uQF6Chnz9otmHGLAaUuyQrMTkn1DxnZcupSKNPr/mw/fAeIwYd3oTn/A
         flJO7B9amg5qSZACG/EqHcZYCLQPEl7p0xMHVkvwhxXWN0tgQwl+1I7FmtsEVF2+EHzu
         Ahh2tOql+j4ivk7hTdOlnyvZLObgv+T52NbZ6BQKmxpnSkcYPwRLxVy+bv5OcFKXBdWY
         Tzy/XSrrS9GbIC4Q2K9yIbsLrdJxdyGWoyajeIbBb62TSSwSbZE1pF24xWLwA8HHM0do
         6uRhCFUWwYmqT3b27enJFkqT0lUV2bvD+g02JLHRNLFELKEGVZNVC0CpT2Bc6bXAE7tH
         FGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuBzkCit4xTjAlP0bZG3qP117kKO1H+AhiJZgtFM6I8=;
        b=S1aKvWHnfej7kbmKQuSGUXpXLX4nP+4zD8rcr+ex80aaSotd7BLDnTFfIbW/GzcLVz
         Ocf81dEwV4WA6Q7W87wt8a9Mv1VA615c186n3RxutvHFpItyx1mMdTk/CDPErTysv6WJ
         WPRjY69Jhcc4g480HChX/zB1DDnqJJsYdpKNbkJMKvC2zbf4Uf4pYoi25/n72OA0xwuI
         EDNHmTn+OCz8oNEE3u4WpvzTrn5tAQN81K50kG3lehHQmd5pmWve3TYzT8pcCWmBQkJ/
         SWEu7FeXAIoZn25STQQVVTVQsC1T/nJW3HHY17J8OEtJSX80uulGNL3rlTx1ejomXBvI
         tvXw==
X-Gm-Message-State: APjAAAXJvCxLcRY7TC/njTf1DNoolQG7wbJ8dfAJglNb0WoCBWOJ3Uuu
        0r68WBDgP+rpozIfugCLNPcOTavxZMk=
X-Google-Smtp-Source: APXvYqyWhGVJswyGZtEpF1GGaPjhYdWICdhFlsBI10wsXfLUePYhFm8I44A0PEyU47m0YVoQLcnnXA==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr31938632pld.41.1564344449111;
        Sun, 28 Jul 2019 13:07:29 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z4sm92603491pfg.166.2019.07.28.13.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 13:07:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 2/5] wt-status.h: drop stdio.h include
Date:   Sun, 28 Jul 2019 13:07:21 -0700
Message-Id: <20190728200724.35630-3-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190728200724.35630-1-carenas@gmail.com>
References: <CAPUEspjp3WkHk376hu5EvvyufGYQCSHKM6cTT3hnQyfNgpnLzg@mail.gmail.com>
 <20190728200724.35630-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We started including stdio.h to pick up the declaration of "FILE" in
f26a001226 (Enable wt-status output to a given FILE pointer.,
2007-09-17). But there's no need, since headers can assume that
git-compat-util.h has been included, which covers stdio.

This should just be redundant, and not hurting anything (like pulling in
includes out of order) because C files are supposed to always include
git-compat-util.h first. But it's worth cleaning up to model good
behavior.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/wt-status.h b/wt-status.h
index 64f1ddc9fd..8849768e92 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -1,7 +1,6 @@
 #ifndef STATUS_H
 #define STATUS_H
 
-#include <stdio.h>
 #include "string-list.h"
 #include "color.h"
 #include "pathspec.h"
-- 
2.22.0

