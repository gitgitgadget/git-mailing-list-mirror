Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378901F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933814AbeFFRDZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:25 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43523 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933773AbeFFRDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:20 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so10213601lfn.10
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pnX6zPOAbFNGxlfpam3gj/3o6OBjhwOVaoenhEhIyA=;
        b=s3E7p1XqwweSpz/zgXtp0jprN47uNpj6IHzoF5d+sP8bU9OXk/PexY1T0ICX1ExPO9
         HmdpKd3PF8szzZsc2rsHxApppGaKtwYLht7Bc6CHZjg6OVXPOm7L5vjTNDB1E0hd3OuM
         YknfFyCGMc0F7D7YZx0ssajA+f/cdOTRHUkIOOqYmvaum/Bw5xA0Eqg/ft54OYM0w2iP
         UtuLzDLp00PNsGTOYgbqF6JyJRsNR+JKTDYTbYVL2y3x+T/KJvNiJFWLCTa8SOpQlyV/
         i2IONNS6AHXOn0IalqHi3aZX8nlynbRdjweIOGG8AhKI8NbCT0uXparBQgcqLBw+EUyA
         eEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pnX6zPOAbFNGxlfpam3gj/3o6OBjhwOVaoenhEhIyA=;
        b=kEb6wEvhsghoi3D0toHbwf5/LM2k+JrIL4lbm8LQoxMPIsdV5CuRLMIOfaOyWjuaRr
         f1XsVfxhshByoiYHreeyHVf4lPE9WM7D8Ty8BaCCIU3ZYt8yFd1aQfJeOHKNdKg55fEi
         aiJh46qMlpKdtlceCgWSnNaYzqbuUl2+qW2jpyMybtZP+ShCfseUTfF7ILtIu3aqbkQ7
         BNX+GWzh15nmhIB8FzjkW4oycpXMGYXeE03Yb81w3ShKTIGt5DA2xoBcAlBgSJJ/fraa
         gZn/Vg42Xz6XL8HlhB5ZA1pyfxs0NAZk/Ky+A2xKv6zkH+AOa0zennP2kNhDldi8k6Ax
         fkLQ==
X-Gm-Message-State: APt69E16g5jWdoEBUAnpldYDum+eSG1MZjvJeGnYaM7isWVNpNSiDowj
        IU8Na6u82C1Fwz+03MILSrM=
X-Google-Smtp-Source: ADUXVKI5M7/+Y/JE3d+gCjZCz2VyAJMG3iu+sg/GhuF/Y9A/C8nn7dX++WLmK6UZRUV+umm5S6qD2w==
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr2518223lfc.55.1528304599344;
        Wed, 06 Jun 2018 10:03:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 23/23] cache.h: make the_index part of "compatibility macros"
Date:   Wed,  6 Jun 2018 19:02:43 +0200
Message-Id: <20180606170243.4169-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the_index is not actually a macro, its use throughout the code
base is dangerous because developers sometimes may not see that some
function is using the_index (instead of some other index that the devs
are interested in).

By keeping the_index part of this NO_ macro, we try to reduce its use
more and more until it's completely gone.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 64abd3e55c..eb8c79b8a1 100644
--- a/cache.h
+++ b/cache.h
@@ -330,8 +330,6 @@ struct index_state {
 	struct ewah_bitmap *fsmonitor_dirty;
 };
 
-extern struct index_state the_index;
-
 /* Name hashing */
 extern int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
 extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
@@ -340,6 +338,8 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
+extern struct index_state the_index;
+
 #define active_cache (the_index.cache)
 #define active_nr (the_index.cache_nr)
 #define active_alloc (the_index.cache_alloc)
-- 
2.18.0.rc0.333.g22e6ee6cdf

