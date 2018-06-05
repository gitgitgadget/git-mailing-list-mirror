Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02D31F403
	for <e@80x24.org>; Tue,  5 Jun 2018 14:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeFEOlL (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 10:41:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35542 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeFEOlG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 10:41:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id j15-v6so5675653wme.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b4kqkIWu7jnlbGjduBQ1ykNY896p5Rm+wG/zMyO7kZE=;
        b=oU+ZHxnn5Te+QsJcC0KML+D/ZtNFo6d1Hbdk8Zy49/whYFXpd0Auxd9jYuNc6rpJCa
         vcII9rogXYHY4ra/oMQzmGUjtO/hcmXN1rPHe+hqhF29c/Xixuy1HZ0dEqcCCpEIi2sV
         QvS/eaxwdvmFotN2lcUn8HTX7EeOdgWgLVEOgobWalIlRMp+5VtxCd0ybZZEzi/Cu1yz
         RCAkDqPPpzMv+TyG55JmXmS2IMMa4PvNa5jWBm9HonfkicS9D45RhY+eTymN9S28Ks40
         tbFJ2/E3x0UDIUs6ssN/NG5ljX834j0Rb6UYEOmV/mAknC+Wv/NNqptpAdpMWHa7bgCz
         Ph8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b4kqkIWu7jnlbGjduBQ1ykNY896p5Rm+wG/zMyO7kZE=;
        b=Zj8LghYT4hYaP2WfD1fBXF1gElnFY81QE9gm6e6mSFf5GMUGd7/LXmWmKHXynfmuu0
         Gor9zctcPNkSjQA52VuzfbwXgxSjh61o03AWZtnRQPg/SrS7ORLrKWhehVG3TbChSP+z
         w1xXEOFn6l7GX2eFIQSg3HM7KfBT5ER3e7reU19P1EbDYvBVsmcBdJyaJR/dd0H4WuS0
         EqWozCaJYnx2WuCFO1Ke4l4FhqPVNsP2q3iGOhhbb0IylCroKthpl/91NPF68psQKUcI
         cuZjgHateYNmnwI6wSOZ+t7yQviUNLKtQadkio0K/o2SDSvKepw5wcPaAsE43GISZTtf
         9UgQ==
X-Gm-Message-State: APt69E3VIIJV2EeTfoc1XKlDMx3rXi1JFoNFqbHZ6D8Q2AaFRsHtvNlb
        kVN4ZW00m+kXEQ7uUOzI03pt2Z1S
X-Google-Smtp-Source: ADUXVKJ4DoEMwSnmKdPK0P4kOVnyXgjcP7HlbYF7HtIcnLX/I+Az/GPUU7ug4RaLvbak+0/l/+4fwQ==
X-Received: by 2002:a1c:c46:: with SMTP id 67-v6mr12791035wmm.79.1528209665386;
        Tue, 05 Jun 2018 07:41:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i76-v6sm2458910wmd.20.2018.06.05.07.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 07:41:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 4/8] checkout.c: change "unique" member to "num_matches"
Date:   Tue,  5 Jun 2018 14:40:45 +0000
Message-Id: <20180605144049.26488-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605144049.26488-1-avarab@gmail.com>
References: <20180605144049.26488-1-avarab@gmail.com>
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally track how many matches we find in the check_tracking_name()
callback. Nothing uses this now, but it will be made use of in a later
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkout.c b/checkout.c
index 80e430cda8..7662a39a62 100644
--- a/checkout.c
+++ b/checkout.c
@@ -7,10 +7,10 @@ struct tracking_name_data {
 	/* const */ char *src_ref;
 	char *dst_ref;
 	struct object_id *dst_oid;
-	int unique;
+	int num_matches;
 };
 
-#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0 }
 
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
@@ -23,9 +23,9 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		free(query.dst);
 		return 0;
 	}
+	cb->num_matches++;
 	if (cb->dst_ref) {
 		free(query.dst);
-		cb->unique = 0;
 		return 0;
 	}
 	cb->dst_ref = query.dst;
@@ -39,7 +39,7 @@ const char *unique_tracking_name(const char *name, struct object_id *oid)
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	free(cb_data.src_ref);
-	if (cb_data.unique)
+	if (cb_data.num_matches == 1)
 		return cb_data.dst_ref;
 	free(cb_data.dst_ref);
 	return NULL;
-- 
2.17.0.290.gded63e768a

