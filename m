Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B891F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeIOVif (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35351 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbeIOVib (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so9875657ljg.2
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKh25848Nq+Ak2nNdEJ7yBZDFuGObTL1+pOecD/YnWo=;
        b=f+K29H86E6Fez2/la9L4b/DFxHCqByOtvkXvBGZYVMDcCEChlDLsM+OWNuzfS48xdG
         2G2Sy9txBzQ12uqOWOXfeZ3ajXGdV7BarrJY84XyUfWHgbPPTiYIbYE4XRV+J0lIJJxH
         QNjStyoTqBg4WPXpCVM1DcCCReA+xwUSzOCXSJNT0ii5yyitO77kk8kC9ngJ9mvPXLVR
         Z7LxouKu64breNU/+7KkD2E+7e3L5ohVB+pKabPOOnFoaqFuTEt3+hnHTpk6RVfhiGvA
         upNFwfmfozmp89oDwjJ7oJgYZ3U2Cj+8qMyhmiInOzP7bG4cvzVvmtdZkBmRTA2HW1wP
         VIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKh25848Nq+Ak2nNdEJ7yBZDFuGObTL1+pOecD/YnWo=;
        b=rwsvNsnPWGuMcgoWh+CnETyJ44c5yd9baVQ5oMw/geJxZm/MEtC1c4wlde3EfwqFAC
         aMOeea4Nhc9MjFgB48I43UB2HfdCho0OxbXZxwpSIBx1h9yVOJM/Ms3On6HOHFLOiteH
         CUi6h2hlDi/EOFU/QwhfKTmw4LGvCtx9WH8oTO4yfdYZS5Pzcsk2oQjAw+kKT/GZZDSa
         /N4mrWGSbF6ct43wK/fKGkO0cPuh6//PmiuMVRDeXwBbiksPvrTKhw+Sa1dHaAfYCGh2
         4DuVDe+Cm503Fh3eKBvrRRWCKWzgNkp1YgX2oDAuMURRDXJkyvifvJM21te1JQHKncqY
         sVWw==
X-Gm-Message-State: APzg51BDdFHRLxH1HGGqDhoa1exJQQl4fN+vXRfwTz1oMvTy54FD6zj6
        ZmFG6bQ1lcEnGAEnETF/bM420Nve
X-Google-Smtp-Source: ANB0VdZ/hYhW/WdSQC1t8KdICcMgquQIg/pbnC0acmJUuv3KhHgJVOSGTeOC5bbRC5LQKvV+FlXiGQ==
X-Received: by 2002:a2e:9bc9:: with SMTP id w9-v6mr3941411ljj.33.1537028339817;
        Sat, 15 Sep 2018 09:18:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:18:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 20/23] tree-diff.c: remove implicit dependency on the_index
Date:   Sat, 15 Sep 2018 18:17:56 +0200
Message-Id: <20180915161759.8272-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
 <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 tree-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tree-diff.c b/tree-diff.c
index 57a15f51f0..16b28ff6d6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -605,7 +605,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	repo_diff_setup(the_repository, &diff_opts);
+	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-- 
2.19.0.rc0.337.ge906d732e7

