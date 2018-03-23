Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E79F31FAE4
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeCWRW1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:27 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40950 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeCWRWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:16 -0400
Received: by mail-lf0-f65.google.com with SMTP id e5-v6so19405240lfb.7
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P4pLFHT07AEdQQ5Ct8J1R8EfF9/lYncgNxLcRBR7prY=;
        b=LCwSuiXsY6I9foHTrN1l7rgKVVqNeY/qEe3oNCzkPoyR5j4wT57oQdZrqNrOEh8pwA
         WrqnadIKlQQXKt1RGvl23R6wTdTectm99yoS7E4AHZQQXB9/7OBgH93Cmh7d4DelJGYx
         uVcUB7jYQ7cAYWF5GKe2IGjddqrhF6OdPOmP9OR6Z8xP9n1U9olqxK2JVXa0dK2ccf2T
         muSAI7Bi8qryitXRLT5Q0PDfvgQ1aU2i2uO4BXRs8QC1OruFfCqqoOi7u0+qCvXe+4O4
         y9VftC4Yuv/fYv8/FAdVoP37QuD2oQbp55KTlOfGZFSawSe+VMBfP8xmJlMgyZ7uzQJG
         zKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P4pLFHT07AEdQQ5Ct8J1R8EfF9/lYncgNxLcRBR7prY=;
        b=oti5OksSoiJ3ijq6IpLYLOCrmJGqJoMx0SfPCA23xWV6wyIs7gLH5wlN4AVKtY23np
         +bKlLVhj8pzrLYFWeOAvwSJ+kz5w8FcBdA0RlWBWavTO9ZRSBjtLyCKPG4ZL380WDkrB
         AsR87DMwTEqdd/BPvIn2xKmT+5J4BKf/5PGteh5zCbGwIjb6iAkmcV5YDttOVN2Pb/kh
         CyhlVpEL14HQiRW57x+dkfnkXqjsm6HrKb4aZ0w35Hz34apUcqFFSDbJS1oENY+Tf+qR
         iuEIgOcmIGvh5xI/zxaVih0VW1SMeyZXdRGLAGASwsvtJ3s5+H0MCOsqFP1uscc1KNkF
         6Z6g==
X-Gm-Message-State: AElRT7H4fAwBeNreXLUmLsoyW+9LVvWVtBtmcO4Gww1ZfZNxMBlMph5F
        IYjDi4Ck+fD+CB3Z4RI8xSQ=
X-Google-Smtp-Source: AG47ELs3/BBY5ijzWyCah7FfiiC5UsXrXXgNY9G5AdIyKaTt7RceP78gcY6cxxoOfVaKVxJ8lgxsRg==
X-Received: by 2002:a19:1449:: with SMTP id k70-v6mr21386478lfi.23.1521825735288;
        Fri, 23 Mar 2018 10:22:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 26/27] sha1_file: allow map_sha1_file to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:21:20 +0100
Message-Id: <20180323172121.17725-27-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index d9cc875153..fef33f345f 100644
--- a/object-store.h
+++ b/object-store.h
@@ -127,7 +127,6 @@ void raw_object_store_clear(struct raw_object_store *o);
  */
 void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
-#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 1d5d23dfe2..9addad6887 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -957,9 +957,10 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	return map;
 }
 
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(struct repository *r,
+		    const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(the_repository, NULL, sha1, size);
+	return map_sha1_file_1(r, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
-- 
2.17.0.rc0.348.gd5a49e0b6f

