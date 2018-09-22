Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4401F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeIVX7j (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:59:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38782 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIVX7i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:59:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id z186-v6so13593069lfa.5
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUOVmDTWLnahPh8r6j22UM9RBd/Y6P/yRp3O2nj73nQ=;
        b=W4gKw/t3nsRC8e1vhUx2I+VCxSPkEgYwWkhl/+ACQnvVjmiUz3DK3j2aeAhgang/1p
         z+qjzKYY7c+NWkYIYVqkqz8HHC3vIC0Dxms2d1elX4vm2heQ7FY5THD7oxH+xxkLHD6/
         0YvuHGGfTOaJMM0KhIEy5aAIVTIn/3Hrvlm4P4Kx5kI6FzC2EbSL9EVWFmqqm396QCKq
         /bY/J+uA7dA3plIh39iZIj+fFOIAoRePTUdk8ejfCqt5tLFjiggFeNGByYS/UXMcWnrN
         miwLWrZgkrybwszMxr2D/eP+Lhv4gUf4yIBKvh8UncdOU4dlYeB4RxZKpjniqYXW+kxD
         w/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUOVmDTWLnahPh8r6j22UM9RBd/Y6P/yRp3O2nj73nQ=;
        b=hvDBrDI761LVFxR77kpxZFecYYaJcVEM2XV0nxkZoivxZN0L8sY7u8xn/nWfVwyVU4
         mKRmEX6W1Fcr4kifCVlpoLZMHPqD+TaM7iA1UPsdZgvAkXEIWvkVu7DdCmUEv67OiEQE
         ahWxEQJICzzMzMPLT+FkhaTFvSIUjSFamUyKwWah8Sotx4uazTkbVFrGFkVCBMOFLkyG
         T8GYCFkivo06IaBKGykKVLLYsi3nDJ7M3VJX2WSAQ1Q/u11DM51q801P3W7Rndd1obRu
         pj6DI2LyxrfvQpVR6RgSCD546xfbMgZKdvmO6KGlAH+cKA2me6pVN72SQTZ+BfwJe2tD
         00yw==
X-Gm-Message-State: APzg51D1SCdF0vSi1FbJ2kN6BpPzDYArHZ4tL4O1op1n31iiK0mFpDi+
        L8M6PltcmDRUT+sqjw2KB1lP/NtW
X-Google-Smtp-Source: ANB0VdYobKkZrSea8CZTZ01THimsdQbwjDTenX3WjaOAh458wztuZbDl3y0cNE2dFtbHsOQmyiTsQA==
X-Received: by 2002:a19:5d56:: with SMTP id p22-v6mr1840324lfj.34.1537639510728;
        Sat, 22 Sep 2018 11:05:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2877942lfa.9.2018.09.22.11.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:05:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/8] revision.c: correct a parameter name
Date:   Sat, 22 Sep 2018 20:04:56 +0200
Message-Id: <20180922180500.4689-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
In-Reply-To: <20180922180500.4689-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is a callback of for_each_reflog() which will pass a ref
name as the first argument, not a path (to a reflog file).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index e18bd530e4..63aae722c1 100644
--- a/revision.c
+++ b/revision.c
@@ -1277,13 +1277,14 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static int handle_one_reflog(const char *path, const struct object_id *oid,
+static int handle_one_reflog(const char *refname,
+			     const struct object_id *oid,
 			     int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	cb->warned_bad_reflog = 0;
-	cb->name_for_errormsg = path;
-	refs_for_each_reflog_ent(cb->refs, path,
+	cb->name_for_errormsg = refname;
+	refs_for_each_reflog_ent(cb->refs, refname,
 				 handle_one_reflog_ent, cb_data);
 	return 0;
 }
-- 
2.19.0.647.gb9a6049235

