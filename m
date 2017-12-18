Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB131F424
	for <e@80x24.org>; Mon, 18 Dec 2017 21:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937410AbdLRVuB (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 16:50:01 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33327 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935216AbdLRVty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 16:49:54 -0500
Received: by mail-io0-f193.google.com with SMTP id t196so11395590iof.0
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bOqZTIgNfYaGearpUu/NTtFHtC7CcEpqwb4HBh3SiI=;
        b=YChruQvjj2XudOs0rw7ChvfVDhVFP/1+CFb7b/xAMOjTqinOT2OH9RqVWrpUWGwwPZ
         PNPQ3MkBtOnaOtZUn4TN1H+IbDrRqgXS5GVg5oXHgMoav6L+8yqOV6Uydn0bojf9MWOH
         aPwz1x2++S84sRVyhEgNvL0SczoKKym/PjzaIzGkp788stZbc0UyLt/jVVMYDt5wCcv9
         e5s5CPtxi+QgfGO3xWBSBMCdYKqYynHcr0VfyX8CxRslmtJm/i0Ez6caXBk2vRltPUET
         duOHn5wF4ZXq4Yr0R4XPPZ9qFccDzOxO7RdOt8wyi7c1/nIbqMZH6o9zqPgG7fRmawQy
         IHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bOqZTIgNfYaGearpUu/NTtFHtC7CcEpqwb4HBh3SiI=;
        b=CqOocxHKF/ds07XcBWjAxlQT54SsoiTyeEXkaysXRI0bnBO1A8nn8NU/i4udfqCUIf
         yHQ7RMGpKyYoGHEEmxEIW/V13Jfd5kQKqJG24UCH9AmYXb5kZj4kTDWN+ZN8Sx7AbBn6
         1sBeXOwqp/gLT/XYozvB+oKblnTq6MdF3MTTbxLGc+Xz6us+IyN83uqedGypXqvQ9sKd
         Gw0MnLqXXcIw3OJRw6jNPc7yC/+K0B+atkcZbiR5VUqhgejScMVVDuxpj/fEm68Rq79U
         TGuhVBIBeGQvblH6MjIWVoh7/BgzoPNAfPkXhZOJatX15lib3TMeqKNivr82350YeBbv
         WCyQ==
X-Gm-Message-State: AKGB3mKQglMmAUkn/N313cg8XMyv366iImE6CL8Cycs4Fe/JkJBBPOIc
        w/Nc8/HYqoIKhIvGIK8S6Sl+5+Zo7Gs=
X-Google-Smtp-Source: ACJfBovdh6HuyguKtWlyD3HKT907PFE8HsuXzMYOgJC5q52TGf66q19vzkRLdPIa/JibHwce0qMcXg==
X-Received: by 10.107.170.148 with SMTP id g20mr1397807ioj.175.1513633792758;
        Mon, 18 Dec 2017 13:49:52 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e132sm146229ite.41.2017.12.18.13.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Dec 2017 13:49:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [FYI PATCH] t/helper/test-lazy-name-hash: fix compilation
Date:   Mon, 18 Dec 2017 13:49:47 -0800
Message-Id: <20171218214947.210042-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was compiling origin/master today with stricter compiler flags today
and was greeted by

t/helper/test-lazy-init-name-hash.c: In function ‘cmd_main’:
t/helper/test-lazy-init-name-hash.c:172:5: error: ‘nr_threads_used’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     printf("avg [size %8d] [single %f] %c [multi %f %d]\n",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         nr,
         ~~~
         (double)avg_single/1000000000,
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         (avg_single < avg_multi ? '<' : '>'),
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         (double)avg_multi/1000000000,
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         nr_threads_used);
         ~~~~~~~~~~~~~~~~
t/helper/test-lazy-init-name-hash.c:115:6: note: ‘nr_threads_used’ was declared here
  int nr_threads_used;
      ^~~~~~~~~~~~~~~

I do not see how we can arrive at that line without having `nr_threads_used`
initialized, as we'd have `count > 1`  (which asserts that we ran the
loop above at least once, such that it *should* be initialized).

I do not have time to dive into further analysis.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/helper/test-lazy-init-name-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 6368a89345..297fb01d61 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -112,7 +112,7 @@ static void analyze_run(void)
 {
 	uint64_t t1s, t1m, t2s, t2m;
 	int cache_nr_limit;
-	int nr_threads_used;
+	int nr_threads_used = 0;
 	int i;
 	int nr;
 
-- 
2.15.1.620.gb9897f4670-goog

