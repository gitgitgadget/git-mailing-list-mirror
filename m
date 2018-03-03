Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B921F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeCCLj1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:27 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43490 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeCCLj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:26 -0500
Received: by mail-pl0-f65.google.com with SMTP id f23-v6so7189286plr.10
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9J6/OfnHaxG0p+bqA2+tw75OTnhN+fYWXsciOKs5IU=;
        b=AqurirJZcc5JMaMTcamqYXMoDcRnsVdDYtxLoKKy9P/7vQTESynMfuAzlgBxaimULF
         4XqbCExsYqYWsNSo8B5gMBMMliEub7Z1ca+1DsBJk1Uwk0ReF3+pNmJs0rXjRMDrWNa6
         TV+HPRFeAqGbjpFgRz/Ux2/fnQnLDE3fR8MSbQHzNIB3BI3U7DVIP0cfWsBUGlWWL/wI
         IXneB77owab1Vk0aC9PqfQveYnREnUXirCPKrRqqXSlcaafumb1VbtbQNHNie9bX3Vqb
         OFFOsHlMuY8UVusIqOwsx6HDKetMpyHbBOuMdHlz6UbkVfU0FGDkGJqfpujPNQkrF2Is
         Xj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9J6/OfnHaxG0p+bqA2+tw75OTnhN+fYWXsciOKs5IU=;
        b=GuWccg9zOlVoQm2aGwwXRKuqMEHL11M6RyPkEW4AWMzY39n3qhPE0uTp4229l19n5N
         NPCPUb4K8QeMYNPwlf3cQ14o76i06iKsaq9JTD4dsfO1BoMvPjvze8zo5TJWu0BIk7Ms
         Ve2uTL5q9/Iz3Xsic1VqiCGV+DMnsaMTAGPhnuX5G4/FKm1kDjnKp76asmlERshJooQv
         DAnciTRjBRhxusC+8jfFOtSEkS3uqht1hUvzZ9cJxoywbNO2qGdJz6apmAlmhNeko7eU
         P9GNLlcfhXZAjHsp3Ve6tdlcPh8WVXyVnjS7sKLO1NkWYhFuvW1u9vNTqTJXNCen+Ak0
         Gj0A==
X-Gm-Message-State: APf1xPBtEptPpJq1ygxHufI5JNaHOGh1i9kTT1ujWw/YYh4qE984JCoY
        9jDhbCLlR3U79vxHcMbQGoUEew==
X-Google-Smtp-Source: AG47ELt1ATWK85HV2mGSehRAXtiqSJQ3OyPSkabM7ORsTEi+gu4sObICvAN110xb/hvvfcy7W84R0w==
X-Received: by 2002:a17:902:2f81:: with SMTP id t1-v6mr8041873plb.290.1520077165819;
        Sat, 03 Mar 2018 03:39:25 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 184sm16339674pfg.125.2018.03.03.03.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 32/44] sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:25 +0700
Message-Id: <20180303113637.26518-33-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c5a8b00aed..7066d4c9ce 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1149,10 +1149,9 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
-static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
-						 struct object_info *oi,
-						 int flags)
+static int sha1_loose_object_info(struct repository *r,
+				  const unsigned char *sha1,
+				  struct object_info *oi, int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1176,14 +1175,14 @@ static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
+		if (stat_sha1_file(r, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
 
-	map = map_sha1_file(the_repository, sha1, &mapsize);
+	map = map_sha1_file(r, sha1, &mapsize);
 	if (!map)
 		return -1;
 
-- 
2.16.1.435.g8f24da2e1a

