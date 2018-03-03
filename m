Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10081F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932125AbeCCLip (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:45 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34045 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLip (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:45 -0500
Received: by mail-pl0-f67.google.com with SMTP id u13-v6so7193287plq.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GJOz3762mlrjkV3iL4OA1zeZ+WOWaLGdW8j4qv+x0U=;
        b=ohL1CQwfzlKToLyuL8okX28jFFBE03ecw8ta9TlsP5KiTolG1k2G4sPOp+6dzNV/hn
         k9DwUwC0ssKkoEqMAlqDwqhRj9AnNMKh1fO4ORDfFsqdpM59OVG6Dp4cF0rvjnd2fSS/
         MhIdEhr2oAdzbFNh8BAj1pVAgw2GmvzhDiRAVqipfCR+uDww8C+arQRa+NxMX23Cp8pu
         aevm8ncum3WM75dyM2L9BOTEWa3dbmKZlfbZonk9rlemJqPDhbp1HfwgjoF5J1is2NNz
         4tScFGsjLDvJdeWgVNChTTTuiHUwZMLF7uSv3hl74VxmAPIe5y/SCD891Ol8Vk/Gixrd
         Ck3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GJOz3762mlrjkV3iL4OA1zeZ+WOWaLGdW8j4qv+x0U=;
        b=PUpb6KQRxvp6BzcYQ32IEZX6+o9KLALYFAmia4mnxgPEJ3so+VnDXLrOBlrrgq8lCY
         OOqj4rMQD5ZeFZroFCkqGWoerhXI7g2lULulNygvWqX+58sMKxXn9FQU5Os5hp2i717J
         6voWbZU57Sd6rd5fdOnY+Ilc+xQ7+acRunuydmkDw2JZLCg7azTLWNWn+aNCtW46lwkn
         UssBwTu4rHA3P7+y/QrvOGUpX/WtYEDsda8Opr2oWEPCdNSCT06KoF7H7wFPXiH5Gajd
         6s6BRURwOMImseYq8jN+AdNq3Ypg6e+8yer5U0JR+pLGJQENe/77i+FT3mmsSLKy7x+s
         RTFw==
X-Gm-Message-State: APf1xPAnYWCucowbx8Ql2tQ19spmy9UVzCHNt6omZ/3119Mb3a+C1oH1
        tQBdMXgPSyILzbfuMq3wKrNiZg==
X-Google-Smtp-Source: AG47ELvV1OWXmUszFYs50c695xydDWBSGn/+MzviclF8E269bWImEWDvvkNmZzLdJQdDqA9XctipFQ==
X-Received: by 2002:a17:902:7009:: with SMTP id y9-v6mr7911482plk.395.1520077124424;
        Sat, 03 Mar 2018 03:38:44 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id i2sm14176187pgp.88.2018.03.03.03.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 24/44] sha1_file: add repository argument to map_sha1_file_1
Date:   Sat,  3 Mar 2018 18:36:17 +0700
Message-Id: <20180303113637.26518-25-pclouds@gmail.com>
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

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the map_sha1_file_1 caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1_file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d4298805e3..78d5ffe876 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -931,9 +931,10 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-static void *map_sha1_file_1(const char *path,
-			     const unsigned char *sha1,
-			     unsigned long *size)
+#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
+static void *map_sha1_file_1_the_repository(const char *path,
+					    const unsigned char *sha1,
+					    unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -962,7 +963,7 @@ static void *map_sha1_file_1(const char *path,
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(NULL, sha1, size);
+	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -2192,7 +2193,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(path, NULL, &mapsize);
+	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno("unable to mmap %s", path);
 		goto out;
-- 
2.16.1.435.g8f24da2e1a

