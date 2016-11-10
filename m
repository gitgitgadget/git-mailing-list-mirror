Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB22E20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964946AbcKJUep (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:45 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36795 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935862AbcKJUen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:43 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so152168066pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HvhiNjitOzNNdcBDLcQ/O+O7SpSMd9kg9jcGF/kBY14=;
        b=R2Wug03a4avP6lHMT+inTeHLLxFYaSNDBrXqurnwNQjOKzaNFgkaFmrBCVT4ICoXIw
         XaEjKVdMxBnJfZXntxJD4VHmCVoANCAXNln1BS+KsL8tQI9yBZaih/g8WNGn3prLlzh6
         mjeWxK8PO8GIFtlMubji/S8kBFtRFoAH/dam3N9enDnX32sy1VqHJ8urxYqQWoWQ+SuM
         T4kkGp0xCsbtncUFBFSsVSKY/r9ZbgB+G2nCxErZjKRi/c2+UletZ29tWRGJm3Mps4Wv
         RiaZDpVGNWfBYybHAv+jxGBIvbNdQYtmMLfjKiJVbCIBGRsdYjnf+TCEy2lJ7dYHnsmT
         qigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HvhiNjitOzNNdcBDLcQ/O+O7SpSMd9kg9jcGF/kBY14=;
        b=nBAGrNq7U0CkJ8CVyhV2XCxo16IKlNrdVfX4sGRGtStdWwiHtX3OEOCc1tPs3Yc9yP
         zGAE7mWFaIv4LKn+esOU01PXTYSxevODh3tC12kXULIvL2bYgJPGmqJHWaVEM8zkvz8F
         WEmRYQemMX2RGd9Vs+8isikydlSkTajh/5yPmWMgd4VGS2d04jFS/oVWFhsXyA0YdWwJ
         immS/m/X4sQ9opE/9mtYNHgdHoaq+dVXEmBb5sQeLkBMeaIBS53keCRoDR11d8bTf9U+
         M+B/tizyFkNIEpixqZa1bByCUa+UveXUwINVPjAG5Qm6dL+eCxBxgGp5nKOz6YkRFrBi
         7ntw==
X-Gm-Message-State: ABUngvcaaAlsyqBt1tHRUtAa/YUm05UhRyaeS7paG5hAbxkJTf2cBhyHmc8M9lvHRfbMVHm1
X-Received: by 10.98.163.71 with SMTP id s68mr13457661pfe.60.1478810079291;
        Thu, 10 Nov 2016 12:34:39 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id v6sm9287177paz.45.2016.11.10.12.34.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/35] attr.c: update a stale comment on "struct match_attr"
Date:   Thu, 10 Nov 2016 12:33:56 -0800
Message-Id: <20161110203428.30512-4-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When 82dce998 (attr: more matching optimizations from .gitignore,
2012-10-15) changed a pointer to a string "*pattern" into an
embedded "struct pattern" in struct match_attr, it forgot to update
the comment that describes the structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 45aec1b..4ae7801 100644
--- a/attr.c
+++ b/attr.c
@@ -131,9 +131,8 @@ struct pattern {
  * If is_macro is true, then u.attr is a pointer to the git_attr being
  * defined.
  *
- * If is_macro is false, then u.pattern points at the filename pattern
- * to which the rule applies.  (The memory pointed to is part of the
- * memory block allocated for the match_attr instance.)
+ * If is_macro is false, then u.pat is the filename pattern to which the
+ * rule applies.
  *
  * In either case, num_attr is the number of attributes affected by
  * this rule, and state is an array listing them.  The attributes are
-- 
2.10.1.469.g00a8914

