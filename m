Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948CE20966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdCZCp1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:45:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33301 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdCZCp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:45:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id p189so4078206pfp.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ddc/FxDebFpZDqHbJkNdd5AXFO1oR+kLhJGUYVqZ0M=;
        b=UBZ/2FGuTlpVGWacuGQlOrTzMdh5dugPz/xWVPPslh0Jc9OHpJa9weii7z6ZZ2+XLq
         hGdvjAotpwrchd9r8AS3Sk7JiepJNfvL9vz3GcZV9QMl7BDpgImjLMHqRRmCmyFUGtJR
         DBXnYNVC4fgW+uR+3Gl8Zr0kgye18YJ0i6nwiwvWJLto2dQfuBsDjUHXPtG0hSzlKtwD
         kVxGRbKCLYBJ5cV8BYoXuEO/065z7LduVYTMrSfjZs7yMdMmo070aeyhYRBiDH+lYZrN
         jBCPQXVEUzrDLrzM8kJn9V1hCk104gGJ/8zKc4Q3194+ZcBbJ8fgRhX9NeF6anMBuXf6
         m3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ddc/FxDebFpZDqHbJkNdd5AXFO1oR+kLhJGUYVqZ0M=;
        b=D/8HTOz6gDsnsNDmAL7LeE1DGcmHGHM2j/cf5vc0aLYFb2oaxP4wQWku/Mhanxj8gf
         GtaNjtLlgKirQYqh3eSqiO4YUneNppufH/LSdJtKuBjf7SyAWe5rlqG4wc43Eh3KEZhv
         dfiLwe1T7EhhyVlVtHBiF5diZF7K18Obo0IkYPWmQ6wUgoyUtmUSpch+ets+Xl0oUwah
         Ts31d3SAagFks6L5n7Lmuqybyr0ua+zqs0xi+9Aa+DOI1I/OQVg5Ek8OjUPG6rBe6Sls
         3J8w07vSRss2bqvPZ39ozMapGLq3fy7kygEnhlSloiyRYnMSWqSlfSK/uLFyctAFpY9o
         tCsQ==
X-Gm-Message-State: AFeK/H0XCuIgzrmGkY1wknsxVaxtAtlpDlXzL9ofDzGAjhgxNCINo6bsy/oeXePV65rmiw==
X-Received: by 10.98.48.196 with SMTP id w187mr18055289pfw.179.1490496324928;
        Sat, 25 Mar 2017 19:45:24 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id n24sm12000106pgc.43.2017.03.25.19.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:45:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:45:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 24/28] refs: delete pack_refs() in favor of refs_pack_refs()
Date:   Sun, 26 Mar 2017 09:42:37 +0700
Message-Id: <20170326024241.31984-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only has one caller, not worth keeping just for convenience.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-refs.c | 2 +-
 refs.c              | 5 -----
 refs.h              | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 39f9a55d16..b106a392a4 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -17,5 +17,5 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	};
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	return pack_refs(flags);
+	return refs_pack_refs(get_main_ref_store(), flags);
 }
diff --git a/refs.c b/refs.c
index 50ea24bd75..ec1f563824 100644
--- a/refs.c
+++ b/refs.c
@@ -1602,11 +1602,6 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags)
 	return refs->be->pack_refs(refs, flags);
 }
 
-int pack_refs(unsigned int flags)
-{
-	return refs_pack_refs(get_main_ref_store(), flags);
-}
-
 int refs_peel_ref(struct ref_store *refs, const char *refname,
 		  unsigned char *sha1)
 {
diff --git a/refs.h b/refs.h
index 37f4aa8bd5..1a07f9d86f 100644
--- a/refs.h
+++ b/refs.h
@@ -297,7 +297,6 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
  * flags: Combination of the above PACK_REFS_* flags.
  */
 int refs_pack_refs(struct ref_store *refs, unsigned int flags);
-int pack_refs(unsigned int flags);
 
 /*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
-- 
2.11.0.157.gd943d85

