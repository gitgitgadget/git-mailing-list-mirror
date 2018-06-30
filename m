Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2321F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934818AbeF3JU7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:20:59 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:42943 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754852AbeF3JUp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:45 -0400
Received: by mail-lf0-f54.google.com with SMTP id u202-v6so8474172lff.9
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2O6/xYl8p86pY+IWmfWRGkoudOJd0N8a1VvXw+LWz80=;
        b=u0AzDcV5QH6ujEIKtcijLB6UYXCEIGBU26957u7iR2YO/DN64yLvFyVdt4zVF+Xfu6
         G0mfYM7yVKIZDGCvypV+6vcAtU+Xb7vh8hMQKfsPAvu5RalKlESfs6zuLOeg/TWXSMXw
         zucEEtOQ65Nhdm7k5MGAmRhzwdDymx9P7WxFjKvEqrYTA2J/q0NTNl1Jnpfv94gj849Z
         /D7bL/xZWDjgSKKKqki+5zbL1dBRXW5HxlJnIQRNm1fqd1FrAWzAl6VWDHSfPAgdW3QH
         Fv2WHzQ+jNm3nNyHp6xs4wYsr2rD+nDUZLI/J8hN2B63ohPTlmsBbvPiJlXwBp62ZZkw
         juCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2O6/xYl8p86pY+IWmfWRGkoudOJd0N8a1VvXw+LWz80=;
        b=eYteybH40FgROd/o504aDrZt2qQrdPv/eTLPVcRMhZ8Nt8nkAA+mKMP+pUmcO8EYhi
         efpE55Z/B9nwLU3yBPgD7pARCziuoRiXdIAhBDrYKyBLfEagEtN8CgMX8JuWP4/MqqrU
         ell6dVdXY5y9I57hkAfT7Ui0EnAeOl8uaaE0LiCPQaWksOVAP7XQcxxq3tBqgD6yKuGS
         HTYCOD7DS5ggg5bf1YdLQBPQ0qWWsAxSQCh1sC8StWastgaQEY9AaHys60qv0tHWg1z4
         ruIDEJjdh1366s3/NU290OT+jKqiQgxycpfpdgCPztXKexBm+CE3osdv9vfInycrVOY7
         fvWw==
X-Gm-Message-State: APt69E0R0BJV1jZZhZWEYZEIj91acyelDDP/aTOliPF3anyPVCx9yXuO
        kHRORhYXuklnPJjKuUVTTdgxjQ==
X-Google-Smtp-Source: AAOMgpeLt8KKRGCRnxUCqX9f4J6J2luUIu2WbWL7ggD6eYhKLCc6Yq+HMm+DiSLUSo99OYTh3HqcZA==
X-Received: by 2002:a19:d245:: with SMTP id j66-v6mr12387546lfg.139.1530350443459;
        Sat, 30 Jun 2018 02:20:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/12] cache-tree.h: drop extern from function declaration
Date:   Sat, 30 Jun 2018 11:20:23 +0200
Message-Id: <20180630092031.29910-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
References: <20180630092031.29910-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.h b/cache-tree.h
index cfd5328cc9..9799e894f7 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -51,6 +51,6 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 int write_cache_as_tree(struct object_id *oid, int flags, const char *prefix);
 void prime_cache_tree(struct index_state *, struct tree *);
 
-extern int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
+int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
 
 #endif
-- 
2.18.0.rc2.476.g39500d3211

