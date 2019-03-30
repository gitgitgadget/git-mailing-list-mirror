Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCC520248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfC3LUi (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:20:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40145 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbfC3LUg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so2255730pfc.7
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SILCV0xL0rMhdc8DRhCUAEY33mnaNDt1h5vVG3Tug14=;
        b=DkJfXCmr/l3kNoxg49DDk7ecSuxkuLv6L7/pb93er/j8FfcTjKLn8VNQcm/ZfyBI7S
         eICVQkHuifBT/MrAajloyyoS51mp04EblZWr8kT3udj5JIQN3LQ9L+Jd/QqsjK6aqOC8
         ISNTGymB3RXtdRNrg4py1H4TbKgE940IcPGJrQB8Y60zaLbElzJymL9wzSRXcMr/Q0YM
         7awM9SlsqmZ9JDvM5rwWuB0mwUPKaSPrpQzXO+P0HuQZZRi9N4X2feYdntwpRD0lVnR+
         25yURqau5q4hw4b1kKtuLhGpcH1IaIjbZmDVYyj71akR6LTejTifi1hOQSvatm89p8+6
         7xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SILCV0xL0rMhdc8DRhCUAEY33mnaNDt1h5vVG3Tug14=;
        b=mEfRgLtLWsOrtNn0tN7G4rW0dwH/oEUKaAVc8bLQR7K5SqwbcP4Qtxk9e0Vei5eV2l
         yfnXON2uklRu5zZgYGXs16gR65OOaFiyE0DEpdVv4BEXk3S2YGW2OhDMoesoZRWDGdat
         gDk2XDp6znYFdDXHtLDQHx4rhD2fZnY7kpTK8PVN/Othl442Axra0sVHF2vDaVl4mT4P
         C0nZxkQpZUIqJJ9Sx0w8TSRA92u3OpwffhTnAx5OZgC0fMszqUSzg/phGirLGjM2leSW
         gCIdxZdQ54rZUV8t0CurIT7tAF4puCBdExR4y4aEIgtG1lJxrK9QNieOASE/7PruE50X
         Wxow==
X-Gm-Message-State: APjAAAV/RruZUekL7WYe9LXAh7VRLvtGnSG0ytpEavcrI56KWkrP5f5I
        b9mcfVhKwd8W2rUIK0gX2ABHHLfx
X-Google-Smtp-Source: APXvYqyTL5HulneLSglWvaIlkvmdj0asUUTrd++mX4ZTBR3hwy2mevQvI4icSeiUS0rZ53oXvg2qqA==
X-Received: by 2002:a65:624a:: with SMTP id q10mr23701681pgv.435.1553944835754;
        Sat, 30 Mar 2019 04:20:35 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id p3sm10599804pfp.136.2019.03.30.04.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:20:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:20:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/31] refs.c: add refs_ref_exists()
Date:   Sat, 30 Mar 2019 18:18:58 +0700
Message-Id: <20190330111927.18645-3-pclouds@gmail.com>
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
 refs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 142888a40a..b869f32d8b 100644
--- a/refs.c
+++ b/refs.c
@@ -241,9 +241,14 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
+static int refs_ref_exists(struct ref_store *refs, const char *refname)
+{
+	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
+}
+
 int ref_exists(const char *refname)
 {
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL, NULL);
+	return refs_ref_exists(get_main_ref_store(the_repository), refname);
 }
 
 static int match_ref_pattern(const char *refname,
-- 
2.21.0.479.g47ac719cd3

