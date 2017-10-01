Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED1A20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbdJAO4r (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:56:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43131 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdJAO4q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:56:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id m72so4901539wmc.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrEwZKKbi0uxKZcsmW4V6fFQZ3JF/YdTVtq+qiJg3EQ=;
        b=i1MBMyGOh0CR6BM1hDg33CH0un1EEyKLYH1rMIEkgI6H9wj2/xBRTCa++HweYWSCsu
         XFsRwmtqVicH6tHMTX84jQPzaXyLq7k0gW4+jevx2DcOQpcoJ6iM91RqDdqUI7G0+oC8
         UpL+eQaOLWsrKeUL5we2LT9HKxOo78TiOi+oRQnVbVLFO+Q2JzY8ORDULeuF6aZNq4bc
         ECbST5zWFKhtU+o5qaacNfQ/29BuovSewSee0NDqV5xRKHtumgJyY8veOMXh+AkCkLHF
         tJOisXhhGWMMpoX/wYlnvLFFxBlDspoEvZ8rZskx9MF/2Kca70ggVgFKus/nWFs8arme
         oN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrEwZKKbi0uxKZcsmW4V6fFQZ3JF/YdTVtq+qiJg3EQ=;
        b=PthB8Aiyydd+26iWGsSMX66gC0TpsVJ6OhARaB4EgZNMzwQKd30N85koSm15DrW8Ow
         mw43Pfyc4kn+vFErRgQCaiQT3Am6b2y1boVWa2xf91a6OH/12ubfMaqx9hr2wtIgr8xL
         unnMCHFBJIZfRE5xRCfq/90HjkgvuIcjYdlW7LUiFuaG+uC04dYgPqD0DToM9Q7fyxo/
         0lhfVEg3XbuI9wPsaUbhXNp2PKRpCjgz0Vp6vJFSnUCdNaT8g+uN7ZTh34NEQhLzx4F2
         ZFM4rK/lS581Cu9nU4Lp7RBg3BqE/DJ0YlSpFhccITVpvRQWfWM5t0FyOk8E++IaGXLB
         8WDw==
X-Gm-Message-State: AMCzsaUm7wV8689s3gNagBFIEf+MyaArgZK7JhHSGp/bcpgyIpxIXi63
        Ch54ddVD8/QS9ZJ41ORbfnyVAQ==
X-Google-Smtp-Source: AOwi7QCWv8x+tgCSltJS+XxzX2/JhTJ2bDlKIRQtnBJzUUmDCieauTDJ2x6dv6cxfb3nabZKBS+HbQ==
X-Received: by 10.28.19.10 with SMTP id 10mr8462476wmt.87.1506869804872;
        Sun, 01 Oct 2017 07:56:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:56:44 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
Subject: [PATCH 04/11] tempfile: fix documentation on `delete_tempfile()`
Date:   Sun,  1 Oct 2017 16:56:05 +0200
Message-Id: <17640b932b49cf86d53a0149300f65f01bff9135.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function has always been documented as returning 0 or -1. It is in
fact `void`. Correct that. As part of the rearrangements we lose the
mention that `delete_tempfile()` might set `errno`. Because there is
no return value, the user can't really know whether it did anyway.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 tempfile.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tempfile.h b/tempfile.h
index b8f4b5e14..450908b2e 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -68,10 +68,10 @@
  * `create_tempfile()` returns an allocated tempfile on success or NULL
  * on failure. On errors, `errno` describes the reason for failure.
  *
- * `delete_tempfile()`, `rename_tempfile()`, and `close_tempfile_gently()`
- * return 0 on success. On failure they set `errno` appropriately and return
- * -1. `delete` and `rename` (but not `close`) do their best to delete the
- * temporary file before returning.
+ * `rename_tempfile()` and `close_tempfile_gently()` return 0 on success.
+ * On failure they set `errno` appropriately and return -1.
+ * `delete_tempfile()` and `rename` (but not `close`) do their best to
+ * delete the temporary file before returning.
  */
 
 struct tempfile {
-- 
2.14.1.727.g9ddaf86

