Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593501F454
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeJ0PuQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33079 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeJ0PuP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so3185259ljz.0
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAfV2Nz5oHseiWQnq7IrtXDy2ffEDSwSfXwchHyglKQ=;
        b=bQNW+lBMjWP/Kc4xeLCCn+aFRnLXiCOs0UTAx5iZVzhrXfduFnN+zdfIVi0W44qJYD
         PBjydnyPB/VFfC3vmwGfTI0LJ/KN5ilVZCsONfx03vuQKQ06UGBdcOF/eIBZhscvI+sY
         TOz+PtCcD8x4BPKY9vtKdCnJ8IVXfKwxrLiaEZtWNUvmcnuAs5/fsYfW/jB6mF2wcZjz
         W477N8AUG1EV/O70T09ADZTsFo3M544KtLnLGH1A73xzJ3viOmZWrYJ4v5mFKulZGGbZ
         oqyUWUSXWTH1SDDCy66L8yDQRLE1dJagpgmz/Apmb0rfbfYITgvfdYobkIkdde/PjZak
         7ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAfV2Nz5oHseiWQnq7IrtXDy2ffEDSwSfXwchHyglKQ=;
        b=kRYbl9cfAzedC7p4K5QlvRJSOe7lhomg/N4rX08CFvWG3H3Ra0kxmzgt68TkoodA1E
         b1AGBclNVt6kcaXIAqNgQ4UMI8paeAjBLlLsV2ILuQPSACd1K+2DIhaV6vnKA0tEwCCW
         yeUiNKlm7ykyQCjCHofIynLvse8c0lc0syNAe0ol1BVHCidp0058NAQ2BDpDGx3X/3Xa
         lB/7oELww37P5v6wVHo2LDfnQ+C+0fE6s4mpklwLUl8qbWww6MHw6TNCsEJZCNHNV04O
         8KLLDgpvvpThpOYYsai5vHNQIltCEeHCutSS5hT3U1fDF9mt7VWB6h0T75QmisxgMesF
         Bidw==
X-Gm-Message-State: AGRZ1gLGuhyU2NOLBbRTuZXYXsCWdyN5EfmgoI3/phIDCL/JjbizA8gH
        KuyheHt3z2UsUi1EtiJtx/b2CMMj
X-Google-Smtp-Source: AJdET5ecLC+5Q7AVdNeb9N90hRs0SKwTwsncpnGOXir6zUp58PWA2bRU1nqSuG7c5juWNZ2/959fvQ==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr4209435ljf.96.1540624214181;
        Sat, 27 Oct 2018 00:10:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/10] attr.c: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 09:09:57 +0200
Message-Id: <20181027071003.1347-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027071003.1347-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 attr.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/attr.c b/attr.c
index 60d284796d..eaece6658d 100644
--- a/attr.c
+++ b/attr.c
@@ -41,23 +41,17 @@ const char *git_attr_name(const struct git_attr *attr)
 
 struct attr_hashmap {
 	struct hashmap map;
-#ifndef NO_PTHREADS
 	pthread_mutex_t mutex;
-#endif
 };
 
 static inline void hashmap_lock(struct attr_hashmap *map)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_lock(&map->mutex);
-#endif
 }
 
 static inline void hashmap_unlock(struct attr_hashmap *map)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_unlock(&map->mutex);
-#endif
 }
 
 /*
@@ -498,23 +492,17 @@ static struct check_vector {
 	size_t nr;
 	size_t alloc;
 	struct attr_check **checks;
-#ifndef NO_PTHREADS
 	pthread_mutex_t mutex;
-#endif
 } check_vector;
 
 static inline void vector_lock(void)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_lock(&check_vector.mutex);
-#endif
 }
 
 static inline void vector_unlock(void)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_unlock(&check_vector.mutex);
-#endif
 }
 
 static void check_vector_add(struct attr_check *c)
@@ -1181,8 +1169,6 @@ void git_all_attrs(const struct index_state *istate,
 
 void attr_start(void)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
 	pthread_mutex_init(&check_vector.mutex, NULL);
-#endif
 }
-- 
2.19.1.647.g708186aaf9

