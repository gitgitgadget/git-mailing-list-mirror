Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B15820248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfC3LVX (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42783 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfC3LVW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so2421236pgh.9
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Sww8ndWyCxak9+iI+JOYHneVIA0yT5/XJ9VtPjuYpA=;
        b=be4uwt3HWsIAfqR924n/Axp+ddP/OaAac9/s1xcAiOlawhazJ300NUXhYFlGG+6Fh2
         xRMxMIP7p9Rb7VCBqSsoZeZarPF63WUad4bfR1rNQ3xVHymHw04bOIaRos/8YyG68Q0k
         MzIfqiqMqmQUQ4a9g2jIrd+WPkkTXXuM7dBzh9/JUrNjxr9jTeoq1GHOxq1t2Yl330VY
         LcqsDKOEhFUp3MFZeaj639k9EYarlZSYR2PyxmwHJpv1hfvmvLCMUWY/piKrcCsArZpI
         pvvNsgWdD0tu2s7C0BV4WiebUb9zgMzekIccIg29gPIWlmrZ0CdODQudTJ/EcVswTUcV
         n4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Sww8ndWyCxak9+iI+JOYHneVIA0yT5/XJ9VtPjuYpA=;
        b=KHiOGwsJ6vO07OB0iXC68ncP0pJD6OpU0/fMgV5PZahvkMugFldFrYsRNRMsOGYSAw
         AFfOZ16sLzx1aSCd7jvO6COFyEP1AK1bWduIdAA9wyFTt2Y0L5fyw++PqYL+Zs/ukaiq
         en4Mk76/jB7sF9H7dPsVSJ7vNgLZjj5VOyt+v38yIEQ9kSGMaPHmbGneVJdO6dwKJuEQ
         yyse5xS5Wghns6VR1pq08iFfF2nvRBAb822bMV3colqc64gDbCEj75a+k95/k4iXiCf/
         51sLo5MYJyMUkk7xumGWh0HPAjT69LK651QyLfMlhZP9sP90d4gKO1Ti2qiBzUFJKOgE
         nmzw==
X-Gm-Message-State: APjAAAUTIljtBoUZPadQObGgSkEq+SbsZIZRHVOpptG6hTIZ3+/MWoTJ
        EjSu3rwZBDPXTl93Jc/Nn/VUJk8X
X-Google-Smtp-Source: APXvYqy0fj9smEkry1DJrQakEN/Acckzo7ZAZPtG/x6wgRZKuKd1sPlDjmFNq7z5+ANA5kB7puhnSg==
X-Received: by 2002:a65:410a:: with SMTP id w10mr50377298pgp.206.1553944882192;
        Sat, 30 Mar 2019 04:21:22 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id c18sm16771772pfc.0.2019.03.30.04.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/31] sha1-name.c: remove the_repo from find_abbrev_len_packed()
Date:   Sat, 30 Mar 2019 18:19:07 +0700
Message-Id: <20190330111927.18645-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 7558ce51a3..b9381aaba6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -514,6 +514,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
+	struct repository *repo;
 	const struct object_id *oid;
 };
 
@@ -619,9 +620,9 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(the_repository); m; m = m->next)
+	for (m = get_multi_pack_index(mad->repo); m; m = m->next)
 		find_abbrev_len_for_midx(m, mad);
-	for (p = get_packed_git(the_repository); p; p = p->next)
+	for (p = get_packed_git(mad->repo); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
@@ -658,6 +659,7 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	if (len == hexsz || !len)
 		return hexsz;
 
+	mad.repo = the_repository;
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
-- 
2.21.0.479.g47ac719cd3

