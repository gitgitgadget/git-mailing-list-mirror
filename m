Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9601F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfEHLNc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:13:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38613 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLNc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:13:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so10335074pfo.5
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMP/cRtemm2PZO8EJbuclLTX3igG7dY30nAnBhSu8xY=;
        b=Du8lkG2PE1f6YXu9zDMOlgz4+RqaAWcLPc+WLI2hvGljUPUaMuESJR6LwJcnn4PkPj
         RU95cX+LPWmRazd0Wzkl0yvJA/HNfufFK22A5odJS4+8mOtfEiAAJ4NA6uzZpFTxqJWP
         SAXwrg41DaUrAr+VGG7/tJwDXDfsLGqP6fJgcsMjCEhhoGmIL6Va1poD7OXtuGqMfrmH
         hXbF33xmJYSdq20JC8HD4tGZUEORx2haFvJgsnOf8vZdFKGh5vOeaG4rI6zO6xIeNx7g
         Bu4+68Kw+AuPbxOtvSKFMSwoCwEcg4NkVFkk0GeCbeTJ0If37B1Iae5+k4C5I5gfJQaw
         5LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMP/cRtemm2PZO8EJbuclLTX3igG7dY30nAnBhSu8xY=;
        b=uPSp3S99a4uTMUV5Q5daWQmc8Mbd9CPjH/zpMhibMpDn/GIiGa6d0wDctl/jcJDwAG
         +3JvUmm/YylgOgdrks5jSL/KtpBqKVqOIfPEJlP4wDeGzNPheAVndzkFM0HXxSG4RfAh
         +ZJJ+SmUY2Jpd6KTLqiRehQoYttECtt1b63npZsbNG3ArSI9Pop3KROQa9Zhv1hasfYR
         11S/mQtRXAND38b+J+/CLK5Sn1i3eKIQVH/B2LqrPPOdXYckr4N16ciHpRpDXlIeuAws
         iF8mGE/uraQg5ueOpTPgdedGRHLki4djB+T5SH5Huixk3K3AK560lUO/LdoPr3hSAS2k
         gvBA==
X-Gm-Message-State: APjAAAXLhwn0y3vm9r+Vrnog+02NiXFRtuHnTAvgM3TAFogZLRnCWiBs
        kXpj0Yw/Yiowr3GKNsVF/FDLLORN
X-Google-Smtp-Source: APXvYqxVdNP5BTnnDYYu5EU5AY0SIEvfBsZGUCZ1macTCQL/s0JkSHn0cbI5bwVCSK1M6L1YW9kJ/g==
X-Received: by 2002:a63:1b56:: with SMTP id b22mr22861062pgm.87.1557314011707;
        Wed, 08 May 2019 04:13:31 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id u75sm4809691pfa.138.2019.05.08.04.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:13:31 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/19] revision.h: move repo field down
Date:   Wed,  8 May 2019 18:12:32 +0700
Message-Id: <20190508111249.15262-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This block at the top of rev_info is "Starting list" and repo is
obviously not one. Move it to the bottom since it's not that important
to stay on top.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/revision.h b/revision.h
index 01e4c42274..71e724c59c 100644
--- a/revision.h
+++ b/revision.h
@@ -74,7 +74,6 @@ struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
 	struct object_array pending;
-	struct repository *repo;
 
 	/* Parents of shown commits */
 	struct object_array boundary_commits;
@@ -278,6 +277,8 @@ struct rev_info {
 	struct revision_sources *sources;
 
 	struct topo_walk_info *topo_walk_info;
+
+	struct repository *repo;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
2.21.0.1141.gd54ac2cb17

