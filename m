Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4285C1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCCLjR (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:17 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38927 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeCCLjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:16 -0500
Received: by mail-pf0-f194.google.com with SMTP id u5so5140332pfh.6
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CM216z3s5XulrDcvivXupKS+MlmtVX7v8QG+XrNVzpQ=;
        b=InbZQYuGA1mjwefRu26ec6WCNQ0EoSvCTnUxvFXWz3dgaQldw4G0chE46qQH6bsvrN
         GdwG0ozraaVVX789DHYSQ4SkOUID5Lf15h8Hi/hGo5G/s/RZXkUqPJ4bLXLP/uvPT6u4
         mHjGsRhE1980oxSxh/nbDde91ZXEfbdVF3YiknFZJpERNaKP2yYKcJptjiM6xtBpYqFv
         8jegFUunT+DteyIpbrxBRJQ9ZWZ3Qgr+y/OmSeMK9bvdLFg6/d+y3/kANo4sQxFw6tRX
         ic8HBrtmvayVv2h6H4cAK9ictrmb8SgfmTImAtZxqkOLm0F+pQHKyA9yBqMrtHFhMsZy
         +lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CM216z3s5XulrDcvivXupKS+MlmtVX7v8QG+XrNVzpQ=;
        b=F6M0pkqYuJQcYM/taAKJWvAVlozLSZynJ2UBqxioHgrL/2xptYHmdJ9PO3ewqw1arl
         8J3ym/Kz71pvu/ZcAtTN5AVciSJJc+O+oXEoLbacd6F8faTQwi/0MQQq2qSwD7f5TOyK
         YgvSksJv2nH5XXfHLk2WhaVNK8ngmfoe+YXfQLVK9FbKoAferQHjhNrMP4jyHjF2KTwX
         t/yUFbRzIenjZfiHLGnAq7c9KxK0J33H6AQeWBYndCSNHAe/+bCuS7UUKNFFeBSx3M+7
         jspPQvzDa637WkERFHiBHvxp3eDtn0o00RsIxXWQTKqvd0mHo5RKWAMzMj/0JjVt0hQx
         jvlA==
X-Gm-Message-State: AElRT7HDk5hSJW7aJqZOtiUK1YvI/CkAb7x3X6D1obmk1JmUqzSn4Q+i
        zfQVZ85CZx/sR7PKbd3/GkXP0w==
X-Google-Smtp-Source: AG47ELtgcua/j3jjicOAFSFoaEjqS4XaoApOtx/WFuAj8/DBbMYCucbATU5ktzVjyA5NCqrHkiivXg==
X-Received: by 10.98.165.4 with SMTP id v4mr3723767pfm.51.1520077155867;
        Sat, 03 Mar 2018 03:39:15 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id x9sm13480675pgc.81.2018.03.03.03.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 30/44] sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:23 +0700
Message-Id: <20180303113637.26518-31-pclouds@gmail.com>
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
 sha1_file.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b3f7656c35..d4678f8162 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -929,10 +929,8 @@ static int open_sha1_file(struct repository *r,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
-static void *map_sha1_file_1_the_repository(const char *path,
-					    const unsigned char *sha1,
-					    unsigned long *size)
+static void *map_sha1_file_1(struct repository *r, const char *path,
+			     const unsigned char *sha1, unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -940,7 +938,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(the_repository, sha1, &path);
+		fd = open_sha1_file(r, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.16.1.435.g8f24da2e1a

