Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BC41F462
	for <e@80x24.org>; Thu, 20 Jun 2019 09:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFTJzg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 05:55:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36335 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfFTJzg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 05:55:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so1380178pfl.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1gxcI9NLNmLhk54Ses/+egBIjoZcrFCzeseEKkzO4pM=;
        b=RpMVJmO/rOevlcXS+2xCiPvkpxWod+5TFgColWNxw3cvwLSM3tuqCDKSshr1TzRDLl
         Z3riGVVCQgphbDk+PVAXnBfWMmKlcOn3p2TG7DhMckHE99XAXknLpof0NfH+q84B7rxm
         5lxLbGCZfFRC/9TkV99hVSWBAUu/eE3cxQ1K6pa1n9pwCRmpUtUrAj+qULVrYgd/Hpfp
         pG1w66zs5t47e29ABqKz39QFwZT16zxelAuPwsSan4fi+Mp9NAgXeuMBwQ0cycEzMM2k
         TajnnVKIxOD5gxmmooYEZU0TQQLwQenL0/pLj8LtPUEgh8sT7IlXMMXFU+kqnQ40T/Cu
         j+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1gxcI9NLNmLhk54Ses/+egBIjoZcrFCzeseEKkzO4pM=;
        b=WQlTqYLF4oTM/grt+lzItoCUh87D+0ePunS/qQ4r3//EzUzGqKGu5x7KsjQkvC/thM
         tsxe5dz4v37OkCkcZeuO6YzD0TvM8Hy2aXNRrZeKKSLN0cZ45SMEtsF+FJw7q9gUbus4
         S2uP9d0U9g2N+wSHhsYNDI5jfSXnBC9VbkZMXSoCmAFuFaMMZiKuMYa8GZerh+Vgtw3b
         ro9V16OvMSzX5joG2/OWt8VsSYvflGqnA3WEX+C/FpfF7ywlz0mn4+8svHDgCzlO0/lS
         E2rluYAljlsk7q0zwIDza0OcDXo3jMjyLILRSt26TGKNxc2WzylFm/2cZSNCtk6SwoYS
         wrRQ==
X-Gm-Message-State: APjAAAVc1Hq/EPoq196nnw1rIHJ4Dy4n+78qtIProV3Kp4AilO1LhXmo
        R/9tHELx6lN1YjwSm8sVcXAY7RX/
X-Google-Smtp-Source: APXvYqznvbHUgWzkOv5r7c5dmPGkmEY1JG+j8hpdZ8GVTtnD9pa0b0CVGinomTu1FEPdye529AdmdQ==
X-Received: by 2002:a63:6946:: with SMTP id e67mr2683617pgc.15.1561024534022;
        Thu, 20 Jun 2019 02:55:34 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id t26sm19114266pgu.43.2019.06.20.02.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:55:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Jun 2019 16:55:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/4] t2027: use test_must_be_empty
Date:   Thu, 20 Jun 2019 16:55:20 +0700
Message-Id: <20190620095523.10003-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190620095523.10003-1-pclouds@gmail.com>
References: <20190620095523.10003-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2070-restore.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 73ea13ede9..2650df1966 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -90,9 +90,8 @@ test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
 
 		git restore --ignore-unmerged --quiet . >output 2>&1 &&
 		git diff common >diff-output &&
-		: >empty &&
-		test_cmp empty output &&
-		test_cmp empty diff-output
+		test_must_be_empty output &&
+		test_must_be_empty diff-output
 	)
 '
 
-- 
2.22.0.rc0.322.g2b0371e29a

