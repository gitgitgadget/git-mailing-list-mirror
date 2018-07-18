Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6441F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeGRQvq (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45336 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbeGRQvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:46 -0400
Received: by mail-lf0-f68.google.com with SMTP id j143-v6so1674155lfj.12
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMjr5IAr8F2z+VYG65tsvkOvXrRUIaCOzHLFDHfPbDQ=;
        b=Lq9XdGydMLDfLRDx1yABOLvVtYnB6HgCWpgGkp1GccohQ4+4Vu96jLzjK/TWafPUxE
         9CFJFK5RrEus/9L20lCF1+FSE9rFL+Vgo1ihra+muu89DKdacRlEQDBlCE8fk/UCApzV
         E2AGja5HelWNq7EL4WOwB8fxJzlSk8X8jWx7M8Lk4A/o3G9aaGAzdtGf/+jcDl+uYc/7
         /s6Ob2xhjteoAD3UepgSCnwUTYdY9HRP5UsGTGXKPFXyMcMrHt/Znoabbb+FPRIy9cRi
         QO10AMi+z2MPpg1F7rb6ttcmJmlLqv21/f8MAeY0Urhn4ZmboWeGQDOnFDq7LS4LYpNW
         90VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMjr5IAr8F2z+VYG65tsvkOvXrRUIaCOzHLFDHfPbDQ=;
        b=LgJInLfXpc2p7bRJ0PN6fj9MIopmB7vJ0ph/4ImLF6U24xRU2LlKHg1DLQc71w1+qq
         37v57aj/GKv/lxY0AJgLqld4Q2qG3JI+71r95U3t4Ri40cMTvaUTnViTPVB/75RIwK2x
         ODNH3F75J95ODE6InJyrn8DqytdKJBLvuT9anqbxLdkqe2FT6SSLouzAmWX9DjKc9tKo
         4qHs8/lM4B6G4Ofqr0yvFDTDoOwa0UdG5fjnKZj7NHMoQacHmCD0eJ/csbTTKd6uDG72
         Kk23ZV58nQwqfkZnpku+E/Dy/qI831V9ee1ph2bH7RH2Q+RI8QLB5i/8+vmBDIxLp60L
         JE9Q==
X-Gm-Message-State: AOUpUlGaEruyhTot+WMPBS0lPmizpu1txXY8mmGea05Ojnfctv/4zk+8
        mJpJ0b6VCvwtr+VWnJwYu96V9A==
X-Google-Smtp-Source: AAOMgpfmxv/3exX3r4z42uvatIiwTshTTvBLF1Zw5fed/akfJ5iyMnCSF9HkZFWDGLa06Uu+2qDM/g==
X-Received: by 2002:a19:6d0f:: with SMTP id i15-v6mr4581916lfc.95.1531930388052;
        Wed, 18 Jul 2018 09:13:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:13:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 19/23] replace-object.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:57 +0200
Message-Id: <20180718161101.19765-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 replace-object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 801b5c1678..ddc1546b8c 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -17,7 +17,7 @@ static int register_replace_ref(const char *refname,
 
 	if (get_oid_hex(hash, &repl_obj->original.oid)) {
 		free(repl_obj);
-		warning("bad replace ref name: %s", refname);
+		warning(_("bad replace ref name: %s"), refname);
 		return 0;
 	}
 
@@ -26,7 +26,7 @@ static int register_replace_ref(const char *refname,
 
 	/* Register new object */
 	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
-		die("duplicate replace ref: %s", refname);
+		die(_("duplicate replace ref: %s"), refname);
 
 	return 0;
 }
@@ -69,5 +69,5 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 			return cur;
 		cur = &repl_obj->replacement;
 	}
-	die("replace depth too high for object %s", oid_to_hex(oid));
+	die(_("replace depth too high for object %s"), oid_to_hex(oid));
 }
-- 
2.18.0.rc2.476.g39500d3211

